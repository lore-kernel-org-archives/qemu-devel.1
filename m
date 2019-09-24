Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01719C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE0732064A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0732064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iClYR-0007L1-ER
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 10:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCks6-0000LQ-EE
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCkru-0001SZ-Si
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34536)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCkrt-0001RC-QG
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EA9A5302C068;
 Tue, 24 Sep 2019 13:28:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 16C8D5D713;
 Tue, 24 Sep 2019 13:28:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6EDB811386A8; Tue, 24 Sep 2019 15:28:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/25] qapi: Change frontend error messages to start with
 lower case
Date: Tue, 24 Sep 2019 15:28:11 +0200
Message-Id: <20190924132830.15835-7-armbru@redhat.com>
In-Reply-To: <20190924132830.15835-1-armbru@redhat.com>
References: <20190924132830.15835-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 24 Sep 2019 13:28:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Starting error messages with a capital letter complicates things when
text can get interpolated both at the beginning and in the middle of
an error message.  The next patch will do that.  Switch to lower case
to keep it simpler.

For what it's worth, the GNU Coding Standards advise the message
"should not begin with a capital letter when it follows a program name
and/or file name, because that isn=E2=80=99t the beginning of a sentence.=
 (The
sentence conceptually starts at the beginning of the line.)"

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py                        | 175 +++++++++---------
 tests/qapi-schema/alternate-any.err           |   2 +-
 tests/qapi-schema/alternate-array.err         |   2 +-
 tests/qapi-schema/alternate-base.err          |   2 +-
 .../alternate-conflict-bool-string.err        |   2 +-
 tests/qapi-schema/alternate-conflict-dict.err |   2 +-
 .../alternate-conflict-enum-bool.err          |   2 +-
 .../alternate-conflict-enum-int.err           |   2 +-
 .../alternate-conflict-num-string.err         |   2 +-
 .../qapi-schema/alternate-conflict-string.err |   2 +-
 tests/qapi-schema/alternate-empty.err         |   2 +-
 tests/qapi-schema/alternate-invalid-dict.err  |   2 +-
 tests/qapi-schema/alternate-nested.err        |   2 +-
 tests/qapi-schema/alternate-unknown.err       |   2 +-
 tests/qapi-schema/args-array-empty.err        |   2 +-
 tests/qapi-schema/args-array-unknown.err      |   2 +-
 tests/qapi-schema/args-member-array-bad.err   |   2 +-
 tests/qapi-schema/args-member-case.err        |   2 +-
 tests/qapi-schema/args-member-unknown.err     |   2 +-
 tests/qapi-schema/bad-type-int.err            |   2 +-
 tests/qapi-schema/base-cycle-direct.err       |   2 +-
 tests/qapi-schema/base-cycle-indirect.err     |   2 +-
 .../qapi-schema/doc-bad-alternate-member.err  |   2 +-
 tests/qapi-schema/doc-bad-command-arg.err     |   2 +-
 tests/qapi-schema/doc-bad-symbol.err          |   2 +-
 tests/qapi-schema/doc-bad-union-member.err    |   2 +-
 tests/qapi-schema/doc-before-include.err      |   2 +-
 tests/qapi-schema/doc-before-pragma.err       |   2 +-
 tests/qapi-schema/doc-duplicated-return.err   |   2 +-
 tests/qapi-schema/doc-duplicated-since.err    |   2 +-
 tests/qapi-schema/doc-empty-arg.err           |   2 +-
 tests/qapi-schema/doc-empty-section.err       |   2 +-
 tests/qapi-schema/doc-empty-symbol.err        |   2 +-
 tests/qapi-schema/doc-invalid-end.err         |   2 +-
 tests/qapi-schema/doc-invalid-end2.err        |   2 +-
 tests/qapi-schema/doc-invalid-start.err       |   2 +-
 tests/qapi-schema/doc-missing-colon.err       |   2 +-
 tests/qapi-schema/doc-missing-expr.err        |   2 +-
 tests/qapi-schema/doc-missing-space.err       |   2 +-
 tests/qapi-schema/doc-missing.err             |   2 +-
 tests/qapi-schema/doc-no-symbol.err           |   2 +-
 tests/qapi-schema/double-type.err             |   2 +-
 tests/qapi-schema/duplicate-key.err           |   2 +-
 tests/qapi-schema/enum-bad-member.err         |   2 +-
 tests/qapi-schema/enum-bad-name.err           |   2 +-
 tests/qapi-schema/enum-bad-prefix.err         |   2 +-
 .../qapi-schema/enum-dict-member-unknown.err  |   2 +-
 tests/qapi-schema/enum-int-member.err         |   2 +-
 tests/qapi-schema/enum-member-case.err        |   2 +-
 tests/qapi-schema/enum-missing-data.err       |   2 +-
 tests/qapi-schema/enum-wrong-data.err         |   2 +-
 tests/qapi-schema/escape-outside-string.err   |   2 +-
 tests/qapi-schema/escape-too-big.err          |   1 +
 tests/qapi-schema/event-boxed-empty.err       |   2 +-
 .../qapi-schema/event-member-invalid-dict.err |   2 +-
 tests/qapi-schema/event-nest-struct.err       |   2 +-
 tests/qapi-schema/features-bad-type.err       |   2 +-
 tests/qapi-schema/features-missing-name.err   |   2 +-
 tests/qapi-schema/features-name-bad-type.err  |   2 +-
 tests/qapi-schema/features-no-list.err        |   2 +-
 tests/qapi-schema/features-unknown-key.err    |   2 +-
 tests/qapi-schema/flat-union-array-branch.err |   2 +-
 .../flat-union-bad-discriminator.err          |   2 +-
 .../flat-union-discriminator-bad-name.err     |   2 +-
 tests/qapi-schema/flat-union-empty.err        |   2 +-
 .../flat-union-inline-invalid-dict.err        |   2 +-
 tests/qapi-schema/flat-union-inline.err       |   2 +-
 tests/qapi-schema/flat-union-int-branch.err   |   2 +-
 .../flat-union-invalid-branch-key.err         |   2 +-
 .../flat-union-invalid-discriminator.err      |   2 +-
 .../flat-union-invalid-if-discriminator.err   |   2 +-
 tests/qapi-schema/flat-union-no-base.err      |   2 +-
 .../flat-union-optional-discriminator.err     |   2 +-
 .../flat-union-string-discriminator.err       |   2 +-
 tests/qapi-schema/funny-char.err              |   2 +-
 tests/qapi-schema/funny-word.err              |   2 +-
 tests/qapi-schema/ident-with-escape.err       |   2 +-
 tests/qapi-schema/include-before-err.err      |   2 +-
 tests/qapi-schema/include-cycle.err           |   2 +-
 tests/qapi-schema/include-extra-junk.err      |   2 +-
 tests/qapi-schema/include-nested-err.err      |   2 +-
 tests/qapi-schema/include-non-file.err        |   2 +-
 tests/qapi-schema/include-self-cycle.err      |   2 +-
 tests/qapi-schema/leading-comma-list.err      |   2 +-
 tests/qapi-schema/leading-comma-object.err    |   2 +-
 tests/qapi-schema/missing-colon.err           |   2 +-
 tests/qapi-schema/missing-comma-list.err      |   2 +-
 tests/qapi-schema/missing-comma-object.err    |   2 +-
 tests/qapi-schema/missing-type.err            |   2 +-
 .../nested-struct-data-invalid-dict.err       |   2 +-
 tests/qapi-schema/nested-struct-data.err      |   2 +-
 tests/qapi-schema/non-objects.err             |   2 +-
 .../qapi-schema/pragma-doc-required-crap.err  |   2 +-
 tests/qapi-schema/pragma-extra-junk.err       |   2 +-
 .../pragma-name-case-whitelist-crap.err       |   2 +-
 tests/qapi-schema/pragma-non-dict.err         |   2 +-
 .../pragma-returns-whitelist-crap.err         |   2 +-
 tests/qapi-schema/pragma-unknown.err          |   2 +-
 tests/qapi-schema/quoted-structural-chars.err |   2 +-
 tests/qapi-schema/reserved-enum-q.err         |   2 +-
 tests/qapi-schema/reserved-member-has.err     |   2 +-
 tests/qapi-schema/reserved-member-q.err       |   2 +-
 tests/qapi-schema/reserved-member-u.err       |   2 +-
 .../reserved-member-underscore.err            |   2 +-
 tests/qapi-schema/string-code-point-127.err   |   2 +-
 tests/qapi-schema/string-code-point-31.err    |   2 +-
 tests/qapi-schema/string-control.err          |   1 +
 tests/qapi-schema/string-unclosed.err         |   1 +
 tests/qapi-schema/string-unicode.err          |   1 +
 .../struct-member-invalid-dict.err            |   2 +-
 tests/qapi-schema/struct-member-invalid.err   |   2 +-
 tests/qapi-schema/trailing-comma-list.err     |   2 +-
 tests/qapi-schema/trailing-comma-object.err   |   2 +-
 tests/qapi-schema/unclosed-list.err           |   2 +-
 tests/qapi-schema/unclosed-object.err         |   2 +-
 tests/qapi-schema/unclosed-string.err         |   2 +-
 tests/qapi-schema/union-base-empty.err        |   2 +-
 .../union-base-no-discriminator.err           |   2 +-
 tests/qapi-schema/union-branch-case.err       |   2 +-
 .../qapi-schema/union-branch-invalid-dict.err |   2 +-
 tests/qapi-schema/union-empty.err             |   2 +-
 tests/qapi-schema/union-optional-branch.err   |   2 +-
 tests/qapi-schema/union-unknown.err           |   2 +-
 tests/qapi-schema/unknown-escape.err          |   2 +-
 tests/qapi-schema/unknown-expr-key.err        |   2 +-
 125 files changed, 215 insertions(+), 204 deletions(-)
 create mode 100644 tests/qapi-schema/escape-too-big.err
 create mode 100644 tests/qapi-schema/string-control.err
 create mode 100644 tests/qapi-schema/string-unclosed.err
 create mode 100644 tests/qapi-schema/string-unicode.err

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index ed4bff4479..23f1c8eece 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -207,7 +207,7 @@ class QAPIDoc(object):
             return
=20
         if line[0] !=3D ' ':
-            raise QAPIParseError(self._parser, "Missing space after #")
+            raise QAPIParseError(self._parser, "missing space after #")
         line =3D line[1:]
         self._append_line(line)
=20
@@ -241,11 +241,11 @@ class QAPIDoc(object):
         # recognized, and get silently treated as ordinary text
         if not self.symbol and not self.body.text and line.startswith('@=
'):
             if not line.endswith(':'):
-                raise QAPIParseError(self._parser, "Line should end with=
 ':'")
+                raise QAPIParseError(self._parser, "line should end with=
 ':'")
             self.symbol =3D line[1:-1]
             # FIXME invalid names other than the empty string aren't fla=
gged
             if not self.symbol:
-                raise QAPIParseError(self._parser, "Invalid name")
+                raise QAPIParseError(self._parser, "invalid name")
         elif self.symbol:
             # This is a definition documentation block
             if name.startswith('@') and name.endswith(':'):
@@ -344,7 +344,7 @@ class QAPIDoc(object):
     def _start_symbol_section(self, symbols_dict, name):
         # FIXME invalid names other than the empty string aren't flagged
         if not name:
-            raise QAPIParseError(self._parser, "Invalid parameter name")
+            raise QAPIParseError(self._parser, "invalid parameter name")
         if name in symbols_dict:
             raise QAPIParseError(self._parser,
                                  "'%s' parameter name duplicated" % name=
)
@@ -362,7 +362,7 @@ class QAPIDoc(object):
     def _start_section(self, name=3DNone):
         if name in ('Returns', 'Since') and self.has_section(name):
             raise QAPIParseError(self._parser,
-                                 "Duplicated '%s' section" % name)
+                                 "duplicated '%s' section" % name)
         self._end_section()
         self._section =3D QAPIDoc.Section(name)
         self.sections.append(self._section)
@@ -371,7 +371,7 @@ class QAPIDoc(object):
         if self._section:
             text =3D self._section.text =3D self._section.text.strip()
             if self._section.name and (not text or text.isspace()):
-                raise QAPIParseError(self._parser, "Empty doc section '%=
s'"
+                raise QAPIParseError(self._parser, "empty doc section '%=
s'"
                                      % self._section.name)
             self._section =3D None
=20
@@ -400,7 +400,7 @@ class QAPIDoc(object):
         if bogus:
             raise QAPISemError(
                 self.info,
-                "The following documented members are not in "
+                "the following documented members are not in "
                 "the declaration: %s" % ", ".join(bogus))
=20
=20
@@ -432,11 +432,11 @@ class QAPISchemaParser(object):
             if 'include' in expr:
                 self.reject_expr_doc(cur_doc)
                 if len(expr) !=3D 1:
-                    raise QAPISemError(info, "Invalid 'include' directiv=
e")
+                    raise QAPISemError(info, "invalid 'include' directiv=
e")
                 include =3D expr['include']
                 if not isinstance(include, str):
                     raise QAPISemError(info,
-                                       "Value of 'include' must be a str=
ing")
+                                       "value of 'include' must be a str=
ing")
                 incl_fname =3D os.path.join(os.path.dirname(self.fname),
                                           include)
                 self.exprs.append({'expr': {'include': incl_fname},
@@ -449,11 +449,11 @@ class QAPISchemaParser(object):
             elif "pragma" in expr:
                 self.reject_expr_doc(cur_doc)
                 if len(expr) !=3D 1:
-                    raise QAPISemError(info, "Invalid 'pragma' directive=
")
+                    raise QAPISemError(info, "invalid 'pragma' directive=
")
                 pragma =3D expr['pragma']
                 if not isinstance(pragma, dict):
                     raise QAPISemError(
-                        info, "Value of 'pragma' must be an object")
+                        info, "value of 'pragma' must be an object")
                 for name, value in pragma.items():
                     self._pragma(name, value, info)
             else:
@@ -462,7 +462,7 @@ class QAPISchemaParser(object):
                 if cur_doc:
                     if not cur_doc.symbol:
                         raise QAPISemError(
-                            cur_doc.info, "Definition documentation requ=
ired")
+                            cur_doc.info, "definition documentation requ=
ired")
                     expr_elem['doc'] =3D cur_doc
                 self.exprs.append(expr_elem)
             cur_doc =3D None
@@ -473,7 +473,7 @@ class QAPISchemaParser(object):
         if doc and doc.symbol:
             raise QAPISemError(
                 doc.info,
-                "Documentation for '%s' is not followed by the definitio=
n"
+                "documentation for '%s' is not followed by the definitio=
n"
                 % doc.symbol)
=20
     def _include(self, include, info, incl_fname, previously_included):
@@ -482,7 +482,7 @@ class QAPISchemaParser(object):
         inf =3D info
         while inf:
             if incl_abs_fname =3D=3D os.path.abspath(inf.fname):
-                raise QAPISemError(info, "Inclusion loop for %s" % inclu=
de)
+                raise QAPISemError(info, "inclusion loop for %s" % inclu=
de)
             inf =3D inf.parent
=20
         # skip multiple include of the same file
@@ -503,24 +503,24 @@ class QAPISchemaParser(object):
         if name =3D=3D 'doc-required':
             if not isinstance(value, bool):
                 raise QAPISemError(info,
-                                   "Pragma 'doc-required' must be boolea=
n")
+                                   "pragma 'doc-required' must be boolea=
n")
             doc_required =3D value
         elif name =3D=3D 'returns-whitelist':
             if (not isinstance(value, list)
                     or any([not isinstance(elt, str) for elt in value]))=
:
-                raise QAPISemError(info,
-                                   "Pragma returns-whitelist must be"
-                                   " a list of strings")
+                raise QAPISemError(
+                    info,
+                    "pragma returns-whitelist must be a list of strings"=
)
             returns_whitelist =3D value
         elif name =3D=3D 'name-case-whitelist':
             if (not isinstance(value, list)
                     or any([not isinstance(elt, str) for elt in value]))=
:
-                raise QAPISemError(info,
-                                   "Pragma name-case-whitelist must be"
-                                   " a list of strings")
+                raise QAPISemError(
+                    info,
+                    "pragma name-case-whitelist must be a list of string=
s")
             name_case_whitelist =3D value
         else:
-            raise QAPISemError(info, "Unknown pragma '%s'" % name)
+            raise QAPISemError(info, "unknown pragma '%s'" % name)
=20
     def accept(self, skip_comment=3DTrue):
         while True:
@@ -547,13 +547,13 @@ class QAPISchemaParser(object):
                     ch =3D self.src[self.cursor]
                     self.cursor +=3D 1
                     if ch =3D=3D '\n':
-                        raise QAPIParseError(self, "Missing terminating =
\"'\"")
+                        raise QAPIParseError(self, "missing terminating =
\"'\"")
                     if esc:
                         # Note: we recognize only \\ because we have
                         # no use for funny characters in strings
                         if ch !=3D '\\':
                             raise QAPIParseError(self,
-                                                 "Unknown escape \\%s" %=
 ch)
+                                                 "unknown escape \\%s" %=
 ch)
                         esc =3D False
                     elif ch =3D=3D '\\':
                         esc =3D True
@@ -563,7 +563,7 @@ class QAPISchemaParser(object):
                         return
                     if ord(ch) < 32 or ord(ch) >=3D 127:
                         raise QAPIParseError(
-                            self, "Funny character in string")
+                            self, "funny character in string")
                     string +=3D ch
             elif self.src.startswith('true', self.pos):
                 self.val =3D True
@@ -584,7 +584,7 @@ class QAPISchemaParser(object):
                 # character
                 match =3D re.match('[^[\\]{}:,\\s\'"]+',
                                  self.src[self.cursor-1:])
-                raise QAPIParseError(self, "Stray '%s'" % match.group(0)=
)
+                raise QAPIParseError(self, "stray '%s'" % match.group(0)=
)
=20
     def get_members(self):
         expr =3D OrderedDict()
@@ -592,24 +592,24 @@ class QAPISchemaParser(object):
             self.accept()
             return expr
         if self.tok !=3D "'":
-            raise QAPIParseError(self, "Expected string or '}'")
+            raise QAPIParseError(self, "expected string or '}'")
         while True:
             key =3D self.val
             self.accept()
             if self.tok !=3D ':':
-                raise QAPIParseError(self, "Expected ':'")
+                raise QAPIParseError(self, "expected ':'")
             self.accept()
             if key in expr:
-                raise QAPIParseError(self, "Duplicate key '%s'" % key)
+                raise QAPIParseError(self, "duplicate key '%s'" % key)
             expr[key] =3D self.get_expr(True)
             if self.tok =3D=3D '}':
                 self.accept()
                 return expr
             if self.tok !=3D ',':
-                raise QAPIParseError(self, "Expected ',' or '}'")
+                raise QAPIParseError(self, "expected ',' or '}'")
             self.accept()
             if self.tok !=3D "'":
-                raise QAPIParseError(self, "Expected string")
+                raise QAPIParseError(self, "expected string")
=20
     def get_values(self):
         expr =3D []
@@ -618,19 +618,19 @@ class QAPISchemaParser(object):
             return expr
         if self.tok not in "{['tfn":
             raise QAPIParseError(
-                self, "Expected '{', '[', ']', string, boolean or 'null'=
")
+                self, "expected '{', '[', ']', string, boolean or 'null'=
")
         while True:
             expr.append(self.get_expr(True))
             if self.tok =3D=3D ']':
                 self.accept()
                 return expr
             if self.tok !=3D ',':
-                raise QAPIParseError(self, "Expected ',' or ']'")
+                raise QAPIParseError(self, "expected ',' or ']'")
             self.accept()
=20
     def get_expr(self, nested):
         if self.tok !=3D '{' and not nested:
-            raise QAPIParseError(self, "Expected '{'")
+            raise QAPIParseError(self, "expected '{'")
         if self.tok =3D=3D '{':
             self.accept()
             expr =3D self.get_members()
@@ -642,13 +642,13 @@ class QAPISchemaParser(object):
             self.accept()
         else:
             raise QAPIParseError(
-                self, "Expected '{', '[', string, boolean or 'null'")
+                self, "expected '{', '[', string, boolean or 'null'")
         return expr
=20
     def get_doc(self, info):
         if self.val !=3D '##':
-            raise QAPIParseError(self, "Junk after '##' at start of "
-                                 "documentation comment")
+            raise QAPIParseError(
+                self, "junk after '##' at start of documentation comment=
")
=20
         doc =3D QAPIDoc(self, info)
         self.accept(False)
@@ -656,8 +656,9 @@ class QAPISchemaParser(object):
             if self.val.startswith('##'):
                 # End of doc comment
                 if self.val !=3D '##':
-                    raise QAPIParseError(self, "Junk after '##' at end o=
f "
-                                         "documentation comment")
+                    raise QAPIParseError(
+                        self,
+                        "junk after '##' at end of documentation comment=
")
                 doc.end_comment()
                 self.accept()
                 return doc
@@ -665,7 +666,7 @@ class QAPISchemaParser(object):
                 doc.append(self.val)
             self.accept(False)
=20
-        raise QAPIParseError(self, "Documentation comment must end with =
'##'")
+        raise QAPIParseError(self, "documentation comment must end with =
'##'")
=20
=20
 #
@@ -804,18 +805,18 @@ def check_type(info, source, value,
=20
     # value is a dictionary, check that each member is okay
     for (key, arg) in value.items():
-        check_name(info, "Member of %s" % source, key,
+        check_name(info, "member of %s" % source, key,
                    allow_optional=3DTrue, permit_upper=3Dpermit_upper)
         if c_name(key, False) =3D=3D 'u' or c_name(key, False).startswit=
h('has_'):
-            raise QAPISemError(info, "Member of %s uses reserved name '%=
s'"
-                               % (source, key))
+            raise QAPISemError(
+                info, "member of %s uses reserved name '%s'" % (source, =
key))
         # Todo: allow dictionaries to represent default values of
         # an optional argument.
         check_known_keys(info, "member '%s' of %s" % (key, source),
                          arg, ['type'], ['if'])
         check_if(arg, info)
         normalize_if(arg)
-        check_type(info, "Member '%s' of %s" % (key, source),
+        check_type(info, "member '%s' of %s" % (key, source),
                    arg['type'], allow_array=3DTrue,
                    allow_metas=3D['built-in', 'union', 'alternate', 'str=
uct',
                                 'enum'])
@@ -868,8 +869,8 @@ def check_union(expr, info):
         enum_values =3D members.keys()
         allow_metas =3D ['built-in', 'union', 'alternate', 'struct', 'en=
um']
         if base is not None:
-            raise QAPISemError(info, "Simple union '%s' must not have a =
base" %
-                               name)
+            raise QAPISemError(
+                info, "simple union '%s' must not have a base" % name)
=20
     # Else, it's a flat union.
     else:
@@ -878,46 +879,47 @@ def check_union(expr, info):
                    base, allow_dict=3Dname,
                    allow_metas=3D['struct'])
         if not base:
-            raise QAPISemError(info, "Flat union '%s' must have a base"
+            raise QAPISemError(info, "flat union '%s' must have a base"
                                % name)
         base_members =3D find_base_members(base)
         assert base_members is not None
=20
         # The value of member 'discriminator' must name a non-optional
         # member of the base struct.
-        check_name(info, "Discriminator of flat union '%s'" % name,
+        check_name(info, "discriminator of flat union '%s'" % name,
                    discriminator)
         discriminator_value =3D base_members.get(discriminator)
         if not discriminator_value:
             raise QAPISemError(info,
-                               "Discriminator '%s' is not a member of 'b=
ase'"
+                               "discriminator '%s' is not a member of 'b=
ase'"
                                % discriminator)
         if discriminator_value.get('if'):
             raise QAPISemError(
                 info,
-                "The discriminator '%s' for union %s must not be conditi=
onal"
+                "the discriminator '%s' for union %s must not be conditi=
onal"
                 % (discriminator, name))
         enum_define =3D enum_types.get(discriminator_value['type'])
         # Do not allow string discriminator
         if not enum_define:
-            raise QAPISemError(info,
-                               "Discriminator '%s' must be of enumeratio=
n "
-                               "type" % discriminator)
+            raise QAPISemError(
+                info,
+                "discriminator '%s' must be of enumeration type"
+                % discriminator)
         enum_values =3D enum_get_names(enum_define)
         allow_metas =3D ['struct']
=20
     if (len(enum_values) =3D=3D 0):
-        raise QAPISemError(info, "Union '%s' has no branches" % name)
+        raise QAPISemError(info, "union '%s' has no branches" % name)
=20
     for (key, value) in members.items():
-        check_name(info, "Member of union '%s'" % name, key)
+        check_name(info, "member of union '%s'" % name, key)
=20
         check_known_keys(info, "member '%s' of union '%s'" % (key, name)=
,
                          value, ['type'], ['if'])
         check_if(value, info)
         normalize_if(value)
         # Each value must name a known type
-        check_type(info, "Member '%s' of union '%s'" % (key, name),
+        check_type(info, "member '%s' of union '%s'" % (key, name),
                    value['type'],
                    allow_array=3Dnot base, allow_metas=3Dallow_metas)
=20
@@ -925,10 +927,10 @@ def check_union(expr, info):
         # of 'data' must also be members of the enum type.
         if discriminator is not None:
             if key not in enum_values:
-                raise QAPISemError(info,
-                                   "Discriminator value '%s' is not foun=
d in "
-                                   "enum '%s'"
-                                   % (key, enum_define['enum']))
+                raise QAPISemError(
+                    info,
+                    "discriminator value '%s' is not found in enum '%s'"
+                    % (key, enum_define['enum']))
=20
=20
 def check_alternate(expr, info):
@@ -938,9 +940,9 @@ def check_alternate(expr, info):
=20
     if len(members) =3D=3D 0:
         raise QAPISemError(info,
-                           "Alternate '%s' cannot have empty 'data'" % n=
ame)
+                           "alternate '%s' cannot have empty 'data'" % n=
ame)
     for (key, value) in members.items():
-        check_name(info, "Member of alternate '%s'" % name, key)
+        check_name(info, "member of alternate '%s'" % name, key)
         check_known_keys(info,
                          "member '%s' of alternate '%s'" % (key, name),
                          value, ['type'], ['if'])
@@ -949,12 +951,14 @@ def check_alternate(expr, info):
         typ =3D value['type']
=20
         # Ensure alternates have no type conflicts.
-        check_type(info, "Member '%s' of alternate '%s'" % (key, name), =
typ,
+        check_type(info, "member '%s' of alternate '%s'" % (key, name), =
typ,
                    allow_metas=3D['built-in', 'union', 'struct', 'enum']=
)
         qtype =3D find_alternate_member_qtype(typ)
         if not qtype:
-            raise QAPISemError(info, "Alternate '%s' member '%s' cannot =
use "
-                               "type '%s'" % (name, key, typ))
+            raise QAPISemError(
+                info,
+                "alternate '%s' member '%s' cannot use type '%s'"
+                % (name, key, typ))
         conflicting =3D set([qtype])
         if qtype =3D=3D 'QTYPE_QSTRING':
             enum_expr =3D enum_types.get(typ)
@@ -969,9 +973,11 @@ def check_alternate(expr, info):
                 conflicting.add('QTYPE_QBOOL')
         for qt in conflicting:
             if qt in types_seen:
-                raise QAPISemError(info, "Alternate '%s' member '%s' can=
't "
-                                   "be distinguished from member '%s'"
-                                   % (name, key, types_seen[qt]))
+                raise QAPISemError(
+                    info,
+                    "alternate '%s' member '%s' can't be distinguished "
+                    "from member '%s'"
+                    % (name, key, types_seen[qt]))
             types_seen[qt] =3D key
=20
=20
@@ -982,10 +988,10 @@ def check_enum(expr, info):
=20
     if not isinstance(members, list):
         raise QAPISemError(info,
-                           "Enum '%s' requires an array for 'data'" % na=
me)
+                           "enum '%s' requires an array for 'data'" % na=
me)
     if prefix is not None and not isinstance(prefix, str):
         raise QAPISemError(info,
-                           "Enum '%s' requires a string for 'prefix'" % =
name)
+                           "enum '%s' requires a string for 'prefix'" % =
name)
=20
     permit_upper =3D name in name_case_whitelist
=20
@@ -994,7 +1000,7 @@ def check_enum(expr, info):
                          ['name'], ['if'])
         check_if(member, info)
         normalize_if(member)
-        check_name(info, "Member of enum '%s'" % name, member['name'],
+        check_name(info, "member of enum '%s'" % name, member['name'],
                    enum_member=3DTrue, permit_upper=3Dpermit_upper)
=20
=20
@@ -1010,9 +1016,8 @@ def check_struct(expr, info):
=20
     if features:
         if not isinstance(features, list):
-            raise QAPISemError(info,
-                               "Struct '%s' requires an array for 'featu=
res'" %
-                               name)
+            raise QAPISemError(
+                info, "struct '%s' requires an array for 'features'" % n=
ame)
         for f in features:
             assert isinstance(f, dict)
             check_known_keys(info, "feature of struct %s" % name, f,
@@ -1020,7 +1025,7 @@ def check_struct(expr, info):
=20
             check_if(f, info)
             normalize_if(f)
-            check_name(info, "Feature of struct %s" % name, f['name'])
+            check_name(info, "feature of struct %s" % name, f['name'])
=20
=20
 def check_known_keys(info, source, value, required, optional):
@@ -1030,13 +1035,13 @@ def check_known_keys(info, source, value, require=
d, optional):
=20
     missing =3D set(required) - set(value)
     if missing:
-        raise QAPISemError(info, "Key%s %s %s missing from %s"
+        raise QAPISemError(info, "key%s %s %s missing from %s"
                            % ('s' if len(missing) > 1 else '', pprint(mi=
ssing),
                               'are' if len(missing) > 1 else 'is', sourc=
e))
     allowed =3D set(required + optional)
     unknown =3D set(value) - allowed
     if unknown:
-        raise QAPISemError(info, "Unknown key%s %s in %s\nValid keys are=
 %s."
+        raise QAPISemError(info, "unknown key%s %s in %s\nValid keys are=
 %s."
                            % ('s' if len(unknown) > 1 else '', pprint(un=
known),
                               source, pprint(allowed)))
=20
@@ -1106,7 +1111,7 @@ def check_exprs(exprs):
=20
         if not doc and doc_required:
             raise QAPISemError(info,
-                               "Definition missing documentation comment=
")
+                               "definition missing documentation comment=
")
=20
         if 'enum' in expr:
             meta =3D 'enum'
@@ -1142,14 +1147,16 @@ def check_exprs(exprs):
             check_keys(expr, info, 'event', [], ['data', 'boxed', 'if'])
             normalize_members(expr.get('data'))
         else:
-            raise QAPISemError(info, "Expression is missing metatype")
+            raise QAPISemError(info, "expression is missing metatype")
         normalize_if(expr)
         name =3D expr[meta]
         add_name(name, info, meta)
         info.set_defn(meta, name)
         if doc and doc.symbol !=3D name:
-            raise QAPISemError(info, "Definition of '%s' follows documen=
tation"
-                               " for '%s'" % (name, doc.symbol))
+            raise QAPISemError(
+                info,
+                "definition of '%s' follows documentation for '%s'"
+                % (name, doc.symbol))
=20
     # Validate that exprs make sense
     for expr_elem in exprs:
@@ -1462,7 +1469,7 @@ class QAPISchemaObjectType(QAPISchemaType):
         if self._checked:
             # Recursed: C struct contains itself
             raise QAPISemError(self.info,
-                               "Object %s contains itself" % self.name)
+                               "object %s contains itself" % self.name)
=20
         QAPISchemaType.check(self, schema)
         assert self._checked and self.members is None
@@ -1734,7 +1741,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
             assert isinstance(self.arg_type, QAPISchemaObjectType)
             assert not self.arg_type.variants or self.boxed
         elif self.boxed:
-            raise QAPISemError(self.info, "Use of 'boxed' requires 'data=
'")
+            raise QAPISemError(self.info, "use of 'boxed' requires 'data=
'")
         if self._ret_type_name:
             self.ret_type =3D schema.lookup_type(self._ret_type_name)
             assert isinstance(self.ret_type, QAPISchemaType)
@@ -1763,7 +1770,7 @@ class QAPISchemaEvent(QAPISchemaEntity):
             assert isinstance(self.arg_type, QAPISchemaObjectType)
             assert not self.arg_type.variants or self.boxed
         elif self.boxed:
-            raise QAPISemError(self.info, "Use of 'boxed' requires 'data=
'")
+            raise QAPISemError(self.info, "use of 'boxed' requires 'data=
'")
=20
     def visit(self, visitor):
         QAPISchemaEntity.visit(self, visitor)
diff --git a/tests/qapi-schema/alternate-any.err b/tests/qapi-schema/alte=
rnate-any.err
index 177a11cc12..5314760775 100644
--- a/tests/qapi-schema/alternate-any.err
+++ b/tests/qapi-schema/alternate-any.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/alternate-any.json: In alternate 'Alt':
-tests/qapi-schema/alternate-any.json:2: Alternate 'Alt' member 'one' can=
not use type 'any'
+tests/qapi-schema/alternate-any.json:2: alternate 'Alt' member 'one' can=
not use type 'any'
diff --git a/tests/qapi-schema/alternate-array.err b/tests/qapi-schema/al=
ternate-array.err
index f16f266c76..a72e4b274d 100644
--- a/tests/qapi-schema/alternate-array.err
+++ b/tests/qapi-schema/alternate-array.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/alternate-array.json: In alternate 'Alt':
-tests/qapi-schema/alternate-array.json:5: Member 'two' of alternate 'Alt=
' cannot be an array
+tests/qapi-schema/alternate-array.json:5: member 'two' of alternate 'Alt=
' cannot be an array
diff --git a/tests/qapi-schema/alternate-base.err b/tests/qapi-schema/alt=
ernate-base.err
index ebe05bc898..4c9158db02 100644
--- a/tests/qapi-schema/alternate-base.err
+++ b/tests/qapi-schema/alternate-base.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/alternate-base.json:4: Unknown key 'base' in alternate=
 'Alt'
+tests/qapi-schema/alternate-base.json:4: unknown key 'base' in alternate=
 'Alt'
 Valid keys are 'alternate', 'data', 'if'.
diff --git a/tests/qapi-schema/alternate-conflict-bool-string.err b/tests=
/qapi-schema/alternate-conflict-bool-string.err
index edfd36b7ad..e2b89f3cac 100644
--- a/tests/qapi-schema/alternate-conflict-bool-string.err
+++ b/tests/qapi-schema/alternate-conflict-bool-string.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/alternate-conflict-bool-string.json: In alternate 'Alt=
':
-tests/qapi-schema/alternate-conflict-bool-string.json:2: Alternate 'Alt'=
 member 'two' can't be distinguished from member 'one'
+tests/qapi-schema/alternate-conflict-bool-string.json:2: alternate 'Alt'=
 member 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-conflict-dict.err b/tests/qapi-s=
chema/alternate-conflict-dict.err
index 61ae93273a..e3f7d9072d 100644
--- a/tests/qapi-schema/alternate-conflict-dict.err
+++ b/tests/qapi-schema/alternate-conflict-dict.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/alternate-conflict-dict.json: In alternate 'Alt':
-tests/qapi-schema/alternate-conflict-dict.json:6: Alternate 'Alt' member=
 'two' can't be distinguished from member 'one'
+tests/qapi-schema/alternate-conflict-dict.json:6: alternate 'Alt' member=
 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-conflict-enum-bool.err b/tests/q=
api-schema/alternate-conflict-enum-bool.err
index b006d1efbc..d0fe1433fc 100644
--- a/tests/qapi-schema/alternate-conflict-enum-bool.err
+++ b/tests/qapi-schema/alternate-conflict-enum-bool.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/alternate-conflict-enum-bool.json: In alternate 'Alt':
-tests/qapi-schema/alternate-conflict-enum-bool.json:4: Alternate 'Alt' m=
ember 'two' can't be distinguished from member 'one'
+tests/qapi-schema/alternate-conflict-enum-bool.json:4: alternate 'Alt' m=
ember 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-conflict-enum-int.err b/tests/qa=
pi-schema/alternate-conflict-enum-int.err
index 817b5c0191..866428b1d1 100644
--- a/tests/qapi-schema/alternate-conflict-enum-int.err
+++ b/tests/qapi-schema/alternate-conflict-enum-int.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/alternate-conflict-enum-int.json: In alternate 'Alt':
-tests/qapi-schema/alternate-conflict-enum-int.json:4: Alternate 'Alt' me=
mber 'two' can't be distinguished from member 'one'
+tests/qapi-schema/alternate-conflict-enum-int.json:4: alternate 'Alt' me=
mber 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-conflict-num-string.err b/tests/=
qapi-schema/alternate-conflict-num-string.err
index abc188e0a6..d00975453e 100644
--- a/tests/qapi-schema/alternate-conflict-num-string.err
+++ b/tests/qapi-schema/alternate-conflict-num-string.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/alternate-conflict-num-string.json: In alternate 'Alt'=
:
-tests/qapi-schema/alternate-conflict-num-string.json:2: Alternate 'Alt' =
member 'two' can't be distinguished from member 'one'
+tests/qapi-schema/alternate-conflict-num-string.json:2: alternate 'Alt' =
member 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-conflict-string.err b/tests/qapi=
-schema/alternate-conflict-string.err
index 77ccd80cd7..0231f4fed1 100644
--- a/tests/qapi-schema/alternate-conflict-string.err
+++ b/tests/qapi-schema/alternate-conflict-string.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/alternate-conflict-string.json: In alternate 'Alt':
-tests/qapi-schema/alternate-conflict-string.json:2: Alternate 'Alt' memb=
er 'two' can't be distinguished from member 'one'
+tests/qapi-schema/alternate-conflict-string.json:2: alternate 'Alt' memb=
er 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-empty.err b/tests/qapi-schema/al=
ternate-empty.err
index 9daac031e4..db92d70f10 100644
--- a/tests/qapi-schema/alternate-empty.err
+++ b/tests/qapi-schema/alternate-empty.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/alternate-empty.json: In alternate 'Alt':
-tests/qapi-schema/alternate-empty.json:2: Alternate 'Alt' cannot have em=
pty 'data'
+tests/qapi-schema/alternate-empty.json:2: alternate 'Alt' cannot have em=
pty 'data'
diff --git a/tests/qapi-schema/alternate-invalid-dict.err b/tests/qapi-sc=
hema/alternate-invalid-dict.err
index 701db8cdce..f85b941750 100644
--- a/tests/qapi-schema/alternate-invalid-dict.err
+++ b/tests/qapi-schema/alternate-invalid-dict.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/alternate-invalid-dict.json: In alternate 'Alt':
-tests/qapi-schema/alternate-invalid-dict.json:2: Key 'type' is missing f=
rom member 'two' of alternate 'Alt'
+tests/qapi-schema/alternate-invalid-dict.json:2: key 'type' is missing f=
rom member 'two' of alternate 'Alt'
diff --git a/tests/qapi-schema/alternate-nested.err b/tests/qapi-schema/a=
lternate-nested.err
index 4ab5328025..03fb9fb212 100644
--- a/tests/qapi-schema/alternate-nested.err
+++ b/tests/qapi-schema/alternate-nested.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/alternate-nested.json: In alternate 'Alt2':
-tests/qapi-schema/alternate-nested.json:4: Member 'nested' of alternate =
'Alt2' cannot use alternate type 'Alt1'
+tests/qapi-schema/alternate-nested.json:4: member 'nested' of alternate =
'Alt2' cannot use alternate type 'Alt1'
diff --git a/tests/qapi-schema/alternate-unknown.err b/tests/qapi-schema/=
alternate-unknown.err
index 5bd473325e..7a533b2b74 100644
--- a/tests/qapi-schema/alternate-unknown.err
+++ b/tests/qapi-schema/alternate-unknown.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/alternate-unknown.json: In alternate 'Alt':
-tests/qapi-schema/alternate-unknown.json:2: Member 'unknown' of alternat=
e 'Alt' uses unknown type 'MissingType'
+tests/qapi-schema/alternate-unknown.json:2: member 'unknown' of alternat=
e 'Alt' uses unknown type 'MissingType'
diff --git a/tests/qapi-schema/args-array-empty.err b/tests/qapi-schema/a=
rgs-array-empty.err
index fb95f0c4de..fe1480671b 100644
--- a/tests/qapi-schema/args-array-empty.err
+++ b/tests/qapi-schema/args-array-empty.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/args-array-empty.json: In command 'oops':
-tests/qapi-schema/args-array-empty.json:2: Member 'empty' of 'data' for =
command 'oops': array type must contain single type name
+tests/qapi-schema/args-array-empty.json:2: member 'empty' of 'data' for =
command 'oops': array type must contain single type name
diff --git a/tests/qapi-schema/args-array-unknown.err b/tests/qapi-schema=
/args-array-unknown.err
index c88a5612b2..57b0d8972e 100644
--- a/tests/qapi-schema/args-array-unknown.err
+++ b/tests/qapi-schema/args-array-unknown.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/args-array-unknown.json: In command 'oops':
-tests/qapi-schema/args-array-unknown.json:2: Member 'array' of 'data' fo=
r command 'oops' uses unknown type 'NoSuchType'
+tests/qapi-schema/args-array-unknown.json:2: member 'array' of 'data' fo=
r command 'oops' uses unknown type 'NoSuchType'
diff --git a/tests/qapi-schema/args-member-array-bad.err b/tests/qapi-sch=
ema/args-member-array-bad.err
index 81e1e95523..89b8b1ce01 100644
--- a/tests/qapi-schema/args-member-array-bad.err
+++ b/tests/qapi-schema/args-member-array-bad.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/args-member-array-bad.json: In command 'oops':
-tests/qapi-schema/args-member-array-bad.json:2: Member 'member' of 'data=
' for command 'oops': array type must contain single type name
+tests/qapi-schema/args-member-array-bad.json:2: member 'member' of 'data=
' for command 'oops': array type must contain single type name
diff --git a/tests/qapi-schema/args-member-case.err b/tests/qapi-schema/a=
rgs-member-case.err
index da183957b2..faa8168d36 100644
--- a/tests/qapi-schema/args-member-case.err
+++ b/tests/qapi-schema/args-member-case.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/args-member-case.json: In command 'no-way-this-will-ge=
t-whitelisted':
-tests/qapi-schema/args-member-case.json:2: Member of 'data' for command =
'no-way-this-will-get-whitelisted' uses uppercase in name 'Arg'
+tests/qapi-schema/args-member-case.json:2: member of 'data' for command =
'no-way-this-will-get-whitelisted' uses uppercase in name 'Arg'
diff --git a/tests/qapi-schema/args-member-unknown.err b/tests/qapi-schem=
a/args-member-unknown.err
index 9d43e54ca9..168e24a4b8 100644
--- a/tests/qapi-schema/args-member-unknown.err
+++ b/tests/qapi-schema/args-member-unknown.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/args-member-unknown.json: In command 'oops':
-tests/qapi-schema/args-member-unknown.json:2: Member 'member' of 'data' =
for command 'oops' uses unknown type 'NoSuchType'
+tests/qapi-schema/args-member-unknown.json:2: member 'member' of 'data' =
for command 'oops' uses unknown type 'NoSuchType'
diff --git a/tests/qapi-schema/bad-type-int.err b/tests/qapi-schema/bad-t=
ype-int.err
index 9b2c12c1eb..7f5916ea29 100644
--- a/tests/qapi-schema/bad-type-int.err
+++ b/tests/qapi-schema/bad-type-int.err
@@ -1 +1 @@
-tests/qapi-schema/bad-type-int.json:3:13: Stray '123'
+tests/qapi-schema/bad-type-int.json:3:13: stray '123'
diff --git a/tests/qapi-schema/base-cycle-direct.err b/tests/qapi-schema/=
base-cycle-direct.err
index 52c21bc2b8..233e4b8952 100644
--- a/tests/qapi-schema/base-cycle-direct.err
+++ b/tests/qapi-schema/base-cycle-direct.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/base-cycle-direct.json: In struct 'Loopy':
-tests/qapi-schema/base-cycle-direct.json:2: Object Loopy contains itself
+tests/qapi-schema/base-cycle-direct.json:2: object Loopy contains itself
diff --git a/tests/qapi-schema/base-cycle-indirect.err b/tests/qapi-schem=
a/base-cycle-indirect.err
index 1f60cd78f6..4472f30ba1 100644
--- a/tests/qapi-schema/base-cycle-indirect.err
+++ b/tests/qapi-schema/base-cycle-indirect.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/base-cycle-indirect.json: In struct 'Base1':
-tests/qapi-schema/base-cycle-indirect.json:2: Object Base1 contains itse=
lf
+tests/qapi-schema/base-cycle-indirect.json:2: object Base1 contains itse=
lf
diff --git a/tests/qapi-schema/doc-bad-alternate-member.err b/tests/qapi-=
schema/doc-bad-alternate-member.err
index 387f7824da..19a1ffd76e 100644
--- a/tests/qapi-schema/doc-bad-alternate-member.err
+++ b/tests/qapi-schema/doc-bad-alternate-member.err
@@ -1 +1 @@
-tests/qapi-schema/doc-bad-alternate-member.json:3: The following documen=
ted members are not in the declaration: aa, bb
+tests/qapi-schema/doc-bad-alternate-member.json:3: the following documen=
ted members are not in the declaration: aa, bb
diff --git a/tests/qapi-schema/doc-bad-command-arg.err b/tests/qapi-schem=
a/doc-bad-command-arg.err
index 8075b146ae..6962ebed69 100644
--- a/tests/qapi-schema/doc-bad-command-arg.err
+++ b/tests/qapi-schema/doc-bad-command-arg.err
@@ -1 +1 @@
-tests/qapi-schema/doc-bad-command-arg.json:3: The following documented m=
embers are not in the declaration: b
+tests/qapi-schema/doc-bad-command-arg.json:3: the following documented m=
embers are not in the declaration: b
diff --git a/tests/qapi-schema/doc-bad-symbol.err b/tests/qapi-schema/doc=
-bad-symbol.err
index 375cdff939..205d0ed619 100644
--- a/tests/qapi-schema/doc-bad-symbol.err
+++ b/tests/qapi-schema/doc-bad-symbol.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/doc-bad-symbol.json: In command 'foo':
-tests/qapi-schema/doc-bad-symbol.json:6: Definition of 'foo' follows doc=
umentation for 'food'
+tests/qapi-schema/doc-bad-symbol.json:6: definition of 'foo' follows doc=
umentation for 'food'
diff --git a/tests/qapi-schema/doc-bad-union-member.err b/tests/qapi-sche=
ma/doc-bad-union-member.err
index 4b016df7ff..da3cd806e3 100644
--- a/tests/qapi-schema/doc-bad-union-member.err
+++ b/tests/qapi-schema/doc-bad-union-member.err
@@ -1 +1 @@
-tests/qapi-schema/doc-bad-union-member.json:3: The following documented =
members are not in the declaration: a, b
+tests/qapi-schema/doc-bad-union-member.json:3: the following documented =
members are not in the declaration: a, b
diff --git a/tests/qapi-schema/doc-before-include.err b/tests/qapi-schema=
/doc-before-include.err
index a649d38a63..e5566f11e9 100644
--- a/tests/qapi-schema/doc-before-include.err
+++ b/tests/qapi-schema/doc-before-include.err
@@ -1 +1 @@
-tests/qapi-schema/doc-before-include.json:3: Documentation for 'foo' is =
not followed by the definition
+tests/qapi-schema/doc-before-include.json:3: documentation for 'foo' is =
not followed by the definition
diff --git a/tests/qapi-schema/doc-before-pragma.err b/tests/qapi-schema/=
doc-before-pragma.err
index c0fb0660d1..8a97ebb578 100644
--- a/tests/qapi-schema/doc-before-pragma.err
+++ b/tests/qapi-schema/doc-before-pragma.err
@@ -1 +1 @@
-tests/qapi-schema/doc-before-pragma.json:3: Documentation for 'foo' is n=
ot followed by the definition
+tests/qapi-schema/doc-before-pragma.json:3: documentation for 'foo' is n=
ot followed by the definition
diff --git a/tests/qapi-schema/doc-duplicated-return.err b/tests/qapi-sch=
ema/doc-duplicated-return.err
index e48039f8e5..7631933093 100644
--- a/tests/qapi-schema/doc-duplicated-return.err
+++ b/tests/qapi-schema/doc-duplicated-return.err
@@ -1 +1 @@
-tests/qapi-schema/doc-duplicated-return.json:7:1: Duplicated 'Returns' s=
ection
+tests/qapi-schema/doc-duplicated-return.json:7:1: duplicated 'Returns' s=
ection
diff --git a/tests/qapi-schema/doc-duplicated-since.err b/tests/qapi-sche=
ma/doc-duplicated-since.err
index 3fb890744a..5ee15ae2a1 100644
--- a/tests/qapi-schema/doc-duplicated-since.err
+++ b/tests/qapi-schema/doc-duplicated-since.err
@@ -1 +1 @@
-tests/qapi-schema/doc-duplicated-since.json:7:1: Duplicated 'Since' sect=
ion
+tests/qapi-schema/doc-duplicated-since.json:7:1: duplicated 'Since' sect=
ion
diff --git a/tests/qapi-schema/doc-empty-arg.err b/tests/qapi-schema/doc-=
empty-arg.err
index 2895518fa7..3c78a37ae1 100644
--- a/tests/qapi-schema/doc-empty-arg.err
+++ b/tests/qapi-schema/doc-empty-arg.err
@@ -1 +1 @@
-tests/qapi-schema/doc-empty-arg.json:5:1: Invalid parameter name
+tests/qapi-schema/doc-empty-arg.json:5:1: invalid parameter name
diff --git a/tests/qapi-schema/doc-empty-section.err b/tests/qapi-schema/=
doc-empty-section.err
index b61e4a7886..f6586c566f 100644
--- a/tests/qapi-schema/doc-empty-section.err
+++ b/tests/qapi-schema/doc-empty-section.err
@@ -1 +1 @@
-tests/qapi-schema/doc-empty-section.json:7:1: Empty doc section 'Note'
+tests/qapi-schema/doc-empty-section.json:7:1: empty doc section 'Note'
diff --git a/tests/qapi-schema/doc-empty-symbol.err b/tests/qapi-schema/d=
oc-empty-symbol.err
index 1936ad094f..2dcddca7f6 100644
--- a/tests/qapi-schema/doc-empty-symbol.err
+++ b/tests/qapi-schema/doc-empty-symbol.err
@@ -1 +1 @@
-tests/qapi-schema/doc-empty-symbol.json:4:1: Invalid name
+tests/qapi-schema/doc-empty-symbol.json:4:1: invalid name
diff --git a/tests/qapi-schema/doc-invalid-end.err b/tests/qapi-schema/do=
c-invalid-end.err
index 2bda28cb54..6345aa6a0f 100644
--- a/tests/qapi-schema/doc-invalid-end.err
+++ b/tests/qapi-schema/doc-invalid-end.err
@@ -1 +1 @@
-tests/qapi-schema/doc-invalid-end.json:5:2: Documentation comment must e=
nd with '##'
+tests/qapi-schema/doc-invalid-end.json:5:2: documentation comment must e=
nd with '##'
diff --git a/tests/qapi-schema/doc-invalid-end2.err b/tests/qapi-schema/d=
oc-invalid-end2.err
index 6fad9c789e..13ead36fd2 100644
--- a/tests/qapi-schema/doc-invalid-end2.err
+++ b/tests/qapi-schema/doc-invalid-end2.err
@@ -1 +1 @@
-tests/qapi-schema/doc-invalid-end2.json:5:1: Junk after '##' at end of d=
ocumentation comment
+tests/qapi-schema/doc-invalid-end2.json:5:1: junk after '##' at end of d=
ocumentation comment
diff --git a/tests/qapi-schema/doc-invalid-start.err b/tests/qapi-schema/=
doc-invalid-start.err
index 149af2bfac..dcaa9699d6 100644
--- a/tests/qapi-schema/doc-invalid-start.err
+++ b/tests/qapi-schema/doc-invalid-start.err
@@ -1 +1 @@
-tests/qapi-schema/doc-invalid-start.json:3:1: Junk after '##' at start o=
f documentation comment
+tests/qapi-schema/doc-invalid-start.json:3:1: junk after '##' at start o=
f documentation comment
diff --git a/tests/qapi-schema/doc-missing-colon.err b/tests/qapi-schema/=
doc-missing-colon.err
index b41d5078b0..6fb5a380bd 100644
--- a/tests/qapi-schema/doc-missing-colon.err
+++ b/tests/qapi-schema/doc-missing-colon.err
@@ -1 +1 @@
-tests/qapi-schema/doc-missing-colon.json:4:1: Line should end with ':'
+tests/qapi-schema/doc-missing-colon.json:4:1: line should end with ':'
diff --git a/tests/qapi-schema/doc-missing-expr.err b/tests/qapi-schema/d=
oc-missing-expr.err
index c909e26eca..622a37cc6c 100644
--- a/tests/qapi-schema/doc-missing-expr.err
+++ b/tests/qapi-schema/doc-missing-expr.err
@@ -1 +1 @@
-tests/qapi-schema/doc-missing-expr.json:3: Documentation for 'bar' is no=
t followed by the definition
+tests/qapi-schema/doc-missing-expr.json:3: documentation for 'bar' is no=
t followed by the definition
diff --git a/tests/qapi-schema/doc-missing-space.err b/tests/qapi-schema/=
doc-missing-space.err
index d6b46ffd77..1187ba12c4 100644
--- a/tests/qapi-schema/doc-missing-space.err
+++ b/tests/qapi-schema/doc-missing-space.err
@@ -1 +1 @@
-tests/qapi-schema/doc-missing-space.json:5:1: Missing space after #
+tests/qapi-schema/doc-missing-space.json:5:1: missing space after #
diff --git a/tests/qapi-schema/doc-missing.err b/tests/qapi-schema/doc-mi=
ssing.err
index 3a377ddc57..08c827931a 100644
--- a/tests/qapi-schema/doc-missing.err
+++ b/tests/qapi-schema/doc-missing.err
@@ -1 +1 @@
-tests/qapi-schema/doc-missing.json:5: Definition missing documentation c=
omment
+tests/qapi-schema/doc-missing.json:5: definition missing documentation c=
omment
diff --git a/tests/qapi-schema/doc-no-symbol.err b/tests/qapi-schema/doc-=
no-symbol.err
index 212984ff20..9a3057730c 100644
--- a/tests/qapi-schema/doc-no-symbol.err
+++ b/tests/qapi-schema/doc-no-symbol.err
@@ -1 +1 @@
-tests/qapi-schema/doc-no-symbol.json:3: Definition documentation require=
d
+tests/qapi-schema/doc-no-symbol.json:3: definition documentation require=
d
diff --git a/tests/qapi-schema/double-type.err b/tests/qapi-schema/double=
-type.err
index 69457173a7..44a9dfdd55 100644
--- a/tests/qapi-schema/double-type.err
+++ b/tests/qapi-schema/double-type.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/double-type.json:2: Unknown key 'command' in struct 'b=
ar'
+tests/qapi-schema/double-type.json:2: unknown key 'command' in struct 'b=
ar'
 Valid keys are 'base', 'data', 'features', 'if', 'struct'.
diff --git a/tests/qapi-schema/duplicate-key.err b/tests/qapi-schema/dupl=
icate-key.err
index 3af2f55174..7f34a34eb6 100644
--- a/tests/qapi-schema/duplicate-key.err
+++ b/tests/qapi-schema/duplicate-key.err
@@ -1 +1 @@
-tests/qapi-schema/duplicate-key.json:3:10: Duplicate key 'key'
+tests/qapi-schema/duplicate-key.json:3:10: duplicate key 'key'
diff --git a/tests/qapi-schema/enum-bad-member.err b/tests/qapi-schema/en=
um-bad-member.err
index 49e4160dc4..1e59d42fca 100644
--- a/tests/qapi-schema/enum-bad-member.err
+++ b/tests/qapi-schema/enum-bad-member.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/enum-bad-member.json: In enum 'MyEnum':
-tests/qapi-schema/enum-bad-member.json:2: Member of enum 'MyEnum' requir=
es a string name
+tests/qapi-schema/enum-bad-member.json:2: member of enum 'MyEnum' requir=
es a string name
diff --git a/tests/qapi-schema/enum-bad-name.err b/tests/qapi-schema/enum=
-bad-name.err
index 3af7345792..ed2d608098 100644
--- a/tests/qapi-schema/enum-bad-name.err
+++ b/tests/qapi-schema/enum-bad-name.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/enum-bad-name.json: In enum 'MyEnum':
-tests/qapi-schema/enum-bad-name.json:3: Member of enum 'MyEnum' uses inv=
alid name 'not\possible'
+tests/qapi-schema/enum-bad-name.json:3: member of enum 'MyEnum' uses inv=
alid name 'not\possible'
diff --git a/tests/qapi-schema/enum-bad-prefix.err b/tests/qapi-schema/en=
um-bad-prefix.err
index 383ebaea7e..4f92736e52 100644
--- a/tests/qapi-schema/enum-bad-prefix.err
+++ b/tests/qapi-schema/enum-bad-prefix.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/enum-bad-prefix.json: In enum 'MyEnum':
-tests/qapi-schema/enum-bad-prefix.json:2: Enum 'MyEnum' requires a strin=
g for 'prefix'
+tests/qapi-schema/enum-bad-prefix.json:2: enum 'MyEnum' requires a strin=
g for 'prefix'
diff --git a/tests/qapi-schema/enum-dict-member-unknown.err b/tests/qapi-=
schema/enum-dict-member-unknown.err
index 02952f472a..79062729a1 100644
--- a/tests/qapi-schema/enum-dict-member-unknown.err
+++ b/tests/qapi-schema/enum-dict-member-unknown.err
@@ -1,3 +1,3 @@
 tests/qapi-schema/enum-dict-member-unknown.json: In enum 'MyEnum':
-tests/qapi-schema/enum-dict-member-unknown.json:2: Unknown key 'bad-key'=
 in member of enum 'MyEnum'
+tests/qapi-schema/enum-dict-member-unknown.json:2: unknown key 'bad-key'=
 in member of enum 'MyEnum'
 Valid keys are 'if', 'name'.
diff --git a/tests/qapi-schema/enum-int-member.err b/tests/qapi-schema/en=
um-int-member.err
index 3f8d7b5b71..27f06e334c 100644
--- a/tests/qapi-schema/enum-int-member.err
+++ b/tests/qapi-schema/enum-int-member.err
@@ -1 +1 @@
-tests/qapi-schema/enum-int-member.json:3:31: Stray '1'
+tests/qapi-schema/enum-int-member.json:3:31: stray '1'
diff --git a/tests/qapi-schema/enum-member-case.err b/tests/qapi-schema/e=
num-member-case.err
index 8f2007c86f..c3c6f8d709 100644
--- a/tests/qapi-schema/enum-member-case.err
+++ b/tests/qapi-schema/enum-member-case.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/enum-member-case.json: In enum 'NoWayThisWillGetWhitel=
isted':
-tests/qapi-schema/enum-member-case.json:4: Member of enum 'NoWayThisWill=
GetWhitelisted' uses uppercase in name 'Value'
+tests/qapi-schema/enum-member-case.json:4: member of enum 'NoWayThisWill=
GetWhitelisted' uses uppercase in name 'Value'
diff --git a/tests/qapi-schema/enum-missing-data.err b/tests/qapi-schema/=
enum-missing-data.err
index ba4873ae69..3c3c52d037 100644
--- a/tests/qapi-schema/enum-missing-data.err
+++ b/tests/qapi-schema/enum-missing-data.err
@@ -1 +1 @@
-tests/qapi-schema/enum-missing-data.json:2: Key 'data' is missing from e=
num 'MyEnum'
+tests/qapi-schema/enum-missing-data.json:2: key 'data' is missing from e=
num 'MyEnum'
diff --git a/tests/qapi-schema/enum-wrong-data.err b/tests/qapi-schema/en=
um-wrong-data.err
index 4ab0c44e48..ab9af5e995 100644
--- a/tests/qapi-schema/enum-wrong-data.err
+++ b/tests/qapi-schema/enum-wrong-data.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/enum-wrong-data.json: In enum 'MyEnum':
-tests/qapi-schema/enum-wrong-data.json:2: Enum 'MyEnum' requires an arra=
y for 'data'
+tests/qapi-schema/enum-wrong-data.json:2: enum 'MyEnum' requires an arra=
y for 'data'
diff --git a/tests/qapi-schema/escape-outside-string.err b/tests/qapi-sch=
ema/escape-outside-string.err
index efee335ba0..06f5f2ed55 100644
--- a/tests/qapi-schema/escape-outside-string.err
+++ b/tests/qapi-schema/escape-outside-string.err
@@ -1 +1 @@
-tests/qapi-schema/escape-outside-string.json:3:27: Stray '\'
+tests/qapi-schema/escape-outside-string.json:3:27: stray '\'
diff --git a/tests/qapi-schema/escape-too-big.err b/tests/qapi-schema/esc=
ape-too-big.err
new file mode 100644
index 0000000000..c34002b1e5
--- /dev/null
+++ b/tests/qapi-schema/escape-too-big.err
@@ -0,0 +1 @@
+tests/qapi-schema/escape-too-big.json:3:14: for now, \u escape only supp=
orts non-zero values up to \u007f
diff --git a/tests/qapi-schema/event-boxed-empty.err b/tests/qapi-schema/=
event-boxed-empty.err
index 6ccbdf7b22..9c691b7d97 100644
--- a/tests/qapi-schema/event-boxed-empty.err
+++ b/tests/qapi-schema/event-boxed-empty.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/event-boxed-empty.json: In event 'FOO':
-tests/qapi-schema/event-boxed-empty.json:2: Use of 'boxed' requires 'dat=
a'
+tests/qapi-schema/event-boxed-empty.json:2: use of 'boxed' requires 'dat=
a'
diff --git a/tests/qapi-schema/event-member-invalid-dict.err b/tests/qapi=
-schema/event-member-invalid-dict.err
index 9981a48b81..8bf89b7a3a 100644
--- a/tests/qapi-schema/event-member-invalid-dict.err
+++ b/tests/qapi-schema/event-member-invalid-dict.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/event-member-invalid-dict.json: In event 'EVENT_A':
-tests/qapi-schema/event-member-invalid-dict.json:1: Key 'type' is missin=
g from member 'a' of 'data' for event 'EVENT_A'
+tests/qapi-schema/event-member-invalid-dict.json:1: key 'type' is missin=
g from member 'a' of 'data' for event 'EVENT_A'
diff --git a/tests/qapi-schema/event-nest-struct.err b/tests/qapi-schema/=
event-nest-struct.err
index 2dd57f1784..8900052e83 100644
--- a/tests/qapi-schema/event-nest-struct.err
+++ b/tests/qapi-schema/event-nest-struct.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/event-nest-struct.json: In event 'EVENT_A':
-tests/qapi-schema/event-nest-struct.json:1: Member 'a' of 'data' for eve=
nt 'EVENT_A' should be a type name
+tests/qapi-schema/event-nest-struct.json:1: member 'a' of 'data' for eve=
nt 'EVENT_A' should be a type name
diff --git a/tests/qapi-schema/features-bad-type.err b/tests/qapi-schema/=
features-bad-type.err
index a08485387a..2182c3ec75 100644
--- a/tests/qapi-schema/features-bad-type.err
+++ b/tests/qapi-schema/features-bad-type.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/features-bad-type.json: In struct 'FeatureStruct0':
-tests/qapi-schema/features-bad-type.json:1: Feature of struct FeatureStr=
uct0 requires a string name
+tests/qapi-schema/features-bad-type.json:1: feature of struct FeatureStr=
uct0 requires a string name
diff --git a/tests/qapi-schema/features-missing-name.err b/tests/qapi-sch=
ema/features-missing-name.err
index d445936b0c..8cbf1ef3f0 100644
--- a/tests/qapi-schema/features-missing-name.err
+++ b/tests/qapi-schema/features-missing-name.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/features-missing-name.json: In struct 'FeatureStruct0'=
:
-tests/qapi-schema/features-missing-name.json:1: Key 'name' is missing fr=
om feature of struct FeatureStruct0
+tests/qapi-schema/features-missing-name.json:1: key 'name' is missing fr=
om feature of struct FeatureStruct0
diff --git a/tests/qapi-schema/features-name-bad-type.err b/tests/qapi-sc=
hema/features-name-bad-type.err
index cc4bd33e7f..19a7b61214 100644
--- a/tests/qapi-schema/features-name-bad-type.err
+++ b/tests/qapi-schema/features-name-bad-type.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/features-name-bad-type.json: In struct 'FeatureStruct0=
':
-tests/qapi-schema/features-name-bad-type.json:1: Feature of struct Featu=
reStruct0 requires a string name
+tests/qapi-schema/features-name-bad-type.json:1: feature of struct Featu=
reStruct0 requires a string name
diff --git a/tests/qapi-schema/features-no-list.err b/tests/qapi-schema/f=
eatures-no-list.err
index 663d9cd158..28f91824bd 100644
--- a/tests/qapi-schema/features-no-list.err
+++ b/tests/qapi-schema/features-no-list.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/features-no-list.json: In struct 'FeatureStruct0':
-tests/qapi-schema/features-no-list.json:1: Struct 'FeatureStruct0' requi=
res an array for 'features'
+tests/qapi-schema/features-no-list.json:1: struct 'FeatureStruct0' requi=
res an array for 'features'
diff --git a/tests/qapi-schema/features-unknown-key.err b/tests/qapi-sche=
ma/features-unknown-key.err
index 2aeca4c1a6..78e63c8cf7 100644
--- a/tests/qapi-schema/features-unknown-key.err
+++ b/tests/qapi-schema/features-unknown-key.err
@@ -1,3 +1,3 @@
 tests/qapi-schema/features-unknown-key.json: In struct 'FeatureStruct0':
-tests/qapi-schema/features-unknown-key.json:1: Unknown key 'colour' in f=
eature of struct FeatureStruct0
+tests/qapi-schema/features-unknown-key.json:1: unknown key 'colour' in f=
eature of struct FeatureStruct0
 Valid keys are 'if', 'name'.
diff --git a/tests/qapi-schema/flat-union-array-branch.err b/tests/qapi-s=
chema/flat-union-array-branch.err
index 13b4e60658..323d79737c 100644
--- a/tests/qapi-schema/flat-union-array-branch.err
+++ b/tests/qapi-schema/flat-union-array-branch.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-array-branch.json: In union 'TestUnion':
-tests/qapi-schema/flat-union-array-branch.json:8: Member 'value1' of uni=
on 'TestUnion' cannot be an array
+tests/qapi-schema/flat-union-array-branch.json:8: member 'value1' of uni=
on 'TestUnion' cannot be an array
diff --git a/tests/qapi-schema/flat-union-bad-discriminator.err b/tests/q=
api-schema/flat-union-bad-discriminator.err
index 9b3746343f..27a6c9f3fb 100644
--- a/tests/qapi-schema/flat-union-bad-discriminator.err
+++ b/tests/qapi-schema/flat-union-bad-discriminator.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-bad-discriminator.json: In union 'TestUnion=
':
-tests/qapi-schema/flat-union-bad-discriminator.json:11: Discriminator of=
 flat union 'TestUnion' requires a string name
+tests/qapi-schema/flat-union-bad-discriminator.json:11: discriminator of=
 flat union 'TestUnion' requires a string name
diff --git a/tests/qapi-schema/flat-union-discriminator-bad-name.err b/te=
sts/qapi-schema/flat-union-discriminator-bad-name.err
index 72dc328bad..f7f64c5c1a 100644
--- a/tests/qapi-schema/flat-union-discriminator-bad-name.err
+++ b/tests/qapi-schema/flat-union-discriminator-bad-name.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-discriminator-bad-name.json: In union 'MyUn=
ion':
-tests/qapi-schema/flat-union-discriminator-bad-name.json:7: Discriminato=
r of flat union 'MyUnion' does not allow optional name '*switch'
+tests/qapi-schema/flat-union-discriminator-bad-name.json:7: discriminato=
r of flat union 'MyUnion' does not allow optional name '*switch'
diff --git a/tests/qapi-schema/flat-union-empty.err b/tests/qapi-schema/f=
lat-union-empty.err
index 3fa79a6a47..96fe46b918 100644
--- a/tests/qapi-schema/flat-union-empty.err
+++ b/tests/qapi-schema/flat-union-empty.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-empty.json: In union 'Union':
-tests/qapi-schema/flat-union-empty.json:4: Union 'Union' has no branches
+tests/qapi-schema/flat-union-empty.json:4: union 'Union' has no branches
diff --git a/tests/qapi-schema/flat-union-inline-invalid-dict.err b/tests=
/qapi-schema/flat-union-inline-invalid-dict.err
index 3716c02a9b..85739c2733 100644
--- a/tests/qapi-schema/flat-union-inline-invalid-dict.err
+++ b/tests/qapi-schema/flat-union-inline-invalid-dict.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-inline-invalid-dict.json: In union 'TestUni=
on':
-tests/qapi-schema/flat-union-inline-invalid-dict.json:7: Key 'type' is m=
issing from member 'value1' of union 'TestUnion'
+tests/qapi-schema/flat-union-inline-invalid-dict.json:7: key 'type' is m=
issing from member 'value1' of union 'TestUnion'
diff --git a/tests/qapi-schema/flat-union-inline.err b/tests/qapi-schema/=
flat-union-inline.err
index 0a7a94b03f..33a8d6e3bd 100644
--- a/tests/qapi-schema/flat-union-inline.err
+++ b/tests/qapi-schema/flat-union-inline.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-inline.json: In union 'TestUnion':
-tests/qapi-schema/flat-union-inline.json:7: Member 'value1' of union 'Te=
stUnion' should be a type name
+tests/qapi-schema/flat-union-inline.json:7: member 'value1' of union 'Te=
stUnion' should be a type name
diff --git a/tests/qapi-schema/flat-union-int-branch.err b/tests/qapi-sch=
ema/flat-union-int-branch.err
index 075751bcf6..2bbb8bf22e 100644
--- a/tests/qapi-schema/flat-union-int-branch.err
+++ b/tests/qapi-schema/flat-union-int-branch.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-int-branch.json: In union 'TestUnion':
-tests/qapi-schema/flat-union-int-branch.json:8: Member 'value1' of union=
 'TestUnion' cannot use built-in type 'int'
+tests/qapi-schema/flat-union-int-branch.json:8: member 'value1' of union=
 'TestUnion' cannot use built-in type 'int'
diff --git a/tests/qapi-schema/flat-union-invalid-branch-key.err b/tests/=
qapi-schema/flat-union-invalid-branch-key.err
index a4d0e3ee66..da4377be69 100644
--- a/tests/qapi-schema/flat-union-invalid-branch-key.err
+++ b/tests/qapi-schema/flat-union-invalid-branch-key.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-invalid-branch-key.json: In union 'TestUnio=
n':
-tests/qapi-schema/flat-union-invalid-branch-key.json:13: Discriminator v=
alue 'value_wrong' is not found in enum 'TestEnum'
+tests/qapi-schema/flat-union-invalid-branch-key.json:13: discriminator v=
alue 'value_wrong' is not found in enum 'TestEnum'
diff --git a/tests/qapi-schema/flat-union-invalid-discriminator.err b/tes=
ts/qapi-schema/flat-union-invalid-discriminator.err
index ca9a413dae..3f80de3044 100644
--- a/tests/qapi-schema/flat-union-invalid-discriminator.err
+++ b/tests/qapi-schema/flat-union-invalid-discriminator.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-invalid-discriminator.json: In union 'TestU=
nion':
-tests/qapi-schema/flat-union-invalid-discriminator.json:10: Discriminato=
r 'enum_wrong' is not a member of 'base'
+tests/qapi-schema/flat-union-invalid-discriminator.json:10: discriminato=
r 'enum_wrong' is not a member of 'base'
diff --git a/tests/qapi-schema/flat-union-invalid-if-discriminator.err b/=
tests/qapi-schema/flat-union-invalid-if-discriminator.err
index c06307db98..be770d6baa 100644
--- a/tests/qapi-schema/flat-union-invalid-if-discriminator.err
+++ b/tests/qapi-schema/flat-union-invalid-if-discriminator.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-invalid-if-discriminator.json: In union 'Te=
stUnion':
-tests/qapi-schema/flat-union-invalid-if-discriminator.json:10: The discr=
iminator 'enum1' for union TestUnion must not be conditional
+tests/qapi-schema/flat-union-invalid-if-discriminator.json:10: the discr=
iminator 'enum1' for union TestUnion must not be conditional
diff --git a/tests/qapi-schema/flat-union-no-base.err b/tests/qapi-schema=
/flat-union-no-base.err
index 6e2035495c..c845259824 100644
--- a/tests/qapi-schema/flat-union-no-base.err
+++ b/tests/qapi-schema/flat-union-no-base.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-no-base.json: In union 'TestUnion':
-tests/qapi-schema/flat-union-no-base.json:9: Flat union 'TestUnion' must=
 have a base
+tests/qapi-schema/flat-union-no-base.json:9: flat union 'TestUnion' must=
 have a base
diff --git a/tests/qapi-schema/flat-union-optional-discriminator.err b/te=
sts/qapi-schema/flat-union-optional-discriminator.err
index db268fffaa..536ac775e2 100644
--- a/tests/qapi-schema/flat-union-optional-discriminator.err
+++ b/tests/qapi-schema/flat-union-optional-discriminator.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-optional-discriminator.json: In union 'MyUn=
ion':
-tests/qapi-schema/flat-union-optional-discriminator.json:7: Discriminato=
r 'switch' is not a member of 'base'
+tests/qapi-schema/flat-union-optional-discriminator.json:7: discriminato=
r 'switch' is not a member of 'base'
diff --git a/tests/qapi-schema/flat-union-string-discriminator.err b/test=
s/qapi-schema/flat-union-string-discriminator.err
index 9bca7082bb..f5635a5774 100644
--- a/tests/qapi-schema/flat-union-string-discriminator.err
+++ b/tests/qapi-schema/flat-union-string-discriminator.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/flat-union-string-discriminator.json: In union 'TestUn=
ion':
-tests/qapi-schema/flat-union-string-discriminator.json:13: Discriminator=
 'kind' must be of enumeration type
+tests/qapi-schema/flat-union-string-discriminator.json:13: discriminator=
 'kind' must be of enumeration type
diff --git a/tests/qapi-schema/funny-char.err b/tests/qapi-schema/funny-c=
har.err
index 139ecf4eb8..132fac93ea 100644
--- a/tests/qapi-schema/funny-char.err
+++ b/tests/qapi-schema/funny-char.err
@@ -1 +1 @@
-tests/qapi-schema/funny-char.json:2:36: Stray ';'
+tests/qapi-schema/funny-char.json:2:36: stray ';'
diff --git a/tests/qapi-schema/funny-word.err b/tests/qapi-schema/funny-w=
ord.err
index af92fe2551..d9286c8962 100644
--- a/tests/qapi-schema/funny-word.err
+++ b/tests/qapi-schema/funny-word.err
@@ -1 +1 @@
-tests/qapi-schema/funny-word.json:1:3: Stray 'command'
+tests/qapi-schema/funny-word.json:1:3: stray 'command'
diff --git a/tests/qapi-schema/ident-with-escape.err b/tests/qapi-schema/=
ident-with-escape.err
index 5517dcb4b1..1117283c81 100644
--- a/tests/qapi-schema/ident-with-escape.err
+++ b/tests/qapi-schema/ident-with-escape.err
@@ -1 +1 @@
-tests/qapi-schema/ident-with-escape.json:3:3: Unknown escape \u
+tests/qapi-schema/ident-with-escape.json:3:3: unknown escape \u
diff --git a/tests/qapi-schema/include-before-err.err b/tests/qapi-schema=
/include-before-err.err
index 2b26322170..098314bc49 100644
--- a/tests/qapi-schema/include-before-err.err
+++ b/tests/qapi-schema/include-before-err.err
@@ -1 +1 @@
-tests/qapi-schema/include-before-err.json:2:13: Expected ':'
+tests/qapi-schema/include-before-err.json:2:13: expected ':'
diff --git a/tests/qapi-schema/include-cycle.err b/tests/qapi-schema/incl=
ude-cycle.err
index bdcd07dce2..52028669b5 100644
--- a/tests/qapi-schema/include-cycle.err
+++ b/tests/qapi-schema/include-cycle.err
@@ -1,3 +1,3 @@
 In file included from tests/qapi-schema/include-cycle.json:1:
 In file included from tests/qapi-schema/include-cycle-b.json:1:
-tests/qapi-schema/include-cycle-c.json:1: Inclusion loop for include-cyc=
le.json
+tests/qapi-schema/include-cycle-c.json:1: inclusion loop for include-cyc=
le.json
diff --git a/tests/qapi-schema/include-extra-junk.err b/tests/qapi-schema=
/include-extra-junk.err
index e6ef2a3720..854cec3ce3 100644
--- a/tests/qapi-schema/include-extra-junk.err
+++ b/tests/qapi-schema/include-extra-junk.err
@@ -1 +1 @@
-tests/qapi-schema/include-extra-junk.json:3: Invalid 'include' directive
+tests/qapi-schema/include-extra-junk.json:3: invalid 'include' directive
diff --git a/tests/qapi-schema/include-nested-err.err b/tests/qapi-schema=
/include-nested-err.err
index aec6207eb0..11928b4f7f 100644
--- a/tests/qapi-schema/include-nested-err.err
+++ b/tests/qapi-schema/include-nested-err.err
@@ -1,2 +1,2 @@
 In file included from tests/qapi-schema/include-nested-err.json:1:
-tests/qapi-schema/missing-colon.json:1:10: Expected ':'
+tests/qapi-schema/missing-colon.json:1:10: expected ':'
diff --git a/tests/qapi-schema/include-non-file.err b/tests/qapi-schema/i=
nclude-non-file.err
index faae1eacf1..65dd3c7c2c 100644
--- a/tests/qapi-schema/include-non-file.err
+++ b/tests/qapi-schema/include-non-file.err
@@ -1 +1 @@
-tests/qapi-schema/include-non-file.json:1: Value of 'include' must be a =
string
+tests/qapi-schema/include-non-file.json:1: value of 'include' must be a =
string
diff --git a/tests/qapi-schema/include-self-cycle.err b/tests/qapi-schema=
/include-self-cycle.err
index 981742ae5f..c84795d1dc 100644
--- a/tests/qapi-schema/include-self-cycle.err
+++ b/tests/qapi-schema/include-self-cycle.err
@@ -1 +1 @@
-tests/qapi-schema/include-self-cycle.json:1: Inclusion loop for include-=
self-cycle.json
+tests/qapi-schema/include-self-cycle.json:1: inclusion loop for include-=
self-cycle.json
diff --git a/tests/qapi-schema/leading-comma-list.err b/tests/qapi-schema=
/leading-comma-list.err
index e021e42ad9..cddf471f71 100644
--- a/tests/qapi-schema/leading-comma-list.err
+++ b/tests/qapi-schema/leading-comma-list.err
@@ -1 +1 @@
-tests/qapi-schema/leading-comma-list.json:2:13: Expected '{', '[', ']', =
string, boolean or 'null'
+tests/qapi-schema/leading-comma-list.json:2:13: expected '{', '[', ']', =
string, boolean or 'null'
diff --git a/tests/qapi-schema/leading-comma-object.err b/tests/qapi-sche=
ma/leading-comma-object.err
index 3852f123d2..2f3b193274 100644
--- a/tests/qapi-schema/leading-comma-object.err
+++ b/tests/qapi-schema/leading-comma-object.err
@@ -1 +1 @@
-tests/qapi-schema/leading-comma-object.json:1:3: Expected string or '}'
+tests/qapi-schema/leading-comma-object.json:1:3: expected string or '}'
diff --git a/tests/qapi-schema/missing-colon.err b/tests/qapi-schema/miss=
ing-colon.err
index a255e51918..e642c7c549 100644
--- a/tests/qapi-schema/missing-colon.err
+++ b/tests/qapi-schema/missing-colon.err
@@ -1 +1 @@
-tests/qapi-schema/missing-colon.json:1:10: Expected ':'
+tests/qapi-schema/missing-colon.json:1:10: expected ':'
diff --git a/tests/qapi-schema/missing-comma-list.err b/tests/qapi-schema=
/missing-comma-list.err
index df3f553f39..5359499430 100644
--- a/tests/qapi-schema/missing-comma-list.err
+++ b/tests/qapi-schema/missing-comma-list.err
@@ -1 +1 @@
-tests/qapi-schema/missing-comma-list.json:2:20: Expected ',' or ']'
+tests/qapi-schema/missing-comma-list.json:2:20: expected ',' or ']'
diff --git a/tests/qapi-schema/missing-comma-object.err b/tests/qapi-sche=
ma/missing-comma-object.err
index 0f691b8ddd..c9b02b0760 100644
--- a/tests/qapi-schema/missing-comma-object.err
+++ b/tests/qapi-schema/missing-comma-object.err
@@ -1 +1 @@
-tests/qapi-schema/missing-comma-object.json:2:3: Expected ',' or '}'
+tests/qapi-schema/missing-comma-object.json:2:3: expected ',' or '}'
diff --git a/tests/qapi-schema/missing-type.err b/tests/qapi-schema/missi=
ng-type.err
index b3e7b14e42..19b7c495e7 100644
--- a/tests/qapi-schema/missing-type.err
+++ b/tests/qapi-schema/missing-type.err
@@ -1 +1 @@
-tests/qapi-schema/missing-type.json:2: Expression is missing metatype
+tests/qapi-schema/missing-type.json:2: expression is missing metatype
diff --git a/tests/qapi-schema/nested-struct-data-invalid-dict.err b/test=
s/qapi-schema/nested-struct-data-invalid-dict.err
index 4d9c9b491a..f2c7a8096c 100644
--- a/tests/qapi-schema/nested-struct-data-invalid-dict.err
+++ b/tests/qapi-schema/nested-struct-data-invalid-dict.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/nested-struct-data-invalid-dict.json: In command 'foo'=
:
-tests/qapi-schema/nested-struct-data-invalid-dict.json:2: Key 'type' is =
missing from member 'a' of 'data' for command 'foo'
+tests/qapi-schema/nested-struct-data-invalid-dict.json:2: key 'type' is =
missing from member 'a' of 'data' for command 'foo'
diff --git a/tests/qapi-schema/nested-struct-data.err b/tests/qapi-schema=
/nested-struct-data.err
index 74d44ab111..b5e136674c 100644
--- a/tests/qapi-schema/nested-struct-data.err
+++ b/tests/qapi-schema/nested-struct-data.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/nested-struct-data.json: In command 'foo':
-tests/qapi-schema/nested-struct-data.json:2: Member 'a' of 'data' for co=
mmand 'foo' should be a type name
+tests/qapi-schema/nested-struct-data.json:2: member 'a' of 'data' for co=
mmand 'foo' should be a type name
diff --git a/tests/qapi-schema/non-objects.err b/tests/qapi-schema/non-ob=
jects.err
index a972abd937..9237af6939 100644
--- a/tests/qapi-schema/non-objects.err
+++ b/tests/qapi-schema/non-objects.err
@@ -1 +1 @@
-tests/qapi-schema/non-objects.json:1:1: Expected '{'
+tests/qapi-schema/non-objects.json:1:1: expected '{'
diff --git a/tests/qapi-schema/pragma-doc-required-crap.err b/tests/qapi-=
schema/pragma-doc-required-crap.err
index 39cd56cd48..bcd981ada8 100644
--- a/tests/qapi-schema/pragma-doc-required-crap.err
+++ b/tests/qapi-schema/pragma-doc-required-crap.err
@@ -1 +1 @@
-tests/qapi-schema/pragma-doc-required-crap.json:3: Pragma 'doc-required'=
 must be boolean
+tests/qapi-schema/pragma-doc-required-crap.json:3: pragma 'doc-required'=
 must be boolean
diff --git a/tests/qapi-schema/pragma-extra-junk.err b/tests/qapi-schema/=
pragma-extra-junk.err
index 4481688dbf..3ae48d3668 100644
--- a/tests/qapi-schema/pragma-extra-junk.err
+++ b/tests/qapi-schema/pragma-extra-junk.err
@@ -1 +1 @@
-tests/qapi-schema/pragma-extra-junk.json:3: Invalid 'pragma' directive
+tests/qapi-schema/pragma-extra-junk.json:3: invalid 'pragma' directive
diff --git a/tests/qapi-schema/pragma-name-case-whitelist-crap.err b/test=
s/qapi-schema/pragma-name-case-whitelist-crap.err
index f83b97e075..81f829ff36 100644
--- a/tests/qapi-schema/pragma-name-case-whitelist-crap.err
+++ b/tests/qapi-schema/pragma-name-case-whitelist-crap.err
@@ -1 +1 @@
-tests/qapi-schema/pragma-name-case-whitelist-crap.json:3: Pragma name-ca=
se-whitelist must be a list of strings
+tests/qapi-schema/pragma-name-case-whitelist-crap.json:3: pragma name-ca=
se-whitelist must be a list of strings
diff --git a/tests/qapi-schema/pragma-non-dict.err b/tests/qapi-schema/pr=
agma-non-dict.err
index b358261050..8221724b0a 100644
--- a/tests/qapi-schema/pragma-non-dict.err
+++ b/tests/qapi-schema/pragma-non-dict.err
@@ -1 +1 @@
-tests/qapi-schema/pragma-non-dict.json:3: Value of 'pragma' must be an o=
bject
+tests/qapi-schema/pragma-non-dict.json:3: value of 'pragma' must be an o=
bject
diff --git a/tests/qapi-schema/pragma-returns-whitelist-crap.err b/tests/=
qapi-schema/pragma-returns-whitelist-crap.err
index 5d77021674..c0cae5de18 100644
--- a/tests/qapi-schema/pragma-returns-whitelist-crap.err
+++ b/tests/qapi-schema/pragma-returns-whitelist-crap.err
@@ -1 +1 @@
-tests/qapi-schema/pragma-returns-whitelist-crap.json:3: Pragma returns-w=
hitelist must be a list of strings
+tests/qapi-schema/pragma-returns-whitelist-crap.json:3: pragma returns-w=
hitelist must be a list of strings
diff --git a/tests/qapi-schema/pragma-unknown.err b/tests/qapi-schema/pra=
gma-unknown.err
index 6ef2058316..f1335f0a0a 100644
--- a/tests/qapi-schema/pragma-unknown.err
+++ b/tests/qapi-schema/pragma-unknown.err
@@ -1 +1 @@
-tests/qapi-schema/pragma-unknown.json:1: Unknown pragma 'no-such-pragma'
+tests/qapi-schema/pragma-unknown.json:1: unknown pragma 'no-such-pragma'
diff --git a/tests/qapi-schema/quoted-structural-chars.err b/tests/qapi-s=
chema/quoted-structural-chars.err
index 6e036c8044..d8460a63a7 100644
--- a/tests/qapi-schema/quoted-structural-chars.err
+++ b/tests/qapi-schema/quoted-structural-chars.err
@@ -1 +1 @@
-tests/qapi-schema/quoted-structural-chars.json:1:1: Expected '{'
+tests/qapi-schema/quoted-structural-chars.json:1:1: expected '{'
diff --git a/tests/qapi-schema/reserved-enum-q.err b/tests/qapi-schema/re=
served-enum-q.err
index e3eecd29dc..d9c0af5a05 100644
--- a/tests/qapi-schema/reserved-enum-q.err
+++ b/tests/qapi-schema/reserved-enum-q.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/reserved-enum-q.json: In enum 'Foo':
-tests/qapi-schema/reserved-enum-q.json:4: Member of enum 'Foo' uses inva=
lid name 'q-Unix'
+tests/qapi-schema/reserved-enum-q.json:4: member of enum 'Foo' uses inva=
lid name 'q-Unix'
diff --git a/tests/qapi-schema/reserved-member-has.err b/tests/qapi-schem=
a/reserved-member-has.err
index 2c6d0418db..6f405ec2a9 100644
--- a/tests/qapi-schema/reserved-member-has.err
+++ b/tests/qapi-schema/reserved-member-has.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/reserved-member-has.json: In command 'oops':
-tests/qapi-schema/reserved-member-has.json:5: Member of 'data' for comma=
nd 'oops' uses reserved name 'has-a'
+tests/qapi-schema/reserved-member-has.json:5: member of 'data' for comma=
nd 'oops' uses reserved name 'has-a'
diff --git a/tests/qapi-schema/reserved-member-q.err b/tests/qapi-schema/=
reserved-member-q.err
index eaabe579bc..ece2664005 100644
--- a/tests/qapi-schema/reserved-member-q.err
+++ b/tests/qapi-schema/reserved-member-q.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/reserved-member-q.json: In struct 'Foo':
-tests/qapi-schema/reserved-member-q.json:4: Member of 'data' for struct =
'Foo' uses invalid name 'q-unix'
+tests/qapi-schema/reserved-member-q.json:4: member of 'data' for struct =
'Foo' uses invalid name 'q-unix'
diff --git a/tests/qapi-schema/reserved-member-u.err b/tests/qapi-schema/=
reserved-member-u.err
index b01629da29..e812a1e404 100644
--- a/tests/qapi-schema/reserved-member-u.err
+++ b/tests/qapi-schema/reserved-member-u.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/reserved-member-u.json: In struct 'Oops':
-tests/qapi-schema/reserved-member-u.json:7: Member of 'data' for struct =
'Oops' uses reserved name 'u'
+tests/qapi-schema/reserved-member-u.json:7: member of 'data' for struct =
'Oops' uses reserved name 'u'
diff --git a/tests/qapi-schema/reserved-member-underscore.err b/tests/qap=
i-schema/reserved-member-underscore.err
index 6089cc1d3b..e1d54f0a27 100644
--- a/tests/qapi-schema/reserved-member-underscore.err
+++ b/tests/qapi-schema/reserved-member-underscore.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/reserved-member-underscore.json: In struct 'Oops':
-tests/qapi-schema/reserved-member-underscore.json:4: Member of 'data' fo=
r struct 'Oops' uses invalid name '_oops'
+tests/qapi-schema/reserved-member-underscore.json:4: member of 'data' fo=
r struct 'Oops' uses invalid name '_oops'
diff --git a/tests/qapi-schema/string-code-point-127.err b/tests/qapi-sch=
ema/string-code-point-127.err
index c310910c23..b4fa2610a9 100644
--- a/tests/qapi-schema/string-code-point-127.err
+++ b/tests/qapi-schema/string-code-point-127.err
@@ -1 +1 @@
-tests/qapi-schema/string-code-point-127.json:2:14: Funny character in st=
ring
+tests/qapi-schema/string-code-point-127.json:2:14: funny character in st=
ring
diff --git a/tests/qapi-schema/string-code-point-31.err b/tests/qapi-sche=
ma/string-code-point-31.err
index 45797928d9..0bb5ce37b8 100644
--- a/tests/qapi-schema/string-code-point-31.err
+++ b/tests/qapi-schema/string-code-point-31.err
@@ -1 +1 @@
-tests/qapi-schema/string-code-point-31.json:2:14: Funny character in str=
ing
+tests/qapi-schema/string-code-point-31.json:2:14: funny character in str=
ing
diff --git a/tests/qapi-schema/string-control.err b/tests/qapi-schema/str=
ing-control.err
new file mode 100644
index 0000000000..5459acf526
--- /dev/null
+++ b/tests/qapi-schema/string-control.err
@@ -0,0 +1 @@
+tests/qapi-schema/string-control.json:2:14: control character \u007f in =
string
diff --git a/tests/qapi-schema/string-unclosed.err b/tests/qapi-schema/st=
ring-unclosed.err
new file mode 100644
index 0000000000..e41de99283
--- /dev/null
+++ b/tests/qapi-schema/string-unclosed.err
@@ -0,0 +1 @@
+tests/qapi-schema/string-unclosed.json:1:11: missing terminating "'"
diff --git a/tests/qapi-schema/string-unicode.err b/tests/qapi-schema/str=
ing-unicode.err
new file mode 100644
index 0000000000..646468f815
--- /dev/null
+++ b/tests/qapi-schema/string-unicode.err
@@ -0,0 +1 @@
+tests/qapi-schema/string-unicode.json:2:14: non-ASCII character in strin=
g
diff --git a/tests/qapi-schema/struct-member-invalid-dict.err b/tests/qap=
i-schema/struct-member-invalid-dict.err
index e8b0ee72e0..0c770bb1e8 100644
--- a/tests/qapi-schema/struct-member-invalid-dict.err
+++ b/tests/qapi-schema/struct-member-invalid-dict.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/struct-member-invalid-dict.json: In struct 'foo':
-tests/qapi-schema/struct-member-invalid-dict.json:2: Key 'type' is missi=
ng from member '*a' of 'data' for struct 'foo'
+tests/qapi-schema/struct-member-invalid-dict.json:2: key 'type' is missi=
ng from member '*a' of 'data' for struct 'foo'
diff --git a/tests/qapi-schema/struct-member-invalid.err b/tests/qapi-sch=
ema/struct-member-invalid.err
index 466c1af1d0..e5a19fc8af 100644
--- a/tests/qapi-schema/struct-member-invalid.err
+++ b/tests/qapi-schema/struct-member-invalid.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/struct-member-invalid.json: In struct 'foo':
-tests/qapi-schema/struct-member-invalid.json:1: Member 'a' of 'data' for=
 struct 'foo' should be a type name
+tests/qapi-schema/struct-member-invalid.json:1: member 'a' of 'data' for=
 struct 'foo' should be a type name
diff --git a/tests/qapi-schema/trailing-comma-list.err b/tests/qapi-schem=
a/trailing-comma-list.err
index 601c4537c3..167d688beb 100644
--- a/tests/qapi-schema/trailing-comma-list.err
+++ b/tests/qapi-schema/trailing-comma-list.err
@@ -1 +1 @@
-tests/qapi-schema/trailing-comma-list.json:2:36: Expected '{', '[', stri=
ng, boolean or 'null'
+tests/qapi-schema/trailing-comma-list.json:2:36: expected '{', '[', stri=
ng, boolean or 'null'
diff --git a/tests/qapi-schema/trailing-comma-object.err b/tests/qapi-sch=
ema/trailing-comma-object.err
index 30bce5e194..186df0fa45 100644
--- a/tests/qapi-schema/trailing-comma-object.err
+++ b/tests/qapi-schema/trailing-comma-object.err
@@ -1 +1 @@
-tests/qapi-schema/trailing-comma-object.json:2:38: Expected string
+tests/qapi-schema/trailing-comma-object.json:2:38: expected string
diff --git a/tests/qapi-schema/unclosed-list.err b/tests/qapi-schema/uncl=
osed-list.err
index 1cc3a094fe..6648a8e30b 100644
--- a/tests/qapi-schema/unclosed-list.err
+++ b/tests/qapi-schema/unclosed-list.err
@@ -1 +1 @@
-tests/qapi-schema/unclosed-list.json:1:20: Expected ',' or ']'
+tests/qapi-schema/unclosed-list.json:1:20: expected ',' or ']'
diff --git a/tests/qapi-schema/unclosed-object.err b/tests/qapi-schema/un=
closed-object.err
index fd1a86b704..54d221e3a9 100644
--- a/tests/qapi-schema/unclosed-object.err
+++ b/tests/qapi-schema/unclosed-object.err
@@ -1 +1 @@
-tests/qapi-schema/unclosed-object.json:1:21: Expected ',' or '}'
+tests/qapi-schema/unclosed-object.json:1:21: expected ',' or '}'
diff --git a/tests/qapi-schema/unclosed-string.err b/tests/qapi-schema/un=
closed-string.err
index 12b187074e..9439698fe0 100644
--- a/tests/qapi-schema/unclosed-string.err
+++ b/tests/qapi-schema/unclosed-string.err
@@ -1 +1 @@
-tests/qapi-schema/unclosed-string.json:1:11: Missing terminating "'"
+tests/qapi-schema/unclosed-string.json:1:11: missing terminating "'"
diff --git a/tests/qapi-schema/union-base-empty.err b/tests/qapi-schema/u=
nion-base-empty.err
index 1e24341819..b76542d47a 100644
--- a/tests/qapi-schema/union-base-empty.err
+++ b/tests/qapi-schema/union-base-empty.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/union-base-empty.json: In union 'TestUnion':
-tests/qapi-schema/union-base-empty.json:5: Discriminator 'type' is not a=
 member of 'base'
+tests/qapi-schema/union-base-empty.json:5: discriminator 'type' is not a=
 member of 'base'
diff --git a/tests/qapi-schema/union-base-no-discriminator.err b/tests/qa=
pi-schema/union-base-no-discriminator.err
index fa9343fb8e..883a98866b 100644
--- a/tests/qapi-schema/union-base-no-discriminator.err
+++ b/tests/qapi-schema/union-base-no-discriminator.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/union-base-no-discriminator.json: In union 'TestUnion'=
:
-tests/qapi-schema/union-base-no-discriminator.json:11: Simple union 'Tes=
tUnion' must not have a base
+tests/qapi-schema/union-base-no-discriminator.json:11: simple union 'Tes=
tUnion' must not have a base
diff --git a/tests/qapi-schema/union-branch-case.err b/tests/qapi-schema/=
union-branch-case.err
index 09313d7f83..f111210281 100644
--- a/tests/qapi-schema/union-branch-case.err
+++ b/tests/qapi-schema/union-branch-case.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/union-branch-case.json: In union 'Uni':
-tests/qapi-schema/union-branch-case.json:2: Member of union 'Uni' uses u=
ppercase in name 'Branch'
+tests/qapi-schema/union-branch-case.json:2: member of union 'Uni' uses u=
ppercase in name 'Branch'
diff --git a/tests/qapi-schema/union-branch-invalid-dict.err b/tests/qapi=
-schema/union-branch-invalid-dict.err
index 5b8b68432c..d11a739674 100644
--- a/tests/qapi-schema/union-branch-invalid-dict.err
+++ b/tests/qapi-schema/union-branch-invalid-dict.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/union-branch-invalid-dict.json: In union 'UnionInvalid=
Branch':
-tests/qapi-schema/union-branch-invalid-dict.json:2: Key 'type' is missin=
g from member 'integer' of union 'UnionInvalidBranch'
+tests/qapi-schema/union-branch-invalid-dict.json:2: key 'type' is missin=
g from member 'integer' of union 'UnionInvalidBranch'
diff --git a/tests/qapi-schema/union-empty.err b/tests/qapi-schema/union-=
empty.err
index 75f2fa9f21..522b19e7ae 100644
--- a/tests/qapi-schema/union-empty.err
+++ b/tests/qapi-schema/union-empty.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/union-empty.json: In union 'Union':
-tests/qapi-schema/union-empty.json:2: Union 'Union' has no branches
+tests/qapi-schema/union-empty.json:2: union 'Union' has no branches
diff --git a/tests/qapi-schema/union-optional-branch.err b/tests/qapi-sch=
ema/union-optional-branch.err
index 09320416ad..a5677f74bc 100644
--- a/tests/qapi-schema/union-optional-branch.err
+++ b/tests/qapi-schema/union-optional-branch.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/union-optional-branch.json: In union 'Union':
-tests/qapi-schema/union-optional-branch.json:2: Member of union 'Union' =
does not allow optional name '*a'
+tests/qapi-schema/union-optional-branch.json:2: member of union 'Union' =
does not allow optional name '*a'
diff --git a/tests/qapi-schema/union-unknown.err b/tests/qapi-schema/unio=
n-unknown.err
index 7c6cabb8cc..5d4fdd2857 100644
--- a/tests/qapi-schema/union-unknown.err
+++ b/tests/qapi-schema/union-unknown.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/union-unknown.json: In union 'Union':
-tests/qapi-schema/union-unknown.json:2: Member 'unknown' of union 'Union=
' uses unknown type 'MissingType'
+tests/qapi-schema/union-unknown.json:2: member 'unknown' of union 'Union=
' uses unknown type 'MissingType'
diff --git a/tests/qapi-schema/unknown-escape.err b/tests/qapi-schema/unk=
nown-escape.err
index 000e30ddf3..e24bbaf046 100644
--- a/tests/qapi-schema/unknown-escape.err
+++ b/tests/qapi-schema/unknown-escape.err
@@ -1 +1 @@
-tests/qapi-schema/unknown-escape.json:3:21: Unknown escape \x
+tests/qapi-schema/unknown-escape.json:3:21: unknown escape \x
diff --git a/tests/qapi-schema/unknown-expr-key.err b/tests/qapi-schema/u=
nknown-expr-key.err
index 4340eaf894..07558edb78 100644
--- a/tests/qapi-schema/unknown-expr-key.err
+++ b/tests/qapi-schema/unknown-expr-key.err
@@ -1,2 +1,2 @@
-tests/qapi-schema/unknown-expr-key.json:2: Unknown keys 'bogus', 'phony'=
 in struct 'bar'
+tests/qapi-schema/unknown-expr-key.json:2: unknown keys 'bogus', 'phony'=
 in struct 'bar'
 Valid keys are 'base', 'data', 'features', 'if', 'struct'.
--=20
2.21.0


