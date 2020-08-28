Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E34FC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:22:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 537D42054F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="peFYGHyy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537D42054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfGc-0004fw-H1
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfE8-0007p0-Rw
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:19:36 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38928)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfE7-000515-3W
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:19:36 -0400
Received: by mail-pg1-x541.google.com with SMTP id v15so524833pgh.6
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LfqpuF2wNDM0fswn7p/0qMKThcYJi8mNAXbQlEHPUSw=;
 b=peFYGHyyfRoK1cqkXVXZemlhp+wWLD4rGmYUfKmu1CJp1ILW2s/iEbz0T1nbeYcQO2
 CLNfg+9YjtkwTdGIV6IUp70eZLunCvXzvIOfzVCoFWYMBF1OeeUzVpHXgttudpPaIibQ
 fKfD3gb7uYmXHsdBaRf4OdtkY0Gqf/kK24ESmC+Kp4MSYBb54DwHL2spA7wZ5Jqxwz11
 ySI/+Un8r2fxonijiSF6p6Qv7zMMu0MB4yLrIRGKOclkNUeTaZ9KAGmWqmVihDrIMLRr
 OLvfThF8ikaHb+RLgpR3/J99zAFf0AigKr3QHl0udyFR3SvH+P/PhvBoixPRK+gcUVuz
 QdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LfqpuF2wNDM0fswn7p/0qMKThcYJi8mNAXbQlEHPUSw=;
 b=BduXBUMqytf6S3VHNWTqs+7Mpr7x8EAY8OextVJV4CLJwIGJgIe7UirhXkvMxBJFKo
 x9PM1II4LHZdmnhE+SU6b1NboWcSOZSXd52c07eDtWkXrHOgNFt0QcvMaAQ60P4AwRsg
 ymnvilpI0/V9Qh5aN4eCod8F/r9KJx/vWE4WfIMUY3l3fqfItR3BfmEOVIK1kozLODvi
 ZsKQ5daxlB6jHd0nteJvOKiBycGjMPsgPJnlQ+YCFmsZoYyI078HMAC7RERA7fWqwvOk
 hrhdNnJ0w6Bd9BEyDG9BIIqo+stp3Ejk0cVvV2UXlnz/KCLwODbCV/Fbi0clr/1STs5b
 dBCA==
X-Gm-Message-State: AOAM530Kln13VMhs2rFjn7/lYMJI0FWYhnxo01WaAJpv1Q2SBt9TyxEU
 bLDu27Iel/82ZIGGbsUYpIHK66pQX2Ubhw==
X-Google-Smtp-Source: ABdhPJzTcn2WZM14DBO5ekuTprCn9I7CFzpWtH9SP9aj55vz1Js7wgwK/FnFendbCA5Gbt6oZUkl0w==
X-Received: by 2002:a65:58c9:: with SMTP id e9mr1429009pgu.66.1598624373311;
 Fri, 28 Aug 2020 07:19:33 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:19:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/76] tests/tcg: Do not require FE_TOWARDZERO
Date: Fri, 28 Aug 2020 07:18:15 -0700
Message-Id: <20200828141929.77854-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is optional in ISO C, and not all cpus provide it.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/multiarch/float_convs.c | 2 ++
 tests/tcg/multiarch/float_madds.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tests/tcg/multiarch/float_convs.c b/tests/tcg/multiarch/float_convs.c
index 47e24b8b16..e9be75c2d5 100644
--- a/tests/tcg/multiarch/float_convs.c
+++ b/tests/tcg/multiarch/float_convs.c
@@ -30,7 +30,9 @@ float_mapping round_flags[] = {
 #ifdef FE_DOWNWARD
     { FE_DOWNWARD, "downwards" },
 #endif
+#ifdef FE_TOWARDZERO
     { FE_TOWARDZERO, "to zero" }
+#endif
 };
 
 static void print_input(float input)
diff --git a/tests/tcg/multiarch/float_madds.c b/tests/tcg/multiarch/float_madds.c
index eceb4ae38b..e422608ccd 100644
--- a/tests/tcg/multiarch/float_madds.c
+++ b/tests/tcg/multiarch/float_madds.c
@@ -29,7 +29,9 @@ float_mapping round_flags[] = {
 #ifdef FE_DOWNWARD
     { FE_DOWNWARD, "downwards" },
 #endif
+#ifdef FE_TOWARDZERO
     { FE_TOWARDZERO, "to zero" }
+#endif
 };
 
 
-- 
2.25.1


