Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B43BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:44:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA28207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FjihzZwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA28207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaisj-0000Os-5x
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jaip5-00025C-LA
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:41:03 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:46135)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jaip4-0005qu-ME
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:41:03 -0400
Received: by mail-pl1-x629.google.com with SMTP id b12so4430219plz.13
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 09:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DXF5hhG17BDEOETPzoe+bSK9+O1lQ05HYEEgNG7hh+w=;
 b=FjihzZwM2wYtERi0Zws7yos2C7KGw20k78/MJFU1LrZ+TmbscZxA63HJVgPAJsmHFp
 F4FBLdZqtGUGycqOLe8S7ZaVCK6hpDvQZ+M+0q7u6KiRhn1z2XVGh2qRmPQoZ7Zp3zL6
 DHScloroEExBlpVlx7ZUTHKQBMYe/lAE1MbsNks1Dw4epwKA1TfwDT1LPOqnjcstQFeg
 C7HqdDxicOgVUoNNtmlBj+GnH15B5bP1u+dIB6iqIoNf33MQL5iGWWNbwK2NzHd8x6i6
 yMFc2hmZPaRISftqap7jE0VpMTxqls3hSKI8B0OxMZBd5dJnpmdU2LsuOAGTg3ga6SEg
 TkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DXF5hhG17BDEOETPzoe+bSK9+O1lQ05HYEEgNG7hh+w=;
 b=XwW+f5EMJv/IIxd0fHYtyM2UswB3Bt5MIhU2FZjA+T+MwjxONN6Uc3JSQt75xBcqa1
 iD3KzwPHXGMPj1FeL4pvvqqUEnJ7HpJGD7fDP4zEfqWpDELoKyRqMO9GHuwTnHNHtsj9
 9kajFeNz0Za+WQE/kh+gMF5Ir+gpv4TQid0zgqnEeo+31MmYy0SCaXTTG1bJhDQ+7uAn
 RoCiAuvxGAnrvRk0op1B2X4E18epCozZS4ktmUR6sSq+rgBOGfOyPP+EN7oUSHmO2FSb
 G/+m2MobmYwEpu7RY0lN3ZhLQ2EMt4qtJyxZpkPA9eeI9lgebIZna7XiBm6uL4IGxQ5z
 +DSw==
X-Gm-Message-State: AOAM530A0Pm8FSb/0z80ORsGhSdwaNc5+i3oQlDNkCpVbXwPBSl92MqT
 DXPEdNWZD0ojgmGPCQJg1zlvpf8W/5A=
X-Google-Smtp-Source: ABdhPJynd/2Be65qIgIa3vW4+ZGuWClcnIbZKlqM5zJMqMaeLiHdBgLxJ66ZQHfzAV8SlKX2Qg0fiw==
X-Received: by 2002:a17:90a:dd45:: with SMTP id
 u5mr302350pjv.156.1589820060313; 
 Mon, 18 May 2020 09:41:00 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x132sm5790610pfd.214.2020.05.18.09.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 09:40:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/8] decodetree: Split out MultiPattern from IncMultiPattern
Date: Mon, 18 May 2020 09:40:48 -0700
Message-Id: <20200518164052.18689-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518164052.18689-1-richard.henderson@linaro.org>
References: <20200518164052.18689-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
2.20.1


