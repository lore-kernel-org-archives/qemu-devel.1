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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264FDC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:02:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E67F620828
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tC3Ikvo+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67F620828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2czL-0005St-Pc
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 11:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i2cvo-00039U-WE
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:58:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i2cvn-0003K4-Ji
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:58:48 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39112)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i2cvn-0003J4-Dd; Tue, 27 Aug 2019 10:58:47 -0400
Received: by mail-pf1-x444.google.com with SMTP id y200so6603619pfb.6;
 Tue, 27 Aug 2019 07:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=mpyu+9zeR5NQecSQEyPIQD+gt/2HHvJQuLsDykgSNvo=;
 b=tC3Ikvo+TYfryayx3R86IT1tjNyF+wZn6nEAJ8mWcLu/MhDlUKpZh59w8QDM3+y3LZ
 x9BSS7n5oZIn4my20ccNywVK+5M0EKodD4CpKM3KyrRVw0Ngg1MPe6nYza9ine+Zpbpv
 IPnR8d5fiJrKSSfadoore5+vyvxyzIrtlS1uAEopT/cDcxx2ARRTZzyHe1b7zYfvqMfL
 FQffT7ldhTMyMbubPoSRscvT26t4Rc3zQt1Mr314DxOQd9oCeD3m3EvY06cNtEavkPas
 f1UQzw/UMLYbeFd3rmljGbl6zlqOWOvuDagqElWTYbxdA+Qh1mRiKLMbk4yj+K/dNoQA
 S/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=mpyu+9zeR5NQecSQEyPIQD+gt/2HHvJQuLsDykgSNvo=;
 b=GS005xnhDkRqmmopsM+L/SqzfaDy25nQh9sm4RLzZMuGRIlnGi06AXuk4P0OzR+jdM
 9Pn3WUZcOJQTh+kJeSNKAVSd+HcuSUVFybseB3zGXW/V4kTW3/uyA3ULdZbqqmxpowgK
 aZkxvySfyRpq3SsMX6d/HNl3A7mIFElx1pzc25z8J2b0FrAynjhvw8GTk5aZnEvu5Omh
 6dXBLLrUBcfE3Ee5PaAgTLMmipEmkmYCGHw5r4hIx0Y4dJfC8wzr9HPet0J920O2sEZ+
 lfxoZwNf/VQO5+Z/UIANUo08Q005nn7eb2WcGtP/skf6tWjOLrJXyW3r7daXVyXusNTS
 aLVw==
X-Gm-Message-State: APjAAAV5tI7OmGjiQ7+O478WeGdHTghS+aZYiY15Fntpk7xThb+K8ebn
 6dvwlC+0Ek7pokpSQfcpERQ=
X-Google-Smtp-Source: APXvYqwiAm91cMUBHNzoR/2vxP4ubMvTkxkJnuNPigxyDdlst8TKIz5llSgQAsfMo+EOXUbUN0Asxw==
X-Received: by 2002:a65:68c9:: with SMTP id k9mr20449300pgt.28.1566917926098; 
 Tue, 27 Aug 2019 07:58:46 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id j15sm14839344pfr.146.2019.08.27.07.58.45
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Tue, 27 Aug 2019 07:58:45 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Tue, 27 Aug 2019 07:58:10 -0700
Message-Id: <1566917919-25381-2-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566917919-25381-1-git-send-email-bmeng.cn@gmail.com>
References: <1566917919-25381-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v6 01/30] riscv: hw: Remove superfluous "linux,
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
sifive_u, virt and spike machine device trees.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v6: None
Changes in v5: None
Changes in v4:
- remove 2 more "linux,phandle" instances in sifive_u.c and spike.c
  after rebasing on Palmer's QEMU RISC-V tree

Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c | 4 ----
 hw/riscv/spike.c    | 1 -
 hw/riscv/virt.c     | 3 ---
 3 files changed, 8 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 64e233d..afe304f 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -126,7 +126,6 @@ static void *create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         qemu_fdt_setprop_string(fdt, nodename, "device_type", "cpu");
         qemu_fdt_add_subnode(fdt, intc);
         qemu_fdt_setprop_cell(fdt, intc, "phandle", cpu_phandle);
-        qemu_fdt_setprop_cell(fdt, intc, "linux,phandle", cpu_phandle);
         qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
         qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
         qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
@@ -185,7 +184,6 @@ static void *create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, nodename, "riscv,max-priority", 7);
     qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", 0x35);
     qemu_fdt_setprop_cells(fdt, nodename, "phandle", plic_phandle);
-    qemu_fdt_setprop_cells(fdt, nodename, "linux,phandle", plic_phandle);
     plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
     g_free(cells);
     g_free(nodename);
@@ -198,7 +196,6 @@ static void *create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
         SIFIVE_U_GEM_CLOCK_FREQ);
     qemu_fdt_setprop_cell(fdt, nodename, "phandle", ethclk_phandle);
-    qemu_fdt_setprop_cell(fdt, nodename, "linux,phandle", ethclk_phandle);
     ethclk_phandle = qemu_fdt_get_phandle(fdt, nodename);
     g_free(nodename);
 
@@ -234,7 +231,6 @@ static void *create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, nodename, "#clock-cells", 0x0);
     qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency", 3686400);
     qemu_fdt_setprop_cell(fdt, nodename, "phandle", uartclk_phandle);
-    qemu_fdt_setprop_cell(fdt, nodename, "linux,phandle", uartclk_phandle);
     uartclk_phandle = qemu_fdt_get_phandle(fdt, nodename);
     g_free(nodename);
 
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 2991b34..14acaef 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -112,7 +112,6 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
         qemu_fdt_setprop_string(fdt, nodename, "device_type", "cpu");
         qemu_fdt_add_subnode(fdt, intc);
         qemu_fdt_setprop_cell(fdt, intc, "phandle", 1);
-        qemu_fdt_setprop_cell(fdt, intc, "linux,phandle", 1);
         qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
         qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
         qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
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


