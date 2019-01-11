Received: from eggs.gnu.org ([209.51.188.92]:38030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ghlYr-0006R4-Sp
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 20:24:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ghlYq-0000t0-2D
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 20:24:37 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:50521)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1ghlYo-0000lH-Bd
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 20:24:35 -0500
Message-Id: <cover.1547166960.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Fri, 11 Jan 2019 01:36:00 +0100
Subject: [Qemu-devel] [PATCH 0/5] Refactor common PCI IDE functions from
 CMD646
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <rth@twiddle.net>

Hello,

This series is a small refactoring that moves some common PCI IDE io
mem ops functions from the CMD646 model to the PCI IDE model so a
CMD646 specific type can be dropped from PCIIDEState, removes code
duplication from SiI3112 model (also fixing a bug) and allows these
functions to be used by future PCI IDE implementations.

Also cc'd Mark and Richard because the CMD646 seems to be used by
Sparc, HPPA and Alpha machines.

Regards,
BALATON Zoltan

BALATON Zoltan (5):
  cmd646: Remove unused variable
  cmd646: Remove IDEBus from CMD646BAR
  cmd646: Move PCI IDE specific functions to ide/pci.c
  ide: Get rid of CMD646BAR struct
  sii3112: Remove duplicated code and use PCI IDE ops instead

 hw/ide/cmd646.c      | 102 ++++++++-------------------------------------------
 hw/ide/pci.c         |  65 ++++++++++++++++++++++++++++++++
 hw/ide/sii3112.c     |  52 ++++----------------------
 include/hw/ide/pci.h |  14 ++-----
 4 files changed, 93 insertions(+), 140 deletions(-)

-- 
2.13.7
