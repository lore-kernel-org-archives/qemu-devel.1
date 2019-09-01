Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58396C3A5A6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 02:59:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A66622CE9
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 02:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJOM8TEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A66622CE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4G5X-0004gn-Gm
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 22:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4FzZ-0007Xu-6U
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4FzY-0006Cr-1V
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:25 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46887)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i4FzX-00069x-ST; Sat, 31 Aug 2019 22:53:23 -0400
Received: by mail-pf1-x443.google.com with SMTP id q139so6906454pfc.13;
 Sat, 31 Aug 2019 19:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=LynGsGkNTtxvEjP2fBblYu7R5hYIRAE6zZprsz9/uKk=;
 b=MJOM8TEsrvKm663VK68unapCFYXPcxohNzGj67y1iw7vLuohAiKdxLGJ2g9hookXaW
 lcpFcj1z/2IRgW3DAJVY/pSXlFlFtF9BaG1+ouTlkXItA+GojUZ7PViDv+GX05mKprEq
 Riw3jHj4ocfosalGnpWfpr7g8u52MEyLE9eUsTbXPoqpKObQLYmtxFD/5GQDt2U9RfLD
 e72ICKwJBexIc8rwHy5yqt6RxIXHRSt82CPpGPMCu3kDwSDCIexDgbsMJfZW+HZu9yg1
 gZI3NTma/eiDXF7xLxImBDkNAptMhsLo5MIHuwhwfTbONSADyWRT5e1DyB7SuaEosGpS
 5flQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=LynGsGkNTtxvEjP2fBblYu7R5hYIRAE6zZprsz9/uKk=;
 b=f72gB4GYMYeIu4ux2e6YJGJqU7AOwFI3/+vJKmWOEomF4fKeJMoa27HSVxRPv+yBKk
 fp7nxwJQntdTsZoD+QWBaT8A9v1ChPVKDFR6P1TwdnSyWQQ6bQLDo3k/SkqY1C9oyc7I
 yGX1gFErtavh60mFAc96mY0aIaHGyqxOCP9QR3YEhvSDXwid7XwoDEgvH1EN/M5tpcQa
 fEsGHPjin5EjkK03JaFqKd5Dt48Q4W3I4b68ItcdhYvAYVLUPIfIEYgYYL6i6aNCf1BV
 MPGaH6QqeKJa5b1KMOZZX1FeadHe9I2e365KDgKy7zkw16mg4mSV4AHXzZbLUNl/UZ0p
 8nAw==
X-Gm-Message-State: APjAAAX8Iy9p1r6jhs/VI2uv6p0C4ulXvULu9arJsQDi9qYg3DF/XZz5
 XlmSyYiUqZKsG0FZRuQa/1PDDGgC
X-Google-Smtp-Source: APXvYqwDEgoCdFAWUlws4ZSKLWI2lr2sdrBNupe7mD1aN7gARozbanR/0Wd6HkPMm8yoUfw2QfK4PA==
X-Received: by 2002:a62:5802:: with SMTP id m2mr27098967pfb.169.1567306401802; 
 Sat, 31 Aug 2019 19:53:21 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id p10sm11453307pff.132.2019.08.31.19.53.20
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sat, 31 Aug 2019 19:53:21 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sat, 31 Aug 2019 19:52:44 -0700
Message-Id: <1567306391-2682-4-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
References: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v7 03/30] riscv: hw: Remove not needed PLIC
 properties in device tree
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

This removes "reg-names" and "riscv,max-priority" properties of the
PLIC node from device tree.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Jonathan Behrens <fintelia@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2:
- keep the PLIC compatible string unchanged as OpenSBI uses that
  for DT fix up

 hw/riscv/sifive_u.c | 2 --
 hw/riscv/virt.c     | 2 --
 2 files changed, 4 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 3f9284e..5fe0033 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -180,8 +180,6 @@ static void *create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
         0x0, memmap[SIFIVE_U_PLIC].base,
         0x0, memmap[SIFIVE_U_PLIC].size);
-    qemu_fdt_setprop_string(fdt, nodename, "reg-names", "control");
-    qemu_fdt_setprop_cell(fdt, nodename, "riscv,max-priority", 7);
     qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", 0x35);
     qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
     plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 127f005..2f75195 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -244,8 +244,6 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
         0x0, memmap[VIRT_PLIC].base,
         0x0, memmap[VIRT_PLIC].size);
-    qemu_fdt_setprop_string(fdt, nodename, "reg-names", "control");
-    qemu_fdt_setprop_cell(fdt, nodename, "riscv,max-priority", 7);
     qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", VIRTIO_NDEV);
     qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
     plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
-- 
2.7.4


