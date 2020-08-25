Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA90C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A83206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WCymE3jW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A83206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgj1-00044o-NZ
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg4C-0000Mm-Su
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:16 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:40631)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg4A-00021U-Tl
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:16 -0400
Received: by mail-pg1-x542.google.com with SMTP id h12so7675219pgm.7
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0+lbMujB7ENQF6DPdS7wnVUjhoKJE7Rkmv+oxgd9wrg=;
 b=WCymE3jWbHXk76hlDjCJUVQXgckSWgcpPrdABXMw7zDyqOP7b2H5O9zMWMH2ou5sxd
 9qYxMOH/q2VsyQywqGSPGugNgKB7981voHZxR16L26suMOfJzw72U3ZyWPGVM4OBLOjp
 ZkwYIPszghuKLsSJzmLLfWotazsxHN+wR8jnQ+csnSXcDqf2DPufkW4ROug4Z9QdWwm1
 evkLhMrp50+O44XPGzR9UJdmC7DSOlxnuBU2o7brm/CzEVjrJyaaziHXaijW7o1LP+OJ
 WzWJQmq1pNzyqPEO3lV3nuCwPTvfN+le52Lx2ejtn8f104ozxKdqSQQynlMzCDVN//lL
 iXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0+lbMujB7ENQF6DPdS7wnVUjhoKJE7Rkmv+oxgd9wrg=;
 b=reNXmVRGErl1jSRITy8Yi8hjQSxMiAPXMwH6rBdVfB1ki9THprd94WApaTgQlPXUOk
 QhTX3UpveAN+8tB15GvbrQgjUmZ8CrdFgVSRTvnEmbqEsUxfcgeIVJpAoOF4Pkcf78r0
 wEdoF5MkXKDIdPCpemCU3atpNDoNgnOgR/qJUnWEcAgiiePmB6p35VgS33H2tSvEVhTN
 ZyqPDyqPmKIvidL1/04qzt8sBMTujZkzWODwsOIDqKCYs4bbjm9WhKs6M0BgNyPPo3Pl
 WJTtLFBCzt229V0vyEdvd/u+TXQ6eV87kkq6F72aWmkSFMVyPRwZnIFhCclKMbGi2HXz
 JPzw==
X-Gm-Message-State: AOAM531UsInpbCEMXzEK982xLqexrXSzVOkBWgBxjYwnjhvLRI42Nyti
 bp5ItMwkmAAn4Mvdc1fAtr1ONdmETRLxeQ==
X-Google-Smtp-Source: ABdhPJwk6KWRlM+HN1HWXL2lk1QWBzxeH+3ZnFn6qnra1WrGnQIM8nNt5L4kMp+W5zxDGoSQk0kbZQ==
X-Received: by 2002:aa7:924b:: with SMTP id 11mr9274257pfp.185.1598389273161; 
 Tue, 25 Aug 2020 14:01:13 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:01:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 61/77] target/microblaze: Tidy mb_cpu_dump_state
Date: Tue, 25 Aug 2020 13:59:34 -0700
Message-Id: <20200825205950.730499-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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

Using lookup_symbol is quite slow; remove that.  Decode the
various bits of iflags; only show imm, btaken, btarget when
they are relevant to iflags.  Improve formatting.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 67 +++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 26 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 3ba2dc1800..4675326083 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1810,41 +1810,56 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUMBState *env = &cpu->env;
+    uint32_t iflags;
     int i;
 
-    if (!env) {
-        return;
-    }
-
-    qemu_fprintf(f, "IN: PC=%x %s\n",
-                 env->pc, lookup_symbol(env->pc));
-    qemu_fprintf(f, "rmsr=%x resr=%x rear=%" PRIx64 " "
-                 "imm=%x iflags=%x fsr=%x rbtr=%x\n",
-                 env->msr, env->esr, env->ear,
-                 env->imm, env->iflags, env->fsr, env->btr);
-    qemu_fprintf(f, "btaken=%d btarget=%x mode=%s(saved=%s) eip=%d ie=%d\n",
-                 env->btaken, env->btarget,
+    qemu_fprintf(f, "pc=0x%08x msr=0x%05x mode=%s(saved=%s) eip=%d ie=%d\n",
+                 env->pc, env->msr,
                  (env->msr & MSR_UM) ? "user" : "kernel",
                  (env->msr & MSR_UMS) ? "user" : "kernel",
                  (bool)(env->msr & MSR_EIP),
                  (bool)(env->msr & MSR_IE));
-    for (i = 0; i < 12; i++) {
-        qemu_fprintf(f, "rpvr%2.2d=%8.8x ", i, env->pvr.regs[i]);
-        if ((i + 1) % 4 == 0) {
-            qemu_fprintf(f, "\n");
-        }
+
+    iflags = env->iflags;
+    qemu_fprintf(f, "iflags: 0x%08x", iflags);
+    if (iflags & IMM_FLAG) {
+        qemu_fprintf(f, " IMM(0x%08x)", env->imm);
+    }
+    if (iflags & BIMM_FLAG) {
+        qemu_fprintf(f, " BIMM");
+    }
+    if (iflags & D_FLAG) {
+        qemu_fprintf(f, " D(btaken=%d btarget=0x%08x)",
+                     env->btaken, env->btarget);
+    }
+    if (iflags & DRTI_FLAG) {
+        qemu_fprintf(f, " DRTI");
+    }
+    if (iflags & DRTE_FLAG) {
+        qemu_fprintf(f, " DRTE");
+    }
+    if (iflags & DRTB_FLAG) {
+        qemu_fprintf(f, " DRTB");
+    }
+    if (iflags & ESR_ESS_FLAG) {
+        qemu_fprintf(f, " ESR_ESS(0x%04x)", iflags & ESR_ESS_MASK);
+    }
+
+    qemu_fprintf(f, "\nesr=0x%04x fsr=0x%02x btr=0x%08x edr=0x%x\n"
+                 "ear=0x%016" PRIx64 " slr=0x%x shr=0x%x\n",
+                 env->esr, env->fsr, env->btr, env->edr,
+                 env->ear, env->slr, env->shr);
+
+    for (i = 0; i < 12; i++) {
+        qemu_fprintf(f, "rpvr%-2d=%08x%c",
+                     i, env->pvr.regs[i], i % 4 == 3 ? '\n' : ' ');
     }
 
-    /* Registers that aren't modeled are reported as 0 */
-    qemu_fprintf(f, "redr=%x rpid=0 rzpr=0 rtlbx=0 rtlbsx=0 "
-                    "rtlblo=0 rtlbhi=0\n", env->edr);
-    qemu_fprintf(f, "slr=%x shr=%x\n", env->slr, env->shr);
     for (i = 0; i < 32; i++) {
-        qemu_fprintf(f, "r%2.2d=%8.8x ", i, env->regs[i]);
-        if ((i + 1) % 4 == 0)
-            qemu_fprintf(f, "\n");
-        }
-    qemu_fprintf(f, "\n\n");
+        qemu_fprintf(f, "r%2.2d=%08x%c",
+                     i, env->regs[i], i % 4 == 3 ? '\n' : ' ');
+    }
+    qemu_fprintf(f, "\n");
 }
 
 void mb_tcg_init(void)
-- 
2.25.1


