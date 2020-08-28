Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E1DC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE0D32078A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u2meYQFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0D32078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfKh-0004FA-8R
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEK-0008CW-8h
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:19:48 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38247)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEI-00054M-FX
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:19:47 -0400
Received: by mail-pf1-x441.google.com with SMTP id d22so737862pfn.5
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uVRyTVQxo8OjLoh4LZ/et66lNRgcRHaSjjoCMlpw+SQ=;
 b=u2meYQFbUWxfteHLzcUK2AZ+zWuwExI34OSwejQpg43VgXpZxmEkwh6lXqUd5IcncH
 186aItOpJximDBd/aavgaWqQJitu3q9b3WKJZkfQb+gpMdf+BCDu6VSdhrPIHvsV0Un9
 ekYBxK55Mr/gLV+/Zfpi+yJ2NVbvtS6uBUb7/nGkoQodj3BwCRT1iLflKQE96Mzku5AL
 IB33QVw/LE/3i+TR1Pz3wDElws4i7QwGikuRXD1fOc1yQq17A7c1kWTqRQa4S5H1Nrql
 223rF8QIe6WkdyN8D5YNP48Tu+61zPrOrYB0PW/3W4FI4j/VjVtx+QnWTDi3Ds+unJu1
 oeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uVRyTVQxo8OjLoh4LZ/et66lNRgcRHaSjjoCMlpw+SQ=;
 b=toGHx/B9v45rLgY8jD5n7U9IT6jTIp08u2mcgYoRgAub88GXhz3cuvmWB/HnGRtBJf
 sHkR/gF+sxpHH+q8h2N3z4sBTlfh31H4QT2iIB735E0LNkZGspKkCwXFis8tgU9R9fgg
 vGbWyBRfztar+Hnfigfxnumvguml3U/wOzpvlI02gD9SvkkpJmvwNgZDbzW0+AcM4VOF
 c9dRrLXYznTlQ2tEYNnXla1aQOsZ6KTjSc7yquqQAjEKQ9qWFAGMQ182SeQciclfI0XN
 7NsN0IvmFQHqui3ihyHrR27HObbdzeQ6Refr2VyZbPrVCEzCO2kaAdUh93lrSeOiExZK
 QpdA==
X-Gm-Message-State: AOAM533GohZUGC/9CU/nbzn0rM29gNsK5ppiAsEeF3MUrsa0mLjP8s+B
 CGjUuy5Q2MUuGsDNrpkcwLrLUPoRNXB0WQ==
X-Google-Smtp-Source: ABdhPJyut+8GhAYtqipQNRu/zjTpF1Bmd6k8kWLKAhlGKpISe9NM/ucqBMeTxy9B35muDQ5kxy9Tlg==
X-Received: by 2002:a63:8543:: with SMTP id u64mr1425085pgd.350.1598624384601; 
 Fri, 28 Aug 2020 07:19:44 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:19:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/76] target/microblaze: Split out BTR from env->sregs
Date: Fri, 28 Aug 2020 07:18:23 -0700
Message-Id: <20200828141929.77854-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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


