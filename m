Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A48C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 05:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D29F72083D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 05:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uMWGhT+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29F72083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48116 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfHzw-0003OQ-5h
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 01:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35117)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vandersonmr2@gmail.com>) id 1hfHxD-0000ep-W4
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 01:55:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hfHxC-0003uo-Un
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 01:55:47 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:45061)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hfHxC-0003uK-Q6
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 01:55:46 -0400
Received: by mail-qt1-x841.google.com with SMTP id j19so13236430qtr.12
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2019 22:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KKclqfftacWgzlGnFMXl4z4qxP79Se0Ou3Fh9OifT6E=;
 b=uMWGhT+aE/c+ayJD89UpvD7tgP/QdDqMMmjIQrhdGpSmnUVOcXNg/P8e45GjnOvluC
 W3ppZ0AahSXOz/B4gKVHMd4e1HR5H83owkrLdPfRjLkA0uL+0Rmmua1GAmlCk7+sUmQr
 9/+PNpAbE1vXubIuCNhrpjy3jTRw7XAfAEmwj89hn/ZvJkGFvQJjs8PI/mSOa+BWHmnd
 CiDa/S8gLvjmJuKuv11OH/xQua/oC9jSwLxXZLVK5fi85Z23J/p5X0IK4KBWnU99Nlxa
 sPN8FdZe/8E8UTfTQjmhoqvhZZnu5GRo7ogA2QIUlmJg40f/XMKV6H7OmyY1bc/QP/6t
 1rTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KKclqfftacWgzlGnFMXl4z4qxP79Se0Ou3Fh9OifT6E=;
 b=dfKP95HVa/0hO3zNjmWpOdDCVUF6MWrjZn1CUsAvNKBqkzFJnaLedRq6xHIn/4J+iq
 fB8wYxBtTLwerDlWt59NviUOQsLxbewv/fLMelL0BQzkKOMdvgbX7hO4ts6i3cZzY1oH
 4ZrsitIe/dewCuWWjJG7upe8UXssSatPPlpQB7oqC8PKaGYlO2wmp1TxPVwksJQfgvrX
 ulOXB1+zrbT08HgxBqF5bNxmMlJkZreQu7oX6rHoc+p9PfkRM+UUXH/ayrHbShHj9woe
 AjMSo+ywE7iWoA94/91WLnWEqWR1J/sqFwBODCguBvBNZKGMFHknqZQj4XGsL3XY5DF6
 tAqA==
X-Gm-Message-State: APjAAAUk33hVhmLrL0N+PoE/zNl+6Ka6cEMp1E40f+KITrBJMM1eT+8V
 H/UushHDz1wp87EJ4pQGsbCy/vUq
X-Google-Smtp-Source: APXvYqyoQ/fg5+U/T8UVZMR/nq/eABRbME0JiYqKfLQh6tjHM7KGw13kGu85HW1hq4wP38FtTADSdQ==
X-Received: by 2002:a0c:8181:: with SMTP id 1mr55261001qvd.59.1561355746137;
 Sun, 23 Jun 2019 22:55:46 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f4:548d:5237:c368:80a0:cb96:64bf])
 by smtp.googlemail.com with ESMTPSA id t80sm5154440qka.87.2019.06.23.22.55.44
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 23 Jun 2019 22:55:45 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 24 Jun 2019 02:54:40 -0300
Message-Id: <20190624055442.2973-3-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624055442.2973-1-vandersonmr2@gmail.com>
References: <20190624055442.2973-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: [Qemu-devel] [PATCH v2 2/4] Adding an optional tb execution counter.
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, vandersonmr <vandersonmr2@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We collect the number of times each TB is executed
and store it in the its TBStatistics.
We also count the number of times the execution counter overflows.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
---
 accel/tcg/tcg-runtime.c   | 10 ++++++++++
 accel/tcg/tcg-runtime.h   |  2 ++
 accel/tcg/translator.c    |  1 +
 include/exec/gen-icount.h |  9 +++++++++
 4 files changed, 22 insertions(+)

diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 8a1e408e31..9888a7fce8 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -167,3 +167,13 @@ void HELPER(exit_atomic)(CPUArchState *env)
 {
     cpu_loop_exit_atomic(env_cpu(env), GETPC());
 }
+
+void HELPER(inc_exec_freq)(void *ptr)
+{
+    TranslationBlock *tb = (TranslationBlock*) ptr;
+    // if overflows, then reset the execution counter and increment the overflow counter
+    if (atomic_cmpxchg(&tb->tb_stats->exec_count, 0xFFFFFFFF, 0) == 0xFFFFFFFF) {
+        atomic_inc(&tb->tb_stats->exec_count_overflows);
+    }
+    atomic_inc(&tb->tb_stats->exec_count);
+}
diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 4fa61b49b4..bf0b75dbe8 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -28,6 +28,8 @@ DEF_HELPER_FLAGS_1(lookup_tb_ptr, TCG_CALL_NO_WG_SE, ptr, env)
 
 DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
 
+DEF_HELPER_FLAGS_1(inc_exec_freq, TCG_CALL_NO_RWG, void, ptr)
+
 #ifdef CONFIG_SOFTMMU
 
 DEF_HELPER_FLAGS_5(atomic_cmpxchgb, TCG_CALL_NO_WG,
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 9226a348a3..cc06070e7e 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -54,6 +54,7 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
     gen_tb_start(db->tb);
     ops->tb_start(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
+    gen_tb_exec_count(tb);
 
     while (true) {
         db->num_insns++;
diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index f7669b6841..6d38b6e1fb 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -7,6 +7,15 @@
 
 static TCGOp *icount_start_insn;
 
+static inline void gen_tb_exec_count(TranslationBlock *tb)
+{
+  if (qemu_loglevel_mask(CPU_LOG_HOT_TBS)) {
+    TCGv_ptr tb_ptr = tcg_const_ptr(tb);
+    gen_helper_inc_exec_freq(tb_ptr);
+    tcg_temp_free_ptr(tb_ptr);
+  }
+}
+
 static inline void gen_tb_start(TranslationBlock *tb)
 {
     TCGv_i32 count, imm;
-- 
2.22.0


