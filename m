Received: from eggs.gnu.org ([2001:4830:134:3::10]:37006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEyhC-0006ks-AX
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEyby-00076i-3M
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:28:51 -0400
Date: Tue, 23 Oct 2018 16:25:57 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181023152557.GV12127@umbus.hotspot.internet-for-guests.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<20181018200422.4358-42-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Zd8I2GZVcdxtyaG/"
Content-Disposition: inline
In-Reply-To: <20181018200422.4358-42-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 41/45] net: smc91c111: convert SysBus init
 method to a realize method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Michael Walle <michael@walle.cc>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--Zd8I2GZVcdxtyaG/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 05:04:18PM -0300, Eduardo Habkost wrote:
> From: C=E9dric Le Goater <clg@kaod.org>
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> Message-Id: <20181001063803.22330-9-clg@kaod.org>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/net/smc91c111.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
> index d2fd2040e8..99da2d9297 100644
> --- a/hw/net/smc91c111.c
> +++ b/hw/net/smc91c111.c
> @@ -766,9 +766,9 @@ static NetClientInfo net_smc91c111_info =3D {
>      .receive =3D smc91c111_receive,
>  };
> =20
> -static int smc91c111_init1(SysBusDevice *sbd)
> +static void smc91c111_realize(DeviceState *dev, Error **errp)
>  {
> -    DeviceState *dev =3D DEVICE(sbd);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>      smc91c111_state *s =3D SMC91C111(dev);
> =20
>      memory_region_init_io(&s->mmio, OBJECT(s), &smc91c111_mem_ops, s,
> @@ -780,7 +780,6 @@ static int smc91c111_init1(SysBusDevice *sbd)
>                            object_get_typename(OBJECT(dev)), dev->id, s);
>      qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
>      /* ??? Save/restore.  */
> -    return 0;
>  }
> =20
>  static Property smc91c111_properties[] =3D {
> @@ -791,9 +790,8 @@ static Property smc91c111_properties[] =3D {
>  static void smc91c111_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
> =20
> -    k->init =3D smc91c111_init1;
> +    dc->realize =3D smc91c111_realize;
>      dc->reset =3D smc91c111_reset;
>      dc->vmsd =3D &vmstate_smc91c111;
>      dc->props =3D smc91c111_properties;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Zd8I2GZVcdxtyaG/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvPPYUACgkQbDjKyiDZ
s5KYGw/+J49J74ma2Qncbz0rUAlphJfIXryCOepHL/qP8//G4Be71VDPYLWlo+7P
5Td6W62Ygn6ny/c4MKzKUugQWbWsRLSdhd5aaAE+E0zk23VXFuhr9hWgZOT2ImRW
CPrYd0LpFEq4+g4l7DQ29JMASlH2Lmwk/DqCEHmTd4YZk8aoRz+BAuKn4EzLAYLd
fGcqclqbXghvbq2IdEb0Gq7K/6oZOT782eetZ2d6PASsjiLaTx8+HOu0nbFK2S7M
vQy1wTXYTIl1wq6tzE9UTXVFmi1AbEYihLbo94hZ3lZJteVB7/ycB4f1W/gWc9B7
h6t1w8udQLTWyMwfhAq7yRGTilx6Z2dJk2ZadU3TyLLoGkd/K/0MryB/k+gSlv0p
fPJzMFA38UAPxhicouGz051ENnH3duYq0PF1tX4Mf12rWacC1ABjiZlRtRIhujfh
MJ7T4mqCq9vxoDtzypUHyc5B++JhPg7gRVSRj9fBEeu/auYVplD9/hEsf5EFJe3o
OabtrWMT6JFyZOpUPOcE5kgtWpkOupm6PPAgUeDSmSpK9Avh5/m0/cRhH9EClM5h
c89LKAgaW28lcH8tvd0hsJaVEAgBoNCxRgngk8ys75akkG8U9UusOdJVflTZu6h1
9+DPnNb6QY1xC6CIHssnHJYHoSa+gh2LttvY99lJuXObWA8xf28=
=/3S7
-----END PGP SIGNATURE-----

--Zd8I2GZVcdxtyaG/--
