Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EDEC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:49:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA52C20578
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qlUf7rcU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA52C20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKeP-0007TT-13
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBKZl-0001q8-Vu
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBKZk-0001Mp-4n
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:17 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:33867)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBKZj-0001M8-Tc
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:16 -0400
Received: by mail-wr1-x433.google.com with SMTP id z15so11840587wrl.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 08:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oanDNH9UXQs5SQ6FP6wfavjB/jgZbQ32aIl+6zF+rww=;
 b=qlUf7rcUOo+B7pRTqJbWwSO4XrMFWR379eqyj4dOcmAgDRIRKZoFTNHyIeuXnWb+eq
 75JYFNYTUu+ihXnW3PO1dWkj3xxOizLvgmEdV1VWTblIXqd396isIdtQYVJ3w1ruRAVr
 cAtc4E2MQzUC2vfIth+LauZQTzAhVy89yJzecxbyKzyYxT3FhsRs/yDEVRfcnR8U/SiH
 HZXHYCuVPjnVzxSjJK986n1drXEoUl6XOeKKv16yYIDGGJL0FZH1YL1N6WlnFxo/Eqp8
 8qL7qeEPpGZnhYJZvcp5E2bJVN8erp0nLlAjCqW9ysfAGKLsiMVDUPwMWHQeCLqKtPCj
 jxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oanDNH9UXQs5SQ6FP6wfavjB/jgZbQ32aIl+6zF+rww=;
 b=SS2+GE0gRh3q1y+81k1GmvBksJ5ftDSf7fmpdf2Vi+AcVBH3De/PWlm6X+Lv5H+9nB
 bhi9bNIoRb0tqnxBaM7OvG/IctbYelrAVnz90gsz7z4k26sLCaU7fwYSoB1vVfvzEhwi
 gs/Qu297C73SgHbknpITUM79HoQ2QxAA91/KwIM3GskDLVOMQ7hikwxmSBi9WjFztSya
 Ka/c1iNomRNTDDOvWpQsBdu/7QsZg3tNFInY8YkcdPYebgdt5sZth+s6m+mD/Of4SKwg
 sQSGVOMNYE8X/3rBPNWpQHpQevGa9dZ26nn/JWw30tTXTD1l/+bYjXbsjHwv8UfUqzkH
 dsNg==
X-Gm-Message-State: ANhLgQ1m5mPOBF2ATzzXajVqEEQy/MloALHUO8NwPfWPxJMe1aG9Sd5Y
 uiFSenKHpxb5CHULH22FMLw8kC2UkE5wSQ==
X-Google-Smtp-Source: ADFU+vtX1bt2+d7AlYq1ntuf4cQeuWTVy+gfDj813UE6/CBK26pfB7kUIFrIX9P6u3IKqP6aCgWAwg==
X-Received: by 2002:a5d:518b:: with SMTP id k11mr22347036wrv.114.1583768654322; 
 Mon, 09 Mar 2020 08:44:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d63sm25932166wmd.44.2020.03.09.08.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 08:44:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 05/18] scripts/qapi: Move doc-comment whitespace stripping
 to doc.py
Date: Mon,  9 Mar 2020 15:43:52 +0000
Message-Id: <20200309154405.13548-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309154405.13548-1-peter.maydell@linaro.org>
References: <20200309154405.13548-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we accumulate lines from doc comments when parsing the JSON, the
QAPIDoc class generally strips leading and trailing whitespace using
line.strip() when it calls _append_freeform().  This is fine for
texinfo, but for rST leading whitespace is significant.  We'd like to
move to having the text in doc comments be rST format rather than a
custom syntax, so move the removal of leading whitespace from the
QAPIDoc class to the texinfo-specific processing code in
texi_format() in qapi/doc.py.

(Trailing whitespace will always be stripped by the rstrip() in
Section::append regardless.)

In a followup commit we will make the whitespace in the lines of doc
comment sections more consistently follow the input source.

There is no change to the generated .texi files before and after this
commit.

Because the qapi-schema test checks the exact values of the
documentation comments against a reference, we need to update that
reference to match the new whitespace.  In the first four places this
is now correctly checking that we did put in the amount of whitespace
to pass a rST-formatted list to the backend; in the last two places
the extra whitespace is 'wrong' and will go away again in the
following commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
New in v2: update doc-good.out as noted in final para of commit msg
---
 scripts/qapi/doc.py            |  1 +
 scripts/qapi/parser.py         | 12 ++++--------
 tests/qapi-schema/doc-good.out | 12 ++++++------
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 1787a53d91a..26cd1a1751e 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -79,6 +79,7 @@ def texi_format(doc):
     inlist = ''
     lastempty = False
     for line in doc.split('\n'):
+        line = line.strip()
         empty = line == ''
 
         # FIXME: Doing this in a single if / elif chain is
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index abadacbb0e8..7fae4478d34 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -417,10 +417,10 @@ class QAPIDoc:
                 self._append_line = self._append_various_line
                 self._append_various_line(line)
             else:
-                self._append_freeform(line.strip())
+                self._append_freeform(line)
         else:
             # This is a free-form documentation block
-            self._append_freeform(line.strip())
+            self._append_freeform(line)
 
     def _append_args_line(self, line):
         """
@@ -453,7 +453,7 @@ class QAPIDoc:
                 self._append_various_line(line)
             return
 
-        self._append_freeform(line.strip())
+        self._append_freeform(line)
 
     def _append_features_line(self, line):
         name = line.split(' ', 1)[0]
@@ -472,7 +472,7 @@ class QAPIDoc:
             self._append_various_line(line)
             return
 
-        self._append_freeform(line.strip())
+        self._append_freeform(line)
 
     def _append_various_line(self, line):
         """
@@ -495,10 +495,6 @@ class QAPIDoc:
             line = line[len(name)+1:]
             self._start_section(name[:-1])
 
-        if (not self._section.name or
-                not self._section.name.startswith('Example')):
-            line = line.strip()
-
         self._append_freeform(line)
 
     def _start_symbol_section(self, symbols_dict, name):
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 9503a3a3178..a65bce639ff 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -71,20 +71,20 @@ doc freeform
 
 * List item one
 * Two, multiple
-lines
+  lines
 
 * Three
-Still in list
+  Still in list
 
 Not in list
 
 - Second list
-Note: still in list
+  Note: still in list
 
 Note: not in list
 
 1. Third list
-is numbered
+   is numbered
 
 2. another item
 
@@ -144,7 +144,7 @@ doc symbol=Alternate
 
     arg=i
 an integer
-@b is undocumented
+    @b is undocumented
     arg=b
 
 doc freeform
@@ -157,7 +157,7 @@ doc symbol=cmd
 the first argument
     arg=arg2
 the second
-argument
+       argument
     arg=arg3
 
     feature=cmd-feat1
-- 
2.20.1


