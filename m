Received: from eggs.gnu.org ([2001:4830:134:3::10]:46255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1etOzM-00072k-Mt
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 21:39:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1etOzI-0006yh-OH
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 21:39:32 -0500
Date: Wed, 7 Mar 2018 13:23:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180307022327.GA3083@umbus.fritz.box>
References: <20180306232851.8DD617456A5@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20180306232851.8DD617456A5@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH] sii3112: Remove unneeded exit function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 07, 2018 at 12:15:15AM +0100, BALATON Zoltan wrote:
> An exit function was mistakenly left here but it's not needed because
> the PCI bars are organised differently in this device. Calling this
> exit function during device_del was causing an abort with
> memory_region_del_subregion: `Assertion subregion->container =3D=3D mr' f=
ailed.
>=20
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Applied to ppc-for-2.12, thanks.

> ---
>  hw/ide/sii3112.c | 12 ------------
>  1 file changed, 12 deletions(-)
>=20
> diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
> index e3896c6..743a50e 100644
> --- a/hw/ide/sii3112.c
> +++ b/hw/ide/sii3112.c
> @@ -327,17 +327,6 @@ static void sii3112_pci_realize(PCIDevice *dev, Erro=
r **errp)
>      qemu_register_reset(sii3112_reset, s);
>  }
> =20
> -static void sii3112_pci_exitfn(PCIDevice *dev)
> -{
> -    PCIIDEState *d =3D PCI_IDE(dev);
> -    int i;
> -
> -    for (i =3D 0; i < 2; ++i) {
> -        memory_region_del_subregion(&d->bmdma_bar, &d->bmdma[i].extra_io=
);
> -        memory_region_del_subregion(&d->bmdma_bar, &d->bmdma[i].addr_iop=
ort);
> -    }
> -}
> -
>  static void sii3112_pci_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -348,7 +337,6 @@ static void sii3112_pci_class_init(ObjectClass *klass=
, void *data)
>      pd->class_id =3D PCI_CLASS_STORAGE_RAID;
>      pd->revision =3D 1;
>      pd->realize =3D sii3112_pci_realize;
> -    pd->exit =3D sii3112_pci_exitfn;
>      dc->desc =3D "SiI3112A SATA controller";
>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqfTR0ACgkQbDjKyiDZ
s5LQUhAApkEWXkdedbhaaqLSBXSUGwh6viM0FjRFUHDncK02RBlNsExfbTZh5+hv
EmiYhl5cyS7JGi7ZXmnjNyXcwIDmaLyU20Z7sEw+UC7gYKvfRIpQGfGcPIKj3GHk
CT2gwa6DC6spXzUgCd0kpcreTywlmCjeoYDS1PjVBPyS7pc6qFpAbxMH4PDgyBpM
d5osWNNEUvIFQZKDS3idecq2xQjl2BB/i9PSeYgAHT9qAPN+7rL9UcvFAm3yrWpa
00twv+vvZMWnSq1emrQBBedSbd3hU4j8UkCsV78uSwZsoxz4qAFS49l/9gmL6YUe
V42GUnnqHAdxKgGI9sDaC+KLvH8/o5Y5HQL7iigpAlmBzwWZ9DhAyzFPjRnZfwB4
UFGcDKYmK/6dD0x/tqb0DopAVYH9OCvbNqT1U7b6RlX2RHjX+o3zSvtmZ1NTdgzh
LvQcVjtBHKlJ/A6tFL9yNq7V4LBLwUyntWOaZc6YlHvO1m8K8P2BbcW1lr+y9mL0
V1BfoSsiB2VdrEXpQqSV3EPLEQWXN8AwRB/cIPOCfPZf1n97eWmoqFKnd9+zrwd4
G4X0TWPRNW5HpBziVMNL5bCrUTA0fC7ZQQFHGhzvobABgtmdRtQJFsovTGLZ4YXH
UOpmRto4JjcmfC5/9ibfu5xWI2+bHW3COIMwQ+LIt323mW0jh98=
=EgTc
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
