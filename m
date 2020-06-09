Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88608C433E3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:26:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50ED820734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uExIaGHG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50ED820734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jih57-0001nz-Fb
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jih3o-00006D-5l
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:25:12 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:37169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jih3m-0000Sr-VV
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:25:11 -0400
Received: by mail-pg1-x530.google.com with SMTP id d10so10533867pgn.4
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fuj4+EzL4ACqWfECVnWjXkyBK0NkdZBLVsNebnwCJQ0=;
 b=uExIaGHGbhx1qtHMuG+SO2cDXVYerh2dCTmlb7xnzDT8+CbIpnNP6ikTa+loHGo/ia
 MXdkMynralLbTG2Y+sz7NCbY1ZZ1EtTjsNcqHKcJrQmTe0uOpBdUEDSpHWRIbdQLflt4
 l32i2ZpgpfnhoH9H0TW1BrGFMGEpNnrQaPZVIsmeD+MG/kpr3xVNYdtKxrBAX8EJLerM
 Oho4pLPMqY2jsIZJVCvG07ADNcvDmyoLZ5/mCuBPbNLw2Btnlslr99rahniRVRJIuAjW
 7lcuuSn4yPqgfFJ5BF+rqiLNp+Gt2pbT7a0ZFtGzycVm22FOcxxRszyw9SpQoIGZR45i
 yK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fuj4+EzL4ACqWfECVnWjXkyBK0NkdZBLVsNebnwCJQ0=;
 b=bEle7ueDJzb1REAhpTSeLoyA0HX642WMsv+fWQs8NBxhAU8dqtM2a8AOS1XriAMI6/
 imAKeH6OlcVq7nL4rxEjkY3Y52q2CmYafJ55wkj07I5x/GJZYwQ3D/wNFBP2TE1SfPAZ
 eqDUVdyjGyDURr8CrRhXS7GconqVfCy4nCX3SN8SMUnYYg3/ehAcfAV02lkZUKpLU4k4
 hDOoT45fDfISzdEQGaFKOKS4LfJCb02AIvjnY7azhFAzq3ac9sDiEw0YZTJikdELqM1I
 vQFE0PIDIFD7qJsXQXzD3NIKUZpWzlWhsDl/s0yIgpV52/hBthKUFQufaVLJXU/iioia
 Faow==
X-Gm-Message-State: AOAM533eOQhRTC8NbxbOYS8Lsqh+b8/HBNjfq155CmVWgOzML/R2Y5qP
 bMk9Sxx7NlivyhrXn+yWPrL56iVB2yY=
X-Google-Smtp-Source: ABdhPJzuYmkQJ+CjZGAi4pu2hy3b1bAPjBhj4OdgEuct3F9nFGKljU0Nn77PgVjQJVXp1KR1Dg4bRA==
X-Received: by 2002:a63:5d19:: with SMTP id r25mr24723423pgb.360.1591719909156; 
 Tue, 09 Jun 2020 09:25:09 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id s188sm7580101pfb.118.2020.06.09.09.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 09:25:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/9] decodetree: Rename MultiPattern to IncMultiPattern
Date: Tue,  9 Jun 2020 09:24:57 -0700
Message-Id: <20200609162504.780080-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200609162504.780080-1-richard.henderson@linaro.org>
References: <20200609162504.780080-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Name the current node for "inclusive" multi-pattern, in
preparation for adding a node for "exclusive" multi-pattern.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index b559db3086..7af6b3056d 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -371,7 +371,7 @@ class Pattern(General):
 # end Pattern
 
 
-class MultiPattern(General):
+class IncMultiPattern(General):
     """Class representing an overlapping set of instruction patterns"""
 
     def __init__(self, lineno, pats, fixb, fixm, udfm, w):
@@ -410,7 +410,7 @@ class MultiPattern(General):
                 output(ind, '}\n')
             else:
                 p.output_code(i, extracted, p.fixedbits, p.fixedmask)
-#end MultiPattern
+#end IncMultiPattern
 
 
 def parse_field(lineno, name, toks):
@@ -751,8 +751,8 @@ def parse_generic(lineno, is_format, name, toks):
                           .format(allbits ^ insnmask))
 # end parse_general
 
-def build_multi_pattern(lineno, pats):
-    """Validate the Patterns going into a MultiPattern."""
+def build_incmulti_pattern(lineno, pats):
+    """Validate the Patterns going into a IncMultiPattern."""
     global patterns
     global insnmask
 
@@ -792,9 +792,9 @@ def build_multi_pattern(lineno, pats):
         else:
             repeat = False
 
-    mp = MultiPattern(lineno, pats, fixedbits, fixedmask, undefmask, width)
+    mp = IncMultiPattern(lineno, pats, fixedbits, fixedmask, undefmask, width)
     patterns.append(mp)
-# end build_multi_pattern
+# end build_incmulti_pattern
 
 def parse_file(f):
     """Parse all of the patterns within a file"""
@@ -860,7 +860,7 @@ def parse_file(f):
                 error(start_lineno, 'indentation ', indent, ' != ', nesting)
             pats = patterns
             patterns = saved_pats.pop()
-            build_multi_pattern(lineno, pats)
+            build_incmulti_pattern(lineno, pats)
             toks = []
             continue
 
-- 
2.25.1


