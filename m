Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AEAC10F00
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 12:49:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E589B206D7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 12:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtCeOUsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E589B206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAYtR-0002ip-Ty
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 07:49:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1jAYsp-0002F4-41
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 07:48:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1jAYsn-0008GH-VD
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 07:48:46 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42347)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1jAYsn-0008DF-N0; Sat, 07 Mar 2020 07:48:45 -0500
Received: by mail-pg1-x541.google.com with SMTP id h8so2419192pgs.9;
 Sat, 07 Mar 2020 04:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id;
 bh=sDlDMFWdUPkBfGBnWPJ/c2w4WPeAB/r/f67ASoRmvX8=;
 b=PtCeOUsrK0vR7nmPFlytdfwahK3ACkNVwnNOqKuS5+kSg6wWF5SMjBSQySb03tRwVP
 +rA7gOOpSRIWW3xpxu658YMA6DSxGXLm1l4spmtMa4rFejYZhELEO3slV9uPmIDV1Mj1
 Inromg/ReFLgZm7dqpwXYmSIUI+5VBdGZJ871irQzVExofczn4fRlYj0xMlVQA4A47a3
 qWmJjTpSaRARApyDtPPR2qAXUz7/16xlwxHMlgc9R5+T85sN23W3FNdw6Pph6HhVCEwJ
 qLIybLfBVVLLNDj1NSzOS+b2lRtDZTL3vosCf3Ghz7tf9mgbMktn6R68rAUlzO9yqdKc
 OyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=sDlDMFWdUPkBfGBnWPJ/c2w4WPeAB/r/f67ASoRmvX8=;
 b=tsp+ErXXLRizoYKI+kUoZjGflXPoKY5SBZvPOCsBWL6P8Sew/eZd+2n4g2Ji1zdUHl
 IIqwiDa7REpjXwn2OjopSs/z4CFxZcBRRcHCJPzqy9yL4VQ3BJyrDjm0sR1uRdC8UrNX
 pxSN6Oagyyt8+vKgLNLzD5FRGKRtdLKq1Ik2vn04KGrLT0ZqaQEb041QfBvCQG3OAH77
 h10p6lMn+rVHMrEBj1D1qAhtY0cLVpB/Witl/roXEc27xcXIHUhA8S/9bSFg363pviZE
 l05v/2r34sL8C1bpSr9Y2U5TkEIoEqEKWAxhgc9h9enRgGsh20YG7qZ4WnTgS0sdYjPn
 pGVg==
X-Gm-Message-State: ANhLgQ3lcf4C9h1khIBkMkE2g9qvQ8V98fPCGxYuyI1N24qatio5+zKa
 1zseIrfPrbcCr97X6FP6Q38=
X-Google-Smtp-Source: ADFU+vsOHepK97HQ6F0G/Cb4nPu2jH32G1QXmp4tuKm3hnnhAdR3Qlm+S6UqVbLQgCR3+8XUWPoqFw==
X-Received: by 2002:a63:b04f:: with SMTP id z15mr7656715pgo.58.1583585324581; 
 Sat, 07 Mar 2020 04:48:44 -0800 (PST)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id z24sm6004349pfk.46.2020.03.07.04.48.43
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sat, 07 Mar 2020 04:48:44 -0800 (PST)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH] hw/riscv: Generate correct "mmu-type" for 32-bit machines
Date: Sat,  7 Mar 2020 04:48:39 -0800
Message-Id: <1583585319-26603-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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

32-bit machine should have its CPU's "mmu-type" set to "riscv,sv32".

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 hw/riscv/sifive_u.c | 4 ++++
 hw/riscv/spike.c    | 4 ++++
 hw/riscv/virt.c     | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index d318988..26ea777 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -159,7 +159,11 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         qemu_fdt_add_subnode(fdt, nodename);
         /* cpu 0 is the management hart that does not have mmu */
         if (cpu != 0) {
+#if defined(TARGET_RISCV32)
+            qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv32");
+#else
             qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
+#endif
             isa = riscv_isa_string(&s->soc.u_cpus.harts[cpu - 1]);
         } else {
             isa = riscv_isa_string(&s->soc.e_cpus.harts[0]);
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 8823681..6f9a1ba 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -102,7 +102,11 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
         char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
         char *isa = riscv_isa_string(&s->soc.harts[cpu]);
         qemu_fdt_add_subnode(fdt, nodename);
+#if defined(TARGET_RISCV32)
+        qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv32");
+#else
         qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
+#endif
         qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", isa);
         qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
         qemu_fdt_setprop_string(fdt, nodename, "status", "okay");
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 7f9e1e5..57f532a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -229,7 +229,11 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
         char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
         char *isa = riscv_isa_string(&s->soc.harts[cpu]);
         qemu_fdt_add_subnode(fdt, nodename);
+#if defined(TARGET_RISCV32)
+        qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv32");
+#else
         qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
+#endif
         qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", isa);
         qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
         qemu_fdt_setprop_string(fdt, nodename, "status", "okay");
-- 
2.7.4


