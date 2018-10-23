Received: from eggs.gnu.org ([2001:4830:134:3::10]:36857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEyhb-0006fy-8t
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEybq-0006vf-Eg
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:28:43 -0400
Date: Tue, 23 Oct 2018 16:10:48 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181023151048.GF12127@umbus.hotspot.internet-for-guests.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<20181018200422.4358-8-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SnV5plBeK2Ge1I9g"
Content-Disposition: inline
In-Reply-To: <20181018200422.4358-8-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 07/45] hw/timer/sun4v-rtc: Use
 DeviceState::realize rather than SysBusDevice::init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Michael Walle <michael@walle.cc>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>


--SnV5plBeK2Ge1I9g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 05:03:44PM -0300, Eduardo Habkost wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> Move from the legacy SysBusDevice::init method to using DeviceState::real=
ize.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
> Message-Id: <20181002212522.23303-4-f4bug@amsat.org>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/timer/sun4v-rtc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/timer/sun4v-rtc.c b/hw/timer/sun4v-rtc.c
> index 13be94f8da..4e7f6a1eff 100644
> --- a/hw/timer/sun4v-rtc.c
> +++ b/hw/timer/sun4v-rtc.c
> @@ -63,21 +63,21 @@ void sun4v_rtc_init(hwaddr addr)
>      sysbus_mmio_map(s, 0, addr);
>  }
> =20
> -static int sun4v_rtc_init1(SysBusDevice *dev)
> +static void sun4v_rtc_realize(DeviceState *dev, Error **errp)
>  {
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>      Sun4vRtc *s =3D SUN4V_RTC(dev);
> =20
>      memory_region_init_io(&s->iomem, OBJECT(s), &sun4v_rtc_ops, s,
>                            "sun4v-rtc", 0x08ULL);
> -    sysbus_init_mmio(dev, &s->iomem);
> -    return 0;
> +    sysbus_init_mmio(sbd, &s->iomem);
>  }
> =20
>  static void sun4v_rtc_class_init(ObjectClass *klass, void *data)
>  {
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> -    k->init =3D sun4v_rtc_init1;
> +    dc->realize =3D sun4v_rtc_realize;
>  }
> =20
>  static const TypeInfo sun4v_rtc_info =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SnV5plBeK2Ge1I9g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvPOfgACgkQbDjKyiDZ
s5J+JhAAh7or1/RlU9cSgOZRATifkzxV152kZy9r/PCiqv+YvVmbExMG4SKQVM5A
9XMNWws43h6i6NsDrc7uyJ0Bo8EmGc5SZD+KphcajjxGmMSrd7WC2CKJEnJRtdnC
r6yMQJyNb/cv14LMfT1TchfEqcQ2I9SIVhfDNbTNzFX14baIPENgoO0tx0OMM6Rm
SOh3mWzKoTHCCwuS5V8HUU7vjnWMsPjyId3euchhWJQPJr3Lb5qZD2fMB4YehIoC
DsRqHPXYrtMmLLloepjn4yQY97j5bBF0LSp4o3OVl78ofIDyd53JekRmv7Ak4zTl
hZRaWM4vC8F79Yg8WYpIJJCY49s1ZsDJuOtCDPQjxONzGkWPsYkXH4Hb9cHW1GYc
pA3Cm1HaW0IENDIyMlTNWBofAh1Is9ApNrK76JAoOKMSA/xGei9SUQ0fXFI5iw3J
xcRLlWw1WipAmNHl5NB/29TecNEx/QHOe+OeW1n1r459InqFVS2+H7YOLWHE92VP
81Out1uXRJfXEgm5o6YQn7M/7wIfNb6QfDDv7Ra8dsCvWYZe/xBW6+DFdK/AzI+H
DTxyz6x+5B4zFWqWZeq3udCFVrin+q64nOcSBoW350Dau40BfZ487c8jLWORWmTg
ZViLxFZ0OuksVKuhYSss4psms7h+HxvGQm8Dtk+J2kv+dSUvgbw=
=QKK4
-----END PGP SIGNATURE-----

--SnV5plBeK2Ge1I9g--
