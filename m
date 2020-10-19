Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28296C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:08:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8351221741
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8351221741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpVe-0003GL-1W
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kUpQv-00062I-RW; Tue, 20 Oct 2020 07:04:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38580 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kUpQr-0006ms-6W; Tue, 20 Oct 2020 07:04:01 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 99934F94A069D7B1C013;
 Tue, 20 Oct 2020 19:03:49 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Tue, 20 Oct 2020
 19:03:43 +0800
From: Gan Qixin <ganqixin@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH 05/10] hw/misc/:split some lines containing more than 80
 characters
Date: Tue, 20 Oct 2020 04:30:18 +0800
Message-ID: <20201019203023.658555-6-ganqixin@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201019203023.658555-1-ganqixin@huawei.com>
References: <20201019203023.658555-1-ganqixin@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=ganqixin@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 07:03:45
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, peter.maydell@linaro.org,
 zhang.zhanghailiang@huawei.com, mst@redhat.com, f4bug@amsat.org,
 alistair.francis@wdc.com, Gan Qixin <ganqixin@huawei.com>,
 kuhn.chenqun@huawei.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By using scripts/checkpatch.pl, it is found that many files in hw/misc/
contain lines with more than 80 characters.

Signed-off-by: Gan Qixin <ganqixin@huawei.com>
---
 hw/misc/aspeed_sdmc.c  | 10 ++++++----
 hw/misc/bcm2835_mphi.c |  3 ++-
 hw/misc/edu.c          |  3 ++-
 hw/misc/omap_gpmc.c    |  3 ++-
 hw/misc/omap_sdrc.c    |  3 ++-
 hw/misc/pci-testdev.c  |  3 ++-
 hw/misc/sifive_test.c  |  4 ++--
 7 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 08f856cbda..2d9f6b5892 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -310,7 +310,8 @@ static void aspeed_2400_sdmc_write(AspeedSDMCState *s, uint32_t reg,
                                    uint32_t data)
 {
     if (reg == R_PROT) {
-        s->regs[reg] = (data == PROT_KEY_UNLOCK) ? PROT_UNLOCKED : PROT_SOFTLOCKED;
+        s->regs[reg] = (data ==
+                        PROT_KEY_UNLOCK) ? PROT_UNLOCKED : PROT_SOFTLOCKED;
         return;
     }
 
@@ -368,7 +369,8 @@ static void aspeed_2500_sdmc_write(AspeedSDMCState *s, uint32_t reg,
                                    uint32_t data)
 {
     if (reg == R_PROT) {
-        s->regs[reg] = (data == PROT_KEY_UNLOCK) ? PROT_UNLOCKED : PROT_SOFTLOCKED;
+        s->regs[reg] = (data == PROT_KEY_UNLOCK) ? PROT_UNLOCKED :
+                        PROT_SOFTLOCKED;
         return;
     }
 
@@ -448,8 +450,8 @@ static void aspeed_2600_sdmc_write(AspeedSDMCState *s, uint32_t reg,
     }
 
     if (s->regs[R_PROT] == PROT_HARDLOCKED) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: SDMC is locked until system reset!\n",
-                __func__);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: SDMC is locked until system reset!\n", __func__);
         return;
     }
 
diff --git a/hw/misc/bcm2835_mphi.c b/hw/misc/bcm2835_mphi.c
index 0428e10ba5..4c417770e4 100644
--- a/hw/misc/bcm2835_mphi.c
+++ b/hw/misc/bcm2835_mphi.c
@@ -148,7 +148,8 @@ static void mphi_init(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     BCM2835MphiState *s = BCM2835_MPHI(obj);
 
-    memory_region_init_io(&s->iomem, obj, &mphi_mmio_ops, s, "mphi", MPHI_MMIO_SIZE);
+    memory_region_init_io(&s->iomem, obj, &mphi_mmio_ops, s,
+                          "mphi", MPHI_MMIO_SIZE);
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index e935c418d4..5c933d1261 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -129,7 +129,8 @@ static dma_addr_t edu_clamp_addr(const EduState *edu, dma_addr_t addr)
     dma_addr_t res = addr & edu->dma_mask;
 
     if (addr != res) {
-        printf("EDU: clamping DMA %#.16"PRIx64" to %#.16"PRIx64"!\n", addr, res);
+        printf("EDU: clamping DMA 0x%.16"PRIx64" to 0x%.16"PRIx64"!\n",
+               addr, res);
     }
 
     return res;
diff --git a/hw/misc/omap_gpmc.c b/hw/misc/omap_gpmc.c
index 10de7a5523..e721fdde1f 100644
--- a/hw/misc/omap_gpmc.c
+++ b/hw/misc/omap_gpmc.c
@@ -830,7 +830,8 @@ struct omap_gpmc_s *omap_gpmc_init(struct omap_mpu_state_s *mpu,
     int cs;
     struct omap_gpmc_s *s = g_new0(struct omap_gpmc_s, 1);
 
-    memory_region_init_io(&s->iomem, NULL, &omap_gpmc_ops, s, "omap-gpmc", 0x1000);
+    memory_region_init_io(&s->iomem, NULL, &omap_gpmc_ops, s,
+                          "omap-gpmc", 0x1000);
     memory_region_add_subregion(get_system_memory(), base, &s->iomem);
 
     s->irq = irq;
diff --git a/hw/misc/omap_sdrc.c b/hw/misc/omap_sdrc.c
index f2f72f6810..438e9ce2ba 100644
--- a/hw/misc/omap_sdrc.c
+++ b/hw/misc/omap_sdrc.c
@@ -161,7 +161,8 @@ struct omap_sdrc_s *omap_sdrc_init(MemoryRegion *sysmem,
 
     omap_sdrc_reset(s);
 
-    memory_region_init_io(&s->iomem, NULL, &omap_sdrc_ops, s, "omap.sdrc", 0x1000);
+    memory_region_init_io(&s->iomem, NULL, &omap_sdrc_ops,
+                          s, "omap.sdrc", 0x1000);
     memory_region_add_subregion(sysmem, base, &s->iomem);
 
     return s;
diff --git a/hw/misc/pci-testdev.c b/hw/misc/pci-testdev.c
index 03845c8de3..ac21f918a2 100644
--- a/hw/misc/pci-testdev.c
+++ b/hw/misc/pci-testdev.c
@@ -277,7 +277,8 @@ static void pci_testdev_realize(PCIDevice *pci_dev, Error **errp)
         test->hdr = g_malloc0(test->bufsize);
         memcpy(test->hdr->name, name, strlen(name) + 1);
         g_free(name);
-        test->hdr->offset = cpu_to_le32(IOTEST_SIZE(i) + i * IOTEST_ACCESS_WIDTH);
+        test->hdr->offset = cpu_to_le32(IOTEST_SIZE(i) +
+                            i * IOTEST_ACCESS_WIDTH);
         test->match_data = strcmp(IOTEST_TEST(i), "wildcard-eventfd");
         if (fastmmio && IOTEST_IS_MEM(i) && !test->match_data) {
             test->size = 0;
diff --git a/hw/misc/sifive_test.c b/hw/misc/sifive_test.c
index 2deb2072cc..2ffcb3b532 100644
--- a/hw/misc/sifive_test.c
+++ b/hw/misc/sifive_test.c
@@ -50,8 +50,8 @@ static void sifive_test_write(void *opaque, hwaddr addr,
             break;
         }
     }
-    qemu_log_mask(LOG_GUEST_ERROR, "%s: write: addr=0x%x val=0x%016" PRIx64 "\n",
-                  __func__, (int)addr, val64);
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: write: addr=0x%x val=0x%016" PRIx64
+                  "\n", __func__, (int)addr, val64);
 }
 
 static const MemoryRegionOps sifive_test_ops = {
-- 
2.23.0


