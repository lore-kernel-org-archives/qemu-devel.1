Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93350ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 22:16:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E6B2054F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 22:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E6B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFQRI-0002vu-5a
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 18:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iFOLR-0000Pa-6R
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 16:02:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iFOLO-0006S2-Bg
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 16:02:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40006)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iFOLL-0006QN-Qg
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 16:01:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AD25318C8907;
 Tue,  1 Oct 2019 20:01:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 188B719C6A;
 Tue,  1 Oct 2019 20:01:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9B7CF113864A; Tue,  1 Oct 2019 22:01:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH v2 1/2] qapi: Add feature flags to commands in qapi
 introspection
References: <cover.1568989362.git.pkrempa@redhat.com>
 <96cc954e1cba111a4565123badb42c36e534a5d3.1568989362.git.pkrempa@redhat.com>
Date: Tue, 01 Oct 2019 22:01:51 +0200
In-Reply-To: <96cc954e1cba111a4565123badb42c36e534a5d3.1568989362.git.pkrempa@redhat.com>
 (Peter Krempa's message of "Fri, 20 Sep 2019 16:26:44 +0200")
Message-ID: <87blv02q1c.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Tue, 01 Oct 2019 20:01:53 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Krempa <pkrempa@redhat.com> writes:

> Similarly to features for struct types introduce the feature flags also
> for commands. This will allow notifying management layers of fixes and
> compatible changes in the behaviour of a command which may not be
> detectable any other way.
>
> The changes were heavily inspired by commit 6a8c0b51025.
>
> Signed-off-by: Peter Krempa <pkrempa@redhat.com>
> ---
>  docs/devel/qapi-code-gen.txt   |  4 ++--
>  qapi/introspect.json           |  6 ++++-
>  scripts/qapi/commands.py       |  3 ++-
>  scripts/qapi/common.py         | 40 +++++++++++++++++++++++++++++-----
>  scripts/qapi/doc.py            |  3 ++-
>  scripts/qapi/introspect.py     |  7 +++++-
>  tests/qapi-schema/test-qapi.py |  7 +++++-
>  7 files changed, 58 insertions(+), 12 deletions(-)
>
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index e8ec8ac1de..d465cc6330 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -726,8 +726,8 @@ change in the QMP syntax (usually by allowing values or operations that
>  previously resulted in an error). QMP clients may still need to know
>  whether the extension is available.
>
> -For this purpose, a list of features can be specified for a struct type.
> -This is exposed to the client as a list of string, where each string
> +For this purpose, a list of features can be specified for a command or struct
> +type. This is exposed to the client as a list of strings, where each string
>  signals that this build of QEMU shows a certain behaviour.

Limit line length to 70 characters, and double space after
sentence-ending period, please.

>
>  In the schema, features can be specified as simple strings, for example:
> diff --git a/qapi/introspect.json b/qapi/introspect.json
> index 1843c1cb17..031a954fa9 100644
> --- a/qapi/introspect.json
> +++ b/qapi/introspect.json
> @@ -266,13 +266,17 @@
>  # @allow-oob: whether the command allows out-of-band execution,
>  #             defaults to false (Since: 2.12)
>  #
> +# @features: names of features associated with the command, in no particular
> +#            order. (since 4.2)
> +#
>  # TODO: @success-response (currently irrelevant, because it's QGA, not QMP)
>  #
>  # Since: 2.5
>  ##
>  { 'struct': 'SchemaInfoCommand',
>    'data': { 'arg-type': 'str', 'ret-type': 'str',
> -            '*allow-oob': 'bool' } }
> +            '*allow-oob': 'bool',
> +            '*features': [ 'str' ] } }
>
>  ##
>  # @SchemaInfoEvent:
> diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
> index b929e07be4..6cfe6cdd9e 100644
> --- a/scripts/qapi/commands.py
> +++ b/scripts/qapi/commands.py
> @@ -276,7 +276,8 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
>          genc.add(gen_registry(self._regy.get_content(), self._prefix))
>
>      def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
> -                      success_response, boxed, allow_oob, allow_preconfig):
> +                      success_response, boxed, allow_oob, allow_preconfig,
> +                      features):
>          if not gen:
>              return
>          # FIXME: If T is a user-defined type, the user is responsible
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index d61bfdc526..1502820f46 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py

Conflicts with my "[PATCH 6/7] qapi: Split up scripts/qapi/common.py"
and also with work that has already landed in master.  Untested rebase
appended for your convenience.

> @@ -838,6 +838,7 @@ def check_type(info, source, value, allow_array=False,
>  def check_command(expr, info):
>      name = expr['command']
>      boxed = expr.get('boxed', False)
> +    features = expr.get('features')
>
>      args_meta = ['struct']
>      if boxed:
> @@ -852,6 +853,19 @@ def check_command(expr, info):
>                 expr.get('returns'), allow_array=True,
>                 allow_optional=True, allow_metas=returns_meta)
>
> +    if features:
> +        if not isinstance(features, list):
> +            raise QAPISemError(info,
> +                               "Command '%s' requires an array for 'features'" %
> +                               name)
> +        for f in features:
> +            assert isinstance(f, dict)
> +            check_known_keys(info, "feature of command %s" % name, f,
> +                             ['name'], ['if'])
> +
> +            check_if(f, info)
> +            check_name(info, "Feature of command %s" % name, f['name'])
> +

Copied from check_struct() with minor edits.

Conflicts semantically with commit eeb57c85da "qapi: Avoid redundant
definition references in error messages", which changes the code you
copy in a way that makes editing it superfluous.  Please factor it into
a helper function check_features(features, info).

>
>  def check_event(expr, info):
>      name = expr['event']
> @@ -1138,8 +1152,10 @@ def check_exprs(exprs):
>              meta = 'command'
>              check_keys(expr_elem, 'command', [],
>                         ['data', 'returns', 'gen', 'success-response',
> -                        'boxed', 'allow-oob', 'allow-preconfig', 'if'])
> +                        'boxed', 'allow-oob', 'allow-preconfig', 'if',
> +                        'features'])
>              normalize_members(expr.get('data'))
> +            normalize_features(expr.get('features'))
>          elif 'event' in expr:
>              meta = 'event'
>              check_keys(expr_elem, 'event', [], ['data', 'boxed', 'if'])
> @@ -1283,7 +1299,8 @@ class QAPISchemaVisitor(object):
>          pass
>
>      def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
> -                      success_response, boxed, allow_oob, allow_preconfig):
> +                      success_response, boxed, allow_oob, allow_preconfig,
> +                      features):
>          pass
>
>      def visit_event(self, name, info, ifcond, arg_type, boxed):
> @@ -1697,10 +1714,14 @@ class QAPISchemaAlternateType(QAPISchemaType):
>
>  class QAPISchemaCommand(QAPISchemaEntity):
>      def __init__(self, name, info, doc, ifcond, arg_type, ret_type,
> -                 gen, success_response, boxed, allow_oob, allow_preconfig):
> +                 gen, success_response, boxed, allow_oob, allow_preconfig,
> +                 features):
>          QAPISchemaEntity.__init__(self, name, info, doc, ifcond)
>          assert not arg_type or isinstance(arg_type, str)
>          assert not ret_type or isinstance(ret_type, str)
> +        for f in features:
> +            assert isinstance(f, QAPISchemaFeature)
> +            f.set_owner(name)

Copied from QAPISchemaObjectType.__init__().  Acceptable for now.

>          self._arg_type_name = arg_type
>          self.arg_type = None
>          self._ret_type_name = ret_type
> @@ -1710,6 +1731,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
>          self.boxed = boxed
>          self.allow_oob = allow_oob
>          self.allow_preconfig = allow_preconfig
> +        self.features = features
>
>      def check(self, schema):
>          QAPISchemaEntity.check(self, schema)
> @@ -1731,12 +1753,18 @@ class QAPISchemaCommand(QAPISchemaEntity):
>              self.ret_type = schema.lookup_type(self._ret_type_name)
>              assert isinstance(self.ret_type, QAPISchemaType)
>
> +        # Features are in a name space separate from members
> +        seen = {}
> +        for f in self.features:
> +            f.check_clash(self.info, seen)
> +

Copied from QAPISchemaObjectType.check().  Acceptable for now.

>      def visit(self, visitor):
>          visitor.visit_command(self.name, self.info, self.ifcond,
>                                self.arg_type, self.ret_type,
>                                self.gen, self.success_response,
>                                self.boxed, self.allow_oob,
> -                              self.allow_preconfig)
> +                              self.allow_preconfig,
> +                              self.features)
>
>
>  class QAPISchemaEvent(QAPISchemaEntity):
> @@ -1989,6 +2017,7 @@ class QAPISchema(object):
>          allow_oob = expr.get('allow-oob', False)
>          allow_preconfig = expr.get('allow-preconfig', False)
>          ifcond = expr.get('if')
> +        features = expr.get('features', [])
>          if isinstance(data, OrderedDict):
>              data = self._make_implicit_object_type(
>                  name, info, doc, ifcond, 'arg', self._make_members(data, info))
> @@ -1997,7 +2026,8 @@ class QAPISchema(object):
>              rets = self._make_array_type(rets[0], info)
>          self._def_entity(QAPISchemaCommand(name, info, doc, ifcond, data, rets,
>                                             gen, success_response,
> -                                           boxed, allow_oob, allow_preconfig))
> +                                           boxed, allow_oob, allow_preconfig,
> +                                           self._make_features(features)))
>
>      def _def_event(self, expr, info, doc):
>          name = expr['event']
> diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
> index 5fc0fc7e06..aa4c557244 100755
> --- a/scripts/qapi/doc.py
> +++ b/scripts/qapi/doc.py
> @@ -249,7 +249,8 @@ class QAPISchemaGenDocVisitor(qapi.common.QAPISchemaVisitor):
>                                 body=texi_entity(doc, 'Members', ifcond)))
>
>      def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
> -                      success_response, boxed, allow_oob, allow_preconfig):
> +                      success_response, boxed, allow_oob, allow_preconfig,
> +                      features):
>          doc = self.cur_doc
>          if boxed:
>              body = texi_body(doc)
> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index f62cf0a2e1..36a5b195e5 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -206,13 +206,18 @@ const QLitObject %(c_name)s = %(c_string)s;
>                             for m in variants.variants]}, ifcond)
>
>      def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
> -                      success_response, boxed, allow_oob, allow_preconfig):
> +                      success_response, boxed, allow_oob, allow_preconfig,
> +                      features):
>          arg_type = arg_type or self._schema.the_empty_object_type
>          ret_type = ret_type or self._schema.the_empty_object_type
>          obj = {'arg-type': self._use_type(arg_type),
>                 'ret-type': self._use_type(ret_type)}
>          if allow_oob:
>              obj['allow-oob'] = allow_oob
> +
> +        if features:
> +            obj['features'] = [(f.name, {'if': f.ifcond}) for f in features]
> +

Copied from visit_object_type_flat().  Acceptable for now.

>          self._gen_qlit(name, 'command', obj, ifcond)
>
>      def visit_event(self, name, info, ifcond, arg_type, boxed):
> diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
> index b0f770b9bd..def34aa489 100644
> --- a/tests/qapi-schema/test-qapi.py
> +++ b/tests/qapi-schema/test-qapi.py
> @@ -60,13 +60,18 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>          self._print_if(ifcond)
>
>      def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
> -                      success_response, boxed, allow_oob, allow_preconfig):
> +                      success_response, boxed, allow_oob, allow_preconfig,
> +                      features):
>          print('command %s %s -> %s'
>                % (name, arg_type and arg_type.name,
>                   ret_type and ret_type.name))
>          print('   gen=%s success_response=%s boxed=%s oob=%s preconfig=%s'
>                % (gen, success_response, boxed, allow_oob, allow_preconfig))
>          self._print_if(ifcond)
> +        if features:
> +            for f in features:
> +                print('    feature %s' % f.name)
> +                self._print_if(f.ifcond, 8)
>
>      def visit_event(self, name, info, ifcond, arg_type, boxed):
>          print('event %s %s' % (name, arg_type and arg_type.name))

Copied from visit_object_type().  Would you mind factoring it into a
@staticmethod _print_features()?

No tests.  Please add at least a positive test case to
qapi-schema-test.json.


From c55b056497b79e922d0489cf2dfe4d2a5edb62c8 Mon Sep 17 00:00:00 2001
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 1 Oct 2019 20:47:04 +0200
Subject: [PATCH 1/2] qapi: Add feature flags to commands in qapi

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
 tests/qapi-schema/test-qapi.py |  7 ++++++-
 8 files changed, 59 insertions(+), 13 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 64d9e4c6a9..637fa49977 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -640,9 +640,10 @@ change in the QMP syntax (usually by allowing values or operations
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
+# @features: names of features associated with the command, in no particular
+#            order. (since 4.2)
+#
 # TODO: @success-response (currently irrelevant, because it's QGA, not QMP)
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
@@ -277,7 +277,8 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
         genc.add(gen_registry(self._regy.get_content(), self._prefix))
 
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
-                      success_response, boxed, allow_oob, allow_preconfig):
+                      success_response, boxed, allow_oob, allow_preconfig,
+                      features):
         if not gen:
             return
         # FIXME: If T is a user-defined type, the user is responsible
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index dc8919bab7..8278ccbc43 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -249,7 +249,8 @@ class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
                                body=texi_entity(doc, 'Members', ifcond)))
 
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
-                      success_response, boxed, allow_oob, allow_preconfig):
+                      success_response, boxed, allow_oob, allow_preconfig,
+                      features):
         doc = self.cur_doc
         if boxed:
             body = texi_body(doc)
diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index da23063f57..5c98d31941 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -277,12 +277,26 @@ def check_command(expr, info):
     args = expr.get('data')
     rets = expr.get('returns')
     boxed = expr.get('boxed', False)
+    features = expr.get('features')
 
     if boxed and args is None:
         raise QAPISemError(info, "'boxed': true requires 'data'")
     check_type(args, info, "'data'", allow_dict=not boxed)
     check_type(rets, info, "'returns'", allow_array=True)
 
+    if features:
+        if not isinstance(features, list):
+            raise QAPISemError(info,
+                               "Command '%s' requires an array for 'features'" %
+                               name)
+        for f in features:
+            assert isinstance(f, dict)
+            check_known_keys(info, "feature of command %s" % name, f,
+                             ['name'], ['if'])
+
+            check_if(f, info)
+            check_name(info, "Feature of command %s" % name, f['name'])
+
 
 def check_event(expr, info):
     args = expr.get('data')
@@ -357,7 +371,7 @@ def check_exprs(exprs):
         elif meta == 'command':
             check_keys(expr, info, meta,
                        ['command'],
-                       ['data', 'returns', 'boxed', 'if',
+                       ['data', 'returns', 'boxed', 'if', 'features',
                         'gen', 'success-response', 'allow-oob',
                         'allow-preconfig'])
             normalize_members(expr.get('data'))
@@ -366,6 +380,7 @@ def check_exprs(exprs):
             check_keys(expr, info, meta,
                        ['event'], ['data', 'boxed', 'if'])
             normalize_members(expr.get('data'))
+            normalize_features(expr.get('features'))
             check_event(expr, info)
         else:
             assert False, 'unexpected meta type'
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index d1c1ad346d..739b35ae8f 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -209,13 +209,18 @@ const QLitObject %(c_name)s = %(c_string)s;
                            for m in variants.variants]}, ifcond)
 
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
-                      success_response, boxed, allow_oob, allow_preconfig):
+                      success_response, boxed, allow_oob, allow_preconfig,
+                      features):
         arg_type = arg_type or self._schema.the_empty_object_type
         ret_type = ret_type or self._schema.the_empty_object_type
         obj = {'arg-type': self._use_type(arg_type),
                'ret-type': self._use_type(ret_type)}
         if allow_oob:
             obj['allow-oob'] = allow_oob
+
+        if features:
+            obj['features'] = [(f.name, {'if': f.ifcond}) for f in features]
+
         self._gen_qlit(name, 'command', obj, ifcond)
 
     def visit_event(self, name, info, ifcond, arg_type, boxed):
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 38041098bd..dd0fdc5ced 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -109,7 +109,8 @@ class QAPISchemaVisitor(object):
         pass
 
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
-                      success_response, boxed, allow_oob, allow_preconfig):
+                      success_response, boxed, allow_oob, allow_preconfig,
+                      features):
         pass
 
     def visit_event(self, name, info, ifcond, arg_type, boxed):
@@ -658,10 +659,14 @@ class QAPISchemaCommand(QAPISchemaEntity):
     meta = 'command'
 
     def __init__(self, name, info, doc, ifcond, arg_type, ret_type,
-                 gen, success_response, boxed, allow_oob, allow_preconfig):
+                 gen, success_response, boxed, allow_oob, allow_preconfig,
+                 features):
         QAPISchemaEntity.__init__(self, name, info, doc, ifcond)
         assert not arg_type or isinstance(arg_type, str)
         assert not ret_type or isinstance(ret_type, str)
+        for f in features:
+            assert isinstance(f, QAPISchemaFeature)
+            f.set_owner(name)
         self._arg_type_name = arg_type
         self.arg_type = None
         self._ret_type_name = ret_type
@@ -671,6 +676,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
         self.boxed = boxed
         self.allow_oob = allow_oob
         self.allow_preconfig = allow_preconfig
+        self.features = features
 
     def check(self, schema):
         QAPISchemaEntity.check(self, schema)
@@ -700,13 +706,19 @@ class QAPISchemaCommand(QAPISchemaEntity):
                         "command's 'returns' cannot take %s"
                         % self.ret_type.describe())
 
+        # Features are in a name space separate from members
+        seen = {}
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
         allow_oob = expr.get('allow-oob', False)
         allow_preconfig = expr.get('allow-preconfig', False)
         ifcond = expr.get('if')
+        features = expr.get('features', [])
         if isinstance(data, OrderedDict):
             data = self._make_implicit_object_type(
                 name, info, doc, ifcond, 'arg', self._make_members(data, info))
@@ -991,7 +1004,8 @@ class QAPISchema(object):
             rets = self._make_array_type(rets[0], info)
         self._def_entity(QAPISchemaCommand(name, info, doc, ifcond, data, rets,
                                            gen, success_response,
-                                           boxed, allow_oob, allow_preconfig))
+                                           boxed, allow_oob, allow_preconfig,
+                                           self._make_features(features, info)))
 
     def _def_event(self, expr, info, doc):
         name = expr['event']
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index 664254618a..fc41d24bb9 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -72,13 +72,18 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         self._print_if(ifcond)
 
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
-                      success_response, boxed, allow_oob, allow_preconfig):
+                      success_response, boxed, allow_oob, allow_preconfig,
+                      features):
         print('command %s %s -> %s'
               % (name, arg_type and arg_type.name,
                  ret_type and ret_type.name))
         print('   gen=%s success_response=%s boxed=%s oob=%s preconfig=%s'
               % (gen, success_response, boxed, allow_oob, allow_preconfig))
         self._print_if(ifcond)
+        if features:
+            for f in features:
+                print('    feature %s' % f.name)
+                self._print_if(f.ifcond, 8)
 
     def visit_event(self, name, info, ifcond, arg_type, boxed):
         print('event %s %s' % (name, arg_type and arg_type.name))
-- 
2.21.0


