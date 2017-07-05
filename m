Received: from eggs.gnu.org ([2001:4830:134:3::10]:42950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSnwO-0006Vj-Dz
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:18:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSnwN-0005Ez-JY
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:18:16 -0400
References: <20170703122505.32017-1-mreitz@redhat.com>
	<20170703122505.32017-3-mreitz@redhat.com>
	<87r2xve509.fsf@dusky.pond.sub.org>
	<98cccb52-4fca-2625-5f69-30c348962377@redhat.com>
	<5067e305-39fe-3590-4a7c-0f0136d8e5b1@redhat.com>
	<e21524cb-a199-fa6e-11f6-8b445a1633db@redhat.com>
	<33f5a5f9-0a58-6b86-d3e1-2bee632a8493@redhat.com>
	<fabe727c-7024-9f4b-99b3-fecb5da26acf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e53d0019-c9d5-5bf8-837a-12f3261a275e@redhat.com>
Date: Wed, 5 Jul 2017 12:18:07 -0500
MIME-Version: 1.0
In-Reply-To: <fabe727c-7024-9f4b-99b3-fecb5da26acf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2b0MAHK38qK6l80sQgnB8ThJW2Nj8dEAW"
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
--2b0MAHK38qK6l80sQgnB8ThJW2Nj8dEAW
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <e53d0019-c9d5-5bf8-837a-12f3261a275e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] qapi: Add qobject_is_equal()
References: <20170703122505.32017-1-mreitz@redhat.com>
 <20170703122505.32017-3-mreitz@redhat.com>
 <87r2xve509.fsf@dusky.pond.sub.org>
 <98cccb52-4fca-2625-5f69-30c348962377@redhat.com>
 <5067e305-39fe-3590-4a7c-0f0136d8e5b1@redhat.com>
 <e21524cb-a199-fa6e-11f6-8b445a1633db@redhat.com>
 <33f5a5f9-0a58-6b86-d3e1-2bee632a8493@redhat.com>
 <fabe727c-7024-9f4b-99b3-fecb5da26acf@redhat.com>
In-Reply-To: <fabe727c-7024-9f4b-99b3-fecb5da26acf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/05/2017 12:00 PM, Max Reitz wrote:
>> (uint64_t)(UINT64_MAX + 1) is well-defined - it is 0.
>>
>> (Adding in unsigned integers is always well-defined - it wraps around =
on
>> mathematical overflow modulo the integer size.  You're thinking of
>> overflow addition on signed integers, which is indeed undefined)
>=20
> It's not. See the standard:
>=20
> When a finite value of real floating type is converted to an integer

Ah, you're talking:

(uint64_t)(double)(UINT64_MAX + 1), which is indeed undefined.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2b0MAHK38qK6l80sQgnB8ThJW2Nj8dEAW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXR9PAAoJEKeha0olJ0NqImAIAKQSETQW6RUNFpTNXQrsW517
TkSXWoNOrYbR4LEMYE+eaf7iF/pClUpK4TznPe8zj6AUXHIqbherD3aluWLl3FLG
h/+rV9zFaKZEtu4mnBdj1XvoFjMl7/OAqVufIY8UicTvsqD7lP3YnFTYxSG+8WWc
sO/CgHF6ByAYN3kvAiXpm7bLaW7NHzhMItnIZO1f3+LcTBw/07EOWcqAvAwFkQCi
x9cb+JM22WjkQX0VtvpVNlyVrHBUu2H/uXHgyHRX1lpYPTuBXStRQiEDlx9+KEvI
eWsMqS6FJ/soTRDgHMzcOn+B/r6oz9+BoUc9Q4u11icy3++FaedH3Mt5sANBaxc=
=4lhy
-----END PGP SIGNATURE-----

--2b0MAHK38qK6l80sQgnB8ThJW2Nj8dEAW--
