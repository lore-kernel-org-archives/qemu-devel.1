Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E896AC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 13:36:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1A4A217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 13:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A4A217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54753 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUAMy-0004YF-Pi
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 09:36:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hUAKc-0001sD-1j
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:34:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hUA7m-0003XJ-98
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:20:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hUA7c-0002UB-ND; Fri, 24 May 2019 09:20:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C1C126EB97;
	Fri, 24 May 2019 13:20:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 42CC11835C;
	Fri, 24 May 2019 13:20:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id C9C611138648; Fri, 24 May 2019 15:20:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190517144232.18965-1-kwolf@redhat.com>
	<20190517144232.18965-2-kwolf@redhat.com>
Date: Fri, 24 May 2019 15:20:23 +0200
In-Reply-To: <20190517144232.18965-2-kwolf@redhat.com> (Kevin Wolf's message
	of "Fri, 17 May 2019 16:42:27 +0200")
Message-ID: <874l5k7zvs.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Fri, 24 May 2019 13:20:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/6] qapi: Support features for structs
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
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Support features for structs" accidentally fits the "Do stuff"
commit message anti-pattern.  Suggest:

    qapi: Add feature flags to struct types

Kevin Wolf <kwolf@redhat.com> writes:

> Sometimes, the behaviour of QEMU changes compatibly, but without a
> change in the QMP syntax (usually by allowing values or operations that
> previously resulted in an error). QMP clients may still need to know
> whether the extension is available.
>
> This allows to add a list of features to struct definitions that will be

What's "this"?  Do you mean "This patch allows"?

> made visible to QMP clients through schema introspection.

Attentive readers might ask why only structs.  The answer is of course
that structs suffice for your immediate needs, and you chose to keep
this patch simple by limiting it to what you actually need.

Now let me try to work that into your commit message:

    qapi: Add feature flags to struct types

    Sometimes, the behaviour of QEMU changes without a change in the QMP
    syntax (usually by allowing values or operations that previously
    resulted in an error).  QMP clients may still need to know whether
    they can rely on the changed behavior.

    To let us make such changes visible in introspection, add feature
    flags to the QAPI schema language.  Looks like this:

        { 'struct': 'TestType',
          'data': { 'number': 'int' },
          'features': [ 'allow-negative-numbers' ] }

    Introspection then looks like

        { "name": "TestType", "meta-type": "object",
          "members": [
              { "name": "number", "type": "int" } ],
          "features": [ "allow-negative-numbers" ] }

    This patch implements feature flags just for struct types.  We'll
    implement them more widely as needed.

>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/introspect.json                   |  8 +++-
>  docs/devel/qapi-code-gen.txt           | 38 ++++++++++++++++
>  scripts/qapi/common.py                 | 61 +++++++++++++++++++++-----
>  scripts/qapi/doc.py                    |  3 +-
>  scripts/qapi/introspect.py             |  6 ++-
>  scripts/qapi/types.py                  |  3 +-
>  scripts/qapi/visit.py                  |  3 +-
>  tests/qapi-schema/double-type.err      |  2 +-
>  tests/qapi-schema/test-qapi.py         |  3 +-
>  tests/qapi-schema/unknown-expr-key.err |  2 +-
>  10 files changed, 111 insertions(+), 18 deletions(-)
>
> diff --git a/qapi/introspect.json b/qapi/introspect.json
> index 3d22166b2b..3cb6c1aca4 100644
> --- a/qapi/introspect.json
> +++ b/qapi/introspect.json
> @@ -174,6 +174,11 @@
>  #            and may even differ from the order of the values of the
>  #            enum type of the @tag.
>  #
> +# @features: names of features that are supported by this version and build and
> +#            aren't othervise visible through schema introspection (e.g. change
> +#            of behaviour related to an object type that didn't come with a
> +#            syntactic change in the schema of the object type) (since: 4.1)
> +#

Specify "in no particular order", like we do elsewhere.

Let's wrap lines a little earlier.

I'm not sure this is the best place to explain the indented purpose of
QAPI feature flags.  Other SchemaInfoFOO will acquire @features.  I feel
each instance should carry just terse specification.  Anything beyond
that should be in just one place.  Right now, query-qmp-schema looks
like the best fit.  We could instead write an introduction to
introspection as a file comment, right under "# = QMP introspection".

>  # Values of this type are JSON object on the wire.
>  #
>  # Since: 2.5
> @@ -181,7 +186,8 @@
>  { 'struct': 'SchemaInfoObject',
>    'data': { 'members': [ 'SchemaInfoObjectMember' ],
>              '*tag': 'str',
> -            '*variants': [ 'SchemaInfoObjectVariant' ] } }
> +            '*variants': [ 'SchemaInfoObjectVariant' ],
> +            '*features': [ 'str' ] } }
>  
>  ##
>  # @SchemaInfoObjectMember:
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index b517b0cfbf..e8ec8ac1de 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -719,6 +719,34 @@ any non-empty complex type (struct, union, or alternate), and a
>  pointer to that QAPI type is passed as a single argument.
>  
>  
> +=== Features ===
> +
> +Sometimes, the behaviour of QEMU changes compatibly, but without a
> +change in the QMP syntax (usually by allowing values or operations that
> +previously resulted in an error). QMP clients may still need to know
> +whether the extension is available.
> +
> +For this purpose, a list of features can be specified for a struct type.
> +This is exposed to the client as a list of string, where each string
> +signals that this build of QEMU shows a certain behaviour.
> +
> +In the schema, features can be specified as simple strings, for example:
> +
> +{ 'struct': 'TestType',
> +  'data': { 'number': 'int' },
> +  'features': [ 'allow-negative-numbers' ] }
> +
> +Another option is to specify features as dictionaries, where the key
> +'name' specifies the feature string to be exposed to clients:
> +
> +{ 'struct': 'TestType',
> +  'data': { 'number': 'int' },
> +  'features': [ { 'name': 'allow-negative-numbers' } ] }
> +
> +This expanded form is necessary if you want to make the feature
> +conditional (see below in "Configuring the schema").
> +
> +
>  === Downstream extensions ===
>  
>  QAPI schema names that are externally visible, say in the Client JSON
> @@ -771,6 +799,16 @@ Example: a conditional 'bar' enum member.
>    [ 'foo',
>      { 'name' : 'bar', 'if': 'defined(IFCOND)' } ] }
>  
> +Similarly, features can be specified as a dictionary with a 'name' and
> +an 'if' key.
> +
> +Example: a conditional 'allow-negative-numbers' feature
> +
> +{ 'struct': 'TestType',
> +  'data': { 'number': 'int' },
> +  'features': [ { 'name': 'allow-negative-numbers',
> +                  'if' 'defined(IFCOND)' } ] }
> +
>  Please note that you are responsible to ensure that the C code will
>  compile with an arbitrary combination of conditions, since the
>  generators are unable to check it at this point.

Feels bolted on, just like conditionals.  I'm afraid we'll have to
rework this document to arrest its deterioration.

I'm not asking you to do this work.  Let's move on with this patch.

> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index f07869ec73..71944e2e30 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -886,12 +886,25 @@ def check_enum(expr, info):
>  def check_struct(expr, info):
>      name = expr['struct']
>      members = expr['data']
> +    features = expr.get('features')
>  
>      check_type(info, "'data' for struct '%s'" % name, members,
>                 allow_dict=True, allow_optional=True)
>      check_type(info, "'base' for struct '%s'" % name, expr.get('base'),
>                 allow_metas=['struct'])
>  
> +    if features:
> +        if not isinstance(features, list):
> +            raise QAPISemError(info,
> +                               "Struct '%s' requires an array for 'features'" %
> +                               name)
> +        for f in features:
> +            assert isinstance(f, dict)
> +            check_known_keys(info, "feature of struct %s" % (name), f,

Redundant parenthesis: (name)

> +                             ['name'], ['if'])
> +
> +            check_if(f, info)
> +            check_name(info, "Feature of struct %s" % (name), f['name'])

Again.

You managed to reduce the differences to check_enum() nicely since v1,
paving the way for future de-duplication.  I'm not asking you to
de-duplicate now.

pycodestyle-3 complains about whitespace here, and in a few other
places.  Please use it to check your patches for avoidable style nits.

>  
>  def check_known_keys(info, source, keys, required, optional):
>  
> @@ -947,6 +960,10 @@ def normalize_members(members):
>                  continue
>              members[key] = {'type': arg}
>  
> +def normalize_features(features):
> +    if isinstance(features, list):
> +        features[:] = [f if isinstance(f, dict) else {'name': f}
> +                       for f in features]

Duplicates the meat of normalize_enum().  I'm not asking you to
de-duplicate now.

>  
>  def check_exprs(exprs):
>      global all_names
> @@ -986,8 +1003,10 @@ def check_exprs(exprs):
>              normalize_members(expr['data'])
>          elif 'struct' in expr:
>              meta = 'struct'
> -            check_keys(expr_elem, 'struct', ['data'], ['base', 'if'])
> +            check_keys(expr_elem, 'struct', ['data'],
> +                       ['base', 'if', 'features'])
>              normalize_members(expr['data'])
> +            normalize_features(expr.get('features'))
>              struct_types[expr[meta]] = expr
>          elif 'command' in expr:
>              meta = 'command'
> @@ -1126,10 +1145,12 @@ class QAPISchemaVisitor(object):
>      def visit_array_type(self, name, info, ifcond, element_type):
>          pass
>  
> -    def visit_object_type(self, name, info, ifcond, base, members, variants):
> +    def visit_object_type(self, name, info, ifcond, base, members, variants,
> +                          features):
>          pass
>  
> -    def visit_object_type_flat(self, name, info, ifcond, members, variants):
> +    def visit_object_type_flat(self, name, info, ifcond, members, variants,
> +                               features):
>          pass
>  
>      def visit_alternate_type(self, name, info, ifcond, variants):
> @@ -1290,7 +1311,7 @@ class QAPISchemaArrayType(QAPISchemaType):
>  
>  class QAPISchemaObjectType(QAPISchemaType):
>      def __init__(self, name, info, doc, ifcond,
> -                 base, local_members, variants):
> +                 base, local_members, variants, features):
>          # struct has local_members, optional base, and no variants
>          # flat union has base, variants, and no local_members
>          # simple union has local_members, variants, and no base
> @@ -1302,11 +1323,15 @@ class QAPISchemaObjectType(QAPISchemaType):
>          if variants is not None:
>              assert isinstance(variants, QAPISchemaObjectTypeVariants)
>              variants.set_owner(name)
> +        for f in features:
> +            assert isinstance(f, QAPISchemaFeature)
> +            f.set_owner(name)
>          self._base_name = base
>          self.base = None
>          self.local_members = local_members
>          self.variants = variants
>          self.members = None
> +        self.features = features
>  
>      def check(self, schema):
>          QAPISchemaType.check(self, schema)
           if self.members is False:               # check for cycles
               raise QAPISemError(self.info,
                                  "Object %s contains itself" % self.name)
           if self.members:
               return
           self.members = False                    # mark as being checked
           seen = OrderedDict()
           if self._base_name:
               self.base = schema.lookup_type(self._base_name)
               assert isinstance(self.base, QAPISchemaObjectType)
               self.base.check(schema)
               self.base.check_clash(self.info, seen)
           for m in self.local_members:
               m.check(schema)
               m.check_clash(self.info, seen)
               if self.doc:
                   self.doc.connect_member(m)
           self.members = seen.values()
           if self.variants:
> @@ -1332,6 +1357,12 @@ class QAPISchemaObjectType(QAPISchemaType):
>              self.variants.check(schema, seen)
>              assert self.variants.tag_member in self.members
>              self.variants.check_clash(self.info, seen)
> +
> +        # Features are in a namespace separate from members

name space

> +        seen = OrderedDict()

seen = {} suffices.  It doesn't for members (above), because there, we
want seen.values() preserve order.  See commit 23a4b2c6f19.

Fun fact: dict is guaranteed to preserve order as of Python 3.7.

> +        for f in self.features:
> +            f.check_clash(self.info, seen)
> +
>          if self.doc:
>              self.doc.check()
>  
> @@ -1368,12 +1399,15 @@ class QAPISchemaObjectType(QAPISchemaType):
>  
>      def visit(self, visitor):
>          visitor.visit_object_type(self.name, self.info, self.ifcond,
> -                                  self.base, self.local_members, self.variants)
> +                                  self.base, self.local_members, self.variants,
> +                                  self.features)
>          visitor.visit_object_type_flat(self.name, self.info, self.ifcond,
> -                                       self.members, self.variants)
> +                                       self.members, self.variants,
> +                                       self.features)
>  
>  
>  class QAPISchemaMember(object):
> +    """ Represents object members, enum members and features """
>      role = 'member'
>  
>      def __init__(self, name, ifcond=None):
> @@ -1418,6 +1452,8 @@ class QAPISchemaMember(object):
>      def describe(self):
>          return "'%s' %s" % (self.name, self._pretty_owner())
>  
> +class QAPISchemaFeature(QAPISchemaMember):
> +    role = 'feature'
>  
>  class QAPISchemaObjectTypeMember(QAPISchemaMember):
>      def __init__(self, name, typ, optional, ifcond=None):
> @@ -1675,7 +1711,7 @@ class QAPISchema(object):
>                    ('null',   'null',    'QNull' + pointer_suffix)]:
>              self._def_builtin_type(*t)
>          self.the_empty_object_type = QAPISchemaObjectType(
> -            'q_empty', None, None, None, None, [], None)
> +            'q_empty', None, None, None, None, [], None, [])
>          self._def_entity(self.the_empty_object_type)
>  
>          qtypes = ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist',
> @@ -1685,6 +1721,9 @@ class QAPISchema(object):
>          self._def_entity(QAPISchemaEnumType('QType', None, None, None,
>                                              qtype_values, 'QTYPE'))
>  
> +    def _make_features(self, features):
> +        return [QAPISchemaFeature(f['name'], f.get('if')) for f in features]
> +
>      def _make_enum_members(self, values):
>          return [QAPISchemaMember(v['name'], v.get('if')) for v in values]
>  
> @@ -1721,7 +1760,7 @@ class QAPISchema(object):
>              assert ifcond == typ._ifcond # pylint: disable=protected-access
>          else:
>              self._def_entity(QAPISchemaObjectType(name, info, doc, ifcond,
> -                                                  None, members, None))
> +                                                  None, members, None, []))
>          return name
>  
>      def _def_enum_type(self, expr, info, doc):
> @@ -1752,9 +1791,11 @@ class QAPISchema(object):
>          base = expr.get('base')
>          data = expr['data']
>          ifcond = expr.get('if')
> +        features = expr.get('features', [])
>          self._def_entity(QAPISchemaObjectType(name, info, doc, ifcond, base,
>                                                self._make_members(data, info),
> -                                              None))
> +                                              None,
> +                                              self._make_features(features)))

I like this much better than v1, because it's so close to the IR for
similar things.

>  
>      def _make_variant(self, case, typ, ifcond):
>          return QAPISchemaObjectTypeVariant(case, typ, ifcond)
> @@ -1795,7 +1836,7 @@ class QAPISchema(object):
>              QAPISchemaObjectType(name, info, doc, ifcond, base, members,
>                                   QAPISchemaObjectTypeVariants(tag_name,
>                                                                tag_member,
> -                                                              variants)))
> +                                                              variants), []))
>  
>      def _def_alternate_type(self, expr, info, doc):
>          name = expr['alternate']
> diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
> index 5c8c136899..433e9fcbfb 100755
> --- a/scripts/qapi/doc.py
> +++ b/scripts/qapi/doc.py
> @@ -220,7 +220,8 @@ class QAPISchemaGenDocVisitor(qapi.common.QAPISchemaVisitor):
>                                 body=texi_entity(doc, 'Values', ifcond,
>                                                  member_func=texi_enum_value)))
>  
> -    def visit_object_type(self, name, info, ifcond, base, members, variants):
> +    def visit_object_type(self, name, info, ifcond, base, members, variants,
> +                          features):
>          doc = self.cur_doc
>          if base and base.is_implicit():
>              base = None
> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index f7f2ca07e4..62cbf94a85 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -188,11 +188,15 @@ const QLitObject %(c_name)s = %(c_string)s;
>          self._gen_qlit('[' + element + ']', 'array', {'element-type': element},
>                         ifcond)
>  
> -    def visit_object_type_flat(self, name, info, ifcond, members, variants):
> +    def visit_object_type_flat(self, name, info, ifcond, members, variants,
> +                               features):
>          obj = {'members': [self._gen_member(m) for m in members]}
>          if variants:
>              obj.update(self._gen_variants(variants.tag_member.name,
>                                            variants.variants))
> +        if features:
> +            obj['features'] = [ (f.name, {'if': f.ifcond}) for f in features ]
> +

Another place where features have become like enums (see
visit_enum_type()).  De-duplication seems not worthwhile here.

>          self._gen_qlit(name, 'object', obj, ifcond)
>  
>      def visit_alternate_type(self, name, info, ifcond, variants):
> diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
> index 2bd6fcd44f..3edd9374aa 100644
> --- a/scripts/qapi/types.py
> +++ b/scripts/qapi/types.py
> @@ -227,7 +227,8 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisitor):
>              self._genh.add(gen_array(name, element_type))
>              self._gen_type_cleanup(name)
>  
> -    def visit_object_type(self, name, info, ifcond, base, members, variants):
> +    def visit_object_type(self, name, info, ifcond, base, members, variants,
> +                          features):
>          # Nothing to do for the special empty builtin
>          if name == 'q_empty':
>              return
> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
> index 826b8066e1..c1cd675c95 100644
> --- a/scripts/qapi/visit.py
> +++ b/scripts/qapi/visit.py
> @@ -326,7 +326,8 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVisitor):
>              self._genh.add(gen_visit_decl(name))
>              self._genc.add(gen_visit_list(name, element_type))
>  
> -    def visit_object_type(self, name, info, ifcond, base, members, variants):
> +    def visit_object_type(self, name, info, ifcond, base, members, variants,
> +                          features):
>          # Nothing to do for the special empty builtin
>          if name == 'q_empty':
>              return
> diff --git a/tests/qapi-schema/double-type.err b/tests/qapi-schema/double-type.err
> index 799193dba1..69457173a7 100644
> --- a/tests/qapi-schema/double-type.err
> +++ b/tests/qapi-schema/double-type.err
> @@ -1,2 +1,2 @@
>  tests/qapi-schema/double-type.json:2: Unknown key 'command' in struct 'bar'
> -Valid keys are 'base', 'data', 'if', 'struct'.
> +Valid keys are 'base', 'data', 'features', 'if', 'struct'.
> diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
> index d21fca01fc..f2d6815c86 100644
> --- a/tests/qapi-schema/test-qapi.py
> +++ b/tests/qapi-schema/test-qapi.py
> @@ -38,7 +38,8 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>          print('array %s %s' % (name, element_type.name))
>          self._print_if(ifcond)
>  
> -    def visit_object_type(self, name, info, ifcond, base, members, variants):
> +    def visit_object_type(self, name, info, ifcond, base, members, variants,
> +                          features):
>          print('object %s' % name)
>          if base:
>              print('    base %s' % base.name)

Printing @features is left to PATCH 2.  Okay.

> diff --git a/tests/qapi-schema/unknown-expr-key.err b/tests/qapi-schema/unknown-expr-key.err
> index 6ff8bb99c5..4340eaf894 100644
> --- a/tests/qapi-schema/unknown-expr-key.err
> +++ b/tests/qapi-schema/unknown-expr-key.err
> @@ -1,2 +1,2 @@
>  tests/qapi-schema/unknown-expr-key.json:2: Unknown keys 'bogus', 'phony' in struct 'bar'
> -Valid keys are 'base', 'data', 'if', 'struct'.
> +Valid keys are 'base', 'data', 'features', 'if', 'struct'.

Looks pretty good now!

