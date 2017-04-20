Received: from eggs.gnu.org ([2001:4830:134:3::10]:51534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1BcK-00028j-M4
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 08:55:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1BcJ-0001op-J3
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 08:55:24 -0400
References: <20170420005428.11465-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e7241a3d-fb8e-582e-abe7-bff2c8658d52@redhat.com>
Date: Thu, 20 Apr 2017 07:55:11 -0500
MIME-Version: 1.0
In-Reply-To: <20170420005428.11465-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PtIaRsu3QmiV4e0qCOjdwRGOF0a6Fjpgm"
Subject: Re: [Qemu-devel] [PATCH v3] iotests: 109: Filter out "len" of
 failed jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PtIaRsu3QmiV4e0qCOjdwRGOF0a6Fjpgm
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org, pbonzini@redhat.com
Message-ID: <e7241a3d-fb8e-582e-abe7-bff2c8658d52@redhat.com>
Subject: Re: [PATCH v3] iotests: 109: Filter out "len" of failed jobs
References: <20170420005428.11465-1-famz@redhat.com>
In-Reply-To: <20170420005428.11465-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/19/2017 07:54 PM, Fam Zheng wrote:
> Mirror calculates job len from current I/O progress:
>=20
>     s->common.len =3D s->common.offset +
>                     (cnt + s->sectors_in_flight) * BDRV_SECTOR_SIZE;
>=20
> The final "len" of a failed mirror job in iotests 109 depends on the
> subtle timing of the completion of read and write issued in the first
> mirror iteration.  The second iteration may or may not have run when th=
e
> I/O error happens, resulting in non-deterministic output of the
> BLOCK_JOB_COMPLETED event text.
>=20
> Similar to what was done in a752e4786, filter out the field to make the=

> test robust.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
>=20
> ---
>=20
> v3: Cover more cases. [Kevin, Paolo]

That my testing missed those extra cases is just proof that the behavior
is non-deterministic.  Munging the 'len' data in more places is the
right solution.

>=20
> v2: Add Eric's r-b.

Once again:

Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PtIaRsu3QmiV4e0qCOjdwRGOF0a6Fjpgm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY+K+vAAoJEKeha0olJ0NqurYH/iM3r8fkH/b0Vaj/Ms5RhR5+
qIUnV9Dy8LiucBfbcnGavlWkcNxaa5czPD5W2JJmoXhnfKwbVAL+fbKtGIg38MGi
nQHSkVyuwmE59YMPRmLw3r49MAhvrcYr+bGcy2G/Sx7eCdQBGW37bZWNX9hibIev
JXYFGi12ECZ5eAK+IFdB5a4xzJnBOs5qCUcI/jInnLgAGJbPerbC/IdIefUegKJw
K75+joQlRgmzFKVy3d4tRkm3FfkCVuYHIoTD8lJX6hm4uIHL1J/4/RXiTXG4gwEr
qg+baT7Ko5GnUjo/qtNysA06dGpZSvqphqWaztq9mRjFmygkiZDu2FK8nbySTHQ=
=1mMe
-----END PGP SIGNATURE-----

--PtIaRsu3QmiV4e0qCOjdwRGOF0a6Fjpgm--
