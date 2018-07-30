Received: from eggs.gnu.org ([2001:4830:134:3::10]:57796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fjzVj-0001UZ-85
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 00:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fjzVh-0007Lz-TY
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 00:10:19 -0400
Date: Mon, 30 Jul 2018 14:05:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180730040501.GB2708@umbus.fritz.box>
References: <20180726133723.17041-1-clg@kaod.org>
	<20180726133723.17041-3-clg@kaod.org>
	<20180727051601.GI3694@umbus.fritz.box>
	<cd9597a3-7f25-769d-b77d-0b0b04916501@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <cd9597a3-7f25-769d-b77d-0b0b04916501@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 2/3] spapr: introduce a IRQ controller
 backend to the machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 27, 2018 at 09:04:17AM +0200, C=E9dric Le Goater wrote:
> [ ... ]=20
>=20
> >> +static void spapr_irq_init_xics(sPAPRMachineState *spapr, Error **err=
p)
> >> +{
> >> +    MachineState *machine =3D MACHINE(spapr);
> >> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> >> +    int nr_irqs =3D smc->irq->nr_irqs;
> >> +    Error *local_err =3D NULL;
> >> +
> >> +    /* Initialize the MSI IRQ allocator. */
> >> +    if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> >> +        spapr_irq_msi_init(spapr, XICS_IRQ_BASE + nr_irqs - SPAPR_IRQ=
_MSI);
> >> +    }
> >=20
> > I think this belongs in common code, rather than xics specific.
>=20
> yes.
> =20
> >> +
> >> +    if (kvm_enabled()) {
> >> +        if (machine_kernel_irqchip_allowed(machine) &&
> >> +            !xics_kvm_init(spapr, &local_err)) {
> >> +            spapr->icp_type =3D TYPE_KVM_ICP;
> >> +            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_i=
rqs,
> >> +                                          &local_err);
> >> +        }
> >> +        if (machine_kernel_irqchip_required(machine) && !spapr->ics) {
> >> +            error_prepend(&local_err,
> >> +                          "kernel_irqchip requested but unavailable: =
");
> >> +            goto error;
> >> +        }
> >> +        error_free(local_err);
> >> +        local_err =3D NULL;
> >> +    }
> >> +
> >> +    if (!spapr->ics) {
> >=20
> > When could this get called with spapr->ics already initialized?
>=20
> if the code above succeeds when running with the KVM accel.=20
>=20
> What are thinking about ? introducing a xics-kvm backend ?

Duh, sorry, no I just wasnt reading the earlier code clearly enough.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltejm0ACgkQbDjKyiDZ
s5LmBBAArKo5Pspmjx6Uqbh93uNXVcJikgazDH/SyVrMYyvM/cgZ7KCK9ORlwkWQ
9BU3CGv/qvjnnFgkgBibVTRj0MTa+qTSwRXAHObBCF93SP5bE09i6eIqk5L4gzjj
HhaNtzegUN2vHfQwJuzFby4SO0qf99iK/eZSYipXwsrQk1A/s0toZ0B0B/jfMA/I
cFBufa3yR9MoBv1pWAUr5dbvdO6Z/E9wk4+YakpNKzJ2TyQm4FLypFB814mHEqQz
GkBdL3JfQuiRFUJJbZ/7NPcNrhanpOTUim8Zo21w7pKjRtxl84s4QgB3l98PRTeZ
wfXhQS9d3922ckQr/5xNhQq7MEaNHvfz70lrEe5iN3ZCIQ/4TumspXalhci/vMAI
MYQNPpoGVPFfdZZ3DmBdn6W8kKvgtKLHTuFUsjS/g/LK7w7mByjviX282q4pjEad
XMFZJVJmrKBKsoUQzLDiRruZNoF5Q1XR1pJy5TAJ24q68RpaDvXIWCN/d+bL1O9Z
3WM8R+jR9uzGNvT3k46gvPFY08i1FLCLPdgO5X385oSYYHJw46DDLKFqi6Ybq/xv
dptVuIDZKkgeqBh36aBRfIgfdJnHeqyC8GuH0P+E667I1A7HVaaL0gfuDHsPfuRq
HnqS3ld/xx5LYWhJL5S1PZbm9tXVobZVV+ZZlfv8KGTVqElXdnU=
=r01T
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
