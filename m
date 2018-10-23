Received: from eggs.gnu.org ([2001:4830:134:3::10]:37233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEyhT-0007C3-22
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEybu-00071W-Vz
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:28:47 -0400
Date: Tue, 23 Oct 2018 16:16:23 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181023151623.GJ12127@umbus.hotspot.internet-for-guests.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<20181018200422.4358-13-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z8yxTSU1mh2gsre7"
Content-Disposition: inline
In-Reply-To: <20181018200422.4358-13-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 12/45] hw/mips/gt64xxx_pci: Mark as bridge
 device
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


--Z8yxTSU1mh2gsre7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 05:03:49PM -0300, Eduardo Habkost wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> The gt64120 is currently listed as uncategorized device.
> Mark it as bridge device.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
> Message-Id: <20181002212522.23303-9-f4bug@amsat.org>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/mips/gt64xxx_pci.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
> index dcd1a66329..1cd8aac658 100644
> --- a/hw/mips/gt64xxx_pci.c
> +++ b/hw/mips/gt64xxx_pci.c
> @@ -1232,6 +1232,7 @@ static void gt64120_class_init(ObjectClass *klass, =
void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      dc->reset =3D gt64120_reset;
>      dc->vmsd =3D &vmstate_gt64120;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Z8yxTSU1mh2gsre7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvPO0cACgkQbDjKyiDZ
s5KDexAAgqzYYh+7ZBK4y1kdR2vMkSOrWlAcUwaoMcFmBP1gow1WYIjcOrFV/mZW
9/gqh3gf6BRaUu9M8YWbUVglbb7gaOi9cx5DoTVGA2/sGDrM9NN6b5K7wwJ4fDvh
sYpxRqyoVushPUgLtyUgFFylATZG7aNP0cH/MBcda2RBs/+XU0rl/13vNbFdGrHl
GvS+n2To2ZOxX6XY70aRdTIZlbZLKM8GYeIoD1VkBnAdGnRFuTBEau9TzJWTPi1K
/m1yfy93mWXeXflEjCNamYNtbYv4NwctQn9JHQrUu/yqi8bwooij0oNUT55x+KXb
MP8deUawNgqDn33QC1EGvz7yObpBibLmZ9RHyGT9UH1+VvFC534o7Oygu+l/vAG3
axAOc39oHby+pr9AgVxHNV243trIch6kv/eG93yNSLJO0UfHAicHKjd1f9V+nIn3
dWZMCohxDJn0zglnVvWME41kR50gtFuzVNmVVA9VIOg+0dJB4lCIWBLW+gXBm9C9
IPwV9DlT0YAo0/8hrsk7kXnRVlwD2QcYuQcpH+rLpav7WDUFJYR8IrpZG5O1StlJ
1Y1gr1mIeZJPQr6y4rL9++9wXC8js2+JRn30hHMep9rgj2irNKX+/PjhX6Zf+VyH
Zdu6FXcvO48D637gkvQ2sf48j7RAxcj9LIMGP4dLdAu5nrDTcWc=
=Kzj5
-----END PGP SIGNATURE-----

--Z8yxTSU1mh2gsre7--
