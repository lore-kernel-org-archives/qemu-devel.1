Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00938C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:21:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0A6D2072F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NtTPwYY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A6D2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgI5c-0001OM-SX
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyM-0003qb-2J
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:39 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42494)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyJ-0003YW-QE
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:36 -0400
Received: by mail-pl1-x641.google.com with SMTP id x11so194106plv.9
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 18:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e60Bq5SlAYtW55DZqRQCRGGXcLnTZe8NHr+quQk/wbA=;
 b=NtTPwYY9PU7sn13lSWl2GMDyhBoH9IxK9qoGwFkNqo4bECzelUhm29RunktbGUOOHm
 AftSaMCpkEW2V7h9I0hct+lLkKdxu+OvHcTUXhYqf0q3xXNzR4CJlz4Pw0a1FKqdZ+H3
 6xoRoleY5oPiG3/qh0KUe5u/jaTDNFOWxrxhctPlmbINs3Dc6h/LM02IP9SYOX1DcOBa
 0cqiDPLxUXcVdGhhHawA5cMMVfLfu2RyrzrKNbSMjZWqrxsitWfo8B8mTgXI86c1XKce
 JMYgc6wi1EgFXBDfEZrTtPEyetq8toYyxIacCaXzfHWAvgPWno3GAZoXcdj9MJRyNOsh
 YBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e60Bq5SlAYtW55DZqRQCRGGXcLnTZe8NHr+quQk/wbA=;
 b=DAZWH02HhgjXEBzkYrlp96KZGIEAHkvA2W6XZ+wnyLQZFN9FvbuI84QKzy0lErmYz6
 Roufs6d46eWYg3oHbyE9UxQA2XHB/07AiFqMrveCIFDvzjbrfMGnvldbhoAy0XYQQPas
 imacr4BWruFRLPEvMf2e+5JemSAnXr0Mg+nTXLOZlIG7vAXqxKBku3moWoISKj0YgB0w
 Bl4KIJmYj6dcxVINh73XW1slrcvmF+dAXLv3CUKiMNZ4A0rVFEQ8QDaeV+8M9X/+w/4p
 co+wcXQblNwat7MUbcMblDzdp/1o8m/9NFi5TfK/d6l/ghKEkSGPnoJaBZ8WWmNcL01N
 nUOA==
X-Gm-Message-State: AOAM5303wAm/aGi/olhsS37d2UDQ+Qg+uw0uQtZC+EYn771oQ26TVdTq
 sQFAN8PURa6goAXrZdjiZrD1qFyKT5E=
X-Google-Smtp-Source: ABdhPJzLfpuSIRqS8IAt+4d64agFwbmnwUx6o225SdLRG3hMYKrKqY3Y8yXiICEbmjy+GA1PHJg44w==
X-Received: by 2002:a17:902:7783:: with SMTP id
 o3mr26908788pll.286.1591146812885; 
 Tue, 02 Jun 2020 18:13:32 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 3sm290067pfe.85.2020.06.02.18.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:13:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 11/42] target/arm: Implement the GMI instruction
Date: Tue,  2 Jun 2020 18:12:46 -0700
Message-Id: <20200603011317.473934-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011317.473934-1-richard.henderson@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v6: Inline the operation.
---
 target/arm/translate-a64.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index a18d71ad98..7d0b7d5b58 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5325,6 +5325,21 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
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


