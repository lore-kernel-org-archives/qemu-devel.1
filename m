Received: from eggs.gnu.org ([2001:4830:134:3::10]:35527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebqEN-0005z2-HD
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:06:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebqEK-0005xv-BB
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:06:27 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<192986ad741749064e855bc67916a11460911992.1513342045.git.berto@igalia.com>
	<a634b25e-08d3-349e-7b71-6d25d7c7bc2c@redhat.com>
	<w51fu741nuo.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <99e8633c-828c-ccf5-334a-6d081d329878@redhat.com>
Date: Wed, 17 Jan 2018 10:06:04 -0600
MIME-Version: 1.0
In-Reply-To: <w51fu741nuo.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oZlYdkbK9nsIND1AyUKuEDiA1ciT7vGhX"
Subject: Re: [Qemu-devel] [PATCH v2 16/32] qcow2: Update l2_allocate() to
 support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oZlYdkbK9nsIND1AyUKuEDiA1ciT7vGhX
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <99e8633c-828c-ccf5-334a-6d081d329878@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 16/32] qcow2: Update l2_allocate() to
 support L2 slices
References: <cover.1513342045.git.berto@igalia.com>
 <192986ad741749064e855bc67916a11460911992.1513342045.git.berto@igalia.com>
 <a634b25e-08d3-349e-7b71-6d25d7c7bc2c@redhat.com>
 <w51fu741nuo.fsf@maestria.local.igalia.com>
In-Reply-To: <w51fu741nuo.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/17/2018 09:55 AM, Alberto Garcia wrote:
> On Tue 16 Jan 2018 11:26:40 PM CET, Eric Blake wrote:
>>>      /* allocate a new entry in the l2 cache */
>>> =20
>>> +    slice_size =3D s->l2_slice_size * sizeof(uint64_t);
>>
>> Would this read any better if the earlier patch named it
>> s->l2_slice_entries?
>=20
> I had doubts with this. Like you, when I see size I tend to think about=

> bytes. However both s->l1_size and s->l2_size indicate entries, and the=

> documentation of the qcow2 format even describes the header field like
> this:
>=20
>          36 - 39:   l1_size
>                     Number of entries in the active L1 table

We're free to rename the field in the qcow2 format specification if it
makes things easier to understand.  If l1_entries reads better than
l1_size, maybe it's worth doing.

>=20
> So I decided to follow that same convention for l2_slice_size.
>=20
> For the local variable I could call it slice_size_bytes or try to come
> up with a different alternative, but I'm open to suggestions.
>=20
> Berto
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--oZlYdkbK9nsIND1AyUKuEDiA1ciT7vGhX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpfdGwACgkQp6FrSiUn
Q2rwnwf/fk2i5IL/+GgUIsk+vlcrqSRq0mZuEKOxu8pHnCo4kcLymc9ew3+dvSv6
HmlmtY65KDpb6aiby1ixsYnY+ucWLl+UPaS3CVJSBbvnrVe6Idd2CVff0i9YkYw/
B1Ge4zUgNaseuO0KRIocLCV16IqXLXKDjDg46NPDKfOjjN0IDO78I9zBlvV95on9
x5gTU9y/Ysm+Ig8na+aeq7SJu+EZCN1T8j5CSo/km6ZK0n1BIo2Ck00/tHhqYE/m
fU7uCoYoPKZRO2DDagUQAaHA4ZJXcvmCNEyNyOZ95jxjjt/esWmvIyfnTDSOab6f
xdgkJhePpyVfkQB8TX2+kZ3EF0E3+A==
=QIYd
-----END PGP SIGNATURE-----

--oZlYdkbK9nsIND1AyUKuEDiA1ciT7vGhX--
