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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4985C3A5A4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:06:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B212E20828
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8zieEF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B212E20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2d3J-0001Jf-Ha
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 11:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i2cvq-00039f-B0
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i2cvp-0003Ky-Ab
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:58:50 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44206)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i2cvp-0003Kb-52; Tue, 27 Aug 2019 10:58:49 -0400
Received: by mail-pf1-x444.google.com with SMTP id c81so14263162pfc.11;
 Tue, 27 Aug 2019 07:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=PgaBfa2461mMPO3hboVa0CTJGMUC2+BnUYEwAGDtIng=;
 b=H8zieEF5gQh7cOmIsMkQFPdAbVhmIegiFU+478jxaySFND/FjoumMMbcWnLCPu496O
 Hh95S1fo1xamGUe23tcdAV4QzGszVRUMj+fxcj1vf5qH6f4xCtK7afDjBzP13Z0dUbex
 W59Yp2WakUDIcaR0pIh9IWQKPle+a1dR+jnuTtOfVVroJTB+1KHBJ5cpbahgvTWKZ2Go
 f6S+EVco/P/UwjX1KcY4Uw/Hi1QvzFQmilmY2ayY0N7Rqa5MPI+U5M29+m9uMgOMXmR/
 mMfo69gcHF2WgauYZssVXUjd21F6GbksOFLxs1CdmljneiAqcgPvcfn7GVis3Ss1Vb/w
 o+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=PgaBfa2461mMPO3hboVa0CTJGMUC2+BnUYEwAGDtIng=;
 b=kg2kdeSdLaeM2qCgxn45j6uYTWEKdUMBFPIuLliqJX09kpY/rCXl8t7Hf6V3NYzNES
 moFLtv++96yHm9ZMnR1xXYAOiP7UHWLDTBr0DPFu69ugC6MybQ17YslIOnkVu41uqtzO
 PyZ4s3EPaA0CYi/XJFxwjba7ihjxgy4JIcd/a7YdDeHU3IDaaA4PcqL7DnNt3PJUSX6V
 pfqTXElUon43wzlbehQv/52DOZcEUedHivC9TrPVNPZ22TohYnE8OWnqI+SYf/Pa3ZTo
 1T0vC5sKpEM3+dDHh3+WJ9mz0O/YA6+RVmh6o2m0M+aAdNFXWc4Mv0pE9ZE3fO8ytoEK
 dk2g==
X-Gm-Message-State: APjAAAVYoD7qTQlSoDVL4FTc6QGpauqAfVHzka+apdF3OIUed4Ex9/FV
 dU/bsZoiU8/Zes02A5M6BmQ=
X-Google-Smtp-Source: APXvYqzg+Ky34vZA/V5MIqMd612EfCag4uhv71DXOMzfFOfyIRNmdVkoyRWcFZyA8tu9XV4VrZKrLQ==
X-Received: by 2002:a17:90a:8990:: with SMTP id
 v16mr12978874pjn.97.1566917928411; 
 Tue, 27 Aug 2019 07:58:48 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id j15sm14839344pfr.146.2019.08.27.07.58.47
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Tue, 27 Aug 2019 07:58:47 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Tue, 27 Aug 2019 07:58:12 -0700
Message-Id: <1566917919-25381-4-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566917919-25381-1-git-send-email-bmeng.cn@gmail.com>
References: <1566917919-25381-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v6 03/30] riscv: hw: Remove not needed PLIC
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


