Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4422AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 00:01:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 158C42072F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 00:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OxQoqEuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158C42072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgGqc-0000xS-7x
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 20:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgGnq-0004l4-M6
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 19:58:42 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:43060)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgGnp-00024J-TK
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 19:58:42 -0400
Received: by mail-pg1-x52a.google.com with SMTP id 185so407388pgb.10
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 16:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Pya0L8DMOCjwgXBO0A8MFuLM5jSzTOZ88OjOprsge18=;
 b=OxQoqEuKsc4m66eOINXxcWnizzdJTun8a5bVgmgE1g3YZNWIYaIJ+PD0WUjFaup7qP
 NAGPzb2VIAg6ga9xZm2gcFoWXltLvoFH3NMtELWJ/+R2rWQaG8iY0eC3dl/P9VWH66i0
 KsM1C9MB5T512dbnww7JGYNP2aGjjz8eyPDCwLtFxw9idK1oHEgvosP70eojLARDSCvU
 EpmbQQGVF3WfldnkpJO2+ZPGNiS8uXp5O4BoegQfznVl62x+L8dnYJRBrh3q9wTuj9Gs
 s5B2689DwKNpL4C8MZhhAhntNySEalftPckR/vZRtj0oWvr9FES7FDl7EA8K+7doXVyd
 JKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Pya0L8DMOCjwgXBO0A8MFuLM5jSzTOZ88OjOprsge18=;
 b=lycdsEn+SKz+JLH35iPyArtyUNCBaquykYeqy92casO8UOFXzWH+kXJ3D/oNUM5Io2
 vYXNMDVWgUD3HMHTkh2c7+sI1iPfHeLoCAEfXEWKR1CP5rQ9qDx7UMPoza6zzePzewBd
 e6HRqyuyviutNwUZYk+lHTxGEqvvFk1X6fyLwUUu8AawTxEQsRP0PneJNxDc8c0bogt0
 bjTJ9ehPh2vZ9j/AiCzOUYqbXhUWYkECQgrMtemikBgz8q881jL6ATYkqA+9PaypTiy4
 MpET4zeJxJEwSxDfKALcUIAhqzg+oAtowoW+ommQk0nXp5As2qsDBTOHFW5kPsCwTC2e
 FZag==
X-Gm-Message-State: AOAM533NoEOw2ZPH1zjZoA9+0iPyHfq2BNTGBmw80AmRpX+LJDJavamS
 JZtEAwlne+b5FsKmUO5IrEShQTG2ywU=
X-Google-Smtp-Source: ABdhPJxI5ubfPI/A7fgfMQclc6TE4VEjVW0w1ha2dnVxzhRXqabSLiZSVQIwDkETZSjdmWx5f6Vo4Q==
X-Received: by 2002:a17:90a:9292:: with SMTP id
 n18mr1932012pjo.3.1591142320177; 
 Tue, 02 Jun 2020 16:58:40 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id k101sm182201pjb.26.2020.06.02.16.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 16:58:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/8] decodetree: Split out MultiPattern from IncMultiPattern
Date: Tue,  2 Jun 2020 16:58:29 -0700
Message-Id: <20200602235834.470345-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200602235834.470345-1-richard.henderson@linaro.org>
References: <20200602235834.470345-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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


