Received: from eggs.gnu.org ([2001:4830:134:3::10]:44115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQq5-00052g-Eq
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:44:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQq4-0002AQ-Bs
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:44:05 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  9 Jul 2018 17:43:34 +1000
Message-Id: <20180709074350.27086-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/16] ppc-for-3.0 queue 20180709
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 43a473993fd9378bf850dcafa68eb6dee8c300=
f8:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2018-07-06 18:18:08 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-3.0-20180709

for you to fetch changes up to 51b0d834c414f494410cc94e56886b6584ae3c54:

  sam460ex: Make sam460ex_load_device_tree() handle all errors internally=
 (2018-07-09 14:38:45 +1000)

----------------------------------------------------------------
ppc patch queue 2018-07-09

Here's a final pull request before tomorrow's hard freeze.

There are a number of fixes and improvements to the sm501 display
driver (not strictly ppc related, but used only on ppc and SH).
There's also a handful of unrelated fixes.

Whether all the sm501 changes are bugfixes is somewhat debatable, but
Peter has indicated he's ok with merging those for 3.0.

----------------------------------------------------------------
BALATON Zoltan (4):
      sm501: Implement i2c part for reading monitor EDID
      sm501: Fix support for non-zero frame buffer start address
      sm501: Set updated region dirty after 2D operation
      sam460ex: Update u-boot-sam460ex firmware

C=C3=A9dric Le Goater (1):
      spapr/vio: quiet down the "irq" property accessors

David Gibson (3):
      sam460ex: Check for errors from libfdt functions
      sam460ex: Don't check for errors from qemu_fdt_*()
      sam460ex: Make sam460ex_load_device_tree() handle all errors intern=
ally

Laurent Vivier (1):
      target/ppc: fix build on ppc64 host

Mark Cave-Ayland (2):
      ppc: fix default VGA display for Mac machines
      ppc: fix default VGA display for PReP machines

Philippe Mathieu-Daud=C3=A9 (1):
      ppc440_uc: Fix a copy/paste error

Sebastian Bauer (4):
      sm501: Perform a full update after palette change
      sm501: Use values from the pitch register for 2D operations
      sm501: Implement negated destination raster operation mode
      sm501: Log unimplemented raster operation modes

 default-configs/ppc-softmmu.mak    |   1 +
 default-configs/ppcemb-softmmu.mak |   1 +
 default-configs/sh4-softmmu.mak    |   2 +
 default-configs/sh4eb-softmmu.mak  |   2 +
 hw/display/sm501.c                 | 230 +++++++++++++++++++++++++++++++=
++++--
 hw/ppc/mac_newworld.c              |   1 +
 hw/ppc/mac_oldworld.c              |   1 +
 hw/ppc/ppc440_uc.c                 |   2 +-
 hw/ppc/prep.c                      |   2 +
 hw/ppc/sam460ex.c                  |  49 +++-----
 hw/ppc/spapr_vio.c                 |  15 ++-
 pc-bios/u-boot-sam460-20100605.bin | Bin 524288 -> 524288 bytes
 roms/u-boot-sam460ex               |   2 +-
 target/ppc/int_helper.c            |   2 +-
 14 files changed, 258 insertions(+), 52 deletions(-)
