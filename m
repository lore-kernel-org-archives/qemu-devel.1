Received: from eggs.gnu.org ([2001:4830:134:3::10]:35601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cOCEc-0004s9-NK
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 18:41:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cOCEZ-0006I7-Kr
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 18:41:46 -0500
Date: Tue, 3 Jan 2017 09:28:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170102222846.GC12761@umbus.fritz.box>
References: <20161231011831.4097-1-zxq_yx_007@163.com>
	<20161231011831.4097-5-zxq_yx_007@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qjNfmADvan18RZcF"
Content-Disposition: inline
In-Reply-To: <20161231011831.4097-5-zxq_yx_007@163.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/ppc: QOM'ify spapr_vio.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoqiang zhao <zxq_yx_007@163.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, peter.maydell@linaro.org, qemu-ppc@nongnu.org


--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 31, 2016 at 09:18:31AM +0800, xiaoqiang zhao wrote:
> Drop the old and empty SysBus init
>=20
> Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>

This should also actually remove the empty function.

> ---
>  hw/ppc/spapr_vio.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
> index cc1e09c568..1739b73a13 100644
> --- a/hw/ppc/spapr_vio.c
> +++ b/hw/ppc/spapr_vio.c
> @@ -548,11 +548,9 @@ static int spapr_vio_bridge_init(SysBusDevice *dev)
> =20
>  static void spapr_vio_bridge_class_init(ObjectClass *klass, void *data)
>  {
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
>      dc->fw_name =3D "vdevice";
> -    k->init =3D spapr_vio_bridge_init;
>  }
> =20
>  static const TypeInfo spapr_vio_bridge_info =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qjNfmADvan18RZcF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYatQeAAoJEGw4ysog2bOSfRMP/3McJCOJ6dt6oHVco2ow38Vl
68JrwShjRiVy1LKxrSOVdrEzMuPbvYBUX1plORyQgNkjO/M/PfLXcYaEFsZxln4K
5yw+pH5riKIGeg+KOjxgP8p7hhwSK4JurXClwcrF+RPRkMIwp8L/PBBQqBb/QpRE
wNu0HbYZt4kZFXz8qcphYOa7WhdXyYbizNPyi+SRJwIym8PGZwzzDLRQ6NxPPKFH
CTljvNuRJDKDgzxSe2x1nPfqv2lI7Fp1KQZc6EtBp1A12sFX8PEP0UrydueODnIQ
vK2Q991c4Zk5QaS5WaIrITYOMnSGRV/NqCYV2qCTK8tkcU+iP37EdO7P1RWvS9eV
TZ33j6NjYAv+aAzP7RtRZUoB8zQFOBeYWYz/vG+qI9bwPDl2TefQoWGqTlcZesQG
hJP/cyrFcvLn8O4zYte2juB4MbvtvXYQS1eteh5Ij0oQj4EnHbV1Wjlr1AXTPZSY
OrjyO8M91+6BOU31HI9sah9YQhhrZhYa0yfyLa9RDfBfVsuqaGVD2xy5BJUK0glJ
BUTU97DxL9oZQYQgqK9gIYKc0BMsHzBbUhuZ+bDhtILB7pzQ/B61K79v8NnWWWpB
FRqzAgpDxM4Zp/4H7B27xxJNvY8n3y8SsKaS1fax/oqwYzHFR9+El52CUgJkM5nS
lOhr+Dc+6PESdaApR5EM
=jLNZ
-----END PGP SIGNATURE-----

--qjNfmADvan18RZcF--
