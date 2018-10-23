Received: from eggs.gnu.org ([2001:4830:134:3::10]:37006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEyhI-0006ks-Pw
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:34:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEybx-00076M-S8
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:28:51 -0400
Date: Tue, 23 Oct 2018 16:18:59 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181023151859.GL12127@umbus.hotspot.internet-for-guests.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<20181018200422.4358-16-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V3eawNQxI9TAjvgi"
Content-Disposition: inline
In-Reply-To: <20181018200422.4358-16-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 15/45] hw/hppa/dino: Remove unuseful code
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


--V3eawNQxI9TAjvgi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 05:03:52PM -0300, Eduardo Habkost wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20181002212522.23303-12-f4bug@amsat.org>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/hppa/dino.c | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
> index 564b938e3a..31e09942b5 100644
> --- a/hw/hppa/dino.c
> +++ b/hw/hppa/dino.c
> @@ -488,17 +488,10 @@ PCIBus *dino_init(MemoryRegion *addr_space,
>      return b;
>  }
> =20
> -static int dino_pcihost_init(SysBusDevice *dev)
> -{
> -    return 0;
> -}
> -
>  static void dino_pcihost_class_init(ObjectClass *klass, void *data)
>  {
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> -    k->init =3D dino_pcihost_init;
>      dc->vmsd =3D &vmstate_dino;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--V3eawNQxI9TAjvgi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvPO+MACgkQbDjKyiDZ
s5LBsRAA3DqajFZABBiaigBwzG94RotGK+p8Ci+sVj7XV7XV5VKol+J5D+wJgc+q
sO2dPYMbmvnDf7yc0QYPhkWuWSSF9E9D5cXqQbFuKHPKOhuYVUwwOyMOx2NdF0rQ
bhgPCoTPTO6bIREYp79Ox86xR1LRIjs87P4+e+6obro8xAeEJfHvauuR9IF1BgQW
KhnDgnZyuP4z94G6qKvSQZa/WRMREoQeknbvg2JJ9DHcS3XVIa/2/fAfVcBU3/mj
dq7jgudx9kkRf4N0IwUvyjIWwOS6vXSsHkLgsxqK2pD2kL+3OXBN9d32B3/wMb+B
dskzCT3BNn2/OLgB6fiSQr/Nos174zMBlXvDVfwBugJ1XiYgofVGw7D84L6YyJct
Y9g3Lw17r0zDEgyeSEQSGqs2do6Ed/rWwRNjzbC1JsVJL9cSAnHF/m+zrN4tfIAv
pql8g/MDUe2dagk8vuRRsmWRsEQlpdlQM/I8Q8/WlRMD8y/Bg5cGKI+5PwuMIf8+
Fr/CNhcKNpKzn1JbgrE1Zcb6TWlG9Ot8PI8l4iDsBomexXtZTHdLTGxoXb0AfEwn
pV74PawItuB2NAmNZPCkXR1wtNZYu92UgGVRx3XMkQRUglN74LfjSCULNJzWkCJJ
Xw0yuNg+qcqYyS95rXQYPcJApk3trX0lFIjEY9TWlDCtVYFpCs0=
=+/4C
-----END PGP SIGNATURE-----

--V3eawNQxI9TAjvgi--
