Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48ADC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:08:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6932A20665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yE1UsFN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6932A20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgAx-0002WX-Lj
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg36-00076u-WF
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:09 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg35-0001fg-65
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:08 -0400
Received: by mail-pf1-x442.google.com with SMTP id d22so8300100pfn.5
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uVRyTVQxo8OjLoh4LZ/et66lNRgcRHaSjjoCMlpw+SQ=;
 b=yE1UsFN4anihXN9PFOKhd1TyAM1LP/xfDZHy+g85G6vlKvTxgzxLG5AfU27URAMfF2
 MbqNkkBtHNmLr6hnT9t2wqHvYq1cWDD/qe6rCnfSXvuyZ+HC5JOcrnluTXIl/TO7La4R
 tJGrEeJqEC4eygNcVwauWNl7o3Y2fbjebDCxX/Qdli8Sc0SEcrfX03XXXpB1Len+ybyE
 tADj2HW9rc9sZwFyll3lyrvKbMdfkf6CGkVMeKCgnHG+AU9/b4LaFpqDSHNJMyznVvmz
 IvA7SQdS+7YIngbkiXvYeFO9SQW3PURgxUlyInPE1y1KTdSgsMlw2gR1Kwib31OQxb/P
 +0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uVRyTVQxo8OjLoh4LZ/et66lNRgcRHaSjjoCMlpw+SQ=;
 b=omlKj6cdAcEE6cpTZxcITctnF9OWRhRik+r9kr6WTQAm7YNJAtoc0ul6g+mszi3zxG
 OH1vivvYfVw8hIDzN7pTKNabxdMHwMkZP8vpaiSvM4ni1kAy+/YeOh5tuLnPsmSYyO6L
 pJFjhZuq4meaQH8o9Eju/4+4qUM+h2Y/jlC4P0ag/1dws0S8f0d49aWLGVCQS27PA1BY
 GnfrReN7UBQNb4cl9T4Wq8fcYGFWvOMUbULmw20CKGUMQCwpO/IX2RSHJV993TzEPk6n
 /3Y4CkaQ/D8qpfW/GVcCN90oDtEdTGiKwNzUINNOQEGNAtvGqnsuce+RiefRbTINgIVL
 k5Zw==
X-Gm-Message-State: AOAM530RHP7/fS64jbArhD9kzWBtvBt2hKrDeC1brsOU7DBEm9SR7OyQ
 LTPABv4+g4vMVzW9I9Bv/kaY7napcgwF9A==
X-Google-Smtp-Source: ABdhPJwPeikTZDLVPCgs3H8y5ZKc7bTJXcSdlui+09RJI1tZA3HIVm4rED7TqtZzBxhU9QJSaT1EUA==
X-Received: by 2002:a62:82c3:: with SMTP id w186mr8018070pfd.287.1598389205254; 
 Tue, 25 Aug 2020 14:00:05 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/77] target/microblaze: Split out BTR from env->sregs
Date: Tue, 25 Aug 2020 13:58:43 -0700
Message-Id: <20200825205950.730499-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Continue eliminating the sregs array in favor of individual members.
Does not correct the width of BTR, yet.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       | 1 +
 target/microblaze/gdbstub.c   | 4 ++--
 target/microblaze/helper.c    | 4 ++--
 target/microblaze/translate.c | 6 ++++--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index bcafef99b0..deddb47abb 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -241,6 +241,7 @@ struct CPUMBState {
     uint64_t ear;
     uint64_t esr;
     uint64_t fsr;
+    uint64_t btr;
     uint64_t sregs[14];
     float_status fp_status;
     /* Stack protectors. Yes, it's a hw feature.  */
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index 2634ce49fc..cde8c169bf 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -74,7 +74,7 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         val = env->fsr;
         break;
     case GDB_BTR:
-        val = env->sregs[SR_BTR];
+        val = env->btr;
         break;
     case GDB_PVR0 ... GDB_PVR11:
         /* PVR12 is intentionally skipped */
@@ -130,7 +130,7 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         env->fsr = tmp;
         break;
     case GDB_BTR:
-        env->sregs[SR_BTR] = tmp;
+        env->btr = tmp;
         break;
     case GDB_PVR0 ... GDB_PVR11:
         /* PVR12 is intentionally skipped */
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index ea290be780..b240dc76f6 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -132,7 +132,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
             /* Exception breaks branch + dslot sequence?  */
             if (env->iflags & D_FLAG) {
                 env->esr |= 1 << 12 ;
-                env->sregs[SR_BTR] = env->btarget;
+                env->btr = env->btarget;
             }
 
             /* Disable the MMU.  */
@@ -160,7 +160,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
             if (env->iflags & D_FLAG) {
                 D(qemu_log("D_FLAG set at exception bimm=%d\n", env->bimm));
                 env->esr |= 1 << 12 ;
-                env->sregs[SR_BTR] = env->btarget;
+                env->btr = env->btarget;
 
                 /* Reexecute the branch.  */
                 env->regs[17] -= 4;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index c58c49ea8f..469e1f103a 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1811,7 +1811,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                  "rbtr=%" PRIx64 "\n",
                  env->msr, env->esr, env->ear,
                  env->debug, env->imm, env->iflags, env->fsr,
-                 env->sregs[SR_BTR]);
+                 env->btr);
     qemu_fprintf(f, "btaken=%d btarget=%" PRIx64 " mode=%s(saved=%s) "
                  "eip=%d ie=%d\n",
                  env->btaken, env->btarget,
@@ -1879,8 +1879,10 @@ void mb_tcg_init(void)
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, esr), "resr");
     cpu_SR[SR_FSR] =
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, fsr), "rfsr");
+    cpu_SR[SR_BTR] =
+        tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, btr), "rbtr");
 
-    for (i = SR_FSR + 1; i < ARRAY_SIZE(cpu_SR); i++) {
+    for (i = SR_BTR + 1; i < ARRAY_SIZE(cpu_SR); i++) {
         cpu_SR[i] = tcg_global_mem_new_i64(cpu_env,
                           offsetof(CPUMBState, sregs[i]),
                           special_regnames[i]);
-- 
2.25.1


