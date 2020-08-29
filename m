Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF68C433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:23:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24FA820707
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7Ig8tyD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24FA820707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC2hF-000123-Ar
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 11:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kC2d5-0001Hd-SM; Sat, 29 Aug 2020 11:18:56 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:32862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kC2d4-0005EL-4A; Sat, 29 Aug 2020 11:18:55 -0400
Received: by mail-ot1-x342.google.com with SMTP id t7so1819697otp.0;
 Sat, 29 Aug 2020 08:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Ij4Fa5djbJIx/Myvpw/aDERYC9Ay8jdmYeDXjuiJA28=;
 b=C7Ig8tyD6UItRRKFw1lbBgqf+wXkj4pVryyVnqyQDXiW+VCxNEygzFU62lJHABEIjA
 b20s7hzjRNYdthDWuMbq5lngPt/xbuT/73gBEk5LaTI7lniYkHwy1dMH1sFZbfMqyLWP
 BbIxnemECfu1WRHs4xzauPKQ9880rjT/GQoRAOJbQuf5a9rlagKbUr9gv59/aj80CTgf
 dcIZLuJoiMaB90XtjwunGUXmcZwPG2UkOBC5KD8qQquPZdmHZAZzVleFRN0KFIyQoSl/
 mp1NOwAmsMFcRlNKJYbUM3XJtDTc+8a87a1g1uJwjVpZo3rZK/mTdpLnCKM1fjh4I4WG
 lN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Ij4Fa5djbJIx/Myvpw/aDERYC9Ay8jdmYeDXjuiJA28=;
 b=EvdNyqriH1+h/Z2c1zJFG3AapjtCFtbc1buCEFYjoAfnRW39G45fK2PZcRY6llktP0
 661HzajfEPnBuPnosWzeDE03PiP4+MugAzG1C0KpJvn9FKCTABZjfcyN5T9Z6UM8P/KJ
 G/2q2nZL8RgYCWJ9Y553e0DUFQK0qMQk7gaCJ/umSYOBLQOeI/w29fQMLEHO5wiAOlNh
 X9Ym8k7jYp3/lrff1xamaJ1DwoEXv+VqmYjJztoHYd4xTQmCNfg6BVZzKDBYjaM6DBZ8
 hJbZgYPQgsb6BxLJ4yzMWKYf8Y7NEyXGFOb9pwc7kaCb1iVwfQszMsOcCsANlq6evKdF
 zQFQ==
X-Gm-Message-State: AOAM532VEqLQSBJRPWW9cyJ1fb1L9PdAGVAY60Eza4tANkViC472uKOo
 8kUi4TNkel347xiQ/7ZrUc/dirxt528=
X-Google-Smtp-Source: ABdhPJxO7JnGywZSleA7Og55l7T4KD9D1TclrG891Fd45zIu/+mIdxbM38iI626tvV1/2JOtnxJ7Mw==
X-Received: by 2002:a9d:734a:: with SMTP id l10mr2346965otk.240.1598714331283; 
 Sat, 29 Aug 2020 08:18:51 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id f50sm58181otf.47.2020.08.29.08.18.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Aug 2020 08:18:50 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 12/16] hw/arm: xlnx: Set all boards' GEM 'phy-addr'
 property value to 23
Date: Sat, 29 Aug 2020 23:17:36 +0800
Message-Id: <1598714261-8320-13-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598714261-8320-1-git-send-email-bmeng.cn@gmail.com>
References: <1598714261-8320-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=bmeng.cn@gmail.com; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Jason Wang <jasowang@redhat.com>,
 Bin Meng <bin.meng@windriver.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
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
---

(no changes since v1)

 hw/arm/xilinx_zynq.c | 1 +
 hw/arm/xlnx-versal.c | 1 +
 hw/arm/xlnx-zynqmp.c | 1 +
 hw/net/cadence_gem.c | 6 +++---
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 969ef07..9ffcc56 100644
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
index e3aa4bd..12ba6c4 100644
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
index c435b9d..a85ef4b 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -460,6 +460,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         }
         object_property_set_int(OBJECT(&s->gem[i]), "revision", GEM_REVISION,
                                 &error_abort);
+        object_property_set_int(OBJECT(dev), "phy-addr", 23, &error_abort);
         object_property_set_int(OBJECT(&s->gem[i]), "num-priority-queues", 2,
                                 &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->gem[i]), errp)) {
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index d80096b..7a53469 100644
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
2.7.4


