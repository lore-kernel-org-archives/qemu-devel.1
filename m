Received: from eggs.gnu.org ([2001:4830:134:3::10]:53138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYGgK-0003tP-Tc
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:28:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYGgG-0005HT-F8
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:28:00 -0500
References: <20170130161441.30493-1-berto@igalia.com>
	<w51vaswzeui.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8b1ea150-2d12-93ed-1a48-6aa6b1b8a351@redhat.com>
Date: Mon, 30 Jan 2017 12:27:44 -0600
MIME-Version: 1.0
In-Reply-To: <w51vaswzeui.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JxWJjios3mi4Mo4baOqOsBkHwDIjEN6oL"
Subject: Re: [Qemu-devel] [PATCH] qcow2: Optimize the refcount-block overlap
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JxWJjios3mi4Mo4baOqOsBkHwDIjEN6oL
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <8b1ea150-2d12-93ed-1a48-6aa6b1b8a351@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: Optimize the refcount-block overlap
 check
References: <20170130161441.30493-1-berto@igalia.com>
 <w51vaswzeui.fsf@maestria.local.igalia.com>
In-Reply-To: <w51vaswzeui.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2017 10:34 AM, Alberto Garcia wrote:

>=20
> I don't think QEMU produces files where refcount_table[i] =3D=3D 0 but
> refcount_table[i + 1] !=3D 0. Do they even make sense?

I don't know if qemu can be directly coerced to create such an image,
but a third party tool can (and that probably includes qemu-io), and
such an image makes sense.  In particular, a refcount can be changed
from non-zero to zero during garbage collection when all clusters
covered by that refcount are no longer in use (perhaps because a
snapshot was deleted).

> In any case, my
> patch would cover those cases too, but this simplified version wouldn't=
=2E

Since an image can have holes in the refcount_table, it sounds like the
simplified version is not robust enough.


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--JxWJjios3mi4Mo4baOqOsBkHwDIjEN6oL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYj4WgAAoJEKeha0olJ0NqC/UH/j0Jbsd2xNcmNTOkRL+3/vag
rX+Xr29JoiZHxzw/xp9yI6J8ju65hGJIyQUuPgjvNs8HWT4xj6ZjMfpI6FLj4bvR
n56v7hrq7eikFOjatXJ2s6q2y9GGuL4Fd7RdyV39DIXtxrJw6EB7lp2KmkywHaCI
hR7WEK2dB1hv82kN4aVCC/mvXd1aeth0fdO9NTYQImtvg8Dsv9yXHoBfYO/hskDF
1R9iOz1aIgkLyi09fYZkKrCMIEAZ/3HFZ34GogUBC2jMCvW/mQdh5n9+FQWjenNv
jqQA55MxM9mZptWjD2eWcEd686fLb74mDmkYIHPB2O/6KyJWhvYjiUSYa7cZJBo=
=kHdn
-----END PGP SIGNATURE-----

--JxWJjios3mi4Mo4baOqOsBkHwDIjEN6oL--
