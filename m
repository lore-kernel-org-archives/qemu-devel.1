Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0309FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:09:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B88E12082C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gTC/wLzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B88E12082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6TH-0004GR-DU
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5mV-0002Hv-Jk
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5mU-0001I3-Ck
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:31 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41611)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5mU-0001HT-6U
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:30 -0400
Received: by mail-wr1-x444.google.com with SMTP id p4so2344300wrm.8
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=coCttQh1DJ7CtKBy6WU9Qj5nCrM3kKgVRgB552jvYCY=;
 b=gTC/wLzqjCaPyNsmujQWYX6qTv2sonKaQAn7gL9XcAzvz1lb4UtYLF7etsv3JgiYkr
 5Y02mFxVwxpIgC/kYuYBgPo4uRBCvSIrvjGW2VDJSH2H5mCHHIRf/1+tSHpF7INqM8z7
 vKhEJccpj3ro3y8cn7VfE9sfpsoAgfmDxuhPnnzfm1Mxekr73cYgBfv4d/FKWsn3uQdf
 BEynaCYg1qNotyx8zUTGgqozuk9WIua0SQwP/NFN+zQCimozZBJ5GBTrpQS8j4WIq2mA
 hgTjLcFOxeoYph5C31s5NJotxBpveNT8UNzeZ9oTmuPfBMr0/t5kQ4vXLCgVHzHLGVPT
 RS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=coCttQh1DJ7CtKBy6WU9Qj5nCrM3kKgVRgB552jvYCY=;
 b=E8m4AdzFk1HgsfWQ+GUAC4Ed6tHQcb6ujT3yHetroXI9fNf76P6tYOlhn5FBTcZz8u
 T3HWJ3KzVkKysqoxeOajBr/ljQXoojt9MmpoFXC1f0I/JVQvtYh+iBbutuKp6IX7Us7f
 JLHj7S/lpawln0YER0qeKwVbzm6g4rzJpa4XaAPQ/StqJUgg8mBWUBe6OtmaVOSmnFw3
 6PeacVDw3rBNLhunnMBjyKlu+zvApJGPm3Tf3rq+gNlhb4b9u/FvDHu6CHi4WzbFqvE4
 FyfiJEFIULe5yHLbEGSEHlnIcHfd88FhZv1aLInsrOrlYruG46DIR83LA0k7Qenk5We/
 VRvA==
X-Gm-Message-State: APjAAAXIdFZLJ2u7Rwti/Np8pvKCn7rNZRFM09FD5VraFS0TopfgfvRy
 TH0zmL96zlAoCZiDNGF13a0NuZo6og4=
X-Google-Smtp-Source: APXvYqxvcOKiZwJO93sXF4aP7SYlKrHnEKfRV8nRiV3MQ5ryrsZiq10s1aczyf+ggdIaBgqCO1iVnA==
X-Received: by 2002:a5d:544b:: with SMTP id w11mr1484484wrv.205.1571318729110; 
 Thu, 17 Oct 2019 06:25:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z1sm2115475wrn.57.2019.10.17.06.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:25:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 142581FFBA;
 Thu, 17 Oct 2019 14:16:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 34/54] translator: inject instrumentation from plugins
Date: Thu, 17 Oct 2019 14:15:55 +0100
Message-Id: <20191017131615.19660-35-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v4
  - note we can't inject instrumentation if ! DISAS_NEXT
---
 accel/tcg/translator.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 70c66c538c..f977682be7 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -16,6 +16,7 @@
 #include "exec/gen-icount.h"
 #include "exec/log.h"
 #include "exec/translator.h"
+#include "exec/plugin-gen.h"
 
 /* Pairs with tcg_clear_temp_count.
    To be called by #TranslatorOps.{translate_insn,tb_stop} if
@@ -34,6 +35,7 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
                      CPUState *cpu, TranslationBlock *tb, int max_insns)
 {
     int bp_insn = 0;
+    bool plugin_enabled;
 
     /* Initialize DisasContext */
     db->tb = tb;
@@ -55,11 +57,17 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
     ops->tb_start(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
+    plugin_enabled = plugin_gen_tb_start(cpu, tb);
+
     while (true) {
         db->num_insns++;
         ops->insn_start(db, cpu);
         tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
+        if (plugin_enabled) {
+            plugin_gen_insn_start(cpu, db);
+        }
+
         /* Pass breakpoint hits to target for further processing */
         if (!db->singlestep_enabled
             && unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
@@ -99,6 +107,14 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
             break;
         }
 
+        /*
+         * We can't instrument after instructions that change control
+         * flow although this only really affects post-load operations.
+         */
+        if (plugin_enabled) {
+            plugin_gen_insn_end();
+        }
+
         /* Stop translation if the output buffer is full,
            or we have executed all of the allowed instructions.  */
         if (tcg_op_buf_full() || db->num_insns >= db->max_insns) {
@@ -111,6 +127,10 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
     ops->tb_stop(db, cpu);
     gen_tb_end(db->tb, db->num_insns - bp_insn);
 
+    if (plugin_enabled) {
+        plugin_gen_tb_end(cpu);
+    }
+
     /* The disas_log hook may use these values rather than recompute.  */
     db->tb->size = db->pc_next - db->pc_first;
     db->tb->icount = db->num_insns;
-- 
2.20.1


