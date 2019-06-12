Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC82C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 17:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2EFB21019
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 17:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2EFB21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34000 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb6pm-0000gg-8T
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 13:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57966)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hb6Ug-0007U9-0p
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hb6Ue-0006dK-2w
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:53:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56432)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hb6Uc-0006ET-0Q
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:52:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DD2413086232
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 16:52:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 87E261FC;
 Wed, 12 Jun 2019 16:52:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BABA01136421; Wed, 12 Jun 2019 18:52:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 12 Jun 2019 18:52:27 +0200
Message-Id: <20190612165229.26976-10-armbru@redhat.com>
In-Reply-To: <20190612165229.26976-1-armbru@redhat.com>
References: <20190612165229.26976-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Wed, 12 Jun 2019 16:52:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 09/11] qapi: Allow documentation for features
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
Cc: Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

Features will be documented in a new part introduced by a "Features:"
line, after arguments and before named sections.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20190606153803.5278-6-armbru@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py | 43 ++++++++++++++++++++++++++++++++++++++----
 scripts/qapi/doc.py    | 12 ++++++++++++
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index f40a2cd4c5..1164301edf 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -129,6 +129,7 @@ class QAPIDoc(object):
           optional overview
         * an ARGS part: description of each argument (for commands and
           events) or member (for structs, unions and alternates),
+        * a FEATURES part: description of each feature,
         * a VARIOUS part: optional tagged sections.
=20
         Free-form documentation blocks consist only of a BODY part.
@@ -136,7 +137,8 @@ class QAPIDoc(object):
         # TODO Make it a subclass of Enum when Python 2 support is remov=
ed
         BODY =3D 1
         ARGS =3D 2
-        VARIOUS =3D 3
+        FEATURES =3D 3
+        VARIOUS =3D 4
=20
     def __init__(self, parser, info):
         # self._parser is used to report errors with QAPIParseError.  Th=
e
@@ -149,6 +151,7 @@ class QAPIDoc(object):
         self.body =3D QAPIDoc.Section()
         # dict mapping parameter name to ArgSection
         self.args =3D OrderedDict()
+        self.features =3D OrderedDict()
         # a list of Section
         self.sections =3D []
         # the current section
@@ -197,6 +200,8 @@ class QAPIDoc(object):
             self._append_body_line(line)
         elif self._part =3D=3D QAPIDoc.DocPart.ARGS:
             self._append_args_line(line)
+        elif self._part =3D=3D QAPIDoc.DocPart.FEATURES:
+            self._append_features_line(line)
         elif self._part =3D=3D QAPIDoc.DocPart.VARIOUS:
             self._append_various_line(line)
         else:
@@ -229,6 +234,8 @@ class QAPIDoc(object):
             if name.startswith('@') and name.endswith(':'):
                 self._part =3D QAPIDoc.DocPart.ARGS
                 self._append_args_line(line)
+            elif line =3D=3D 'Features:':
+                self._part =3D QAPIDoc.DocPart.FEATURES
             elif self._is_section_tag(name):
                 self._part =3D QAPIDoc.DocPart.VARIOUS
                 self._append_various_line(line)
@@ -248,6 +255,28 @@ class QAPIDoc(object):
             self._part =3D QAPIDoc.DocPart.VARIOUS
             self._append_various_line(line)
             return
+        elif (self._section.text.endswith('\n\n')
+              and line and not line[0].isspace()):
+            if line =3D=3D 'Features:':
+                self._part =3D QAPIDoc.DocPart.FEATURES
+            else:
+                self._start_section()
+                self._part =3D QAPIDoc.DocPart.VARIOUS
+                self._append_various_line(line)
+            return
+
+        self._append_freeform(line.strip())
+
+    def _append_features_line(self, line):
+        name =3D line.split(' ', 1)[0]
+
+        if name.startswith('@') and name.endswith(':'):
+            line =3D line[len(name)+1:]
+            self._start_features_section(name[1:-1])
+        elif self._is_section_tag(name):
+            self._part =3D QAPIDoc.DocPart.VARIOUS
+            self._append_various_line(line)
+            return
         elif (self._section.text.endswith('\n\n')
               and line and not line[0].isspace()):
             self._start_section()
@@ -274,17 +303,23 @@ class QAPIDoc(object):
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
index 433e9fcbfb..5fc0fc7e06 100755
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -182,6 +182,17 @@ def texi_members(doc, what, base, variants, member_f=
unc):
     return '\n@b{%s:}\n@table @asis\n%s@end table\n' % (what, items)
=20
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
+
 def texi_sections(doc, ifcond):
     """Format additional sections following arguments"""
     body =3D ''
@@ -201,6 +212,7 @@ def texi_entity(doc, what, ifcond, base=3DNone, varia=
nts=3DNone,
                 member_func=3Dtexi_member):
     return (texi_body(doc)
             + texi_members(doc, what, base, variants, member_func)
+            + texi_features(doc)
             + texi_sections(doc, ifcond))
=20
=20
--=20
2.21.0


