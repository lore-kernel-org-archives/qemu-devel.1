Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8E4C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:28:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 244572086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D/NrYL+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244572086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycHL-0000BM-8V
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6o-0003Lg-6b
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6n-0005Qx-0F
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:34 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50782)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyc6m-0005Pr-Jf
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:32 -0400
Received: by mail-wm1-x341.google.com with SMTP id v15so4027683wml.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=uVyQXVCtM/J7JnL/CXNcjzqFIkkV64buKcsOFGN2/8M=;
 b=D/NrYL+QXtGCFNwM/4qEccy5FKWCX2j9x8rSQY0xuPRNeY4+inQIROANbKFZ4jfV2G
 z7kj0OSjROg3aiBPEM5JHkgF0mm7ufhIgMSUuKjmsyhmeGplR0uWBPUMKMVbNBERAAwE
 skCuh2lxtyKtWBe3OMqttCaMMLF62J75JBxzJGC/DLgDPCV1Jk0FFzmEny5c9cLp1Ouf
 3Jt22e7BTFFL/o2HXFg7/BauOQh9ZDOomq0dusBR10wUpWoTByle3gr9AAi5/Gk7tbe3
 m2dJf8qLdl5/n0bPLPTf9gExrvQqVdirhMNCUd/DscKkA1h9iwswQ0wf/5xgwQO8g/F1
 DNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uVyQXVCtM/J7JnL/CXNcjzqFIkkV64buKcsOFGN2/8M=;
 b=Q+UNG1Aa3CYxeFw2qqRb1ue1KOhVClDHAF3Im2PZ0uWB0S3HIqF6jYbpWvVfUnLIBu
 MlzHhrH/5MCgYEKG+uY0PBYwrUgBRouYN5oxZsooOZxHRo9bmbCkneqxXeif2uk/w33s
 i9TWALKKY2+udo+puGPficmd59/+Q6FaBxjoWXfl9w9ts0KX233RKNb4mSuBiK49Rm44
 C49u0BkFxHYq+CtCZxZXiY9Rvklra9ytvn0Eg+tvZXk7OmrcaVse00CkqHi+HJxNWYPW
 75zvXIo8LTgZkvLaghG7ajxJMIojKpUpldobAAV8wg+AyUk5g/3qNxM5J0F9e5dxgUYt
 SL2A==
X-Gm-Message-State: APjAAAUK13gXCvKpYKvGuAu3JvXmY9kbjWV19Qy0yAGrLO0ajk2vSjrh
 r0OFbbxyAPnYpdSobMSEMNMS9uJIv78kqg==
X-Google-Smtp-Source: APXvYqwQJBTBwHjNqMczd5bGyvMpWz9NvChDvdF4/BGX2IxeapinXBv/OVRliDoUYwBuyPNnVOaUSg==
X-Received: by 2002:a05:600c:2111:: with SMTP id
 u17mr7817330wml.64.1565961451412; 
 Fri, 16 Aug 2019 06:17:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 4sm8705796wro.78.2019.08.16.06.17.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 06:17:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 14:17:00 +0100
Message-Id: <20190816131719.28244-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816131719.28244-1-peter.maydell@linaro.org>
References: <20190816131719.28244-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PULL 10/29] target/arm: Remove redundant s->pc & ~1
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

The thumb bit has already been removed from s->pc, and is always even.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190807045335.1361-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index f481b87f997..8779d36a868 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1273,7 +1273,7 @@ static void gen_exception_bkpt_insn(DisasContext *s, int offset, uint32_t syn)
 /* Force a TB lookup after an instruction that changes the CPU state.  */
 static inline void gen_lookup_tb(DisasContext *s)
 {
-    tcg_gen_movi_i32(cpu_R[15], s->pc & ~1);
+    tcg_gen_movi_i32(cpu_R[15], s->pc);
     s->base.is_jmp = DISAS_EXIT;
 }
 
@@ -7804,7 +7804,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                  * self-modifying code correctly and also to take
                  * any pending interrupts immediately.
                  */
-                gen_goto_tb(s, 0, s->pc & ~1);
+                gen_goto_tb(s, 0, s->pc);
                 return;
             case 7: /* sb */
                 if ((insn & 0xf) || !dc_isar_feature(aa32_sb, s)) {
@@ -7815,7 +7815,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                  * for TCG; MB and end the TB instead.
                  */
                 tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
-                gen_goto_tb(s, 0, s->pc & ~1);
+                gen_goto_tb(s, 0, s->pc);
                 return;
             default:
                 goto illegal_op;
@@ -10449,7 +10449,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                              * and also to take any pending interrupts
                              * immediately.
                              */
-                            gen_goto_tb(s, 0, s->pc & ~1);
+                            gen_goto_tb(s, 0, s->pc);
                             break;
                         case 7: /* sb */
                             if ((insn & 0xf) || !dc_isar_feature(aa32_sb, s)) {
@@ -10460,7 +10460,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                              * for TCG; MB and end the TB instead.
                              */
                             tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
-                            gen_goto_tb(s, 0, s->pc & ~1);
+                            gen_goto_tb(s, 0, s->pc);
                             break;
                         default:
                             goto illegal_op;
-- 
2.20.1


