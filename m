Received: from eggs.gnu.org ([2001:4830:134:3::10]:57936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fxXFW-00030L-3E
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fxXFV-0001bG-8D
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:49:34 -0400
References: <cover.1535983918.git.berto@igalia.com>
	<5e84c28e4ed8ac259665c7e0c0baa028668ac0b2.1535983918.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <aa77ca0f-2138-5e57-850c-9e9999b538c5@redhat.com>
Date: Wed, 5 Sep 2018 14:49:22 +0200
MIME-Version: 1.0
In-Reply-To: <5e84c28e4ed8ac259665c7e0c0baa028668ac0b2.1535983918.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="avrcTZbOTNFQmskrEbUwQg9v0ePbWkM4H"
Subject: Re: [Qemu-devel] [PATCH v2 07/10] file-posix: Forbid trying to
 change unsupported options during reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--avrcTZbOTNFQmskrEbUwQg9v0ePbWkM4H
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <aa77ca0f-2138-5e57-850c-9e9999b538c5@redhat.com>
Subject: Re: [PATCH v2 07/10] file-posix: Forbid trying to change unsupported
 options during reopen
References: <cover.1535983918.git.berto@igalia.com>
 <5e84c28e4ed8ac259665c7e0c0baa028668ac0b2.1535983918.git.berto@igalia.com>
In-Reply-To: <5e84c28e4ed8ac259665c7e0c0baa028668ac0b2.1535983918.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-09-03 16:34, Alberto Garcia wrote:
> The file-posix code is used for the "file", "host_device" and
> "host_cdrom" drivers, and it allows reopening images. However the only
> option that is actually processed is "x-check-cache-dropped", and
> changes in all other options (e.g. "filename") are silently ignored:
>=20
>    (qemu) qemu-io virtio0 "reopen -o file.filename=3Dno-such-file"
>=20
> While we could allow changing some of the other options, let's keep
> things as they are for now but return an error if the user tries to
> change any of them.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/file-posix.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--avrcTZbOTNFQmskrEbUwQg9v0ePbWkM4H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluP0NIACgkQ9AfbAGHV
z0CFCAf+KCtOmmviSrcQK/e8bXCBzQ8VrdC4xBjRPZD39wJf5iz0y/k74asgUwRh
unesVjMyCHN9WYnivyKdRPi2Az9suHuMMThc2ucprdpi0oWj5pshlsQqCeW6UW3I
4+HGfd007HSLdEX5Yn1FUMppZBCl+7WS1mPIFXN8G9GYbCZ8jiF7dtBotficyfHW
zmdoDZK8urPI580VP0vgvFI40cRJLbMiZ0cVzaGpmMUJqaBE7+7OVi4vjQ3cv+a6
nWAQuMCvXnj+p62y5eZ4/rQI7P8Br2802JZ1RV2i7/2SzGvfGdyr5kmk2gcKtoOg
LEQk8IslnU0YaHH8r6RG0tZv0H8nmw==
=Bcyh
-----END PGP SIGNATURE-----

--avrcTZbOTNFQmskrEbUwQg9v0ePbWkM4H--
