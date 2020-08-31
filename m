Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143DFC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:21:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D44282073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hMjqixW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44282073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmZ9-0001j7-0V
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKY-0004kJ-Tn
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:51 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40493)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKX-00061d-0J
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:50 -0400
Received: by mail-pg1-x541.google.com with SMTP id h12so831243pgm.7
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8/3WDLS8b0IqACNGFAn6ZPwsL1jv2U3misGXJGmlm9U=;
 b=hMjqixW8wDfqzZh/oashrCrrsp68fpjiMQZgyeyawZUWBq0GA1a+r33mBfmk4z8pqQ
 u9oR7vLexxWV56ZhLsSsXwDBpv4+wuW2GhP1isW1SheE1rQVsG07vxE6aoyK3yJg7g8P
 lrRDbNMbk28bUyC4UDpPAdtcxPBejNHw+Fvtrc0x6jeuM2oyNL+eauE+a0mAEG2DpfUv
 ViwWyy7sVzGKNno46llcwb0O6qyiyptJ3cXftXxZKhIKaVRFUT+tbiqxQey7D41MjvsA
 vGKevJTS/YHZaCmQ9ubzPB1S7cCif62XHLTuf3sRZrJMQd4OqPpqPRBCBxUgmYHq35Qw
 J4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8/3WDLS8b0IqACNGFAn6ZPwsL1jv2U3misGXJGmlm9U=;
 b=VzLmafOw4VPqyGH2NK+0HlyZsOPOYG30WVvoiwEpOnrnlIa3eGPFZWq1jmOI/CEGu/
 DYx9dfRG09Lmcw3UEn/IfKEAIrKRYNrCC8ubqgsN4OELfW2+oc4VBtB64ULcwflHKuum
 EOvuv6cKOLminQrMG6WnKaKdAT45HemWsN691rp4nssYFZ3+ebskAxrLvDHU99ao6ZrV
 w38xDzTSexQlnLZkaJtnkpAfOILf5T8rqze04sy9TINMiUhvj48S96nhg2i4PjSjmG62
 SNfrCk6Yr8dAWQnIAWEOxneEoGqBXwGWTJ/gwt7JUxC0tvqxohprNz3ANi48D2e4E7Lu
 0VAQ==
X-Gm-Message-State: AOAM5333dlKneUhGDiAsp2CzrDhbe0/xZduiMQVmTqToJyENoxHWYLx+
 eZZ135if/3Gh4+CxUhvh/DDxL0CtZtqh9A==
X-Google-Smtp-Source: ABdhPJxZxdjiuSwfRvw+un39hcKojONKMAq+OXWJSL9baldA/a9tj0Uyy7QbzZak+5+iOLBefgELSA==
X-Received: by 2002:a62:928d:: with SMTP id o135mr1888007pfd.22.1598890006946; 
 Mon, 31 Aug 2020 09:06:46 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/76] target/microblaze: Remove empty D macros
Date: Mon, 31 Aug 2020 09:05:17 -0700
Message-Id: <20200831160601.833692-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is never used in op_helper.c and translate.c.  There are
two trivial uses in helper.c which can be improved by always
logging MMU_EXCP to CPU_LOG_INT.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/helper.c    | 11 ++++-------
 target/microblaze/op_helper.c |  2 --
 target/microblaze/translate.c |  2 --
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 9a95456401..f8e2ca12a9 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -24,8 +24,6 @@
 #include "qemu/host-utils.h"
 #include "exec/log.h"
 
-#define D(x)
-
 #if defined(CONFIG_USER_ONLY)
 
 void mb_cpu_do_interrupt(CPUState *cs)
@@ -155,10 +153,13 @@ void mb_cpu_do_interrupt(CPUState *cs)
         case EXCP_MMU:
             env->regs[17] = env->pc;
 
+            qemu_log_mask(CPU_LOG_INT,
+                          "MMU exception at pc=%x iflags=%x ear=%" PRIx64 "\n",
+                          env->pc, env->iflags, env->ear);
+
             env->esr &= ~(1 << 12);
             /* Exception breaks branch + dslot sequence?  */
             if (env->iflags & D_FLAG) {
-                D(qemu_log("D_FLAG set at exception bimm=%d\n", env->bimm));
                 env->esr |= 1 << 12 ;
                 env->btr = env->btarget;
 
@@ -166,14 +167,10 @@ void mb_cpu_do_interrupt(CPUState *cs)
                 env->regs[17] -= 4;
                 /* was the branch immprefixed?.  */
                 if (env->bimm) {
-                    qemu_log_mask(CPU_LOG_INT,
-                                  "bimm exception at pc=%x iflags=%x\n",
-                                  env->pc, env->iflags);
                     env->regs[17] -= 4;
                     log_cpu_state_mask(CPU_LOG_INT, cs, 0);
                 }
             } else if (env->iflags & IMM_FLAG) {
-                D(qemu_log("IMM_FLAG set at exception\n"));
                 env->regs[17] -= 4;
             }
 
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index d79202c3f8..decdca0fd8 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -26,8 +26,6 @@
 #include "exec/cpu_ldst.h"
 #include "fpu/softfloat.h"
 
-#define D(x)
-
 void helper_put(uint32_t id, uint32_t ctrl, uint32_t data)
 {
     int test = ctrl & STREAM_TEST;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 6757720776..860859324a 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -41,8 +41,6 @@
 #  define LOG_DIS(...) do { } while (0)
 #endif
 
-#define D(x)
-
 #define EXTRACT_FIELD(src, start, end) \
             (((src) >> start) & ((1 << (end - start + 1)) - 1))
 
-- 
2.25.1


