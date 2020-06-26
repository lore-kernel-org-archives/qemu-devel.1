Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C601C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:32:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 448402080C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HASE1GBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448402080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqL4-00081Q-BT
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq42-0002CQ-Cm
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:50 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:33991)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq3x-0006JC-99
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:50 -0400
Received: by mail-wm1-x32d.google.com with SMTP id u26so9095741wmn.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=0jclhN1iI8Ils0M7tH4L8prj0mKxUP8gosaZhHheF7I=;
 b=HASE1GBTZmsW0//eemhsZdvHpYvDq7eTQhv0Pxnxuz2yMkdcE7TajImcK5b5ng01ZY
 858zW3VEdnaz/iWkxeRKTYN617GAYSeTfGbUPTYFpCOh7wwlnUPLJQTtdA4djQbj4zoY
 JvMbpELmCVw7N2jLYuY+RzJfZ394ig41hNSYLWexSu1lVtBg2BjYQ03vXXONGs6TAZCu
 qZ/57pvNSFy+AKMdi/im9DFMQrBc2gx2aLPHY4YYkqWfsziLTkedKAIba1icFRL4AxTH
 Ww/8cVNRPMBceS7nhhDAsRVsC8u1+35p6jBtExMtgyMZxUZvdNOTj51//AWvQKjyOKE4
 z3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0jclhN1iI8Ils0M7tH4L8prj0mKxUP8gosaZhHheF7I=;
 b=gP4s8PuQ2YEoc6A5ibUsBPoFtwEtKN4TJ6v3gIh3wp9oYBekDt6GVbVakhLbkQGHSv
 Vtpno3xtjcYZOD8v5w18u/QlkEHf5bN/fYvUtNwbkF7zt16xzZzajxesDg47C6LTsstT
 fRuFRR0Tz53ZEfyry/S7/0bM5vDwGG4YZvurJr1x+HMdIMfYhBZ0kYKSe1qOsqU1Zwfz
 tzq6ah98t7UIgzYty4AZetAWsd/ntSn+5HqKqtLXvkf1dSZV4krcpLovb8buMHCrwkwK
 FC2HTLuC/RR1ZIYmoKd8CO0XSrBRo5rGZ5wP8btItp0EA7k+s/vPCc+LkXXYoP1f1pT0
 7XEQ==
X-Gm-Message-State: AOAM530xNf+gyxk2RUSCLygzeNqE5mPlaAl0KC4FkUP4+Hv+dpPmWh6k
 B8OSk4A83ET/tQzDKolFRntrfHjJ5e/1Dw==
X-Google-Smtp-Source: ABdhPJwT97GDmfQwclQl0bbdVr5si7nN4+0sRWTxSvxHzuQEEE0J7YWNIEQNhVMabh2l7Dmn9HIPbA==
X-Received: by 2002:a7b:ca52:: with SMTP id m18mr3919302wml.92.1593184481073; 
 Fri, 26 Jun 2020 08:14:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.14.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:14:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/57] target/arm: Add isar tests for mte
Date: Fri, 26 Jun 2020 16:13:40 +0100
Message-Id: <20200626151424.30117-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200626033144.790098-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cf66b8c7fb0..ff70115801f 100644
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
2.20.1


