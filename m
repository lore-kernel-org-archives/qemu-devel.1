Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD21C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:46:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0228207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CSSEp5lq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0228207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfdj-0002Ha-3d
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFO-00024k-2V
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:54 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:37815)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFM-0005Pj-7R
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:53 -0400
Received: by mail-pj1-x1042.google.com with SMTP id mw10so568526pjb.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XgYEr9I/NlTUuTKL+AU6VwkfWOL8hdo8tZQBDIES8xQ=;
 b=CSSEp5lqwYWjqTy9lXy8S4Svr65vSmM3UthvxDAuMKJjqfbHaxQ92i1ZbIl2kaU+6D
 5Utb8JRJ+SE8MH1CT9WfrXVXQGgnMN+BRDHXn3SKPh/ccjczSIIHlxn20prLjEZZcm94
 NcZWy3biaZGqxPLqfy7EGDSqnWsuDM3S9m2bwKBZsUDXzCQ2u4ATHvLYV0zD+6I3qapq
 a5Xo8NYjetp7aCEVOqU7T6XmV4O7ueWIctsol3Qbxn9DrvI/MEki0/xuNEh9tHX9IY5K
 vwmJUVmQanAaa4TrvOmEwhCwibVVzpwuuVKrxoWs+R4cKT548JfO+1vQGbHfMycgpKgy
 VzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XgYEr9I/NlTUuTKL+AU6VwkfWOL8hdo8tZQBDIES8xQ=;
 b=sf51/wouzIvO4uk9wd7VhXUZBBbapXQGJ5aKK3uBHcZP4KF0MKx1yYLZGHlrdsS9Bt
 vRwDR9trMxo3cKGMQl40RTM2Ppjeb2SUDRBI69o4TNmMELjTow+1s29Ggm6NNbVHZK3B
 uvw6hG7L9UG6Xl6HAr1JiT7xXaUV2iyJ4gK66T0MGrQKemUrPuFp/Ia7+4yfzUtV0ssG
 qcnDHVmu7Hs7e4kt2sx+6GrxMx0QumodyYIFiiCz0+THwHEEE7vvYHBGlI6S/orRU9pB
 Qgu1frj5xGiWCTgdjBbg/a1I3I1BGDunkdBbAnPH6J4DN3jeJkC0dDIFNza8pXJmOa+B
 KHow==
X-Gm-Message-State: AOAM533DPoR7cST3tbQ46rc8U9JvncG6Wl5ozgsD3zLPywx/kccpcbtk
 820WtD7mQZlIG2Vmuz+rUgKmt7b1TGEnxA==
X-Google-Smtp-Source: ABdhPJyR86fiDfs2BX0dLTWa+9nq/EtFYOjVSS0BFtzzffS7d8T6m1I+1TZ6e5lZJh6xwkWby+17Hw==
X-Received: by 2002:a17:902:c111:: with SMTP id
 17mr1537062pli.46.1598624450536; 
 Fri, 28 Aug 2020 07:20:50 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 62/76] target/microblaze: Tidy mb_cpu_dump_state
Date: Fri, 28 Aug 2020 07:19:15 -0700
Message-Id: <20200828141929.77854-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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

Using lookup_symbol is quite slow; remove that.  Decode the
various bits of iflags; only show imm, btaken, btarget when
they are relevant to iflags.  Improve formatting.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 67 +++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 26 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 811c92d23b..3b63fd79e5 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1818,41 +1818,56 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
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


