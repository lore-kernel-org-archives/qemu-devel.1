Received: from eggs.gnu.org ([2001:4830:134:3::10]:52711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fVuwk-0001ji-Aj
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 04:28:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fVuwh-0004cm-1K
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 04:28:02 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:31077)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1fVuwg-0004c9-Q7
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 04:27:58 -0400
Message-Id: <cover.1529568501.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Thu, 21 Jun 2018 10:08:21 +0200
Date: Thu, 21 Jun 2018 10:08:21 +0200
Subject: [Qemu-devel] [PATCH 0/5] Misc sm501 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Sebastian Bauer <mail@sebastianbauer.info>

These are fixes to sm501 emulation that were found while testing with
AmigaOS 4.1FE (AmigaOS 4 is known to work on real hardware but we have
no way to verify it against hardware). While this is mainly to improve
sam460ex emulation this is now a separate series with the sm501
specific patches because that's also used on SH emulation. I hope
someone can review and merge this.

BALATON Zoltan (3):
  sm501: Implement i2c part for reading monitor EDID
  sm501: Set updated region dirty after 2D operation
  sm501: Fix support for non-zero frame buffer start address

Sebastian Bauer (2):
  sm501: Perform a full update after palette change
  sm501: Use values from the pitch register for 2d operations.

 default-configs/ppc-softmmu.mak    |   1 +
 default-configs/ppcemb-softmmu.mak |   1 +
 default-configs/sh4-softmmu.mak    |   2 +
 default-configs/sh4eb-softmmu.mak  |   2 +
 hw/display/sm501.c                 | 166 +++++++++++++++++++++++++++++++++++--
 5 files changed, 163 insertions(+), 9 deletions(-)

-- 
2.7.6
