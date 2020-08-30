Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8A5C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 02:33:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5252D2075B
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 02:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JFtHkiOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5252D2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCD9m-0004UK-Ez
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 22:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCD8m-0002qi-JK
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 22:32:21 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:46862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCD8j-0002Z6-8N
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 22:32:20 -0400
Received: by mail-pg1-x534.google.com with SMTP id 31so2367615pgy.13
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 19:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=03HWfKJcxI+2FEdiEL/iXlMX93EyWDJq6OG6P1m51Wg=;
 b=JFtHkiOEBSQhZglqDXmlEXGcIcVkM+B/1drXTPienRwUZFH5uEzoUsta7PDy8wTcx8
 cakMGy6MfwvYuUFwHwmIOBWJCCJWw+U0NK7ISKLofCdDGF93luDHlUyFlfzJ4088D6pt
 L/Hh2I0Dewv8DgE4AlsmoegyGDPgdpzzzK44JwcwDVgrPCNE+ZQMt1QDwQF+RIrHZeHN
 myNzq3849oNvVi6HAFFPXo/m+rryFzDBntWd/m9lM1lhwAbwTPFxKYhlvdlqGYtycVoh
 RXjvsenoyGr/UWJXv+7+WL4KMRgu9v5cjmBzgqIgKvmxsVAvnz5MiTf4R3i4Zz2N0W5M
 zwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=03HWfKJcxI+2FEdiEL/iXlMX93EyWDJq6OG6P1m51Wg=;
 b=lROLmI8TKvXE8pOU51vHw2uEMEs2yXISxHJKDPENqPnyM9dzZz3Et9ERHrUDmdh3Jb
 T0L3LXyH+6m2tJKho4avTygceOm4ejJB8N6Z9P9dJwu3VonBIqtf1ARjQOlyL6QSsR29
 tI2oZy9DTs5YA2ljiuGrgupkY0z96dXXm/BMZr7Xs5DaRkmuaUkgPwW5wmMjLHcln5U2
 XPxaMQ9T3HBcbGNYq3p0BcmHEc57P+TWjbfWR5EHp/kq3+zifghDvX2r2xQQdLjbSgbW
 +sjthjk7rRztc/O384BrX4JMXQ+21GFLNwSsLtk/9VQnfmP/H6BozaYnWx8PuDOZraJR
 tkrA==
X-Gm-Message-State: AOAM532LQwpap9tLS0J87QfiEjpFO9NQmGo3lmndz6fKVe/ueRvIqOry
 DWkgUwGNrxfkzDKSJtep95hPJ8xM3fMyfw==
X-Google-Smtp-Source: ABdhPJwrSyDOIC5VfofixC3LKBAOgXiKuKRuCvrzX0775LwK2objMMnbg3OOYPp//dd7Vk/BSZG63A==
X-Received: by 2002:a63:f209:: with SMTP id v9mr3937213pgh.237.1598754735364; 
 Sat, 29 Aug 2020 19:32:15 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id l23sm3546269pgt.16.2020.08.29.19.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2020 19:32:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 7/7] softfloat: Define comparison operations for bfloat16
Date: Sat, 29 Aug 2020 19:32:03 -0700
Message-Id: <20200830023203.612312-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200830023203.612312-1-richard.henderson@linaro.org>
References: <20200830023203.612312-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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
Cc: peter.maydell@linaro.org, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 1233f98014..78ad5ca738 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -479,6 +479,47 @@ static inline bfloat16 bfloat16_set_sign(bfloat16 a, int sign)
     return (a & 0x7fff) | (sign << 15);
 }
 
+static inline bool bfloat16_eq(bfloat16 a, bfloat16 b, float_status *s)
+{
+    return bfloat16_compare(a, b, s) == float_relation_equal;
+}
+
+static inline bool bfloat16_le(bfloat16 a, bfloat16 b, float_status *s)
+{
+    return bfloat16_compare(a, b, s) <= float_relation_equal;
+}
+
+static inline bool bfloat16_lt(bfloat16 a, bfloat16 b, float_status *s)
+{
+    return bfloat16_compare(a, b, s) < float_relation_equal;
+}
+
+static inline bool bfloat16_unordered(bfloat16 a, bfloat16 b, float_status *s)
+{
+    return bfloat16_compare(a, b, s) == float_relation_unordered;
+}
+
+static inline bool bfloat16_eq_quiet(bfloat16 a, bfloat16 b, float_status *s)
+{
+    return bfloat16_compare_quiet(a, b, s) == float_relation_equal;
+}
+
+static inline bool bfloat16_le_quiet(bfloat16 a, bfloat16 b, float_status *s)
+{
+    return bfloat16_compare_quiet(a, b, s) <= float_relation_equal;
+}
+
+static inline bool bfloat16_lt_quiet(bfloat16 a, bfloat16 b, float_status *s)
+{
+    return bfloat16_compare_quiet(a, b, s) < float_relation_equal;
+}
+
+static inline bool bfloat16_unordered_quiet(bfloat16 a, bfloat16 b,
+                                           float_status *s)
+{
+    return bfloat16_compare_quiet(a, b, s) == float_relation_unordered;
+}
+
 #define bfloat16_zero 0
 #define bfloat16_half 0x3f00
 #define bfloat16_one 0x3f80
-- 
2.25.1


