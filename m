Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AD4C388F4
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 007CF217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007CF217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDrU9-0003FG-Fn
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 10:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iDqa7-0001C1-CC
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iDqa4-00061h-SN
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:46:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48466)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iDqa4-000616-In
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:46:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C6B737FDFE;
 Fri, 27 Sep 2019 13:46:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D719510001BC;
 Fri, 27 Sep 2019 13:46:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 668971138660; Fri, 27 Sep 2019 15:46:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/26] qapi: Rename .owner to .defined_in
Date: Fri, 27 Sep 2019 15:46:15 +0200
Message-Id: <20190927134639.4284-3-armbru@redhat.com>
In-Reply-To: <20190927134639.4284-1-armbru@redhat.com>
References: <20190927134639.4284-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 27 Sep 2019 13:46:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

QAPISchemaMember.owner is the name of the defining entity.  That's a
confusing name when an object type inherits members from a base type.
Rename it to .defined_in.  Rename .set_owner() and ._pretty_owner() to
match.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/common.py | 61 +++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 155b87b825..bfb3e8a493 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1319,7 +1319,7 @@ class QAPISchemaEnumType(QAPISchemaType):
         QAPISchemaType.__init__(self, name, info, doc, ifcond)
         for m in members:
             assert isinstance(m, QAPISchemaEnumMember)
-            m.set_owner(name)
+            m.set_defined_in(name)
         assert prefix is None or isinstance(prefix, str)
         self.members =3D members
         self.prefix =3D prefix
@@ -1405,13 +1405,13 @@ class QAPISchemaObjectType(QAPISchemaType):
         assert base is None or isinstance(base, str)
         for m in local_members:
             assert isinstance(m, QAPISchemaObjectTypeMember)
-            m.set_owner(name)
+            m.set_defined_in(name)
         if variants is not None:
             assert isinstance(variants, QAPISchemaObjectTypeVariants)
-            variants.set_owner(name)
+            variants.set_defined_in(name)
         for f in features:
             assert isinstance(f, QAPISchemaFeature)
-            f.set_owner(name)
+            f.set_defined_in(name)
         self._base_name =3D base
         self.base =3D None
         self.local_members =3D local_members
@@ -1521,15 +1521,16 @@ class QAPISchemaMember(object):
         assert isinstance(name, str)
         self.name =3D name
         self.ifcond =3D ifcond or []
-        self.owner =3D None
+        self.defined_in =3D None
=20
-    def set_owner(self, name):
-        assert not self.owner
-        self.owner =3D name
+    def set_defined_in(self, name):
+        assert not self.defined_in
+        self.defined_in =3D name
=20
     def check_clash(self, info, seen):
         cname =3D c_name(self.name)
-        if cname.lower() !=3D cname and self.owner not in name_case_whit=
elist:
+        if (cname.lower() !=3D cname
+                and self.defined_in not in name_case_whitelist):
             raise QAPISemError(info,
                                "%s should not use uppercase" % self.desc=
ribe())
         if cname in seen:
@@ -1537,27 +1538,27 @@ class QAPISchemaMember(object):
                                (self.describe(), seen[cname].describe())=
)
         seen[cname] =3D self
=20
-    def _pretty_owner(self):
-        owner =3D self.owner
-        if owner.startswith('q_obj_'):
+    def _pretty_defined_in(self):
+        defined_in =3D self.defined_in
+        if defined_in.startswith('q_obj_'):
             # See QAPISchema._make_implicit_object_type() - reverse the
             # mapping there to create a nice human-readable description
-            owner =3D owner[6:]
-            if owner.endswith('-arg'):
-                return '(parameter of %s)' % owner[:-4]
-            elif owner.endswith('-base'):
-                return '(base of %s)' % owner[:-5]
+            defined_in =3D defined_in[6:]
+            if defined_in.endswith('-arg'):
+                return '(parameter of %s)' % defined_in[:-4]
+            elif defined_in.endswith('-base'):
+                return '(base of %s)' % defined_in[:-5]
             else:
-                assert owner.endswith('-wrapper')
+                assert defined_in.endswith('-wrapper')
                 # Unreachable and not implemented
                 assert False
-        if owner.endswith('Kind'):
+        if defined_in.endswith('Kind'):
             # See QAPISchema._make_implicit_enum_type()
-            return '(branch of %s)' % owner[:-4]
-        return '(%s of %s)' % (self.role, owner)
+            return '(branch of %s)' % defined_in[:-4]
+        return '(%s of %s)' % (self.role, defined_in)
=20
     def describe(self):
-        return "'%s' %s" % (self.name, self._pretty_owner())
+        return "'%s' %s" % (self.name, self._pretty_defined_in())
=20
=20
 class QAPISchemaEnumMember(QAPISchemaMember):
@@ -1578,7 +1579,7 @@ class QAPISchemaObjectTypeMember(QAPISchemaMember):
         self.optional =3D optional
=20
     def check(self, schema):
-        assert self.owner
+        assert self.defined_in
         self.type =3D schema.lookup_type(self._type_name)
         assert self.type
=20
@@ -1598,9 +1599,9 @@ class QAPISchemaObjectTypeVariants(object):
         self.tag_member =3D tag_member
         self.variants =3D variants
=20
-    def set_owner(self, name):
+    def set_defined_in(self, name):
         for v in self.variants:
-            v.set_owner(name)
+            v.set_defined_in(name)
=20
     def check(self, schema, seen):
         if not self.tag_member:    # flat union
@@ -1616,7 +1617,7 @@ class QAPISchemaObjectTypeVariants(object):
                 if m.name not in cases:
                     v =3D QAPISchemaObjectTypeVariant(m.name, 'q_empty',
                                                     m.ifcond)
-                    v.set_owner(self.tag_member.owner)
+                    v.set_defined_in(self.tag_member.defined_in)
                     self.variants.append(v)
         assert self.variants
         for v in self.variants:
@@ -1648,8 +1649,8 @@ class QAPISchemaAlternateType(QAPISchemaType):
         QAPISchemaType.__init__(self, name, info, doc, ifcond)
         assert isinstance(variants, QAPISchemaObjectTypeVariants)
         assert variants.tag_member
-        variants.set_owner(name)
-        variants.tag_member.set_owner(self.name)
+        variants.set_defined_in(name)
+        variants.tag_member.set_defined_in(self.name)
         self.variants =3D variants
=20
     def check(self, schema):
@@ -1829,7 +1830,7 @@ class QAPISchema(object):
                 for v in values]
=20
     def _make_implicit_enum_type(self, name, info, ifcond, values):
-        # See also QAPISchemaObjectTypeMember._pretty_owner()
+        # See also QAPISchemaObjectTypeMember._pretty_defined_in()
         name =3D name + 'Kind'   # Use namespace reserved by add_name()
         self._def_entity(QAPISchemaEnumType(
             name, info, None, ifcond, self._make_enum_members(values), N=
one))
@@ -1845,7 +1846,7 @@ class QAPISchema(object):
                                    role, members):
         if not members:
             return None
-        # See also QAPISchemaObjectTypeMember._pretty_owner()
+        # See also QAPISchemaObjectTypeMember._pretty_defined_in()
         name =3D 'q_obj_%s-%s' % (name, role)
         typ =3D self.lookup_entity(name, QAPISchemaObjectType)
         if typ:
--=20
2.21.0


