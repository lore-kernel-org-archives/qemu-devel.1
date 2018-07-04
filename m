Received: from eggs.gnu.org ([2001:4830:134:3::10]:57277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1faeOo-0008D5-AA
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1faeOj-0003uu-Ce
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:48:34 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:46729)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1faeOj-0003uQ-4N
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:48:29 -0400
Message-Id: <cover.1530697258.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Wed, 04 Jul 2018 11:40:58 +0200
Subject: [Qemu-devel] [PATCH v3 0/7] Misc sm501 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Sebastian Bauer <mail@sebastianbauer.info>, Philippe Mathieu-Daude <f4bug@amsat.org>

Version 3 with changes to 1/7 suggested by Philippe Mathieu-Daudé.
Hopefully this haven't missed 3.0 yet.

BALATON Zoltan (3):
  sm501: Implement i2c part for reading monitor EDID
  sm501: Fix support for non-zero frame buffer start address
  sm501: Set updated region dirty after 2D operation

Sebastian Bauer (4):
  sm501: Perform a full update after palette change
  sm501: Use values from the pitch register for 2D operations
  sm501: Implement negated destination raster operation mode
  sm501: Log unimplemented raster operation modes

 default-configs/ppc-softmmu.mak    |   1 +
 default-configs/ppcemb-softmmu.mak |   1 +
 default-configs/sh4-softmmu.mak    |   2 +
 default-configs/sh4eb-softmmu.mak  |   2 +
 hw/display/sm501.c                 | 230 +++++++++++++++++++++++++++++++++++--
 5 files changed, 224 insertions(+), 12 deletions(-)

-- 
2.7.6
