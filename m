Received: from eggs.gnu.org ([2001:4830:134:3::10]:54320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gWgsh-0007vl-Qg
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:11:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gWgse-000159-QM
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:11:19 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gWgsc-00012B-H4
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:11:16 -0500
Received: by mail-wr1-x443.google.com with SMTP id t27so13818024wra.6
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 04:11:14 -0800 (PST)
MIME-Version: 1.0
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
	<20181208111606.8505-14-marcandre.lureau@redhat.com>
	<87a7lde1lg.fsf@dusky.pond.sub.org>
In-Reply-To: <87a7lde1lg.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 11 Dec 2018 16:11:00 +0400
Message-ID: <CAJ+F1CKFipFDJcO=cFwAUO+7Y_dx7-DbJgfaBwyk9zJj=XR3dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v7 13/27] qapi: add a dictionary
 form for TYPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi

On Mon, Dec 10, 2018 at 9:26 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Wherever a struct/union/alternate/command/event member with NAME: TYPE
> > form is accepted, desugar it to a NAME: { 'type': TYPE } form.
> >
> > This will allow to add new member details, such as 'if' in the
> > following patch to introduce conditionals, or 'default' for default
> > values etc.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  scripts/qapi/common.py                        | 71 ++++++++++++++-----
> >  tests/Makefile.include                        |  6 ++
> >  tests/qapi-schema/alternate-invalid-dict.err  |  1 +
> >  tests/qapi-schema/alternate-invalid-dict.exit |  1 +
> >  tests/qapi-schema/alternate-invalid-dict.json |  4 ++
> >  tests/qapi-schema/alternate-invalid-dict.out  |  0
> >  .../qapi-schema/event-member-invalid-dict.err |  1 +
> >  .../event-member-invalid-dict.exit            |  1 +
> >  .../event-member-invalid-dict.json            |  2 +
> >  .../qapi-schema/event-member-invalid-dict.out |  0
> >  tests/qapi-schema/event-nest-struct.json      |  2 +-
> >  .../flat-union-inline-invalid-dict.err        |  1 +
> >  .../flat-union-inline-invalid-dict.exit       |  1 +
> >  .../flat-union-inline-invalid-dict.json       | 11 +++
> >  .../flat-union-inline-invalid-dict.out        |  0
> >  tests/qapi-schema/flat-union-inline.json      |  2 +-
> >  .../nested-struct-data-invalid-dict.err       |  1 +
> >  .../nested-struct-data-invalid-dict.exit      |  1 +
> >  .../nested-struct-data-invalid-dict.json      |  3 +
> >  .../nested-struct-data-invalid-dict.out       |  0
> >  tests/qapi-schema/nested-struct-data.json     |  2 +-
> >  tests/qapi-schema/qapi-schema-test.json       | 10 +--
> >  .../struct-member-invalid-dict.err            |  1 +
> >  .../struct-member-invalid-dict.exit           |  1 +
> >  .../struct-member-invalid-dict.json           |  3 +
> >  .../struct-member-invalid-dict.out            |  0
> >  .../qapi-schema/union-branch-invalid-dict.err |  1 +
> >  .../union-branch-invalid-dict.exit            |  1 +
> >  .../union-branch-invalid-dict.json            |  4 ++
> >  .../qapi-schema/union-branch-invalid-dict.out |  0
> >  30 files changed, 106 insertions(+), 26 deletions(-)
> >  create mode 100644 tests/qapi-schema/alternate-invalid-dict.err
> >  create mode 100644 tests/qapi-schema/alternate-invalid-dict.exit
> >  create mode 100644 tests/qapi-schema/alternate-invalid-dict.json
> >  create mode 100644 tests/qapi-schema/alternate-invalid-dict.out
> >  create mode 100644 tests/qapi-schema/event-member-invalid-dict.err
> >  create mode 100644 tests/qapi-schema/event-member-invalid-dict.exit
> >  create mode 100644 tests/qapi-schema/event-member-invalid-dict.json
> >  create mode 100644 tests/qapi-schema/event-member-invalid-dict.out
> >  create mode 100644 tests/qapi-schema/flat-union-inline-invalid-dict.er=
r
> >  create mode 100644 tests/qapi-schema/flat-union-inline-invalid-dict.ex=
it
> >  create mode 100644 tests/qapi-schema/flat-union-inline-invalid-dict.js=
on
> >  create mode 100644 tests/qapi-schema/flat-union-inline-invalid-dict.ou=
t
> >  create mode 100644 tests/qapi-schema/nested-struct-data-invalid-dict.e=
rr
> >  create mode 100644 tests/qapi-schema/nested-struct-data-invalid-dict.e=
xit
> >  create mode 100644 tests/qapi-schema/nested-struct-data-invalid-dict.j=
son
> >  create mode 100644 tests/qapi-schema/nested-struct-data-invalid-dict.o=
ut
> >  create mode 100644 tests/qapi-schema/struct-member-invalid-dict.err
> >  create mode 100644 tests/qapi-schema/struct-member-invalid-dict.exit
> >  create mode 100644 tests/qapi-schema/struct-member-invalid-dict.json
> >  create mode 100644 tests/qapi-schema/struct-member-invalid-dict.out
> >  create mode 100644 tests/qapi-schema/union-branch-invalid-dict.err
> >  create mode 100644 tests/qapi-schema/union-branch-invalid-dict.exit
> >  create mode 100644 tests/qapi-schema/union-branch-invalid-dict.json
> >  create mode 100644 tests/qapi-schema/union-branch-invalid-dict.out
> >
> > diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> > index 95e55b3f44..4b3ba53dc7 100644
> > --- a/scripts/qapi/common.py
> > +++ b/scripts/qapi/common.py
> > @@ -588,11 +588,13 @@ def discriminator_find_enum_define(expr):
> >      if not base_members:
> >          return None
> >
> > -    discriminator_type =3D base_members.get(discriminator)
> > -    if not discriminator_type:
> > +    discriminator_value =3D base_members.get(discriminator)
> > +    if not discriminator_value:
> >          return None
> >
> > -    return enum_types.get(discriminator_type)
> > +    if isinstance(discriminator_value, dict):
> > +        discriminator_value =3D discriminator_value['type']
> > +    return enum_types.get(discriminator_value)
>
> As in PATCH 08, this is slightly more complicated than v6 because @expr
> isn't normalized.  I can't say offhand whether normalizing in the place
> I suggested in my review of v6 would avoid this complication.
>
> >
> >
> >  # Names must be letters, numbers, -, and _.  They must start with lett=
er,
> > @@ -660,6 +662,15 @@ def check_if(expr, info):
> >          check_if_str(ifcond, info)
> >
> >
> > +def normalize_members(expr, field):
> > +    members =3D expr.get(field)
> > +    if isinstance(members, OrderedDict):
> > +        for key, arg in members.items():
> > +            if isinstance(arg, dict):
> > +                continue
> > +            members[key] =3D {'type': arg}
> > +
> > +
> >  def check_type(info, source, value, allow_array=3DFalse,
> >                 allow_implicit=3DFalse, allow_optional=3DFalse,
> >                 allow_metas=3D[]):
> > @@ -704,8 +715,14 @@ def check_type(info, source, value, allow_array=3D=
False,
> >                                 % (source, key))
> >          # Todo: allow dictionaries to represent default values of
> >          # an optional argument.
> > -        check_type(info, "Member '%s' of %s" % (key, source), arg,
> > -                   allow_array=3DTrue,
> > +        if isinstance(arg, dict):
> > +            check_known_keys(info, "member '%s' of %s" % (key, source)=
,
> > +                             arg, ['type'], [])
> > +            typ =3D arg['type']
> > +        else:
> > +            typ =3D arg
> > +        check_type(info, "Member '%s' of %s" % (key, source),
> > +                   typ, allow_array=3DTrue,
> >                     allow_metas=3D['built-in', 'union', 'alternate', 's=
truct',
> >                                  'enum'])
> >
>
> Slightly more complicated than v6, this time because members of the
> implicit struct type aren't normalized, yet.
>
> > @@ -776,13 +793,15 @@ def check_union(expr, info):
> >          # member of the base struct.
> >          check_name(info, "Discriminator of flat union '%s'" % name,
> >                     discriminator)
> > -        discriminator_type =3D base_members.get(discriminator)
> > -        if not discriminator_type:
> > +        discriminator_value =3D base_members.get(discriminator)
> > +        if not discriminator_value:
> >              raise QAPISemError(info,
> >                                 "Discriminator '%s' is not a member of =
base "
> >                                 "struct '%s'"
> >                                 % (discriminator, base))
> > -        enum_define =3D enum_types.get(discriminator_type)
> > +        if isinstance(discriminator_value, dict):
> > +            discriminator_value =3D discriminator_value['type']
> > +        enum_define =3D enum_types.get(discriminator_value)
> >          allow_metas =3D ['struct']
> >          # Do not allow string discriminator
> >          if not enum_define:
> > @@ -795,10 +814,16 @@ def check_union(expr, info):
> >          raise QAPISemError(info, "Union '%s' cannot have empty 'data'"=
 % name)
> >      for (key, value) in members.items():
> >          check_name(info, "Member of union '%s'" % name, key)
> > +        if isinstance(value, dict):
> > +            check_known_keys(info, "member '%s' of union '%s'" % (key,=
 name),
> > +                             value, ['type'], [])
> > +            typ =3D value['type']
> > +        else:
> > +            typ =3D value
>
> Likewise.
>
> >
> >          # Each value must name a known type
> >          check_type(info, "Member '%s' of union '%s'" % (key, name),
> > -                   value, allow_array=3Dnot base, allow_metas=3Dallow_=
metas)
> > +                   typ, allow_array=3Dnot base, allow_metas=3Dallow_me=
tas)
> >
> >          # If the discriminator names an enum type, then all members
> >          # of 'data' must also be members of the enum type.
> > @@ -822,18 +847,24 @@ def check_alternate(expr, info):
> >                             "in 'data'" % name)
> >      for (key, value) in members.items():
> >          check_name(info, "Member of alternate '%s'" % name, key)
> > +        if isinstance(value, dict):
> > +            check_known_keys(info,
> > +                             "member '%s' of alternate '%s'" % (key, n=
ame),
> > +                             value, ['type'], [])
> > +            typ =3D value['type']
> > +        else:
> > +            typ =3D value
>
> Likewise.
>
> >
> >          # Ensure alternates have no type conflicts.
> > -        check_type(info, "Member '%s' of alternate '%s'" % (key, name)=
,
> > -                   value,
> > +        check_type(info, "Member '%s' of alternate '%s'" % (key, name)=
, typ,
> >                     allow_metas=3D['built-in', 'union', 'struct', 'enum=
'])
> > -        qtype =3D find_alternate_member_qtype(value)
> > +        qtype =3D find_alternate_member_qtype(typ)
> >          if not qtype:
> >              raise QAPISemError(info, "Alternate '%s' member '%s' canno=
t use "
> > -                               "type '%s'" % (name, key, value))
> > +                               "type '%s'" % (name, key, typ))
> >          conflicting =3D set([qtype])
> >          if qtype =3D=3D 'QTYPE_QSTRING':
> > -            enum_expr =3D enum_types.get(value)
> > +            enum_expr =3D enum_types.get(typ)
> >              if enum_expr:
> >                  for v in enum_get_names(enum_expr):
> >                      if v in ['on', 'off']:
> > @@ -1035,6 +1066,10 @@ def normalize_exprs(exprs):
> >          expr =3D expr_elem['expr']
> >          if 'enum' in expr:
> >              normalize_enum(expr)
> > +        elif 'union' in expr:
> > +            normalize_members(expr, 'base')
> > +        if {'union', 'alternate', 'struct', 'command', 'event'} & set(=
expr):
> > +            normalize_members(expr, 'data')
> >
> >      return exprs
> >
> > @@ -1738,7 +1773,7 @@ class QAPISchema(object):
> >          return QAPISchemaObjectTypeMember(name, typ, optional)
> >
> >      def _make_members(self, data, info):
> > -        return [self._make_member(key, value, info)
> > +        return [self._make_member(key, value['type'], info)
> >                  for (key, value) in data.items()]
> >
> >      def _def_struct_type(self, expr, info, doc):
> > @@ -1774,11 +1809,11 @@ class QAPISchema(object):
> >                  name, info, doc, ifcond,
> >                  'base', self._make_members(base, info))
> >          if tag_name:
> > -            variants =3D [self._make_variant(key, value)
> > +            variants =3D [self._make_variant(key, value['type'])
> >                          for (key, value) in data.items()]
> >              members =3D []
> >          else:
> > -            variants =3D [self._make_simple_variant(key, value, info)
> > +            variants =3D [self._make_simple_variant(key, value['type']=
, info)
> >                          for (key, value) in data.items()]
> >              typ =3D self._make_implicit_enum_type(name, info, ifcond,
> >                                                  [v.name for v in varia=
nts])
> > @@ -1794,7 +1829,7 @@ class QAPISchema(object):
> >          name =3D expr['alternate']
> >          data =3D expr['data']
> >          ifcond =3D expr.get('if')
> > -        variants =3D [self._make_variant(key, value)
> > +        variants =3D [self._make_variant(key, value['type'])
> >                      for (key, value) in data.items()]
> >          tag_member =3D QAPISchemaObjectTypeMember('type', 'QType', Fal=
se)
> >          self._def_entity(
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index 3c9eea27fd..ea5d1e8787 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -318,6 +318,7 @@ qapi-schema +=3D alternate-conflict-string.json
> >  qapi-schema +=3D alternate-conflict-bool-string.json
> >  qapi-schema +=3D alternate-conflict-num-string.json
> >  qapi-schema +=3D alternate-empty.json
> > +qapi-schema +=3D alternate-invalid-dict.json
> >  qapi-schema +=3D alternate-nested.json
> >  qapi-schema +=3D alternate-unknown.json
> >  qapi-schema +=3D args-alternate.json
> > @@ -394,6 +395,7 @@ qapi-schema +=3D escape-too-big.json
> >  qapi-schema +=3D escape-too-short.json
> >  qapi-schema +=3D event-boxed-empty.json
> >  qapi-schema +=3D event-case.json
> > +qapi-schema +=3D event-member-invalid-dict.json
> >  qapi-schema +=3D event-nest-struct.json
> >  qapi-schema +=3D flat-union-array-branch.json
> >  qapi-schema +=3D flat-union-bad-base.json
> > @@ -403,6 +405,7 @@ qapi-schema +=3D flat-union-base-union.json
> >  qapi-schema +=3D flat-union-clash-member.json
> >  qapi-schema +=3D flat-union-empty.json
> >  qapi-schema +=3D flat-union-inline.json
> > +qapi-schema +=3D flat-union-inline-invalid-dict.json
> >  qapi-schema +=3D flat-union-int-branch.json
> >  qapi-schema +=3D flat-union-invalid-branch-key.json
> >  qapi-schema +=3D flat-union-invalid-discriminator.json
> > @@ -430,6 +433,7 @@ qapi-schema +=3D missing-comma-list.json
> >  qapi-schema +=3D missing-comma-object.json
> >  qapi-schema +=3D missing-type.json
> >  qapi-schema +=3D nested-struct-data.json
> > +qapi-schema +=3D nested-struct-data-invalid-dict.json
> >  qapi-schema +=3D non-objects.json
> >  qapi-schema +=3D oob-test.json
> >  qapi-schema +=3D allow-preconfig-test.json
> > @@ -460,6 +464,7 @@ qapi-schema +=3D returns-whitelist.json
> >  qapi-schema +=3D struct-base-clash-deep.json
> >  qapi-schema +=3D struct-base-clash.json
> >  qapi-schema +=3D struct-data-invalid.json
> > +qapi-schema +=3D struct-member-invalid-dict.json
> >  qapi-schema +=3D struct-member-invalid.json
> >  qapi-schema +=3D trailing-comma-list.json
> >  qapi-schema +=3D trailing-comma-object.json
> > @@ -471,6 +476,7 @@ qapi-schema +=3D unicode-str.json
> >  qapi-schema +=3D union-base-empty.json
> >  qapi-schema +=3D union-base-no-discriminator.json
> >  qapi-schema +=3D union-branch-case.json
> > +qapi-schema +=3D union-branch-invalid-dict.json
> >  qapi-schema +=3D union-clash-branches.json
> >  qapi-schema +=3D union-empty.json
> >  qapi-schema +=3D union-invalid-base.json
> > diff --git a/tests/qapi-schema/alternate-invalid-dict.err b/tests/qapi-=
schema/alternate-invalid-dict.err
> > new file mode 100644
> > index 0000000000..631d46628e
> > --- /dev/null
> > +++ b/tests/qapi-schema/alternate-invalid-dict.err
> > @@ -0,0 +1 @@
> > +tests/qapi-schema/alternate-invalid-dict.json:2: Key 'type' is missing=
 from member 'two' of alternate 'Alt'
> > diff --git a/tests/qapi-schema/alternate-invalid-dict.exit b/tests/qapi=
-schema/alternate-invalid-dict.exit
> > new file mode 100644
> > index 0000000000..d00491fd7e
> > --- /dev/null
> > +++ b/tests/qapi-schema/alternate-invalid-dict.exit
> > @@ -0,0 +1 @@
> > +1
> > diff --git a/tests/qapi-schema/alternate-invalid-dict.json b/tests/qapi=
-schema/alternate-invalid-dict.json
> > new file mode 100644
> > index 0000000000..8e0b2ac287
> > --- /dev/null
> > +++ b/tests/qapi-schema/alternate-invalid-dict.json
> > @@ -0,0 +1,4 @@
> > +# exploded member form must have a 'type'
> > +{ 'alternate': 'Alt',
> > +  'data': { 'one': 'str',
> > +            'two': { 'if': 'foo' } } }
> > diff --git a/tests/qapi-schema/alternate-invalid-dict.out b/tests/qapi-=
schema/alternate-invalid-dict.out
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/qapi-schema/event-member-invalid-dict.err b/tests/qa=
pi-schema/event-member-invalid-dict.err
> > new file mode 100644
> > index 0000000000..1a57fa29b0
> > --- /dev/null
> > +++ b/tests/qapi-schema/event-member-invalid-dict.err
> > @@ -0,0 +1 @@
> > +tests/qapi-schema/event-member-invalid-dict.json:1: Key 'type' is miss=
ing from member 'a' of 'data' for event 'EVENT_A'
> > diff --git a/tests/qapi-schema/event-member-invalid-dict.exit b/tests/q=
api-schema/event-member-invalid-dict.exit
> > new file mode 100644
> > index 0000000000..d00491fd7e
> > --- /dev/null
> > +++ b/tests/qapi-schema/event-member-invalid-dict.exit
> > @@ -0,0 +1 @@
> > +1
> > diff --git a/tests/qapi-schema/event-member-invalid-dict.json b/tests/q=
api-schema/event-member-invalid-dict.json
> > new file mode 100644
> > index 0000000000..ee6f3ecb6f
> > --- /dev/null
> > +++ b/tests/qapi-schema/event-member-invalid-dict.json
> > @@ -0,0 +1,2 @@
> > +{ 'event': 'EVENT_A',
> > +  'data': { 'a' : { 'string' : 'str', 'integer': 'int' }, 'b' : 'str' =
} }
> > diff --git a/tests/qapi-schema/event-member-invalid-dict.out b/tests/qa=
pi-schema/event-member-invalid-dict.out
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/qapi-schema/event-nest-struct.json b/tests/qapi-sche=
ma/event-nest-struct.json
> > index ee6f3ecb6f..355ddaeff1 100644
> > --- a/tests/qapi-schema/event-nest-struct.json
> > +++ b/tests/qapi-schema/event-nest-struct.json
> > @@ -1,2 +1,2 @@
> >  { 'event': 'EVENT_A',
> > -  'data': { 'a' : { 'string' : 'str', 'integer': 'int' }, 'b' : 'str' =
} }
> > +  'data': { 'a' : { 'type' : { 'integer': 'int' } }, 'b' : 'str' } }
> > diff --git a/tests/qapi-schema/flat-union-inline-invalid-dict.err b/tes=
ts/qapi-schema/flat-union-inline-invalid-dict.err
> > new file mode 100644
> > index 0000000000..9c4c45b7f0
> > --- /dev/null
> > +++ b/tests/qapi-schema/flat-union-inline-invalid-dict.err
> > @@ -0,0 +1 @@
> > +tests/qapi-schema/flat-union-inline-invalid-dict.json:7: Key 'type' is=
 missing from member 'value1' of union 'TestUnion'
> > diff --git a/tests/qapi-schema/flat-union-inline-invalid-dict.exit b/te=
sts/qapi-schema/flat-union-inline-invalid-dict.exit
> > new file mode 100644
> > index 0000000000..d00491fd7e
> > --- /dev/null
> > +++ b/tests/qapi-schema/flat-union-inline-invalid-dict.exit
> > @@ -0,0 +1 @@
> > +1
> > diff --git a/tests/qapi-schema/flat-union-inline-invalid-dict.json b/te=
sts/qapi-schema/flat-union-inline-invalid-dict.json
> > new file mode 100644
> > index 0000000000..62c7cda617
> > --- /dev/null
> > +++ b/tests/qapi-schema/flat-union-inline-invalid-dict.json
> > @@ -0,0 +1,11 @@
> > +# we require branches to be a struct name
> > +# TODO: should we allow anonymous inline branch types?
> > +{ 'enum': 'TestEnum',
> > +  'data': [ 'value1', 'value2' ] }
> > +{ 'struct': 'Base',
> > +  'data': { 'enum1': 'TestEnum', 'kind': 'str' } }
> > +{ 'union': 'TestUnion',
> > +  'base': 'Base',
> > +  'discriminator': 'enum1',
> > +  'data': { 'value1': { 'string': 'str' },
> > +            'value2': { 'integer': 'int' } } }
> > diff --git a/tests/qapi-schema/flat-union-inline-invalid-dict.out b/tes=
ts/qapi-schema/flat-union-inline-invalid-dict.out
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/qapi-schema/flat-union-inline.json b/tests/qapi-sche=
ma/flat-union-inline.json
> > index 62c7cda617..a9b3ce3f0d 100644
> > --- a/tests/qapi-schema/flat-union-inline.json
> > +++ b/tests/qapi-schema/flat-union-inline.json
> > @@ -7,5 +7,5 @@
> >  { 'union': 'TestUnion',
> >    'base': 'Base',
> >    'discriminator': 'enum1',
> > -  'data': { 'value1': { 'string': 'str' },
> > +  'data': { 'value1': { 'type': {} },
> >              'value2': { 'integer': 'int' } } }
> > diff --git a/tests/qapi-schema/nested-struct-data-invalid-dict.err b/te=
sts/qapi-schema/nested-struct-data-invalid-dict.err
> > new file mode 100644
> > index 0000000000..5bd364e8d9
> > --- /dev/null
> > +++ b/tests/qapi-schema/nested-struct-data-invalid-dict.err
> > @@ -0,0 +1 @@
> > +tests/qapi-schema/nested-struct-data-invalid-dict.json:2: Key 'type' i=
s missing from member 'a' of 'data' for command 'foo'
> > diff --git a/tests/qapi-schema/nested-struct-data-invalid-dict.exit b/t=
ests/qapi-schema/nested-struct-data-invalid-dict.exit
> > new file mode 100644
> > index 0000000000..d00491fd7e
> > --- /dev/null
> > +++ b/tests/qapi-schema/nested-struct-data-invalid-dict.exit
> > @@ -0,0 +1 @@
> > +1
> > diff --git a/tests/qapi-schema/nested-struct-data-invalid-dict.json b/t=
ests/qapi-schema/nested-struct-data-invalid-dict.json
> > new file mode 100644
> > index 0000000000..efbe773ded
> > --- /dev/null
> > +++ b/tests/qapi-schema/nested-struct-data-invalid-dict.json
> > @@ -0,0 +1,3 @@
> > +# inline subtypes collide with our desired future use of defaults
> > +{ 'command': 'foo',
> > +  'data': { 'a' : { 'string' : 'str', 'integer': 'int' }, 'b' : 'str' =
} }
> > diff --git a/tests/qapi-schema/nested-struct-data-invalid-dict.out b/te=
sts/qapi-schema/nested-struct-data-invalid-dict.out
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/qapi-schema/nested-struct-data.json b/tests/qapi-sch=
ema/nested-struct-data.json
> > index efbe773ded..5b8a40cca3 100644
> > --- a/tests/qapi-schema/nested-struct-data.json
> > +++ b/tests/qapi-schema/nested-struct-data.json
> > @@ -1,3 +1,3 @@
> >  # inline subtypes collide with our desired future use of defaults
> >  { 'command': 'foo',
> > -  'data': { 'a' : { 'string' : 'str', 'integer': 'int' }, 'b' : 'str' =
} }
> > +  'data': { 'a' : { 'type': {} }, 'b' : 'str' } }
> > diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schem=
a/qapi-schema-test.json
> > index 22d9044a89..94570154c9 100644
> > --- a/tests/qapi-schema/qapi-schema-test.json
> > +++ b/tests/qapi-schema/qapi-schema-test.json
> > @@ -11,7 +11,7 @@
> >          'guest-sync' ] } }
> >
> >  { 'struct': 'TestStruct',
> > -  'data': { 'integer': 'int', 'boolean': 'bool', 'string': 'str' } }
> > +  'data': { 'integer': {'type': 'int'}, 'boolean': 'bool', 'string': '=
str' } }
> >
> >  # for testing enums
> >  { 'struct': 'NestedEnumsOne',
> > @@ -77,7 +77,7 @@
> >  { 'union': 'UserDefFlatUnion',
> >    'base': 'UserDefUnionBase',   # intentional forward reference
> >    'discriminator': 'enum1',
> > -  'data': { 'value1' : 'UserDefA',
> > +  'data': { 'value1' : {'type': 'UserDefA'},
> >              'value2' : 'UserDefB',
> >              'value3' : 'UserDefB'
> >              # 'value4' defaults to empty
> > @@ -98,7 +98,7 @@
> >  { 'struct': 'WrapAlternate',
> >    'data': { 'alt': 'UserDefAlternate' } }
> >  { 'alternate': 'UserDefAlternate',
> > -  'data': { 'udfu': 'UserDefFlatUnion', 'e': 'EnumOne', 'i': 'int',
> > +  'data': { 'udfu': {'type': 'UserDefFlatUnion'}, 'e': 'EnumOne', 'i':=
 'int',
> >              'n': 'null' } }
> >
> >  { 'struct': 'UserDefC',
> > @@ -134,7 +134,7 @@
> >  { 'command': 'user_def_cmd', 'data': {} }
> >  { 'command': 'user_def_cmd1', 'data': {'ud1a': 'UserDefOne'} }
> >  { 'command': 'user_def_cmd2',
> > -  'data': {'ud1a': 'UserDefOne', '*ud1b': 'UserDefOne'},
> > +  'data': {'ud1a': {'type': 'UserDefOne'}, '*ud1b': 'UserDefOne'},
> >    'returns': 'UserDefTwo' }
> >
> >  { 'command': 'cmd-success-response', 'data': {}, 'success-response': f=
alse }
> > @@ -166,7 +166,7 @@
> >
> >  # testing event
> >  { 'struct': 'EventStructOne',
> > -  'data': { 'struct1': 'UserDefOne', 'string': 'str', '*enum2': 'EnumO=
ne' } }
> > +  'data': { 'struct1': {'type': 'UserDefOne'}, 'string': 'str', '*enum=
2': 'EnumOne' } }
> >
> >  { 'event': 'EVENT_A' }
> >  { 'event': 'EVENT_B',
> > diff --git a/tests/qapi-schema/struct-member-invalid-dict.err b/tests/q=
api-schema/struct-member-invalid-dict.err
> > new file mode 100644
> > index 0000000000..6a765bc668
> > --- /dev/null
> > +++ b/tests/qapi-schema/struct-member-invalid-dict.err
> > @@ -0,0 +1 @@
> > +tests/qapi-schema/struct-member-invalid-dict.json:2: Key 'type' is mis=
sing from member '*a' of 'data' for struct 'foo'
> > diff --git a/tests/qapi-schema/struct-member-invalid-dict.exit b/tests/=
qapi-schema/struct-member-invalid-dict.exit
> > new file mode 100644
> > index 0000000000..d00491fd7e
> > --- /dev/null
> > +++ b/tests/qapi-schema/struct-member-invalid-dict.exit
> > @@ -0,0 +1 @@
> > +1
> > diff --git a/tests/qapi-schema/struct-member-invalid-dict.json b/tests/=
qapi-schema/struct-member-invalid-dict.json
> > new file mode 100644
> > index 0000000000..9fe0d455a9
> > --- /dev/null
> > +++ b/tests/qapi-schema/struct-member-invalid-dict.json
> > @@ -0,0 +1,3 @@
> > +# Long form of member must have a value member 'type'
> > +{ 'struct': 'foo',
> > +  'data': { '*a': { 'case': 'foo' } } }
> > diff --git a/tests/qapi-schema/struct-member-invalid-dict.out b/tests/q=
api-schema/struct-member-invalid-dict.out
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/qapi-schema/union-branch-invalid-dict.err b/tests/qa=
pi-schema/union-branch-invalid-dict.err
> > new file mode 100644
> > index 0000000000..89f9b36791
> > --- /dev/null
> > +++ b/tests/qapi-schema/union-branch-invalid-dict.err
> > @@ -0,0 +1 @@
> > +tests/qapi-schema/union-branch-invalid-dict.json:2: Key 'type' is miss=
ing from member 'integer' of union 'UnionInvalidBranch'
> > diff --git a/tests/qapi-schema/union-branch-invalid-dict.exit b/tests/q=
api-schema/union-branch-invalid-dict.exit
> > new file mode 100644
> > index 0000000000..d00491fd7e
> > --- /dev/null
> > +++ b/tests/qapi-schema/union-branch-invalid-dict.exit
> > @@ -0,0 +1 @@
> > +1
> > diff --git a/tests/qapi-schema/union-branch-invalid-dict.json b/tests/q=
api-schema/union-branch-invalid-dict.json
> > new file mode 100644
> > index 0000000000..9778598dbd
> > --- /dev/null
> > +++ b/tests/qapi-schema/union-branch-invalid-dict.json
> > @@ -0,0 +1,4 @@
> > +# Long form of member must have a value member 'type'
> > +{ 'union': 'UnionInvalidBranch',
> > +  'data': { 'integer': { 'if': 'foo'},
> > +            's8': 'int8' } }
> > diff --git a/tests/qapi-schema/union-branch-invalid-dict.out b/tests/qa=
pi-schema/union-branch-invalid-dict.out
> > new file mode 100644
> > index 0000000000..e69de29bb2
>
> Looks good, but I'd like to investigate whether my suggested placement
> of the normalization would simplify things before I give my R-by.
>

I am not sure I follow, you suggest to have normalization before
check? Then how can we produce an error that reflects the input
accurately? Should we carry additional information (original form etc)
on the source during normalization?

--=20
Marc-Andr=C3=A9 Lureau
