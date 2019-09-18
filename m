Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F2CC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A53208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A53208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAcVf-0004Ub-BR
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 12:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsu-0007pg-Ci
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iAbss-0007Al-Ix
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:48 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:37117)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iAbss-0007AO-D1
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:46 -0400
Received: by mail-pg1-f174.google.com with SMTP id c17so52305pgg.4
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=A0+zXxPdr5loQEL2NqQ0gmpNNo8KWnLwDfjW695HhGs=;
 b=jiJy+BaobLFXJn+nYo4UCZ+EljwM0CDleTLQZcSr5bE58PP7HnRUGdiCZ0kaPrDZNe
 c+k2kaOn2Ygl3mh//QlBDER+M3FoJPXNh2ABg19zwELJYmPYLyHjxAFf4QvMAFmNZMpw
 eqNkKamLQ1QQ3v+x/Qlj+YgUEsRD1S/aozFLVX6pxIZmUf2kaDKrpbeKbiY5OtOeL9E+
 mzB+DriPw46D/TOjYl2Jt4no3MQzqxDHjX5wBZL7LjLC5GD2IGdltSekpPcufxY9Vy4A
 7ON7QQsXSlqbZe0jwmE/p0WylOmMI3i+v7Ly1BS+keHLnkwAEPMjUjnDg1o7voTROpAO
 sPBA==
X-Gm-Message-State: APjAAAWQiiSECr4c8bvhU0+6EV6kZC0mZHzrmlB5tbpCUgvwWLT0OKno
 2LQ27jcM+TcNIcuPG2vs1TiHdOs9tL8=
X-Google-Smtp-Source: APXvYqzLQuRvTa2Ik5Ml+MYI/sUEehJSzKLYWl3dRE1CgkVMAoD5RCA0XVfl0Gqiutnyvq9wbX+Fog==
X-Received: by 2002:a17:90a:ba93:: with SMTP id
 t19mr4171619pjr.141.1568820525197; 
 Wed, 18 Sep 2019 08:28:45 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id k5sm5630426pgo.45.2019.09.18.08.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 08:28:44 -0700 (PDT)
Date: Wed, 18 Sep 2019 07:56:35 -0700
Message-Id: <20190918145640.17349-44-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918145640.17349-1-palmer@sifive.com>
References: <20190918145640.17349-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.174
Subject: [Qemu-devel] [PULL 43/48] riscv: sifive_u: Remove handcrafted clock
 nodes for UART and ethernet
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

In the past we did not have a model for PRCI, hence two handcrafted
clock nodes ("/soc/ethclk" and "/soc/uartclk") were created for the
purpose of supplying hard-coded clock frequencies. But now since we
have added the PRCI support in QEMU, we don't need them any more.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_u.c         | 24 +-----------------------
 include/hw/riscv/sifive_u.h |  3 +--
 2 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 7c07452a57..444c699f49 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -87,8 +87,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     uint32_t *cells;
     char *nodename;
     char ethclk_names[] = "pclk\0hclk";
-    uint32_t plic_phandle, prci_phandle, ethclk_phandle, phandle = 1;
-    uint32_t uartclk_phandle;
+    uint32_t plic_phandle, prci_phandle, phandle = 1;
     uint32_t hfclk_phandle, rtcclk_phandle, phy_phandle;
 
     fdt = s->fdt = create_device_tree(&s->fdt_size);
@@ -248,17 +247,6 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
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
index 5270851aa2..e4df298c23 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -77,8 +77,7 @@ enum {
 enum {
     SIFIVE_U_CLOCK_FREQ = 1000000000,
     SIFIVE_U_HFCLK_FREQ = 33333333,
-    SIFIVE_U_RTCCLK_FREQ = 1000000,
-    SIFIVE_U_GEM_CLOCK_FREQ = 125000000
+    SIFIVE_U_RTCCLK_FREQ = 1000000
 };
 
 #define SIFIVE_U_MANAGEMENT_CPU_COUNT   1
-- 
2.21.0


