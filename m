Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9268C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:46:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 854F4207E8
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mjM7rw4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854F4207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnosg-0004ek-IM
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 15:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojQ-0003dB-5W
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:20 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35233)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojO-0005cK-7p
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:19 -0400
Received: by mail-pf1-x442.google.com with SMTP id h185so10566395pfg.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 12:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j9052jJr3KmnjYv00hnljbuK29UeNui26+Zt9JfEPLY=;
 b=mjM7rw4f1Jmd4a7uiswEjHHpsmY1la2ambYehWS/V1AiKpzqsN7Bf0wk5Myh+VtpkL
 vRxSpGe8+DAw/6B8CBrzP86aTBlxHYdZaqUKB7RDqMiDV5SV8a/j+doCEgLi1h2J4y4N
 jdwcIb/ZRsB0ntEWRlFuLDWWe2GY3dpxLDOWWC2BgirbJHerie7zJ7RbI/cGqQyeXehp
 1ox35pvkTAcPltlxCmh/Iqx9U9mPQlPqmeOceoHhuT0BSUa5rE7ivRpNgMr8OGH2tKdR
 i7e3QnB1F8ivlUx+VhXUAfB8MTS5K0P45tcKVZ0l+EdjM4jLbVfLp5/WburJoraqSFLX
 YXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j9052jJr3KmnjYv00hnljbuK29UeNui26+Zt9JfEPLY=;
 b=ECLwSybdWHQ+xlhlMgoJt2E1Mi5QHY9HNxWtsqbWq0hvrRYjufecEMqYcV/rQC725S
 ZXJaf3BJxX3sI7ZI2lORIozIkkozvwWChEwVzIsIqTwu503L2gRLMg8n7MwYLIjFs9m4
 WI4wBCtzOhlGqUcArt1DVG17MTI5M3zGtOCmk2Feyz/jCUmFBJQvSCQG8K5leUv8xPt4
 sb+fgCKrRGRBA3JsKtuvP56ZnaQoyedZKcjPkGGtRzfdYs3XAZqV5egEu1lDGsfO22+I
 MrNsA+o0KFJrtIu90XULKC4NbH+1O6NG2Gw4T65VycBc/0zV3W71fk9JKfEUG4K1iAop
 FhhQ==
X-Gm-Message-State: AOAM5327OOiSxF7SHT7+q+AmnEE5/JfaoB5QroN9C6jI8vkovg9IvBNP
 PgQ+gUXJhhJoL/KNhSk8DrRLc1vN6Ww=
X-Google-Smtp-Source: ABdhPJxUQNuO7KTS4Xrt0182e7iOOhPKA5s53t3C8HjSdEUA8YnOBtxWG4B4TuV1iAxTD4FIwiHRkg==
X-Received: by 2002:a63:5a60:: with SMTP id k32mr18367293pgm.73.1592941036592; 
 Tue, 23 Jun 2020 12:37:16 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p12sm17927642pfq.69.2020.06.23.12.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 12:37:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 12/45] target/arm: Implement the GMI instruction
Date: Tue, 23 Jun 2020 12:36:25 -0700
Message-Id: <20200623193658.623279-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623193658.623279-1-richard.henderson@linaro.org>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
v6: Inline the operation.
---
 target/arm/translate-a64.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e9bc7e90af..255365e76c 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5346,6 +5346,21 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
                                              cpu_reg_sp(s, rn));
         }
         break;
+    case 5: /* GMI */
+        if (sf == 0 || !dc_isar_feature(aa64_mte_insn_reg, s)) {
+            goto do_unallocated;
+        } else {
+            TCGv_i64 t1 = tcg_const_i64(1);
+            TCGv_i64 t2 = tcg_temp_new_i64();
+
+            tcg_gen_extract_i64(t2, cpu_reg_sp(s, rn), 56, 4);
+            tcg_gen_shl_i64(t1, t1, t2);
+            tcg_gen_or_i64(cpu_reg(s, rd), cpu_reg(s, rm), t1);
+
+            tcg_temp_free_i64(t1);
+            tcg_temp_free_i64(t2);
+        }
+        break;
     case 8: /* LSLV */
         handle_shift_reg(s, A64_SHIFT_TYPE_LSL, sf, rm, rn, rd);
         break;
-- 
2.25.1


