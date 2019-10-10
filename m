Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7424FC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA81206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA81206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIWHC-00065Y-EY
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 07:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1iIWGA-00058d-Ar
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1iIWG8-0000s7-Et
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:05:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36484)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1iIWG8-0000rT-61
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:05:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7015730832EA
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 11:05:27 +0000 (UTC)
Received: from angien.brq.redhat.com (unknown [10.43.2.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B54460BF4;
 Thu, 10 Oct 2019 11:05:26 +0000 (UTC)
From: Peter Krempa <pkrempa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/3] qapi: Add feature flags to commands in qapi
Date: Thu, 10 Oct 2019 13:05:22 +0200
Message-Id: <b8559eac94436f327aa2e418c0bf8fc1fe032807.1570705279.git.pkrempa@redhat.com>
In-Reply-To: <cover.1570705279.git.pkrempa@redhat.com>
References: <cover.1570705279.git.pkrempa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 10 Oct 2019 11:05:27 +0000 (UTC)
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similarly to features for struct types introduce the feature flags also
for commands. This will allow notifying management layers of fixes and
compatible changes in the behaviour of a command which may not be
detectable any other way.

The changes were heavily inspired by commit 6a8c0b51025.

Signed-off-by: Peter Krempa <pkrempa@redhat.com>
---
 docs/devel/qapi-code-gen.txt   |  7 ++++---
 qapi/introspect.json           |  6 +++++-
 scripts/qapi/commands.py       |  3 ++-
 scripts/qapi/doc.py            |  3 ++-
 scripts/qapi/expr.py           | 17 ++++++++++++++++-
 scripts/qapi/introspect.py     |  7 ++++++-
 scripts/qapi/schema.py         | 22 ++++++++++++++++++----
 tests/qapi-schema/test-qapi.py |  3 ++-
 8 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 64d9e4c6a9..637fa49977 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -640,9 +640,10 @@ change in the QMP syntax (usually by allowing values=
 or operations
 that previously resulted in an error).  QMP clients may still need to
 know whether the extension is available.

-For this purpose, a list of features can be specified for a struct type.
-This is exposed to the client as a list of string, where each string
-signals that this build of QEMU shows a certain behaviour.
+For this purpose, a list of features can be specified for a command or
+struct type.  This is exposed to the client as a list of strings,
+where each string signals that this build of QEMU shows a certain
+behaviour.

 Each member of the 'features' array defines a feature.  It can either
 be { 'name': STRING, '*if': COND }, or STRING, which is shorthand for
diff --git a/qapi/introspect.json b/qapi/introspect.json
index 1843c1cb17..031a954fa9 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -266,13 +266,17 @@
 # @allow-oob: whether the command allows out-of-band execution,
 #             defaults to false (Since: 2.12)
 #
+# @features: names of features associated with the command, in no partic=
ular
+#            order. (since 4.2)
+#
 # TODO: @success-response (currently irrelevant, because it's QGA, not Q=
MP)
 #
 # Since: 2.5
 ##
 { 'struct': 'SchemaInfoCommand',
   'data': { 'arg-type': 'str', 'ret-type': 'str',
-            '*allow-oob': 'bool' } }
+            '*allow-oob': 'bool',
+            '*features': [ 'str' ] } }

 ##
 # @SchemaInfoEvent:
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 898516b086..ab98e504f3 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -277,7 +277,8 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmd=
s);
         genc.add(gen_registry(self._regy.get_content(), self._prefix))

     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
-                      success_response, boxed, allow_oob, allow_preconfi=
g):
+                      success_response, boxed, allow_oob, allow_preconfi=
g,
+                      features):
         if not gen:
             return
         # FIXME: If T is a user-defined type, the user is responsible
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index dc8919bab7..8278ccbc43 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -249,7 +249,8 @@ class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
                                body=3Dtexi_entity(doc, 'Members', ifcond=
)))

     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
-                      success_response, boxed, allow_oob, allow_preconfi=
g):
+                      success_response, boxed, allow_oob, allow_preconfi=
g,
+                      features):
         doc =3D self.cur_doc
         if boxed:
             body =3D texi_body(doc)
diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index da23063f57..129a4075f0 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -277,12 +277,26 @@ def check_command(expr, info):
     args =3D expr.get('data')
     rets =3D expr.get('returns')
     boxed =3D expr.get('boxed', False)
+    features =3D expr.get('features')

     if boxed and args is None:
         raise QAPISemError(info, "'boxed': true requires 'data'")
     check_type(args, info, "'data'", allow_dict=3Dnot boxed)
     check_type(rets, info, "'returns'", allow_array=3DTrue)

+    if features:
+        if not isinstance(features, list):
+            raise QAPISemError(info, "'features' must be an array")
+        for f in features:
+            source =3D "'features' member"
+            assert isinstance(f, dict)
+            check_keys(f, info, source, ['name'], ['if'])
+            check_name_is_str(f['name'], info, source)
+            source =3D "%s '%s'" % (source, f['name'])
+            check_name_str(f['name'], info, source)
+            check_if(f, info, source)
+            normalize_if(f)
+

 def check_event(expr, info):
     args =3D expr.get('data')
@@ -357,10 +371,11 @@ def check_exprs(exprs):
         elif meta =3D=3D 'command':
             check_keys(expr, info, meta,
                        ['command'],
-                       ['data', 'returns', 'boxed', 'if',
+                       ['data', 'returns', 'boxed', 'if', 'features',
                         'gen', 'success-response', 'allow-oob',
                         'allow-preconfig'])
             normalize_members(expr.get('data'))
+            normalize_features(expr.get('features'))
             check_command(expr, info)
         elif meta =3D=3D 'event':
             check_keys(expr, info, meta,
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index d1c1ad346d..739b35ae8f 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -209,13 +209,18 @@ const QLitObject %(c_name)s =3D %(c_string)s;
                            for m in variants.variants]}, ifcond)

     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
-                      success_response, boxed, allow_oob, allow_preconfi=
g):
+                      success_response, boxed, allow_oob, allow_preconfi=
g,
+                      features):
         arg_type =3D arg_type or self._schema.the_empty_object_type
         ret_type =3D ret_type or self._schema.the_empty_object_type
         obj =3D {'arg-type': self._use_type(arg_type),
                'ret-type': self._use_type(ret_type)}
         if allow_oob:
             obj['allow-oob'] =3D allow_oob
+
+        if features:
+            obj['features'] =3D [(f.name, {'if': f.ifcond}) for f in fea=
tures]
+
         self._gen_qlit(name, 'command', obj, ifcond)

     def visit_event(self, name, info, ifcond, arg_type, boxed):
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 38041098bd..8a48231766 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -109,7 +109,8 @@ class QAPISchemaVisitor(object):
         pass

     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
-                      success_response, boxed, allow_oob, allow_preconfi=
g):
+                      success_response, boxed, allow_oob, allow_preconfi=
g,
+                      features):
         pass

     def visit_event(self, name, info, ifcond, arg_type, boxed):
@@ -658,10 +659,14 @@ class QAPISchemaCommand(QAPISchemaEntity):
     meta =3D 'command'

     def __init__(self, name, info, doc, ifcond, arg_type, ret_type,
-                 gen, success_response, boxed, allow_oob, allow_preconfi=
g):
+                 gen, success_response, boxed, allow_oob, allow_preconfi=
g,
+                 features):
         QAPISchemaEntity.__init__(self, name, info, doc, ifcond)
         assert not arg_type or isinstance(arg_type, str)
         assert not ret_type or isinstance(ret_type, str)
+        for f in features:
+            assert isinstance(f, QAPISchemaFeature)
+            f.set_defined_in(name)
         self._arg_type_name =3D arg_type
         self.arg_type =3D None
         self._ret_type_name =3D ret_type
@@ -671,6 +676,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
         self.boxed =3D boxed
         self.allow_oob =3D allow_oob
         self.allow_preconfig =3D allow_preconfig
+        self.features =3D features

     def check(self, schema):
         QAPISchemaEntity.check(self, schema)
@@ -700,13 +706,19 @@ class QAPISchemaCommand(QAPISchemaEntity):
                         "command's 'returns' cannot take %s"
                         % self.ret_type.describe())

+        # Features are in a name space separate from members
+        seen =3D {}
+        for f in self.features:
+            f.check_clash(self.info, seen)
+
     def visit(self, visitor):
         QAPISchemaEntity.visit(self, visitor)
         visitor.visit_command(self.name, self.info, self.ifcond,
                               self.arg_type, self.ret_type,
                               self.gen, self.success_response,
                               self.boxed, self.allow_oob,
-                              self.allow_preconfig)
+                              self.allow_preconfig,
+                              self.features)


 class QAPISchemaEvent(QAPISchemaEntity):
@@ -983,6 +995,7 @@ class QAPISchema(object):
         allow_oob =3D expr.get('allow-oob', False)
         allow_preconfig =3D expr.get('allow-preconfig', False)
         ifcond =3D expr.get('if')
+        features =3D expr.get('features', [])
         if isinstance(data, OrderedDict):
             data =3D self._make_implicit_object_type(
                 name, info, doc, ifcond, 'arg', self._make_members(data,=
 info))
@@ -991,7 +1004,8 @@ class QAPISchema(object):
             rets =3D self._make_array_type(rets[0], info)
         self._def_entity(QAPISchemaCommand(name, info, doc, ifcond, data=
, rets,
                                            gen, success_response,
-                                           boxed, allow_oob, allow_preco=
nfig))
+                                           boxed, allow_oob, allow_preco=
nfig,
+                                           self._make_features(features,=
 info)))

     def _def_event(self, expr, info, doc):
         name =3D expr['event']
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index 664254618a..e13c2e8671 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -72,7 +72,8 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         self._print_if(ifcond)

     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
-                      success_response, boxed, allow_oob, allow_preconfi=
g):
+                      success_response, boxed, allow_oob, allow_preconfi=
g,
+                      features):
         print('command %s %s -> %s'
               % (name, arg_type and arg_type.name,
                  ret_type and ret_type.name))
--=20
2.21.0


