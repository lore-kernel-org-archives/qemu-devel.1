Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08424C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 18:46:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1EBA2063A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 18:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GiXPc6md"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1EBA2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiMmj-0007Pz-UQ
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 14:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jiMdt-0007b5-Op
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 14:37:05 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:43605)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jiMds-0001W0-P3
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 14:37:05 -0400
Received: by mail-pl1-x636.google.com with SMTP id g12so6988485pll.10
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 11:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+utQoTLUzPPlGyk84vqSkSI1IEc8oNkKhMpAe11BE/0=;
 b=GiXPc6mdmO5esgCL9wSNG6rse+Xx2nWK6R3tOrOdCIektTDpf/2XT6ErZJSmHlu2qf
 JcIp2gPHOYv6WZMYhDB5HeSEeamI5xwudssRRjTkowlQh3h7dE+hPj8FWm+azfkOPrtf
 778hiWvUauvNlp4ttPXp6BXaFsS8KNWmGVX/lN0Y2iTFyGQH9ZXrR4MRUSvtxh/AkDF6
 z+qLwG5I6Xc133/Exa7toYv+50lIKARbuC2CpQsMHw/AG5cNOaCb0O9Pg/mnOwVaZOj6
 RboVucgoIvOqaEqNmn/LQ2HEi+/SYecSsXhE1Bf7N/CGRUwLSAgaHYcyPhGgwxR628lI
 1UWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+utQoTLUzPPlGyk84vqSkSI1IEc8oNkKhMpAe11BE/0=;
 b=mF++/Q+4Izngt4m/zMiaH3MN1vp4fruZLxbjOUkfOY/l+JCMNs3mg0ZFe0zRZ+nmpe
 lyi1qcOHIBb5JJ1jfwX+wCLwJo6Fb25zWBCG/OAtLnNiobAZBAICtqFJni5GW5YXknWZ
 DA4dskRiVG1yHdmtYe+F293AXPR7MTNENhVO9yvuD9ymHTdLVHZR7FM/bB4lxNkXTOt0
 SgUB0Xz1LXdtwpN124gvCfelwMFxXwMeCOgYnxOLul9Wje9w/UX2Ju1q6Z8oci+Ny6H7
 EzyLPupimsn3mYyzkHCqVBlU9SkCyTvjR7vbis+KrViwblYtIMim5HVH32FD2FdsotRi
 U55w==
X-Gm-Message-State: AOAM5306xbaewdNw/VCgzzn2yMtcG0RpgsFwh4fac6zOH2BWT5J3YvP2
 TOSjJz4A13Ogv+vuxyvq1hDo/TAa+2A=
X-Google-Smtp-Source: ABdhPJzlniobZMDioenLUYjAoDCReUcdirC7BMBAiObRhp5OKn6BeEI3geuMPFo/gt/YInhWIHR4ug==
X-Received: by 2002:a17:902:c301:: with SMTP id
 k1mr148708plx.192.1591641422899; 
 Mon, 08 Jun 2020 11:37:02 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i22sm7854235pfo.92.2020.06.08.11.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 11:37:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 6/9] decodetree: Implement non-overlapping groups
Date: Mon,  8 Jun 2020 11:36:49 -0700
Message-Id: <20200608183652.661386-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608183652.661386-1-richard.henderson@linaro.org>
References: <20200608183652.661386-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Intended to be nested within overlapping groups.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


