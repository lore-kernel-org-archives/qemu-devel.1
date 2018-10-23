Received: from eggs.gnu.org ([2001:4830:134:3::10]:36857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEygl-0006fy-G3
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEycb-0007h6-6K
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:29:30 -0400
Date: Tue, 23 Oct 2018 16:23:50 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181023152350.GQ12127@umbus.hotspot.internet-for-guests.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<20181018200422.4358-37-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eLe8FOcWSbbyMVJD"
Content-Disposition: inline
In-Reply-To: <20181018200422.4358-37-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 36/45] net: lan9118: convert SysBus init
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


--eLe8FOcWSbbyMVJD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 05:04:13PM -0300, Eduardo Habkost wrote:
> From: C=E9dric Le Goater <clg@kaod.org>
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> Message-Id: <20181001063803.22330-4-clg@kaod.org>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/net/lan9118.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
> index b9032dac59..a6269d9463 100644
> --- a/hw/net/lan9118.c
> +++ b/hw/net/lan9118.c
> @@ -1320,9 +1320,9 @@ static NetClientInfo net_lan9118_info =3D {
>      .link_status_changed =3D lan9118_set_link,
>  };
> =20
> -static int lan9118_init1(SysBusDevice *sbd)
> +static void lan9118_realize(DeviceState *dev, Error **errp)
>  {
> -    DeviceState *dev =3D DEVICE(sbd);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>      lan9118_state *s =3D LAN9118(dev);
>      QEMUBH *bh;
>      int i;
> @@ -1349,8 +1349,6 @@ static int lan9118_init1(SysBusDevice *sbd)
>      s->timer =3D ptimer_init(bh, PTIMER_POLICY_DEFAULT);
>      ptimer_set_freq(s->timer, 10000);
>      ptimer_set_limit(s->timer, 0xffff, 1);
> -
> -    return 0;
>  }
> =20
>  static Property lan9118_properties[] =3D {
> @@ -1362,12 +1360,11 @@ static Property lan9118_properties[] =3D {
>  static void lan9118_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
> =20
> -    k->init =3D lan9118_init1;
>      dc->reset =3D lan9118_reset;
>      dc->props =3D lan9118_properties;
>      dc->vmsd =3D &vmstate_lan9118;
> +    dc->realize =3D lan9118_realize;
>  }
> =20
>  static const TypeInfo lan9118_info =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eLe8FOcWSbbyMVJD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvPPQYACgkQbDjKyiDZ
s5I88A//V2rT/Wje9fcPNIEE/vTsOlANi2zMYzpQMDghToF2hsVOV+X5GSVEAfSW
ycqt7GFGayATKOVNCLlf9amGtevbKGLqcajoKXcpWERbOnKSCoX267pS4P4Dpeax
yQRT14WJ21EC9cKMtD30rtxPZl57K0zNXLVSPr4sU5UmxQc5Aki3OnChJ3YtAZr8
+yax5i79gsrn1YRqY5nxlPnmenJ3vMRLjv3ZCYhUS309HfSyQXl3orrMbWFNcF5u
JDMwx4s7VYPegh2aI+58O58Su+tTL2xcu4gQ3ADKNXLeBXDQEVG4Fvy1sJ5ZMILc
sjqXNKDDm0MG6L2SAue3zdDVIXnkiX7gw01gxDpWdq9fa6sVA1VH35Zqi9/KpZxg
Mkv7aWR4pfcGhH+M2HsFADvjdciYrVaVNWR0Lk7usaDk4AoM7C/dZDLj/osq0dr4
xQBZcRp1TYMRJuBa3TvmUATNqKu/CdNuERbhaUJ5G0pyWMzteZZ1piubzeaAN18A
snTrGYKsIZz05IHz+JARFdEcb0RzFXl14SotwpGLN9wktycBflfOZ1H+Fxi7Gqbh
rEnHG7xP8fwz3KGqrElP2au0BgcR4tQouQ2jCc7CqOHf+BOEcuLgF6lCcxCIk6+y
kYU+uHC65xoDGeDRpZjFTiRUhUF7lYc/iP5lKXKEXT1ZYhwBkaQ=
=3Zsw
-----END PGP SIGNATURE-----

--eLe8FOcWSbbyMVJD--
