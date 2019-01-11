Received: from eggs.gnu.org ([209.51.188.92]:38029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ghlYr-0006R3-Sm
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 20:24:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ghlYq-0000sy-2B
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 20:24:37 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:50520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1ghlYo-0000lG-BN
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 20:24:35 -0500
Message-Id: <1e352f091aa601fb2e19771aac46529fe278dd91.1547166960.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1547166960.git.balaton@eik.bme.hu>
References: <cover.1547166960.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Fri, 11 Jan 2019 01:36:00 +0100
Subject: [Qemu-devel] [PATCH 1/5] cmd646: Remove unused variable
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

There was a pointer to PCIIDEState in CMD646BAR which was set but
not used afterwards. Get rid of this unused variable.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ide/cmd646.c      | 1 -
 include/hw/ide/pci.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index 6bb92d717f..41c1831f9a 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -123,7 +123,6 @@ static void setup_cmd646_bar(PCIIDEState *d, int bus_num)
     CMD646BAR *bar = &d->cmd646_bar[bus_num];
 
     bar->bus = bus;
-    bar->pci_dev = d;
     memory_region_init_io(&bar->cmd, OBJECT(d), &cmd646_cmd_ops, bar,
                           "cmd646-cmd", 4);
     memory_region_init_io(&bar->data, OBJECT(d), &cmd646_data_ops, bar,
diff --git a/include/hw/ide/pci.h b/include/hw/ide/pci.h
index dbc6a0383d..ed723acfb4 100644
--- a/include/hw/ide/pci.h
+++ b/include/hw/ide/pci.h
@@ -41,7 +41,6 @@ typedef struct CMD646BAR {
     MemoryRegion cmd;
     MemoryRegion data;
     IDEBus *bus;
-    struct PCIIDEState *pci_dev;
 } CMD646BAR;
 
 #define TYPE_PCI_IDE "pci-ide"
-- 
2.13.7
