Received: from eggs.gnu.org ([2001:4830:134:3::10]:57251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1emRk2-00027L-HD
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:10:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1emRk1-0003vs-6c
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:10:58 -0500
Message-Id: <cover.1518730026.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Thu, 15 Feb 2018 22:27:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Feb 2018 22:27:06 +0100
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/3] Sam460ex emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Francois Revol <revol@free.fr>

Remaining patches for Sam460ex emulation. The original cover letter
with more details is here:

http://lists.nongnu.org/archive/html/qemu-ppc/2017-08/msg00112.html

We'll need to also add binaries for firmware (customised u-boot
version) and dtb but I'm not sure how to submit those.

Current status for OSes I've tried:

- AROS boots (after I've fixed some bugs in it which are now upstream
  so the nightly iso should work) but keyboard doesn't work (could be
  a bug in AROS's HID driver) and time is going slow (this can be seen
  in time prefs). This may be a QEMU bug and possibly causes the hang
  seen in other OSes but I don't know what causes it or how to fix it.
  Maybe related to some internal timing registers of the SoC because
  setting multipliers to real values causes U-Boot to become slow.
  Anyone with more knowledge of this hardware has any idea?

- Linux: kernel boots but hangs during user space (again could be the
  above timing problem or maybe missing emac network interface
  emulation but I don't really know).

- AmigaOS 4 seems to boot but display is not working so not usable
  (either related to timing problem or could be SM502 emulation).

- MorphOS does not boot (it seems to either deliberately do stuff to
  prevent it from running on QEMU or it has bugs but developers are
  not communicative about it)

Regards,
BALATON Zoltan

BALATON Zoltan (3):
  ppc4xx: Add device models found in PPC440 core SoCs
  ppc440: Add emulation of plb-pcix controller found in some 440 SoCs
  ppc: Add aCube Sam460ex board

 default-configs/ppc-softmmu.mak    |    2 +
 default-configs/ppcemb-softmmu.mak |    1 +
 hw/ppc/Makefile.objs               |    3 +-
 hw/ppc/ppc440.h                    |   26 +
 hw/ppc/ppc440_pcix.c               |  528 ++++++++++++++++
 hw/ppc/ppc440_uc.c                 | 1159 ++++++++++++++++++++++++++++++=
++++++
 hw/ppc/sam460ex.c                  |  603 +++++++++++++++++++
 hw/ppc/trace-events                |    8 +
 include/hw/pci/pcie_host.h         |    2 +-
 9 files changed, 2330 insertions(+), 2 deletions(-)
 create mode 100644 hw/ppc/ppc440.h
 create mode 100644 hw/ppc/ppc440_pcix.c
 create mode 100644 hw/ppc/ppc440_uc.c
 create mode 100644 hw/ppc/sam460ex.c

--=20
2.7.6
