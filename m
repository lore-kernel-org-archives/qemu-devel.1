Received: from eggs.gnu.org ([2001:4830:134:3::10]:60159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gPOQN-0001Hk-Nl
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 04:03:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gPOQK-0007Rx-JT
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 04:03:55 -0500
Date: Wed, 21 Nov 2018 19:42:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181121084230.GA10448@umbus.fritz.box>
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
	<20181119120820.29878-16-maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <20181119120820.29878-16-maozhongyi@cmss.chinamobile.com>
Subject: Re: [Qemu-devel] [PATCH 15/22] pci-bridge/dec: Convert sysbus init
 function to realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com, qemu-ppc@nongnu.org, Zhang Shengju <zhangshengju@cmss.chinamobile.com>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 19, 2018 at 08:08:13PM +0800, Mao Zhongyi wrote:
> Use DeviceClass rather than SysBusDeviceClass in
> pci_dec_21154_device_class_init().
>=20
> Cc: david@gibson.dropbear.id.au
> Cc: mst@redhat.com
> Cc: marcel.apfelbaum@gmail.com
> Cc: qemu-ppc@nongnu.org
>=20
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/pci-bridge/dec.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/pci-bridge/dec.c b/hw/pci-bridge/dec.c
> index 84492d5e5f..5b21c20e50 100644
> --- a/hw/pci-bridge/dec.c
> +++ b/hw/pci-bridge/dec.c
> @@ -98,7 +98,7 @@ PCIBus *pci_dec_21154_init(PCIBus *parent_bus, int devf=
n)
>      return pci_bridge_get_sec_bus(br);
>  }
> =20
> -static int pci_dec_21154_device_init(SysBusDevice *dev)
> +static void pci_dec_21154_device_realize(DeviceState *dev, Error **errp)
>  {
>      PCIHostState *phb;
> =20
> @@ -108,9 +108,8 @@ static int pci_dec_21154_device_init(SysBusDevice *de=
v)
>                            dev, "pci-conf-idx", 0x1000);
>      memory_region_init_io(&phb->data_mem, OBJECT(dev), &pci_host_data_le=
_ops,
>                            dev, "pci-data-idx", 0x1000);
> -    sysbus_init_mmio(dev, &phb->conf_mem);
> -    sysbus_init_mmio(dev, &phb->data_mem);
> -    return 0;
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &phb->conf_mem);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &phb->data_mem);
>  }
> =20
>  static void dec_21154_pci_host_realize(PCIDevice *d, Error **errp)
> @@ -150,9 +149,9 @@ static const TypeInfo dec_21154_pci_host_info =3D {
> =20
>  static void pci_dec_21154_device_class_init(ObjectClass *klass, void *da=
ta)
>  {
> -    SysBusDeviceClass *sdc =3D SYS_BUS_DEVICE_CLASS(klass);
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> -    sdc->init =3D pci_dec_21154_device_init;
> +    dc->realize =3D pci_dec_21154_device_realize;
>  }
> =20
>  static const TypeInfo pci_dec_21154_device_info =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv1GnMACgkQbDjKyiDZ
s5L53A/+InPGP00kkA6rcGJ542ZHsywiSBO5FZQ+7iAhGTqbNhw3qBCMhUSaW3eP
ioeTGeeFnVOgbi04PGD6pjB7RINPaH6w3CBhU5S0iS7y3r132gMcQVPo8HLyRTYn
i8LAo/YYjZHiFuIasD902BP8oaYMH35WDZSP2nt7rDFxLcqMq8isVMDyGAccS6Kf
0YJu6+kndbJWpMpzwwX36V+7b6HmRT1Q4QFmxJEYW3QP1n8eFVKiq/LQc31+XKZi
21PPY/Orr3dTiKXSPh0iHLmAhsqiD9dspCLmCDJvGXY85DwI3GVobCm1iiwA3VQr
RdsQs/ew9fgL1K0HW8gZK/2DUjfrk8/0KdmWcVcwHCefwBQ6fLYTtnR6OdtSHi2G
XnUjwUMNHxnStdysDLC/3W95MuVw450CSyLYTAHQi9012LVPyADgjZ+tNeeLDNqk
/7o265JcCMKPiuYXpOIle51LhsbFY9yhrqh4d0zewDbAPr4xXwk1G0EZfqatjQJb
9EoBmZ683DfICjg/3Yu/k6QreXeY8DuEWhq+oLwlltKxk8HjsYX3abrGvJr6zFzN
zThFYP/UqT/qpXNlooZ93yFuxY9smOT5+KBA3hefASdiKsq/eBA69eDZjEHDBBKB
jlWIdBQI4V6jwNk3fDQyoGJvyt2mSIZkTpTVNI3Knr15gM7sP28=
=w6wx
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
