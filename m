Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF62C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:31:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D482087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L04HoHmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D482087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzaGk-0003M9-Pe
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 01:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZyB-0005OT-Ty
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZyA-0000D2-J1
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:39 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34911)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hzZyA-00005a-BR; Mon, 19 Aug 2019 01:12:38 -0400
Received: by mail-pf1-x443.google.com with SMTP id d85so462274pfd.2;
 Sun, 18 Aug 2019 22:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=COq3i+BYAm3tcWjD86Rc5auZBv3Y+a94JftSmzO59nA=;
 b=L04HoHmIAqZApVvYSnIpyHcUGchjpQ7IZXLvrYl/SHL7RHEqjRmAYLqsI3Q88Ilzpd
 dqqRkQKZDuTawiYa1oxUHnLL0g7Pmts/g2i0rZGhQ1/OCcHik1VU4ndoxN0bomE31uke
 Emck+M+sZ5vOz+TiLpjryGq8BbgLv7sqbAFNB07uEBbj4pjVP5TnkKjbU7yp2ThylLmc
 nwaCkkjvWE9i1gDRLMxZ19D1yxzsulVkgfpjzzj40DM8USx9GlV0legaOIwKioOf7Flu
 xlEPEbIU1xgWwwe8Sll2s92QqtBwtEbjIymRfplNsELjQhD0iQ4ErjFGT4DqxUoaQte3
 b4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=COq3i+BYAm3tcWjD86Rc5auZBv3Y+a94JftSmzO59nA=;
 b=UGUNolEBBgSkuRBO1vqCNM0yge0PWyPZmCidIJTEetqbZuwQyKt9Kv2qkILohBvITO
 rkgWkdZx5aoZ6Da5Xkpxmvc6in9RJcyCPki3mLu+xPky+gHj4etVJmulIrGZMgajVVpL
 AYgvRPAm5u0OBmWOVVnXjyXDFUi3qpHe8Wj2ZLNcEZupmeWOJcx8XhvJhxgygK/iHX5R
 JpLyjIpZiwqiysFspTG8K8yhpFzvVV6HdHTMiV3VKI2qiu9t3tb0qJ3NZ+o3Xt+t2Npo
 DqWRWrnIUMEQcVUut7ijWa8i9xKfT+sBSNpxknk1O4fLFeJTNLpZ+CfCvZXytnUDCOU7
 EHVQ==
X-Gm-Message-State: APjAAAUPZNFrCGfhosRCkkIpH7SF0OjuDsplfYqm75NF6Rm01+vEiQjk
 PLdzs045fxSqFOTibok/rbc=
X-Google-Smtp-Source: APXvYqyazmAz6Y3tWzz14TWGZZL8MSnVA1asmCklf2vtPSJXKg6//Y9azQRLmn+8EP3b5ETjoGwhyA==
X-Received: by 2002:a17:90a:8081:: with SMTP id
 c1mr19322982pjn.62.1566191556561; 
 Sun, 18 Aug 2019 22:12:36 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id q13sm15464986pfl.124.2019.08.18.22.12.35
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 18 Aug 2019 22:12:36 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 18 Aug 2019 22:12:00 -0700
Message-Id: <1566191521-7820-28-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
References: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v4 27/28] riscv: sifive_u: Remove handcrafted
 clock nodes for UART and ethernet
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

In the past we did not have a model for PRCI, hence two handcrafted
clock nodes ("/soc/ethclk" and "/soc/uartclk") were created for the
purpose of supplying hard-coded clock frequencies. But now since we
have added the PRCI support in QEMU, we don't need them any more.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

---

Changes in v4:
- new patch to remove handcrafted clock nodes for UART and ethernet

Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c         | 24 +-----------------------
 include/hw/riscv/sifive_u.h |  3 +--
 2 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 7a370e9..7d9fb3a 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -89,8 +89,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     uint32_t *cells;
     char *nodename;
     char ethclk_names[] = "pclk\0hclk";
-    uint32_t plic_phandle, prci_phandle, ethclk_phandle, phandle = 1;
-    uint32_t uartclk_phandle;
+    uint32_t plic_phandle, prci_phandle, phandle = 1;
     uint32_t hfclk_phandle, rtcclk_phandle, phy_phandle;
 
     fdt = s->fdt = create_device_tree(&s->fdt_size);
@@ -250,17 +249,6 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     g_free(cells);
     g_free(nodename);
 
-    ethclk_phandle = phandle++;
-    nodename = g_strdup_printf("/soc/ethclk");
-    qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_string(fdt, nodename, "compatible", "fixed-clock");
-    qemu_fdt_setprop_cell(fdt, nodename, "#clock-cells", 0x0);
-    qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
-        SIFIVE_U_GEM_CLOCK_FREQ);
-    qemu_fdt_setprop_cell(fdt, nodename, "phandle", ethclk_phandle);
-    ethclk_phandle = qemu_fdt_get_phandle(fdt, nodename);
-    g_free(nodename);
-
     phy_phandle = phandle++;
     nodename = g_strdup_printf("/soc/ethernet@%lx",
         (long)memmap[SIFIVE_U_GEM].base);
@@ -292,16 +280,6 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, nodename, "reg", 0x0);
     g_free(nodename);
 
-    uartclk_phandle = phandle++;
-    nodename = g_strdup_printf("/soc/uartclk");
-    qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_string(fdt, nodename, "compatible", "fixed-clock");
-    qemu_fdt_setprop_cell(fdt, nodename, "#clock-cells", 0x0);
-    qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency", 3686400);
-    qemu_fdt_setprop_cell(fdt, nodename, "phandle", uartclk_phandle);
-    uartclk_phandle = qemu_fdt_get_phandle(fdt, nodename);
-    g_free(nodename);
-
     nodename = g_strdup_printf("/soc/serial@%lx",
         (long)memmap[SIFIVE_U_UART0].base);
     qemu_fdt_add_subnode(fdt, nodename);
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index cba29e1..8880f9c 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -72,8 +72,7 @@ enum {
 enum {
     SIFIVE_U_CLOCK_FREQ = 1000000000,
     SIFIVE_U_HFCLK_FREQ = 33333333,
-    SIFIVE_U_RTCCLK_FREQ = 1000000,
-    SIFIVE_U_GEM_CLOCK_FREQ = 125000000
+    SIFIVE_U_RTCCLK_FREQ = 1000000
 };
 
 #define SIFIVE_U_MANAGEMENT_CPU_COUNT   1
-- 
2.7.4


