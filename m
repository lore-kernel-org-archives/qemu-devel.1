Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01ACC33CB2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:16:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC8C24681
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K4bGHv/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC8C24681
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irNw8-0005KS-09
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 10:16:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1irNpk-0005SF-Ni
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:10:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1irNpj-0007go-AA
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:10:20 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45515)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1irNpj-0007Yx-15
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:10:19 -0500
Received: by mail-wr1-x443.google.com with SMTP id j42so12479288wrj.12
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 07:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=anlfnB/asVkTJ6RtskIPp90azP/8H+sHTGGY0UbzreY=;
 b=K4bGHv/xQxqrTpz/FO5r/p0qqat5XJ9cHKNgajOby8XNuyQzd3zh1/L4BaTd+6FA6d
 BxCqzaIoJ9CYKDl12zIL8Odvi7Apzf4oPLoBTRMmqwiOwDv+PKNtAtdfm2vdScNUngmm
 Q2tg2G/MlG0ZAXugONgei1cQWDlWd/Epzr53yWMKshfhbpIXeYO/w63axPK9JnQpI6q9
 /X56kCn/mL0UvgEj37O6Oki8Ro2KLJOebwsAS8aL/hO7c8m2FJoFlIYwPCBuXiGrtNjh
 StldL2VahypN3idKTPoLJCHhhPrYxFIGH59YgelDmZZqU8IWulR+uYIj6RVGXhIA+p5g
 YJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=anlfnB/asVkTJ6RtskIPp90azP/8H+sHTGGY0UbzreY=;
 b=e2Cii8XCtSrUEZk3em5QLUcqjWPFitbKaBvskTTz/ynUrAi4f64uuHC38uuWMAAbCZ
 lcEd88lVLl7A5g7MxAwBFV8X6pbmYWX/OjWUIChrvL/217AahyY8cSJel116vyfR4V9G
 SoR1JHUvC0MbFPaNBW3F4UIdbeShnEb59tREILau/xdwOuqFlrilOGClr48/Bjmn8UPj
 /UlfyUgwzSZBzhSUjukOKLYOgEe3CsZTmqeMI2CXgAts1KM1gnjkGygo8z1mdcH4/MxM
 YVBT0sUscLGn+1bp7Tf1u4zJQG7045CYe5DfNMjPCmp2P71BD3XwBlOMC6HAjJQO8ZmK
 4Znw==
X-Gm-Message-State: APjAAAXOsKQ71s75pNVIWacdlcLDbez4vX5bpk1M/qUIUokSJx2xokt0
 vQfntuEG+PR4DAAyCXUIQCtuGA==
X-Google-Smtp-Source: APXvYqx8aPeZAa5gP1bUwmmzsgi2v1cxVe4V+wRbiSJlTrpHfOFGT8ui4x/nRkgJMeERruuPaV6+ig==
X-Received: by 2002:a5d:6408:: with SMTP id z8mr25868916wru.122.1579014610055; 
 Tue, 14 Jan 2020 07:10:10 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t81sm18850690wmg.6.2020.01.14.07.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 07:10:05 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7D5B71FF9D;
 Tue, 14 Jan 2020 15:09:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 14/22] target/arm: don't bother with id_aa64pfr0_read for
 USER_ONLY
Date: Tue, 14 Jan 2020 15:09:45 +0000
Message-Id: <20200114150953.27659-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200114150953.27659-1-alex.bennee@linaro.org>
References: <20200114150953.27659-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For system emulation we need to check the state of the GIC before we
report the value. However this isn't relevant to exporting of the
value to linux-user and indeed breaks the exported value as set by
modify_arm_cp_regs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - extend the ifdef and make type CONST with no accessfn
---
 target/arm/helper.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7dae067b3d..79cad7aad1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5924,6 +5924,7 @@ static uint64_t id_pfr1_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return pfr1;
 }
 
+#ifndef CONFIG_USER_ONLY
 static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -5934,6 +5935,7 @@ static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
     }
     return pfr0;
 }
+#endif
 
 /* Shared logic between LORID and the rest of the LOR* registers.
  * Secure state has already been delt with.
@@ -6426,16 +6428,24 @@ void register_cp_regs_for_features(ARMCPU *cpu)
          * define new registers here.
          */
         ARMCPRegInfo v8_idregs[] = {
-            /* ID_AA64PFR0_EL1 is not a plain ARM_CP_CONST because we don't
-             * know the right value for the GIC field until after we
-             * define these regs.
+            /*
+             * ID_AA64PFR0_EL1 is not a plain ARM_CP_CONST in system
+             * emulation because we don't know the right value for the
+             * GIC field until after we define these regs.
              */
             { .name = "ID_AA64PFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 0,
-              .access = PL1_R, .type = ARM_CP_NO_RAW,
+              .access = PL1_R,
+#ifdef CONFIG_USER_ONLY
+              .type = ARM_CP_CONST,
+              .resetvalue = cpu->isar.id_aa64pfr0
+#else
+              .type = ARM_CP_NO_RAW,
               .accessfn = access_aa64_tid3,
               .readfn = id_aa64pfr0_read,
-              .writefn = arm_cp_write_ignore },
+              .writefn = arm_cp_write_ignore
+#endif
+            },
             { .name = "ID_AA64PFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
-- 
2.20.1


