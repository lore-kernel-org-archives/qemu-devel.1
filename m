Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375E9C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 18:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF7D92063A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 18:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kGbAXsl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF7D92063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiMhL-0001yc-3e
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 14:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jiMdq-0007W7-7P
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 14:37:02 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:40459)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jiMdo-0001V7-LF
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 14:37:01 -0400
Received: by mail-pf1-x42e.google.com with SMTP id s23so7597843pfh.7
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 11:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Pya0L8DMOCjwgXBO0A8MFuLM5jSzTOZ88OjOprsge18=;
 b=kGbAXsl2GFot687u6BRTHSfCd3DowBOh6wE9S0BAunLCOwv3qaxsTecc9PxOKyRPPM
 xfPhRhgOTKud96uQDnGRqigu57Y8qBGuCnJDY7NdVyJtMil0yn2XAddHrj0KFMQDyZbs
 pvL7R3dWkAN0mDE/9E2Pfr1ST9AY4dJL4U5gyNISxWo/FgZLehyL9X7w2oYDpYHThu/I
 u5sz2cyb7uzV8H3NT+p8dIG7YueIVtoFXi5J+Yw9QcXzht13J5nKsszXE0fkC7ZDYXmY
 yJYjqnfvC0pW2Y6lJ3Dyb7Dp1uGKHdguwPiS1EmlBvTaS8aPh/mvkmNh4n3SlIWhDGgu
 D7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Pya0L8DMOCjwgXBO0A8MFuLM5jSzTOZ88OjOprsge18=;
 b=qQgp6Rn/gZ23lWI+00AZ7dGllt6ZjObAVNR+jPJkvpGoJuONBhKMmcPMh/Q7IVIXOv
 aQu5BfcF80UsqFNAHzn5y/AxyeqMxmqx6jcn8H5FSm8PHUwA/sDRd5g5OsC9U4kSRuyR
 gSyAKCzfxKXYLJIP7tht0ihyF0nIfSbzjn7luZHJm5J2w/2xk41X0Xl4uO0YL+w0Yce4
 PnF5gitJBAYxKi4ZSsgn4Ec4xXRye3u8xM8ak156OgF0KBDFLA0nAWF8DojWXDFOJosB
 /8rZH5d2akpe31QfAmEjLu39Y2gKdMoVznBADFOg/FLDW6jlDbmnOpeiQjRtcL0ZC5dR
 m5Hg==
X-Gm-Message-State: AOAM533kbwCXl7Dzh5A7qQ9SJas51l0lIsDt0HG2jLDMaTzVJXrnwHG6
 CRnRnah6PjuU9YoLubLMlLDrVj6VDJY=
X-Google-Smtp-Source: ABdhPJyDIRGezXT8JQ7/zV4RQE9wvT1V1iIfxpQ0n3yHug720qppEZQk351ZUPJmaUALkybTERxgaA==
X-Received: by 2002:a62:2944:: with SMTP id p65mr22668858pfp.280.1591641418962; 
 Mon, 08 Jun 2020 11:36:58 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i22sm7854235pfo.92.2020.06.08.11.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 11:36:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/9] decodetree: Split out MultiPattern from IncMultiPattern
Date: Mon,  8 Jun 2020 11:36:46 -0700
Message-Id: <20200608183652.661386-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608183652.661386-1-richard.henderson@linaro.org>
References: <20200608183652.661386-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 7af6b3056d..ea313bcdea 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -371,7 +371,32 @@ class Pattern(General):
 # end Pattern
 
 
-class IncMultiPattern(General):
+class MultiPattern(General):
+    """Class representing a set of instruction patterns"""
+
+    def __init__(self, lineno, pats):
+        self.file = input_file
+        self.lineno = lineno
+        self.pats = pats
+        self.base = None
+        self.fixedbits = 0
+        self.fixedmask = 0
+        self.undefmask = 0
+        self.width = None
+
+    def __str__(self):
+        r = 'group'
+        if self.fixedbits is not None:
+            r += ' ' + str_match_bits(self.fixedbits, self.fixedmask)
+        return r
+
+    def output_decl(self):
+        for p in self.pats:
+            p.output_decl()
+# end MultiPattern
+
+
+class IncMultiPattern(MultiPattern):
     """Class representing an overlapping set of instruction patterns"""
 
     def __init__(self, lineno, pats, fixb, fixm, udfm, w):
@@ -384,16 +409,6 @@ class IncMultiPattern(General):
         self.undefmask = udfm
         self.width = w
 
-    def __str__(self):
-        r = "{"
-        for p in self.pats:
-           r = r + ' ' + str(p)
-        return r + "}"
-
-    def output_decl(self):
-        for p in self.pats:
-            p.output_decl()
-
     def output_code(self, i, extracted, outerbits, outermask):
         global translate_prefix
         ind = str_indent(i)
-- 
2.25.1


