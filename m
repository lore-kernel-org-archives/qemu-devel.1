Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDEEC19759
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:47:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E1C622BEB
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWfnujpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1C622BEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvGf9-0002kl-AL
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 03:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36393)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvGdZ-0000t3-L2
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvGdY-0007yi-In
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:45:33 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:36149)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hvGdY-0007yH-9x; Wed, 07 Aug 2019 03:45:32 -0400
Received: by mail-pl1-x641.google.com with SMTP id k8so39498441plt.3;
 Wed, 07 Aug 2019 00:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=LJ6f/334HjDkyHf6tr18VXYShBQB2ljOf/vOuSocRMM=;
 b=bWfnujpIlECRZZk9c0Gog+nCQpYrDg0Qd5MlPWmqGfL1Td3DwPEsH8Ge7RqJNG7Q4G
 TkS3ykvOw0sdBFPqRBRQTZyngAu/yX90RammDeETsUEdbo94ckMRjQsoO3Dgcz9C73VZ
 Gc0x0sOd5PqV2IyiygZQlayc2ud/DLTmrsrCWL1palBXyRRopJffYzW26GbMsOoSB/j2
 dJwTnqL3QKoy8mnVg6ioIyZXtHSx2Og/OxbmUq2XQ69/5xMeeYE/m6yR+aobrOIK/GbK
 GoRMT3phLncXGbNbrPSMQWM8Ph24natZ9VavGctUdppKYALBC6nIwgIkCaMr1FGzd+qr
 EJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=LJ6f/334HjDkyHf6tr18VXYShBQB2ljOf/vOuSocRMM=;
 b=F0scszN2iLjjjiBbD+6KfdFayEcIinbk2iYWnBmPrQylhk9TJmy3MUHmrgEPA+27dZ
 vMHy2VjwaTYT8Jv3mWgshlefEtI6HYMPQ7QZILIfSt1s8Wcq7UaRB0l6ILi70nlkSy57
 JxrzQ6/WqwMhHpCQmZO8X12gfbs3307d7LnsEGKyhJuEP4XM6FYfUkSts8dHzrwUQT+V
 vni+gpaFoxRHmyCzfRAEd2R0zNNA84NserZOecaXq9PiUwBwTfYLJT49iqPqXSJf2XlC
 c9pWITqO5eCF22DVgKLaOZsGPD7fladX+p6/oeI+k77PCqzz1i/Vqs8HrWJGe1Yf4BwU
 +FWQ==
X-Gm-Message-State: APjAAAUHcEUjW+iyPIYjpGe3gvPxrXeaqKk++XQy0jWP1uwImFok0h3x
 82KG+fIOPMm6K03y9ENpQBA=
X-Google-Smtp-Source: APXvYqzY/sdDffk4N1U/QWqTNfYtQFDpS+8pScQ9K+0bI6u34C8LSQAgXAcO6zcLpWMC65CnfkgKkw==
X-Received: by 2002:a65:430b:: with SMTP id j11mr6489300pgq.383.1565163931129; 
 Wed, 07 Aug 2019 00:45:31 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id l44sm20154449pje.29.2019.08.07.00.45.30
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Wed, 07 Aug 2019 00:45:30 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Wed,  7 Aug 2019 00:44:57 -0700
Message-Id: <1565163924-18621-2-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v2 01/28] riscv: hw: Remove superfluous "linux,
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


