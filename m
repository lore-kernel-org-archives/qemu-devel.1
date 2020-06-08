Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1340BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 18:45:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D53582063A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 18:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mJntbXWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D53582063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiMlu-0006jP-VO
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 14:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jiMdx-0007if-Kx
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 14:37:09 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:35583)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jiMdv-0001Wu-AY
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 14:37:09 -0400
Received: by mail-pl1-x642.google.com with SMTP id q16so6998957plr.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 11:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9kKsrc4DOI6Wr8yYNYKXoTwwxZi1qcG2sxUWYFambRA=;
 b=mJntbXWxehe4JtFVkEi4sAeIi3567M0Hro81iUzPO8W5llJit+EBmB9IDcY6/jswl8
 2BL7t3/BoDNTu0rAUx7tFm3iuVHNtNWZFt+heVgLPKEHJ5/979xPv8mm+a+ldkmWRyWQ
 o3R0yfs7FyWNvGMX6zzDYSlMcWS1H2DqGZVTBshTzzxTLcBqa79Cb6GPSR/xrYno9noi
 MqsJshjAuK94KTE2zO9dx4T8MPBoHJSD6iVSlLzLdfH3bq+JiQrex7QgA4OMtpCQy6fq
 fVkp+2tJ1FRwrB9rHEK7DGkh7fxRulwVDOQJoO+5L1l+RpACksR6kYL3KlqJ7FDmZUBo
 Kfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9kKsrc4DOI6Wr8yYNYKXoTwwxZi1qcG2sxUWYFambRA=;
 b=rnPTHf0GuA4cFazNk7+yQV05ZbC0jjTrN0A1QJg9S4THMJV1EI+dQSkJLAWeIiwRAh
 0yX3Xr4IUaRgB2r7OPvuMAvbIDrbkjD1rKsnmMtgonFwOFVUTng7Xh04iLXOWAr6P6UM
 mrwxbt9JOFapb6EdR+Efv66IyFslD5aHpPYT2ByrnPoT4uJXuapHd2lqrsMIhoruMg3S
 kkzm5TVjf+aB/vI1DrhP69dGfgmtFNLuQwmP4U1NO2Hfr++FEfrkz0E24tpP3DoMO+c/
 2KA+sGnKyPGwXtCqFDnM17W7nRmGrIrYI6Adirr+uAVyAksGX/blswdC7VefhMVak0ke
 fj4Q==
X-Gm-Message-State: AOAM532jTKaI17M0tLwMSM3DSOQ8/mILMEdDmbPtWgdDUpLo40wbyMr7
 X9SZyvBRzZHwKLbiC5zWxoWT07bwaj4=
X-Google-Smtp-Source: ABdhPJwnQFnTAB/e32oSRJGyEVOKigc5hyfThJSpVGu1NEUFRgRZrePU4Hkwsx21cW4wJpHVEhZDdw==
X-Received: by 2002:a17:902:bb85:: with SMTP id m5mr128440pls.23.1591641425596; 
 Mon, 08 Jun 2020 11:37:05 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i22sm7854235pfo.92.2020.06.08.11.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 11:37:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 8/9] decodetree: Drop check for less than 2 patterns in a
 group
Date: Mon,  8 Jun 2020 11:36:51 -0700
Message-Id: <20200608183652.661386-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608183652.661386-1-richard.henderson@linaro.org>
References: <20200608183652.661386-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While it makes little sense for the end product to have a group
containing only a single pattern, avoiding this case within an
incremental patch set is troublesome.

Because this is expected to be a transient condition, do not
bother "optimizing" this case, e.g. by folding away the group.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/decode/succ_pattern_group_nest4.decode | 13 +++++++++++++
 scripts/decodetree.py                        |  2 --
 2 files changed, 13 insertions(+), 2 deletions(-)
 create mode 100644 tests/decode/succ_pattern_group_nest4.decode

diff --git a/tests/decode/succ_pattern_group_nest4.decode b/tests/decode/succ_pattern_group_nest4.decode
new file mode 100644
index 0000000000..dc54a1d285
--- /dev/null
+++ b/tests/decode/succ_pattern_group_nest4.decode
@@ -0,0 +1,13 @@
+# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# See the COPYING.LIB file in the top-level directory.
+
+# Verify deeper nesting, and a single element in the groups.
+{
+  [
+    {
+      [
+        sub1  00000000 a:8 b:8 c:8
+      ]
+    }
+  ]
+}
diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 7e3b1d1399..530d41ca62 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -1024,8 +1024,6 @@ def parse_file(f, parent_pat):
         if name == '}' or name == ']':
             if len(toks) != 0:
                 error(start_lineno, 'extra tokens after close brace')
-            if len(parent_pat.pats) < 2:
-                error(lineno, 'less than two patterns within braces')
 
             # Make sure { } and [ ] nest properly.
             if (name == '}') != isinstance(parent_pat, IncMultiPattern):
-- 
2.25.1


