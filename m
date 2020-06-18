Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7ECC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 896E72186A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zooqHr37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896E72186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmYE-0004gb-PQ
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmBW-00008k-6u
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:29:54 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b]:50782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmBU-0002w4-Hw
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:29:53 -0400
Received: by mail-pj1-x102b.google.com with SMTP id jz3so1971288pjb.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+BnZTXdpODaLZrkJCZ0Kk78XEvL6jEYXh84gw/7MXns=;
 b=zooqHr37d3dgq72OAAPoLM7+SQOwlYQPFk7LMcRscbWHELI2AE5duwHy8qr5hJsqZv
 8Qa6bAQbalPEUrVEeEc9X+XY520i2YTju1xcb7gjfHLyBgQhNfIiEiUti3kNTTSwY37s
 eJ2ub+1NTjFJZdP5CnpR79Y537JsHKkXiB3VGglEmu4BOAcmzF5fPUulGc/WzHWoCm60
 JhJg22/f1NuPKghSQ5wzF6BHOCP4Uc9S+3+iGR91PBL1Y/89OAjagTe3fq03Z8czTr+D
 G4rnUQUMRM6X5ZpAm6+u9JMUXeBBPWeLHvtKvLpUjZxQUPZ8G2rsnLtwkUzjF4E0sbac
 Uk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+BnZTXdpODaLZrkJCZ0Kk78XEvL6jEYXh84gw/7MXns=;
 b=FOpL7QS02Id152glZmgvFiqszpP/xaBs6VlrUQnRJ0vRpJPGDJuO2dxRRGouEdW/BR
 nf+wcoDXHr9qxP/Qt5/5XVnMT5TILkS7ySgKxF0rGpmbQod3Yc8k+NnCUiJIPhGO61FU
 fTPfu85038c5pZ5XhWXzh4ebzHUtQfbJ/2hWv3ydkAheleAtUiQq8e0V03nukyaQVtyd
 QEFXa/bna8NkRZczT2c44WmMdQavZvH+AayqmrjzL1w8hVB5MYs/XwPHMFq2EvBVQ2da
 g4yohV1e6XSE0kfSvsmNMPnsdFszjkyh+pNnOXxeiNszcMgUGcL34FF470yYTjBlT8DM
 472Q==
X-Gm-Message-State: AOAM530B/bnGn32K5XiNtHpLWijowgpQ6frY7F5/jcSzRMu2JSmdTW03
 FsadNIOKYM8tdBEw3uRms+pkPRdv4GQ=
X-Google-Smtp-Source: ABdhPJwOPc2uQHmKTYWi4OJIs8bP/rNyL6y1pX46uygs/PBftfuLezdBWx713yDJVVLQUrxyZex65w==
X-Received: by 2002:a17:902:c404:: with SMTP id
 k4mr1954524plk.99.1592454590859; 
 Wed, 17 Jun 2020 21:29:50 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id j17sm1157899pgk.66.2020.06.17.21.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:29:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 046/100] target/arm: Implement SVE2 WHILERW, WHILEWR
Date: Wed, 17 Jun 2020 21:25:50 -0700
Message-Id: <20200618042644.1685561-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Fix decodetree typo
---
 target/arm/sve.decode      |  3 ++
 target/arm/translate-sve.c | 62 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index b7038f9f57..19d503e2f4 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -702,6 +702,9 @@ CTERM           00100101 1 sf:1 1 rm:5 001000 rn:5 ne:1 0000
 # SVE integer compare scalar count and limit
 WHILE           00100101 esz:2 1 rm:5 000 sf:1 u:1 lt:1 rn:5 eq:1 rd:4
 
+# SVE2 pointer conflict compare
+WHILE_ptr       00100101 esz:2 1 rm:5 001 100 rn:5 rw:1 rd:4
+
 ### SVE Integer Wide Immediate - Unpredicated Group
 
 # SVE broadcast floating-point immediate (unpredicated)
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index dc6f39b5bb..97e26c8ff5 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3227,6 +3227,68 @@ static bool trans_WHILE(DisasContext *s, arg_WHILE *a)
     return true;
 }
 
+static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
+{
+    TCGv_i64 op0, op1, diff, t1, tmax;
+    TCGv_i32 t2, t3;
+    TCGv_ptr ptr;
+    unsigned desc, vsz = vec_full_reg_size(s);
+
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    op0 = read_cpu_reg(s, a->rn, 1);
+    op1 = read_cpu_reg(s, a->rm, 1);
+
+    tmax = tcg_const_i64(vsz);
+    diff = tcg_temp_new_i64();
+
+    if (a->rw) {
+        /* WHILERW */
+        /* diff = abs(op1 - op0), noting that op0/1 are unsigned. */
+        t1 = tcg_temp_new_i64();
+        tcg_gen_sub_i64(diff, op0, op1);
+        tcg_gen_sub_i64(t1, op1, op0);
+        tcg_gen_movcond_i64(TCG_COND_LTU, diff, op0, op1, diff, t1);
+        tcg_temp_free_i64(t1);
+        /* If op1 == op0, diff == 0, and the condition is always true. */
+        tcg_gen_movcond_i64(TCG_COND_EQ, diff, op0, op1, tmax, diff);
+    } else {
+        /* WHILEWR */
+        tcg_gen_sub_i64(diff, op1, op0);
+        /* If op0 >= op1, diff <= 0, the condition is always true. */
+        tcg_gen_movcond_i64(TCG_COND_GEU, diff, op0, op1, tmax, diff);
+    }
+
+    /* Bound to the maximum.  */
+    tcg_gen_umin_i64(diff, diff, tmax);
+    tcg_temp_free_i64(tmax);
+
+    /* Since we're bounded, pass as a 32-bit type.  */
+    t2 = tcg_temp_new_i32();
+    tcg_gen_extrl_i64_i32(t2, diff);
+    tcg_temp_free_i64(diff);
+
+    desc = (vsz / 8) - 2;
+    desc = deposit32(desc, SIMD_DATA_SHIFT, 2, a->esz);
+    t3 = tcg_const_i32(desc);
+
+    ptr = tcg_temp_new_ptr();
+    tcg_gen_addi_ptr(ptr, cpu_env, pred_full_reg_offset(s, a->rd));
+
+    gen_helper_sve_whilel(t2, ptr, t2, t3);
+    do_pred_flags(t2);
+
+    tcg_temp_free_ptr(ptr);
+    tcg_temp_free_i32(t2);
+    tcg_temp_free_i32(t3);
+    return true;
+}
+
 /*
  *** SVE Integer Wide Immediate - Unpredicated Group
  */
-- 
2.25.1


