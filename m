Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D16C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:24:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9144D2076C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KhOpxxYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9144D2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRFJ-00017q-Hy
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBf-0004EX-03
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:47 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBc-0002kZ-5u
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599762043; x=1631298043;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HEhP4NQKlH459kbrtN12X8mfdwJiWZXFQOkseP2wUNU=;
 b=KhOpxxYHqL5aZcdg9wovqEqe8JdM9pSj/wjU3uVcFON041YfNBBaYP2J
 GgerjdZJdfCs2lBdVUYYhSnXtNHpAijO4Q67nsO2N9QItQd2AoKnMhw13
 CKXBozSleBA2pJRbn7ALTX0GJjV4YPrv8GfG4KOwnlfiW5EKULU9hbvqW
 6deDxvkIQ5+X6g1cXdTBmWKy4K1vH7POLKZutKZey3PuqJO41HZYDD7gX
 ytrOgE4O/Z1hJZd+OBVnGVjoIxaOXSO44o4Xgj5AHxdz4wnz+A9kBDhmg
 hl5LwpDtPXaivZ3/rdyM8+07XwFFKSBf7kqFhspd0D/syUAnguaeqHLVN Q==;
IronPort-SDR: pfyWzbDGXF0dnMUE2t6EY7Iv9FYNfRTGtGzm7CuXuhKbCR2cL0FrRRA7MBbNEgZIgKADczBcx5
 SeS9wOn0thk0I/Rh8ukv9j/rwpePTLQ1w1KM/CXspOBWuTRJVCEouabW5Nov5swwyfZdnKUNMz
 B5thDkgMNjhSa0Vt5Wx/d6esVXRaskgJh+auOx/0c3d1Twg+v0El28FEL6cfZQajF1j2EAIyYG
 KYaI/svbmPm93HEohpcg9gr6eix5h8YuvENsbInEBLi6YYZGNNWev99VqnYjljLeDX/oLpcn+t
 rc4=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146979233"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 02:20:18 +0800
IronPort-SDR: bN5ppWGHZuJCNjM+fJomnP+Mdgw33iibDosZNrVUOTd74BVBtws8vwn8CGSG4v0Om5SVyyzIBU
 x85Wva9kTy6A==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 11:07:35 -0700
IronPort-SDR: f4tmIlyjgYbCFMyZ5c5OiP1rv4UCi25mBy4HTqPbqUaUIizxThQ+Mzc2RYyJKpmjNgi8cWI5y+
 YpjkUAfHXt6w==
WDCIronportException: Internal
Received: from fwvkpc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.152])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 11:20:18 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 14/30] hw/arm: xlnx: Set all boards' GEM 'phy-addr' property
 value to 23
Date: Thu, 10 Sep 2020 11:09:22 -0700
Message-Id: <20200910180938.584205-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910180938.584205-1-alistair.francis@wdc.com>
References: <20200910180938.584205-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=515d47f05=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 14:20:04
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

When cadence_gem model was created for Xilinx boards, the PHY address
was hard-coded to 23 in the GEM model. Now that we have introduced a
property we can use that to tell GEM model what our PHY address is.
Change all boards' GEM 'phy-addr' property value to 23, and set the
PHY address default value to 0 in the GEM model.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1598924352-89526-13-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/arm/xilinx_zynq.c | 1 +
 hw/arm/xlnx-versal.c | 1 +
 hw/arm/xlnx-zynqmp.c | 2 ++
 hw/net/cadence_gem.c | 6 +++---
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 969ef0727c..9ffcc5606f 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -119,6 +119,7 @@ static void gem_init(NICInfo *nd, uint32_t base, qemu_irq irq)
         qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
         qdev_set_nic_properties(dev, nd);
     }
+    object_property_set_int(OBJECT(dev), "phy-addr", 23, &error_abort);
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
     sysbus_mmio_map(s, 0, base);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index e3aa4bd1e5..12ba6c4eba 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -165,6 +165,7 @@ static void versal_create_gems(Versal *s, qemu_irq *pic)
             qemu_check_nic_model(nd, "cadence_gem");
             qdev_set_nic_properties(dev, nd);
         }
+        object_property_set_int(OBJECT(dev), "phy-addr", 23, &error_abort);
         object_property_set_int(OBJECT(dev), "num-priority-queues", 2,
                                 &error_abort);
         object_property_set_link(OBJECT(dev), "dma", OBJECT(&s->mr_ps),
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index c435b9d52a..7885bb1774 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -460,6 +460,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         }
         object_property_set_int(OBJECT(&s->gem[i]), "revision", GEM_REVISION,
                                 &error_abort);
+        object_property_set_int(OBJECT(&s->gem[i]), "phy-addr", 23,
+                                &error_abort);
         object_property_set_int(OBJECT(&s->gem[i]), "num-priority-queues", 2,
                                 &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->gem[i]), errp)) {
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index d80096bbe8..7a534691f1 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -250,7 +250,7 @@
 #define GEM_PHYMNTNC_REG_SHIFT 18
 
 /* Marvell PHY definitions */
-#define BOARD_PHY_ADDRESS    23 /* PHY address we will emulate a device at */
+#define BOARD_PHY_ADDRESS    0 /* PHY address we will emulate a device at */
 
 #define PHY_REG_CONTROL      0
 #define PHY_REG_STATUS       1
@@ -1446,7 +1446,7 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
             uint32_t phy_addr, reg_num;
 
             phy_addr = (retval & GEM_PHYMNTNC_ADDR) >> GEM_PHYMNTNC_ADDR_SHFT;
-            if (phy_addr == s->phy_addr || phy_addr == 0) {
+            if (phy_addr == s->phy_addr) {
                 reg_num = (retval & GEM_PHYMNTNC_REG) >> GEM_PHYMNTNC_REG_SHIFT;
                 retval &= 0xFFFF0000;
                 retval |= gem_phy_read(s, reg_num);
@@ -1569,7 +1569,7 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
             uint32_t phy_addr, reg_num;
 
             phy_addr = (val & GEM_PHYMNTNC_ADDR) >> GEM_PHYMNTNC_ADDR_SHFT;
-            if (phy_addr == s->phy_addr || phy_addr == 0) {
+            if (phy_addr == s->phy_addr) {
                 reg_num = (val & GEM_PHYMNTNC_REG) >> GEM_PHYMNTNC_REG_SHIFT;
                 gem_phy_write(s, reg_num, val);
             }
-- 
2.28.0


