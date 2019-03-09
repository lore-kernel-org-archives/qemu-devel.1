Received: from eggs.gnu.org ([209.51.188.92]:34185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h2yof-0004zZ-OO
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 09:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h2yod-0005Qb-QZ
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 09:48:37 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:29563)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h2yob-0005P5-T4
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 09:48:34 -0400
Message-Id: <cover.1552152100.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sat, 09 Mar 2019 18:21:40 +0100
Subject: [Qemu-devel] [PATCH v7 0/2] Basic ATI VGA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Aleksandar Markovic <amarkovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, philmd@redhat.com

Rebase on master to fix build with new Kconfig based stuff.

BALATON Zoltan (2):
  hw/display: Add basic ATI VGA emulation
  mips_fulong2e: Add on-board graphics chip

 hw/display/Kconfig       |   6 +
 hw/display/Makefile.objs |   2 +
 hw/display/ati.c         | 865 +++++++++++++++++++++++++++++++++++++++++++++++
 hw/display/ati_2d.c      | 167 +++++++++
 hw/display/ati_dbg.c     | 259 ++++++++++++++
 hw/display/ati_int.h     |  96 ++++++
 hw/display/ati_regs.h    | 461 +++++++++++++++++++++++++
 hw/display/trace-events  |   4 +
 hw/mips/mips_fulong2e.c  |   7 +
 vl.c                     |   1 +
 10 files changed, 1868 insertions(+)
 create mode 100644 hw/display/ati.c
 create mode 100644 hw/display/ati_2d.c
 create mode 100644 hw/display/ati_dbg.c
 create mode 100644 hw/display/ati_int.h
 create mode 100644 hw/display/ati_regs.h

-- 
2.13.7
