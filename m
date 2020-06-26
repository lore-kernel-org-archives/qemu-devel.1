Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433C0C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EDFE20709
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GCS7ndOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EDFE20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jofCb-0004NK-A4
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof60-0008Hl-4v
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:08 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36644)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof5x-0001pe-Mm
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:07 -0400
Received: by mail-pl1-x643.google.com with SMTP id j4so3759244plk.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9VktHgFQx2o6nxM6k3GXsxowwhTU3U8IYM5wfKQDVUU=;
 b=GCS7ndOdhtmGiRT3bttVFP99zs/C5VoepWdq4imRRP6AzsZjhRRTS5dGDwj0TNWYcB
 o3VUuVDV/yVbsachXUMSafGYMqlbJinP8g9tWPZ/RzFo0Vas0lM8gJlie2NL4SAy9Dkk
 KkXfFeo9aobNjCJ4ch65E/JjbssqwAza2Dx1u+o8Ct1Tg+JEB49J0faT7VStqyHElbQY
 rmhnxFcHDwEDlz2ao8NvRxJdLHFR2yLO41BNqXDnAei1Uapf4wPh7TzlOEYRjxilPFps
 o9k0fygsn2zcO0SL9jn1Iq/WESjnbqEKOhXkM/6lMs5xHPgmERV8z8TVamNqh48uPL/M
 vx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9VktHgFQx2o6nxM6k3GXsxowwhTU3U8IYM5wfKQDVUU=;
 b=nFmmhRMW6bO8VLOx1UefsnZDBntfXZn6+pCigEy3tXUBmAG4l/pw50gHT5ruHwarX9
 eQH5jXyQNgUF9tl60wJMAFifUANiYHPpjGsOrwkTvKqDK2PcAmG6m6zdhjat1LgT1U0d
 e4OvCfeTi185nniG9uhbNaevitGnciyXmrBHMsqDgz7i6KNf6IY9pvYdLADFmFDs8baC
 g8XHVj0cZjI8bsHT+aazRdrJ3wCo6DJE9CFE7NgfOkZHegbqt+PXL9RtG/DXnv5iHOlq
 /2cBdcPo4HrN/py+7b2RzG/bxt00uC7X6D5WYCPcnUQN5pkXg28oWcHEp31yhymxBw5x
 PWDQ==
X-Gm-Message-State: AOAM531EwQMd7S1PxOheSwn4/7vctMe5sGchcbVNM85wIFN1QNs1B1Om
 HF3o05wXN4oJ4m1MwuAFj3QWLN2kALM=
X-Google-Smtp-Source: ABdhPJzly5piTOg2AAUfy8OdFFH6xj0TQfu6v0lKOMBvo/XPoZ8V2ILDDmUUvlVELHBhN4PKCloR9A==
X-Received: by 2002:a17:902:9346:: with SMTP id g6mr856717plp.19.1593142324074; 
 Thu, 25 Jun 2020 20:32:04 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:32:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 13/46] target/arm: Implement the SUBP instruction
Date: Thu, 25 Jun 2020 20:31:11 -0700
Message-Id: <20200626033144.790098-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
References: <20200626033144.790098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Fix extraction length.
---
 target/arm/translate-a64.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index ee9dfa8e43..abbcdbb53a 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5315,19 +5315,39 @@ static void handle_crc32(DisasContext *s,
  */
 static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
 {
-    unsigned int sf, rm, opcode, rn, rd;
+    unsigned int sf, rm, opcode, rn, rd, setflag;
     sf = extract32(insn, 31, 1);
+    setflag = extract32(insn, 29, 1);
     rm = extract32(insn, 16, 5);
     opcode = extract32(insn, 10, 6);
     rn = extract32(insn, 5, 5);
     rd = extract32(insn, 0, 5);
 
-    if (extract32(insn, 29, 1)) {
+    if (setflag && opcode != 0) {
         unallocated_encoding(s);
         return;
     }
 
     switch (opcode) {
+    case 0: /* SUBP(S) */
+        if (sf == 0 || !dc_isar_feature(aa64_mte_insn_reg, s)) {
+            goto do_unallocated;
+        } else {
+            TCGv_i64 tcg_n, tcg_m, tcg_d;
+
+            tcg_n = read_cpu_reg_sp(s, rn, true);
+            tcg_m = read_cpu_reg_sp(s, rm, true);
+            tcg_gen_sextract_i64(tcg_n, tcg_n, 0, 56);
+            tcg_gen_sextract_i64(tcg_m, tcg_m, 0, 56);
+            tcg_d = cpu_reg(s, rd);
+
+            if (setflag) {
+                gen_sub_CC(true, tcg_d, tcg_n, tcg_m);
+            } else {
+                tcg_gen_sub_i64(tcg_d, tcg_n, tcg_m);
+            }
+        }
+        break;
     case 2: /* UDIV */
         handle_div(s, false, sf, rm, rn, rd);
         break;
-- 
2.25.1


