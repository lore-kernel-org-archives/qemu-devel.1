Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D10C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 00:03:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95AE6206E9
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 00:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qZJBNhgo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95AE6206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgGsN-0003NT-Q1
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 20:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgGnv-0004uM-9z
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 19:58:47 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:40715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgGnu-00024y-FV
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 19:58:47 -0400
Received: by mail-pf1-x429.google.com with SMTP id v2so294117pfv.7
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 16:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T9g/1bYL5AF8SWtZFiFU5ixPPASa6ChAdx/2pCnn8+k=;
 b=qZJBNhgobPOrNgGlxq5XE+HbFruffBAbh+WUkUA+QIHdbWHFD4FGbbeRb4SUax5YzT
 rYwh6A95BJlleTrEpkr9E1jsV+fJZgHZwPCkW79IumzvMO2bHvBTaf0CQFGeSjnYTJ1q
 BpzjLNtZTNq5JICPOZpQx9tExo4JdNm+oOjQFILoM1RJ6SwZU6DpPQmq6MoAyoBVky+/
 7rba46wOzG3rt0ImrQQs6YGEgvRMncdd+0cEQvrDtEf/QV2uCU8i4r+YxHfANmYbKNl6
 dWNBKx3muSfLRlcpCa1CQe5hB5hZIUq4aFMiLt8vbLCOrnyFqWxEaMz47/lDjn6Oo6v9
 2InQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T9g/1bYL5AF8SWtZFiFU5ixPPASa6ChAdx/2pCnn8+k=;
 b=j85uPZB35zFIDxEgCy9k0zQaQj6742B7OpsJwCjOYs/1D2sJ9cX9xCRlzh8+awssiG
 kX5u3xaVyOAvGv5npkmpXkJCHU/nuORKwE/d/yBBUgB8hHj04CcJ4iiAtXEE4fSyA/43
 S/nv/l59RtrpLXsW7aty8Cdnya0Gxbv39Ytyz8a7gDPJdwcDhKN2rLiQGO/OazGRXIun
 PCpkpvd+2XOip4ovsqRTuLYyCwbVxBXlDntTPNFm4N/ZUB7U7dp4qnlBVfPBZTD5sXjU
 L3a/duPfWMS/WkUncAoK+xEEx+fPeRq38OIWxvCLFgFWz9caEhT0e9o77HzMgnZkMe+g
 e0GQ==
X-Gm-Message-State: AOAM533Cn0jzfaP66uPuS2uKxTKcLaOTf553PR6vJiQQ62U8o29IZqo9
 Es+yyJtkpivf9qNIsDSpbbPefbdQwzo=
X-Google-Smtp-Source: ABdhPJzNrMBAQZSmgPPw+hqTah32yVrErsorwcPaaQ5AeElV7faPbu8UDh5UE1tzTOPbnlGFixY9wA==
X-Received: by 2002:aa7:93ac:: with SMTP id x12mr29950554pff.143.1591142324732; 
 Tue, 02 Jun 2020 16:58:44 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id k101sm182201pjb.26.2020.06.02.16.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 16:58:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/8] decodetree: Implement non-overlapping groups
Date: Tue,  2 Jun 2020 16:58:32 -0700
Message-Id: <20200602235834.470345-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200602235834.470345-1-richard.henderson@linaro.org>
References: <20200602235834.470345-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
Cc: peter.maydell@linaro.org, philmd@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Intended to be nested within overlapping groups.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 0ba01e049c..7e3b1d1399 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -1021,16 +1021,20 @@ def parse_file(f, parent_pat):
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
             if indent != nesting:
@@ -1044,11 +1048,14 @@ def parse_file(f, parent_pat):
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
@@ -1067,6 +1074,9 @@ def parse_file(f, parent_pat):
         else:
             parse_generic(start_lineno, parent_pat, name, toks)
         toks = []
+
+    if nesting != 0:
+        error(lineno, 'missing close brace')
 # end parse_file
 
 
-- 
2.25.1


