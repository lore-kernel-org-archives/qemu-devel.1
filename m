Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7DDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:10:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA4C2089D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MC91PRMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA4C2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmon-0002Cr-78
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 01:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmEz-0007B4-Th
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:33:29 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42082)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmEy-0003fb-7Z
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:33:29 -0400
Received: by mail-pg1-x544.google.com with SMTP id e9so2328567pgo.9
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JnIvscga/41MHmopAUGND2DFOQvZJOfzYshgRIbja6w=;
 b=MC91PRMo3aGGAYJcXbt+4cffLSLpTEuWhVKiM4V9z7VvbS2MOB4FXVk8WCcy+pB07N
 f9nGmsCvy0xcDtjEC5sELLT5nc/1h4GhAucji0+48IuvT3O4atRA3dNJfLQ7zX1klFqa
 5wMvAEZHLF9VPGCNKbMLj1vwzwuaalXa9BV/9jjOT6Dyx1QYzjMTT7dw+A0FSFumowWf
 X/4nvtVpxcPnPX9IUey00vhJL5izKjw1cH5fuVbp4NUFCgkkgGs9G0OhIOLAuD93XOvR
 AMdm8vO6IPIQ1Rq4Rgzm9XNy/9HyK+1HvgduDvQHldquVg4ppHaaxEBlGqtSZsVgp6MD
 V7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JnIvscga/41MHmopAUGND2DFOQvZJOfzYshgRIbja6w=;
 b=KLNVg0CaX/xxmw3NDMQrQ6oJO2wYPE/vJe/t1Kr0r8cWRE9UGSoCYhEYZhHX+Yvgbg
 b/zFul3R3rNbl9GiOQ9D2XIDO2MWC3ftECl5hMlcSE7c26B6JrsOZjn5YFzidURyKn+G
 MrYzgDS7lXaqG+Z/I7/LxShrpYlM3FhdULnwOI/kYSgU/nqre8v45XdRdef8zF0mBxD8
 5jJKbfaB+hypWbZnlbp4ZCCSbL9XJOKH8IQEdItyT+ZRDkw5e3p8cIlOYnMzuJbqLJvo
 Fnhor1yLAB/lWkqzE+6lyngLug2xPlaUO0d0IAJlFgKG4z0cbG71SmdRBXO1OiFSY417
 h1fg==
X-Gm-Message-State: AOAM530DjXCaqAn82bULzxV29cqhT+0Nm+gBzFyLJ7r/CFnUTFazxpLO
 /RN9A3amJK4nQjiuo9wMeMuXUTH7ziM=
X-Google-Smtp-Source: ABdhPJxdayk6t7iVMBPsEPCjl0povWXVv6IJSZCmlMIZe9k1P9zSHOk5/LZAkXcLoHq8kaysKxN8hw==
X-Received: by 2002:aa7:84cc:: with SMTP id x12mr1884519pfn.235.1592454806628; 
 Wed, 17 Jun 2020 21:33:26 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id q22sm1288212pfg.192.2020.06.17.21.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:33:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 093/100] softfloat: Add float16_is_normal
Date: Wed, 17 Jun 2020 21:26:37 -0700
Message-Id: <20200618042644.1685561-94-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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
Cc: qemu-arm@nongnu.org, steplong@quicinc.com
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
index 16ca697a73..cd1fcfbf0c 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -264,6 +264,11 @@ static inline bool float16_is_zero_or_denormal(float16 a)
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


