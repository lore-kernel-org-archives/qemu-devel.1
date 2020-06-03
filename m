Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACDAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:35:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB4FC206A2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W2VpHdhl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4FC206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgIJd-0003za-6A
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyt-0005AP-Bd
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:14:11 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:39719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHys-0003hK-JE
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:14:10 -0400
Received: by mail-pl1-x644.google.com with SMTP id v24so199532plo.6
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 18:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uaH1sngv9xlWH/X8rZjic7q7Jho9e1jf1ezwAdUAR9c=;
 b=W2VpHdhlmXjJWldCJJ/AWBtSxY3UTYaz44DqxLhKEiskonM1uXUpPuN29hCgBFhPvP
 gA7YjjtvTHhJ8fx92XaeSMXl0EFMTDiukC9LU3Yk9lybiGySoCD1FPyYl6zvjVsQjQ/1
 bQ2EaThf9TApdkDsf/53X/YavAdnEWivRfC/g5t8sKJoQ31aoYdEOBXNRTkUlsEOj/HF
 pEy7asfNnWtpbtpB+r/l0jBmQgdZTeeqoGSkuw3PxtzqKW4l1RH1ulpfwhNN323u4vCQ
 18fu0Mjvz++aU6Vdi5E0zAATT6NdUkmOwx78uuxXr/TJyE2Pn5x+g6UZwh7ulqF3O9zU
 EG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uaH1sngv9xlWH/X8rZjic7q7Jho9e1jf1ezwAdUAR9c=;
 b=iNPNSEr/nAz5FBq2KlQyYWCeL7FNzZx1c1toZhctfds+lBE7pvQ0QLf8rpeBKbqc4w
 y885PdDp2PO2Dy7zXb8j/BfuFPsIpqQIybwmm4IJBfHCcu9scbJhOnmrXPFsA6Czmj5T
 jLnHmfVZuBdZweEUWZdve1lWahpz1+HByT7koJg4u+jBmIbBeWLOA7DADh+ZRooTP3ZM
 FIRbToJQAJkD/N9aUZb1AL7XR2yCycraAvdcVG8k1VszUs6H+3wunhc00+gd491DT0zW
 cDOUycMtQ8LXz51jUtKBlLWsgXwj4qWVTD/otBGahvR8ph2uglQzy5t3zcOSuzbYC4Di
 K9Tg==
X-Gm-Message-State: AOAM530swloX/ZJovSUyoEUyU1IGuG88WYwVpW+Tos02HvzVLz+0VfhQ
 nDk/dImhWe18qn+I+9hx37fVKyD57HE=
X-Google-Smtp-Source: ABdhPJxlz0U+OGynw30ChSMQGFOTZv+xNdIiO/NkvaO1oF/jXC+QHVGJok/SKi6Wu0syZRMm+Lp/AA==
X-Received: by 2002:a17:902:d711:: with SMTP id
 w17mr28235658ply.122.1591146848946; 
 Tue, 02 Jun 2020 18:14:08 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 3sm290067pfe.85.2020.06.02.18.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:14:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 38/42] target/arm: Set PSTATE.TCO on exception entry
Date: Tue,  2 Jun 2020 18:13:13 -0700
Message-Id: <20200603011317.473934-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011317.473934-1-richard.henderson@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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

D1.10 specifies that exception handlers begin with tag checks overridden.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Only set if MTE feature present.
---
 target/arm/helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3adafc07f0..50717afa4a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9702,6 +9702,9 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
             break;
         }
     }
+    if (cpu_isar_feature(aa64_mte, cpu)) {
+        new_mode |= PSTATE_TCO;
+    }
 
     pstate_write(env, PSTATE_DAIF | new_mode);
     env->aarch64 = 1;
-- 
2.25.1


