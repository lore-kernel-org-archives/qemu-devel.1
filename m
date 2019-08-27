Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C0DC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:17:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45D7C214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPYJZIPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D7C214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2dE8-0004vw-Ar
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 11:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i2cwS-0003PR-6i
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:59:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i2cwP-0003pR-Vl
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:59:27 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44079)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i2cwL-0003jg-Q8; Tue, 27 Aug 2019 10:59:22 -0400
Received: by mail-pl1-x644.google.com with SMTP id t14so11904690plr.11;
 Tue, 27 Aug 2019 07:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=V2DW5myB/686B3BuCfQ3PMfCTq1gYnWsm27tMr5svLY=;
 b=XPYJZIPkDzAzX+hv7AKMuh2Q/qvMZULI+Pw0NTXuXIaezxnf+aN/3Y2+/HVOQH+RH3
 jfQJtDx3XoVPz8k0jrPd9H+h4HqpH7CMVABOVVyof2GWI9clxcAPyYOyabqFiFqYx/I8
 aZGSBRT1ZXPKz++h1KlK39itEflUUhVnSsKKz1WzkQFISck2Va74c53LgN7bV+xZKFOe
 x47rlame1RhO5DnrWq/9cV2o6SqAIcX6wQxlyc88rlGoZ7R+uyIrvLx7RfLXUlcoWku4
 7998RY5qalGKvVhOHLhLYGOmHzu65BZLppsc4pY5IV/AvvFPGNISBaipEtELxhkEkz6b
 3WfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=V2DW5myB/686B3BuCfQ3PMfCTq1gYnWsm27tMr5svLY=;
 b=czG3Mh8lXl2UPEnvonVx7yS0bsqkYeiSjgCm3aezkoPLigcBZ83r7gzsE84M6XT3L1
 2FX6MnSIioaJM43rQ6UrdT3x5Nje+JeytnKbTAzRmWvBMh5VD9PCm54QhdPXJEWCRChX
 sSP194Pelszj2vH5i4aCA7X578SZXEWnqVnDNQDvRMJCc12Fya6veAoC6rGOGOi9C4af
 e1O65UlWQHLX4dWQ9TM8DqA/devHBfm/NHVdn1iphhmeph3VkFWPU04b5/eSlMWv+YTx
 ltQSH9GZI7J/rP6nuZexyzz6fn+TBN5/8korPq4wFGA6fQy5lRyNEN6AVt+yuJ9/Xyov
 h8wg==
X-Gm-Message-State: APjAAAW37UDYw+OJldeavVbz+gBhUfCcuYZnRtUGskBPGE1t/KtRlTLo
 e4g6LzfWuvkxZ/+/z8jt2ms=
X-Google-Smtp-Source: APXvYqzv5NzAfFDEWN6xAxrc8woW0dD3g9iSENyIb5/17tOgJBEnKkyJKgGv+ulLgeySH0hmecwOcw==
X-Received: by 2002:a17:902:8302:: with SMTP id
 bd2mr24226159plb.9.1566917948229; 
 Tue, 27 Aug 2019 07:59:08 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id j15sm14839344pfr.146.2019.08.27.07.59.06
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Tue, 27 Aug 2019 07:59:07 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Tue, 27 Aug 2019 07:58:29 -0700
Message-Id: <1566917919-25381-21-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566917919-25381-1-git-send-email-bmeng.cn@gmail.com>
References: <1566917919-25381-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v6 20/30] riscv: sifive_u: Generate hfclk and
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


