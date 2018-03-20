Received: from eggs.gnu.org ([2001:4830:134:3::10]:32907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyLdp-0007do-KM
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyLdl-0002wo-LK
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:05:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49632 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eyLdl-0002wB-H2
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:05:41 -0400
Date: Tue, 20 Mar 2018 20:05:40 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180320200257-mutt-send-email-mst@kernel.org>
References: <1521568357-114127-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521568357-114127-1-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/2] linux-headers: unistd.h fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

Cc MIPS maintainers.
Can we drop the MIPS blacklist for kvm?
Could you guys pls check?

On Tue, Mar 20, 2018 at 07:52:51PM +0200, Michael S. Tsirkin wrote:
> It turns out that we have unistd.h for some architectures but not
> others.  We are thus unable to use e.g. usefaultfd on these systems.
> 
> Fix up update-linux-headers.sh to make sure we
> get it for all architectures which have linux-headers/
> (unfortunately this still does not mean "all linux systems").
> 
> Tested on x86 only.
> 
> Pls consider merging this through the migration tree.
> 
> Michael S. Tsirkin (2):
>   update-linux-headers.sh: add unistd.h
>   linux-headers: add asm-generic/unistd.h
> 
>  linux-headers/asm-arm/bitsperlong.h     |   1 +
>  linux-headers/asm-arm64/bitsperlong.h   |  24 +
>  linux-headers/asm-generic/bitsperlong.h |  16 +
>  linux-headers/asm-generic/unistd.h      | 944 ++++++++++++++++++++++++++++++++
>  linux-headers/asm-mips/bitsperlong.h    |   9 +
>  linux-headers/asm-mips/unistd.h         |  44 +-
>  linux-headers/asm-powerpc/bitsperlong.h |  13 +
>  linux-headers/asm-s390/bitsperlong.h    |  14 +
>  linux-headers/asm-x86/bitsperlong.h     |  14 +
>  scripts/update-linux-headers.sh         |  20 +-
>  10 files changed, 1086 insertions(+), 13 deletions(-)
>  create mode 100644 linux-headers/asm-arm/bitsperlong.h
>  create mode 100644 linux-headers/asm-arm64/bitsperlong.h
>  create mode 100644 linux-headers/asm-generic/bitsperlong.h
>  create mode 100644 linux-headers/asm-generic/unistd.h
>  create mode 100644 linux-headers/asm-mips/bitsperlong.h
>  create mode 100644 linux-headers/asm-powerpc/bitsperlong.h
>  create mode 100644 linux-headers/asm-s390/bitsperlong.h
>  create mode 100644 linux-headers/asm-x86/bitsperlong.h
> 
> -- 
> MST
> 
