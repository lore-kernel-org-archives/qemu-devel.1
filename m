Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E42C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:23:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6860F20738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0twTuks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6860F20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgPE-0002W3-Lr
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3a-0007r1-Qq
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:38 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40288)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3W-0001qK-UY
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:38 -0400
Received: by mail-pf1-x443.google.com with SMTP id k18so8289934pfp.7
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b/4g1T+WE9RDnuv3IAKyPSAVgdbvulTxnio8bcXmxqI=;
 b=B0twTuksnwz7HZ+KtuQhPiyv5xfA0oLn/CccM6Ql26TDaoQWI2B8eWPlsWtpbhecey
 uSA172Q6JQ9m1HLO/CGWZF4n6anl6yCUL3HnGqppFtwsKobmxcpDRVfo71h1WlxdDOIl
 SbIqBY9iXZuCMxL5TsvZaigVz3/3/go12CEBXwVF6C5xSbMKUWZDYauqtEa9SHwSAW0Y
 7szCyjEzMk10FcKwBlkznELjrBIyF91Ce7zFI8B3SKf1fBS+Xe8LpX9R1iu/o4KDnHFG
 KmUGqcfcVs3UehoiCqG3p4YWcWss4HGTs7dWZ8nUe4MXgbg8OK5uh4BWgtJUKR4rcsOK
 01Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b/4g1T+WE9RDnuv3IAKyPSAVgdbvulTxnio8bcXmxqI=;
 b=UMQag2IZEN2qeSPXh6Qe0KLKflByGiYkBaooyAmZQMgh80crEL71WbgkI4DOkI0qaS
 R3f/gieRv3U9XRC1W5S7tHljc71+N6fUTkwJ5AfKkDl0W1kVmUvacwnCaGUJt27b6d/0
 3zxCnlPwgFZMqkDHwMPU/GuEpBoTPiW+3+hGpYaxmSJJvOsnUPk4xtGmuG+6QPIBpCZN
 YAZMZgsjuQYGarz/x/D/vB0tWnDEYGHbCJs1bnnABEO6tspnTOvgwLaQrMSQW04VQiK1
 yRQIaFbmuKyu+3RBTeselA74NqWnmvCvc9VIZE1ZoVGRQq3Je2JpvaHA2zVoW8Fdu0da
 s/Ow==
X-Gm-Message-State: AOAM531Qhtjshj8b0xHK5Ij4U7kuZbF9fugVrLyPPO8C+mp0qn/BLVfQ
 V6idvKC3wCsmr+TeXO1LDZsa8YdQQ/Volg==
X-Google-Smtp-Source: ABdhPJy4ITh0mGPprZXHrELKExwI8yMYm9RSrajy26YrksYkcVmC1hJ24xL4EsqpkYKw5nKkkETN7g==
X-Received: by 2002:a17:902:343:: with SMTP id
 61mr8991627pld.274.1598389233135; 
 Tue, 25 Aug 2020 14:00:33 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 32/77] target/microblaze: Remove empty D macros
Date: Tue, 25 Aug 2020 13:59:05 -0700
Message-Id: <20200825205950.730499-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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

This is never used in op_helper.c and translate.c.  There are
two trivial uses in helper.c which can be improved by always
logging MMU_EXCP to CPU_LOG_INT.

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


