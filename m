Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F89CC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:08:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7ED9208A9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IfvHJ+Qr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7ED9208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKqSi-0004ej-Pc
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpgI-0007ko-TQ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:18:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpgG-0006f7-KU
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600809511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vv6gz/rv2Yfhg2YZr9ebex9Kb/v+vSlxIvI5b/okvhU=;
 b=IfvHJ+QrP3E8YGj2GPtIKNXCyCnk5eevNI06NN1QtFRL0YqZ5x3fhIJ5WNx0njllKdZWL3
 CJZku5bmEsmdKUiXhB7T9KdaAvYo4KEuz+vidAjCvrJRAwTXDDMXJEDPFIw66F3xrltl8i
 pkjFYE2jud5zTBM4KSbN6NRu2880WCg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184--TR-ejU-NM2Encysz0fQmg-1; Tue, 22 Sep 2020 17:18:15 -0400
X-MC-Unique: -TR-ejU-NM2Encysz0fQmg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B87D186DD39;
 Tue, 22 Sep 2020 21:18:14 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AEC765DE50;
 Tue, 22 Sep 2020 21:18:13 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 06/14] qapi/doc.py: Add type hint annotations
Date: Tue, 22 Sep 2020 17:17:54 -0400
Message-Id: <20200922211802.4083666-7-jsnow@redhat.com>
In-Reply-To: <20200922211802.4083666-1-jsnow@redhat.com>
References: <20200922211802.4083666-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Annotations do not change runtime behavior.
This commit *only* adds annotations.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/doc.py | 119 ++++++++++++++++++++++++++++++++------------
 1 file changed, 87 insertions(+), 32 deletions(-)

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 9a02cf2f27..43943575da 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -5,14 +5,24 @@
 """This script produces the documentation of a qapi schema in texinfo format"""
 
 import re
-from typing import Optional
+from typing import Callable, List, Optional
 
 from .gen import QAPIGenDoc
+from .parser import QAPIDoc
 from .schema import (
+    QAPISchema,
+    QAPISchemaEntity,
     QAPISchemaEnumMember,
+    QAPISchemaFeature,
+    QAPISchemaMember,
+    QAPISchemaObjectType,
     QAPISchemaObjectTypeMember,
+    QAPISchemaType,
+    QAPISchemaVariants,
     QAPISchemaVisitor,
 )
+from .source import QAPISourceInfo
+
 
 MSG_FMT = """
 @deftypefn {type} {{}} {name}
@@ -36,27 +46,27 @@
 """.format
 
 
-def subst_strong(doc):
+def subst_strong(doc: str) -> str:
     """Replaces *foo* by @strong{foo}"""
     return re.sub(r'\*([^*\n]+)\*', r'@strong{\1}', doc)
 
 
-def subst_emph(doc):
+def subst_emph(doc: str) -> str:
     """Replaces _foo_ by @emph{foo}"""
     return re.sub(r'\b_([^_\n]+)_\b', r'@emph{\1}', doc)
 
 
-def subst_vars(doc):
+def subst_vars(doc: str) -> str:
     """Replaces @var by @code{var}"""
     return re.sub(r'@([\w-]+)', r'@code{\1}', doc)
 
 
-def subst_braces(doc):
+def subst_braces(doc: str) -> str:
     """Replaces {} with @{ @}"""
     return doc.replace('{', '@{').replace('}', '@}')
 
 
-def texi_example(doc):
+def texi_example(doc: str) -> str:
     """Format @example"""
     # TODO: Neglects to escape @ characters.
     # We should probably escape them in subst_braces(), and rename the
@@ -66,7 +76,7 @@ def texi_example(doc):
     return EXAMPLE_FMT(code=doc)
 
 
-def texi_format(doc):
+def texi_format(doc: str) -> str:
     """
     Format documentation
 
@@ -126,19 +136,26 @@ def texi_format(doc):
     return ret
 
 
-def texi_body(doc):
+def texi_body(doc: QAPIDoc) -> str:
     """Format the main documentation body"""
     return texi_format(doc.body.text)
 
 
-def texi_if(ifcond, prefix='\n', suffix='\n'):
+def texi_if(ifcond: Optional[List[str]],
+            prefix: str = '\n',
+            suffix: str = '\n') -> str:
     """Format the #if condition"""
     if not ifcond:
         return ''
     return '%s@b{If:} @code{%s}%s' % (prefix, ', '.join(ifcond), suffix)
 
 
-def texi_enum_value(value, desc, suffix):
+TexiMemberCallback = Callable[[QAPISchemaMember, str, str], str]
+
+
+def texi_enum_value(value: QAPISchemaMember,
+                    desc: str,
+                    suffix: str) -> str:
     """Format a table of members item for an enumeration value"""
     assert isinstance(value, QAPISchemaEnumMember)
     assert suffix == '', "Ignored suffix for texi_enum_value"
@@ -146,7 +163,9 @@ def texi_enum_value(value, desc, suffix):
         value.name, desc, texi_if(value.ifcond, prefix='@*'))
 
 
-def texi_member(member, desc, suffix):
+def texi_member(member: QAPISchemaMember,
+                desc: str,
+                suffix: str) -> str:
     """Format a table of members item for an object type member"""
     assert isinstance(member, QAPISchemaObjectTypeMember)
     typ = member.type.doc_type()
@@ -157,8 +176,11 @@ def texi_member(member, desc, suffix):
         suffix, desc, texi_if(member.ifcond, prefix='@*'))
 
 
-def texi_members(doc, what, base=None, variants=None,
-                 member_func=texi_member):
+def texi_members(doc: QAPIDoc,
+                 what: str,
+                 base: Optional[QAPISchemaObjectType] = None,
+                 variants: Optional[QAPISchemaVariants] = None,
+                 member_func: TexiMemberCallback = texi_member) -> str:
     """Format the table of members"""
     items = ''
     for section in doc.args.values():
@@ -195,7 +217,8 @@ def texi_members(doc, what, base=None, variants=None,
     return '\n@b{%s:}\n@table @asis\n%s@end table\n' % (what, items)
 
 
-def texi_arguments(doc, boxed_arg_type):
+def texi_arguments(doc: QAPIDoc,
+                   boxed_arg_type: Optional[QAPISchemaObjectType]) -> str:
     if boxed_arg_type:
         assert not doc.args
         return ('\n@b{Arguments:} the members of @code{%s}\n'
@@ -203,7 +226,7 @@ def texi_arguments(doc, boxed_arg_type):
     return texi_members(doc, 'Arguments')
 
 
-def texi_features(doc):
+def texi_features(doc: QAPIDoc) -> str:
     """Format the table of features"""
     items = ''
     for section in doc.features.values():
@@ -214,7 +237,7 @@ def texi_features(doc):
     return '\n@b{Features:}\n@table @asis\n%s@end table\n' % (items)
 
 
-def texi_sections(doc, ifcond):
+def texi_sections(doc: QAPIDoc, ifcond: Optional[List[str]]) -> str:
     """Format additional sections following arguments"""
     body = ''
     for section in doc.sections:
@@ -229,7 +252,7 @@ def texi_sections(doc, ifcond):
     return body
 
 
-def texi_type(typ, doc, ifcond, members):
+def texi_type(typ: str, doc: QAPIDoc, ifcond: List[str], members: str) -> str:
     return TYPE_FMT(type=typ,
                     name=doc.symbol,
                     body=texi_body(doc),
@@ -238,7 +261,7 @@ def texi_type(typ, doc, ifcond, members):
                     sections=texi_sections(doc, ifcond))
 
 
-def texi_msg(typ, doc, ifcond, members):
+def texi_msg(typ: str, doc: QAPIDoc, ifcond: List[str], members: str) -> str:
     return MSG_FMT(type=typ,
                    name=doc.symbol,
                    body=texi_body(doc),
@@ -248,60 +271,92 @@ def texi_msg(typ, doc, ifcond, members):
 
 
 class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
-    def __init__(self, prefix):
+    def __init__(self, prefix: str):
         self._prefix = prefix
         self._gen = QAPIGenDoc(self._prefix + 'qapi-doc.texi')
-        self.cur_doc = None
+        self.cur_doc: Optional[QAPIDoc] = None
 
-    def write(self, output_dir):
+    def write(self, output_dir: str) -> None:
         self._gen.write(output_dir)
 
-    def visit_enum_type(self, name, info, ifcond, features, members, prefix):
+    def visit_enum_type(self,
+                        name: str,
+                        info: QAPISourceInfo,
+                        ifcond: List[str],
+                        features: List[QAPISchemaFeature],
+                        members: List[QAPISchemaEnumMember],
+                        prefix: Optional[str]) -> None:
         doc = self.cur_doc
         self._gen.add(texi_type('Enum', doc, ifcond,
                                 texi_members(doc, 'Values',
                                              member_func=texi_enum_value)))
 
-    def visit_object_type(self, name, info, ifcond, features,
-                          base, members, variants):
+    def visit_object_type(self,
+                          name: str,
+                          info: QAPISourceInfo,
+                          ifcond: List[str],
+                          features: List[QAPISchemaFeature],
+                          base: Optional[QAPISchemaObjectType],
+                          members: List[QAPISchemaObjectTypeMember],
+                          variants: Optional[QAPISchemaVariants]) -> None:
         doc = self.cur_doc
         if base and base.is_implicit():
             base = None
         self._gen.add(texi_type('Object', doc, ifcond,
                                 texi_members(doc, 'Members', base, variants)))
 
-    def visit_alternate_type(self, name, info, ifcond, features, variants):
+    def visit_alternate_type(self,
+                             name: str,
+                             info: QAPISourceInfo,
+                             ifcond: List[str],
+                             features: List[QAPISchemaFeature],
+                             variants: QAPISchemaVariants) -> None:
         doc = self.cur_doc
         self._gen.add(texi_type('Alternate', doc, ifcond,
                                 texi_members(doc, 'Members')))
 
-    def visit_command(self, name, info, ifcond, features,
-                      arg_type, ret_type, gen, success_response, boxed,
-                      allow_oob, allow_preconfig):
+    def visit_command(self,
+                      name: str,
+                      info: QAPISourceInfo,
+                      ifcond: List[str],
+                      features: List[QAPISchemaFeature],
+                      arg_type: QAPISchemaObjectType,
+                      ret_type: QAPISchemaType,
+                      gen: bool,
+                      success_response: bool,
+                      boxed: bool,
+                      allow_oob: bool,
+                      allow_preconfig: bool) -> None:
         doc = self.cur_doc
         members = texi_arguments(doc, arg_type if boxed else None)
         self._gen.add(texi_msg('Command', doc, ifcond, members))
 
-    def visit_event(self, name, info, ifcond, features, arg_type, boxed):
+    def visit_event(self,
+                    name: str,
+                    info: QAPISourceInfo,
+                    ifcond: List[str],
+                    features: List[QAPISchemaFeature],
+                    arg_type: QAPISchemaObjectType,
+                    boxed: bool) -> None:
         doc = self.cur_doc
         members = texi_arguments(doc, arg_type if boxed else None)
         self._gen.add(texi_msg('Event', doc, ifcond, members))
 
-    def symbol(self, doc, entity):
+    def symbol(self, doc: QAPIDoc, entity: QAPISchemaEntity) -> None:
         if self._gen._body:
             self._gen.add('\n')
         self.cur_doc = doc
         entity.visit(self)
         self.cur_doc = None
 
-    def freeform(self, doc):
+    def freeform(self, doc: QAPIDoc) -> None:
         assert not doc.args
         if self._gen._body:
             self._gen.add('\n')
         self._gen.add(texi_body(doc) + texi_sections(doc, None))
 
 
-def gen_doc(schema, output_dir, prefix):
+def gen_doc(schema: QAPISchema, output_dir: str, prefix: str) -> None:
     vis = QAPISchemaGenDocVisitor(prefix)
     vis.visit_begin(schema)
     for doc in schema.docs:
-- 
2.26.2


