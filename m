Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D031C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:32:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96D9C20757
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gsw4vavP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D9C20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKptI-0007FT-5W
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 17:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpQP-0002aE-Bq
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:02:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpQI-0004ew-Ds
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600808520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rv+GbJMGvi07Ydrp0iM6tLrOr0MCaCDZiPfLKRTNgy8=;
 b=Gsw4vavPbwGpY4hUuWus5kfYiQ8aAwtPV/yhPYe7yOIP/0QGGbejUKx3N8qAtrNeVHyt3O
 xG3I0rtURgiE+QFAjJmb2280JDQIrQF0UGrfetWrMQmHPyGMJqfHaiqo3YT11BRxzJS05G
 L+e0qfNGg2poJ9p/7I5jTK1HpWKcWH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-X2BgJvh1NCWS7iDwI4Oqgg-1; Tue, 22 Sep 2020 17:01:59 -0400
X-MC-Unique: X2BgJvh1NCWS7iDwI4Oqgg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3570185A0CA;
 Tue, 22 Sep 2020 21:01:57 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAD4455765;
 Tue, 22 Sep 2020 21:01:56 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 38/38] qapi/visit.py: add type hint annotations
Date: Tue, 22 Sep 2020 17:01:01 -0400
Message-Id: <20200922210101.4081073-39-jsnow@redhat.com>
In-Reply-To: <20200922210101.4081073-1-jsnow@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 15:47:47
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Annotations do not change runtime behavior.
This commit *only* adds annotations.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/mypy.ini |  5 ----
 scripts/qapi/visit.py | 68 +++++++++++++++++++++++++++++++++----------
 2 files changed, 52 insertions(+), 21 deletions(-)

diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
index 3babc380a8..5ab3433c5f 100644
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
index ec9d36e72f..3bd06661c4 100644
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
@@ -23,12 +25,19 @@
 )
 from .gen import QAPISchemaModularCVisitor, ifcontext
 from .schema import (
+    QAPISchema,
+    QAPISchemaEnumMember,
     QAPISchemaEnumType,
+    QAPISchemaFeature,
     QAPISchemaObjectType,
+    QAPISchemaObjectTypeMember,
+    QAPISchemaType,
+    QAPISchemaVariants,
 )
+from .source import QAPISourceInfo
 
 
-def gen_visit_decl(name, scalar=False):
+def gen_visit_decl(name: str, scalar: bool = False) -> str:
     c_type = c_name(name) + ' *'
     if not scalar:
         c_type += '*'
@@ -40,7 +49,7 @@ def gen_visit_decl(name, scalar=False):
                  c_name=c_name(name), c_type=c_type)
 
 
-def gen_visit_members_decl(name):
+def gen_visit_members_decl(name: str) -> str:
     return mcgen('''
 
 bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp);
@@ -48,7 +57,10 @@ def gen_visit_members_decl(name):
                  c_name=c_name(name))
 
 
-def gen_visit_object_members(name, base, members, variants):
+def gen_visit_object_members(name: str,
+                             base: Optional[QAPISchemaObjectType],
+                             members: List[QAPISchemaObjectTypeMember],
+                             variants: Optional[QAPISchemaVariants]) -> str:
     ret = mcgen('''
 
 bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
@@ -128,7 +140,7 @@ def gen_visit_object_members(name, base, members, variants):
     return ret
 
 
-def gen_visit_list(name, element_type):
+def gen_visit_list(name: str, element_type: QAPISchemaType) -> str:
     return mcgen('''
 
 bool visit_type_%(c_name)s(Visitor *v, const char *name,
@@ -162,7 +174,7 @@ def gen_visit_list(name, element_type):
                  c_name=c_name(name), c_elt_type=element_type.c_name())
 
 
-def gen_visit_enum(name):
+def gen_visit_enum(name: str) -> str:
     return mcgen('''
 
 bool visit_type_%(c_name)s(Visitor *v, const char *name,
@@ -177,7 +189,7 @@ def gen_visit_enum(name):
                  c_name=c_name(name))
 
 
-def gen_visit_alternate(name, variants):
+def gen_visit_alternate(name: str, variants: QAPISchemaVariants) -> str:
     ret = mcgen('''
 
 bool visit_type_%(c_name)s
@@ -253,7 +265,7 @@ def gen_visit_alternate(name, variants):
     return ret
 
 
-def gen_visit_object(name):
+def gen_visit_object(name: str) -> str:
     return mcgen('''
 
 bool visit_type_%(c_name)s
@@ -288,12 +300,12 @@ def gen_visit_object(name):
 
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
@@ -305,7 +317,7 @@ def _begin_system_module(self, name):
 
 '''))
 
-    def _begin_user_module(self, name):
+    def _begin_user_module(self, name: str) -> None:
         types = self._module_basename('qapi-types', name)
         visit = self._module_basename('qapi-visit', name)
         self._genc.preamble_add(mcgen('''
@@ -322,18 +334,34 @@ def _begin_user_module(self, name):
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
@@ -348,13 +376,21 @@ def visit_object_type(self, name, info, ifcond, features,
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


