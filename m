Received: from eggs.gnu.org ([2001:4830:134:3::10]:36264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1daOtd-00075j-7l
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1daOtZ-0003PI-1f
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:10:49 -0400
Received: from mail-bn3nam01on0077.outbound.protection.outlook.com
	([104.47.33.77]:42592
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1daOtY-0003Ms-F3
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:10:44 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 26 Jul 2017 09:07:22 -0700
Message-ID: <cover.1501084908.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 0/5]  More warning reporting fixed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com

This series expands on my previous series by converting more existing
prints to use warn_report() instead of error_report() or fprintf().

Alistair Francis (5):
  hw/i386: Improve some of the warning messages
  Convert remaining error_report() to warn_report()
  Convert single line fprintf() to warn_report()
  Convert multi-line fprintf() to warn_report()
  Convert single line fprintf() to warn_report()

 accel/kvm/kvm-all.c         |  7 +++----
 block/qcow2.c               | 10 +++++-----
 block/vvfat.c               |  8 +++++---
 hw/acpi/core.c              | 10 +++++-----
 hw/arm/vexpress.c           |  4 ++--
 hw/i386/acpi-build.c        | 15 ++++++++++-----
 hw/i386/pc.c                |  9 ++++-----
 hw/i386/pc_q35.c            |  8 +++++---
 hw/i386/xen/xen-mapcache.c  |  4 ++--
 hw/mips/mips_malta.c        |  4 ++--
 hw/mips/mips_r4k.c          |  7 ++++---
 hw/misc/applesmc.c          |  2 +-
 hw/s390x/s390-virtio.c      | 16 ++++++++--------
 hw/usb/hcd-ehci.c           |  5 +++--
 hw/virtio/virtio-balloon.c  |  3 ++-
 net/hub.c                   | 12 ++++++------
 net/net.c                   | 14 +++++++-------
 net/socket.c                |  7 +++++--
 qga/vss-win32.c             |  2 +-
 target/i386/cpu.c           | 12 ++++++------
 target/i386/hax-mem.c       |  6 +++---
 target/mips/kvm.c           |  4 ++--
 target/ppc/translate_init.c | 18 +++++++++---------
 target/s390x/kvm.c          |  4 ++--
 tests/Makefile.include      |  4 ++--
 trace/control.c             |  4 ++--
 trace/simple.c              |  2 +-
 ui/keymaps.c                | 11 ++++++-----
 ui/spice-display.c          |  2 +-
 util/cutils.c               |  3 ++-
 util/main-loop.c            |  6 +++---
 31 files changed, 119 insertions(+), 104 deletions(-)

-- 
2.11.0
