Received: from eggs.gnu.org ([2001:4830:134:3::10]:43186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eniv3-0001Kk-Fs
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 05:43:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eniv0-0006rm-9u
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 05:43:37 -0500
Message-Id: <cover.1519036465.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Feb 2018 11:34:25 +0100
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/2] Sam460ex emulation
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

This is just resending the two remaining patches (2/3 from v2 and v3
of 3/3 of previous series as a new series to have them at one place).

BALATON Zoltan (2):
  ppc440: Add emulation of plb-pcix controller found in some 440 SoCs
  ppc: Add aCube Sam460ex board

 Makefile                           |   2 +-
 default-configs/ppc-softmmu.mak    |   2 +
 default-configs/ppcemb-softmmu.mak |   1 +
 hw/ppc/Makefile.objs               |   3 +-
 hw/ppc/ppc440_pcix.c               | 528 +++++++++++++++++++++++++++++++=
+
 hw/ppc/sam460ex.c                  | 603 +++++++++++++++++++++++++++++++=
++++++
 hw/ppc/trace-events                |   8 +
 pc-bios/canyonlands.dtb            | Bin 0 -> 9779 bytes
 pc-bios/canyonlands.dts            | 566 +++++++++++++++++++++++++++++++=
+++
 9 files changed, 1711 insertions(+), 2 deletions(-)
 create mode 100644 hw/ppc/ppc440_pcix.c
 create mode 100644 hw/ppc/sam460ex.c
 create mode 100644 pc-bios/canyonlands.dtb
 create mode 100644 pc-bios/canyonlands.dts

--=20
2.7.6
