Received: from eggs.gnu.org ([2001:4830:134:3::10]:52941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cMixv-00053X-Lk
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 17:14:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cMixs-0001c1-Gp
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 17:14:27 -0500
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Thu, 29 Dec 2016 23:12:10 +0100
Message-Id: <1483049536-21548-1-git-send-email-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/6] ppc: add a IBM 40p machine (RS/6000, PReP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, Giancarlo Teodori <gteodori@gmail.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

Hi,

This patchset adds the emulation of the IBM RS/6000 7020 (40p). The real =
machine is
able to run AIX (up to 4.3.3), Windows NT (up to 4.0 SP1), the beta of OS=
/2 PowerPC,
Solaris, Linux, NetBSD/PReP ...

I've tested current emulation with Open Hack'Ware, OpenBIOS and official =
firmware.

Linux kernel starts, and freezes during boot (like with 'prep' machine).
Windows NT starts up to the point where it wants to change endianness.
Other OSes have not been tested.

This machine is a superset of the 'prep' one, because we know exactly wha=
t is/should
emulated, and that operating system list running on it is quite wide.
I hope that 'prep' machine can be deprecated soon and then later removed.

Patches 1 to 3 are cleanups, and can probably be committed first.
Patches 4 to 6 are the real implementation of the IBM 40p.

Herv=C3=A9 Poussineau (6):
  pci: add pci_vga_type(), giving the device name of the chosen VGA
    device
  vga: increase priority of 0xa0000 memory region
  prep: do not use global variable to access nvram
  prep: QOM'ify System I/O
  prep: add IBM RS/6000 7020 (40p) memory controller
  prep: add IBM RS/6000 7020 (40p) machine emulation

 default-configs/ppc-softmmu.mak |   2 +
 hw/display/vga.c                |   2 +-
 hw/pci/pci.c                    |  22 ++-
 hw/ppc/Makefile.objs            |   2 +
 hw/ppc/prep.c                   | 235 ++++++++++++++++++++++++++++++-
 hw/ppc/prep_systemio.c          | 302 ++++++++++++++++++++++++++++++++++=
++++++
 hw/ppc/rs6000_mc.c              | 232 ++++++++++++++++++++++++++++++
 hw/ppc/trace-events             |  11 ++
 include/hw/pci/pci.h            |   1 +
 9 files changed, 800 insertions(+), 9 deletions(-)
 create mode 100644 hw/ppc/prep_systemio.c
 create mode 100644 hw/ppc/rs6000_mc.c

--=20
2.1.4
