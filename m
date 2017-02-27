Received: from eggs.gnu.org ([2001:4830:134:3::10]:50162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciRCm-0005W2-GY
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:43:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciRCl-00048Z-LT
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:43:32 -0500
References: <87bmukmlau.fsf@dusky.pond.sub.org>
	<87poi4c4jd.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8332e5e7-5e27-5c0b-7990-af814716acf8@redhat.com>
Date: Mon, 27 Feb 2017 13:43:23 -0600
MIME-Version: 1.0
In-Reply-To: <87poi4c4jd.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="baQBUc6kpaQDtAA4UjAKcNesxsSSBXWPI"
Subject: Re: [Qemu-devel] Non-flat command line option argument syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--baQBUc6kpaQDtAA4UjAKcNesxsSSBXWPI
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <8332e5e7-5e27-5c0b-7990-af814716acf8@redhat.com>
Subject: Re: Non-flat command line option argument syntax
References: <87bmukmlau.fsf@dusky.pond.sub.org>
 <87poi4c4jd.fsf@dusky.pond.sub.org>
In-Reply-To: <87poi4c4jd.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/27/2017 04:27 AM, Markus Armbruster wrote:
> Design flaw: there is no good way to denote an empty array or object
> other than the root object.
>=20
> Empty KEY=3DVALUE,... is valid and results in an empty root object.
>=20
> Presence of a KEY that contains periods results in additional non-root
> objects or arrays.  For instance, KEY a.b.c results in root object
> member "a" that has member "b" that has (scalar) member "c".
>=20
> These additional objects and arrays all have at least one member, by
> construction.
>=20
> Begs the question how to denote an empty object or array other than the=

> root.

If a.b.c=3D1 means root object has member "a" with child object "b", and
object "b" has key "c" with scalar value, I suppose we could allow:

a.b,

(with no =3Dval) to mean root object "a" has an empty child "b"
(indeterminate if "b" is an object or a list) - but only if we don't
allow the 'foo' =3D> 'foo=3Don' magic already in use by QemuOpts.  And yo=
u
still have to figure out how to choose empty list vs. empty object.

>=20
> Without additional syntax, all we can do is choose what exactly to make=

> impossible:
>=20
> * Absent key means absent, period.  No way to do empty array or object.=

>   This is what I implemented.

I lean towards this meaning. It should generally possible to allow an
empty object/list to mean the same thing as an optional omitted
object/list in all contexts - so omitting KEY=3DVALUE for a list means yo=
u
are omitting the list, but the omitted list behaves the same as an
explicitly empty one would have done (even though dotted syntax doesn't
have an easy way to express an explicit empty list).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--baQBUc6kpaQDtAA4UjAKcNesxsSSBXWPI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtIFbAAoJEKeha0olJ0Nq8RAH/Rs9Fo9RDIDPqISKqKFjHWTs
mNxnafgKhUfyrs54hHjs7Hv80Vl2A8V7kRsCWRYzFC5RzVfnbqnpsm75ej6aUfIB
JNjVSOTnvoYvCwwtkZC3bpAuVQibCWKrV+OAUHq3ffqUO3k1lEYIvFtDB3ZAy4ZN
Y3F6fq3Wieg3C1sk+SRLgOZkPpPmwxlJ1fqG6+EDVW16z7SwfU4Wc9EIGWVVIW3a
/0frclvGjFpkIpOvwHJlxsL/TWT2oBIwqZXLfnvzeb+OQUE+Ga5x95J71dugauFD
FVYKGZvqjDGgVSt2mrd5QRMNHgErYzbUouJqtgk5z61zSCkAC5tdzSOY5G2k+kE=
=MWxN
-----END PGP SIGNATURE-----

--baQBUc6kpaQDtAA4UjAKcNesxsSSBXWPI--
