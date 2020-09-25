Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273B4C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:33:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7624D221EC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xig6Zi/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7624D221EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqfJ-0002Hb-EY
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVP-0006fm-Bq
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:31 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:36227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVK-0006ng-56
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:31 -0400
Received: by mail-wm1-x32f.google.com with SMTP id e2so3947418wme.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 09:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5QK61Iu51GnV8ssf6Wi/MgxNc0CZq3E5l2KB7srun8Y=;
 b=Xig6Zi/osi3xvMQQjBVOJASsu8Au2CYCGwRw2at+fLRXuA1I1ScdGES86h1PtIirfg
 Uicaae3CHoxcetyqlNXUOLoeMWdv9bXUZx6sVnCMy8p7OxQrT7j4QXLL/6JSJcdxVySq
 DWz9ENEDkjxvSc5BROGoB79P7CbfXfsTgBkdlsqSc5F++WbVgGLr1pl/zd16yMJvZwVm
 5GAcmPxeYarmGb8RL77layYNW0Lx0Kga8LUR5C0UO4CwC12WysonUOynfraogrC1E/hd
 A1TI4Q7s7IumxCrQLGRYKzB8Bj3Uzho6O8hpaqepdMBSnoRwdTF0fwUg0fI05WykgN8j
 HXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5QK61Iu51GnV8ssf6Wi/MgxNc0CZq3E5l2KB7srun8Y=;
 b=Cz7Q4e24Vc3FebgIdd55wB2+fr2nfBFMUd19HCEoUOnk6rZFBfg/FeuKomFFeWXfph
 Ei6O3mqXxDZAYuXZ7PYMt3UTeA920alOpCW7VsTNHqKjNWWjgGhx2noW9020BmIol1lx
 yRZOyQS4SkChKuklieDStlw4/NP7u2+1scA83rSPpNfwsuioDOtKZaMnIk5AZKJQU7PE
 xie5dGji3YgBdKk2MCNuhabW3gj1IyqFUDwxMICdBpo/um3Swy28oxojjdZdFOWeMnkM
 Ocktut+dhJs/em/vchyAjL9uy/uDW4/Qs4p9z/hM1njSUQVI7UaBOF2wr5peSkxgBbtJ
 HhSw==
X-Gm-Message-State: AOAM530IPic3VExq0/CO9IwpKwl4sI5kHTXYBnRilAWPZjuw8zP9cuUF
 xEDX9GOD42duQT40q4vxUCyFxtejJ4y7+32U
X-Google-Smtp-Source: ABdhPJwzi7k5Xe1+M7y5Z+vrD5sccG0rJY/YKaSOM9RH5tVygubJPS9DC62ltFDmhJ+QndM4GN62gA==
X-Received: by 2002:a05:600c:2283:: with SMTP id
 3mr3826443wmf.37.1601051004050; 
 Fri, 25 Sep 2020 09:23:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d6sm3565824wrq.67.2020.09.25.09.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 09:23:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 05/21] scripts/qapi/parser.py: improve doc comment indent
 handling
Date: Fri, 25 Sep 2020 17:23:00 +0100
Message-Id: <20200925162316.21205-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925162316.21205-1-peter.maydell@linaro.org>
References: <20200925162316.21205-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
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

If we detect that the comment document text is not indented as much
as we expect it to be, we throw a parse error.  (We don't complain
about over-indented sections, because for rST this can be legitimate
markup.)

The golden reference for the doc comment text is updated to remove
the two 'wrong' indents; these now form a test case that we correctly
stripped leading whitespace from an indented multi-line argument
definition.

We update the documentation in docs/devel/qapi-code-gen.txt to
describe the new indentation rules.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/devel/qapi-code-gen.txt          | 23 +++++++
 scripts/qapi/parser.py                | 93 +++++++++++++++++++++------
 tests/qapi-schema/doc-bad-indent.err  |  1 +
 tests/qapi-schema/doc-bad-indent.json |  8 +++
 tests/qapi-schema/doc-bad-indent.out  |  0
 tests/qapi-schema/doc-good.out        |  4 +-
 tests/qapi-schema/meson.build         |  1 +
 7 files changed, 109 insertions(+), 21 deletions(-)
 create mode 100644 tests/qapi-schema/doc-bad-indent.err
 create mode 100644 tests/qapi-schema/doc-bad-indent.json
 create mode 100644 tests/qapi-schema/doc-bad-indent.out

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 9eede44350c..69eaffac376 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -901,6 +901,22 @@ commands and events), member (for structs and unions), branch (for
 alternates), or value (for enums), and finally optional tagged
 sections.
 
+Descriptions of arguments can span multiple lines. The description
+text can start on the line following the '@argname:', in which case
+it must not be indented at all. It can also start on the same line
+as the '@argname:'. In this case if it spans multiple lines then
+second and subsequent lines must be indented to line up with the
+first character of the first line of the description:
+
+# @argone:
+# This is a two line description
+# in the first style.
+#
+# @argtwo: This is a two line description
+#          in the second style.
+
+The number of spaces between the ':' and the text is not significant.
+
 FIXME: the parser accepts these things in almost any order.
 FIXME: union branches should be described, too.
 
@@ -911,6 +927,13 @@ A tagged section starts with one of the following words:
 "Note:"/"Notes:", "Since:", "Example"/"Examples", "Returns:", "TODO:".
 The section ends with the start of a new section.
 
+The text of a section can start on a new line, in
+which case it must not be indented at all.  It can also start
+on the same line as the 'Note:', 'Returns:', etc tag.  In this
+case if it spans multiple lines then second and subsequent
+lines must be indented to match the first, in the same way as
+multiline argument descriptions.
+
 A 'Since: x.y.z' tagged section lists the release that introduced the
 definition.
 
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 04bf10db378..6c3455b41f3 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -319,17 +319,32 @@ class QAPIDoc:
     """
 
     class Section:
-        def __init__(self, name=None):
+        def __init__(self, parser, name=None, indent=0):
+            # parser, for error messages about indentation
+            self._parser = parser
             # optional section name (argument/member or section name)
             self.name = name
             self.text = ''
+            # the expected indent level of the text of this section
+            self._indent = indent
 
         def append(self, line):
+            # Strip leading spaces corresponding to the expected indent level
+            # Blank lines are always OK.
+            if line:
+                indent = re.match(r'\s*', line).end()
+                if indent < self._indent:
+                    raise QAPIParseError(
+                        self._parser,
+                        "unexpected de-indent (expected at least %d spaces)" %
+                        self._indent)
+                line = line[self._indent:]
+
             self.text += line.rstrip() + '\n'
 
     class ArgSection(Section):
-        def __init__(self, name):
-            super().__init__(name)
+        def __init__(self, parser, name, indent=0):
+            super().__init__(parser, name, indent)
             self.member = None
 
         def connect(self, member):
@@ -343,7 +358,7 @@ class QAPIDoc:
         self._parser = parser
         self.info = info
         self.symbol = None
-        self.body = QAPIDoc.Section()
+        self.body = QAPIDoc.Section(parser)
         # dict mapping parameter name to ArgSection
         self.args = OrderedDict()
         self.features = OrderedDict()
@@ -447,8 +462,21 @@ class QAPIDoc:
         name = line.split(' ', 1)[0]
 
         if name.startswith('@') and name.endswith(':'):
-            line = line[len(name)+1:]
-            self._start_args_section(name[1:-1])
+            # If line is "@arg:   first line of description", find the
+            # index of 'f', which is the indent we expect for any
+            # following lines. We then remove the leading "@arg:" from line
+            # and replace it with spaces so that 'f' has the same index
+            # as it did in the original line and can be handled the same
+            # way we will handle following lines.
+            indent = re.match(r'@\S*:\s*', line).end()
+            line = line[indent:]
+            if not line:
+                # Line was just the "@arg:" header; following lines
+                # are not indented
+                indent = 0
+            else:
+                line = ' ' * indent + line
+            self._start_args_section(name[1:-1], indent)
         elif self._is_section_tag(name):
             self._append_line = self._append_various_line
             self._append_various_line(line)
@@ -469,8 +497,21 @@ class QAPIDoc:
         name = line.split(' ', 1)[0]
 
         if name.startswith('@') and name.endswith(':'):
-            line = line[len(name)+1:]
-            self._start_features_section(name[1:-1])
+            # If line is "@arg:   first line of description", find the
+            # index of 'f', which is the indent we expect for any
+            # following lines. We then remove the leading "@arg:" from line
+            # and replace it with spaces so that 'f' has the same index
+            # as it did in the original line and can be handled the same
+            # way we will handle following lines.
+            indent = re.match(r'@\S*:\s*', line).end()
+            line = line[indent:]
+            if not line:
+                # Line was just the "@arg:" header; following lines
+                # are not indented
+                indent = 0
+            else:
+                line = ' ' * indent + line
+            self._start_features_section(name[1:-1], indent)
         elif self._is_section_tag(name):
             self._append_line = self._append_various_line
             self._append_various_line(line)
@@ -502,12 +543,25 @@ class QAPIDoc:
                                  "'%s' can't follow '%s' section"
                                  % (name, self.sections[0].name))
         if self._is_section_tag(name):
-            line = line[len(name)+1:]
-            self._start_section(name[:-1])
+            # If line is "Section:   first line of description", find the
+            # index of 'f', which is the indent we expect for any
+            # following lines. We then remove the leading "Section:" from line
+            # and replace it with spaces so that 'f' has the same index
+            # as it did in the original line and can be handled the same
+            # way we will handle following lines.
+            indent = re.match(r'\S*:\s*', line).end()
+            line = line[indent:]
+            if not line:
+                # Line was just the "Section:" header; following lines
+                # are not indented
+                indent = 0
+            else:
+                line = ' ' * indent + line
+            self._start_section(name[:-1], indent)
 
         self._append_freeform(line)
 
-    def _start_symbol_section(self, symbols_dict, name):
+    def _start_symbol_section(self, symbols_dict, name, indent):
         # FIXME invalid names other than the empty string aren't flagged
         if not name:
             raise QAPIParseError(self._parser, "invalid parameter name")
@@ -516,21 +570,21 @@ class QAPIDoc:
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
@@ -553,7 +607,8 @@ class QAPIDoc:
     def connect_member(self, member):
         if member.name not in self.args:
             # Undocumented TODO outlaw
-            self.args[member.name] = QAPIDoc.ArgSection(member.name)
+            self.args[member.name] = QAPIDoc.ArgSection(self._parser,
+                                                        member.name)
         self.args[member.name].connect(member)
 
     def connect_feature(self, feature):
diff --git a/tests/qapi-schema/doc-bad-indent.err b/tests/qapi-schema/doc-bad-indent.err
new file mode 100644
index 00000000000..67844539bd2
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-indent.err
@@ -0,0 +1 @@
+doc-bad-indent.json:6:1: unexpected de-indent (expected at least 4 spaces)
diff --git a/tests/qapi-schema/doc-bad-indent.json b/tests/qapi-schema/doc-bad-indent.json
new file mode 100644
index 00000000000..edde8f21dc7
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-indent.json
@@ -0,0 +1,8 @@
+# Multiline doc comments should have consistent indentation
+
+##
+# @foo:
+# @a: line one
+# line two is wrongly indented
+##
+{ 'command': 'foo', 'data': { 'a': 'int' } }
diff --git a/tests/qapi-schema/doc-bad-indent.out b/tests/qapi-schema/doc-bad-indent.out
new file mode 100644
index 00000000000..e69de29bb2d
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 9993ffcd89d..b7e3f4313da 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -159,7 +159,7 @@ doc symbol=Alternate
 
     arg=i
 an integer
-    @b is undocumented
+@b is undocumented
     arg=b
 
     feature=alt-feat
@@ -174,7 +174,7 @@ doc symbol=cmd
 the first argument
     arg=arg2
 the second
-       argument
+argument
     arg=arg3
 
     feature=cmd-feat1
diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index f1449298b07..83a0a68389b 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -53,6 +53,7 @@ schemas = [
   'doc-bad-enum-member.json',
   'doc-bad-event-arg.json',
   'doc-bad-feature.json',
+  'doc-bad-indent.json',
   'doc-bad-section.json',
   'doc-bad-symbol.json',
   'doc-bad-union-member.json',
-- 
2.20.1


