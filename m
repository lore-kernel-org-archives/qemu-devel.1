Received: from eggs.gnu.org ([209.51.188.92]:56361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1cSH-0004PK-EE
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 14:43:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1cSG-00050e-Bc
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 14:43:53 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:53320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h1cSG-0004yo-1B
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 14:43:52 -0500
Message-Id: <cover.1551899859.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Wed, 06 Mar 2019 20:17:39 +0100
Subject: [Qemu-devel] [PATCH v5 0/2] Basic ATI VGA emulation
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

Hello,

This is the latest version of the ati-vga patch, now also including
the mips_fulong2e patch in a series so both can be merged together via
the UI tree as agreed before to avoid needing to sync two maintainers.

That's probably all I can do before the freeze but the rest can be
considered bugfixes (or given that there's nothing to regress from yet
anything can be considered bugfix at this stage) so we may have some
more chance to improve it before the release if it's merged now.

At least Linux console and fulong2e PMON firmware should work but I
wasn't able to completely find out how 2D accel should work so it
still gives some garbled output for guests using it but I won't have
time to figure this out before the freeze. I could take some help in
this from someone knowing this hardware and pixman better than me.
(Pixman not having any documentation does not help.)

Please let me know if there's anything that needs to be fixed for it
to be merged now. I can probably make another version before the
freeze with those changes but not much more at the moment.

Regards,
BALATON Zoltan

BALATON Zoltan (2):
  hw/display: Add basic ATI VGA emulation
  mips_fulong2e: Add on-board graphics chip

 default-configs/pci.mak  |   1 +
 hw/display/Makefile.objs |   2 +
 hw/display/ati.c         | 786 +++++++++++++++++++++++++++++++++++++++++++++++
 hw/display/ati_2d.c      | 134 ++++++++
 hw/display/ati_dbg.c     | 259 ++++++++++++++++
 hw/display/ati_int.h     |  93 ++++++
 hw/display/ati_regs.h    | 461 +++++++++++++++++++++++++++
 hw/display/trace-events  |   4 +
 hw/mips/mips_fulong2e.c  |   6 +
 vl.c                     |   1 +
 10 files changed, 1747 insertions(+)
 create mode 100644 hw/display/ati.c
 create mode 100644 hw/display/ati_2d.c
 create mode 100644 hw/display/ati_dbg.c
 create mode 100644 hw/display/ati_int.h
 create mode 100644 hw/display/ati_regs.h

-- 
2.13.7
