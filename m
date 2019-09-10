Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4EEECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:02:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 619C6222C1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619C6222C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7yVp-0006au-7E
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 05:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7xwK-0008Kd-KE
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7xwJ-0006pM-4o
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37714)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7xwI-0006oe-UR
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:25:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id r195so2395225wme.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 01:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=Vf8orQoCr70Vddp/7MqIPffmdMREbqhw90IvJdtFKJA=;
 b=eRlfcDN1OXp7Bu6F+lvIuLzJa/u1Uq3F6K7adq1pH4FH5LglVwH2Vmo0/BLRX5P/pn
 J3nvPaeoAo2P5VUYkoSuHSrOa8Ucppqflb5jDXFflENOFZcx6BqlykapovNYrNU/GXnY
 IDPrJbfS/yrb3zi62PMo3cHbvf/N/SmcpiOPZRQ4nlgrEKpo4iAxui5HOC1w9SIxJF+b
 ChuIhSDyPgz3/eO8uGAikeFfcZ+IFjPvS84tuA3EaSLZm/hIE88yWUCILs62XaXuANDP
 dX6C/jzEezSBf9RTbh9QnbBymF/jMV25y9s0JG2RZanjoIOiU6qmWPDBoNw4PkovrYqN
 fEOA==
X-Gm-Message-State: APjAAAUEMZRXoDFPhT6zuAHne2wPsSWO+xyXL3r2i0CjBEGeG18FB34Z
 aIEW74Q3pG9tDOQWDk1grDcKpqUwJ4CBbw==
X-Google-Smtp-Source: APXvYqywT0F9dtlj/JhI/gKN0VtHoGocKhojWd3EU2k2mtIzRhS4Iyq1eWGZ6hUG6AiGQ+GMb3TziQ==
X-Received: by 2002:a7b:ca50:: with SMTP id m16mr2684119wml.158.1568190321785; 
 Wed, 11 Sep 2019 01:25:21 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id v6sm3683422wma.24.2019.09.11.01.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 01:25:21 -0700 (PDT)
Date: Tue, 10 Sep 2019 12:05:00 -0700
Message-Id: <20190910190513.21160-35-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910190513.21160-1-palmer@sifive.com>
References: <20190910190513.21160-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: [Qemu-devel] [PULL 34/47] riscv: sifive_u: Generate hfclk and
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

To keep in sync with Linux kernel device tree, generate hfclk and
rtcclk nodes in the device tree, to be referenced by PRCI node.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_u.c         | 23 +++++++++++++++++++++++
 include/hw/riscv/sifive_u.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 713c451e85..3ee6fcbd12 100644
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
index 6b2b5b68e2..24418145aa 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -69,6 +69,8 @@ enum {
 
 enum {
     SIFIVE_U_CLOCK_FREQ = 1000000000,
+    SIFIVE_U_HFCLK_FREQ = 33333333,
+    SIFIVE_U_RTCCLK_FREQ = 1000000,
     SIFIVE_U_GEM_CLOCK_FREQ = 125000000
 };
 
-- 
2.21.0


