Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B83BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:29:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6535820734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U+VsWnue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6535820734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jih7t-0006h5-Ib
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jih3p-000070-Hx
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:25:13 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:40681)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jih3o-0000TR-DX
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:25:13 -0400
Received: by mail-pl1-x630.google.com with SMTP id t16so8229826plo.7
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Pya0L8DMOCjwgXBO0A8MFuLM5jSzTOZ88OjOprsge18=;
 b=U+VsWnueeL0xPWTjn43ahwwDTz7u5oyjiwYln2FVm5xQVoBGt8R1/d8um9leJGCLPs
 CWukIVh3WoKSaJ3FFOTTgIayzjglZ0Y3LnYy0mSyuXF9qlNX5/rkc9xZJqUeYyW3ey1T
 tYE4ZmSoqpJCWBp+KDJoQeRjVOXzEEU5/sxSLdKnfJnaO55kbWg+C12BUh//+blSvsyG
 8fwf8sIQzCZKrgi1wCdinN1qt9HlvLCb6CsZZtOfrBl1r80SPdm/N/7P2whAAqrWK7Pk
 f+oFpvOMMQZFJ37qFoyWgkIYqykOID7axsdgFc1PGaacLbUcvXU4O3UaDccLk2Zno6FW
 2uDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Pya0L8DMOCjwgXBO0A8MFuLM5jSzTOZ88OjOprsge18=;
 b=CqIQYsWgkorh0U2E9DqFBpbxiLRUnwpz7DEwDyxfRYLBF/8LKjFtNz+vVi11ckbMU4
 v7RTUyto7Livvk7dfqk5yXCNftqNhdzzAZ9TpCozKJqWDVFNilmqTiWmS4R/xTlaUsZl
 fqSpdY/1bDTaiUN5g2xQf4SMhjFIvRlul950o4ULIeQ/pK/xKLYO13P34t3oyKWHznhw
 yP8p6h/v4gVInwxkcwUHuosvom8J5SSCt80xGQKzCqI4iZ8xSG1pdGlfovLEbLjDXWOE
 HmslglA2FkBI7/LvKMyz8H/2Ie/elOJ538qZQENXbDSLfvtkjGjFhd7/ZbeG8V934vA/
 1vTg==
X-Gm-Message-State: AOAM5304aChNTHBG8MraMA+oA4eDMbwOXlujotFh6xIqv3Y6Jd0k2ZBO
 lRShDMDG+ndRPlTR5gZKQvI7QYDt4N4=
X-Google-Smtp-Source: ABdhPJxRW2VzbjbHy4poDF4Fn0PZoblwY9Or2ukbejwAEJLoDzuvdlHDCKPhlCn9/VwVpMq8rpY7Hg==
X-Received: by 2002:a17:90b:283:: with SMTP id
 az3mr5760784pjb.232.1591719910441; 
 Tue, 09 Jun 2020 09:25:10 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id s188sm7580101pfb.118.2020.06.09.09.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 09:25:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/9] decodetree: Split out MultiPattern from IncMultiPattern
Date: Tue,  9 Jun 2020 09:24:58 -0700
Message-Id: <20200609162504.780080-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200609162504.780080-1-richard.henderson@linaro.org>
References: <20200609162504.780080-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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


