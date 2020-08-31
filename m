Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17723C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:39:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D140320719
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qZw/8raV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D140320719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmpm-0004gF-1T
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmLD-0006G6-Kk
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:32 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmLB-00068j-Q8
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:31 -0400
Received: by mail-pg1-x543.google.com with SMTP id g29so843749pgl.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0VSksOfKW1ugYJ+R8MPzR710nsFiQJIhTNG7hwTinY4=;
 b=qZw/8raV5MjGQHNSax9gJVsk8eIQ5X4xsdiXxWFo+U6cJYeyeRs9KNF+QdVcjpW1i0
 9OiuLY5e5bSk47x1IW+Du67oI4hJzuiUPwZL8VG49Cgz6pdG+JhY9Kk2K6X+jnZQ5xyw
 HVUzu2dTuOY2Kmk5kzkK9cdOE0n10mGQYKDBu6KkZQj2Z/T9jRv5v1XteBHf9roPK5P1
 IleWeykCt6kFSkjioa1J15PrnKdvOp4LOtPf+ZCzycu1Osb7QvpWBnDVDvtRayy8KV6C
 t3PVppJCnB8+ljh7EZ3QOh2Tna0ND2iwG+rnVwbK2Cyq/vSyny8CxSXjLQ9GvYoyO4rr
 YE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0VSksOfKW1ugYJ+R8MPzR710nsFiQJIhTNG7hwTinY4=;
 b=CW/mRQnuxLD5s9G5dP7vBjodTYYlXPLZcy4qYP0XAzSiNVAQwh+nniKGUPdlrrRcwd
 W6PXrr+l1zX9aFD4qh6ScNRdCdn7Mv1uS3nDSgpjDr+fkj95pbFgl1qymrxHrycPwmcs
 bbajKjg2zyjgPqI6V2lE5ifvPkO2iLM7QnzKbIqT0k9W21jJ7YGGwQDMmdwn+JzflD1p
 dEq9N2Q70gXCV1DeKmdZykw/edPd3GVYCooqgpKCwbY6ndPsxvOQsg1DvLqYjvCPpqvY
 KWqWMU+uVqnYxG15lXuSHoi3NYNZTv2YogqU6Of36Vjx6fqC548tsxf4+fbBcVL9KyCD
 rfjA==
X-Gm-Message-State: AOAM533x9z57zPsIlHnlRiuTfRoiO9lwBWMc6CkONgUMVADlzVJnp6xz
 /sUSjTd/8+aYpYdCiDhVoEnzVpp5cTCCXQ==
X-Google-Smtp-Source: ABdhPJxIOyARnby/JxUybhBmHuIeKPjdMYKeqU7rDLRf6dcm3FATIY+U74LKUS9diiU2UBPVZvCxeg==
X-Received: by 2002:a63:2809:: with SMTP id o9mr1820673pgo.410.1598890047573; 
 Mon, 31 Aug 2020 09:07:27 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:07:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 62/76] target/microblaze: Tidy mb_cpu_dump_state
Date: Mon, 31 Aug 2020 09:05:47 -0700
Message-Id: <20200831160601.833692-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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

Using lookup_symbol is quite slow; remove that.  Decode the
various bits of iflags; only show imm, btaken, btarget when
they are relevant to iflags.  Improve formatting.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
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


