Received: from eggs.gnu.org ([2001:4830:134:3::10]:37006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEyhL-0006ks-Jn
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEybx-00075p-L1
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:28:51 -0400
Date: Tue, 23 Oct 2018 16:24:49 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181023152449.GS12127@umbus.hotspot.internet-for-guests.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<20181018200422.4358-39-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kLVKJMuKEUFaIs8+"
Content-Disposition: inline
In-Reply-To: <20181018200422.4358-39-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 38/45] net: milkymist_minimac2: convert
 SysBus init method to a realize method
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


--kLVKJMuKEUFaIs8+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 05:04:15PM -0300, Eduardo Habkost wrote:
> From: C=E9dric Le Goater <clg@kaod.org>
>=20
> Cc: Michael Walle <michael@walle.cc>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Message-Id: <20181001063803.22330-6-clg@kaod.org>
> Acked-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/net/milkymist-minimac2.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/net/milkymist-minimac2.c b/hw/net/milkymist-minimac2.c
> index 3eaa19dfde..7ef1daee41 100644
> --- a/hw/net/milkymist-minimac2.c
> +++ b/hw/net/milkymist-minimac2.c
> @@ -452,9 +452,9 @@ static NetClientInfo net_milkymist_minimac2_info =3D {
>      .receive =3D minimac2_rx,
>  };
> =20
> -static int milkymist_minimac2_init(SysBusDevice *sbd)
> +static void milkymist_minimac2_realize(DeviceState *dev, Error **errp)
>  {
> -    DeviceState *dev =3D DEVICE(sbd);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>      MilkymistMinimac2State *s =3D MILKYMIST_MINIMAC2(dev);
>      size_t buffers_size =3D TARGET_PAGE_ALIGN(3 * MINIMAC2_BUFFER_SIZE);
> =20
> @@ -479,8 +479,6 @@ static int milkymist_minimac2_init(SysBusDevice *sbd)
>      s->nic =3D qemu_new_nic(&net_milkymist_minimac2_info, &s->conf,
>                            object_get_typename(OBJECT(dev)), dev->id, s);
>      qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
> -
> -    return 0;
>  }
> =20
>  static const VMStateDescription vmstate_milkymist_minimac2_mdio =3D {
> @@ -521,9 +519,8 @@ static Property milkymist_minimac2_properties[] =3D {
>  static void milkymist_minimac2_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
> =20
> -    k->init =3D milkymist_minimac2_init;
> +    dc->realize =3D milkymist_minimac2_realize;
>      dc->reset =3D milkymist_minimac2_reset;
>      dc->vmsd =3D &vmstate_milkymist_minimac2;
>      dc->props =3D milkymist_minimac2_properties;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kLVKJMuKEUFaIs8+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvPPUEACgkQbDjKyiDZ
s5LTjA//b4fFkv7v2xUK7KFXjb9QPVdtqZGXSsfJRiCROsPSxlBffxLhvDiZtaHH
Ohwd4L+04jhv1TZZsVN2X7iIB4LHSj21iXh2yfVtOK4N9CObvv5R1nMCinXG1qY0
AfbLshE7jA1squ49/15Q65ckasB8/Xxqq001cJlpN5/nu0JpPAq8fsPS0JpWOEEj
IkivTfLKmNJOjRKX9ED6aK023L2DmlNzEc4dI80cRbHGEMVDEREjSUaoR1PnezvD
iLERZKU8oPiXJlDboBcDCai3bs6AXImSBfgkmTYdakAFpecKiRQ5OQOs+me70qOM
UMr6qcY/nOV90WjJCvRRhdkKaACQnGuiedukvnKW7yt5pOQONM6y5RPZz5HNIEpt
fndalqtXYZEsZhmFJu+GL0i0I2m/gCsbN1H4TX4ffY81dLXGAWQ8s2edCAjuNZk1
ItXa6uX9KnUN43xwTayINBJPsohqxaJGuMjLCZvUc4GM6PdMM+2Q/7nMfZm6SBmn
atr4/X+42JEMrctUDt1Dp3MAj02F5BbKjeALVcoPedbBkm2yQBT8rEiw8s2rZJtA
BC3rYMozkKVUpZXAbT2k7r+aeBvPWi/hiFhtK6YCMi/Dg3VSmBHLzIhGfbDkezTo
hhCCrF9xIkg8fsfrcNZwRQlOM/mRagT9OvH3NpDShIZkFm03atA=
=4xLF
-----END PGP SIGNATURE-----

--kLVKJMuKEUFaIs8+--
