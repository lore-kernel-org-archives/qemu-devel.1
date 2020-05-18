Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AD6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:51:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1C9620674
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e2AxxJup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C9620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaiyz-00014t-Qw
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jaip9-0002CR-SE
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:41:07 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:33996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jaip8-0005s9-PQ
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:41:07 -0400
Received: by mail-pf1-x42f.google.com with SMTP id x15so5222551pfa.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 09:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PDxSs9xf1b7EFL4pA0grZqMFDbD8BMz/GvRTlqeyA2I=;
 b=e2AxxJupJagi8K3bYFhRin1ja+XNx7qEOSklYn7bX3V3sasqPk3DKCZ7y4K6VoFE/l
 PAKSQlGoY4mJDxOTXf5daCf8qEmo/vQmJTxqljcHaAbTURf/cwidT9AvTUQdeP9NjEUK
 G0dRiJs0EvWeqi3ajkRobYvC8+oyFJ3+DVkI6j2SR7VReEnMXGlh9uNTkxewEQ0JghSt
 LlaqmccdYMeQwqDGO3sLFLvm8sc1S0pKfEHKc/NFSPAb2VABOgb8WQHqoobpfr0FJSAR
 18yUyegB6NxX2vl4s63VPid8OXZfelZmswCxBkukTs6RqL5ZKr1WGvSaBF2Ublw5DcBo
 eXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PDxSs9xf1b7EFL4pA0grZqMFDbD8BMz/GvRTlqeyA2I=;
 b=LeVMy7V4AOQkz8ny5dH+ozh3pv8jajEJfCgh4crH8+tYuGqFfU3q/+zbaZCXX2zsva
 rkFVlH/1zEmHApXEno9ntfov+Kyvx5oTJ4t9D7mpj0laelsxYzJ6Png/8RCQXbRyno42
 Kq6a73gEEIUSPdzZUbf6ZpJc1rKCSgBrH4qw+XV77XcQRnOrhuTDitTeUhitKzeXdXHv
 jJStOUc78oIoZ+XJgRiwcRKW0qc7dDntYhez+OTXh0CKSCcN3ppaM/oJgBRVU+JOgROg
 s0E9bPhCbjP+4+NtXXyE0YWW/+bL+GMIae+0Hhgrv5RlbHRAJfUdUEtRwIlb/Cwgknl/
 B9fA==
X-Gm-Message-State: AOAM5318rGv5dCdvUKyr/UlFAKhTJ/UprEvh9uWqN7LgraG2x9IXhymR
 fCJ8qXc2PhLxUTIE/vTX/NHfDpBaxyQ=
X-Google-Smtp-Source: ABdhPJz2mNM3Vx1I4JTL/IA+nLTzTH0DX3NuB5L1MrwaoOxh80fouh+qK87vSy+osu8KmCf9NNnTEQ==
X-Received: by 2002:a62:cd4a:: with SMTP id o71mr17915345pfg.115.1589820064970; 
 Mon, 18 May 2020 09:41:04 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x132sm5790610pfd.214.2020.05.18.09.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 09:41:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/8] decodetree: Implement non-overlapping groups
Date: Mon, 18 May 2020 09:40:51 -0700
Message-Id: <20200518164052.18689-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518164052.18689-1-richard.henderson@linaro.org>
References: <20200518164052.18689-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Intended to be nested within overlapping groups.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 0ba01e049c..a9739f671d 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -1021,21 +1021,22 @@ def parse_file(f, parent_pat):
         del toks[0]
 
         # End nesting?
-        if name == '}':
+        if name == '}' or name == ']':
             if len(toks) != 0:
                 error(start_lineno, 'extra tokens after close brace')
             if len(parent_pat.pats) < 2:
                 error(lineno, 'less than two patterns within braces')
 
+            # Make sure { } and [ ] nest properly.
+            if (name == '}') != isinstance(parent_pat, IncMultiPattern):
+                error(lineno, 'mismatched close brace')
+
             try:
                 parent_pat = nesting_pats.pop()
             except:
-                error(lineno, 'mismatched close brace')
+                error(lineno, 'extra close brace')
 
             nesting -= 2
-            if indent != nesting:
-                error(lineno, 'indentation ', indent, ' != ', nesting)
-
             toks = []
             continue
 
@@ -1044,11 +1045,14 @@ def parse_file(f, parent_pat):
             error(start_lineno, 'indentation ', indent, ' != ', nesting)
 
         # Start nesting?
-        if name == '{':
+        if name == '{' or name == '[':
             if len(toks) != 0:
                 error(start_lineno, 'extra tokens after open brace')
 
-            nested_pat = IncMultiPattern(start_lineno)
+            if name == '{':
+                nested_pat = IncMultiPattern(start_lineno)
+            else:
+                nested_pat = ExcMultiPattern(start_lineno)
             parent_pat.pats.append(nested_pat)
             nesting_pats.append(parent_pat)
             parent_pat = nested_pat
@@ -1067,6 +1071,9 @@ def parse_file(f, parent_pat):
         else:
             parse_generic(start_lineno, parent_pat, name, toks)
         toks = []
+
+    if nesting != 0:
+        error(lineno, 'missing close brace')
 # end parse_file
 
 
-- 
2.20.1


