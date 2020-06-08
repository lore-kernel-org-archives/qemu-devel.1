Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759D8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 18:43:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E8D72063A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 18:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YeyinN5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8D72063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiMju-0005Js-F3
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 14:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jiMds-0007Za-HK
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 14:37:04 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:42835)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jiMdn-0001V1-PU
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 14:37:04 -0400
Received: by mail-pg1-x52b.google.com with SMTP id e9so9116505pgo.9
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 11:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fuj4+EzL4ACqWfECVnWjXkyBK0NkdZBLVsNebnwCJQ0=;
 b=YeyinN5gyH61m/GcaeXypPOfjovaRRze//ZqzH27PIAJot3bepDWgR+Qb9TVn9tHsa
 HB+1OaUabVaIX2MXMydhFKIeBqAO0QFh6P/AAuEBVb8SKVlEPpVi0kDPu7WwAhlGYRYw
 Hkycr5RvfOKnzAqM18agFMZXe1FxxCSWf2NP7Ncv1W1bkuJbd45uAzRJs+Q1ecUyf7xU
 eZYPOuYuYacRP3YjXGLWP50Lu5Qi9j564i/JIFeCWCH7TvdoK2UbKHmC9qGgvhEVbhKk
 Ie7KWm2I6y8jMcVVjwVcYKwb2InxVbbqrFWWDMUC3487wKFEItNu9+3hd8BDvzoFebN0
 9bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fuj4+EzL4ACqWfECVnWjXkyBK0NkdZBLVsNebnwCJQ0=;
 b=g/58taAd+DwdSzcRB7BILrZE+K1msERz5e2UAQXlJOpjkTtBBsGBfGd9bYVSOjkb35
 bHp0zlwS+tuYSxSnsuTQs25jlSBGuAOCPiUPocfSVZTtXsrHuSvqpywzhHgqOPfazG/5
 vS23XLN8+7iC/BBt8ufm6kAVwKNroV4DMlIso2pGrrssuELAlujPf1+zpCa5rJTErzF1
 pkFd+9b0gSAZAClajRcSpaZioZAs+7HM5o3PB8vHhksqh/2xPWyMGZ5o/jSCPCzlMhEF
 jEzbPpFM1wkuMwiWCbMT6D2/kXTrhZ+Rh+0EGe93gLiyA++z1G368ih3y0YYcAK/BvUv
 JApg==
X-Gm-Message-State: AOAM530/2Iyy/K7VyOnxQrwSk1o59AoaPDvyOlUieudYd+3MVrMeeC1S
 Lf8O2KxucYOoPO6ccSoaqAgY+Q4+dnI=
X-Google-Smtp-Source: ABdhPJz5KGyIkDAxG6q9AjbFP4ZPXqwgR+skvJ1ZTai6ccre5f0RdMv4zMBMm9C/bEIwszD5Esm1GA==
X-Received: by 2002:a62:1a0f:: with SMTP id a15mr23770292pfa.177.1591641417789; 
 Mon, 08 Jun 2020 11:36:57 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i22sm7854235pfo.92.2020.06.08.11.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 11:36:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/9] decodetree: Rename MultiPattern to IncMultiPattern
Date: Mon,  8 Jun 2020 11:36:45 -0700
Message-Id: <20200608183652.661386-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608183652.661386-1-richard.henderson@linaro.org>
References: <20200608183652.661386-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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


