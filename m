Received: from eggs.gnu.org ([2001:4830:134:3::10]:53604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHMOn-0002hb-U1
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 23:12:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHMOm-0002XM-PV
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 23:12:33 -0500
Date: Wed, 22 Nov 2017 14:58:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171122035831.GK2380@umbus.fritz.box>
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
	<20171120032420.9134-6-mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Tv3+oRj6D9L8lW+H"
Content-Disposition: inline
In-Reply-To: <20171120032420.9134-6-mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 05/12] e500: name openpic and pci host
 bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--Tv3+oRj6D9L8lW+H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2017 at 09:24:13PM -0600, Michael Davidsaver wrote:
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>

Applied to ppc-for-2.12.

> ---
>  hw/ppc/e500.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 057be1751b..6f77844303 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -685,6 +685,8 @@ static DeviceState *ppce500_init_mpic_qemu(PPCE500Par=
ams *params,
>      int i, j, k;
> =20
>      dev =3D qdev_create(NULL, TYPE_OPENPIC);
> +    object_property_add_child(qdev_get_machine(), "pic", OBJECT(dev),
> +                              &error_fatal);
>      qdev_prop_set_uint32(dev, "model", params->mpic_version);
>      qdev_prop_set_uint32(dev, "nb_cpus", smp_cpus);
> =20
> @@ -876,6 +878,8 @@ void ppce500_init(MachineState *machine, PPCE500Param=
s *params)
> =20
>      /* PCI */
>      dev =3D qdev_create(NULL, "e500-pcihost");
> +    object_property_add_child(qdev_get_machine(), "pci-host", OBJECT(dev=
),
> +                              &error_abort);
>      qdev_prop_set_uint32(dev, "first_slot", params->pci_first_slot);
>      qdev_prop_set_uint32(dev, "first_pin_irq", pci_irq_nrs[0]);
>      qdev_init_nofail(dev);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Tv3+oRj6D9L8lW+H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloU9ecACgkQbDjKyiDZ
s5LgRw/+MmATKoeZfhfpnX+pG/D9HwnfDIRoiDE1f804/T2HfDbcZRJGkdBMP4KF
9CURhaKGcmsJzaidmypsK6OyDH0TQ0JSbKQEkQL+PZN+d+0i30Og0P6+K76Rwsav
m66EWIbXSXDqyw1in3ZRZufQvI7GoWLnf8TNveMSMn3+FZYJgjesQX4bbaowU7Fp
QJObrsL78ow5bt+Irm+gY0tNoJEZQqOwGLAdH421nb6KbVYl7ceCyE3/HwxfUL8S
j5gdXa1M10TLd4KTowL+POYIQvwp6daHhjJ8J8itBfANlVDDox6ejef/HxJQUkBl
wojlZCES+3fPTbUD5dlW5vWyqmW+np19FUFPkwFCUJnCSxHeF6RNKAjy/LyHZ9yv
MSy8IBPwxRHCPIBDvEpCkQGFJ33Leq2AIYD28+ZsWotY7CTfzGxYgAo/m+Qfvoqf
HyqsboClzqdLJM62qCzoaabst+WFIM9UtrZSug4vtZe5DM8jov9qov0tYJPVbjoK
lCEp8U2HFJoDh+PeyrVU6ywMto6E14cOi8pIkVEqWpQJEJnat0lSFXWfK01AlPtC
kkPN7wkDQ1jNNkhSRB20Kndwb91xViSeYf25EZS/etoqSxO/jm7v19p5cEJocPbf
Rv4EhaHgtPrxW43Usm8QYsOQRtYK5Ug5WFG2Jr09SnzELBv1B3Y=
=06LG
-----END PGP SIGNATURE-----

--Tv3+oRj6D9L8lW+H--
