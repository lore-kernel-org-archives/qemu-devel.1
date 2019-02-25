Received: from eggs.gnu.org ([209.51.188.92]:41513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyTFa-00075H-67
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:17:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyTFZ-0006qM-Eb
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:17:46 -0500
Date: Tue, 26 Feb 2019 10:49:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190225234927.GB6872@umbus.fritz.box>
References: <20190222131322.26079-1-clg@kaod.org>
	<20190222131322.26079-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline
In-Reply-To: <20190222131322.26079-4-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 03/13] spapr/xive: activate KVM support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 02:13:12PM +0100, C=E9dric Le Goater wrote:
> All is in place for KVM now. State synchronization and migration will
> come next.

As with the kernel side capability, this should be moved later in the
series to avoid breaking bisections.

>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/spapr_irq.c | 9 ---------
>  1 file changed, 9 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 6e1c36dc62ca..1ad57582a403 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -263,19 +263,10 @@ sPAPRIrq spapr_irq_xics =3D {
>  static void spapr_irq_init_xive(sPAPRMachineState *spapr, int nr_irqs,
>                                  Error **errp)
>  {
> -    MachineState *machine =3D MACHINE(spapr);
>      uint32_t nr_servers =3D spapr_max_server_number(spapr);
>      DeviceState *dev;
>      int i;
> =20
> -    /* KVM XIVE device not yet available */
> -    if (kvm_enabled()) {
> -        if (machine_kernel_irqchip_required(machine)) {
> -            error_setg(errp, "kernel_irqchip requested. no KVM XIVE supp=
ort");
> -            return;
> -        }
> -    }
> -
>      dev =3D qdev_create(NULL, TYPE_SPAPR_XIVE);
>      qdev_prop_set_uint32(dev, "nr-irqs", nr_irqs);
>      /*

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx0fwQACgkQbDjKyiDZ
s5IQCA//Vq6aoaIUMrCyWDopg7FrjNbCJyl/6K3nYsMPjMRW3n7dcJeNd0V6lshM
CF8R+N18a6OZSQrsXJVMsjw17nIoff+0pz2ykdlPXB7oUMfSr8iY8jDeoENjdsCW
bX7zMAtFBEoaVZ0jxDfBtbNSRhqC+fSzDQZc6Y29g8zoNtfRuvRB1gtwJ+EW4Up5
xNqU8G/oeGD7roQj++bpGXJd9C+McfoKPKSkplL2qqx5GSP/RsZQhGvVnQDzhMjF
LhxK5LDqPSRSZXwFtOKxFNSdq3E4l/hQC07J2HDMJnPbxC7i+vokz9wTJwjJYGfA
9knfGVtZVGOis79/22oCG1DI0bqkzen/0PSo0ADvl+64PHsYKsVsugvdYKA7VlhA
ox0/ewWRs8+bzARQ168X/YtZDSoukZxXV84IPXi8Xs1G4RoLHRg/9kNMSB4kt91P
LGIDM356gUGo6YXdnXdMwHmP9/ca0tF5ySYeiG/lIcO60IzLEqrVZGgEZxAz/OFO
ypVQZRA8Q33NGAOBsuH0nmDbj6I8vpgz8CG5LuCpCBptb4+R3NL5J+Hp6lva8l71
l3og33IRhNw/I/f1tx/z7ujouBRE44b+OgcCliWQjbQYDejO1drB5BYar/gaoiDo
uhAN0UgZ/dY1QxSJmDRbmwX/YbjQ8Jkf7HecPXDPL9CHameu9uQ=
=r8kA
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
