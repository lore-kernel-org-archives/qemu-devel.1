Received: from eggs.gnu.org ([2001:4830:134:3::10]:44260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSo12-0002dj-4w
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:23:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSo11-0007Xi-4d
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:23:04 -0400
References: <20170703122505.32017-1-mreitz@redhat.com>
	<20170703122505.32017-3-mreitz@redhat.com>
	<87r2xve509.fsf@dusky.pond.sub.org>
	<98cccb52-4fca-2625-5f69-30c348962377@redhat.com>
	<5067e305-39fe-3590-4a7c-0f0136d8e5b1@redhat.com>
	<e21524cb-a199-fa6e-11f6-8b445a1633db@redhat.com>
	<33f5a5f9-0a58-6b86-d3e1-2bee632a8493@redhat.com>
	<fabe727c-7024-9f4b-99b3-fecb5da26acf@redhat.com>
	<986a4919-937e-3668-d94e-f71981992e87@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <275f6b2c-e68e-17f0-f48d-9cc95f84fdc9@redhat.com>
Date: Wed, 5 Jul 2017 12:22:54 -0500
MIME-Version: 1.0
In-Reply-To: <986a4919-937e-3668-d94e-f71981992e87@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DmrIv6xGaBgFfD9B8awExNXoLpXKkMIUc"
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
--DmrIv6xGaBgFfD9B8awExNXoLpXKkMIUc
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <275f6b2c-e68e-17f0-f48d-9cc95f84fdc9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] qapi: Add qobject_is_equal()
References: <20170703122505.32017-1-mreitz@redhat.com>
 <20170703122505.32017-3-mreitz@redhat.com>
 <87r2xve509.fsf@dusky.pond.sub.org>
 <98cccb52-4fca-2625-5f69-30c348962377@redhat.com>
 <5067e305-39fe-3590-4a7c-0f0136d8e5b1@redhat.com>
 <e21524cb-a199-fa6e-11f6-8b445a1633db@redhat.com>
 <33f5a5f9-0a58-6b86-d3e1-2bee632a8493@redhat.com>
 <fabe727c-7024-9f4b-99b3-fecb5da26acf@redhat.com>
 <986a4919-937e-3668-d94e-f71981992e87@redhat.com>
In-Reply-To: <986a4919-937e-3668-d94e-f71981992e87@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/05/2017 12:04 PM, Max Reitz wrote:

> Or, well, yes, it is in this case, but I meant literally UINT64_MAX + 1=
,
> not the uint64_t value. I meant the natural number 2^64.
>=20
> Because the issue is that (double)UINT64_MAX will (or may, depending on=

> the environment and such) give us 2.0^64 =3D=3D 0x1p64.
>=20
> And this is where the quotation I gave below comes in. When casting an
> integer to a double we may end up with a value that is not representabl=
e
> in the original integer type, so we cannot easily cast it back.

And it's more than just UINT64_MAX that rounds to the double value of
0x1p64.  Okay, I'm starting to be convinced that using a floating-point
comparison to 0x1p64 is going to be easier than an integer comparison to
the rounding point (what point is that, anyways: where the low-order 11
bits that don't fit in 53 bits of precision cause us to round up instead
of down?)

>>> Justifying the use of binary exponents is going to be harder than tha=
t,
>>> and would need a really good comment in the code, compared to just us=
ing
>>> a safe double-cast.
>>
>> It's not safe.
>>
>> Max
>>
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--DmrIv6xGaBgFfD9B8awExNXoLpXKkMIUc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXSBuAAoJEKeha0olJ0NqynAH/A4R3zvjRdBH13GYp4y7xN8k
Ufcm7Mish6rplkvezGQaGyGodaKHpbFwrcrRjrZgu5/pAeTdi2I0iAGGYe8ypzuC
9cb72HD+zJJEyCXzj3gthMepBJMVM21M6BeTkLw19yL8Tyx7YPue+RxvxZ4SKRCn
Rkdtkk2Mxmt5Hhq5mfkjUmMHclAW6BKouNAvA3PBECshgIcDkOWlyUu04/pwNmp7
cNpEOcvUFbKkWqdhNNjvoC9mcETv0aTktRPgYA8cy3/Aoi8/jexo6X6xBI7Y+9rc
MV5Qp5ypS4dhIwgERJ8fRv6gUWPeuEAVQb+LfJ/ADXaaVQXoDGDoXYH58wk3Nro=
=oYBk
-----END PGP SIGNATURE-----

--DmrIv6xGaBgFfD9B8awExNXoLpXKkMIUc--
