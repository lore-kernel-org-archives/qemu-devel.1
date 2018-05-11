Received: from eggs.gnu.org ([2001:4830:134:3::10]:52332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHCRH-0007bv-1q
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHCRF-0004Tl-El
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:06:43 -0400
References: <20180509165530.29561-1-mreitz@redhat.com>
	<20180509165530.29561-4-mreitz@redhat.com>
	<ec3886fb-04df-5ee1-5796-12d415335a02@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9f0d6357-182b-0fd6-19ed-30c13797a5d4@redhat.com>
Date: Fri, 11 May 2018 20:06:30 +0200
MIME-Version: 1.0
In-Reply-To: <ec3886fb-04df-5ee1-5796-12d415335a02@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qT11tLBCwaLnR5FpoD0EDDQ8HLsAbQRwY"
Subject: Re: [Qemu-devel] [PATCH 03/13] tests: Add QAPI optional
 discriminator tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qT11tLBCwaLnR5FpoD0EDDQ8HLsAbQRwY
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <9f0d6357-182b-0fd6-19ed-30c13797a5d4@redhat.com>
Subject: Re: [PATCH 03/13] tests: Add QAPI optional discriminator tests
References: <20180509165530.29561-1-mreitz@redhat.com>
 <20180509165530.29561-4-mreitz@redhat.com>
 <ec3886fb-04df-5ee1-5796-12d415335a02@redhat.com>
In-Reply-To: <ec3886fb-04df-5ee1-5796-12d415335a02@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-10 16:08, Eric Blake wrote:
> On 05/09/2018 11:55 AM, Max Reitz wrote:
>> There already is an optional discriminator test, although it also note=
d
>> the discriminator name itself as optional.=C2=A0 Changing that, and ad=
ding a
>> default-variant field, makes that test pass instead of failing.
>=20
> I'm not sure I agree with that one.=C2=A0 I think that you should inste=
ad add
> a positive test of a default variant into qapi-schema-test.json,
> especially since that is the one positive test where we also ensure tha=
t
> the C compiler is happy with the generated code (other positive tests
> prove that the generator produced something without error, but not that=

> what it produced could be compiled).

Oh, sure.

>> =C2=A0 17 files changed, 61 insertions(+), 4 deletions(-)
>> =C2=A0 create mode 100644
>> tests/qapi-schema/flat-union-optional-discriminator-invalid-default.js=
on
>> =C2=A0 create mode 100644
>> tests/qapi-schema/flat-union-optional-discriminator-no-default.json
>> =C2=A0 create mode 100644
>> tests/qapi-schema/flat-union-superfluous-default-variant.json
>> =C2=A0 create mode 100644
>> tests/qapi-schema/flat-union-optional-discriminator-invalid-default.er=
r
>> =C2=A0 create mode 100644
>> tests/qapi-schema/flat-union-optional-discriminator-invalid-default.ex=
it
>> =C2=A0 create mode 100644
>> tests/qapi-schema/flat-union-optional-discriminator-invalid-default.ou=
t
>> =C2=A0 create mode 100644
>> tests/qapi-schema/flat-union-optional-discriminator-no-default.err
>> =C2=A0 create mode 100644
>> tests/qapi-schema/flat-union-optional-discriminator-no-default.exit
>> =C2=A0 create mode 100644
>> tests/qapi-schema/flat-union-optional-discriminator-no-default.out
>> =C2=A0 create mode 100644
>> tests/qapi-schema/flat-union-superfluous-default-variant.err
>> =C2=A0 create mode 100644
>> tests/qapi-schema/flat-union-superfluous-default-variant.exit
>> =C2=A0 create mode 100644
>> tests/qapi-schema/flat-union-superfluous-default-variant.out
>=20
> Patch 1 converted 2 error messages into 6, where 2 of them look identic=
al:
>=20
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # The value of member 'di=
scriminator' must name a non-optional
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # member of the base stru=
ct.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # The value of member 'di=
scriminator' must name a member of
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # the base struct.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 check_name(info, "Di=
scriminator of flat union '%s'" % name,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 discriminator)
>=20
> [0] check_name() checks that 'discriminator':'*name' is rejected - this=

> check is unchanged
>=20
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 discriminator_type =3D ba=
se_members.get(discriminator)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not discriminator_type=
:
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
aise QAPISemError(info,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Discriminator '%s' is not a member
>>> of base "
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "struct '%s'"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 % (discriminator, base))
>=20
> The old code ensured that 'discriminator':'name' finds 'name' as a
> mandatory field in the base type; which changed into:
>=20
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if default_variant is Non=
e:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=
iscriminator_type =3D base_members.get(discriminator)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f not discriminator_type:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if base_members.get('*' + discriminator) is None:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise QAPISemError(info,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "Discriminator '%s' is not a
>>> member of "
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "base struct '%s'"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 % (discriminator, base))
>=20
> [1] the discriminator type must be a member field (we didn't find eithe=
r
> a mandatory or an optional field)
>=20
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 else:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise QAPISemError(info,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "Default variant must be
>>> specified for "
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "optional discriminator '%s'"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 % discriminator)
>=20
> [2] without default_variant, the member field must be mandatory
>=20
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=
iscriminator_type =3D base_members.get('*' + discriminator)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f not discriminator_type:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if base_members.get(discriminator) is None:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise QAPISemError(info,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "Discriminator '%s' is not a
>>> member of "
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "base struct '%s'"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 % (discriminator, base))
>=20
> [3] the discriminator type must be a member field (we didn't find eithe=
r
> a mandatory or an optional field), identical message to [1]
>=20
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 else:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise QAPISemError(info,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "Must not specify a default
>>> variant for "
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "non-optional discriminator
>>> '%s'"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 % discriminator)
>=20
> [4] with default_variant, the member field must be optional
>=20
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum_define =3D enum=
_types.get(discriminator_type)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 allow_metas =3D ['st=
ruct']
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Do not allow strin=
g discriminator
>>> @@ -763,6 +785,15 @@ def check_union(expr, info):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Discriminator '%s' must be of=

>>> enumeration "
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "type" % discriminator)
>>> =C2=A0
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if default_variant is not=
 None:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #=
 Must be a value of the enumeration
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f default_variant not in enum_define['data']:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 raise QAPISemError(info,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Default var=
iant '%s' of flat
>>> union '%s' is "
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "not part of=
 '%s'"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 % (default_v=
ariant, name,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 discriminator_type))
>>> +
>=20
> [5] the default discriminator value must belong to the discriminator's =
type
>=20
> Of those 6 messages, you now have coverage of:
>=20
>>
>> +++ b/tests/Makefile.include
>> @@ -500,7 +500,10 @@ qapi-schema +=3D flat-union-invalid-branch-key.js=
on
>> =C2=A0qapi-schema +=3D flat-union-invalid-discriminator.json
>=20
> [1] no change to that test
>=20
>> =C2=A0qapi-schema +=3D flat-union-no-base.json
>> =C2=A0qapi-schema +=3D flat-union-optional-discriminator.json
>=20
> the old test for [0] - you turned it into success. See more below...
>=20
>> +qapi-schema +=3D flat-union-optional-discriminator-no-default.json
>=20
> new test for [2]
>=20
>> +qapi-schema +=3D flat-union-optional-discriminator-invalid-default.js=
on
>=20
> new test for [5]
>=20
>> =C2=A0qapi-schema +=3D flat-union-string-discriminator.json
>> +qapi-schema +=3D flat-union-superfluous-default-variant.json
>=20
> new test for [4]
>=20
> I don't know if it is worth trying to explicitly test for [3], given
> that it is identical to [1], but the loss of the test for [0] bothers m=
e.
>=20
>> +++ b/tests/qapi-schema/flat-union-optional-discriminator.err
>> @@ -1 +0,0 @@
>> -tests/qapi-schema/flat-union-optional-discriminator.json:6:
>> Discriminator of flat union 'MyUnion' does not allow optional name
>> '*switch'
>=20
> This used to be covered by [0] - but you rewrote the test by changing
> 'discriminator':'*switch' to 'discriminator':'switch'.
>=20
> I'd argue that you WANT to keep 'discriminator':'*switch' in this test,=

> to keep the testing of error [0] (even when the discriminator type is
> optional, we spell it without leading '*' in the 'union' description),
> and then only qapi-schema-test.json gets a positive test, which also
> gives us the additional coverage that the C compiler likes our generate=
d
> code.

OK, but I'd like to rename the test, then.

Max


--qT11tLBCwaLnR5FpoD0EDDQ8HLsAbQRwY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr126YACgkQ9AfbAGHV
z0BEiAf8CCcKjBDmrUr1bIGSGjZrnCfUvsmHSaQrcuLFJOcXDr0uEhtnoOHAi9/p
51xN23O09wD9tm3t/3I6XwJ/ADPkwBibJm6jTgUvpsoRhfLI0SB2Q6epwnKPjwpP
HebrEVp1I+xhJe8wcugTy2Yvla9VGUvHGLQjDR4vZI0bQWdAFmDc+gGu7dSJ4c2w
GVYskwLDZJL/6R5TAWPxqdmyXTwzYpKp/Ach5QvTiyw8NqHkrUVEOUik3A+y1g+o
mJOBzY8KovNOMRHQqmXbORJdaYs93Md6GxEFt7GVQUeg0RUvs+k6dNl9YlHoiIKI
fTBJD0iNVcYECfhM22SRG/XsRveb2Q==
=41Ly
-----END PGP SIGNATURE-----

--qT11tLBCwaLnR5FpoD0EDDQ8HLsAbQRwY--
