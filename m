Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BD3C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:51:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7268C20578
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fo7dRYZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7268C20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKge-00034P-K3
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBKZp-0001ro-Cs
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBKZl-0001Np-UD
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:21 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:36916)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBKZl-0001N4-4K
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:17 -0400
Received: by mail-wr1-x42d.google.com with SMTP id 6so11824123wre.4
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 08:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N6mQu6BRQc+d3wvjojXxmiJN8RUreVO9yrOtythNod4=;
 b=fo7dRYZ9os3+a3d0+hUGbteCDtdwlVeO8VRf6wKssNLPL9M60o7gOAiZMuVyO04s2Q
 JVxlXF6+RhAZjaarSDTtSK4/j5kZ/2seQuwCe6vPRqRZCJLGS4Qbg4SUTdN5rcYFwD6k
 DDB/w9U1sOaoGVitqg3PVr/+QiSSCa/ZvnXyOZXENCu2wiw8nD7YRGDOCL57bHBSadEf
 EFK11rLwQzzgY8wVYNSFj1u+NO2Zf40xWyh18vz26ZkPk9FEwUeQbeqRafy6WXWW2nJc
 5lrwT9OW9DF0ZP4XeRtZ1r4FbW0c5Fu9Gw8TxmUCr+egV+1RMEbI++t85kilWy9efEZX
 sYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N6mQu6BRQc+d3wvjojXxmiJN8RUreVO9yrOtythNod4=;
 b=Y7SxmHx9mhr0jKJ6/Yka8/8fp0HsIAh71TXYPOhfoOxYjrVGHP0TOEMQZhfd9Lhxk4
 r3/uqHeE+bs4rryt0ze2CtE2HZqe2enb4PM67wrD8ocQor/I4Lspp1pTqFETBwZD8r8a
 SlNBVmW/q/UDnbIhGCBLrQp5yJxi2XRxqgI67bXY9yIBBrvrOO3edi2bUBi3Elywz1o5
 Ffcw2NbE47aSPe6XTSX4xMZnUUOC5UrzgnyiXT9kgHA/zZ10Ya4SkyWNFFupA/quLLJE
 hMurVi7vles1WO6oAUPyfuA6QTcXzMaMLcbsdJprb1Ze2Rlxg7WyrjNGk7r8wvALKBoH
 OuEg==
X-Gm-Message-State: ANhLgQ0xczdxB9NqPiEdDY+6gPhzxjqus4kRSZCTlRj/d7bktwWehQBh
 Dh+CBfIGz3zPl9GC5gkFgu3MBU0jwZ6yZg==
X-Google-Smtp-Source: ADFU+vsXGaUmFeqL/HdSTXNI5mI6FGVDRwdiAHsw8jH3cjccNy4hvbfBRJr31IWde338muOVT/exTA==
X-Received: by 2002:adf:fd11:: with SMTP id e17mr20441757wrr.195.1583768655645; 
 Mon, 09 Mar 2020 08:44:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d63sm25932166wmd.44.2020.03.09.08.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 08:44:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 06/18] scripts/qapi/parser.py: improve doc comment indent
 handling
Date: Mon,  9 Mar 2020 15:43:53 +0000
Message-Id: <20200309154405.13548-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309154405.13548-1-peter.maydell@linaro.org>
References: <20200309154405.13548-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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

Make the handling of indentation in doc comments more sophisticated,
so that when we see a section like:

Notes: some text
       some more text
          indented line 3

we save it for the doc-comment processing code as:

some text
some more text
   indented line 3

and when we see a section with the heading on its own line:

Notes:

some text
some more text
   indented text

we also accept that and save it in the same form.

The exception is that we always retain indentation as-is for Examples
sections, because these are literal text.

If we detect that the comment document text is not indented as much
as we expect it to be, we throw a parse error.  (We don't complain
about over-indented sections, because for rST this can be legitimate
markup.)

The golden reference for the doc comment text is updated to remove
the two 'wrong' indents; these now form a test case that we correctly
stripped leading whitespace from an indented multi-line argument
definition.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
v1->v2: Update doc-good.out as per final para.
---
 scripts/qapi/parser.py         | 81 +++++++++++++++++++++++++++-------
 tests/qapi-schema/doc-good.out |  4 +-
 2 files changed, 67 insertions(+), 18 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 7fae4478d34..d9f11eadd96 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -308,18 +308,32 @@ class QAPIDoc:
     """
 
     class Section:
-        def __init__(self, name=None):
+        def __init__(self, parser, name=None, indent=0):
+            # parser, for error messages about indentation
+            self._parser = parser
             # optional section name (argument/member or section name)
             self.name = name
             # the list of lines for this section
             self.text = ''
+            # the expected indent level of the text of this section
+            self._indent = indent
 
         def append(self, line):
+            # Strip leading spaces corresponding to the expected indent level
+            # Blank lines are always OK.
+            if line:
+                spacecount = len(line) - len(line.lstrip(" "))
+                if spacecount > self._indent:
+                    spacecount = self._indent
+                if spacecount < self._indent:
+                    raise QAPIParseError(self._parser, "unexpected de-indent")
+                line = line[spacecount:]
+
             self.text += line.rstrip() + '\n'
 
     class ArgSection(Section):
-        def __init__(self, name):
-            super().__init__(name)
+        def __init__(self, parser, name, indent=0):
+            super().__init__(parser, name, indent)
             self.member = None
 
         def connect(self, member):
@@ -333,7 +347,7 @@ class QAPIDoc:
         self._parser = parser
         self.info = info
         self.symbol = None
-        self.body = QAPIDoc.Section()
+        self.body = QAPIDoc.Section(parser)
         # dict mapping parameter name to ArgSection
         self.args = OrderedDict()
         self.features = OrderedDict()
@@ -438,7 +452,18 @@ class QAPIDoc:
 
         if name.startswith('@') and name.endswith(':'):
             line = line[len(name)+1:]
-            self._start_args_section(name[1:-1])
+            if not line or line.isspace():
+                # Line was just the "@arg:" header; following lines
+                # are not indented
+                indent = 0
+                line = ''
+            else:
+                # Line is "@arg: first line of description"; following
+                # lines should be indented by len(name) + 1, and we
+                # pad out this first line so it is handled the same way
+                indent = len(name) + 1
+                line = ' ' * indent + line
+            self._start_args_section(name[1:-1], indent)
         elif self._is_section_tag(name):
             self._append_line = self._append_various_line
             self._append_various_line(line)
@@ -460,7 +485,17 @@ class QAPIDoc:
 
         if name.startswith('@') and name.endswith(':'):
             line = line[len(name)+1:]
-            self._start_features_section(name[1:-1])
+            if not line or line.isspace():
+                # Line is just the "@name:" header, no ident for following lines
+                indent = 0
+                line = ''
+            else:
+                # Line is "@arg: first line of description"; following
+                # lines should be indented by len(name) + 3, and we
+                # pad out this first line so it is handled the same way
+                indent = len(name) + 1
+                line = ' ' * indent + line
+            self._start_features_section(name[1:-1], indent)
         elif self._is_section_tag(name):
             self._append_line = self._append_various_line
             self._append_various_line(line)
@@ -493,11 +528,23 @@ class QAPIDoc:
                                  % (name, self.sections[0].name))
         if self._is_section_tag(name):
             line = line[len(name)+1:]
-            self._start_section(name[:-1])
+            if not line or line.isspace():
+                # Line is just "SectionName:", no indent for following lines
+                indent = 0
+                line = ''
+            elif name.startswith("Example"):
+                # The "Examples" section is literal-text, so preserve
+                # all the indentation as-is
+                indent = 0
+            else:
+                # Line is "SectionName: some text", indent required
+                indent = len(name) + 1
+                line = ' ' * indent + line
+            self._start_section(name[:-1], indent)
 
         self._append_freeform(line)
 
-    def _start_symbol_section(self, symbols_dict, name):
+    def _start_symbol_section(self, symbols_dict, name, indent):
         # FIXME invalid names other than the empty string aren't flagged
         if not name:
             raise QAPIParseError(self._parser, "invalid parameter name")
@@ -506,21 +553,21 @@ class QAPIDoc:
                                  "'%s' parameter name duplicated" % name)
         assert not self.sections
         self._end_section()
-        self._section = QAPIDoc.ArgSection(name)
+        self._section = QAPIDoc.ArgSection(self._parser, name, indent)
         symbols_dict[name] = self._section
 
-    def _start_args_section(self, name):
-        self._start_symbol_section(self.args, name)
+    def _start_args_section(self, name, indent):
+        self._start_symbol_section(self.args, name, indent)
 
-    def _start_features_section(self, name):
-        self._start_symbol_section(self.features, name)
+    def _start_features_section(self, name, indent):
+        self._start_symbol_section(self.features, name, indent)
 
-    def _start_section(self, name=None):
+    def _start_section(self, name=None, indent=0):
         if name in ('Returns', 'Since') and self.has_section(name):
             raise QAPIParseError(self._parser,
                                  "duplicated '%s' section" % name)
         self._end_section()
-        self._section = QAPIDoc.Section(name)
+        self._section = QAPIDoc.Section(self._parser, name, indent)
         self.sections.append(self._section)
 
     def _end_section(self):
@@ -543,7 +590,7 @@ class QAPIDoc:
     def connect_member(self, member):
         if member.name not in self.args:
             # Undocumented TODO outlaw
-            self.args[member.name] = QAPIDoc.ArgSection(member.name)
+            self.args[member.name] = QAPIDoc.ArgSection(self._parser, member.name)
         self.args[member.name].connect(member)
 
     def connect_feature(self, feature):
@@ -551,6 +598,8 @@ class QAPIDoc:
             raise QAPISemError(feature.info,
                                "feature '%s' lacks documentation"
                                % feature.name)
+            self.features[feature.name] = QAPIDoc.ArgSection(self._parser,
+                                                             feature.name)
         self.features[feature.name].connect(feature)
 
     def check_expr(self, expr):
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index a65bce639ff..0302ce0bde1 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -144,7 +144,7 @@ doc symbol=Alternate
 
     arg=i
 an integer
-    @b is undocumented
+@b is undocumented
     arg=b
 
 doc freeform
@@ -157,7 +157,7 @@ doc symbol=cmd
 the first argument
     arg=arg2
 the second
-       argument
+argument
     arg=arg3
 
     feature=cmd-feat1
-- 
2.20.1


