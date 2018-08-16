Received: from eggs.gnu.org ([2001:4830:134:3::10]:49024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fq5je-0008V9-6J
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 20:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fq5jd-00072f-EU
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 20:01:54 -0400
References: <153430460784.10304.668502576933473446@502c9da6d61e>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <91d64820-89d3-c0dc-741b-f6fb13175174@redhat.com>
Date: Thu, 16 Aug 2018 02:01:44 +0200
MIME-Version: 1.0
In-Reply-To: <153430460784.10304.668502576933473446@502c9da6d61e>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rcMarWx9LzmjBgCy9DsNGOzEZwt1fosyG"
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 00/31] block: Fix some filename
 generation issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rcMarWx9LzmjBgCy9DsNGOzEZwt1fosyG
From: Max Reitz <mreitz@redhat.com>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com, berto@igalia.com
Message-ID: <91d64820-89d3-c0dc-741b-f6fb13175174@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 00/31] block: Fix some filename
 generation issues
References: <153430460784.10304.668502576933473446@502c9da6d61e>
In-Reply-To: <153430460784.10304.668502576933473446@502c9da6d61e>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-15 05:43, no-reply@patchew.org wrote:
> Hi,
>=20
> This series seems to have some coding style problems. See output below =
for
> more information:

[...]

> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Checking PATCH 1/31: block: Use bdrv_refresh_filename() to pull...
> Checking PATCH 2/31: block: Use children list in bdrv_refresh_filename.=
=2E.
> Checking PATCH 3/31: block: Skip implicit nodes for filename info...
> Checking PATCH 4/31: block: Add BDS.auto_backing_file...
> Checking PATCH 5/31: block: Respect backing bs in bdrv_refresh_filename=
=2E..
> ERROR: return is not a function, parentheses are not required
> #46: FILE: block.c:5192:
> +        return (bs->auto_backing_file[0] !=3D '\0');
>=20
> total: 1 errors, 0 warnings, 136 lines checked

Sure, but I'd hate you personally if you omitted them.

Max


--rcMarWx9LzmjBgCy9DsNGOzEZwt1fosyG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt0vugACgkQ9AfbAGHV
z0DygAgAiMJwlWc3d6zQ24Zy5A2k+Dz225HKxTPDQE7PlYLY92xmEQoKMWrDoXrW
4nN/uGCkwmGhslt0syW4h9yLKIGRGUedwRBnkxMuhaopfF6YKBv3pqP4XxWOgTbL
1tbB5MogLNNBFXTk0m4Fi+xK9t41XPUthJgNwDkaJfe5VyZblTdxDdT4M6VSOfpS
87fR6bUGdUnwiQA0FKlPYPcVJPYmRPJ+3dXdE7x4w5a3zjXLSocTVjfTbsxAMTNs
/8jQmAy2eyMhum0RxmP7OGZsE6b3tjM+dSx9kqzxEY7AyjuRhAX+qQwYoO2M8ImP
DCX0vFaCXBwFigiwX6WGLo4zT8TGcA==
=mx3O
-----END PGP SIGNATURE-----

--rcMarWx9LzmjBgCy9DsNGOzEZwt1fosyG--
