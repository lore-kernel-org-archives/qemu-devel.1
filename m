Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447A9C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF77920674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6rbEXGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF77920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuYT-0001bW-33
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDtGU-00068i-3y
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:11:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDtGS-0007Ho-4b
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:10:58 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39530)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jDtGR-0007E9-SY
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:10:56 -0400
Received: by mail-wr1-x441.google.com with SMTP id h6so1887306wrs.6
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ftKu+V9cm+BUGJzIYqmav6sjdRsT4fHhxpYIdjfzXi8=;
 b=s6rbEXGoQ+4sGg3mj9OgnU7l/KRoIqhQlT+8LwKTDYZRMRZxlPcvHSSK02UqNGha3Z
 7iDB5CcgVVWMnGTQfoi+Fwl2uUhm3VxxqKeiQgcsrK3MUHapGxczwsS02pokubwndX/P
 P6NE/XIgyTZwam67OwJDHgIclASWnj0ZVKinK93AEOFx1pqdCEEfoDZgOlZR28LKPI1m
 P+39qQEQRsdFYQgajfffLWyZHbC/gqQ7wryrWW5hEbSfy2HNZN6b7NkLUcQUG7oDenBT
 nRir7Be6O05tiYRZkMRIr1F779znJJnjTKdm066hGq3t4zpH4rFeBgvygKtzWO5jmiuP
 uOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ftKu+V9cm+BUGJzIYqmav6sjdRsT4fHhxpYIdjfzXi8=;
 b=JCzDQmRJkDvhU/uJtkyWyvuhEvB5NjoOm/K8dPVDhrECGn5mjSQLG5As3H9oqT7xBJ
 adB71Zp/QG43mlBHvUz4VXopy/pnKaJbWevAU1D0e/AZS5CER3tppzXbx1+cuiVn+lsM
 rW+eim+NiApnP9WaS7JRfxZ6yA8QDHtlod6pcQOYrZKGwh+XG7S8pzi+Z5Fix7D+YAd8
 LHxSAjEGE5y+/yvi0pCrUO0fovjx5Yt6Hlmo12EREH05tv4XY15AyVvmKbpDYB2L9dPQ
 1laKtnXH7q+BuDimKJotVpza16vHLO3QrJnMv6H128w2BqHrqTmNgYu9BnVUdXQFRieE
 ILMw==
X-Gm-Message-State: ANhLgQ0Sfu1Mp4SSQ7kk5URdDDW5YNYu8ija/y3q6uJWK55m3ZycUt6R
 SxZvW3mfwbB47EEOBKVZJ+fDMKw+IHoHnLJKpTk=
X-Google-Smtp-Source: ADFU+vuz+rS5NVcPEOHkv1ngfJVkPfTMyn1+rjKy4D2UgBKTnHFTSJHtblvDUDMgsS2TsUjk8GNYrYN7U4/Z+VV5smo=
X-Received: by 2002:a05:6000:4a:: with SMTP id
 k10mr297498wrx.381.1584378654678; 
 Mon, 16 Mar 2020 10:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-21-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-21-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Mar 2020 18:10:42 +0100
Message-ID: <CAJ+F1C+vTVbho-K38tiPC0FYx3KadZDy7L8hNn6iBydWuKFo8g@mail.gmail.com>
Subject: Re: [PATCH v3 20/34] qapi: Add feature flags to struct members
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 15, 2020 at 4:23 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  docs/devel/qapi-code-gen.txt            |  4 +++-
>  tests/qapi-schema/doc-good.texi         |  2 ++
>  qapi/introspect.json                    |  6 +++++-
>  scripts/qapi/expr.py                    |  3 ++-
>  scripts/qapi/introspect.py              |  2 +-
>  scripts/qapi/schema.py                  | 25 ++++++++++++++++++++-----
>  tests/qapi-schema/doc-good.json         |  5 ++++-
>  tests/qapi-schema/doc-good.out          |  3 +++
>  tests/qapi-schema/qapi-schema-test.json |  2 +-
>  tests/qapi-schema/qapi-schema-test.out  |  1 +
>  tests/qapi-schema/test-qapi.py          |  7 ++++---
>  11 files changed, 46 insertions(+), 14 deletions(-)
>
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index 9fce78dcad..a1ef1cfd61 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -234,7 +234,9 @@ Syntax:
>                 '*features': FEATURES }
>      MEMBERS =3D { MEMBER, ... }
>      MEMBER =3D STRING : TYPE-REF
> -           | STRING : { 'type': TYPE-REF, '*if': COND }
> +           | STRING : { 'type': TYPE-REF,
> +                        '*if': COND,
> +                        '*features': FEATURES }
>
>  Member 'struct' names the struct type.
>
> diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good=
.texi
> index 76b396dae6..7f28fb7a0f 100644
> --- a/tests/qapi-schema/doc-good.texi
> +++ b/tests/qapi-schema/doc-good.texi
> @@ -132,6 +132,8 @@ Not documented
>  @table @asis
>  @item @code{variant1-feat}
>  a feature
> +@item @code{member-feat}
> +a member feature
>  @end table
>
>  @end deftp
> diff --git a/qapi/introspect.json b/qapi/introspect.json
> index da3e176899..b1aabd4cfd 100644
> --- a/qapi/introspect.json
> +++ b/qapi/introspect.json
> @@ -206,11 +206,15 @@
>  #           Future extension: if present and non-null, the parameter
>  #           is optional, and defaults to this value.
>  #
> +# @features: names of features associated with the member, in no
> +#            particular order.  (since 5.0)
> +#
>  # Since: 2.5
>  ##
>  { 'struct': 'SchemaInfoObjectMember',
> -  'data': { 'name': 'str', 'type': 'str', '*default': 'any' } }
> +  'data': { 'name': 'str', 'type': 'str', '*default': 'any',
>  # @default's type must be null or match @type
> +            '*features': [ 'str' ] } }
>
>  ##
>  # @SchemaInfoObjectVariant:
> diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
> index f9c4448980..2942520399 100644
> --- a/scripts/qapi/expr.py
> +++ b/scripts/qapi/expr.py
> @@ -167,8 +167,9 @@ def check_type(value, info, source,
>                         allow_optional=3DTrue, permit_upper=3Dpermit_uppe=
r)
>          if c_name(key, False) =3D=3D 'u' or c_name(key, False).startswit=
h('has_'):
>              raise QAPISemError(info, "%s uses reserved name" % key_sourc=
e)
> -        check_keys(arg, info, key_source, ['type'], ['if'])
> +        check_keys(arg, info, key_source, ['type'], ['if', 'features'])
>          check_if(arg, info, key_source)
> +        check_features(arg.get('features'), info)
>          check_type(arg['type'], info, key_source, allow_array=3DTrue)
>
>
> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index a3fa9865db..23652be810 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -173,7 +173,7 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>          obj =3D {'name': member.name, 'type': self._use_type(member.type=
)}
>          if member.optional:
>              obj['default'] =3D None
> -        return _make_tree(obj, member.ifcond, None)
> +        return _make_tree(obj, member.ifcond, member.features)
>
>      def _gen_variants(self, tag_name, variants):
>          return {'tag': tag_name,
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 59e1f5a395..6ee3677215 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -668,18 +668,31 @@ class QAPISchemaFeature(QAPISchemaMember):
>
>
>  class QAPISchemaObjectTypeMember(QAPISchemaMember):
> -    def __init__(self, name, info, typ, optional, ifcond=3DNone):
> +    def __init__(self, name, info, typ, optional, ifcond=3DNone, feature=
s=3DNone):
>          super().__init__(name, info, ifcond)
>          assert isinstance(typ, str)
>          assert isinstance(optional, bool)
> +        for f in features or []:
> +            assert isinstance(f, QAPISchemaFeature)
> +            f.set_defined_in(name)
>          self._type_name =3D typ
>          self.type =3D None
>          self.optional =3D optional
> +        self.features =3D features or []
>
>      def check(self, schema):
>          assert self.defined_in
>          self.type =3D schema.resolve_type(self._type_name, self.info,
>                                          self.describe)
> +        seen =3D {}
> +        for f in self.features:
> +            f.check_clash(self.info, seen)
> +
> +    def connect_doc(self, doc):
> +        super().connect_doc(doc)
> +        if doc:
> +            for f in self.features:
> +                doc.connect_feature(f)
>
>
>  class QAPISchemaVariant(QAPISchemaObjectTypeMember):
> @@ -962,7 +975,7 @@ class QAPISchema:
>              name, info, doc, ifcond, features,
>              self._make_enum_members(data, info), prefix))
>
> -    def _make_member(self, name, typ, ifcond, info):
> +    def _make_member(self, name, typ, ifcond, features, info):
>          optional =3D False
>          if name.startswith('*'):
>              name =3D name[1:]
> @@ -970,10 +983,12 @@ class QAPISchema:
>          if isinstance(typ, list):
>              assert len(typ) =3D=3D 1
>              typ =3D self._make_array_type(typ[0], info)
> -        return QAPISchemaObjectTypeMember(name, info, typ, optional, ifc=
ond)
> +        return QAPISchemaObjectTypeMember(name, info, typ, optional, ifc=
ond,
> +                                          self._make_features(features, =
info))
>
>      def _make_members(self, data, info):
> -        return [self._make_member(key, value['type'], value.get('if'), i=
nfo)
> +        return [self._make_member(key, value['type'], value.get('if'),
> +                                  value.get('features'), info)
>                  for (key, value) in data.items()]
>
>      def _def_struct_type(self, expr, info, doc):
> @@ -996,7 +1011,7 @@ class QAPISchema:
>              typ =3D self._make_array_type(typ[0], info)
>          typ =3D self._make_implicit_object_type(
>              typ, info, self.lookup_type(typ),
> -            'wrapper', [self._make_member('data', typ, None, info)])
> +            'wrapper', [self._make_member('data', typ, None, None, info)=
])
>          return QAPISchemaVariant(case, info, typ, ifcond)
>
>      def _def_union_type(self, expr, info, doc):
> diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good=
.json
> index 457b8b2cdf..ddd89d1233 100644
> --- a/tests/qapi-schema/doc-good.json
> +++ b/tests/qapi-schema/doc-good.json
> @@ -78,10 +78,13 @@
>  #
>  # Features:
>  # @variant1-feat: a feature
> +# @member-feat: a member feature
>  ##
>  { 'struct': 'Variant1',
>    'features': [ 'variant1-feat' ],
> -  'data': { 'var1': { 'type': 'str', 'if': 'defined(IFSTR)' } } }
> +  'data': { 'var1': { 'type': 'str',
> +                      'features': [ 'member-feat' ],
> +                      'if': 'defined(IFSTR)' } } }
>
>  ##
>  # @Variant2:
> diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.=
out
> index 9bcb2b3e91..6757dd26a2 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -21,6 +21,7 @@ object Base
>  object Variant1
>      member var1: str optional=3DFalse
>          if ['defined(IFSTR)']
> +        feature member-feat
>      feature variant1-feat
>  object Variant2
>  object Object
> @@ -135,6 +136,8 @@ Another paragraph (but no @var: line)
>
>      feature=3Dvariant1-feat
>  a feature
> +    feature=3Dmember-feat
> +a member feature
>  doc symbol=3DVariant2
>      body=3D
>
> diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
> index fa4f3a15da..f576c337af 100644
> --- a/tests/qapi-schema/qapi-schema-test.json
> +++ b/tests/qapi-schema/qapi-schema-test.json
> @@ -258,7 +258,7 @@
>    'data': { 'foo': 'int' },
>    'features': [] }
>  { 'struct': 'FeatureStruct1',
> -  'data': { 'foo': 'int' },
> +  'data': { 'foo': { 'type': 'int', 'features': [ 'member-feature1' ] } =
},
>    'features': [ 'feature1' ] }
>  { 'struct': 'FeatureStruct2',
>    'data': { 'foo': 'int' },
> diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
> index 1cbd0802b3..cd863ae966 100644
> --- a/tests/qapi-schema/qapi-schema-test.out
> +++ b/tests/qapi-schema/qapi-schema-test.out
> @@ -359,6 +359,7 @@ object FeatureStruct0
>      member foo: int optional=3DFalse
>  object FeatureStruct1
>      member foo: int optional=3DFalse
> +        feature member-feature1
>      feature feature1
>  object FeatureStruct2
>      member foo: int optional=3DFalse
> diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
> index 8e09e54edb..f396b471eb 100755
> --- a/tests/qapi-schema/test-qapi.py
> +++ b/tests/qapi-schema/test-qapi.py
> @@ -55,6 +55,7 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>              print('    member %s: %s optional=3D%s'
>                    % (m.name, m.type.name, m.optional))
>              self._print_if(m.ifcond, 8)
> +            self._print_features(m.features, indent=3D8)
>          self._print_variants(variants)
>          self._print_if(ifcond)
>          self._print_features(features)
> @@ -96,11 +97,11 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>              print('%sif %s' % (' ' * indent, ifcond))
>
>      @classmethod
> -    def _print_features(cls, features):
> +    def _print_features(cls, features, indent=3D4):
>          if features:
>              for f in features:
> -                print('    feature %s' % f.name)
> -                cls._print_if(f.ifcond, 8)
> +                print('%sfeature %s' % (' ' * indent, f.name))
> +                cls._print_if(f.ifcond, indent + 4)
>
>
>  def test_frontend(fname):
> --
> 2.21.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

