Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09CCC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 23:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 578AE221EB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 23:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQLlgoEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578AE221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKrJn-0003aB-CU
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 19:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKr2l-0002K7-Bf
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27547)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKr2f-0000Wl-R2
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600814738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KIzYZQlKwhGoNOUNtlupdCebW6wEPKxJ96BgJJ3SLN8=;
 b=SQLlgoEtQbrCBvSp8UJftL0Xj6f7i4vGZtHcJuFqVid/3Ut5c6x96D5s8rsWLYK5jb4gq5
 FTMiawARFW55wtKMaflRGkK1K+kTKOo0wXh/hiZffdTg0AJ8XrBlwW+JsuLgj+94jY54/v
 L/GhC2HWNh4MXK+8xilNY6u8QKudh/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-XrjDxhYZOyWkCn8IM7p4tQ-1; Tue, 22 Sep 2020 18:45:25 -0400
X-MC-Unique: XrjDxhYZOyWkCn8IM7p4tQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD57F802B49;
 Tue, 22 Sep 2020 22:45:24 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9EF6F5C1A3;
 Tue, 22 Sep 2020 22:45:23 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 15/25] qapi/schema.py: add type hint annotations
Date: Tue, 22 Sep 2020 18:44:51 -0400
Message-Id: <20200922224501.4087749-16-jsnow@redhat.com>
In-Reply-To: <20200922224501.4087749-1-jsnow@redhat.com>
References: <20200922224501.4087749-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Annotations do not change runtime behavior.
This commit *only* adds annotations.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 519 ++++++++++++++++++++++++++++-------------
 1 file changed, 361 insertions(+), 158 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index b502eee9cb..8907bec0b5 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -14,15 +14,27 @@
 
 # TODO catching name collisions in generated code would be nice
 
-import os
-import re
 from collections import OrderedDict
-from typing import cast, List
+import re
+import os
+from typing import (
+    Any,
+    Callable,
+    Dict,
+    List,
+    Optional,
+    Type,
+    TypeVar,
+    Union,
+    cast,
+    overload,
+)
 
 from .common import c_name, POINTER_SUFFIX
 from .error import QAPISourceError, QAPISemError
 from .expr import check_exprs
-from .parser import QAPISchemaParser
+from .parser import QAPIDoc, QAPISchemaParser, ParsedExpression
+from .source import QAPISourceInfo
 
 
 class Visitable:
@@ -32,13 +44,18 @@ def visit(self, visitor: 'QAPISchemaVisitor') -> None:
 
 
 class QAPISchemaEntity(Visitable):
-    def __init__(self, name: str, info, doc, ifcond=None, features=None):
+    def __init__(self,
+                 name: str,
+                 info: Optional[QAPISourceInfo],
+                 doc: Optional[QAPIDoc],
+                 ifcond: Optional[Union[List[str], 'QAPISchemaType']] = None,
+                 features: Optional[List['QAPISchemaFeature']] = None):
         assert name is None or isinstance(name, str)
         for f in features or []:
             assert isinstance(f, QAPISchemaFeature)
             f.set_defined_in(name)
         self.name = name
-        self._module = None
+        self._module: Optional[QAPISchemaModule] = None
         # For explicitly defined entities, info points to the (explicit)
         # definition.  For builtins (and their arrays), info is None.
         # For implicitly defined entities, info points to a place that
@@ -59,105 +76,151 @@ def meta(self) -> str:
     def meta(self, value: str) -> None:
         self._meta = value
 
-    def c_name(self):
+    def c_name(self) -> str:
         return c_name(self.name)
 
-    def check(self, schema):
+    def check(self, schema: 'QAPISchema') -> None:
         assert not self._checked
-        seen = {}
+        seen: Dict[str, 'QAPISchemaMember'] = {}
         for f in self.features:
             f.check_clash(self.info, seen)
         self._checked = True
 
-    def connect_doc(self, doc=None):
+    def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         doc = doc or self.doc
         if doc:
             for f in self.features:
                 doc.connect_feature(f)
 
-    def check_doc(self):
+    def check_doc(self) -> None:
         if self.doc:
             self.doc.check()
 
-    def _set_module(self, schema, info):
+    def _set_module(self,
+                    schema: 'QAPISchema',
+                    info: Optional[QAPISourceInfo]) -> None:
         assert self._checked
         self._module = schema.module_by_fname(info.fname if info else None)
         self._module.add_entity(self)
 
-    def set_module(self, schema):
+    def set_module(self, schema: 'QAPISchema') -> None:
         self._set_module(schema, self.info)
 
     @property
-    def ifcond(self):
+    def ifcond(self) -> List[str]:
         assert self._checked and isinstance(self._ifcond, list)
         return self._ifcond
 
-    def is_implicit(self):
+    def is_implicit(self) -> bool:
         return not self.info
 
-    def visit(self, visitor):
+    def visit(self, visitor: 'QAPISchemaVisitor') -> None:
         assert self._checked
 
-    def describe(self):
+    def describe(self) -> str:
         assert self.meta
         return "%s '%s'" % (self.meta, self.name)
 
 
 class QAPISchemaVisitor:
-    def visit_begin(self, schema):
+    def visit_begin(self, schema: 'QAPISchema') -> None:
         pass
 
-    def visit_end(self):
+    def visit_end(self) -> None:
         pass
 
-    def visit_module(self, name):
+    def visit_module(self, name: Optional[str]) -> None:
         pass
 
-    def visit_needed(self, entity):
+    def visit_needed(self, entity: QAPISchemaEntity) -> bool:
         # Default to visiting everything
         return True
 
-    def visit_include(self, name, info):
+    def visit_include(self, name: str, info: QAPISourceInfo) -> None:
         pass
 
-    def visit_builtin_type(self, name, info, json_type):
+    def visit_builtin_type(self, name: str,
+                           info: Optional[QAPISourceInfo],
+                           json_type: str) -> None:
         pass
 
-    def visit_enum_type(self, name, info, ifcond, features, members, prefix):
+    def visit_enum_type(self,
+                        name: str,
+                        info: Optional[QAPISourceInfo],
+                        ifcond: List[str],
+                        features: List['QAPISchemaFeature'],
+                        members: List['QAPISchemaEnumMember'],
+                        prefix: Optional[str]) -> None:
         pass
 
-    def visit_array_type(self, name, info, ifcond, element_type):
+    def visit_array_type(self,
+                         name: str,
+                         info: Optional[QAPISourceInfo],
+                         ifcond: List[str],
+                         element_type: 'QAPISchemaType') -> None:
         pass
 
-    def visit_object_type(self, name, info, ifcond, features,
-                          base, members, variants):
+    def visit_object_type(self,
+                          name: str,
+                          info: Optional[QAPISourceInfo],
+                          ifcond: List[str],
+                          features: List['QAPISchemaFeature'],
+                          base: Optional['QAPISchemaObjectType'],
+                          members: List['QAPISchemaObjectTypeMember'],
+                          variants: Optional['QAPISchemaVariants']) -> None:
         pass
 
-    def visit_object_type_flat(self, name, info, ifcond, features,
-                               members, variants):
+    def visit_object_type_flat(self,
+                               name: str,
+                               info: Optional[QAPISourceInfo],
+                               ifcond: List[str],
+                               features: List['QAPISchemaFeature'],
+                               members: List['QAPISchemaObjectTypeMember'],
+                               variants: Optional['QAPISchemaVariants'],
+                               ) -> None:
         pass
 
-    def visit_alternate_type(self, name, info, ifcond, features, variants):
+    def visit_alternate_type(self,
+                             name: str,
+                             info: QAPISourceInfo,
+                             ifcond: List[str],
+                             features: List['QAPISchemaFeature'],
+                             variants: 'QAPISchemaVariants') -> None:
         pass
 
-    def visit_command(self, name, info, ifcond, features,
-                      arg_type, ret_type, gen, success_response, boxed,
-                      allow_oob, allow_preconfig):
+    def visit_command(self,
+                      name: str,
+                      info: QAPISourceInfo,
+                      ifcond: List[str],
+                      features: List['QAPISchemaFeature'],
+                      arg_type: 'QAPISchemaObjectType',
+                      ret_type: Optional['QAPISchemaType'],
+                      gen: bool,
+                      success_response: bool,
+                      boxed: bool,
+                      allow_oob: bool,
+                      allow_preconfig: bool) -> None:
         pass
 
-    def visit_event(self, name, info, ifcond, features, arg_type, boxed):
+    def visit_event(self,
+                    name: str,
+                    info: QAPISourceInfo,
+                    ifcond: List[str],
+                    features: List['QAPISchemaFeature'],
+                    arg_type: 'QAPISchemaObjectType',
+                    boxed: bool) -> None:
         pass
 
 
 class QAPISchemaModule(Visitable):
-    def __init__(self, name):
+    def __init__(self, name: Optional[str]):
         self.name = name
-        self._entity_list = []
+        self._entity_list: List[QAPISchemaEntity] = []
 
-    def add_entity(self, ent):
+    def add_entity(self, ent: QAPISchemaEntity) -> None:
         self._entity_list.append(ent)
 
-    def visit(self, visitor):
+    def visit(self, visitor: QAPISchemaVisitor) -> None:
         visitor.visit_module(self.name)
         for entity in self._entity_list:
             if visitor.visit_needed(entity):
@@ -165,11 +228,11 @@ def visit(self, visitor):
 
 
 class QAPISchemaInclude(QAPISchemaEntity):
-    def __init__(self, sub_module, info):
+    def __init__(self, sub_module: QAPISchemaModule, info: QAPISourceInfo):
         super().__init__(None, info, None)
         self._sub_module = sub_module
 
-    def visit(self, visitor):
+    def visit(self, visitor: QAPISchemaVisitor) -> None:
         super().visit(visitor)
         visitor.visit_include(self._sub_module.name, self.info)
 
@@ -181,17 +244,17 @@ def c_type(self) -> str:
         raise NotImplementedError()
 
     # Return the C type to be used in a parameter list.
-    def c_param_type(self):
+    def c_param_type(self) -> str:
         return self.c_type()
 
     # Return the C type to be used where we suppress boxing.
-    def c_unboxed_type(self):
+    def c_unboxed_type(self) -> str:
         return self.c_type()
 
     def json_type(self) -> str:
         raise NotImplementedError()
 
-    def alternate_qtype(self):
+    def alternate_qtype(self) -> str:
         json2qtype = {
             'null':    'QTYPE_QNULL',
             'string':  'QTYPE_QSTRING',
@@ -202,24 +265,24 @@ def alternate_qtype(self):
         }
         return json2qtype[self.json_type()]
 
-    def doc_type(self):
+    def doc_type(self) -> Optional[str]:
         if self.is_implicit():
             return None
         return self.name
 
-    def check(self, schema):
+    def check(self, schema: 'QAPISchema') -> None:
         QAPISchemaEntity.check(self, schema)
         if 'deprecated' in [f.name for f in self.features]:
             raise QAPISemError(
                 self.info, "feature 'deprecated' is not supported for types")
 
-    def describe(self):
+    def describe(self) -> str:
         assert self.meta
         return "%s type '%s'" % (self.meta, self.name)
 
 
 class QAPISchemaBuiltinType(QAPISchemaType):
-    def __init__(self, name, json_type, c_type):
+    def __init__(self, name: str, json_type: str, c_type: str):
         super().__init__(name, None, None)
         assert not c_type or isinstance(c_type, str)
         assert json_type in ('string', 'number', 'int', 'boolean', 'null',
@@ -228,30 +291,37 @@ def __init__(self, name, json_type, c_type):
         self._c_type_name = c_type
         self._meta = 'built-in'
 
-    def c_name(self):
+    def c_name(self) -> str:
         return self.name
 
-    def c_type(self):
+    def c_type(self) -> str:
         return self._c_type_name
 
-    def c_param_type(self):
+    def c_param_type(self) -> str:
         if self.name == 'str':
             return 'const ' + self._c_type_name
         return self._c_type_name
 
-    def json_type(self):
+    def json_type(self) -> str:
         return self._json_type_name
 
-    def doc_type(self):
+    def doc_type(self) -> str:
         return self.json_type()
 
-    def visit(self, visitor):
+    def visit(self, visitor: QAPISchemaVisitor) -> None:
         super().visit(visitor)
         visitor.visit_builtin_type(self.name, self.info, self.json_type())
 
 
 class QAPISchemaEnumType(QAPISchemaType):
-    def __init__(self, name, info, doc, ifcond, features, members, prefix):
+    def __init__(self,
+                 name: str,
+                 info: Optional[QAPISourceInfo],
+                 doc: Optional[QAPIDoc],
+                 ifcond: Optional[List[str]],
+                 features: Optional[List['QAPISchemaFeature']],
+                 members: List['QAPISchemaEnumMember'],
+                 prefix: Optional[str]):
         super().__init__(name, info, doc, ifcond, features)
         for m in members:
             assert isinstance(m, QAPISchemaEnumMember)
@@ -261,32 +331,32 @@ def __init__(self, name, info, doc, ifcond, features, members, prefix):
         self.prefix = prefix
         self._meta = 'enum'
 
-    def check(self, schema):
+    def check(self, schema: 'QAPISchema') -> None:
         super().check(schema)
-        seen = {}
+        seen: Dict[str, 'QAPISchemaMember'] = {}
         for m in self.members:
             m.check_clash(self.info, seen)
 
-    def connect_doc(self, doc=None):
+    def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         super().connect_doc(doc)
         doc = doc or self.doc
         for m in self.members:
             m.connect_doc(doc)
 
-    def is_implicit(self):
+    def is_implicit(self) -> bool:
         # See QAPISchema._make_implicit_enum_type() and ._def_predefineds()
         return self.name.endswith('Kind') or self.name == 'QType'
 
-    def c_type(self):
+    def c_type(self) -> str:
         return c_name(self.name)
 
-    def member_names(self):
+    def member_names(self) -> List[str]:
         return [m.name for m in self.members]
 
-    def json_type(self):
+    def json_type(self) -> str:
         return 'string'
 
-    def visit(self, visitor):
+    def visit(self, visitor: QAPISchemaVisitor) -> None:
         super().visit(visitor)
         visitor.visit_enum_type(
             self.name, self.info, self.ifcond, self.features,
@@ -294,56 +364,65 @@ def visit(self, visitor):
 
 
 class QAPISchemaArrayType(QAPISchemaType):
-    def __init__(self, name, info, element_type):
+    def __init__(self, name: str,
+                 info: Optional[QAPISourceInfo],
+                 element_type: str):
         super().__init__(name, info, None)
         assert isinstance(element_type, str)
         self._element_type_name = element_type
-        self.element_type = None
+        self.element_type: Optional[QAPISchemaType] = None
         self._meta = 'array'
 
-    def check(self, schema):
+    def check(self, schema: 'QAPISchema') -> None:
         super().check(schema)
         self.element_type = schema.resolve_type(
             self._element_type_name, self.info,
             self.info.defn_meta if self.info else None)
         assert not isinstance(self.element_type, QAPISchemaArrayType)
 
-    def set_module(self, schema):
+    def set_module(self, schema: 'QAPISchema') -> None:
         self._set_module(schema, self.element_type.info)
 
     @property
-    def ifcond(self):
+    def ifcond(self) -> List[str]:
         assert self._checked
         return self.element_type.ifcond
 
-    def is_implicit(self):
+    def is_implicit(self) -> bool:
         return True
 
-    def c_type(self):
+    def c_type(self) -> str:
         return c_name(self.name) + POINTER_SUFFIX
 
-    def json_type(self):
+    def json_type(self) -> str:
         return 'array'
 
-    def doc_type(self):
+    def doc_type(self) -> Optional[str]:
         elt_doc_type = self.element_type.doc_type()
         if not elt_doc_type:
             return None
         return 'array of ' + elt_doc_type
 
-    def visit(self, visitor):
+    def visit(self, visitor: QAPISchemaVisitor) -> None:
         super().visit(visitor)
         visitor.visit_array_type(self.name, self.info, self.ifcond,
                                  self.element_type)
 
-    def describe(self):
+    def describe(self) -> str:
         assert self.meta
         return "%s type ['%s']" % (self.meta, self._element_type_name)
 
 
 class QAPISchemaObjectType(QAPISchemaType):
-    def __init__(self, name, info, doc, ifcond, features,
-                 base, local_members, variants):
+    def __init__(self,
+                 name: str,
+                 info: Optional[QAPISourceInfo],
+                 doc: Optional[QAPIDoc],
+                 ifcond: Optional['QAPISchemaType'],
+                 features: Optional[List['QAPISchemaFeature']],
+                 base: Optional[str],
+                 local_members: List['QAPISchemaObjectTypeMember'],
+                 variants: Optional['QAPISchemaVariants']):
         # struct has local_members, optional base, and no variants
         # flat union has base, variants, and no local_members
         # simple union has local_members, variants, and no base
@@ -357,12 +436,12 @@ def __init__(self, name, info, doc, ifcond, features,
             assert isinstance(variants, QAPISchemaVariants)
             variants.set_defined_in(name)
         self._base_name = base
-        self.base = None
+        self.base: Optional[QAPISchemaObjectType] = None
         self.local_members = local_members
         self.variants = variants
-        self.members = None
+        self.members: Optional[List[QAPISchemaObjectTypeMember]] = None
 
-    def check(self, schema):
+    def check(self, schema: 'QAPISchema') -> None:
         # This calls another type T's .check() exactly when the C
         # struct emitted by gen_object() contains that T's C struct
         # (pointers don't count).
@@ -377,7 +456,7 @@ def check(self, schema):
         super().check(schema)
         assert self._checked and self.members is None
 
-        seen = OrderedDict()
+        seen: Dict[str, 'QAPISchemaMember'] = OrderedDict()
         if self._base_name:
             base = schema.resolve_type(self._base_name, self.info, "'base'")
             if (not isinstance(base, QAPISchemaObjectType)
@@ -406,13 +485,15 @@ def check(self, schema):
     # Check that the members of this type do not cause duplicate JSON members,
     # and update seen to track the members seen so far. Report any errors
     # on behalf of info, which is not necessarily self.info
-    def check_clash(self, info, seen):
+    def check_clash(self,
+                    info: QAPISourceInfo,
+                    seen: Dict[str, 'QAPISchemaMember']) -> None:
         assert self._checked
         assert not self.variants       # not implemented
         for m in self.members:
             m.check_clash(info, seen)
 
-    def connect_doc(self, doc=None):
+    def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         super().connect_doc(doc)
         doc = doc or self.doc
         if self.base and self.base.is_implicit():
@@ -421,7 +502,7 @@ def connect_doc(self, doc=None):
             m.connect_doc(doc)
 
     @property
-    def ifcond(self):
+    def ifcond(self) -> List[str]:
         assert self._checked
         if isinstance(self._ifcond, QAPISchemaType):
             # Simple union wrapper type inherits from wrapped type;
@@ -429,30 +510,30 @@ def ifcond(self):
             return self._ifcond.ifcond
         return self._ifcond
 
-    def is_implicit(self):
+    def is_implicit(self) -> bool:
         # See QAPISchema._make_implicit_object_type(), as well as
         # _def_predefineds()
         return self.name.startswith('q_')
 
-    def is_empty(self):
+    def is_empty(self) -> bool:
         assert self.members is not None
         return not self.members and not self.variants
 
-    def c_name(self):
+    def c_name(self) -> str:
         assert self.name != 'q_empty'
         return super().c_name()
 
-    def c_type(self):
+    def c_type(self) -> str:
         assert not self.is_implicit()
         return c_name(self.name) + POINTER_SUFFIX
 
-    def c_unboxed_type(self):
+    def c_unboxed_type(self) -> str:
         return c_name(self.name)
 
-    def json_type(self):
+    def json_type(self) -> str:
         return 'object'
 
-    def visit(self, visitor):
+    def visit(self, visitor: QAPISchemaVisitor) -> None:
         super().visit(visitor)
         visitor.visit_object_type(
             self.name, self.info, self.ifcond, self.features,
@@ -463,7 +544,13 @@ def visit(self, visitor):
 
 
 class QAPISchemaAlternateType(QAPISchemaType):
-    def __init__(self, name, info, doc, ifcond, features, variants):
+    def __init__(self,
+                 name: str,
+                 info: QAPISourceInfo,
+                 doc: QAPIDoc,
+                 ifcond: Optional[List[str]],
+                 features: List['QAPISchemaFeature'],
+                 variants: 'QAPISchemaVariants'):
         super().__init__(name, info, doc, ifcond, features)
         assert isinstance(variants, QAPISchemaVariants)
         assert variants.tag_member
@@ -472,7 +559,7 @@ def __init__(self, name, info, doc, ifcond, features, variants):
         self.variants = variants
         self._meta = 'alternate'
 
-    def check(self, schema):
+    def check(self, schema: 'QAPISchema') -> None:
         super().check(schema)
         self.variants.tag_member.check(schema)
         # Not calling self.variants.check_clash(), because there's nothing
@@ -480,8 +567,8 @@ def check(self, schema):
         self.variants.check(schema, {})
         # Alternate branch names have no relation to the tag enum values;
         # so we have to check for potential name collisions ourselves.
-        seen = {}
-        types_seen = {}
+        seen: Dict[str, QAPISchemaMember] = {}
+        types_seen: Dict[str, str] = {}
         for v in self.variants.variants:
             v.check_clash(self.info, seen)
             try:
@@ -511,26 +598,30 @@ def check(self, schema):
                         % (v.describe(self.info), types_seen[qt]))
                 types_seen[qt] = v.name
 
-    def connect_doc(self, doc=None):
+    def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         super().connect_doc(doc)
         doc = doc or self.doc
         for v in self.variants.variants:
             v.connect_doc(doc)
 
-    def c_type(self):
+    def c_type(self) -> str:
         return c_name(self.name) + POINTER_SUFFIX
 
-    def json_type(self):
+    def json_type(self) -> str:
         return 'value'
 
-    def visit(self, visitor):
+    def visit(self, visitor: QAPISchemaVisitor) -> None:
         super().visit(visitor)
         visitor.visit_alternate_type(
             self.name, self.info, self.ifcond, self.features, self.variants)
 
 
 class QAPISchemaVariants:
-    def __init__(self, tag_name, info, tag_member, variants):
+    def __init__(self,
+                 tag_name: Optional[str],
+                 info: QAPISourceInfo,
+                 tag_member: Optional['QAPISchemaObjectTypeMember'],
+                 variants: List['QAPISchemaVariant']):
         # Flat unions pass tag_name but not tag_member.
         # Simple unions and alternates pass tag_member but not tag_name.
         # After check(), tag_member is always set, and tag_name remains
@@ -545,11 +636,13 @@ def __init__(self, tag_name, info, tag_member, variants):
         self.tag_member = tag_member
         self.variants = variants
 
-    def set_defined_in(self, name):
+    def set_defined_in(self, name: str) -> None:
         for v in self.variants:
             v.set_defined_in(name)
 
-    def check(self, schema, seen):
+    def check(self,
+              schema: 'QAPISchema',
+              seen: Dict[str, 'QAPISchemaMember']) -> None:
         if not self.tag_member:  # flat union
             tag_member = seen.get(c_name(self._tag_name))
             base = "'base'"
@@ -616,7 +709,9 @@ def check(self, schema, seen):
                         % (v.describe(self.info), v.type.describe()))
                 v.type.check(schema)
 
-    def check_clash(self, info, seen):
+    def check_clash(self,
+                    info: QAPISourceInfo,
+                    seen: Dict[str, 'QAPISchemaMember']) -> None:
         for v in self.variants:
             # Reset seen map for each variant, since qapi names from one
             # branch do not affect another branch
@@ -628,18 +723,22 @@ class QAPISchemaMember:
     """ Represents object members, enum members and features """
     role = 'member'
 
-    def __init__(self, name, info, ifcond=None):
+    def __init__(self, name: str,
+                 info: Optional[QAPISourceInfo],
+                 ifcond: Optional[List[str]] = None):
         assert isinstance(name, str)
         self.name = name
         self.info = info
         self.ifcond = ifcond or []
-        self.defined_in = None
+        self.defined_in: Optional[str] = None
 
-    def set_defined_in(self, name):
+    def set_defined_in(self, name: str) -> None:
         assert not self.defined_in
         self.defined_in = name
 
-    def check_clash(self, info, seen):
+    def check_clash(self,
+                    info: Optional[QAPISourceInfo],
+                    seen: Dict[str, 'QAPISchemaMember']) -> None:
         cname = c_name(self.name)
         if cname in seen:
             raise QAPISemError(
@@ -648,11 +747,11 @@ def check_clash(self, info, seen):
                 % (self.describe(info), seen[cname].describe(info)))
         seen[cname] = self
 
-    def connect_doc(self, doc):
+    def connect_doc(self, doc: Optional[QAPIDoc]) -> None:
         if doc:
             doc.connect_member(self)
 
-    def describe(self, info):
+    def describe(self, info: QAPISourceInfo) -> str:
         role = self.role
         defined_in = self.defined_in
         assert defined_in
@@ -692,7 +791,13 @@ class QAPISchemaFeature(QAPISchemaMember):
 
 
 class QAPISchemaObjectTypeMember(QAPISchemaMember):
-    def __init__(self, name, info, typ, optional, ifcond=None, features=None):
+    def __init__(self,
+                 name: str,
+                 info: QAPISourceInfo,
+                 typ: str,
+                 optional: bool,
+                 ifcond: Optional[List[str]] = None,
+                 features: Optional[List[QAPISchemaFeature]] = None):
         super().__init__(name, info, ifcond)
         assert isinstance(typ, str)
         assert isinstance(optional, bool)
@@ -700,19 +805,19 @@ def __init__(self, name, info, typ, optional, ifcond=None, features=None):
             assert isinstance(f, QAPISchemaFeature)
             f.set_defined_in(name)
         self._type_name = typ
-        self.type = None
+        self.type: Optional[QAPISchemaType] = None
         self.optional = optional
         self.features = features or []
 
-    def check(self, schema):
+    def check(self, schema: 'QAPISchema') -> None:
         assert self.defined_in
         self.type = schema.resolve_type(self._type_name, self.info,
                                         self.describe)
-        seen = {}
+        seen: Dict[str, QAPISchemaMember] = {}
         for f in self.features:
             f.check_clash(self.info, seen)
 
-    def connect_doc(self, doc):
+    def connect_doc(self, doc: Optional[QAPIDoc]) -> None:
         super().connect_doc(doc)
         if doc:
             for f in self.features:
@@ -722,21 +827,35 @@ def connect_doc(self, doc):
 class QAPISchemaVariant(QAPISchemaObjectTypeMember):
     role = 'branch'
 
-    def __init__(self, name, info, typ, ifcond=None):
+    def __init__(self,
+                 name: str,
+                 info: QAPISourceInfo,
+                 typ: str,
+                 ifcond: Optional[List[str]] = None):
         super().__init__(name, info, typ, False, ifcond)
 
 
 class QAPISchemaCommand(QAPISchemaEntity):
-    def __init__(self, name, info, doc, ifcond, features,
-                 arg_type, ret_type,
-                 gen, success_response, boxed, allow_oob, allow_preconfig):
+    def __init__(self,
+                 name: str,
+                 info: QAPISourceInfo,
+                 doc: QAPIDoc,
+                 ifcond: Optional[List[str]],
+                 features: List[QAPISchemaFeature],
+                 arg_type: str,
+                 ret_type: Optional[str],
+                 gen: bool,
+                 success_response: bool,
+                 boxed: bool,
+                 allow_oob: bool,
+                 allow_preconfig: bool):
         super().__init__(name, info, doc, ifcond, features)
         assert not arg_type or isinstance(arg_type, str)
         assert not ret_type or isinstance(ret_type, str)
         self._arg_type_name = arg_type
-        self.arg_type = None
+        self.arg_type: Optional[QAPISchemaObjectType] = None
         self._ret_type_name = ret_type
-        self.ret_type = None
+        self.ret_type: Optional[QAPISchemaType] = None
         self.gen = gen
         self.success_response = success_response
         self.boxed = boxed
@@ -744,7 +863,7 @@ def __init__(self, name, info, doc, ifcond, features,
         self.allow_preconfig = allow_preconfig
         self._meta = 'command'
 
-    def check(self, schema):
+    def check(self, schema: 'QAPISchema') -> None:
         super().check(schema)
         if self._arg_type_name:
             arg_type = schema.resolve_type(
@@ -774,14 +893,14 @@ def check(self, schema):
                         "command's 'returns' cannot take %s"
                         % self.ret_type.describe())
 
-    def connect_doc(self, doc=None):
+    def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         super().connect_doc(doc)
         doc = doc or self.doc
         if doc:
             if self.arg_type and self.arg_type.is_implicit():
                 self.arg_type.connect_doc(doc)
 
-    def visit(self, visitor):
+    def visit(self, visitor: QAPISchemaVisitor) -> None:
         super().visit(visitor)
         visitor.visit_command(
             self.name, self.info, self.ifcond, self.features,
@@ -790,15 +909,22 @@ def visit(self, visitor):
 
 
 class QAPISchemaEvent(QAPISchemaEntity):
-    def __init__(self, name, info, doc, ifcond, features, arg_type, boxed):
+    def __init__(self,
+                 name: str,
+                 info: QAPISourceInfo,
+                 doc: QAPIDoc,
+                 ifcond: Optional[List[str]],
+                 features: List[QAPISchemaFeature],
+                 arg_type: str,
+                 boxed: bool):
         super().__init__(name, info, doc, ifcond, features)
         assert not arg_type or isinstance(arg_type, str)
         self._arg_type_name = arg_type
-        self.arg_type = None
+        self.arg_type: Optional[QAPISchemaObjectType] = None
         self.boxed = boxed
         self._meta = 'event'
 
-    def check(self, schema):
+    def check(self, schema: 'QAPISchema') -> None:
         super().check(schema)
         if self._arg_type_name:
             arg_type = schema.resolve_type(
@@ -815,29 +941,32 @@ def check(self, schema):
                     "event's 'data' can take %s only with 'boxed': true"
                     % self.arg_type.describe())
 
-    def connect_doc(self, doc=None):
+    def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         super().connect_doc(doc)
         doc = doc or self.doc
         if doc:
             if self.arg_type and self.arg_type.is_implicit():
                 self.arg_type.connect_doc(doc)
 
-    def visit(self, visitor):
+    def visit(self, visitor: QAPISchemaVisitor) -> None:
         super().visit(visitor)
         visitor.visit_event(
             self.name, self.info, self.ifcond, self.features,
             self.arg_type, self.boxed)
 
 
+_EntityType = TypeVar('_EntityType', bound=QAPISchemaEntity)
+
+
 class QAPISchema(Visitable):
-    def __init__(self, fname):
+    def __init__(self, fname: str):
         self.fname = fname
         parser = QAPISchemaParser(fname)
         exprs = check_exprs(parser.exprs)
         self.docs = parser.docs
-        self._entity_list = []
-        self._entity_dict = {}
-        self._module_dict = OrderedDict()
+        self._entity_list: List[QAPISchemaEntity] = []
+        self._entity_dict: Dict[str, QAPISchemaEntity] = {}
+        self._module_dict: Dict[str, QAPISchemaModule] = OrderedDict()
         self._schema_dir = os.path.dirname(fname)
         self._make_module(None)  # built-ins
         self._make_module(fname)
@@ -847,7 +976,7 @@ def __init__(self, fname):
         self._def_exprs(exprs)
         self.check()
 
-    def _def_entity(self, ent):
+    def _def_entity(self, ent: QAPISchemaEntity) -> None:
         # Only the predefined types are allowed to not have info
         assert ent.info or self._predefining
         self._entity_list.append(ent)
@@ -866,16 +995,33 @@ def _def_entity(self, ent):
                 ent.info, "%s is already defined" % other_ent.describe())
         self._entity_dict[ent.name] = ent
 
-    def lookup_entity(self, name, typ=None):
+    @overload
+    def lookup_entity(self, name: str,
+                      typ: None = None) -> Optional[QAPISchemaEntity]: ...
+
+    @overload
+    def lookup_entity(self, name: str,
+                      typ: Type[_EntityType]) -> Optional[_EntityType]: ...
+
+    def lookup_entity(self,
+                      name: str,
+                      typ: Optional[Type[QAPISchemaEntity]] = None,
+                      ) -> Optional[QAPISchemaEntity]:
         ent = self._entity_dict.get(name)
         if typ and not isinstance(ent, typ):
             return None
         return ent
 
-    def lookup_type(self, name):
+    def lookup_type(self, name: str) -> QAPISchemaType:
         return self.lookup_entity(name, QAPISchemaType)
 
-    def resolve_type(self, name, info, what):
+    def resolve_type(self,
+                     name: str,
+                     info: Optional[QAPISourceInfo],
+                     what: Optional[
+                         Union[str, Callable[[Optional[QAPISourceInfo]], str]]
+                     ],
+                     ) -> QAPISchemaType:
         typ = self.lookup_type(name)
         if not typ:
             if callable(what):
@@ -884,27 +1030,33 @@ def resolve_type(self, name, info, what):
                 info, "%s uses unknown type '%s'" % (what, name))
         return typ
 
-    def _module_name(self, fname):
+    def _module_name(self, fname: Optional[str]) -> Optional[str]:
         if fname is None:
             return None
         return os.path.relpath(fname, self._schema_dir)
 
-    def _make_module(self, fname):
+    def _make_module(self, fname: Optional[str]) -> QAPISchemaModule:
         name = self._module_name(fname)
         if name not in self._module_dict:
             self._module_dict[name] = QAPISchemaModule(name)
         return self._module_dict[name]
 
-    def module_by_fname(self, fname):
+    def module_by_fname(self, fname: Optional[str]) -> QAPISchemaModule:
         name = self._module_name(fname)
         return self._module_dict[name]
 
-    def _def_include(self, expr, info, doc):
+    def _def_include(self,
+                     expr: Dict[str, Any],
+                     info: QAPISourceInfo,
+                     doc: Optional[QAPIDoc]) -> None:
         include = expr['include']
         assert doc is None
         self._def_entity(QAPISchemaInclude(self._make_module(include), info))
 
-    def _def_builtin_type(self, name, json_type, c_type):
+    def _def_builtin_type(self,
+                          name: str,
+                          json_type: str,
+                          c_type: str) -> None:
         self._def_entity(QAPISchemaBuiltinType(name, json_type, c_type))
         # Instantiating only the arrays that are actually used would
         # be nice, but we can't as long as their generated code
@@ -912,7 +1064,7 @@ def _def_builtin_type(self, name, json_type, c_type):
         # schema.
         self._make_array_type(name, None)
 
-    def _def_predefineds(self):
+    def _def_predefineds(self) -> None:
         for t in [('str',    'string',  'char' + POINTER_SUFFIX),
                   ('number', 'number',  'double'),
                   ('int',    'int',     'int64_t'),
@@ -941,17 +1093,26 @@ def _def_predefineds(self):
         self._def_entity(QAPISchemaEnumType('QType', None, None, None, None,
                                             qtype_values, 'QTYPE'))
 
-    def _make_features(self, features, info):
+    def _make_features(self,
+                       features: Optional[List[Dict[str, Any]]],
+                       info: QAPISourceInfo) -> List[QAPISchemaFeature]:
         if features is None:
             return []
         return [QAPISchemaFeature(f['name'], info, f.get('if'))
                 for f in features]
 
-    def _make_enum_members(self, values, info):
+    def _make_enum_members(self,
+                           values: List[Dict[str, Any]],
+                           info: Optional[QAPISourceInfo],
+                           ) -> List[QAPISchemaEnumMember]:
         return [QAPISchemaEnumMember(v['name'], info, v.get('if'))
                 for v in values]
 
-    def _make_implicit_enum_type(self, name, info, ifcond, values):
+    def _make_implicit_enum_type(self,
+                                 name: str,
+                                 info: QAPISourceInfo,
+                                 ifcond: Optional[List[str]],
+                                 values: List[Dict[str, Any]]) -> str:
         # See also QAPISchemaObjectTypeMember.describe()
         name = name + 'Kind'    # reserved by check_defn_name_str()
         self._def_entity(QAPISchemaEnumType(
@@ -960,13 +1121,21 @@ def _make_implicit_enum_type(self, name, info, ifcond, values):
             None))
         return name
 
-    def _make_array_type(self, element_type, info):
+    def _make_array_type(self,
+                         element_type: str,
+                         info: QAPISourceInfo) -> str:
         name = element_type + 'List'    # reserved by check_defn_name_str()
         if not self.lookup_type(name):
             self._def_entity(QAPISchemaArrayType(name, info, element_type))
         return name
 
-    def _make_implicit_object_type(self, name, info, ifcond, role, members):
+    def _make_implicit_object_type(self,
+                                   name: str,
+                                   info: QAPISourceInfo,
+                                   ifcond: Optional[QAPISchemaType],
+                                   role: str,
+                                   members: List[QAPISchemaObjectTypeMember],
+                                   ) -> Optional[str]:
         if not members:
             return None
         # See also QAPISchemaObjectTypeMember.describe()
@@ -990,7 +1159,10 @@ def _make_implicit_object_type(self, name, info, ifcond, role, members):
                 name, info, None, ifcond, None, None, members, None))
         return name
 
-    def _def_enum_type(self, expr, info, doc):
+    def _def_enum_type(self,
+                       expr: Dict[str, Any],
+                       info: QAPISourceInfo,
+                       doc: QAPIDoc) -> None:
         name = expr['enum']
         data = expr['data']
         prefix = expr.get('prefix')
@@ -1000,7 +1172,12 @@ def _def_enum_type(self, expr, info, doc):
             name, info, doc, ifcond, features,
             self._make_enum_members(data, info), prefix))
 
-    def _make_member(self, name, typ, ifcond, features, info):
+    def _make_member(self,
+                     name: str,
+                     typ: str,
+                     ifcond: Optional[List[str]],
+                     features: Optional[List[Dict[str, Any]]],
+                     info: QAPISourceInfo) -> QAPISchemaObjectTypeMember:
         optional = False
         if name.startswith('*'):
             name = name[1:]
@@ -1011,12 +1188,18 @@ def _make_member(self, name, typ, ifcond, features, info):
         return QAPISchemaObjectTypeMember(name, info, typ, optional, ifcond,
                                           self._make_features(features, info))
 
-    def _make_members(self, data, info):
+    def _make_members(self,
+                      data: Dict[str, Dict[str, Any]],
+                      info: QAPISourceInfo,
+                      ) -> List[QAPISchemaObjectTypeMember]:
         return [self._make_member(key, value['type'], value.get('if'),
                                   value.get('features'), info)
                 for (key, value) in data.items()]
 
-    def _def_struct_type(self, expr, info, doc):
+    def _def_struct_type(self,
+                         expr: Dict[str, Any],
+                         info: QAPISourceInfo,
+                         doc: QAPIDoc) -> None:
         name = expr['struct']
         base = expr.get('base')
         data = expr['data']
@@ -1027,10 +1210,18 @@ def _def_struct_type(self, expr, info, doc):
             self._make_members(data, info),
             None))
 
-    def _make_variant(self, case, typ, ifcond, info):
+    def _make_variant(self,
+                      case: str,
+                      typ: str,
+                      ifcond: Optional[List[str]],
+                      info: QAPISourceInfo) -> QAPISchemaVariant:
         return QAPISchemaVariant(case, info, typ, ifcond)
 
-    def _make_simple_variant(self, case, typ, ifcond, info):
+    def _make_simple_variant(self,
+                             case: str,
+                             typ: str,
+                             ifcond: Optional[List[str]],
+                             info: QAPISourceInfo) -> QAPISchemaVariant:
         if isinstance(typ, list):
             assert len(typ) == 1
             typ = self._make_array_type(typ[0], info)
@@ -1039,7 +1230,10 @@ def _make_simple_variant(self, case, typ, ifcond, info):
             'wrapper', [self._make_member('data', typ, None, None, info)])
         return QAPISchemaVariant(case, info, typ, ifcond)
 
-    def _def_union_type(self, expr, info, doc):
+    def _def_union_type(self,
+                        expr: Dict[str, Any],
+                        info: QAPISourceInfo,
+                        doc: QAPIDoc) -> None:
         name = expr['union']
         data = expr['data']
         base = expr.get('base')
@@ -1070,7 +1264,10 @@ def _def_union_type(self, expr, info, doc):
                                  QAPISchemaVariants(
                                      tag_name, info, tag_member, variants)))
 
-    def _def_alternate_type(self, expr, info, doc):
+    def _def_alternate_type(self,
+                            expr: Dict[str, Any],
+                            info: QAPISourceInfo,
+                            doc: QAPIDoc) -> None:
         name = expr['alternate']
         data = expr['data']
         ifcond = expr.get('if')
@@ -1084,7 +1281,10 @@ def _def_alternate_type(self, expr, info, doc):
                                     QAPISchemaVariants(
                                         None, info, tag_member, variants)))
 
-    def _def_command(self, expr, info, doc):
+    def _def_command(self,
+                     expr: Dict[str, Any],
+                     info: QAPISourceInfo,
+                     doc: QAPIDoc) -> None:
         name = expr['command']
         data = expr.get('data')
         rets = expr.get('returns')
@@ -1107,7 +1307,10 @@ def _def_command(self, expr, info, doc):
                                            gen, success_response,
                                            boxed, allow_oob, allow_preconfig))
 
-    def _def_event(self, expr, info, doc):
+    def _def_event(self,
+                   expr: Dict[str, Any],
+                   info: QAPISourceInfo,
+                   doc: QAPIDoc) -> None:
         name = expr['event']
         data = expr.get('data')
         boxed = expr.get('boxed', False)
@@ -1120,7 +1323,7 @@ def _def_event(self, expr, info, doc):
         self._def_entity(QAPISchemaEvent(name, info, doc, ifcond, features,
                                          data, boxed))
 
-    def _def_exprs(self, exprs):
+    def _def_exprs(self, exprs: List[ParsedExpression]) -> None:
         for expr_elem in exprs:
             expr = expr_elem.expr
             info = expr_elem.info
@@ -1142,7 +1345,7 @@ def _def_exprs(self, exprs):
             else:
                 assert False
 
-    def check(self):
+    def check(self) -> None:
         for ent in self._entity_list:
             ent.check(self)
             ent.connect_doc()
@@ -1150,7 +1353,7 @@ def check(self):
         for ent in self._entity_list:
             ent.set_module(self)
 
-    def visit(self, visitor):
+    def visit(self, visitor: QAPISchemaVisitor) -> None:
         visitor.visit_begin(self)
         for mod in self._module_dict.values():
             mod.visit(visitor)
-- 
2.26.2


