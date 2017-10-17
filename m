Received: from eggs.gnu.org ([2001:4830:134:3::10]:48560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4ZcH-0007VU-DT
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 17:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4ZcG-0008FE-DU
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 17:41:37 -0400
References: <bdbb9d79839f3149db9cf2ff11a2cc04977e0a64.1507817548.git.pkrempa@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dbb57dfe-0e9b-f484-4e52-7bbb7b8c8142@redhat.com>
Date: Tue, 17 Oct 2017 16:41:26 -0500
MIME-Version: 1.0
In-Reply-To: <bdbb9d79839f3149db9cf2ff11a2cc04977e0a64.1507817548.git.pkrempa@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pkrwL6oKp2XFl1ULeCNPuDV1XEuMnxLVk"
Subject: Re: [Qemu-devel] [PATCH] block: don't add 'driver' to options when
 refering to backing via node name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pkrwL6oKp2XFl1ULeCNPuDV1XEuMnxLVk
From: Eric Blake <eblake@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <dbb57dfe-0e9b-f484-4e52-7bbb7b8c8142@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: don't add 'driver' to options when
 refering to backing via node name
References: <bdbb9d79839f3149db9cf2ff11a2cc04977e0a64.1507817548.git.pkrempa@redhat.com>
In-Reply-To: <bdbb9d79839f3149db9cf2ff11a2cc04977e0a64.1507817548.git.pkrempa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/12/2017 09:14 AM, Peter Krempa wrote:
> When refering to a backing file of an image via node name

s/refering/referring/ (here and in the subject)

> bdrv_open_backing_file would add the 'driver' option to the option list=

> filling it with the backing format driver. This breaks construction of
> the backing chain via -blockdev, as bdrv_open_inherit reports an error
> if both 'reference' and 'options' are provided.
>=20
> Signed-off-by: Peter Krempa <pkrempa@redhat.com>
> ---
>  block.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pkrwL6oKp2XFl1ULeCNPuDV1XEuMnxLVk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnmeQYACgkQp6FrSiUn
Q2q15Af/dGq2kE2954H6x2u4XUXTTiRidc7IdblWfuQBQ0q8Jg/EhEIbnR7zx2n6
J3tIXkAwgLzTfRzRwtVCHjTJY2WuxAZiLoymEB0igYJVj1bVJq5C6YgUuGZGAn1s
f3Q8KttT2PMnkYtm3glMOd5PoR3guSiqzO3D/xwK6As1mZ71vofDQjBWUv4UW+HI
W/qs4Pfc1X0cNI/sdEyqYz9fyJg8t5cMucehbPkuKOPTHWMLy1L7kL/ll0v+RoPY
MhIuVbQ7oRibhCbcQeyGYc/WN/tRmbUopZjw2b1dc2Z6Pjx4hhE0hWRzXZT6DReK
UzQGl3iydZ4vFQv2LeM3M5PgiwLJ7A==
=yxFb
-----END PGP SIGNATURE-----

--pkrwL6oKp2XFl1ULeCNPuDV1XEuMnxLVk--
