Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B656FC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 14:46:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C32121743
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 14:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C32121743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49692 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRe8C-0004ae-Kg
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 10:46:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hRe4l-0001so-94
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:43:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hRe4k-00047g-29
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:43:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hRe4h-00045J-5P; Fri, 17 May 2019 10:43:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 634EC80F79;
	Fri, 17 May 2019 14:42:56 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-213.ams2.redhat.com
	[10.36.116.213])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 039585D784;
	Fri, 17 May 2019 14:42:54 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 17 May 2019 16:42:31 +0200
Message-Id: <20190517144232.18965-6-kwolf@redhat.com>
In-Reply-To: <20190517144232.18965-1-kwolf@redhat.com>
References: <20190517144232.18965-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Fri, 17 May 2019 14:43:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 5/6] qapi: Allow documentation for features
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, pkrempa@redhat.com, armbru@redhat.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Features will be documented in a new part introduced by a "Features:"
line, after arguments and before named sections.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 scripts/qapi/common.py | 43 ++++++++++++++++++++++++++++++++++++++----
 scripts/qapi/doc.py    | 11 +++++++++++
 2 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 1d0f4847db..6a1ec87d41 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -132,6 +132,9 @@ class QAPIDoc(object):
         ARGS means that we're parsing the arguments section. Any symbol =
name is
         interpreted as an argument and an ArgSection is created for it.
=20
+        FEATURES means that we're parsing features sections. Any symbol =
name is
+        interpreted as a feature.
+
         VARIOUS is the final part where freeform sections may appear. Th=
is
         includes named sections such as "Return:" as well as unnamed
         paragraphs. No symbols are allowed any more in this part.
@@ -139,7 +142,8 @@ class QAPIDoc(object):
         # Can't make it a subclass of Enum because of Python 2
         BODY =3D 0
         ARGS =3D 1
-        VARIOUS =3D 2
+        FEATURES =3D 2
+        VARIOUS =3D 3
=20
     def __init__(self, parser, info):
         # self._parser is used to report errors with QAPIParseError.  Th=
e
@@ -152,6 +156,7 @@ class QAPIDoc(object):
         self.body =3D QAPIDoc.Section()
         # dict mapping parameter name to ArgSection
         self.args =3D OrderedDict()
+        self.features =3D OrderedDict()
         # a list of Section
         self.sections =3D []
         # the current section
@@ -180,6 +185,8 @@ class QAPIDoc(object):
             self._append_body_line(line)
         elif self._part =3D=3D QAPIDoc.SymbolPart.ARGS:
             self._append_args_line(line)
+        elif self._part =3D=3D QAPIDoc.SymbolPart.FEATURES:
+            self._append_features_line(line)
         elif self._part =3D=3D QAPIDoc.SymbolPart.VARIOUS:
             self._append_various_line(line)
         else:
@@ -215,6 +222,8 @@ class QAPIDoc(object):
             if name.startswith('@') and name.endswith(':'):
                 self._part =3D QAPIDoc.SymbolPart.ARGS
                 self._append_args_line(line)
+            elif line =3D=3D 'Features:':
+                self._part =3D QAPIDoc.SymbolPart.FEATURES
             elif self.symbol and self._check_named_section(line, name):
                 self._append_various_line(line)
             else:
@@ -231,6 +240,26 @@ class QAPIDoc(object):
             self._start_args_section(name[1:-1])
         elif self._check_named_section(line, name):
             return self._append_various_line(line)
+        elif (self._section.text.endswith('\n\n')
+              and line and not line[0].isspace()):
+            if line =3D=3D 'Features:':
+                self._part =3D QAPIDoc.SymbolPart.FEATURES
+                return
+            else:
+                self._start_section()
+                self._part =3D QAPIDoc.SymbolPart.VARIOUS
+                return self._append_various_line(line)
+
+        self._append_freeform(line.strip())
+
+    def _append_features_line(self, line):
+        name =3D line.split(' ', 1)[0]
+
+        if name.startswith('@') and name.endswith(':'):
+            line =3D line[len(name)+1:]
+            self._start_features_section(name[1:-1])
+        elif self._check_named_section(line, name):
+            return self._append_various_line(line)
         elif (self._section.text.endswith('\n\n')
               and line and not line[0].isspace()):
             self._start_section()
@@ -256,17 +285,23 @@ class QAPIDoc(object):
=20
         self._append_freeform(line)
=20
-    def _start_args_section(self, name):
+    def _start_symbol_section(self, symbols_dict, name):
         # FIXME invalid names other than the empty string aren't flagged
         if not name:
             raise QAPIParseError(self._parser, "Invalid parameter name")
-        if name in self.args:
+        if name in symbols_dict:
             raise QAPIParseError(self._parser,
                                  "'%s' parameter name duplicated" % name=
)
         assert not self.sections
         self._end_section()
         self._section =3D QAPIDoc.ArgSection(name)
-        self.args[name] =3D self._section
+        symbols_dict[name] =3D self._section
+
+    def _start_args_section(self, name):
+        self._start_symbol_section(self.args, name)
+
+    def _start_features_section(self, name):
+        self._start_symbol_section(self.features, name)
=20
     def _start_section(self, name=3DNone):
         if name in ('Returns', 'Since') and self.has_section(name):
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 433e9fcbfb..8e799b9e0b 100755
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -181,6 +181,16 @@ def texi_members(doc, what, base, variants, member_f=
unc):
         return ''
     return '\n@b{%s:}\n@table @asis\n%s@end table\n' % (what, items)
=20
+def texi_features(doc):
+    """Format the table of features"""
+    items =3D ''
+    for section in doc.features.values():
+        desc =3D texi_format(section.text)
+        items +=3D '@item @code{%s}\n%s' % (section.name, desc)
+    if not items:
+        return ''
+    return '\n@b{Features:}\n@table @asis\n%s@end table\n' % (items)
+
=20
 def texi_sections(doc, ifcond):
     """Format additional sections following arguments"""
@@ -201,6 +211,7 @@ def texi_entity(doc, what, ifcond, base=3DNone, varia=
nts=3DNone,
                 member_func=3Dtexi_member):
     return (texi_body(doc)
             + texi_members(doc, what, base, variants, member_func)
+            + texi_features(doc)
             + texi_sections(doc, ifcond))
=20
=20
--=20
2.20.1


