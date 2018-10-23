Received: from eggs.gnu.org ([2001:4830:134:3::10]:37006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEyhU-0006ks-1o
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEybu-00070W-4K
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:28:47 -0400
Date: Tue, 23 Oct 2018 16:19:24 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181023151924.GM12127@umbus.hotspot.internet-for-guests.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<20181018200422.4358-17-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kkcDP0v44wDpNmbp"
Content-Disposition: inline
In-Reply-To: <20181018200422.4358-17-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 16/45] hw/mips/malta: Remove unuseful code
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


--kkcDP0v44wDpNmbp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 05:03:53PM -0300, Eduardo Habkost wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20181002212522.23303-13-f4bug@amsat.org>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/mips/mips_malta.c | 13 -------------
>  1 file changed, 13 deletions(-)
>=20
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 29b90bacf3..c1cf0fe12e 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1422,23 +1422,10 @@ void mips_malta_init(MachineState *machine)
>      pci_vga_init(pci_bus);
>  }
> =20
> -static int mips_malta_sysbus_device_init(SysBusDevice *sysbusdev)
> -{
> -    return 0;
> -}
> -
> -static void mips_malta_class_init(ObjectClass *klass, void *data)
> -{
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
> -
> -    k->init =3D mips_malta_sysbus_device_init;
> -}
> -
>  static const TypeInfo mips_malta_device =3D {
>      .name          =3D TYPE_MIPS_MALTA,
>      .parent        =3D TYPE_SYS_BUS_DEVICE,
>      .instance_size =3D sizeof(MaltaState),
> -    .class_init    =3D mips_malta_class_init,
>  };
> =20
>  static void mips_malta_machine_init(MachineClass *mc)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kkcDP0v44wDpNmbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvPO/wACgkQbDjKyiDZ
s5IISBAAw8dQ45zestRaDVu52GMGGL0cW8ZqZwovyxhG25XbnHHiRnaGJ3INgMPK
85HC4U6RaGAmp/EtZMC1JuluryszsEyTUIjYKSQMv+ReBnHyXA1Q02rvFAsn9rbN
3eEIzhwcZMPjVS3DoicJ/R14/y5vbHudkpi37/Ws6glLoL+/viYNwRQf+WMMRnxU
dykAx0D9VSmzMTRS9c5h9V2lwpsGsPCX3XN+d+ccKdwpaL1kJW7vkiDHb6z9Rwh0
xE4JBYT8Fr7fQE0eokKXd42WwnB6NwCAym1KAipkXN6KctAbE5R9KU66skNi658r
l6LjFRrhoxaubZC5lERPxcJHcUO6aK7bO2BT0dCudWbgKUCJJZvxkU13YUDfbtde
uruNo3YmlG3IwJVxYEBGW8Lbk/l5SORITFyy+60azMD29/Dl/vrmHl6N+mDp/rMF
/Ndzh0nGT5jRuTpIeHj39kRc3u8qybFCeEi2u4kl7xYgbgqcxsQn3Ql3RGhn83I9
BdmPKTzTyuRiP5iU65V2fMx/C7AuS9XTmrvF2ydU5VOoXlxDKMyw9fKkuRfcp1Lp
j9LgUTaTHjFDci6jzb4d7MvYWk9KoOJC+ITkvOecqVrt2a9GrF0ij0prUKdAZqIz
LNe7+qoUo6klsp7Q6FSfqTWXgbKgD4MeOuh76Ab0tpPEguAkRf8=
=9gx8
-----END PGP SIGNATURE-----

--kkcDP0v44wDpNmbp--
