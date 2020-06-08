Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76F6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 18:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 909EC2063A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 18:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dTqZkv9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909EC2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiMiw-00049J-H0
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 14:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jiMdr-0007XJ-5y
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 14:37:03 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40117)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jiMdq-0001VD-2L
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 14:37:02 -0400
Received: by mail-pf1-x444.google.com with SMTP id s23so7597869pfh.7
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 11:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D9iJwfXIlrrZhBoa0zYBpMpQDudGom24uMHOfJzYaos=;
 b=dTqZkv9jvfvfq1OFDvraXcQBvuP8mqFVA2zU+sj6+kJY4VVpLoRxccBT7NDm0fezq8
 HO2Fv0GbIMjcfq9MAPxiRCrtu+dSwRSpB9yQWO+JnZRfLRLdq+lre80kwsdslZu1G6zR
 oHBTPfr7WZ62Kjer9d+tSdf7yMV3oX11G5dZ8fGq+Es0kwypTDnHm3ugOA5i4kQOxQ5J
 HFWRHhYLJ/ZwVtmRbrT5p0QEn1gYFLkfBu8vc51Gc7QBt13EikFUf+j6vXP/XjU7az0Z
 cnl7vasDwmaumiR/JXR5eXFb2UmupZ5Gke0J7zZS+CzSBXsoHfZt88bmP0i6oTwSauKd
 VHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D9iJwfXIlrrZhBoa0zYBpMpQDudGom24uMHOfJzYaos=;
 b=tnpkcdaAUob6eWOHEaPoXhRo+7ymFPMeW5vM9hV/48yWvOJSuEmS6DDefMbHowqnGN
 //rQIZ+KgOMEeQMY03UlqLxiDvK5ISStv1Sodr/2kaIFQlyp6yHwi6/8ZLtz7A9DLKof
 Lf7Ed29bDj5GGVtlR3hz8IOuhS0xGRXrxsrIjK/CSEU4MhpVxx10mmG212/un+md/5q0
 4KPRqcBAY2fiK3uYXH+SVaiQeY9+tlR2/e2A2bx1kpYDV7usRl1TQhFS9ZJG6YCZ5rqQ
 Vb+fk+aJeVHT3u9ZQSpY9vUt1chYrDtSDSPqGCWatiivrdYns/Mrd7k28dRfY8FLHiQ2
 /5Og==
X-Gm-Message-State: AOAM532WXo+xmpW0YMLCd4Cvb140ASHC19Tgyjb6swgrZLrNVtCognZ3
 WZ1QenBliK324GSkYWM9EBSwhbcxHWY=
X-Google-Smtp-Source: ABdhPJwK3y/VDDgrSNyo0XqiICKnzhVL65WnrLzpg9FgT+F2qolJtpWWN8pf8tngQ/VY8CcY6pUzmw==
X-Received: by 2002:a63:da0e:: with SMTP id c14mr20908773pgh.377.1591641420266; 
 Mon, 08 Jun 2020 11:37:00 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i22sm7854235pfo.92.2020.06.08.11.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 11:36:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/9] decodetree: Allow group covering the entire insn space
Date: Mon,  8 Jun 2020 11:36:47 -0700
Message-Id: <20200608183652.661386-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608183652.661386-1-richard.henderson@linaro.org>
References: <20200608183652.661386-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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


