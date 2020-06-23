Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7504FC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F8F2081A
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T5RXR/aV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F8F2081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnomd-0001YB-Gu
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 15:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojD-0003BF-I5
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:07 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:33122)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojA-0005Uf-01
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:07 -0400
Received: by mail-pf1-x433.google.com with SMTP id f9so1731452pfn.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 12:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=udQrbI6Tw9/vGRMuSJ3l4nv9mjeaNNPNMMavnVln8O8=;
 b=T5RXR/aVcos3lQjNNAEVCLAyslHCr55JEJnwUyAkeoGbWo1k9Ww8KHGc/z2NTLQCCS
 P4rM4H1uQkyW80vkEUDC58/ksQuNbGVIkaYMZ0fqtOSzyEAk0IYYsUxAMpkMzNTxv+4W
 BamdiJxUO9bNAo22YJkfQDjT+eK1wfb6gOFQZD+pDl3ly8ZhxEG7vBARBoo5kx8UjjmK
 8sU+I0+2V51YiodztY5iIng98/tHMeav+EBo9tcfkDw6oMEbMvmZlRebem286tMAVz61
 GnBWsN5o+knHpnmRjFJ9C/6HmPZCr3s+rxLLV4K7bSArlC0HqIx31HeYBZ99Xnk6P9Bt
 p4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=udQrbI6Tw9/vGRMuSJ3l4nv9mjeaNNPNMMavnVln8O8=;
 b=emOu+3KQbWn2xekA4hnDMyXuDUnXpEXXmfaz+8EnDzttYbQQbbwTaeIMaBpbI19pHH
 Sv8Xm8v3LhxJXb5MskeEyhci/17vW+w4HLPOWBbNFDrZncrw+0Tg+MJ1A8AEYJhH59T+
 t2iR+pvyCrkvXDWSZUmDdkMwL1803jDcWI/wgTbwMnUannLnuYNiWwF+x/YGlFO/B8p+
 0/CjbVUJkOVGBaqotXWUgdo5vf0WOzRItww9GA5MaaXVLTpEQMLIb1Ae2oXWaMl+02j8
 +NQR1PG3xdiOIAwBoXMHgyIB3QstQUndNacqtikCwuk+ttA19XRYB+zhh/U/gKDq1O8I
 d7oA==
X-Gm-Message-State: AOAM530wr+4xnfkWKW72yqiphRenU/aj1hF2AC2oRnoa+w7N0mooSwHx
 p/n4hPovf8Y1yedLtXuFHqCqoBk5Yl4=
X-Google-Smtp-Source: ABdhPJyhTBd1/oSLRo7hWiEwoJ4+o2rCTrB/Es63EM7nypg976eK+QpzRBQAZHh3uk3+qEKt6OSwVQ==
X-Received: by 2002:a63:e707:: with SMTP id b7mr19120038pgi.35.1592941022227; 
 Tue, 23 Jun 2020 12:37:02 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p12sm17927642pfq.69.2020.06.23.12.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 12:37:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 01/45] target/arm: Add isar tests for mte
Date: Tue, 23 Jun 2020 12:36:14 -0700
Message-Id: <20200623193658.623279-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623193658.623279-1-richard.henderson@linaro.org>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
 target/arm/cpu.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 677584e5da..f8ac11e73b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3814,6 +3814,16 @@ static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, BT) != 0;
 }
 
+static inline bool isar_feature_aa64_mte_insn_reg(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) != 0;
+}
+
+static inline bool isar_feature_aa64_mte(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) >= 2;
+}
+
 static inline bool isar_feature_aa64_pmu_8_1(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) >= 4 &&
-- 
2.25.1


