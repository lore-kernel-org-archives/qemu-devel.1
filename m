Received: from eggs.gnu.org ([2001:4830:134:3::10]:58342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crSpn-0006IH-7S
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crSpl-0000sr-Vs
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:17:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1crSpl-0000sc-NE
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:17:05 -0400
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-42-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9bf961af-1b77-f288-aeaa-21ef1e207d60@redhat.com>
Date: Fri, 24 Mar 2017 12:17:03 -0500
MIME-Version: 1.0
In-Reply-To: <20170323204544.12015-42-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fGQsKPCk1EC6TvJHMWSiC6CGmhSR7nLxU"
Subject: Re: [Qemu-devel] [PATCH 41/51] Add page-size to output in 'info
 migrate'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>, dgilbert@redhat.com, Li Zhijian <lizhijian@cn.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fGQsKPCk1EC6TvJHMWSiC6CGmhSR7nLxU
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>, dgilbert@redhat.com,
 Li Zhijian <lizhijian@cn.fujitsu.com>
Message-ID: <9bf961af-1b77-f288-aeaa-21ef1e207d60@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 41/51] Add page-size to output in 'info
 migrate'
References: <20170323204544.12015-1-quintela@redhat.com>
 <20170323204544.12015-42-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-42-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/23/2017 03:45 PM, Juan Quintela wrote:
> From: Chao Fan <fanc.fnst@cn.fujitsu.com>
>=20
> The number of dirty pages outputed in 'pages' in the command

s/outputed/is output/

> 'info migrate', so add page-size to calculate the number of dirty
> pages in bytes.
>=20
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hmp.c                 | 3 +++
>  migration/migration.c | 1 +
>  qapi-schema.json      | 5 ++++-
>  3 files changed, 8 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--fGQsKPCk1EC6TvJHMWSiC6CGmhSR7nLxU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY1VSPAAoJEKeha0olJ0Nq2qgIAJMjMBwCoypdFHxytCRDDmUP
IDcCO1reZqYlK8ZdV+HjCHkVMsYh531lA8EHObDQCTNTBWkoXC3/BORg0/3E7LZK
uuVUmrWPnytNBdn5zYSmCJm2/GtBvodGw+MrhFbYs8awihBALTbX8HhkaPYPibCw
Dezl55iDXOPuuJf1MbMyyz14LOLy+47kAmb+10i4BkGmVp/X1eUBqxoeqh1tWht+
a5O66fGP9mxrXFnkG0gb6d1fHurRTk96mEDMc+uiKs2Y2wQ4SjUpTRT/sqZy1b02
fx31lYDzNHla4lnokoNh2rYeI0D+xYkYMXAin6FSASFosy3EtnrJkuq0290bvWY=
=mjx1
-----END PGP SIGNATURE-----

--fGQsKPCk1EC6TvJHMWSiC6CGmhSR7nLxU--
