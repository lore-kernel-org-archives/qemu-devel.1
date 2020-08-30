Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8425FC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 02:33:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F7712075B
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 02:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hNeXNvho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7712075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCD9h-0004FG-GQ
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 22:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCD8g-0002en-0t
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 22:32:14 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:38749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCD8d-0002XS-M8
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 22:32:13 -0400
Received: by mail-pl1-x632.google.com with SMTP id t11so1427531plr.5
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 19:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+4RZCdMOsaMUmLqVgZAlaR32NMPZinL4K5nOFXnWb04=;
 b=hNeXNvhovHKc8cmmSF6P3EICfYFuUE2EI0kMk3PNr1KehLlUhJNYU7uiRIZxohYzOu
 nYfe3aSyqscHcVQhVwpbeTpnqtSl8VSY6VL0+xkW2XLVoXIEPncVxy2ctt12FRdMr/x2
 J/BFgzdiZy7TxKwDHCoilY1blYZUaCWDs54uh65nO+cfcaK+UyjH9kAdTOlhCcxrouy4
 +ZAJp5xLjSHImChQPKQdXOIwndK8LmjD+nNmdSfZzaNB/f4uZbtKk+AQLXpibnOSc082
 qSKZorIam89ABBDFXL3yB4wAEfYtg67HlEu1/wS5eOP4BuPJl43FiDb88UOL/9NqeBhz
 BTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+4RZCdMOsaMUmLqVgZAlaR32NMPZinL4K5nOFXnWb04=;
 b=OvUV0yRnkfYFXo7yvx+wuCjpqsL8eejHNZLBAHp7vVc7B/poNA+qrmz9d13KM75KXg
 5SjXReWaDPAlMhA9SMfhTW8oSVdA8GEhHx37X2MIDUngknECnKJd+E3MLszPyPn6kVOr
 2LSWnxSdpXajW/afsLbHpoSkzoEqxrZZONjkt/QbWOvx4LxLTezXUGntY+ek7Z3GcEsc
 JB1zrKNG0sNsejSwfRabUdopql+S/NEF4PPXW+ruVnDHRoR1/A55HrMat5HdhdR82/ib
 oY3L362ZcWYFikanyJaEV+eBLcWlxeb4+kChGaDIpKejbkmB0tMzDdpgs965m3pbc+fe
 tZcQ==
X-Gm-Message-State: AOAM530gjgq6y3jVPJFxPC55BbraVk1WwIG/bSeruYTkTP3Q4sR6Sinj
 05hfXRxIfvOIVvLZKf2s0d/iEY9APsCrkQ==
X-Google-Smtp-Source: ABdhPJxvzL3ZmHsRSyu8LA+Knl+NpHDisS4v7Xenpz4tp2U8octUm48QA+yheaxKjGKPR7NSaQgcSg==
X-Received: by 2002:a17:90b:95:: with SMTP id
 bb21mr4971269pjb.68.1598754729948; 
 Sat, 29 Aug 2020 19:32:09 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id l23sm3546269pgt.16.2020.08.29.19.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2020 19:32:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/7] softfloat: Add float16_is_normal
Date: Sat, 29 Aug 2020 19:31:59 -0700
Message-Id: <20200830023203.612312-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200830023203.612312-1-richard.henderson@linaro.org>
References: <20200830023203.612312-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
Cc: peter.maydell@linaro.org, Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stephen Long <steplong@quicinc.com>

This float16 predicate was missing from the normal set.

Signed-off-by: Stephen Long <steplong@quicinc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 0a5a5e5d0b..863dfc6151 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -272,6 +272,11 @@ static inline bool float16_is_zero_or_denormal(float16 a)
     return (float16_val(a) & 0x7c00) == 0;
 }
 
+static inline bool float16_is_normal(float16 a)
+{
+    return (((float16_val(a) >> 10) + 1) & 0x1f) >= 2;
+}
+
 static inline float16 float16_abs(float16 a)
 {
     /* Note that abs does *not* handle NaN specially, nor does
-- 
2.25.1


