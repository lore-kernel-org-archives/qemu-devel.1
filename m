Received: from eggs.gnu.org ([2001:4830:134:3::10]:36857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEyhU-0006fy-Nh
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEybt-0006zo-KN
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:28:47 -0400
Date: Tue, 23 Oct 2018 16:24:23 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181023152423.GR12127@umbus.hotspot.internet-for-guests.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<20181018200422.4358-38-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cYG5ZC/RuVsIq1ir"
Content-Disposition: inline
In-Reply-To: <20181018200422.4358-38-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 37/45] net: lance: convert SysBus init
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


--cYG5ZC/RuVsIq1ir
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Thu, Oct 18, 2018 at 05:04:14PM -0300, Eduardo Habkost wrote:
> From: C=E9dric Le Goater <clg@kaod.org>
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Message-Id: <20181001063803.22330-5-clg@kaod.org>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/net/lance.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/net/lance.c b/hw/net/lance.c
> index a08d5ac6a8..f987b2fd18 100644
> --- a/hw/net/lance.c
> +++ b/hw/net/lance.c
> @@ -97,9 +97,9 @@ static const VMStateDescription vmstate_lance =3D {
>      }
>  };
> =20
> -static int lance_init(SysBusDevice *sbd)
> +static void lance_realize(DeviceState *dev, Error **errp)
>  {
> -    DeviceState *dev =3D DEVICE(sbd);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>      SysBusPCNetState *d =3D SYSBUS_PCNET(dev);
>      PCNetState *s =3D &d->state;
> =20
> @@ -115,7 +115,6 @@ static int lance_init(SysBusDevice *sbd)
>      s->phys_mem_read =3D ledma_memory_read;
>      s->phys_mem_write =3D ledma_memory_write;
>      pcnet_common_init(dev, s, &net_lance_info);
> -    return 0;
>  }
> =20
>  static void lance_reset(DeviceState *dev)
> @@ -144,9 +143,8 @@ static Property lance_properties[] =3D {
>  static void lance_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
> =20
> -    k->init =3D lance_init;
> +    dc->realize =3D lance_realize;
>      set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
>      dc->fw_name =3D "ethernet";
>      dc->reset =3D lance_reset;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cYG5ZC/RuVsIq1ir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvPPSYACgkQbDjKyiDZ
s5L7zA//f/d4cXZuCgxXj2DMfSlgTsd9nawtpOV9bdBh3qxg7wM7KO24rxC5Ut0u
1qDuCQDu1Jvm6xOuF2+myf4GnvB+R0HJgfaH9z8CzJjvdQQIllO5rXjTv2/8XqTz
iWBT8+jtb/PkK5P+qay32IjSi8uNEt4N7EwPLMVLeFB80dGpfzJrgVfy7bQ+FONb
ED33JP0/FpV15FnN2MUfrxdvNIdPEfb1STx3NO5JqOLgByEoZJ9UcgMb2Q+2WPQb
MkKQjd9kTbQBUo4ABx/FVEoQ44y2uuJMQ6hEfygmpgmr7Eaf1OyTQj9n3j+RYs0B
9j3gqGzAWQrJ5VoqcUra0yI1eFy5S3VX7LCicyROhJRVAuvXAnhpI6sPdMTqbZRU
rw9qgchJQ8u6kHBkyObHFlmz4d7VgLVt418nBXV05m/S8eKbsOSCY+4e2SPWWDf1
tlo2YQCJN1YqjNqmoIZdE8jFapzGPJAtxoQHRcvU/w63pR6CypGnsqP7Sc0SZVzF
nbWUViKjqNC1tYUZKEUEs8ZiLvdskKMMYWmArSHVltiJ6R+JFqo/Pnud+/aeIaKs
DgGXAXHL0zDZaOiH5ubIugtUUGvetmpY/+y8qAA174FaVI/CimUQKWh/YBGcpurK
s/jdv+sMLgVS6QTsgKT89tx6mq1H7MK2ATtdooHN1/q9RIPLM+k=
=AU3U
-----END PGP SIGNATURE-----

--cYG5ZC/RuVsIq1ir--
