Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20374C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD7D2086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FiIDkBAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD7D2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56213 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycPB-0007fZ-EP
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6t-0003PM-7p
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6s-0005XB-3b
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:39 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36655)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyc6q-0005Ta-KT
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:36 -0400
Received: by mail-wm1-x343.google.com with SMTP id g67so4054563wme.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=OdK5cWlQ5sk+G9iGDbydEQDvzmCjdBLAENCSI33Pl1s=;
 b=FiIDkBAgoB1ksl0H9z8nXQBjtdxBNxzRjPvvndOEGSg7YTrYbCXHICLXxOE69OTcsa
 WM9v8hdsZNs+HJUvxBjMwEKDaI2S1GJK9kKVSm12s+QINY7wIoRxGHdPTRo7BK/2lvvt
 z/CNsgcO/x0Fkv1P65tExLJ8uUxMKrbUqcQZCecl6gUE5x2WAajOdPvRD9oxQO8LzNJH
 BIVmXXtFFNN73P/jEn3yuQK0420BVMyEgk/4CP3Vio5slwxdy9tGV3M9598uh0fN7XY9
 B9xEpk0tTDeO6b/z8Rx/377rAroUmbJuvt2MhQ94MqpOKbJb/48y0y6DH+zYW5cGcN/p
 6mDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OdK5cWlQ5sk+G9iGDbydEQDvzmCjdBLAENCSI33Pl1s=;
 b=FAtuuCWrU+2nt2zwG7Bv7rUzLoyjYqdSlXtVnQ6bnxdiI6AqVwmz0VEkh6nNZsP5jS
 0P2IuoZXYBQtNcAVrsXF7cpmrvYcV0l7w3pgECgD75CAH2UmyXynwb6elFADIYUXsXpE
 dXZPoJMPMBa1wKyk7u2c4gmSEXrJ6yle1zKPkU/nCXmdrwVzgv680noxfZizb/+hRZHB
 Zo6Wrlu9Y0X8cu4Tv3VZBHTBGchLlbrexPgxq1vHCsiyJb/g2kQhhoJcatSIoIsy2tDv
 z7dngLxuV3pP4nG55sRBKSNCvcmwF+n6kLW1I40S84NqlyUDfKbJ8LYjk/unaMurFRbs
 I0ig==
X-Gm-Message-State: APjAAAUnVvuCA3LHASd86dJSqPxav8PW1IpKDSgOZ4eas1MAxCSx5TM1
 ajzAcfw6CF1U1B0o1uirDPllWLxGrL7Bag==
X-Google-Smtp-Source: APXvYqypaDjSf1A/m3yROxm0xLSc4zESWij1J3vbP3QyNVVDYdFLC3vDFxH2kInZZWRCei6xHN2Uig==
X-Received: by 2002:a7b:cb11:: with SMTP id u17mr7282400wmj.17.1565961454825; 
 Fri, 16 Aug 2019 06:17:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 4sm8705796wro.78.2019.08.16.06.17.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 06:17:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 14:17:03 +0100
Message-Id: <20190816131719.28244-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816131719.28244-1-peter.maydell@linaro.org>
References: <20190816131719.28244-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PULL 13/29] target/arm: Replace offset with pc in
 gen_exception_internal_insn
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The offset is variable depending on the instruction set.
Passing in the actual value is clearer in intent.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190807045335.1361-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 8 ++++----
 target/arm/translate.c     | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 70caf3becb1..2f8eea02e3b 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -253,9 +253,9 @@ static void gen_exception_internal(int excp)
     tcg_temp_free_i32(tcg_excp);
 }
 
-static void gen_exception_internal_insn(DisasContext *s, int offset, int excp)
+static void gen_exception_internal_insn(DisasContext *s, uint64_t pc, int excp)
 {
-    gen_a64_set_pc_im(s->base.pc_next - offset);
+    gen_a64_set_pc_im(pc);
     gen_exception_internal(excp);
     s->base.is_jmp = DISAS_NORETURN;
 }
@@ -1924,7 +1924,7 @@ static void disas_exc(DisasContext *s, uint32_t insn)
                 break;
             }
 #endif
-            gen_exception_internal_insn(s, 0, EXCP_SEMIHOST);
+            gen_exception_internal_insn(s, s->base.pc_next, EXCP_SEMIHOST);
         } else {
             unsupported_encoding(s, insn);
         }
@@ -14220,7 +14220,7 @@ static bool aarch64_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
         /* End the TB early; it likely won't be executed */
         dc->base.is_jmp = DISAS_TOO_MANY;
     } else {
-        gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
+        gen_exception_internal_insn(dc, dc->base.pc_next, EXCP_DEBUG);
         /* The address covered by the breakpoint must be
            included in [tb->pc, tb->pc + tb->size) in order
            to for it to be properly cleared -- thus we
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 60f1b3998a1..c26d3376b3c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1241,10 +1241,10 @@ static inline void gen_smc(DisasContext *s)
     s->base.is_jmp = DISAS_SMC;
 }
 
-static void gen_exception_internal_insn(DisasContext *s, int offset, int excp)
+static void gen_exception_internal_insn(DisasContext *s, uint32_t pc, int excp)
 {
     gen_set_condexec(s);
-    gen_set_pc_im(s, s->base.pc_next - offset);
+    gen_set_pc_im(s, pc);
     gen_exception_internal(excp);
     s->base.is_jmp = DISAS_NORETURN;
 }
@@ -1296,7 +1296,7 @@ static inline void gen_hlt(DisasContext *s, int imm)
         s->current_el != 0 &&
 #endif
         (imm == (s->thumb ? 0x3c : 0xf000))) {
-        gen_exception_internal_insn(s, 0, EXCP_SEMIHOST);
+        gen_exception_internal_insn(s, s->base.pc_next, EXCP_SEMIHOST);
         return;
     }
 
@@ -11940,7 +11940,7 @@ static bool arm_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
         /* End the TB early; it's likely not going to be executed */
         dc->base.is_jmp = DISAS_TOO_MANY;
     } else {
-        gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
+        gen_exception_internal_insn(dc, dc->base.pc_next, EXCP_DEBUG);
         /* The address covered by the breakpoint must be
            included in [tb->pc, tb->pc + tb->size) in order
            to for it to be properly cleared -- thus we
-- 
2.20.1


