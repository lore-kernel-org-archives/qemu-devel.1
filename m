Received: from eggs.gnu.org ([2001:4830:134:3::10]:60170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1erjRG-0008Eb-G0
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 07:05:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1erjRB-000052-Gs
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 07:05:26 -0500
Message-Id: <cover.1519991414.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Fri, 02 Mar 2018 12:50:14 +0100
Subject: [Qemu-devel] [PATCH v2 0/2] Firmware blob and git submodule for
 Sam460ex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Jeff Cody <jcody@redhat.com>

This is v2 of the firmware image for the ppc sam460ex machine type in
case you choose to add it with external git repo first. In case you
decide not to add it either as external git nor as a mirrored or
copied to QEMU repo then probably some wiki page should be updated to
point to a binary image for the machine to be usable but I'm not sure
how to do that. Please advise which of the above options should be
followed.

Thank you,
BALATON Zoltan

BALATON Zoltan (2):
  roms: Added git submodule for u-boot-sam460 (firmware for sam460ex)
  pc-bios: Added u-boot-sam460 firmware binary

 .gitmodules                        |   3 +++
 Makefile                           |   2 +-
 pc-bios/u-boot-sam460-20100605.bin | Bin 0 -> 524288 bytes
 roms/Makefile                      |   7 +++++++
 roms/u-boot-sam460ex               |   1 +
 5 files changed, 12 insertions(+), 1 deletion(-)
 create mode 100755 pc-bios/u-boot-sam460-20100605.bin
 create mode 160000 roms/u-boot-sam460ex

-- 
2.7.6
