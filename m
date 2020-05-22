Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03374C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:47:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E462072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ECNuVEcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E462072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxiA-0004xN-H5
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 22:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWh-00036W-IH
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:35:11 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:55378)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWg-00058u-FP
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:35:11 -0400
Received: by mail-pj1-x1041.google.com with SMTP id k7so4289771pjs.5
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 19:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Y21KcsvLFJXq/u9VH9lik1swR2hgaP1jOrA8QoTE+F4=;
 b=ECNuVEcZAbPQPZxEjgGYqmY1EOgyTcS2pmNAfs8ZJcMHP/ftK0gbYbPgPPCps1PfE1
 eLCzVaAcxyzXmswqa0IQNKeXMKdbERkhegKD6Uqmm8Hl1/fr8F4UfHqVIJp+lSS9xrLL
 DLKVYDamgUw2k2Tb1pvRsN9i/ikTMT9OXfxnYFn4wyeVaUq+dhFEOMTqgBqA0p69szpg
 4hFl1488GrsZkojtEUBgv7lBQe1HZtUMMT1BfUndkL+qZwo02RjpwaSBf4OCeVyOY2o0
 PImxTHMXHkVVBXgIKbG1v91iYbGrSHOq3HlI3kNAcMa5SPM9NOax3coU7J/vK4XAhtCg
 2zCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Y21KcsvLFJXq/u9VH9lik1swR2hgaP1jOrA8QoTE+F4=;
 b=KV5WvMw6uMHxCAR/m59s9zrFGgONBK3y53jzdcw4Fae7i0B3c0x9zczTHgh0V1VMFk
 t2XseKAYbYFjmIs4ajuIHGOjefrsEc3LNSw0o/0+G0ZOqV9qCFLywOuElBZ6cslZXWhf
 oYsIrcsK++d9ZlOsH/egrBUIuUlxJ8+1PJi41MACpCjWtVR3vFJ8IUtQ2YOE/pG5JMdC
 Ct6agPSUqz9HPo3BNKCR2jUeBcf7Qqi4GHHMmCmaUwfihvaZzzZ9E7HwLKxoU6teLeWa
 nma7acZV3mdGluzhe5GIQIwK8ODyVDD4xqOXJofpjN5avoEt7cd5BBoKREBF1OZsEwdY
 4QWg==
X-Gm-Message-State: AOAM531h+Eg9YMDoUTFP37ELdd9Xk49rVEbrd+kiHfIK4MBYuACELIn8
 BikHV1780PvYtiZK5JbFcOcoGm7f5I0=
X-Google-Smtp-Source: ABdhPJxAQwznYPV6MAoBfMRQFrDmKEV+jXgKMF9phpFxo3XZSwyMOTNR648GTwsCOWFaw51OGzFghg==
X-Received: by 2002:a17:902:328:: with SMTP id
 37mr13148955pld.35.1590114908766; 
 Thu, 21 May 2020 19:35:08 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gt10sm5443755pjb.30.2020.05.21.19.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 19:35:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 21/25] ppc64: Use uint64_t to represent double
Date: Thu, 21 May 2020 19:34:36 -0700
Message-Id: <20200522023440.26261-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522023440.26261-1-richard.henderson@linaro.org>
References: <20200522023440.26261-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to do exact bitwise comparisons of the data,
not be held hostage to IEEE comparisons and NaNs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu_reginfo_ppc64.h |  3 ++-
 risu_reginfo_ppc64.c | 29 +++++++++--------------------
 2 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/risu_reginfo_ppc64.h b/risu_reginfo_ppc64.h
index 7f2c962..4b1d8bd 100644
--- a/risu_reginfo_ppc64.h
+++ b/risu_reginfo_ppc64.h
@@ -20,7 +20,8 @@ struct reginfo {
     uint64_t nip;
     uint64_t prev_addr;
     gregset_t gregs;
-    fpregset_t fpregs;
+    uint64_t fpregs[32];
+    uint64_t fpscr;
     vrregset_t vrregs;
 };
 
diff --git a/risu_reginfo_ppc64.c b/risu_reginfo_ppc64.c
index c80e387..9899b36 100644
--- a/risu_reginfo_ppc64.c
+++ b/risu_reginfo_ppc64.c
@@ -45,6 +45,7 @@ int reginfo_size(struct reginfo *ri)
 void reginfo_init(struct reginfo *ri, ucontext_t *uc)
 {
     int i;
+
     memset(ri, 0, sizeof(*ri));
 
     ri->faulting_insn = *((uint32_t *) uc->uc_mcontext.regs->nip);
@@ -54,16 +55,11 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
         ri->gregs[i] = uc->uc_mcontext.gp_regs[i];
     }
 
-    for (i = 0; i < NFPREG; i++) {
-        ri->fpregs[i] = uc->uc_mcontext.fp_regs[i];
-    }
+    memcpy(ri->fpregs, uc->uc_mcontext.fp_regs, 32 * sizeof(double));
+    ri->fpscr = uc->uc_mcontext.fp_regs[32];
 
-    for (i = 0; i < 32; i++) {
-        ri->vrregs.vrregs[i][0] = uc->uc_mcontext.v_regs->vrregs[i][0];
-        ri->vrregs.vrregs[i][1] = uc->uc_mcontext.v_regs->vrregs[i][1];
-        ri->vrregs.vrregs[i][2] = uc->uc_mcontext.v_regs->vrregs[i][2];
-        ri->vrregs.vrregs[i][3] = uc->uc_mcontext.v_regs->vrregs[i][3];
-    }
+    memcpy(ri->vrregs.vrregs, uc->uc_mcontext.v_regs->vrregs,
+           sizeof(ri->vrregs.vrregs[0]) * 32);
     ri->vrregs.vscr = uc->uc_mcontext.v_regs->vscr;
     ri->vrregs.vrsave = uc->uc_mcontext.v_regs->vrsave;
 }
@@ -91,10 +87,6 @@ int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
     }
 
     for (i = 0; i < 32; i++) {
-        if (isnan(m->fpregs[i]) && isnan(a->fpregs[i])) {
-            continue;
-        }
-
         if (m->fpregs[i] != a->fpregs[i]) {
             return 0;
         }
@@ -141,10 +133,10 @@ int reginfo_dump(struct reginfo *ri, FILE * f)
     fprintf(f, "\tdscr   : %16lx\n\n", ri->gregs[44]);
 
     for (i = 0; i < 16; i++) {
-        fprintf(f, "\tf%2d: %.4f\tf%2d: %.4f\n", i, ri->fpregs[i],
+        fprintf(f, "\tf%2d: %016lx\tf%2d: %016lx\n", i, ri->fpregs[i],
                 i + 16, ri->fpregs[i + 16]);
     }
-    fprintf(f, "\tfpscr: %f\n\n", ri->fpregs[32]);
+    fprintf(f, "\tfpscr: %016lx\n\n", ri->fpscr);
 
     for (i = 0; i < 32; i++) {
         fprintf(f, "vr%02d: %8x, %8x, %8x, %8x\n", i,
@@ -181,13 +173,10 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
     }
 
     for (i = 0; i < 32; i++) {
-        if (isnan(m->fpregs[i]) && isnan(a->fpregs[i])) {
-            continue;
-        }
-
         if (m->fpregs[i] != a->fpregs[i]) {
             fprintf(f, "Mismatch: Register f%d\n", i);
-            fprintf(f, "m: [%f] != a: [%f]\n", m->fpregs[i], a->fpregs[i]);
+            fprintf(f, "m: [%016lx] != a: [%016lx]\n",
+                    m->fpregs[i], a->fpregs[i]);
         }
     }
 
-- 
2.20.1


