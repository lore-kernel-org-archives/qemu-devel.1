Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C1BC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCAA32078A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J5WX9nTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCAA32078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfLb-0006OA-0D
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEL-0008GA-Ga
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:19:49 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEJ-00054Y-JE
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:19:49 -0400
Received: by mail-pg1-x541.google.com with SMTP id i10so535255pgk.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kxuKPEsnkZdfVwCBdweXYlcCCLoCz5+CGJqBlv/VqWk=;
 b=J5WX9nTT9MdGeM+/nwjYQNebibQDzHizdBLLXGBgD0rkbXpfbee9FTg4Im6d3avgY2
 A3lgfgzuCiDKQZAKD0h8FvO3kw+3ZzVqbB6oi2z1qt6581PhlECRIke1MkdxSoj/VY3Y
 gKBJxsuqRB9C66UsCH/yQ4jXLS58ueRHMPQbKgmUYtJFUEqQGB2sD6pn1Fw1eOonSxmH
 rqajT/VU402lvvrL+55vL7AbQYMbSXZKT/vWy8pDu6f5/WEd/tK1iTFJ4xmQb+0ZAFRp
 ZoCzTJ6KIdlxdAc6VMbWgZSZJb2a/O2VoxjLHQ+c6RKYhSHD6gTX/Iv74YizXvGMDka7
 reuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kxuKPEsnkZdfVwCBdweXYlcCCLoCz5+CGJqBlv/VqWk=;
 b=RIjpBiEa5QXVUeqYccLU7uoOG0a39CcspZUYK95BOHyq1nYG25WWItzj9EQU2lrzcU
 AWRoNhz2ASZNj0Sb6EHgh/3wvxs7rnuLf/+gvThly1fHC4bD8IpZnnmTVca5yh+PcpoQ
 o9gpOhw2e9AtrZWQGBg3dgKyP588QYPIzNqxXgwY5yiuT6wdEy4NFiWysohrRciPvPSL
 ocTKekNbhfitVQSuwVwpFK7iDAzj9aGmiLvKhqaZfyQ/jJcEFQASDpDeNfQUV1vKJ1fU
 i9FNTOCNdtW0MRJn4OUQ1q8NlMAyjJzLF3a2XeWhtk4V67P2sTFnX/HwFSimev6YeWbx
 puBg==
X-Gm-Message-State: AOAM531UyRpo+CFS+HEEtCrXdj2gyox9Dyya5z8K78iZzYzvqAGapTfW
 11hI9oo1Qz4Gw8nJ0IKOpCBNGG1LSfZ4Aw==
X-Google-Smtp-Source: ABdhPJz4n5o/i7w9elKaQm59Yhpijw+hFIu41tVBoRw7J3yUiCacyLDI71nQIMd+IzCINDRthUXHAA==
X-Received: by 2002:aa7:9e5d:: with SMTP id z29mr1492151pfq.122.1598624385846; 
 Fri, 28 Aug 2020 07:19:45 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:19:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/76] target/microblaze: Split out EDR from env->sregs
Date: Fri, 28 Aug 2020 07:18:24 -0700
Message-Id: <20200828141929.77854-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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

Finish eliminating the sregs array in favor of individual members.
Does not correct the width of EDR, yet.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       |  2 +-
 linux-user/elfload.c          |  9 ++++++---
 target/microblaze/gdbstub.c   |  4 ++--
 target/microblaze/translate.c | 16 +++-------------
 4 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index deddb47abb..610ddfb719 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -242,7 +242,7 @@ struct CPUMBState {
     uint64_t esr;
     uint64_t fsr;
     uint64_t btr;
-    uint64_t sregs[14];
+    uint64_t edr;
     float_status fp_status;
     /* Stack protectors. Yes, it's a hw feature.  */
     uint32_t slr, shr;
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index fe9dfe795d..bbfb665321 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1032,9 +1032,12 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMBState *env
         (*regs)[pos++] = tswapreg(env->regs[i]);
     }
 
-    for (i = 0; i < 6; i++) {
-        (*regs)[pos++] = tswapreg(env->sregs[i]);
-    }
+    (*regs)[pos++] = tswapreg(env->pc);
+    (*regs)[pos++] = tswapreg(env->msr);
+    (*regs)[pos++] = 0;
+    (*regs)[pos++] = tswapreg(env->ear);
+    (*regs)[pos++] = 0;
+    (*regs)[pos++] = tswapreg(env->esr);
 }
 
 #endif /* TARGET_MICROBLAZE */
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index cde8c169bf..9cba9d2215 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -81,7 +81,7 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         val = env->pvr.regs[n - GDB_PVR0];
         break;
     case GDB_EDR:
-        val = env->sregs[SR_EDR];
+        val = env->edr;
         break;
     case GDB_SLR:
         val = env->slr;
@@ -137,7 +137,7 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         env->pvr.regs[n - GDB_PVR0] = tmp;
         break;
     case GDB_EDR:
-        env->sregs[SR_EDR] = tmp;
+        env->edr = tmp;
         break;
     case GDB_SLR:
         env->slr = tmp;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 469e1f103a..7d307e6b48 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -103,12 +103,6 @@ static const char *regnames[] =
     "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
 };
 
-static const char *special_regnames[] =
-{
-    "rpc", "rmsr", "sr2", "rear", "sr4", "resr", "sr6", "rfsr",
-    "sr8", "sr9", "sr10", "rbtr", "sr12", "redr"
-};
-
 static inline void t_sync_flags(DisasContext *dc)
 {
     /* Synch the tb dependent flags between translator and runtime.  */
@@ -1828,7 +1822,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 
     /* Registers that aren't modeled are reported as 0 */
     qemu_fprintf(f, "redr=%" PRIx64 " rpid=0 rzpr=0 rtlbx=0 rtlbsx=0 "
-                    "rtlblo=0 rtlbhi=0\n", env->sregs[SR_EDR]);
+                    "rtlblo=0 rtlbhi=0\n", env->edr);
     qemu_fprintf(f, "slr=%x shr=%x\n", env->slr, env->shr);
     for (i = 0; i < 32; i++) {
         qemu_fprintf(f, "r%2.2d=%8.8x ", i, env->regs[i]);
@@ -1881,12 +1875,8 @@ void mb_tcg_init(void)
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, fsr), "rfsr");
     cpu_SR[SR_BTR] =
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, btr), "rbtr");
-
-    for (i = SR_BTR + 1; i < ARRAY_SIZE(cpu_SR); i++) {
-        cpu_SR[i] = tcg_global_mem_new_i64(cpu_env,
-                          offsetof(CPUMBState, sregs[i]),
-                          special_regnames[i]);
-    }
+    cpu_SR[SR_EDR] =
+        tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, edr), "redr");
 }
 
 void restore_state_to_opc(CPUMBState *env, TranslationBlock *tb,
-- 
2.25.1


