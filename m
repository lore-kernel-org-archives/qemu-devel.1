Received: from eggs.gnu.org ([2001:4830:134:3::10]:34597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTFKb-0000Tm-SM
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:00:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTFKa-0008TH-Td
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:00:49 -0500
References: <20170111181432.18868-1-mreitz@redhat.com>
	<20170116204905.31347-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e6488a9d-e9c0-daa4-07f6-627c8c3a9e67@redhat.com>
Date: Mon, 16 Jan 2017 16:00:41 -0600
MIME-Version: 1.0
In-Reply-To: <20170116204905.31347-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IxdMSG6Eon553OH6rlSefl1Om2qNiTkfK"
Subject: Re: [Qemu-devel] [PATCH v4 07/25] block:
 bdrv_get_full_backing_filename's ret. val.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IxdMSG6Eon553OH6rlSefl1Om2qNiTkfK
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <e6488a9d-e9c0-daa4-07f6-627c8c3a9e67@redhat.com>
Subject: Re: [PATCH v4 07/25] block: bdrv_get_full_backing_filename's ret.
 val.
References: <20170111181432.18868-1-mreitz@redhat.com>
 <20170116204905.31347-1-mreitz@redhat.com>
In-Reply-To: <20170116204905.31347-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/16/2017 02:48 PM, Max Reitz wrote:
> Make bdrv_get_full_backing_filename() return an allocated string instea=
d
> of placing the result in a caller-provided buffer.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/block/block.h |  3 +--
>  block.c               | 26 +++++++++-----------------
>  block/qapi.c          | 12 ++----------
>  3 files changed, 12 insertions(+), 29 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--IxdMSG6Eon553OH6rlSefl1Om2qNiTkfK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYfUKJAAoJEKeha0olJ0NqJx0H/2ooV2Q2G7JXyeRY3rvF/6u8
OcMCxnK8c1KXr2lLtgsCmHmHb7+QdeqLrBIIDcGwEKflMu7ewEsk2X4JR/NIqtch
4tqg9GN3GjN5iDrjX8QeW3ZiCNMq7marFlfeac1sWw+2fOIrFmWCT8Doc1iqi5xr
ytRdHjDRLRZaggun8zGEw8Q+4jjH7kSnOHd5093wKExd9DdB431Yu+c7zYIbxAH0
Mmm28Xc/PYqBsZjSyIRH0Cs5gzZ8rhnkBmyOyq0Xgcdpj1zdL9O3qLztIfxJzqYq
uY+wCPwhdB49YGKNLr+R7m0P4S5qW/zD2JhEYoNA5yvFl+hzw0GUvG+rblSP9eE=
=gqE4
-----END PGP SIGNATURE-----

--IxdMSG6Eon553OH6rlSefl1Om2qNiTkfK--
