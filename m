Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9596AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:43:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60E9320C09
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GndXWjr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E9320C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnopa-0007Dx-Lm
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 15:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojR-0003fu-3j
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:21 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37280)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojP-0005dK-FC
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:20 -0400
Received: by mail-pg1-x542.google.com with SMTP id d4so23426pgk.4
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 12:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z5s5rlUW9GYPPG56wEDdplRqZCi6Mno4b3nIg0xdsbg=;
 b=GndXWjr/vLzec/dg0qlbL3Lo2e+bmEpc/taP9Tpv8OJy3lTXDma4Dy7Igkgh9AqNHX
 jghMQVGw0sFYBdA7l/Heb2JHn+BvSupMxZv5JDYpVFSybFgdzdrm5u3WDpmm/eUoZ27l
 D0hkZBGKrsOS136ngvPKAqyZeET02jo8KREFyf6o+4ZAxExJYs4vtqamJRKdaeP+/1jW
 +VwdxX/XIM+/voUsCzWdsqGMkrnbeSpAPe5MPORhRT1ls5rsjtdi82nOvu7OnUrIQrvb
 MBJTb7xj2VQVxdT2h4OcS8qkp+1XQXf7I7J66gUcXHDmQIqilB/sFIwTL5PiFPPXA5hZ
 CivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z5s5rlUW9GYPPG56wEDdplRqZCi6Mno4b3nIg0xdsbg=;
 b=BkvR6zYKGMXcuKmiQG+XsyH906AtKTezrr3vcHnn8JhGkBjH0a6QfmuR95JMIF/ae/
 KPZqcfyNR6VG7xHs6EA4OWqZhId1g+cgLVN7HpHzx8/TL0sZwGJyrVcpb7DmNAaCITlc
 Ruzx4HjnsoifPKqh2SPKMEu000HTyX2wtT7Q5yNWrdLEZziF95uFB/YCytIeKg+kdjm1
 3J0ZVuVEsAMP0pkIhvoJZim8AW1j4h7y+o/RcrL2tuk9KwLkv16bJ/nlW/1k8bOOh+qF
 Q68u1Tisi8qNjmpyxhfNpPFGHhAMI64lX/aeVOoozujsPGsnkGR8o8t/GlaRjkqMVbMq
 AdmQ==
X-Gm-Message-State: AOAM531fVknpXBzpVvgGGesllNOV5zM9jHR2DX/6ZRNO36xUPvBFGGgi
 prQdptg+XdQp+0yo2/wkSQUdbxgL4vY=
X-Google-Smtp-Source: ABdhPJxxoQq537wYkMStATrjOKvNkLID9W15taLPs2M9u5h+bjLgSAB/Gia/romZMS6aOezx01xq9g==
X-Received: by 2002:a65:52c8:: with SMTP id z8mr18264082pgp.266.1592941037791; 
 Tue, 23 Jun 2020 12:37:17 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p12sm17927642pfq.69.2020.06.23.12.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 12:37:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 13/45] target/arm: Implement the SUBP instruction
Date: Tue, 23 Jun 2020 12:36:26 -0700
Message-Id: <20200623193658.623279-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623193658.623279-1-richard.henderson@linaro.org>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
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
index 255365e76c..5400516eef 100644
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


