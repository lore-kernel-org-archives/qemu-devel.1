Received: from eggs.gnu.org ([2001:4830:134:3::10]:44005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da1Ne-0004I6-2E
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da1Nc-0003m5-Tu
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:04:14 -0400
References: <1500993699-19299-1-git-send-email-pl@kamp.de>
	<1500993699-19299-2-git-send-email-pl@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e4639625-7674-dfa8-8597-3e142b9931a0@redhat.com>
Date: Tue, 25 Jul 2017 10:03:58 -0500
MIME-Version: 1.0
In-Reply-To: <1500993699-19299-2-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OA2D73PBbhCSdgi99abKiQvx7L6gkft1c"
Subject: Re: [Qemu-devel] [PATCH V5 01/10] specs/qcow2: add compress format
 extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OA2D73PBbhCSdgi99abKiQvx7L6gkft1c
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com,
 den@openvz.org, mreitz@redhat.com, berrange@redhat.com
Message-ID: <e4639625-7674-dfa8-8597-3e142b9931a0@redhat.com>
Subject: Re: [PATCH V5 01/10] specs/qcow2: add compress format extension
References: <1500993699-19299-1-git-send-email-pl@kamp.de>
 <1500993699-19299-2-git-send-email-pl@kamp.de>
In-Reply-To: <1500993699-19299-2-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/25/2017 09:41 AM, Peter Lieven wrote:
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  docs/interop/qcow2.txt | 51 ++++++++++++++++++++++++++++++++++++++++++=
+++++++-
>  roms/ipxe              |  2 +-
>  2 files changed, 51 insertions(+), 2 deletions(-)
>=20

> +
> +=3D=3D Compress format extension =3D=3D
> +
> +The compress format extension is an optional header extension. It prov=
ides
> +the ability to specify the compress algorithm and compress parameters

s/the compress algorithm/the compression algorithm/

> +that are used for compressed clusters. This new header MUST be present=
 if
> +the incompatible-feature bit "compress format bit" is set and MUST be =
absent
> +otherwise.
> +
> +The fields of the compress format extension are:
> +
> +    Byte  0 - 13:  compress_format_name (padded with zeros, but not
> +                   necessarily null terminated if it has full length).=

> +                   Valid compression format names currently are:
> +
> +                   deflate: Standard zlib deflate compression without
> +                            compression header

Why did you name it "deflate" instead of "zlib" again?

> +
> +              14:  compress_level (uint8_t)
> +
> +                   0 =3D default compress level (valid for all formats=
, default)
> +
> +                   Additional valid compression levels for deflate com=
pression:
> +
> +                   All values between 1 and 9. 1 gives best speed, 9 g=
ives best
> +                   compression. The default compression level is defin=
ed by zlib
> +                   and currently defaults to 6.
> +
> +              15:  compress_window_size (uint8_t)
> +
> +                   Window or dictionary size used by the compression f=
ormat.
> +                   Currently only used by the deflate compression algo=
rithm.

What must this be set to for other algorithms?  I guess we get to that
in later patches.

> +
> +                   Valid window sizes for deflate compression range fr=
om 8 to
> +                   15 inclusively.
> +
> +Note: Omitting the incompatible "Compress format bit" results in the u=
sage
> +of deflate compression with default compression level and a window siz=
e of 12
> +(which was default before QEMU 2.11). If exactly these parameters are =
choosen

s/choosen/chosen,/

> +it is free to the implementation to omit the "Compress format bit" and=
 the

s/it is free to the implementation to omit/the implementation may omit/

> +compress format extension when updating the QCOW2 header.
> +
> +
>  =3D=3D Host cluster management =3D=3D
> =20
>  qcow2 manages the allocation of host clusters by maintaining a referen=
ce count
> diff --git a/roms/ipxe b/roms/ipxe
> index 0600d3a..b991c67 160000
> --- a/roms/ipxe
> +++ b/roms/ipxe
> @@ -1 +1 @@
> -Subproject commit 0600d3ae94f93efd10fc6b3c7420a9557a3a1670
> +Subproject commit b991c67c1d91574ef22336cc3a5944d1e63230c9

Oops.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OA2D73PBbhCSdgi99abKiQvx7L6gkft1c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll3Xd4ACgkQp6FrSiUn
Q2oDRAf/XuRQAEmFsTz+PPNLbGClgBrBOtZknpgYxr+/a6Q+nJyDIjzww8DUfbgT
7Aj2HNJ6IbdKkqv/skjA+mQ9GkNE04NhZZ8FPC5lVhYZuVPMXQgkojhq25YG33AQ
99lMqSF2AHpR8hOJoBJrKRmgTqPJ/Ai+n3XVW52TkLn7K5RKYpm1oYZ3R31SV5Ca
LXRMbzC82slfO7lKH8t5gW0SNUGBhPB75IwS2Bz222S3CygMDykAODR6jRYzg1uk
QsMLqkKaAEqmbo68zKR+XcLNXde8pdZf+WWmDvLifQtjPthw/DJOKymBQsYTJfMX
1iaoIK9VBOpsK1FIk6dX2FWug3EDOQ==
=EQXL
-----END PGP SIGNATURE-----

--OA2D73PBbhCSdgi99abKiQvx7L6gkft1c--
