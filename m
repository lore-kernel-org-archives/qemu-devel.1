Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66CEC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:23:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 707A020787
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6BaITq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707A020787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU6Ld-0005ER-Hp
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 06:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jU6IX-0008D6-MH
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jU6IQ-00017f-2O
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:20:05 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234]:34352)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jU6IP-00017A-Ms
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:19:57 -0400
Received: by mail-lj1-x234.google.com with SMTP id f11so5905230ljp.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 03:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XHBGTarqSU7FvFVqR/1Ml1TW7QFmRL1nmZZFnmyDZqc=;
 b=O6BaITq5g3Ub6+OIszV26t5Ucn61I00nPkGnBrY/Y9872OtegiRqsCeYdaLuZ3CGok
 jeaDo+J4W6Upe+H+mk9P1g+is5gqVIW7Zm9nJqd0JQyBE2zMtffUy9x0b3T03j+xHTlT
 /wKQV39CwGS4Jg7RnhFwLA0xbfB+NhdR6olJRGOFiUbvCSPx7/CjXDfy46OHSuVy+Jw6
 dOi4yAi4+nM2Nh24ckxNvp1zQVOn5xOOKjBMaY2uLvDJ6kkGsYfEdlxOtOw76Uer5Xnw
 rMiB8M+S8AKgL3/IJiMIpI2/OHU0hbkOOITkPjZIEvdgQrTN5JR89Jnr1hFgGGFl5gOq
 NY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XHBGTarqSU7FvFVqR/1Ml1TW7QFmRL1nmZZFnmyDZqc=;
 b=e6/U9EViBxyBmn9Xdi28rSEqf5U2nxVOx/gtuz3Ej5ik3KfvWrRnmR3NOgqVbnLtTG
 QTcIPy3PPQyJTN7FtwSLyR9ImOoWMZ4FcVcmxCVuBUyX7pIECaKReTUhmCaaIA9QD2eY
 mK+XQoMQMk1mF/J0L6nANMCs8qdzQPVW37NNZSrkKxQlwyyJGpXdrXzblZg4FXzdNq2z
 3SXMxC75abTIvfAEwNJ4i/247i+M+bWLJIqa7jr5xDVjJhQ3qkF30TMZ8vgv8L1NN3Y6
 utvSZHTbpvLfGjq4k0nKAGixEiu8/+YqHncjEB/k0R7uWSBSNvOYmEgVyN1dJI0lv85s
 jDCw==
X-Gm-Message-State: AGi0PubrHWmACPFPrniI4Bhmh5uwaU1DcU//cARpl/fkjxFWHRkYoL5m
 MVu8rI2m4ivQ0udyZz6fzHgFaH4InWs=
X-Google-Smtp-Source: APiQypK+4Lhqzy8+5b22BRGc5MEYoYJvRcuIt2ToHeWYzkhBP0GsZlquPCkbdwUBWiIm5ld6LYB0Ng==
X-Received: by 2002:a05:651c:50e:: with SMTP id
 o14mr1814519ljp.52.1588241995945; 
 Thu, 30 Apr 2020 03:19:55 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id f10sm3009032lfl.82.2020.04.30.03.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 03:19:55 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 3/6] target/microblaze: Add the div-zero-exception property
Date: Thu, 30 Apr 2020 12:19:46 +0200
Message-Id: <20200430101949.7754-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430101949.7754-1-edgar.iglesias@gmail.com>
References: <20200430101949.7754-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x234.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::234
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add the div-zero-exception property to control if the core
traps divizions by zero.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.h       | 1 +
 target/microblaze/cpu.c       | 4 ++++
 target/microblaze/op_helper.c | 5 +++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 71d7317a58..3c07f9b3f7 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -305,6 +305,7 @@ struct MicroBlazeCPU {
         bool iopb_bus_exception;
         bool illegal_opcode_exception;
         bool opcode_0_illegal;
+        bool div_zero_exception;
         char *version;
         uint8_t pvr;
     } cfg;
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 2cc6b1513c..4211f50c11 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -207,6 +207,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
                                                  PVR2_DOPB_BUS_EXC_MASK : 0) |
                         (cpu->cfg.iopb_bus_exception ?
                                                  PVR2_IOPB_BUS_EXC_MASK : 0) |
+                        (cpu->cfg.div_zero_exception ?
+                                                 PVR2_DIV_ZERO_EXC_MASK : 0) |
                         (cpu->cfg.illegal_opcode_exception ?
                                                 PVR2_ILL_OPCODE_EXC_MASK : 0) |
                         (cpu->cfg.opcode_0_illegal ?
@@ -280,6 +282,8 @@ static Property mb_properties[] = {
                      cfg.iopb_bus_exception, false),
     DEFINE_PROP_BOOL("ill-opcode-exception", MicroBlazeCPU,
                      cfg.illegal_opcode_exception, false),
+    DEFINE_PROP_BOOL("div-zero-exception", MicroBlazeCPU,
+                     cfg.div_zero_exception, false),
     DEFINE_PROP_BOOL("opcode-0x0-illegal", MicroBlazeCPU,
                      cfg.opcode_0_illegal, false),
     DEFINE_PROP_STRING("version", MicroBlazeCPU, cfg.version),
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 18677ddfca..f3b17a95b3 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -132,11 +132,12 @@ uint32_t helper_carry(uint32_t a, uint32_t b, uint32_t cf)
 
 static inline int div_prepare(CPUMBState *env, uint32_t a, uint32_t b)
 {
+    MicroBlazeCPU *cpu = env_archcpu(env);
+
     if (b == 0) {
         env->sregs[SR_MSR] |= MSR_DZ;
 
-        if ((env->sregs[SR_MSR] & MSR_EE)
-            && !(env->pvr.regs[2] & PVR2_DIV_ZERO_EXC_MASK)) {
+        if ((env->sregs[SR_MSR] & MSR_EE) && cpu->cfg.div_zero_exception) {
             env->sregs[SR_ESR] = ESR_EC_DIVZERO;
             helper_raise_exception(env, EXCP_HW_EXCP);
         }
-- 
2.20.1


