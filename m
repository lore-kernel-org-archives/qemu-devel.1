Received: from eggs.gnu.org ([2001:4830:134:3::10]:60601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cFSg7-0007NE-D7
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 16:26:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cFSg3-0007HK-0X
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 16:26:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cFSg2-0007H9-O5
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 16:25:58 -0500
References: <148127558476.2633.13433882390740185948.stgit@bahia>
	<148127568042.2633.5084932697061472826.stgit@bahia>
From: Eric Blake <eblake@redhat.com>
Message-ID: <85cb0570-87e5-8396-dd04-eb6400226278@redhat.com>
Date: Fri, 9 Dec 2016 15:25:55 -0600
MIME-Version: 1.0
In-Reply-To: <148127568042.2633.5084932697061472826.stgit@bahia>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="i6r8VNB4b2p9l0m4810V3a5KUoaNXs1Sd"
Subject: Re: [Qemu-devel] [PATCH 3/8] 9pfs: fix P9_NOTAG and P9_NOFID macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i6r8VNB4b2p9l0m4810V3a5KUoaNXs1Sd
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Message-ID: <85cb0570-87e5-8396-dd04-eb6400226278@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/8] 9pfs: fix P9_NOTAG and P9_NOFID macros
References: <148127558476.2633.13433882390740185948.stgit@bahia>
 <148127568042.2633.5084932697061472826.stgit@bahia>
In-Reply-To: <148127568042.2633.5084932697061472826.stgit@bahia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/09/2016 03:28 AM, Greg Kurz wrote:
> The u16 and u32 types don't exist in QEMU common headers. It never brok=
e
> build because these two macros aren't use by the current code, but this=

> is about to change with the future addition of functional tests for 9P.=

>=20
> This patch convert the types to uintXX_t.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> index 3976b7fe3dcd..89c904bdb7e7 100644
> --- a/hw/9pfs/9p.h
> +++ b/hw/9pfs/9p.h
> @@ -99,8 +99,8 @@ enum p9_proto_version {
>      V9FS_PROTO_2000L =3D 0x02,
>  };
> =20
> -#define P9_NOTAG    (u16)(~0)
> -#define P9_NOFID    (u32)(~0)
> +#define P9_NOTAG    (uint16_t)(~0)
> +#define P9_NOFID    (uint32_t)(~0)

Don't you want to write ((uint16_t)(~0)), to ensure that this expression
can be used as a drop-in in any other syntactical situation?

Or even write it as UINT16_C(~0) (using <stdint.h>), or as UINT16_MAX.
(Be aware: the type of (uint16_t)(~0) is uint16_t, while the type of
UINT16_MAX is int, due to the rules of integer promotion, if that matters=
)

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--i6r8VNB4b2p9l0m4810V3a5KUoaNXs1Sd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYSyFjAAoJEKeha0olJ0Nqe3AIAJt5RJkTo3cseY2HupCWBos6
WJQVOOKb58D1B2sUAuqQ+LFIWL9UeIWFNvYda2xNdkxYurnkpzYiytXV4SBmAu9B
5BJzxaD9qitUVkkecg1aWHdJVfCGox3nHBj3IzdWdJcVFo+gqnvi+WYTscM16TGG
oYxqn/ZQSkhOxHmNNDtJ+FMB1vTRfOaoKCLdsUMss5YA9EpcNRnW5ZFkwRB3/3cf
JyATP/3CPKExyhGEqTis/a4RSafAlCPDD7o/6pfAGMzBS6Y3JfgRenLBtISHF/jg
NqTeVVSnF4CHQo3A/kQxo4BWrYHCEhPtVJSgbn5y4vpcxNdjHH6FrDtcI5SSE8o=
=rAcQ
-----END PGP SIGNATURE-----

--i6r8VNB4b2p9l0m4810V3a5KUoaNXs1Sd--
