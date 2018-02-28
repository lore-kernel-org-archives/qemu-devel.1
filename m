Received: from eggs.gnu.org ([2001:4830:134:3::10]:42802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er69o-000783-Lq
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:08:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er69n-00089k-DL
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:08:48 -0500
References: <20180224154033.29559-1-mreitz@redhat.com>
	<20180224154033.29559-4-mreitz@redhat.com>
	<abd5ed7a-d5ee-028c-1cd5-208161f88beb@redhat.com>
	<fb3756be-e002-8b47-921f-80a5ce332721@redhat.com>
	<01bf42f6-971d-1a28-eeb4-61063ae62bd7@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8b6cb74b-6335-3ee2-0dc3-ff5604704608@redhat.com>
Date: Wed, 28 Feb 2018 19:08:38 +0100
MIME-Version: 1.0
In-Reply-To: <01bf42f6-971d-1a28-eeb4-61063ae62bd7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ViAtEvbQggVyVBoccQSXfulnAu3oUkui3"
Subject: Re: [Qemu-devel] [PATCH v3 3/7] qapi: Replace qobject_to_X(o) by
 qobject_to(o, X)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ViAtEvbQggVyVBoccQSXfulnAu3oUkui3
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <8b6cb74b-6335-3ee2-0dc3-ff5604704608@redhat.com>
Subject: Re: [PATCH v3 3/7] qapi: Replace qobject_to_X(o) by qobject_to(o, X)
References: <20180224154033.29559-1-mreitz@redhat.com>
 <20180224154033.29559-4-mreitz@redhat.com>
 <abd5ed7a-d5ee-028c-1cd5-208161f88beb@redhat.com>
 <fb3756be-e002-8b47-921f-80a5ce332721@redhat.com>
 <01bf42f6-971d-1a28-eeb4-61063ae62bd7@redhat.com>
In-Reply-To: <01bf42f6-971d-1a28-eeb4-61063ae62bd7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-27 15:47, Eric Blake wrote:
> On 02/26/2018 06:01 AM, Max Reitz wrote:
>=20
>>>> +++ b/block.c
>>>> @@ -1457,7 +1457,7 @@ static QDict *parse_json_filename(const char
>>>> *filename, Error **errp)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return =
NULL;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0 options =3D qobject_to_qdict(option=
s_obj);
>>>> +=C2=A0=C2=A0=C2=A0 options =3D qobject_to(options_obj, QDict);
>>>
>>> Bikeshedding - would it read any easier as:
>>>
>>> options =3D qobject_to(QDict, options_obj);
>>>
>>> ?=C2=A0 If so, your Coccinelle script can be touched up, and patch 2/=
7 swaps
>>> argument order around, so it would be tolerable but still slightly
>>> busywork to regenerate the series.=C2=A0 But I'm not strongly attache=
d to
>>> either order, and so I'm also willing to take this as-is (especially
>>> since that's less work), if no one else has a strong opinion that
>>> swapping order would aid legibility.
>>
>> Well, same for me. :-)
>>
>> In a template/generic language, we'd write the type first (e.g.
>> qobject_cast<QDict>(options_obj)).=C2=A0 But maybe we'd write the obje=
ct
>> first, too (e.g. options_obj.cast<QDict>()).=C2=A0 And the current ord=
er of
>> the arguments follows the order in the name ("qobject" options_obj "to=
"
>> QDict).=C2=A0 But maybe it's more natural to read it as "qobject to" Q=
Dict
>> "applied to" options_obj.
>>
>> I don't know either.
>=20
> Okay, after looking for existing uses of type names in macro calls, I s=
ee:
>=20
> qemu/compiler.h:
>=20
> #ifndef container_of
> #define container_of(ptr, type, member) ({=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const typeof(((type *) 0)->m=
ember) *__mptr =3D (ptr);=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (type *) ((char *) __mptr - =
offsetof(type, member));})
> #endif
>=20
> /* Convert from a base type to a parent type, with compile time
> checking.=C2=A0 */
> #ifdef __GNUC__
> #define DO_UPCAST(type, field, dev) ( __extension__ ( { \
> =C2=A0=C2=A0=C2=A0 char __attribute__((unused)) offset_must_be_zero[ \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -offsetof(type, field)]; \
> =C2=A0=C2=A0=C2=A0 container_of(dev, type, field);}))
> #else
> #define DO_UPCAST(type, field, dev) container_of(dev, type, field)
> #endif
>=20
> #define typeof_field(type, field) typeof(((type *)0)->field)
>=20
>=20
> qapi/clone-visitor.h:
>=20
> /*
> =C2=A0* Deep-clone QAPI object @src of the given @type, and return the =
result.
> =C2=A0*
> =C2=A0* Not usable on QAPI scalars (integers, strings, enums), nor on a=

> =C2=A0* QAPI object that references the 'any' type.=C2=A0 Safe when @sr=
c is NULL.
> =C2=A0*/
> #define QAPI_CLONE(type, src)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>=20
> /*
> =C2=A0* Copy deep clones of @type members from @src to @dst.
> =C2=A0*
> =C2=A0* Not usable on QAPI scalars (integers, strings, enums), nor on a=

> =C2=A0* QAPI object that references the 'any' type.
> =C2=A0*/
> #define QAPI_CLONE_MEMBERS(type, dst, src)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>=20
>=20
> 2 out of 3 macros in compiler.h put the type name first, and
> container_of() puts it in the middle of 3.=C2=A0 It's even weirder beca=
use
> DO_UPCAST(t, f, d) calls container_of(d, t, f), where the inconsistency=

> makes it a mental struggle to figure out how to read the two macros sid=
e
> by side, compared to if we had just been consistent.=C2=A0 Meanwhile, a=
ll of
> the macros in qapi put the type name first.
>=20
> So at this point, I'm 70:30 in favor of doing the rename to have
> qobject_to(type, obj) for consistency with majority of other macros tha=
t
> take a type name (type names are already unusual as arguments to macros=
,
> whether or not the macro is named with ALL_CAPS).=C2=A0 (Sorry, I know =
that
> means more busy work for you, if you agree with my reasoning)

I agree, because it means I have a decision. :-)

Max


--ViAtEvbQggVyVBoccQSXfulnAu3oUkui3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqW8CYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AMTEH/j0Oog0TYk9oUA2FxyaJlaTcSXFgkWA5
jOFn6thEy7ROEqYQEGTsY02AymMiCge8DKuLVLZp8K/1+HMtWJtxsPb+qtc/2od3
oSmdPWqiS5pk04flMS1iTA7WrFlmpE09EAoCFSl+1TKA1HiIrrGyb5rs/Zc6hR09
cS/AtwmmePiAXPhlDwNKDcD8ZLS8uSKLmT7tKao9K4qzxiNnv+zQLHNaYrT9B3FO
PE0nZUnHNlBnlGhGN2scU9aR1TCY4qFQ91KhgOQMIlBdHqsqP+toVN+RcwrYsbkQ
YDhpmqLOJqK7HIfhCPU/YFAo67nimH++in5B76mo3kvPeY7VJxtMjwE=
=u45F
-----END PGP SIGNATURE-----

--ViAtEvbQggVyVBoccQSXfulnAu3oUkui3--
