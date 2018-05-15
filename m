Received: from eggs.gnu.org ([2001:4830:134:3::10]:45189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fIZ9W-0002ad-13
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fIZ9Q-0005sJ-0w
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:34:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42284 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fIZ9P-0005rJ-RX
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:33:55 -0400
Date: Tue, 15 May 2018 15:33:54 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180515061211-mutt-send-email-mst@kernel.org>
References: <1523991487-241006-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523991487-241006-1-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] move kvm_para.h to standard-headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Wanpeng Li <kernellwp@gmail.com>, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Tue, Apr 17, 2018 at 09:58:16PM +0300, Michael S. Tsirkin wrote:
> kvm_para.h is normally an interface for guest.  It's natural to need the
> header in host to emulate that in qemu.
> 
> ATM it does not actually work on non-kvm systems, which allowed us to
> get by sticking it in linux-headers and only pulling it in on Linux, but
> that turns out to be more pain than it's worth.
> 
> The result seems to be that we are forced to duplicate
> more and more code from there when we are in portable code.
> Not nice.
> 
> Let's just pull it into standard-headers instead, and use
> on all platforms unconditionally.
> 
> It turns out we only need the x86 version, so that is
> and extra a plus - drop the rest.

Ping kvm maintainers - any comments?
Should I merge this one?

> Michael S. Tsirkin (4):
>   update-linux-headers.sh: drop kvm_para.h hacks
>   include/standard-headers: add asm-x86/kvm_para.h
>   x86/cpu: use standard-headers/asm-x86.kvm_para.h
>   linux-headers: drop kvm_para.h
> 
>  .../standard-headers}/asm-x86/kvm_para.h           | 49 ++++++-----
>  include/sysemu/kvm.h                               |  1 -
>  linux-headers/asm-arm/kvm_para.h                   |  2 -
>  linux-headers/asm-arm64/kvm_para.h                 |  1 -
>  linux-headers/asm-generic/kvm_para.h               |  4 -
>  linux-headers/asm-mips/kvm_para.h                  |  5 --
>  linux-headers/asm-powerpc/epapr_hcalls.h           | 99 ----------------------
>  linux-headers/asm-powerpc/kvm_para.h               | 98 ---------------------
>  linux-headers/asm-s390/kvm_para.h                  |  8 --
>  linux-headers/linux/kvm_para.h                     | 35 --------
>  target/i386/cpu.h                                  |  2 -
>  target/i386/kvm_i386.h                             |  6 --
>  hw/i386/kvm/clock.c                                |  2 +-
>  target/i386/cpu.c                                  |  4 +-
>  target/i386/kvm.c                                  |  4 +-
>  scripts/update-linux-headers.sh                    | 16 ++--
>  16 files changed, 35 insertions(+), 301 deletions(-)
>  rename {linux-headers => include/standard-headers}/asm-x86/kvm_para.h (80%)
>  delete mode 100644 linux-headers/asm-arm/kvm_para.h
>  delete mode 100644 linux-headers/asm-arm64/kvm_para.h
>  delete mode 100644 linux-headers/asm-generic/kvm_para.h
>  delete mode 100644 linux-headers/asm-mips/kvm_para.h
>  delete mode 100644 linux-headers/asm-powerpc/epapr_hcalls.h
>  delete mode 100644 linux-headers/asm-powerpc/kvm_para.h
>  delete mode 100644 linux-headers/asm-s390/kvm_para.h
>  delete mode 100644 linux-headers/linux/kvm_para.h
> 
> -- 
> MST
> 
