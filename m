Received: from eggs.gnu.org ([2001:4830:134:3::10]:40775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1edjK3-0004Y1-O2
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 16:08:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1edjK0-00021U-Hk
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 16:08:07 -0500
Received: from mail-sn1nam02on0116.outbound.protection.outlook.com
	([104.47.36.116]:8720
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juterry@microsoft.com>)
	id 1edjK0-00020h-7I
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 16:08:04 -0500
From: "Justin Terry (VM)" <juterry@microsoft.com>
Date: Mon, 22 Jan 2018 13:07:45 -0800
Message-Id: <1516655269-1785-1-git-send-email-juterry@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/4] Updates based on feedback.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, ehabkost@redhat.com, "Justin Terry (VM)" <juterry@microsoft.com>

Updates based on review feedback.

1. Fixes style issues and properly ran the scripts/checkpatch pre submission.
2. Added migration blockers for CPUID, dirty memory tracking, and XSAVE/XRSTOR.
3. Fixed some bugs around register states when using bios vs efi.

Justin Terry (VM) (4):
  Add the Windows Hypervisor Platform accelerator.
  Add the WHPX vcpu API
  Introduce the WHPX impl
  Add the WHPX acceleration enlightenments

 accel/stubs/Makefile.objs |    9 +-
 accel/stubs/whpx-stub.c   |   48 ++
 configure                 |   48 +-
 cpus.c                    |   66 ++-
 include/sysemu/hw_accel.h |   13 +
 include/sysemu/whpx.h     |   40 ++
 qemu-options.hx           |    8 +-
 target/i386/Makefile.objs |    1 +
 target/i386/helper.c      |    2 +-
 target/i386/whpx-all.c    | 1366 +++++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 1590 insertions(+), 11 deletions(-)
 create mode 100644 accel/stubs/whpx-stub.c
 create mode 100644 include/sysemu/whpx.h
 create mode 100644 target/i386/whpx-all.c

-- 
2.7.4
