Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86C8C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:22:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A813D2054F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cSJPLrm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A813D2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfHD-0006FR-RU
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfET-00007u-3j
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:19:57 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:52175)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfER-000561-CS
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:19:56 -0400
Received: by mail-pj1-x1043.google.com with SMTP id ds1so564759pjb.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AF5wUNj1rfWDk74W8hKW9/y1FLbHGsX9t+9rRKYsDAE=;
 b=cSJPLrm9GteLmp/zHcYXBP7RJR7B23j4r/EiC/h2x4srhE/XJSzyKYIm2vuVNjWSg+
 vbqASILIB4TCQd6fuelOKhjCYpFZ170/obWyZNCxPEv5Z6bGpC3i/91BfafuJi33fMGi
 t5X2WnEW7RYHhzWjgpZAw9YzX3V1lflRQ28FtSYtbFiW3qCB3NU0XLbfm2vNHpH1Sj2A
 rDfNqk9uKagyhmCflNQeuiZP9rWXXwrNJ6U7WlITLS9fzRYLC2tlopXG9pXFyL0jNeaz
 Ubk3M/FvWCnTnaLB/AuEbQP6oRuP8OrwJlOvPSwmAl7MPgcI2o7zlnd2n14jApOvtynl
 6Hvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AF5wUNj1rfWDk74W8hKW9/y1FLbHGsX9t+9rRKYsDAE=;
 b=TUUtZn7dUcn00esqgriMbdR4xhkhLKII2oTPYX1VYacOuz3/HnhGOJTyDOSK7QJ2jX
 bK7TRTd/sb9RlhBqFZ2NAdXmjCTbn/hIZd8VTNR4DEAnILPQt4absFtuTClvqWHDPwJE
 p0NNqvHi/G3yupWrLodZEqpCEauoS/N/maHzMBZnlv7betWcKxc99S5iL2Wqgwm3YIoC
 s8PKzVS4MWA5Y7eU/PQPz7rQvaVukkOb7h9wUDw1AWxLWMMpmviHJytA0pzSjxiUevQl
 x2gUeJg5AKsaF0Qbmb2ho6L/qxKUBFhPGueQS3QUdNUafb0I2H1CkdiI/c8GrruufBuX
 gWig==
X-Gm-Message-State: AOAM531+aOt5eYROoBQQ2PwzEUrQO6lHg8PrD1hKw4Wqz+332mbce9rx
 d2t3nwtKd/sQcTDmTSPTZB9KADK57KYf2g==
X-Google-Smtp-Source: ABdhPJw1/aKqUesxpJc7N27xCBaxnGtDHdgHPB9bFvYS8WuWx1JK1fHxwWiJhmZeP8yQ3Lva8W5CUQ==
X-Received: by 2002:a17:90a:f28a:: with SMTP id
 fs10mr1331215pjb.219.1598624393664; 
 Fri, 28 Aug 2020 07:19:53 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:19:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 17/76] target/microblaze: Fix width of BTR
Date: Fri, 28 Aug 2020 07:18:30 -0700
Message-Id: <20200828141929.77854-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The branch target register is only 32-bits wide.  Do not use a
64-bit type to represent it.  Since cpu_btr is only used during
MSR and MTR instructions, we can just as easily use an explicit
load and store, so eliminate the variable.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       |  2 +-
 target/microblaze/translate.c | 12 +++++-------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 34177f9b28..72f068a5fd 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -241,7 +241,7 @@ struct CPUMBState {
     uint64_t ear;
     uint32_t esr;
     uint32_t fsr;
-    uint64_t btr;
+    uint32_t btr;
     uint64_t edr;
     float_status fp_status;
     /* Stack protectors. Yes, it's a hw feature.  */
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 3fc2feda3d..a2bba0fe61 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -59,7 +59,6 @@ static TCGv_i32 cpu_pc;
 static TCGv_i32 cpu_msr;
 static TCGv_i64 cpu_ear;
 static TCGv_i32 cpu_esr;
-static TCGv_i64 cpu_btr;
 static TCGv_i64 cpu_edr;
 static TCGv_i32 env_imm;
 static TCGv_i32 env_btaken;
@@ -545,7 +544,8 @@ static void dec_msr(DisasContext *dc)
                                cpu_env, offsetof(CPUMBState, fsr));
                 break;
             case SR_BTR:
-                tcg_gen_extu_i32_i64(cpu_btr, cpu_R[dc->ra]);
+                tcg_gen_st_i32(cpu_R[dc->ra],
+                               cpu_env, offsetof(CPUMBState, btr));
                 break;
             case SR_EDR:
                 tcg_gen_extu_i32_i64(cpu_edr, cpu_R[dc->ra]);
@@ -587,7 +587,8 @@ static void dec_msr(DisasContext *dc)
                                cpu_env, offsetof(CPUMBState, fsr));
                 break;
             case SR_BTR:
-                tcg_gen_extrl_i64_i32(cpu_R[dc->rd], cpu_btr);
+                tcg_gen_ld_i32(cpu_R[dc->rd],
+                               cpu_env, offsetof(CPUMBState, btr));
                 break;
             case SR_EDR:
                 tcg_gen_extrl_i64_i32(cpu_R[dc->rd], cpu_edr);
@@ -1799,8 +1800,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     qemu_fprintf(f, "IN: PC=%x %s\n",
                  env->pc, lookup_symbol(env->pc));
     qemu_fprintf(f, "rmsr=%x resr=%x rear=%" PRIx64 " "
-                 "debug=%x imm=%x iflags=%x fsr=%x "
-                 "rbtr=%" PRIx64 "\n",
+                 "debug=%x imm=%x iflags=%x fsr=%x rbtr=%x\n",
                  env->msr, env->esr, env->ear,
                  env->debug, env->imm, env->iflags, env->fsr,
                  env->btr);
@@ -1868,8 +1868,6 @@ void mb_tcg_init(void)
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, ear), "rear");
     cpu_esr =
         tcg_global_mem_new_i32(cpu_env, offsetof(CPUMBState, esr), "resr");
-    cpu_btr =
-        tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, btr), "rbtr");
     cpu_edr =
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, edr), "redr");
 }
-- 
2.25.1


