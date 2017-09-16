Received: from eggs.gnu.org ([2001:4830:134:3::10]:42172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dtDlp-0006fc-SA
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 10:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dtDln-0003TO-Pe
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 10:08:33 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:41145)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1dtDln-0003Sm-Jg
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 10:08:31 -0400
Message-Id: <cover.1505570561.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sat, 16 Sep 2017 16:02:41 +0200
Date: Sat, 16 Sep 2017 16:02:41 +0200
Subject: [Qemu-devel] [PATCH v2 0/4] Sam460ex emulation
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

Resending those patches that were reviewed and did not need any
changes or only rebasing to latest master so these could go in now.
I'll get back to the other patches that need more changes later.

BALATON Zoltan (4):
  ohci: Allow sysbus version to be used as a companion
  ehci: Add ppc4xx-ehci for the USB 2.0 controller in embedded PPC SoCs
  ppc4xx: Add more PLB registers
  ppc: Add 460EX embedded CPU

 hw/ppc/ppc405_uc.c          | 12 +++++++++---
 hw/usb/hcd-ehci-sysbus.c    | 25 +++++++++++++++++++++++++
 hw/usb/hcd-ehci.h           |  1 +
 hw/usb/hcd-ohci.c           | 15 ++++++++++++---
 target/ppc/cpu-models.c     |  3 +++
 target/ppc/cpu-models.h     |  1 +
 target/ppc/translate_init.c | 38 ++++++++++++++++++++++++++++++++++++++
 7 files changed, 89 insertions(+), 6 deletions(-)

-- 
2.7.6
