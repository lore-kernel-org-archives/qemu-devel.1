Received: from eggs.gnu.org ([2001:4830:134:3::10]:35163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnsRI-0005Wi-Q6
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 16:21:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnsRF-00062A-NJ
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 16:21:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dnsRF-00060R-Dv
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 16:21:13 -0400
References: <20170901201054.11738-1-briansteffens@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <832e1069-c74c-cb20-bb7b-65032df8eabe@redhat.com>
Date: Fri, 1 Sep 2017 15:21:10 -0500
MIME-Version: 1.0
In-Reply-To: <20170901201054.11738-1-briansteffens@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PPa7Ux7oGkb1ovqqgEa4iuNCXSacrH3FF"
Subject: Re: [Qemu-devel] [PATCH 1/1] block: add block device shared field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brian Steffens <briansteffens@gmail.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PPa7Ux7oGkb1ovqqgEa4iuNCXSacrH3FF
From: Eric Blake <eblake@redhat.com>
To: Brian Steffens <briansteffens@gmail.com>, qemu-devel@nongnu.org
Message-ID: <832e1069-c74c-cb20-bb7b-65032df8eabe@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] block: add block device shared field
References: <20170901201054.11738-1-briansteffens@gmail.com>
In-Reply-To: <20170901201054.11738-1-briansteffens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/01/2017 03:10 PM, Brian Steffens wrote:
> This adds a boolean option called 'shared' to block devices. It default=
s
> to off/false. When enabled for a particular block device, the 'shared' =
option
> causes the block migration code to skip over syncing of that device. Th=
is
> allows controlling exactly which block devices get synced during a migr=
ation.
>=20
> Signed-off-by: Brian Steffens <briansteffens@gmail.com>
> ---
>  block.c                   | 7 +++++++
>  block/qapi.c              | 2 ++
>  include/block/block.h     | 1 +
>  include/block/block_int.h | 3 +++
>  migration/block.c         | 4 ++++
>  qapi/block-core.json      | 2 +-
>  6 files changed, 18 insertions(+), 1 deletion(-)
>=20

> +++ b/qapi/block-core.json
> @@ -365,7 +365,7 @@
>              '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
>              '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int'=
,
>              '*iops_size': 'int', '*group': 'str', 'cache': 'BlockdevCa=
cheInfo',
> -            'write_threshold': 'int' } }
> +            'write_threshold': 'int', 'shared': 'bool' } }

Missing documentation, which should include '(since 2.11)'.  The new
parameter should be optional on input; but it looks like you've only
modified a structure that is present on output - so you're missing a
QAPI edit that mirrors the command-line edit.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PPa7Ux7oGkb1ovqqgEa4iuNCXSacrH3FF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmpwTYACgkQp6FrSiUn
Q2pN7gf/Xfwj8E/noTayTYX8gZHPINYn0WrjUT8p6L1jHEOeksOPkQ/owBDCHaeG
gHvS3GKjC/Ej6NuIFFfLYA/rPiwCRnSB/GjR0dPsz8ih+bSJGa5eeNTWkolS2wLV
KvNj9BhLAnus8kbyDE2YmaESj//Bmr9VbXADz1m7eLwmEAakxzFj/3L56FIPZLhc
oYBDGoOORjWu8XJrdozAfx5uNGsuGAw0m5i3KBrRHvANs+jiK+xivZBmvusOklGN
SQX2DIZBF5F6hnpakhOMYWvIT+DUJeZep5kzDicBgsL4wtfAQ30VBEcGyAVoy++0
bS56TWk3eBkRa4ta+Zf05ptE+mEbUg==
=Uqd2
-----END PGP SIGNATURE-----

--PPa7Ux7oGkb1ovqqgEa4iuNCXSacrH3FF--
