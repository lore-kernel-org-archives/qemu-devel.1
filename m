Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521A6C3A5A6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 03:04:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA15222CE9
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 03:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+jXebON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA15222CE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4GA8-0000ZO-5N
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 23:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4Fzt-0007jk-3K
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4Fzq-0006kG-CB
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:44 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39895)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i4Fzp-0006hj-FQ; Sat, 31 Aug 2019 22:53:42 -0400
Received: by mail-pg1-x543.google.com with SMTP id u17so5487271pgi.6;
 Sat, 31 Aug 2019 19:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=GthrvH1LkVdcK8KBj7aYI0/CcEbUQ3ynDxDO/AyoHIc=;
 b=V+jXebONHtjYrl9UXbLTu+dO/bO/oLqk66LUc2bKXM1dG3+GFhEGLNPkAFDE6pt863
 UrE4cqIC3/WqMqGzldQILPeP/KmxOCH56o2kKHcZflJg12GaVyZ2z0l4S8yA5VPX5ghp
 aHNO5UhXu66+hg8RoEJX8jMo8nyRKuWNcf1oAgCv3M7g/JTdxdZuY8gWATIONiU7mEpK
 TT4aqc3rkZG5UKahDBO6sYQ9cBgqm98hAHRqAVvDebrISLXuCLdTEsB8pfUxT4IOI6bL
 Fec1qmxk3bQKt+sDJ+mpgSlbEtB+xiIiPTp++RpwXruhgJ4Rkhkm5voQnQAcTopBk3Cz
 Pptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=GthrvH1LkVdcK8KBj7aYI0/CcEbUQ3ynDxDO/AyoHIc=;
 b=dU4vPuzcNUiizF4wCHrVOwyLDEvlYR1PNP2tuOMsgwJJYOviD1Rpi6/YWPHcCX8PZ8
 de+d1cchceFQ6Svek526gDrYzBZwyTT6IgsuD4GC/ds/x5Twb9Nd37/M7KnLikVHhZF7
 0pviz+Uu6/FprrtZUV0P7Qo10Y3DgjKk8yoyb6/kON6jxL73NNk7Mk8RBckVC1C0p3/4
 T2YExXQxzS9r+LoDllpByg1ggy7kCWjHyXTuyQ6Bk59gmMO+h8j8y03TTUV+F9GBdskg
 2Zenh8tfWcTyilLzBq9PJvRmmQUpKhhCLdmEDzryVh5xC+51H1lTBBwOPvlQaN7E0XGk
 YhvA==
X-Gm-Message-State: APjAAAWiU6u6otryeJa6baxubaUqGGvfjfluC03tSeFW2essq2h9/hKI
 imPh19FOLpsm+PbLPm4PsTg=
X-Google-Smtp-Source: APXvYqxfHIwy9bnviPMbV/MfC1INR3qMrRMnSbUKTpmOAMapQgHO5lGdF/CPQgwoet89mIKOYyPlEg==
X-Received: by 2002:a17:90a:1a1a:: with SMTP id
 26mr6602971pjk.118.1567306420653; 
 Sat, 31 Aug 2019 19:53:40 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id p10sm11453307pff.132.2019.08.31.19.53.39
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sat, 31 Aug 2019 19:53:40 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sat, 31 Aug 2019 19:53:01 -0700
Message-Id: <1567306391-2682-21-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
References: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v7 20/30] riscv: sifive_u: Generate hfclk and
 rtcclk nodes
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To keep in sync with Linux kernel device tree, generate hfclk and
rtcclk nodes in the device tree, to be referenced by PRCI node.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c         | 23 +++++++++++++++++++++++
 include/hw/riscv/sifive_u.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 24ae3d1..f048806 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -79,6 +79,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     char ethclk_names[] = "pclk\0hclk\0tx_clk";
     uint32_t plic_phandle, ethclk_phandle, phandle = 1;
     uint32_t uartclk_phandle;
+    uint32_t hfclk_phandle, rtcclk_phandle;
 
     fdt = s->fdt = create_device_tree(&s->fdt_size);
     if (!fdt) {
@@ -97,6 +98,28 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
 
+    hfclk_phandle = phandle++;
+    nodename = g_strdup_printf("/hfclk");
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cell(fdt, nodename, "phandle", hfclk_phandle);
+    qemu_fdt_setprop_string(fdt, nodename, "clock-output-names", "hfclk");
+    qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
+        SIFIVE_U_HFCLK_FREQ);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "fixed-clock");
+    qemu_fdt_setprop_cell(fdt, nodename, "#clock-cells", 0x0);
+    g_free(nodename);
+
+    rtcclk_phandle = phandle++;
+    nodename = g_strdup_printf("/rtcclk");
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cell(fdt, nodename, "phandle", rtcclk_phandle);
+    qemu_fdt_setprop_string(fdt, nodename, "clock-output-names", "rtcclk");
+    qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
+        SIFIVE_U_RTCCLK_FREQ);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "fixed-clock");
+    qemu_fdt_setprop_cell(fdt, nodename, "#clock-cells", 0x0);
+    g_free(nodename);
+
     nodename = g_strdup_printf("/memory@%lx",
         (long)memmap[SIFIVE_U_DRAM].base);
     qemu_fdt_add_subnode(fdt, nodename);
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 7a1a4f3..debbf28 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -68,6 +68,8 @@ enum {
 
 enum {
     SIFIVE_U_CLOCK_FREQ = 1000000000,
+    SIFIVE_U_HFCLK_FREQ = 33333333,
+    SIFIVE_U_RTCCLK_FREQ = 1000000,
     SIFIVE_U_GEM_CLOCK_FREQ = 125000000
 };
 
-- 
2.7.4


