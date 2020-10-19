Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE7FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E16FA21D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16FA21D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpSl-00084l-OI
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kUpQt-00061J-HQ; Tue, 20 Oct 2020 07:04:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38616 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kUpQr-0006mt-6z; Tue, 20 Oct 2020 07:03:59 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id A03BA91E903B23999C30;
 Tue, 20 Oct 2020 19:03:49 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Tue, 20 Oct 2020
 19:03:40 +0800
From: Gan Qixin <ganqixin@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH 03/10] hw/ide/:split some lines containing more than 80
 characters
Date: Tue, 20 Oct 2020 04:30:16 +0800
Message-ID: <20201019203023.658555-4-ganqixin@huawei.com>
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

By using scripts/checkpatch.pl, it is found that many files in hw/ide/
contain lines with more than 80 characters.

Signed-off-by: Gan Qixin <ganqixin@huawei.com>
---
 hw/ide/ahci.c   | 10 ++++++----
 hw/ide/atapi.c  |  9 +++++----
 hw/ide/cmd646.c |  3 ++-
 hw/ide/core.c   | 21 ++++++++++++++-------
 hw/ide/piix.c   |  3 ++-
 hw/ide/via.c    |  3 ++-
 6 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 680304a24c..83bbc7e3df 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1252,7 +1252,8 @@ static void handle_reg_h2d_fis(AHCIState *s, int port,
     if (opts & AHCI_CMD_ATAPI) {
         memcpy(ide_state->io_buffer, &cmd_fis[AHCI_COMMAND_TABLE_ACMD], 0x10);
         if (trace_event_get_state_backends(TRACE_HANDLE_REG_H2D_FIS_DUMP)) {
-            char *pretty_fis = ahci_pretty_buffer_fis(ide_state->io_buffer, 0x10);
+            char *pretty_fis = ahci_pretty_buffer_fis(ide_state->io_buffer,
+                                                      0x10);
             trace_handle_reg_h2d_fis_dump(s, port, pretty_fis);
             g_free(pretty_fis);
         }
@@ -1356,9 +1357,10 @@ static void ahci_pio_transfer(const IDEDMA *dma)
      * The device only sets the 'I' bit in the PIO Setup FIS for device->host
      * requests (see "DPIOI1" in the SATA spec), or for host->device DRQs after
      * the first (see "DPIOO1").  The latter is consistent with the spec's
-     * description of the PACKET protocol, where the command part of ATAPI requests
-     * ("DPKT0") has the 'I' bit clear, while the data part of PIO ATAPI requests
-     * ("DPKT4a" and "DPKT7") has the 'I' bit set for both directions for all DRQs.
+     * description of the PACKET protocol, where the command part of ATAPI
+     * requests ("DPKT0") has the 'I' bit clear, while the data part of PIO
+     * ATAPI requests ("DPKT4a" and "DPKT7") has the 'I' bit set for both
+     * directions for all DRQs.
      */
     pio_fis_i = ad->done_first_drq || (!is_atapi && !is_write);
     ahci_write_fis_pio(ad, size, pio_fis_i);
diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index 14a2b0bb2f..7f346d5d2a 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -378,7 +378,8 @@ static void ide_atapi_cmd_read_dma_cb(void *opaque, int ret)
 
     if (s->packet_transfer_size <= 0) {
         s->status = READY_STAT | SEEK_STAT;
-        s->nsector = (s->nsector & ~7) | ATAPI_INT_REASON_IO | ATAPI_INT_REASON_CD;
+        s->nsector = (s->nsector & ~7) | ATAPI_INT_REASON_IO |
+                      ATAPI_INT_REASON_CD;
         ide_set_irq(s->bus);
         goto eot;
     }
@@ -1232,9 +1233,9 @@ enum {
     ALLOW_UA = 0x01,
 
     /*
-     * Commands flagged with CHECK_READY can only execute if a medium is present.
-     * Otherwise they report the Not Ready Condition. (See MMC-5, section
-     * 4.1.8)
+     * Commands flagged with CHECK_READY can only execute if a medium is
+     * present. Otherwise they report the Not Ready Condition. (See MMC-5,
+     * section 4.1.8)
      */
     CHECK_READY = 0x02,
 
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index c254631485..c41990f393 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -144,7 +144,8 @@ static void bmdma_write(void *opaque, hwaddr addr,
         cmd646_update_irq(pci_dev);
         break;
     case 2:
-        bm->status = (val & 0x60) | (bm->status & 1) | (bm->status & ~val & 0x06);
+        bm->status = (val & 0x60) | (bm->status & 1) |
+                     (bm->status & ~val & 0x06);
         break;
     case 3:
         if (bm == &bm->pci_dev->bmdma[0]) {
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 693b352d5e..b784fff88f 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2017,7 +2017,8 @@ static const struct {
     [WIN_READ_ONCE]               = { cmd_read_pio, HD_CFA_OK },
     [WIN_READ_EXT]                = { cmd_read_pio, HD_CFA_OK },
     [WIN_READDMA_EXT]             = { cmd_read_dma, HD_CFA_OK },
-    [WIN_READ_NATIVE_MAX_EXT]     = { cmd_read_native_max, HD_CFA_OK | SET_DSC },
+    [WIN_READ_NATIVE_MAX_EXT]     = { cmd_read_native_max, HD_CFA_OK |
+                                      SET_DSC },
     [WIN_MULTREAD_EXT]            = { cmd_read_multiple, HD_CFA_OK },
     [WIN_WRITE]                   = { cmd_write_pio, HD_CFA_OK },
     [WIN_WRITE_ONCE]              = { cmd_write_pio, HD_CFA_OK },
@@ -2037,7 +2038,8 @@ static const struct {
     [WIN_IDLEIMMEDIATE2]          = { cmd_nop, HD_CFA_OK },
     [WIN_STANDBY2]                = { cmd_nop, HD_CFA_OK },
     [WIN_SETIDLE2]                = { cmd_nop, HD_CFA_OK },
-    [WIN_CHECKPOWERMODE2]         = { cmd_check_power_mode, HD_CFA_OK | SET_DSC },
+    [WIN_CHECKPOWERMODE2]         = { cmd_check_power_mode, HD_CFA_OK |
+                                      SET_DSC },
     [WIN_SLEEPNOW2]               = { cmd_nop, HD_CFA_OK },
     [WIN_PACKETCMD]               = { cmd_packet, CD_OK },
     [WIN_PIDENTIFY]               = { cmd_identify_packet, CD_OK },
@@ -2046,7 +2048,8 @@ static const struct {
     [CFA_ERASE_SECTORS]           = { cmd_cfa_erase_sectors, CFA_OK | SET_DSC },
     [WIN_MULTREAD]                = { cmd_read_multiple, HD_CFA_OK },
     [WIN_MULTWRITE]               = { cmd_write_multiple, HD_CFA_OK },
-    [WIN_SETMULT]                 = { cmd_set_multiple_mode, HD_CFA_OK | SET_DSC },
+    [WIN_SETMULT]                 = { cmd_set_multiple_mode, HD_CFA_OK |
+                                      SET_DSC },
     [WIN_READDMA]                 = { cmd_read_dma, HD_CFA_OK },
     [WIN_READDMA_ONCE]            = { cmd_read_dma, HD_CFA_OK },
     [WIN_WRITEDMA]                = { cmd_write_dma, HD_CFA_OK },
@@ -2056,15 +2059,19 @@ static const struct {
     [WIN_IDLEIMMEDIATE]           = { cmd_nop, HD_CFA_OK },
     [WIN_STANDBY]                 = { cmd_nop, HD_CFA_OK },
     [WIN_SETIDLE1]                = { cmd_nop, HD_CFA_OK },
-    [WIN_CHECKPOWERMODE1]         = { cmd_check_power_mode, HD_CFA_OK | SET_DSC },
+    [WIN_CHECKPOWERMODE1]         = { cmd_check_power_mode, HD_CFA_OK |
+                                      SET_DSC },
     [WIN_SLEEPNOW1]               = { cmd_nop, HD_CFA_OK },
     [WIN_FLUSH_CACHE]             = { cmd_flush_cache, ALL_OK },
     [WIN_FLUSH_CACHE_EXT]         = { cmd_flush_cache, HD_CFA_OK },
     [WIN_IDENTIFY]                = { cmd_identify, ALL_OK },
     [WIN_SETFEATURES]             = { cmd_set_features, ALL_OK | SET_DSC },
-    [IBM_SENSE_CONDITION]         = { cmd_ibm_sense_condition, CFA_OK | SET_DSC },
-    [CFA_WEAR_LEVEL]              = { cmd_cfa_erase_sectors, HD_CFA_OK | SET_DSC },
-    [WIN_READ_NATIVE_MAX]         = { cmd_read_native_max, HD_CFA_OK | SET_DSC },
+    [IBM_SENSE_CONDITION]         = { cmd_ibm_sense_condition, CFA_OK |
+                                      SET_DSC },
+    [CFA_WEAR_LEVEL]              = { cmd_cfa_erase_sectors, HD_CFA_OK |
+                                      SET_DSC },
+    [WIN_READ_NATIVE_MAX]         = { cmd_read_native_max, HD_CFA_OK |
+                                      SET_DSC },
 };
 
 static bool ide_cmd_permitted(IDEState *s, uint32_t cmd)
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index b402a93636..2b154d0344 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -75,7 +75,8 @@ static void bmdma_write(void *opaque, hwaddr addr,
         bmdma_cmd_writeb(bm, val);
         break;
     case 2:
-        bm->status = (val & 0x60) | (bm->status & 1) | (bm->status & ~val & 0x06);
+        bm->status = (val & 0x60) | (bm->status & 1) |
+                     (bm->status & ~val & 0x06);
         break;
     }
 }
diff --git a/hw/ide/via.c b/hw/ide/via.c
index be09912b33..694d5e55a2 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -74,7 +74,8 @@ static void bmdma_write(void *opaque, hwaddr addr,
         bmdma_cmd_writeb(bm, val);
         break;
     case 2:
-        bm->status = (val & 0x60) | (bm->status & 1) | (bm->status & ~val & 0x06);
+        bm->status = (val & 0x60) | (bm->status & 1) |
+                     (bm->status & ~val & 0x06);
         break;
     default:;
     }
-- 
2.23.0


