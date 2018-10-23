Received: from eggs.gnu.org ([2001:4830:134:3::10]:37363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEyhT-0007I5-2u
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:34:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEybv-00071b-0g
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:28:47 -0400
Date: Tue, 23 Oct 2018 16:18:42 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181023151842.GK12127@umbus.hotspot.internet-for-guests.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<20181018200422.4358-15-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J2pR2RtFp0tAjF3C"
Content-Disposition: inline
In-Reply-To: <20181018200422.4358-15-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 14/45] hw/alpha/typhoon: Remove unuseful code
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


--J2pR2RtFp0tAjF3C
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 05:03:51PM -0300, Eduardo Habkost wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20181002212522.23303-11-f4bug@amsat.org>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/alpha/typhoon.c | 13 -------------
>  1 file changed, 13 deletions(-)
>=20
> diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
> index d74b5b55e1..8004afe45b 100644
> --- a/hw/alpha/typhoon.c
> +++ b/hw/alpha/typhoon.c
> @@ -932,23 +932,10 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **=
isa_bus,
>      return b;
>  }
> =20
> -static int typhoon_pcihost_init(SysBusDevice *dev)
> -{
> -    return 0;
> -}
> -
> -static void typhoon_pcihost_class_init(ObjectClass *klass, void *data)
> -{
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
> -
> -    k->init =3D typhoon_pcihost_init;
> -}
> -
>  static const TypeInfo typhoon_pcihost_info =3D {
>      .name          =3D TYPE_TYPHOON_PCI_HOST_BRIDGE,
>      .parent        =3D TYPE_PCI_HOST_BRIDGE,
>      .instance_size =3D sizeof(TyphoonState),
> -    .class_init    =3D typhoon_pcihost_class_init,
>  };
> =20
>  static void typhoon_iommu_memory_region_class_init(ObjectClass *klass,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--J2pR2RtFp0tAjF3C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvPO9IACgkQbDjKyiDZ
s5IpEQ//TIL1ZV6bFSoP+Hl3IiQornbLwEB5GNX5LOlksisV2K+XxO8eQj0wz2Gz
DVdqg7zDao5vGO6nQAAAIJkD0x5j2OuV0aHY/B65k9OBLhwbXjFwNMTdl7BOC4ip
fVuEdeHVIsMHYARdcfhbRtL3eXDMvHJx/CJKxIw/w1Tf3RTD2p5ES2oXwLRpJn3I
k+mVkt8Om/Apv+x6eu/PmieVCJUqamdPESLVDQZ211dsP1sDrRXnFEpj79rjtvEd
yJUOq1hYCw7UgcyLR5E0Ce5PLbonM+Z3Rp9OT8M5VlyvBff9egHHufUz7MbayY9C
FfPlCdeNKIoweaRoCgUjDMpkb7ygTjKZK1NV3aTr4/D5ZhJ6OaoV2SUaK4iCX38b
Uq/h74BcQAtYVKE3SmMBCHJMu6naskD5llCHD8Rq1Pq69R/iDFosn5Z69jedT4lR
BW+XH+ViMj+b20JZh2SWyijN62xQ9gjPW3wImjrj3aHsTn8MMo6y+K41QGjxMqaj
3kh8QAR95l6bfch2GF74+aRQB2FriOUG1SrB/ilzxOCTpVE2cj4cwbAeQR00SCTx
avV4dlS9C+3SzxeKUEOMrY7OanOC+1STY2HuV9ytgea0hsoLQpm8FB/s+RNZlDdn
81Uxo2xcG8bWRC0sDWmyriW5Zg4HzOuHr7FZpdGXLBirSgvmJQ8=
=f7ha
-----END PGP SIGNATURE-----

--J2pR2RtFp0tAjF3C--
