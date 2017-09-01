Received: from eggs.gnu.org ([2001:4830:134:3::10]:50932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dnpDY-0005dv-J4
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 12:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dnpDT-0005zT-QO
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 12:54:52 -0400
Received: from mail-by2nam01on0089.outbound.protection.outlook.com
	([104.47.34.89]:60144
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dnpDT-0005ys-7U
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 12:54:47 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 1 Sep 2017 09:51:00 -0700
Message-ID: <cover.1504228916.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/7]  More warning reporting fixed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, pbonzini@redhat.com

This series expands on my previous series by converting more existing
prints to use warn_report() instead of error_report() or fprintf().

As discussed with Paolo and Markus this series combines libqemustub.a into
libqemuutil.a to avoid circular dependencies.

V3:
 - Small corrections as reported by Markus
 - Rename patch 3 and 5 so they don't have the same name
 - Combine libqemustub.a into libqemuutil.a
 - Add an extra patch with general cleanups

V2:
 - Fixup auto CC logic so everyone is CCed

Alistair Francis (7):
  hw/i386: Improve some of the warning messages
  Convert remaining error_report() to warn_report()
  Convert single line fprintf(.../n) to warn_report()
  Convert multi-line fprintf() to warn_report()
  General warn report fixups
  Makefile: Remove libqemustub.a
  Convert remaining single line fprintf() to warn_report()

 Makefile                    |  7 +++----
 Makefile.target             |  2 +-
 accel/kvm/kvm-all.c         |  7 +++----
 block/qcow2.c               |  9 +++++----
 block/vvfat.c               |  7 ++++---
 docs/devel/build-system.txt | 16 +++++++---------
 hw/acpi/core.c              | 10 +++++-----
 hw/arm/vexpress.c           |  4 ++--
 hw/i386/acpi-build.c        | 15 ++++++++++-----
 hw/i386/pc.c                |  9 ++++-----
 hw/i386/pc_q35.c            |  8 +++++---
 hw/i386/xen/xen-mapcache.c  |  5 +++--
 hw/mips/mips_malta.c        |  4 ++--
 hw/mips/mips_r4k.c          |  5 ++---
 hw/misc/applesmc.c          |  2 +-
 hw/s390x/s390-virtio.c      | 17 +++++++++--------
 hw/usb/hcd-ehci.c           |  5 +++--
 hw/virtio/virtio-balloon.c  |  3 ++-
 net/hub.c                   | 10 ++++------
 net/net.c                   | 15 ++++++++-------
 net/socket.c                |  7 +++++--
 qga/vss-win32.c             |  2 +-
 target/i386/cpu.c           | 12 ++++++------
 target/i386/hax-mem.c       |  5 ++---
 target/mips/kvm.c           |  4 ++--
 target/ppc/translate_init.c | 17 ++++++++---------
 target/s390x/kvm.c          |  4 ++--
 tests/Makefile.include      |  8 ++++----
 trace/control.c             |  4 ++--
 trace/simple.c              |  3 ++-
 ui/keymaps.c                | 10 +++++-----
 ui/spice-display.c          |  2 +-
 util/cutils.c               |  3 ++-
 util/main-loop.c            |  6 +++---
 34 files changed, 128 insertions(+), 119 deletions(-)

--=20
2.11.0
