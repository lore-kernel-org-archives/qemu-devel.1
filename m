Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48531C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:30:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 166332075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wjRqha/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166332075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBaib-0007OP-BL
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBaci-0004dJ-7I
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:40 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:40057)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacg-0004Kr-Fe
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:39 -0400
Received: by mail-wm1-x32e.google.com with SMTP id k20so269569wmi.5
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=150vA2l0M0YAcbk3j/Ns9hH+mky1glijBmcJAoK7LV4=;
 b=wjRqha/nf8uDFBL0ZLylejYL/91TZQW0QPGa51XrOFO8Ibubv9oK2+z0laUCKPtfMU
 VCcxpdk3/6U4Mhkv6nH+HR1US4Ikd8p4Ueqm5BVu2sMFK/BCbW6eieEMXEPoGYPqYvWA
 pdhHmnFqspRg03SWs4NuBvHFRkjBsjSJ9AQu1x++rhbQ12WFn6IB0lfgtsLnJY0BX9ns
 1YyfJ8fesVMx4Tl7nc3u/fq16frKt+vHZN3exQKEHTwkKBrtQ7bwy+G89z7pLLbg4G02
 GKnB6Ag0KWy3R7CQ2oBmlms/FpF45kW9719BOYYAcI/Dam7iFv/ppIcqv2sWnNtK3tD0
 PQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=150vA2l0M0YAcbk3j/Ns9hH+mky1glijBmcJAoK7LV4=;
 b=SUEt5zsjL55pELJex5Cz6fDBwA6tNi2C37RJAzDvqdDeB9H5n4oChCzK0YW992nxR6
 dvqLvOzGssWupeAOY9/EULiCQAhMZuoo+0zIShMHc6P+3JPL/dCT90Lo0kk1xJFvm6i1
 ROm114cVAnEMYbvNj1QeIz030Ogzp6rxk9J7b8jN6sCHNVXfIvEluzPh5JLJcmYK2yUO
 FmvTHsobPHdq/d17JKUniI4V372H4lCgNUhaSVwYUaJDshn+tHjWiOK9CH9c0phRv7eh
 N3kShmt+jeM52YL/kadxSyWVSf5Ej38NaUIuq9TI/qSBq/PFgNYf7/FL56GsPKSh9Wo7
 Z+PA==
X-Gm-Message-State: AOAM531ER3kWEmIKFYz97eLxLui3KwWjgBUzCr/UYVl/NgE6Sc3stR/j
 Ag4tnfBK92JXGvGxYxXAJOLtikuN0anQ2uMT
X-Google-Smtp-Source: ABdhPJwYE8vgjfrkdIKloMZmKVg0AdqzMOZ0MtBoYqYb9Xm62d0TrPDzetOCzdVSB8PTQIqH60nhgg==
X-Received: by 2002:a1c:750f:: with SMTP id o15mr746980wmc.182.1598606676885; 
 Fri, 28 Aug 2020 02:24:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/35] qemu/int128: Add int128_lshift
Date: Fri, 28 Aug 2020 10:23:57 +0100
Message-Id: <20200828092413.22206-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Add left-shift to match the existing right-shift.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200815013145.539409-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/qemu/int128.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/qemu/int128.h b/include/qemu/int128.h
index 5c9890db8b3..76ea405922d 100644
--- a/include/qemu/int128.h
+++ b/include/qemu/int128.h
@@ -63,6 +63,11 @@ static inline Int128 int128_rshift(Int128 a, int n)
     return a >> n;
 }
 
+static inline Int128 int128_lshift(Int128 a, int n)
+{
+    return a << n;
+}
+
 static inline Int128 int128_add(Int128 a, Int128 b)
 {
     return a + b;
@@ -217,6 +222,17 @@ static inline Int128 int128_rshift(Int128 a, int n)
     }
 }
 
+static inline Int128 int128_lshift(Int128 a, int n)
+{
+    uint64_t l = a.lo << (n & 63);
+    if (n >= 64) {
+        return int128_make128(0, l);
+    } else if (n > 0) {
+        return int128_make128(l, (a.hi << n) | (a.lo >> (64 - n)));
+    }
+    return a;
+}
+
 static inline Int128 int128_add(Int128 a, Int128 b)
 {
     uint64_t lo = a.lo + b.lo;
-- 
2.20.1


