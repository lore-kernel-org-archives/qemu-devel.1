Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90445C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 208C62227F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwlbWNW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208C62227F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvRs-000446-9A
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQv4c-0004cO-M7
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:16:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQv4X-0003My-6f
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602260204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xfLHFOeSxVhEBa0V5rzKpvO9KzbAZlKvh/1PPXfZ3Wc=;
 b=BwlbWNW+88ILG984iEtLaDcaqdnvS84tMRziRzj45Wx9YNWEYGno1+ll7lpui7wFHZ2r4H
 S/3qwT19fcHOwSp++Pv2tvispCbnGKnYdx9M/lX96xNM3ul1PjxtBaoqnkh5zpB3Url8u7
 Zi2I+xKgRsnPgr0527hY2I5U1vewlJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-KUmJUotTPd-My3KArqdUNw-1; Fri, 09 Oct 2020 12:16:42 -0400
X-MC-Unique: KUmJUotTPd-My3KArqdUNw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88D7780B70D;
 Fri,  9 Oct 2020 16:16:41 +0000 (UTC)
Received: from scv.redhat.com (ovpn-112-203.rdu2.redhat.com [10.10.112.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CBE6521E95;
 Fri,  9 Oct 2020 16:16:40 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 36/36] qapi/visit.py: add type hint annotations
Date: Fri,  9 Oct 2020 12:15:58 -0400
Message-Id: <20201009161558.107041-37-jsnow@redhat.com>
In-Reply-To: <20201009161558.107041-1-jsnow@redhat.com>
References: <20201009161558.107041-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Annotations do not change runtime behavior.
This commit *only* adds annotations.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/qapi/mypy.ini |  5 ---
 scripts/qapi/visit.py | 73 +++++++++++++++++++++++++++++++++----------
 2 files changed, 56 insertions(+), 22 deletions(-)

diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
index 83f19813553..74fc6c82153 100644
--- a/scripts/qapi/mypy.ini
+++ b/scripts/qapi/mypy.ini
@@ -28,8 +28,3 @@ check_untyped_defs = False
 disallow_untyped_defs = False
 disallow_incomplete_defs = False
 check_untyped_defs = False
-
-[mypy-qapi.visit]
-disallow_untyped_defs = False
-disallow_incomplete_defs = False
-check_untyped_defs = False
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 8699e5c09c6..339f1521524 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -13,6 +13,8 @@
 See the COPYING file in the top-level directory.
 """
 
+from typing import List, Optional
+
 from .common import (
     c_enum_const,
     c_name,
@@ -22,10 +24,20 @@
     mcgen,
 )
 from .gen import QAPISchemaModularCVisitor, ifcontext
-from .schema import QAPISchemaEnumType, QAPISchemaObjectType
+from .schema import (
+    QAPISchema,
+    QAPISchemaEnumMember,
+    QAPISchemaEnumType,
+    QAPISchemaFeature,
+    QAPISchemaObjectType,
+    QAPISchemaObjectTypeMember,
+    QAPISchemaType,
+    QAPISchemaVariants,
+)
+from .source import QAPISourceInfo
 
 
-def gen_visit_decl(name, scalar=False):
+def gen_visit_decl(name: str, scalar: bool = False) -> str:
     c_type = c_name(name) + ' *'
     if not scalar:
         c_type += '*'
@@ -37,7 +49,7 @@ def gen_visit_decl(name, scalar=False):
                  c_name=c_name(name), c_type=c_type)
 
 
-def gen_visit_members_decl(name):
+def gen_visit_members_decl(name: str) -> str:
     return mcgen('''
 
 bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp);
@@ -45,7 +57,10 @@ def gen_visit_members_decl(name):
                  c_name=c_name(name))
 
 
-def gen_visit_object_members(name, base, members, variants):
+def gen_visit_object_members(name: str,
+                             base: Optional[QAPISchemaObjectType],
+                             members: List[QAPISchemaObjectTypeMember],
+                             variants: Optional[QAPISchemaVariants]) -> str:
     ret = mcgen('''
 
 bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
@@ -125,7 +140,7 @@ def gen_visit_object_members(name, base, members, variants):
     return ret
 
 
-def gen_visit_list(name, element_type):
+def gen_visit_list(name: str, element_type: QAPISchemaType) -> str:
     return mcgen('''
 
 bool visit_type_%(c_name)s(Visitor *v, const char *name,
@@ -159,7 +174,7 @@ def gen_visit_list(name, element_type):
                  c_name=c_name(name), c_elt_type=element_type.c_name())
 
 
-def gen_visit_enum(name):
+def gen_visit_enum(name: str) -> str:
     return mcgen('''
 
 bool visit_type_%(c_name)s(Visitor *v, const char *name,
@@ -174,7 +189,7 @@ def gen_visit_enum(name):
                  c_name=c_name(name))
 
 
-def gen_visit_alternate(name, variants):
+def gen_visit_alternate(name: str, variants: QAPISchemaVariants) -> str:
     ret = mcgen('''
 
 bool visit_type_%(c_name)s(Visitor *v, const char *name,
@@ -250,7 +265,7 @@ def gen_visit_alternate(name, variants):
     return ret
 
 
-def gen_visit_object(name):
+def gen_visit_object(name: str) -> str:
     return mcgen('''
 
 bool visit_type_%(c_name)s(Visitor *v, const char *name,
@@ -285,12 +300,12 @@ def gen_visit_object(name):
 
 class QAPISchemaGenVisitVisitor(QAPISchemaModularCVisitor):
 
-    def __init__(self, prefix):
+    def __init__(self, prefix: str):
         super().__init__(
             prefix, 'qapi-visit', ' * Schema-defined QAPI visitors',
             ' * Built-in QAPI visitors', __doc__)
 
-    def _begin_system_module(self, name):
+    def _begin_system_module(self, name: None) -> None:
         self._genc.preamble_add(mcgen('''
 #include "qemu/osdep.h"
 #include "qapi/error.h"
@@ -302,7 +317,7 @@ def _begin_system_module(self, name):
 
 '''))
 
-    def _begin_user_module(self, name):
+    def _begin_user_module(self, name: str) -> None:
         types = self._module_basename('qapi-types', name)
         visit = self._module_basename('qapi-visit', name)
         self._genc.preamble_add(mcgen('''
@@ -319,18 +334,34 @@ def _begin_user_module(self, name):
 ''',
                                       types=types))
 
-    def visit_enum_type(self, name, info, ifcond, features, members, prefix):
+    def visit_enum_type(self,
+                        name: str,
+                        info: QAPISourceInfo,
+                        ifcond: List[str],
+                        features: List[QAPISchemaFeature],
+                        members: List[QAPISchemaEnumMember],
+                        prefix: Optional[str]) -> None:
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.add(gen_visit_decl(name, scalar=True))
             self._genc.add(gen_visit_enum(name))
 
-    def visit_array_type(self, name, info, ifcond, element_type):
+    def visit_array_type(self,
+                         name: str,
+                         info: Optional[QAPISourceInfo],
+                         ifcond: List[str],
+                         element_type: QAPISchemaType) -> None:
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.add(gen_visit_decl(name))
             self._genc.add(gen_visit_list(name, element_type))
 
-    def visit_object_type(self, name, info, ifcond, features,
-                          base, members, variants):
+    def visit_object_type(self,
+                          name: str,
+                          info: Optional[QAPISourceInfo],
+                          ifcond: List[str],
+                          features: List[QAPISchemaFeature],
+                          base: Optional[QAPISchemaObjectType],
+                          members: List[QAPISchemaObjectTypeMember],
+                          variants: Optional[QAPISchemaVariants]) -> None:
         # Nothing to do for the special empty builtin
         if name == 'q_empty':
             return
@@ -345,13 +376,21 @@ def visit_object_type(self, name, info, ifcond, features,
                 self._genh.add(gen_visit_decl(name))
                 self._genc.add(gen_visit_object(name))
 
-    def visit_alternate_type(self, name, info, ifcond, features, variants):
+    def visit_alternate_type(self,
+                             name: str,
+                             info: QAPISourceInfo,
+                             ifcond: List[str],
+                             features: List[QAPISchemaFeature],
+                             variants: QAPISchemaVariants) -> None:
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.add(gen_visit_decl(name))
             self._genc.add(gen_visit_alternate(name, variants))
 
 
-def gen_visit(schema, output_dir, prefix, opt_builtins):
+def gen_visit(schema: QAPISchema,
+              output_dir: str,
+              prefix: str,
+              opt_builtins: bool) -> None:
     vis = QAPISchemaGenVisitVisitor(prefix)
     schema.visit(vis)
     vis.write(output_dir, opt_builtins)
-- 
2.26.2


