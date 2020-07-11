Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9DEC433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:12:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B90C2078B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5IVNUF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B90C2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juDR1-0004VU-Av
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 07:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1juDMM-0004Yc-Fq
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 07:07:58 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43088)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1juDMK-0006Np-U5
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 07:07:58 -0400
Received: by mail-pl1-x641.google.com with SMTP id x8so3294775plm.10
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 04:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R0mDmcoY1c/T6ValqPe48xOd9C3NnWvFmUKnHSHnR6s=;
 b=U5IVNUF1v1ZRNszumu/BmY2RU7Q5y7Mq+c5Rsvb73555YghxW4FsthwtvHmLrgIjhL
 Ug7+u/hPUFCzD8H8zOde5ffLb6h9vkJ2rZVIh30i7d6YvvauVAdB9zirnBPqktInCHSW
 LJyXdGk6DFhvhBDII2aDwUxf3f00+XJDcln33ttZVWXWfHRRFj1vtvrZ5SkGrDLUswtw
 LhFn680Q007n03uzemaxuO7K95JiXmQ82ebHWy5oxINELySQCHxXHztzybhZY2qst/H/
 14MUu0U6YJcSuwlwjX2g8ftvSL8mXJaPAvK18PP2d3YC03WzXf/EHeJNWAbaHSvdQfrJ
 XkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R0mDmcoY1c/T6ValqPe48xOd9C3NnWvFmUKnHSHnR6s=;
 b=nenpKPSCbNmGLStSCaip1oyOkq8jGdoCkkQ2dCZ1GHEZl1LTZ0wXIFdR6HRyzraeOz
 ++PlXDhAQqbvDObuMtnRHUn+kP4yDcPgxxQB8+Q+6I2hcg2QdBWxixa38smN0Ocu2iA+
 Ie5nC4oyu4gjf5IZo7/7F478tMIj4kExpNi5m/cTdUD9KWPGNj0N83ZgJH2BcvAZqTCT
 7/ns1HcSMnw0MEVttCe2v+cf97hfGucWjps7FlRsgAaJw/PqU8b5C27UA5slK2sg1IvE
 dcNFYUOWXJWknHWrsNUIspfymy3yr20/79KPDnNqf7Sa9cnMOb3UiTugmDaLX1k46svq
 r99Q==
X-Gm-Message-State: AOAM530SaOW+3HlmcZQFX6dkRyi1qFqpzYsR/aiItfFQxnE2OEtid1Tf
 NLgTMoZGzl2J1yC33Qjg3IzodFch
X-Google-Smtp-Source: ABdhPJw78i50m5vqnLUYZlYzJGJD7LRNgVuWuMQUhoNmk9PPDyAThIMCV2h2XC0wPSOqOSM5m8rnVg==
X-Received: by 2002:a17:90a:d587:: with SMTP id
 v7mr10745660pju.29.1594465675460; 
 Sat, 11 Jul 2020 04:07:55 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id m31sm8925826pjb.52.2020.07.11.04.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 04:07:54 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 09/22] target/xtensa: add DFPU option
Date: Sat, 11 Jul 2020 04:06:44 -0700
Message-Id: <20200711110655.20287-10-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200711110655.20287-1-jcmvbkbc@gmail.com>
References: <20200711110655.20287-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Double precision floating point unit is a FPU implementation different
from the FPU2000 in the following ways:
- it may be configured with only single or with both single and double
  precision operations support;
- it may be configured with division and square root opcodes;
- FSR register accumulates inValid, division by Zero, Overflow,
  Underflow and Inexact result flags of operations;
- QNaNs and SNaNs are handled properly;
- NaN propagation rules are different.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v3->v4:
- new patch split from the next one

 target/xtensa/cpu.h          |  2 ++
 target/xtensa/overlay_tool.h | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 960f6573447f..6fc1565000b6 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -52,6 +52,8 @@ enum {
     XTENSA_OPTION_COPROCESSOR,
     XTENSA_OPTION_BOOLEAN,
     XTENSA_OPTION_FP_COPROCESSOR,
+    XTENSA_OPTION_DFP_COPROCESSOR,
+    XTENSA_OPTION_DFPU_SINGLE_ONLY,
     XTENSA_OPTION_MP_SYNCHRO,
     XTENSA_OPTION_CONDITIONAL_STORE,
     XTENSA_OPTION_ATOMCTL,
diff --git a/target/xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
index eb9f08af0bf6..9f0846c86b65 100644
--- a/target/xtensa/overlay_tool.h
+++ b/target/xtensa/overlay_tool.h
@@ -39,6 +39,26 @@
 #define XCHAL_HAVE_DEPBITS 0
 #endif
 
+#ifndef XCHAL_HAVE_DFP
+#define XCHAL_HAVE_DFP 0
+#endif
+
+#ifndef XCHAL_HAVE_DFPU_SINGLE_ONLY
+#define XCHAL_HAVE_DFPU_SINGLE_ONLY 0
+#endif
+
+#ifndef XCHAL_HAVE_DFPU_SINGLE_DOUBLE
+#define XCHAL_HAVE_DFPU_SINGLE_DOUBLE XCHAL_HAVE_DFP
+#endif
+
+/*
+ * We need to know the type of FP unit, not only its precision.
+ * Unfortunately XCHAL macros don't tell this explicitly.
+ */
+#define XCHAL_HAVE_DFPU (XCHAL_HAVE_DFP || \
+                         XCHAL_HAVE_DFPU_SINGLE_ONLY || \
+                         XCHAL_HAVE_DFPU_SINGLE_DOUBLE)
+
 #ifndef XCHAL_HAVE_DIV32
 #define XCHAL_HAVE_DIV32 0
 #endif
@@ -99,6 +119,9 @@
     XCHAL_OPTION(XCHAL_HAVE_CP, XTENSA_OPTION_COPROCESSOR) | \
     XCHAL_OPTION(XCHAL_HAVE_BOOLEANS, XTENSA_OPTION_BOOLEAN) | \
     XCHAL_OPTION(XCHAL_HAVE_FP, XTENSA_OPTION_FP_COPROCESSOR) | \
+    XCHAL_OPTION(XCHAL_HAVE_DFPU, XTENSA_OPTION_DFP_COPROCESSOR) | \
+    XCHAL_OPTION(XCHAL_HAVE_DFPU_SINGLE_ONLY, \
+                 XTENSA_OPTION_DFPU_SINGLE_ONLY) | \
     XCHAL_OPTION(XCHAL_HAVE_RELEASE_SYNC, XTENSA_OPTION_MP_SYNCHRO) | \
     XCHAL_OPTION(XCHAL_HAVE_S32C1I, XTENSA_OPTION_CONDITIONAL_STORE) | \
     XCHAL_OPTION(((XCHAL_HAVE_S32C1I && XCHAL_HW_VERSION >= 230000) || \
-- 
2.20.1


