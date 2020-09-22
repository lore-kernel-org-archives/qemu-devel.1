Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663E8C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:59:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBBEC221EB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxCwp2rA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBBEC221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKrG6-0006x3-P7
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKr2o-0002SD-I0
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:45:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54601)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKr2j-0000X5-F0
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600814740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mCVr78vMIPrc4SLTY7s0f9VJQeTa3jvsqQX8yshaFD0=;
 b=SxCwp2rAW/sisFQpN0inCxzPp3ukagpByUA+l/3Zl1ycK/NTg02rTBv09exhdNgHGDwaAo
 29s6vHYJ2eb1L3fvuiBz0eToe5AjaMOPL6XLW5TIz5O7HMxZnuAoHDEiy908HCuWUAn3nJ
 tfxq68dGQH+2t208KmVhqZddvDkAf28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-OWRrEI3IOXiAhRPr-Zt4_Q-1; Tue, 22 Sep 2020 18:45:31 -0400
X-MC-Unique: OWRrEI3IOXiAhRPr-Zt4_Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3B1F801AE9;
 Tue, 22 Sep 2020 22:45:30 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C2C5C5C1A3;
 Tue, 22 Sep 2020 22:45:29 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 20/25] qapi/schema.py: Replace one-letter variable names
Date: Tue, 22 Sep 2020 18:44:56 -0400
Message-Id: <20200922224501.4087749-21-jsnow@redhat.com>
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I hope you like butter, because here comes the churn!

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 184 +++++++++++++++++++++--------------------
 1 file changed, 95 insertions(+), 89 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 2d23ce04eb..a0e047c735 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -53,9 +53,11 @@ def __init__(self,
                  ifcond: Optional[Union[List[str], 'QAPISchemaType']] = None,
                  features: Optional[List['QAPISchemaFeature']] = None):
         assert name is None or isinstance(name, str)
-        for f in features or []:
-            assert isinstance(f, QAPISchemaFeature)
-            f.set_defined_in(name)
+
+        for feature in features or []:
+            assert isinstance(feature, QAPISchemaFeature)
+            feature.set_defined_in(name)
+
         self.name = name
         self._module: Optional[QAPISchemaModule] = None
         # For explicitly defined entities, info points to the (explicit)
@@ -84,15 +86,15 @@ def c_name(self) -> str:
     def check(self, schema: 'QAPISchema') -> None:
         assert not self._checked
         seen: Dict[str, 'QAPISchemaMember'] = {}
-        for f in self.features:
-            f.check_clash(self.info, seen)
+        for feature in self.features:
+            feature.check_clash(self.info, seen)
         self._checked = True
 
     def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         doc = doc or self.doc
         if doc:
-            for f in self.features:
-                doc.connect_feature(f)
+            for feature in self.features:
+                doc.connect_feature(feature)
 
     def check_doc(self) -> None:
         if self.doc:
@@ -326,9 +328,9 @@ def __init__(self,
                  members: List['QAPISchemaEnumMember'],
                  prefix: Optional[str]):
         super().__init__(name, info, doc, ifcond, features)
-        for m in members:
-            assert isinstance(m, QAPISchemaEnumMember)
-            m.set_defined_in(name)
+        for member in members:
+            assert isinstance(member, QAPISchemaEnumMember)
+            member.set_defined_in(name)
         assert prefix is None or isinstance(prefix, str)
         self.members = members
         self.prefix = prefix
@@ -337,14 +339,14 @@ def __init__(self,
     def check(self, schema: 'QAPISchema') -> None:
         super().check(schema)
         seen: Dict[str, 'QAPISchemaMember'] = {}
-        for m in self.members:
-            m.check_clash(self.info, seen)
+        for member in self.members:
+            member.check_clash(self.info, seen)
 
     def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         super().connect_doc(doc)
         doc = doc or self.doc
-        for m in self.members:
-            m.connect_doc(doc)
+        for member in self.members:
+            member.connect_doc(doc)
 
     def is_implicit(self) -> bool:
         # See QAPISchema._make_implicit_enum_type() and ._def_predefineds()
@@ -432,9 +434,9 @@ def __init__(self,
         super().__init__(name, info, doc, ifcond, features)
         self._meta = 'union' if variants else 'struct'
         assert base is None or isinstance(base, str)
-        for m in local_members:
-            assert isinstance(m, QAPISchemaObjectTypeMember)
-            m.set_defined_in(name)
+        for member in local_members:
+            assert isinstance(member, QAPISchemaObjectTypeMember)
+            member.set_defined_in(name)
         if variants is not None:
             assert isinstance(variants, QAPISchemaVariants)
             variants.set_defined_in(name)
@@ -471,9 +473,9 @@ def check(self, schema: 'QAPISchema') -> None:
             self.base = base
             self.base.check(schema)
             self.base.check_clash(self.info, seen)
-        for m in self.local_members:
-            m.check(schema)
-            m.check_clash(self.info, seen)
+        for member in self.local_members:
+            member.check(schema)
+            member.check_clash(self.info, seen)
 
         # check_clash is abstract, but local_members is asserted to be
         # Sequence[QAPISchemaObjectTypeMember]. Cast to the narrower type.
@@ -493,16 +495,16 @@ def check_clash(self,
                     seen: Dict[str, 'QAPISchemaMember']) -> None:
         assert self._checked
         assert not self.variants       # not implemented
-        for m in self.members:
-            m.check_clash(info, seen)
+        for member in self.members:
+            member.check_clash(info, seen)
 
     def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         super().connect_doc(doc)
         doc = doc or self.doc
         if self.base and self.base.is_implicit():
             self.base.connect_doc(doc)
-        for m in self.local_members:
-            m.connect_doc(doc)
+        for member in self.local_members:
+            member.connect_doc(doc)
 
     @property
     def ifcond(self) -> List[str]:
@@ -572,40 +574,43 @@ def check(self, schema: 'QAPISchema') -> None:
         # so we have to check for potential name collisions ourselves.
         seen: Dict[str, QAPISchemaMember] = {}
         types_seen: Dict[str, str] = {}
-        for v in self.variants.variants:
-            v.check_clash(self.info, seen)
+
+        for variant in self.variants.variants:
+            variant.check_clash(self.info, seen)
+
             try:
-                qtype = v.type.alternate_qtype()
+                qtype = variant.type.alternate_qtype()
             except KeyError:
-                raise QAPISemError(
-                    self.info,
-                    "%s cannot use %s"
-                    % (v.describe(self.info), v.type.describe()))
+                msg = "{} cannot use {}".format(
+                    variant.describe(self.info), variant.type.describe())
+                raise QAPISemError(self.info, msg) from None
+
             conflicting = set([qtype])
             if qtype == 'QTYPE_QSTRING':
-                if isinstance(v.type, QAPISchemaEnumType):
-                    for m in v.type.members:
-                        if m.name in ['on', 'off']:
+                if isinstance(variant.type, QAPISchemaEnumType):
+                    for member in variant.type.members:
+                        if member.name in ['on', 'off']:
                             conflicting.add('QTYPE_QBOOL')
-                        if re.match(r'[-+0-9.]', m.name):
+                        if re.match(r'[-+0-9.]', member.name):
                             # lazy, could be tightened
                             conflicting.add('QTYPE_QNUM')
                 else:
                     conflicting.add('QTYPE_QNUM')
                     conflicting.add('QTYPE_QBOOL')
-            for qt in conflicting:
-                if qt in types_seen:
-                    raise QAPISemError(
-                        self.info,
-                        "%s can't be distinguished from '%s'"
-                        % (v.describe(self.info), types_seen[qt]))
-                types_seen[qt] = v.name
+
+            for qtype in conflicting:
+                if qtype in types_seen:
+                    msg = "{} can't be distinguished from '{}'".format(
+                        variant.describe(self.info), types_seen[qtype])
+                    raise QAPISemError(self.info, msg)
+
+                types_seen[qtype] = variant.name
 
     def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         super().connect_doc(doc)
         doc = doc or self.doc
-        for v in self.variants.variants:
-            v.connect_doc(doc)
+        for variant in self.variants.variants:
+            variant.connect_doc(doc)
 
     def c_type(self) -> str:
         return c_name(self.name) + POINTER_SUFFIX
@@ -632,16 +637,16 @@ def __init__(self,
         assert bool(tag_member) != bool(tag_name)
         assert (isinstance(tag_name, str) or
                 isinstance(tag_member, QAPISchemaObjectTypeMember))
-        for v in variants:
-            assert isinstance(v, QAPISchemaVariant)
+        for variant in variants:
+            assert isinstance(variant, QAPISchemaVariant)
         self._tag_name = tag_name
         self.info = info
         self.tag_member = tag_member
         self.variants = variants
 
     def set_defined_in(self, name: str) -> None:
-        for v in self.variants:
-            v.set_defined_in(name)
+        for variant in self.variants:
+            variant.set_defined_in(name)
 
     def check(self,
               schema: 'QAPISchema',
@@ -686,40 +691,41 @@ def check(self,
         if self._tag_name:    # flat union
             # branches that are not explicitly covered get an empty type
             cases = {v.name for v in self.variants}
-            for m in self.tag_member.type.members:
-                if m.name not in cases:
-                    v = QAPISchemaVariant(m.name, self.info,
-                                          'q_empty', m.ifcond)
-                    v.set_defined_in(self.tag_member.defined_in)
-                    self.variants.append(v)
+            for member in self.tag_member.type.members:
+                if member.name not in cases:
+                    variant = QAPISchemaVariant(member.name, self.info,
+                                                'q_empty', member.ifcond)
+                    variant.set_defined_in(self.tag_member.defined_in)
+                    self.variants.append(variant)
         if not self.variants:
             raise QAPISemError(self.info, "union has no branches")
-        for v in self.variants:
-            v.check(schema)
+        for variant in self.variants:
+            variant.check(schema)
             # Union names must match enum values; alternate names are
             # checked separately. Use 'seen' to tell the two apart.
             if seen:
-                if v.name not in self.tag_member.type.member_names():
+                if variant.name not in self.tag_member.type.member_names():
                     raise QAPISemError(
                         self.info,
                         "branch '%s' is not a value of %s"
-                        % (v.name, self.tag_member.type.describe()))
-                if (not isinstance(v.type, QAPISchemaObjectType)
-                        or v.type.variants):
+                        % (variant.name, self.tag_member.type.describe()))
+                if (not isinstance(variant.type, QAPISchemaObjectType)
+                        or variant.type.variants):
                     raise QAPISemError(
                         self.info,
-                        "%s cannot use %s"
-                        % (v.describe(self.info), v.type.describe()))
-                v.type.check(schema)
+                        "%s cannot use %s" % (
+                            variant.describe(self.info),
+                            variant.type.describe()))
+                variant.type.check(schema)
 
     def check_clash(self,
                     info: QAPISourceInfo,
                     seen: Dict[str, 'QAPISchemaMember']) -> None:
-        for v in self.variants:
+        for variant in self.variants:
             # Reset seen map for each variant, since qapi names from one
             # branch do not affect another branch
-            assert isinstance(v.type, QAPISchemaObjectType)
-            v.type.check_clash(info, dict(seen))
+            assert isinstance(variant.type, QAPISchemaObjectType)
+            variant.type.check_clash(info, dict(seen))
 
 
 class QAPISchemaMember:
@@ -804,9 +810,9 @@ def __init__(self,
         super().__init__(name, info, ifcond)
         assert isinstance(typ, str)
         assert isinstance(optional, bool)
-        for f in features or []:
-            assert isinstance(f, QAPISchemaFeature)
-            f.set_defined_in(name)
+        for feature in features or []:
+            assert isinstance(feature, QAPISchemaFeature)
+            feature.set_defined_in(name)
         self._type_name = typ
         self.type: Optional[QAPISchemaType] = None
         self.optional = optional
@@ -817,14 +823,14 @@ def check(self, schema: 'QAPISchema') -> None:
         self.type = schema.resolve_type(self._type_name, self.info,
                                         self.describe)
         seen: Dict[str, QAPISchemaMember] = {}
-        for f in self.features:
-            f.check_clash(self.info, seen)
+        for feature in self.features:
+            feature.check_clash(self.info, seen)
 
     def connect_doc(self, doc: Optional[QAPIDoc]) -> None:
         super().connect_doc(doc)
         if doc:
-            for f in self.features:
-                doc.connect_feature(f)
+            for feature in self.features:
+                doc.connect_feature(feature)
 
 
 class QAPISchemaVariant(QAPISchemaObjectTypeMember):
@@ -1068,22 +1074,22 @@ def _def_builtin_type(self,
         self._make_array_type(name, None)
 
     def _def_predefineds(self) -> None:
-        for t in [('str',    'string',  'char' + POINTER_SUFFIX),
-                  ('number', 'number',  'double'),
-                  ('int',    'int',     'int64_t'),
-                  ('int8',   'int',     'int8_t'),
-                  ('int16',  'int',     'int16_t'),
-                  ('int32',  'int',     'int32_t'),
-                  ('int64',  'int',     'int64_t'),
-                  ('uint8',  'int',     'uint8_t'),
-                  ('uint16', 'int',     'uint16_t'),
-                  ('uint32', 'int',     'uint32_t'),
-                  ('uint64', 'int',     'uint64_t'),
-                  ('size',   'int',     'uint64_t'),
-                  ('bool',   'boolean', 'bool'),
-                  ('any',    'value',   'QObject' + POINTER_SUFFIX),
-                  ('null',   'null',    'QNull' + POINTER_SUFFIX)]:
-            self._def_builtin_type(*t)
+        for args in (('str',    'string',  'char' + POINTER_SUFFIX),
+                     ('number', 'number',  'double'),
+                     ('int',    'int',     'int64_t'),
+                     ('int8',   'int',     'int8_t'),
+                     ('int16',  'int',     'int16_t'),
+                     ('int32',  'int',     'int32_t'),
+                     ('int64',  'int',     'int64_t'),
+                     ('uint8',  'int',     'uint8_t'),
+                     ('uint16', 'int',     'uint16_t'),
+                     ('uint32', 'int',     'uint32_t'),
+                     ('uint64', 'int',     'uint64_t'),
+                     ('size',   'int',     'uint64_t'),
+                     ('bool',   'boolean', 'bool'),
+                     ('any',    'value',   'QObject' + POINTER_SUFFIX),
+                     ('null',   'null',    'QNull' + POINTER_SUFFIX)):
+            self._def_builtin_type(*args)
         self.the_empty_object_type = QAPISchemaObjectType(
             'q_empty', None, None, None, None, None, [], None)
         self._def_entity(self.the_empty_object_type)
-- 
2.26.2


