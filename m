Return-Path: <SRS0=zX6u=BS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A10C433E1
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD4832053B
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZ89hNCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4832053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4OYJ-0005X1-VH
	for qemu-devel@archiver.kernel.org; Sat, 08 Aug 2020 09:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan.lee.qnl@gmail.com>)
 id 1k4KsS-0000jj-5G; Sat, 08 Aug 2020 05:10:56 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:55604)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ethan.lee.qnl@gmail.com>)
 id 1k4KsQ-0000bM-4Y; Sat, 08 Aug 2020 05:10:55 -0400
Received: by mail-pj1-x1043.google.com with SMTP id 2so2165283pjx.5;
 Sat, 08 Aug 2020 02:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IqYdAZooT8lM28ETEjL5hU1NnnBa1o7OjjnUhzOuR3Y=;
 b=FZ89hNCg5E4Um6oxdgXwESusEbjxji5pxx1l1cIebwGYZS8XI7kIcDKWKrbkoNaHql
 ZYkpR8vbUNY3pvxzO/y2U+Q2iIpVv/JqSozWx5XFXCySxr6Z/VTGZm6Kp7UZt55t4S78
 rQEPwgAJ8/ZgyYz5sRdsQIxtu3jEyssZL71x7Wv4fxAfEwt1wDd4X/OP011jOhuE1DBn
 yuj86esER2+h0B4jCeruMloxJ+GvBflxm146YuV+RRN4BqLyGNr+nxtx4pwX7cs0jiyD
 2TW0URTDhipfH4qXlkTb9tVWfqfNJFlcHi21dvcV9yvm3BaPYnMOe157QXwFt+CV7s6M
 dZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IqYdAZooT8lM28ETEjL5hU1NnnBa1o7OjjnUhzOuR3Y=;
 b=HCIAWka3MyMY1e12fm8iR1YcC9VR6/V9cBPMN4nrxaJ2ilMTj9RNwz7u81aUKHZV6S
 ggq2InOIVxHyq48qhtyZxjLddxKcn4yF/256bfTMKZ6jSyWLyihKeufV7xAIEgySb72t
 SBF03mGk0/WgolVec6mYIrl47T96FUJJF5bakk3mUEsyJw2jAnPYbuL6mUbaNXWDD1dW
 wX7d/H66W7YhxlQTfclloCeVBvqSVdaZgN0nsQurnuZitmZcL8t4BF+1arm9dWiDIyBo
 MsQPScWhjXH606VndF/L6HkDitTJeZogLGFKLzarMrKmQuSQxwAJ4FUoB0YBlN2lpPay
 gIUQ==
X-Gm-Message-State: AOAM532tHrUKmyxhoHMSiETf7rJTpqinMv7esVz+ZeytBoXMI0WfyuXB
 SVOAxj5c4aVYgqXRoBk0eztmYOviEbcZKg==
X-Google-Smtp-Source: ABdhPJx43Hf8Nd0dXu/jhposdQ03b7fvkBnCiJS3tn4w22VYioWDlEoXQmUlkkPP8jetJcnJ6spr/g==
X-Received: by 2002:a17:90a:8d0b:: with SMTP id
 c11mr17922923pjo.196.1596877851775; 
 Sat, 08 Aug 2020 02:10:51 -0700 (PDT)
Received: from localhost.localdomain (183178047145.ctinets.com.
 [183.178.47.145])
 by smtp.gmail.com with ESMTPSA id i11sm13312700pjv.30.2020.08.08.02.10.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Aug 2020 02:10:51 -0700 (PDT)
From: Hongzheng-Li <ethan.lee.qnl@gmail.com>
X-Google-Original-From: Hongzheng-Li <Ethan.Lee.QNL@gmail.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/4] Implementation of enhanced PMP(ePMP) support
Date: Sat,  8 Aug 2020 17:09:48 +0800
Message-Id: <20200808090950.13-3-Ethan.Lee.QNL@gmail.com>
X-Mailer: git-send-email 2.24.1.windows.2
In-Reply-To: <20200808090950.13-1-Ethan.Lee.QNL@gmail.com>
References: <20200808090950.13-1-Ethan.Lee.QNL@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=ethan.lee.qnl@gmail.com; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 08 Aug 2020 08:59:47 -0400
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
Cc: Hou Weiying <weiying_hou@outlook.com>, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, Hongzheng-Li <Ethan.Lee.QNL@gmail.com>,
 Alistair.Francis@wdc.com, palmer@dabbelt.com,
 Myriad-Dreamin <camiyoru@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Hou Weiying <weiying_hou@outlook.com>

The ePMP can be found in:
https://docs.google.com/document/d/1Mh_aiHYxemL0umN3GTTw8vsbmzHZ_nxZXgjgOUzbvc8/edit#heading=h.9wsr1lnxtwe2

Signed-off-by: Hongzheng-Li <Ethan.Lee.QNL@gmail.com>
Signed-off-by: Hou Weiying <weiying_hou@outlook.com>
Signed-off-by: Myriad-Dreamin <camiyoru@gmail.com>
---
 target/riscv/pmp.c        | 134 ++++++++++++++++++++++++++++++++++----
 target/riscv/pmp.h        |  12 ++++
 target/riscv/trace-events |   4 ++
 3 files changed, 138 insertions(+), 12 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 0e6b640fbd..8df389cecd 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -34,6 +34,26 @@ static void pmp_write_cfg(CPURISCVState *env, uint32_t addr_index,
 static uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t addr_index);
 static void pmp_update_rule(CPURISCVState *env, uint32_t pmp_index);
 
+static char mode_to_char(int mode)
+{
+    char ret = 0;
+    switch (mode) {
+    case PRV_U:
+        ret = 'u';
+        break;
+    case PRV_S:
+        ret = 's';
+        break;
+    case PRV_H:
+        ret = 'h';
+        break;
+    case PRV_M:
+        ret = 'm';
+        break;
+    }
+    return ret;
+}
+
 /*
  * Accessor method to extract address matching type 'a field' from cfg reg
  */
@@ -99,7 +119,28 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_index)
 static void pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
 {
     if (pmp_index < MAX_RISCV_PMPS) {
-        if (!pmp_is_locked(env, pmp_index)) {
+        /*
+         * mseccfg.RLB is set
+         */
+        if (MSECCFG_RLB_ISSET(env) ||
+            /*
+             * mseccfg.MML is set
+             */
+            (MSECCFG_MML_ISSET(env) &&
+            /*
+             * m model and not adding X bit
+             */
+            (((val & PMP_LOCK) != 0 && (val & PMP_EXEC) != PMP_EXEC) ||
+             /*
+              * shared region and not adding X bit
+              */
+            ((val & PMP_LOCK) != PMP_LOCK &&
+            (val & 0x7) != (PMP_WRITE | PMP_EXEC)))) ||
+            /*
+             * mseccfg.MML is not set
+             */
+            (!MSECCFG_MML_ISSET(env) && !pmp_is_locked(env, pmp_index))
+        ){
             env->pmp_state.pmp[pmp_index].cfg_reg = val;
             pmp_update_rule(env, pmp_index);
         } else {
@@ -230,6 +271,18 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
 
     /* Short cut if no rules */
     if (0 == pmp_get_num_rules(env)) {
+        if (MSECCFG_MMWP_ISSET(env)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "pmp violation - %c mode access denied\n",
+                          mode_to_char(mode));
+            return false;
+        }
+        if (MSECCFG_MML_ISSET(env) && (mode != PRV_M || (privs & PMP_EXEC))) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "pmp violation - %c mode access denied\n",
+                          mode_to_char(mode));
+            return false;
+        }
         return true;
     }
 
@@ -261,16 +314,65 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
         const uint8_t a_field =
             pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg);
 
-        /*
-         * If the PMP entry is not off and the address is in range, do the priv
-         * check
-         */
         if (((s + e) == 2) && (PMP_AMATCH_OFF != a_field)) {
-            allowed_privs = PMP_READ | PMP_WRITE | PMP_EXEC;
-            if ((mode != PRV_M) || pmp_is_locked(env, i)) {
-                allowed_privs &= env->pmp_state.pmp[i].cfg_reg;
+            /*
+             * If the PMP entry is not off and the address is in range,
+             * do the priv check
+             */
+            if (!MSECCFG_MML_ISSET(env)) {
+                /*
+                 * If mseccfg.MML Bit is not set, do pmp priv check
+                 */
+                allowed_privs = PMP_READ | PMP_WRITE | PMP_EXEC;
+                if ((mode != PRV_M) || pmp_is_locked(env, i)) {
+                    allowed_privs &= env->pmp_state.pmp[i].cfg_reg;
+                }
+            } else {
+                /*
+                 * If mseccfg.MML Bit set, do the enhanced pmp priv check
+                 */
+                if (env->pmp_state.pmp[i].cfg_reg & PMP_LOCK) {
+                    /*
+                     * Shared Region
+                     */
+                    if ((env->pmp_state.pmp[i].cfg_reg &
+                    (PMP_READ | PMP_WRITE)) == PMP_WRITE) {
+                        allowed_privs = PMP_EXEC | ((mode == PRV_M &&
+                        (env->pmp_state.pmp[i].cfg_reg & PMP_EXEC)) ?
+                        PMP_READ : 0);
+                    } else {
+                        allowed_privs = env->pmp_state.pmp[i].cfg_reg &
+                        (PMP_READ | PMP_WRITE | PMP_EXEC);
+
+                        if (mode != PRV_M && allowed_privs) {
+                            qemu_log_mask(LOG_GUEST_ERROR,
+                                "pmp violation - %c mode access denied\n",
+                                mode_to_char(mode));
+                            ret = 0;
+                            break;
+                        }
+                    }
+                } else {
+                    /*
+                     * Shared Region
+                     */
+                    if ((env->pmp_state.pmp[i].cfg_reg &
+                        (PMP_READ | PMP_WRITE)) == PMP_WRITE) {
+                        allowed_privs = PMP_READ | ((mode == PRV_M ||
+                        (env->pmp_state.pmp[i].cfg_reg & PMP_EXEC)) ?
+                        PMP_WRITE : 0);
+                    } else {
+                        allowed_privs = env->pmp_state.pmp[i].cfg_reg &
+                        (PMP_READ | PMP_WRITE | PMP_EXEC);
+                        if (mode == PRV_M && allowed_privs) {
+                            qemu_log_mask(LOG_GUEST_ERROR,
+                                    "pmp violation - m mode access denied\n");
+                            ret = 0;
+                            break;
+                        }
+                    }
+                }
             }
-
             if ((privs & allowed_privs) == privs) {
                 ret = 1;
                 break;
@@ -284,15 +386,23 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
     /* No rule matched */
     if (ret == -1) {
         if (mode == PRV_M) {
-            ret = 1; /* Privileged spec v1.10 states if no PMP entry matches an
-                      * M-Mode access, the access succeeds */
+            ret = !MSECCFG_MMWP_ISSET(env); /* PMP Enhancements */
+            if (MSECCFG_MML_ISSET(env) && (privs & PMP_EXEC)) {
+                ret = 0;
+            }
         } else {
             ret = 0; /* Other modes are not allowed to succeed if they don't
                       * match a rule, but there are rules.  We've checked for
                       * no rule earlier in this function. */
         }
     }
-
+    if (ret) {
+        trace_pmp_hart_has_privs_pass_match(
+            env->mhartid, addr, size, privs, mode);
+    } else {
+        trace_pmp_hart_has_privs_violation(
+            env->mhartid, addr, size, privs, mode);
+    }
     return ret == 1 ? true : false;
 }
 
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index 8e19793132..7db2069204 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -36,6 +36,12 @@ typedef enum {
     PMP_AMATCH_NAPOT /* Naturally aligned power-of-two region */
 } pmp_am_t;
 
+typedef enum {
+    MSECCFG_MML  = 1 << 0,
+    MSECCFG_MMWP = 1 << 1,
+    MSECCFG_RLB  = 1 << 2
+} mseccfg_field_t;
+
 typedef struct {
     target_ulong addr_reg;
     uint8_t  cfg_reg;
@@ -58,7 +64,13 @@ target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index);
 void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
     target_ulong val);
 target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index);
+void mseccfg_csr_write(CPURISCVState *env, target_ulong val);
+target_ulong mseccfg_csr_read(CPURISCVState *env);
 bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
     target_ulong size, pmp_priv_t priv, target_ulong mode);
 
+#define MSECCFG_MML_ISSET(env) get_field(env->mseccfg, MSECCFG_MML)
+#define MSECCFG_MMWP_ISSET(env) get_field(env->mseccfg, MSECCFG_MMWP)
+#define MSECCFG_RLB_ISSET(env) get_field(env->mseccfg, MSECCFG_RLB)
+
 #endif
diff --git a/target/riscv/trace-events b/target/riscv/trace-events
index 4b6c652ae9..4f877f90f7 100644
--- a/target/riscv/trace-events
+++ b/target/riscv/trace-events
@@ -6,3 +6,7 @@ pmpcfg_csr_read(uint64_t mhartid, uint32_t reg_index, uint64_t val) "hart %" PRI
 pmpcfg_csr_write(uint64_t mhartid, uint32_t reg_index, uint64_t val) "hart %" PRIu64 ": write reg%" PRIu32", val: 0x%" PRIx64
 pmpaddr_csr_read(uint64_t mhartid, uint32_t addr_index, uint64_t val) "hart %" PRIu64 ": read addr%" PRIu32", val: 0x%" PRIx64
 pmpaddr_csr_write(uint64_t mhartid, uint32_t addr_index, uint64_t val) "hart %" PRIu64 ": write addr%" PRIu32", val: 0x%" PRIx64
+mseccfg_csr_read(uint64_t mhartid, uint64_t val) "hart %" PRIu64 ": read mseccfg, val: 0x%" PRIx64
+mseccfg_csr_write(uint64_t mhartid, uint64_t val) "hart %" PRIu64 ": write mseccfg, val: 0x%" PRIx64
+pmp_hart_has_privs_pass_match(uint64_t mhartid, uint64_t addr, uint64_t size, uint64_t privs, uint64_t mode) "hart %"PRId64 "pass PMP 0 match addr:%"PRIu64" size:%"PRIu64 "privs: %"PRIu64 "mode: %"PRIu64
+pmp_hart_has_privs_violation(uint64_t mhartid, uint64_t addr, uint64_t size, uint64_t privs, uint64_t mode) "hart %"PRId64 "pass PMP 0 match addr:%"PRIu64" size:%"PRIu64 "privs: %"PRIu64 "mode: %"PRIu64
-- 
2.20.1


