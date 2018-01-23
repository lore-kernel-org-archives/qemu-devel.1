Received: from eggs.gnu.org ([2001:4830:134:3::10]:48496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ee4eM-0005i6-CF
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 14:54:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ee4eJ-0004mX-4v
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 14:54:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ee4eI-0004lw-VJ
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 14:54:27 -0500
Date: Tue, 23 Jan 2018 17:54:24 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180123195424.GC4298@localhost.localdomain>
References: <1516655269-1785-1-git-send-email-juterry@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516655269-1785-1-git-send-email-juterry@microsoft.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] Updates based on feedback.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Justin Terry (VM)" <juterry@microsoft.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net

On Mon, Jan 22, 2018 at 01:07:45PM -0800, Justin Terry (VM) wrote:
> Updates based on review feedback.
> 
> 1. Fixes style issues and properly ran the scripts/checkpatch pre submission.
> 2. Added migration blockers for CPUID, dirty memory tracking, and XSAVE/XRSTOR.
> 3. Fixed some bugs around register states when using bios vs efi.

For reference to others, v1 seems to be:

  Subject: [PATCH 0/4] Implements the Windows Hypervisor Platform accelerator
  https://www.mail-archive.com/qemu-devel@nongnu.org/msg505710.html

> 
> Justin Terry (VM) (4):
>   Add the Windows Hypervisor Platform accelerator.
>   Add the WHPX vcpu API
>   Introduce the WHPX impl
>   Add the WHPX acceleration enlightenments
> 
>  accel/stubs/Makefile.objs |    9 +-
>  accel/stubs/whpx-stub.c   |   48 ++
>  configure                 |   48 +-
>  cpus.c                    |   66 ++-
>  include/sysemu/hw_accel.h |   13 +
>  include/sysemu/whpx.h     |   40 ++
>  qemu-options.hx           |    8 +-
>  target/i386/Makefile.objs |    1 +
>  target/i386/helper.c      |    2 +-
>  target/i386/whpx-all.c    | 1366 +++++++++++++++++++++++++++++++++++++++++++++
>  10 files changed, 1590 insertions(+), 11 deletions(-)
>  create mode 100644 accel/stubs/whpx-stub.c
>  create mode 100644 include/sysemu/whpx.h
>  create mode 100644 target/i386/whpx-all.c
> 
> -- 
> 2.7.4
> 

-- 
Eduardo
