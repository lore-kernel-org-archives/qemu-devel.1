Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5810C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:22:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B20C42072F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yUo6adD8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20C42072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgI6y-0004rc-Ur
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyN-0003rc-QN
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:41 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyJ-0003Yk-RF
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:39 -0400
Received: by mail-pl1-x642.google.com with SMTP id t7so209382plr.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 18:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TDw09kqIkbskRr4/kNgVUuxCkd+nzaukf7UqdETf1U0=;
 b=yUo6adD8xnB39ooYZVKvAMUokWhucdRFGYuFbSDUjdog0eTz3gh6UKycWetGt9Q+fB
 CgLP6dzFgmkT/9YSLPYp1iqba8ULo7ZkZNDC/NBIxXJFKw/Q7cBKQq84btLmQw4qX42p
 vZsQH52cJjxoP8w2wNaLAzr7jD788JtY+nkwld5Hyjv+cLpz/5PDleNX0LBVjDpzfiFZ
 ZRXk5w6qBa2KWaAE5hd6qCTKihBIX73UVJfFBsnW7k//6EAyVDfU0zwjevbgKDqzaNqT
 AyeIhnzyjMp/hNFOVF+dyUou6/sG0RNFNXY5BJ4AweqwQSNPb8+0iqGAU9VM1bk5mZFl
 kbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TDw09kqIkbskRr4/kNgVUuxCkd+nzaukf7UqdETf1U0=;
 b=kV7fDp7YBYjw5ZiynsRSt083j4o7PrEKmCksXWUpOSNJjI/q2uFCWqAKC+A0J95SQ4
 CpIcjNlM9bbR9WmhXYnRO0HNpcEY2c0TlDjch70CY2r9wJ6gmuMSpwJe+S4kkQa8I7/4
 sDKRr3z3WhntaikNmhIsfxTPp485WpaWuagWqpfAhLSHHiBCyFoFcudJCdUiaVaz5U/e
 rAayjcZQHjpSG2C/m4N8THs7x/PzOhgC8Jv+/IXq/QPrBGxW2dGV73MAlgcDvnIGgi/9
 oDj3x6CGDhIzX8+7gpsoB2VLinJgfE+X7+MYe0FTI0L5/6eQamxGU1graCAyqL9IsjmR
 Wqgw==
X-Gm-Message-State: AOAM533ExE2trNdVylyWP5q/P4pygCRyilCN8SeOad+JHQb57PI399Ww
 Uodv0scrX+bhq9hTdvGC4+mpWNs/Zrw=
X-Google-Smtp-Source: ABdhPJzgNdTGtQxa9HHnlt2EnoPWiqWzL9n+zX745GSbf/gyE82PykEK21BZw3yI/CbnINR0nZhXPw==
X-Received: by 2002:a17:902:aa92:: with SMTP id
 d18mr27914389plr.127.1591146814331; 
 Tue, 02 Jun 2020 18:13:34 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 3sm290067pfe.85.2020.06.02.18.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:13:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 12/42] target/arm: Implement the SUBP instruction
Date: Tue,  2 Jun 2020 18:12:47 -0700
Message-Id: <20200603011317.473934-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011317.473934-1-richard.henderson@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, steplong@quicinc.com
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
index 7d0b7d5b58..0ee2ef403e 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5294,19 +5294,39 @@ static void handle_crc32(DisasContext *s,
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


