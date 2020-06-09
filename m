Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8B3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5965420734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SSKioLzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5965420734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jih7B-0005ER-Bs
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jih3q-00008q-JC
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:25:14 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:43848)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jih3p-0000Ti-Ff
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:25:14 -0400
Received: by mail-pl1-x631.google.com with SMTP id g12so8231369pll.10
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D9iJwfXIlrrZhBoa0zYBpMpQDudGom24uMHOfJzYaos=;
 b=SSKioLzg15b5lY0y9ok3Z8QBQAD9YoHL+TVOXRhHO6EAK9a7uTrCBthkJJNY4KeM7e
 pZYIdtEzK8qAec+chAzKSWPEmBEl/0HeSn8rzn+CtZ2OrljPY2b+cKoSMWmY34vYUvnk
 JUnE52lcSRxaHTsUbtqwbP70d65x2/g7U7gc5xwDAZxRreK0YFbULHxOijW40Uz4oybb
 IXl4GYHLOz+HwSyUCY1pL06aNeoMc/WfiBcX02qNoqaJNyTDVpXbNSk15TxG3T64I2KG
 aO1FrZ57E0A6SsG2AvjslfxpFAsdF/Tt/1fAg7MDbbQ33OUnrLefZXQfni5JANA4fNQF
 Na+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D9iJwfXIlrrZhBoa0zYBpMpQDudGom24uMHOfJzYaos=;
 b=IROX4cCbi8jK5lLW8yHfsT4iUuP/HvzBsW4I4GS5E+YQLzKI+CIRl+igAsX5Vanix4
 zxWzpW2aqU+1MyucbH+iWvXwmhX00lYREN57RkqMkMRY4HCo4+28xBdj4ysMo3XxQieF
 iwSsWvdg54LJhZwwMD7d0jnJ6euAeZDxHPZdhrTOMGhSW8KsYwfhp+wgy2Wb2P5TVHpI
 LR3/8Yr7T+YeRiKWtdxQa/TtfdSpqDieVCEcCfrpaPdQc1SotRFjfSasLXHEhUWri7DF
 K2GiQwznVRH+edy2BFi4RJ26VvuSa3rddoR7TpV6Ngn/HeL/q7+5f1gyvEJNT7MxJCzh
 pG0Q==
X-Gm-Message-State: AOAM5318FgmuKWFqkzmqiQ8uPavd7JA7yw5xgYeHFK4JWqMSLBfiGjtb
 m6PX/oW8KCu6iPril4TYonZhRY7Al+M=
X-Google-Smtp-Source: ABdhPJy866nI5xzvLPXeTBeVGR5GU0oLqSMp9L4gc89JGRd2Q7d41Mic9cHor0NitorHAolHXjDb7g==
X-Received: by 2002:a17:90a:c293:: with SMTP id
 f19mr5550170pjt.91.1591719911610; 
 Tue, 09 Jun 2020 09:25:11 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id s188sm7580101pfb.118.2020.06.09.09.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 09:25:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/9] decodetree: Allow group covering the entire insn space
Date: Tue,  9 Jun 2020 09:24:59 -0700
Message-Id: <20200609162504.780080-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200609162504.780080-1-richard.henderson@linaro.org>
References: <20200609162504.780080-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

This is an edge case for sure, but the logic that disallowed
this case was faulty.  Further, a few fixes scattered about
can allow this to work.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 ...est1.decode => succ_pattern_group_nest2.decode} |  2 +-
 scripts/decodetree.py                              | 14 +++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)
 rename tests/decode/{err_pattern_group_nest1.decode => succ_pattern_group_nest2.decode} (85%)

diff --git a/tests/decode/err_pattern_group_nest1.decode b/tests/decode/succ_pattern_group_nest2.decode
similarity index 85%
rename from tests/decode/err_pattern_group_nest1.decode
rename to tests/decode/succ_pattern_group_nest2.decode
index 92e971c3c5..8d5ab4b2d3 100644
--- a/tests/decode/err_pattern_group_nest1.decode
+++ b/tests/decode/succ_pattern_group_nest2.decode
@@ -6,7 +6,7 @@
 %sub3 16:8
 %sub4 24:8
 
-# Groups with no overlap are supposed to fail
+# Group with complete overlap of the two patterns
 {
   top  00000000 00000000 00000000 00000000
   sub4 ........ ........ ........ ........ %sub1 %sub2 %sub3 %sub4
diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index ea313bcdea..3307c74c30 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -124,6 +124,7 @@ def is_pow2(x):
 
 def ctz(x):
     """Return the number of times 2 factors into X."""
+    assert x != 0
     r = 0
     while ((x >> r) & 1) == 0:
         r += 1
@@ -131,6 +132,8 @@ def ctz(x):
 
 
 def is_contiguous(bits):
+    if bits == 0:
+        return -1
     shift = ctz(bits)
     if is_pow2((bits >> shift) + 1):
         return shift
@@ -793,9 +796,8 @@ def build_incmulti_pattern(lineno, pats):
             error(lineno, 'width mismatch in patterns within braces')
 
     repeat = True
-    while repeat:
-        if fixedmask == 0:
-            error(lineno, 'no overlap in patterns within braces')
+    fixedbits = 0
+    while repeat and fixedmask != 0:
         fixedbits = None
         for p in pats:
             thisbits = p.fixedbits & fixedmask
@@ -978,6 +980,12 @@ def build_tree(pats, outerbits, outermask):
         innermask &= i.fixedmask
 
     if innermask == 0:
+        # Edge condition: One pattern covers the entire insnmask
+        if len(pats) == 1:
+            t = Tree(outermask, innermask)
+            t.subs.append((0, pats[0]))
+            return t
+
         text = 'overlapping patterns:'
         for p in pats:
             text += '\n' + p.file + ':' + str(p.lineno) + ': ' + str(p)
-- 
2.25.1


