Received: from eggs.gnu.org ([2001:4830:134:3::10]:37552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gJx5c-0002zP-Jn
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 03:52:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gJwz4-0006Kt-IW
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 03:45:16 -0500
Date: Tue, 6 Nov 2018 19:14:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181106081455.GD3539@umbus.fritz.box>
References: <20181105102044.20547-1-david@redhat.com>
	<20181105102044.20547-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Content-Disposition: inline
In-Reply-To: <20181105102044.20547-4-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 03/10] s390x/pci: rename hotplug handler
 callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2018 at 11:20:37AM +0100, David Hildenbrand wrote:
> The callbacks are also called for cold plugged devices. Drop the "hot"
> to better match the actual callback names.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/s390x/s390-pci-bus.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index e42e1b80d6..e1b14b131b 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -813,8 +813,8 @@ static bool s390_pci_alloc_idx(S390pciState *s, S390P=
CIBusDevice *pbdev)
>      return true;
>  }
> =20
> -static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
> -                                  DeviceState *dev, Error **errp)
> +static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *=
dev,
> +                              Error **errp)
>  {
>      PCIDevice *pdev =3D NULL;
>      S390PCIBusDevice *pbdev =3D NULL;
> @@ -923,8 +923,8 @@ static void s390_pcihost_timer_cb(void *opaque)
>      qdev_unplug(DEVICE(pbdev), NULL);
>  }
> =20
> -static void s390_pcihost_hot_unplug(HotplugHandler *hotplug_dev,
> -                                    DeviceState *dev, Error **errp)
> +static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState=
 *dev,
> +                                Error **errp)
>  {
>      PCIDevice *pci_dev =3D NULL;
>      PCIBus *bus;
> @@ -1032,8 +1032,8 @@ static void s390_pcihost_class_init(ObjectClass *kl=
ass, void *data)
> =20
>      dc->reset =3D s390_pcihost_reset;
>      dc->realize =3D s390_pcihost_realize;
> -    hc->plug =3D s390_pcihost_hot_plug;
> -    hc->unplug =3D s390_pcihost_hot_unplug;
> +    hc->plug =3D s390_pcihost_plug;
> +    hc->unplug =3D s390_pcihost_unplug;
>      msi_nonbroken =3D true;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvhTX8ACgkQbDjKyiDZ
s5Ljrw/+IwVWPJHZSHv9IMd+efY6QTZxOym6j8+2AfVczkz7CRf6Xc3R4tntBiyf
8PfhvJouS+hgcRbZwiY2V1tjg0Y0GDHXCoVRfVxExsCaabqxyEE8Kkdz2/Vq14Fa
uBdvcMfveyQrmBlNdUeeOeopipP4xXzeAvy8lnwud918wrpSv8letQs12H30BWtY
0AZPHvqxztzoLBYbavzVvNRb3SJCAbug6AtLlpUr4SiHslS+BJ60szJK0h8n3reR
5AVRZvGVH2Gs2aAcexGkpvbkAn7HTunD/5VUFR619WW65zQogG/Lb7FTy4iAol37
7yDBq3Ij1mPvsCP5aE8ZQsV6SiMCqIAm3B73+wQEoQunGmzwTAaesPowzQBV3Aap
AReBsnq7PXbLMZOzx9ZnGG2PR6w+x3aTTeSTSwPFdkL1mTq8uYcxPPjEOkmQEvj7
mmr98sBxJtxasbmSHzRdGndFbJJcNw0kXz7/5S4Zc0PWymMz5rWMCwzPrb93MG0C
BUdex+5hKP40M1kIrttJzJu2Vvs/Z51h/psmy5FtU0F6wj2aMDXmk8n7kX2nj1Fv
Rnwh0dgRYUac99rFXaB9AW//MxxU8qsiFodysCSKBoKsb2C1addvCU9TqEeST3gH
B8Aj45cuwGsJgpY88wMbsZYcE7TAaH5U/ShcIaAIWL4eDbrXLck=
=zAAB
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--
