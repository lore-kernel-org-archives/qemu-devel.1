Received: from eggs.gnu.org ([2001:4830:134:3::10]:57510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSnBJ-0002wP-Am
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSnBI-0007K7-Bn
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:29:37 -0400
References: <20170703122505.32017-1-mreitz@redhat.com>
	<20170703122505.32017-3-mreitz@redhat.com>
	<87r2xve509.fsf@dusky.pond.sub.org>
	<98cccb52-4fca-2625-5f69-30c348962377@redhat.com>
	<5067e305-39fe-3590-4a7c-0f0136d8e5b1@redhat.com>
	<e21524cb-a199-fa6e-11f6-8b445a1633db@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <33f5a5f9-0a58-6b86-d3e1-2bee632a8493@redhat.com>
Date: Wed, 5 Jul 2017 11:29:28 -0500
MIME-Version: 1.0
In-Reply-To: <e21524cb-a199-fa6e-11f6-8b445a1633db@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BQIKBE9nWMMl8dRmThjVPm6ifu04wtH1h"
Subject: Re: [Qemu-devel] [PATCH v3 2/5] qapi: Add qobject_is_equal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BQIKBE9nWMMl8dRmThjVPm6ifu04wtH1h
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <33f5a5f9-0a58-6b86-d3e1-2bee632a8493@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] qapi: Add qobject_is_equal()
References: <20170703122505.32017-1-mreitz@redhat.com>
 <20170703122505.32017-3-mreitz@redhat.com>
 <87r2xve509.fsf@dusky.pond.sub.org>
 <98cccb52-4fca-2625-5f69-30c348962377@redhat.com>
 <5067e305-39fe-3590-4a7c-0f0136d8e5b1@redhat.com>
 <e21524cb-a199-fa6e-11f6-8b445a1633db@redhat.com>
In-Reply-To: <e21524cb-a199-fa6e-11f6-8b445a1633db@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/05/2017 11:22 AM, Max Reitz wrote:

>>>>     return (double)x =3D=3D x && x =3D=3D y;
>>>
>>> Yes, that would do, too; and spares me of having to think about how w=
ell
>>> comparing an arbitrary double to UINT64_MAX actually works. :-)
>>
>> On second thought, this won't do, because (double)x =3D=3D x is always=
 true
>> if x is an integer (because this will implicitly cast the second x to =
a
>> double, too). However, (uint64_t)(double)x =3D=3D x should work.
>=20
> Hm, well, the nice thing with this is that (double)UINT64_MAX is
> actually UINT64_MAX + 1, and now (uint64_t)(UINT64_MAX + 1) is
> undefined... Urgs.

(uint64_t)(UINT64_MAX + 1) is well-defined - it is 0.

(Adding in unsigned integers is always well-defined - it wraps around on
mathematical overflow modulo the integer size.  You're thinking of
overflow addition on signed integers, which is indeed undefined)

>=20
> So I guess one thing that isn't very obvious but that should *always*
> work (and is always well-defined) is this:
>=20
> For uint64_t: y < 0x1p64 && (uint64_t)y =3D=3D x
>=20
> For int64_t: y >=3D -0x1p63 && y < 0x1p63 && (int64_t)y =3D=3D x

That's harder to read, compared to the double-cast method which is
well-defined after all.

>=20
> I hope. :-/
>=20
> (But finally a chance to use binary exponents! Yay!)

Justifying the use of binary exponents is going to be harder than that,
and would need a really good comment in the code, compared to just using
a safe double-cast.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BQIKBE9nWMMl8dRmThjVPm6ifu04wtH1h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXRPoAAoJEKeha0olJ0NqytMH/3SAo5ndHBsrC6S99RVwrg7Y
13P04iQJxSeBomYsfCXfi/OBS9+fhLHKZMZRtYC6Ooh/W8rpqR9tgyWq7pvIu2lz
jn2tva3jucJCKyeZflJBb7MPe0JZpqvJ7RhjnERs63IsqgFnbselCBJ4o2qz9MvG
qROYlOUafSd09MvMAQ4DDwQEhERHL9txJRKMh14MWDceWH8c5PpdwyfOopM/HEvM
Ds0uD7P9rPKTzVaJx+S/0NLh3tH7uHraFAH59RLGzM0Ke0S1gyvRQaRbrTZPKMpL
nOxmhG981p8EH+0VQ9kfACiivFZr2Qp963YOrXkFl0TbVXB68ANGb8+CGtC3Dhg=
=H2bQ
-----END PGP SIGNATURE-----

--BQIKBE9nWMMl8dRmThjVPm6ifu04wtH1h--
