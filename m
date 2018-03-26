Received: from eggs.gnu.org ([2001:4830:134:3::10]:54013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f0V0J-0000Bt-MK
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 12:29:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f0V0I-0006BA-Oz
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 12:29:51 -0400
References: <20180322133337.28024-1-yuchenlin@synology.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <60f3297a-2bd8-c541-1a47-20d9f3393580@redhat.com>
Date: Mon, 26 Mar 2018 18:29:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180322133337.28024-1-yuchenlin@synology.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hgcu1ry7uXdszqgVEMqNQRJv6Fnl5S8h1"
Subject: Re: [Qemu-devel] [PATCH v3] vmdk: return ERROR when cluster sector
 is larger than vmdk limitation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuchenlin@synology.com, qemu-devel@nongnu.org
Cc: famz@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org, eblake@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hgcu1ry7uXdszqgVEMqNQRJv6Fnl5S8h1
From: Max Reitz <mreitz@redhat.com>
To: yuchenlin@synology.com, qemu-devel@nongnu.org
Cc: famz@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org,
 eblake@redhat.com
Message-ID: <60f3297a-2bd8-c541-1a47-20d9f3393580@redhat.com>
Subject: Re: [PATCH v3] vmdk: return ERROR when cluster sector is larger than
 vmdk limitation
References: <20180322133337.28024-1-yuchenlin@synology.com>
In-Reply-To: <20180322133337.28024-1-yuchenlin@synology.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-22 14:33, yuchenlin@synology.com wrote:
> From: yuchenlin <yuchenlin@synology.com>
>=20
> VMDK has a hard limitation of extent size, which is due to the size of =
grain
> table entry is 32 bits. It means it can only point to a grain located a=
t
> offset =3D 2^32. To avoid writing the user data beyond limitation and r=
ecord a useless offset
> in grain table. We should return ERROR here.
>=20
> Signed-off-by: yuchenlin <yuchenlin@synology.com>
> ---
> v2->v3:
>  - use (1ULL << 32) to clearly show the limitation of offset is 2^32.
>=20
>  thanks
>=20
>  block/vmdk.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--hgcu1ry7uXdszqgVEMqNQRJv6Fnl5S8h1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlq5H/QSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ac6cH/RGqgY2JGviKoVDSbMJTeYQdoNMOjsnh
mWHS8Q0Mt2F7FbbW243PcsVku6OMfloYdaZGEFpFTUKGVKFg7j93KYnB33lhUq5l
8Uy46WU2g/jsYyBlEwvi70yNW52C+pzQXAg4wPmLZQE3xPvM6TvTSxN1rp9ddDab
HvxP3sWwi7QXt/ho8u7mdmv9PTh5ryShhw+7NIEm6v2fVNXO2QJDR6F1jBwg4uSD
3Lwm81q+VJgmZYFkRzvUXXu4+x3ZhdpwUC74WaXkRvgsN9Da/Zd4crci8uBFhI0q
TxIowr1Ve6eT27dzSXoucA4dbphrMPjvs9GY417/S7awxcStpHRfPTg=
=SCjM
-----END PGP SIGNATURE-----

--hgcu1ry7uXdszqgVEMqNQRJv6Fnl5S8h1--
