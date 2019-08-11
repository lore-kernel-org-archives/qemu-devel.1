Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695B5C0650F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:07:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3755D208C2
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRl4ghrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3755D208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwitP-0007An-DQ
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 04:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59989)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwisg-0005Qg-AJ
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwisf-0003oq-8R
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:10 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:39345)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hwisf-0003oL-3F; Sun, 11 Aug 2019 04:07:09 -0400
Received: by mail-pf1-x443.google.com with SMTP id f17so44250429pfn.6;
 Sun, 11 Aug 2019 01:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=3LT92N7XM1qCNmYC5QZ4lu+LlxUUbvlnPQDuotQ/kSI=;
 b=sRl4ghrlTihW1jVsm6xdOD2Eb5Mxt4gjG7ooJoq2YhfZMVFWjvkGOg5Oa8cPdTw+gt
 TDHjRVS1CH8b8kB86d1aGp490Iotw6JkD+zWinS2eGrga265g1TBz7f1qQqb8hQxZ9XN
 ZSE+ddlfxNF+wzCIGLKzMdrW3a66Xr521ceHmjECydxVp0CSM4gV/GVWIoUmys02Vx5g
 cJ9vTy263JV9FfTpg5R/zQNBVKt9ThfSY/qomIptv6UOL2sZiN97hzwBhCAYDQ8C5jEb
 QODtXccProWKdIBVoDh4Uj5f5LfYMX0Cw8i4bwCRv45Q/4uPkYUBttoeuQHXRGrs+Pyc
 R2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=3LT92N7XM1qCNmYC5QZ4lu+LlxUUbvlnPQDuotQ/kSI=;
 b=UStTWGVsVY5cKLWUaHoLBBRp9vua9aYg8tIergyEHXV1FMEUSipV4nXlMXBYT0BOae
 lfCD1hzGudnZnpAYw4mbVj4rA3yB5qSiewKKx3ky8LvQoTPkAGQF5COkf4lsSK+UZz33
 AVooqTQzAD/d82ZKftUFEebACu5JuyMMmh87d3oA6unc1E2Pe1O44Nn1cFDV9S9v0UMj
 9yubbnTJG64gPLxuDF1YJMm825hlxdaaUB9f+e8oLE/4XRSafLkwtH6Ro1sQl67wneD7
 6ONec0veBhY3hWjaEkXE2O/0yzxPXxpk+0PLmzEQ+j9wT+kqwiDb3rocR5ekp60HNGgz
 tnJA==
X-Gm-Message-State: APjAAAWZti66HGnaGA1gAJikI5C0ffZFDAcZtwcUYAt/sVQyEXIbbP4t
 LW56s+Z+yIDarPF4/wx2JAWySfXt
X-Google-Smtp-Source: APXvYqyW/GPAZkkk/dG7HJ0DKEehBJzEiXUqZP5YbiG+4Hh1TDYeSSJo/97qXPdpNi4CTf3YRiwEBg==
X-Received: by 2002:a62:144b:: with SMTP id 72mr2137603pfu.42.1565510828211;
 Sun, 11 Aug 2019 01:07:08 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v8sm87339107pgs.82.2019.08.11.01.07.07
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 11 Aug 2019 01:07:07 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 11 Aug 2019 01:06:34 -0700
Message-Id: <1565510821-3927-2-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
References: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v3 01/28] riscv: hw: Remove superfluous "linux,
 phandle" property
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

"linux,phandle" property is optional. Remove all instances in the
sifive_u and virt machine device tree.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c | 3 ---
 hw/riscv/virt.c     | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 71b8083..ef36948 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -125,7 +125,6 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         qemu_fdt_setprop_string(fdt, nodename, "device_type", "cpu");
         qemu_fdt_add_subnode(fdt, intc);
         qemu_fdt_setprop_cell(fdt, intc, "phandle", cpu_phandle);
-        qemu_fdt_setprop_cell(fdt, intc, "linux,phandle", cpu_phandle);
         qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
         qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
         qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
@@ -184,7 +183,6 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, nodename, "riscv,max-priority", 7);
     qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", 0x35);
     qemu_fdt_setprop_cells(fdt, nodename, "phandle", plic_phandle);
-    qemu_fdt_setprop_cells(fdt, nodename, "linux,phandle", plic_phandle);
     plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
     g_free(cells);
     g_free(nodename);
@@ -197,7 +195,6 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
         SIFIVE_U_GEM_CLOCK_FREQ);
     qemu_fdt_setprop_cell(fdt, nodename, "phandle", ethclk_phandle);
-    qemu_fdt_setprop_cell(fdt, nodename, "linux,phandle", ethclk_phandle);
     ethclk_phandle = qemu_fdt_get_phandle(fdt, nodename);
     g_free(nodename);
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 25faf3b..00be05a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -170,11 +170,9 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
         qemu_fdt_setprop_cell(fdt, nodename, "reg", cpu);
         qemu_fdt_setprop_string(fdt, nodename, "device_type", "cpu");
         qemu_fdt_setprop_cell(fdt, nodename, "phandle", cpu_phandle);
-        qemu_fdt_setprop_cell(fdt, nodename, "linux,phandle", cpu_phandle);
         intc_phandle = phandle++;
         qemu_fdt_add_subnode(fdt, intc);
         qemu_fdt_setprop_cell(fdt, intc, "phandle", intc_phandle);
-        qemu_fdt_setprop_cell(fdt, intc, "linux,phandle", intc_phandle);
         qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
         qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
         qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
@@ -250,7 +248,6 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, nodename, "riscv,max-priority", 7);
     qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", VIRTIO_NDEV);
     qemu_fdt_setprop_cells(fdt, nodename, "phandle", plic_phandle);
-    qemu_fdt_setprop_cells(fdt, nodename, "linux,phandle", plic_phandle);
     plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
     g_free(cells);
     g_free(nodename);
-- 
2.7.4


