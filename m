Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA05C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 00:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9C9D2071A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 00:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q7dP2FeG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C9D2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYIhl-0004Dw-K0
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 20:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIbu-0004DF-Kn
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:42 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42010)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIbq-0001qr-KK
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:42 -0400
Received: by mail-pg1-x541.google.com with SMTP id k9so2059110pgt.9
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 17:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WQtz9VJLYSx04Hh8zsTVQFn8wB6GzwGePEieOesZ6FA=;
 b=q7dP2FeGiKfgbHeD3ZoC9tyxhsY6euZLjKFB8UVJ2Os+FTeXieruZjkVJPX8063QtA
 6rKY+/RsrEJtH3BzwA9/J1wUNj0190vaFRYxctpo8n93hMQLp9uTemoTKrPhM+/hpUJk
 8WHVSmzih0AzUqbfCtHEcQibe4RyJ4GAIaWOnFDVPT/LMSIJQZWv/VWHrhm7TSEE7UHq
 TGX3Z6j74oixxooLLIEuV4vnZic04zzM/FwOOGwvAlgKVnSikLbptstCGIlplc2PhSpE
 kig5c/BJNvFWZ5FFdS1rCffK98svhum1nQWo1XF+R0nvAwrpHAqKgmPjABtKIxdJ5GiT
 gg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WQtz9VJLYSx04Hh8zsTVQFn8wB6GzwGePEieOesZ6FA=;
 b=OilHpmdHnRajFOOiPzP/TiMqIj0NIBKyoFsG64mv/dsATQM8DPyR3BMqzbNQABijSG
 IaGURNj+arLmhob+VRN+CoiFBAD31Z2De51lZxnUuiqJECy0aj8IfVudU8vqhn8uvSbQ
 zmKMzTnu+4QgCzwjTXqxvF9k7tcA/q4iurO9aYQujq1GfAi4pNuLFD/vqSyqzKFfdn6V
 xyfdp8PU3WMD173eD4mP2LhMP2IN5fE+b+goBvnG5xSl/GQFdAecdpspFkl7hdrp3shq
 peVXTGLWFy2tpbSW82izSFCt8jo/5aCiXN61IyoPwcagJWVJhaxnIA8W7nFOmqECBMWC
 VCIg==
X-Gm-Message-State: AOAM530hYUb7HMeibzHLuI/Rkg2n2+s7Lok2itGEtecJ29hmOEiZr0rf
 2yAoMZ68E/DMlg5pNd7KV1BVznzze0a3ug==
X-Google-Smtp-Source: ABdhPJwd0FdbZKzzGsPvHsH9Yi1kqbYmhKXMgg2ZiaGGfZ9JtekrukCB5/c9jH/ctZsn9DRz+xZ/Dg==
X-Received: by 2002:aa7:8b0b:0:b029:152:900d:2288 with SMTP id
 f11-20020aa78b0b0000b0290152900d2288mr6950906pfd.53.1604018975744; 
 Thu, 29 Oct 2020 17:49:35 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b6sm3557264pgq.58.2020.10.29.17.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 17:49:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/19] tcg: Make DisasContextBase.tb const
Date: Thu, 29 Oct 2020 17:49:11 -0700
Message-Id: <20201030004921.721096-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030004921.721096-1-richard.henderson@linaro.org>
References: <20201030004921.721096-1-richard.henderson@linaro.org>
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
Cc: pbonzini@redhat.com, j@getutm.app, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is nothing within the translators that ought to be
changing the TranslationBlock data, so make it const.

This does not actually use the read-only copy of the
data structure that exists within the rx mirror.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/gen-icount.h  | 4 ++--
 include/exec/translator.h  | 2 +-
 include/tcg/tcg-op.h       | 2 +-
 accel/tcg/translator.c     | 4 ++--
 target/arm/translate-a64.c | 2 +-
 tcg/tcg-op.c               | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 822c43cfd3..aa4b44354a 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -32,7 +32,7 @@ static inline void gen_io_end(void)
     tcg_temp_free_i32(tmp);
 }
 
-static inline void gen_tb_start(TranslationBlock *tb)
+static inline void gen_tb_start(const TranslationBlock *tb)
 {
     TCGv_i32 count, imm;
 
@@ -71,7 +71,7 @@ static inline void gen_tb_start(TranslationBlock *tb)
     tcg_temp_free_i32(count);
 }
 
-static inline void gen_tb_end(TranslationBlock *tb, int num_insns)
+static inline void gen_tb_end(const TranslationBlock *tb, int num_insns)
 {
     if (tb_cflags(tb) & CF_USE_ICOUNT) {
         /* Update the num_insn immediate parameter now that we know
diff --git a/include/exec/translator.h b/include/exec/translator.h
index 638e1529c5..24232ead41 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -67,7 +67,7 @@ typedef enum DisasJumpType {
  * Architecture-agnostic disassembly context.
  */
 typedef struct DisasContextBase {
-    TranslationBlock *tb;
+    const TranslationBlock *tb;
     target_ulong pc_first;
     target_ulong pc_next;
     DisasJumpType is_jmp;
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 5abf17fecc..cbe39a3b95 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -805,7 +805,7 @@ static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1,
  * be NULL and @idx should be 0.  Otherwise, @tb should be valid and
  * @idx should be one of the TB_EXIT_ values.
  */
-void tcg_gen_exit_tb(TranslationBlock *tb, unsigned idx);
+void tcg_gen_exit_tb(const TranslationBlock *tb, unsigned idx);
 
 /**
  * tcg_gen_goto_tb() - output goto_tb TCG operation
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index fb1e19c585..a49a794065 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -133,8 +133,8 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
     }
 
     /* The disas_log hook may use these values rather than recompute.  */
-    db->tb->size = db->pc_next - db->pc_first;
-    db->tb->icount = db->num_insns;
+    tb->size = db->pc_next - db->pc_first;
+    tb->icount = db->num_insns;
 
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 072754fa24..297782e6ef 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -410,7 +410,7 @@ static inline bool use_goto_tb(DisasContext *s, int n, uint64_t dest)
 
 static inline void gen_goto_tb(DisasContext *s, int n, uint64_t dest)
 {
-    TranslationBlock *tb;
+    const TranslationBlock *tb;
 
     tb = s->base.tb;
     if (use_goto_tb(s, n, dest)) {
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 4b8a473fad..e3dc0cb4cb 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2664,7 +2664,7 @@ void tcg_gen_extr32_i64(TCGv_i64 lo, TCGv_i64 hi, TCGv_i64 arg)
 
 /* QEMU specific operations.  */
 
-void tcg_gen_exit_tb(TranslationBlock *tb, unsigned idx)
+void tcg_gen_exit_tb(const TranslationBlock *tb, unsigned idx)
 {
     uintptr_t val = (uintptr_t)tb + idx;
 
-- 
2.25.1


