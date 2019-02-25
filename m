Received: from eggs.gnu.org ([209.51.188.92]:41486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyTFY-00075E-VQ
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:17:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyTFY-0006os-4t
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:17:44 -0500
Date: Tue, 26 Feb 2019 10:49:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190225234956.GC6872@umbus.fritz.box>
References: <20190222131322.26079-1-clg@kaod.org>
	<20190222131322.26079-4-clg@kaod.org>
	<20190225234927.GB6872@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Content-Disposition: inline
In-Reply-To: <20190225234927.GB6872@umbus.fritz.box>
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


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2019 at 10:49:27AM +1100, David Gibson wrote:
> On Fri, Feb 22, 2019 at 02:13:12PM +0100, C=E9dric Le Goater wrote:
> > All is in place for KVM now. State synchronization and migration will
> > come next.
>=20
> As with the kernel side capability, this should be moved later in the
> series to avoid breaking bisections.

Apart from that,

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

>=20
> >=20
> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > ---
> >  hw/ppc/spapr_irq.c | 9 ---------
> >  1 file changed, 9 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > index 6e1c36dc62ca..1ad57582a403 100644
> > --- a/hw/ppc/spapr_irq.c
> > +++ b/hw/ppc/spapr_irq.c
> > @@ -263,19 +263,10 @@ sPAPRIrq spapr_irq_xics =3D {
> >  static void spapr_irq_init_xive(sPAPRMachineState *spapr, int nr_irqs,
> >                                  Error **errp)
> >  {
> > -    MachineState *machine =3D MACHINE(spapr);
> >      uint32_t nr_servers =3D spapr_max_server_number(spapr);
> >      DeviceState *dev;
> >      int i;
> > =20
> > -    /* KVM XIVE device not yet available */
> > -    if (kvm_enabled()) {
> > -        if (machine_kernel_irqchip_required(machine)) {
> > -            error_setg(errp, "kernel_irqchip requested. no KVM XIVE su=
pport");
> > -            return;
> > -        }
> > -    }
> > -
> >      dev =3D qdev_create(NULL, TYPE_SPAPR_XIVE);
> >      qdev_prop_set_uint32(dev, "nr-irqs", nr_irqs);
> >      /*
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx0fyQACgkQbDjKyiDZ
s5Jofg/9FR4BrY/hI3NjXeAvcg8IW7owW5s+CjeocyAjbFt26NwdZYgMXibWiqoB
WyOqlaKJDid4on+ZP7lrYavNWWZT9/amS5XpRZ2C+9uMzs3yFb2LAKHaurtaK1gW
yBndEWo0r4JChW8pRsoJmXztMQYfMITPAT8YYIKvOhK3AvDXN4x9w44Mv+fLgGMB
MwwsSKPjVMJn0RKnjiRhcb0AlGTkYDlLUyuyzO6wJ914eOvOqxo2FUrkGZntm5dV
eaxaSO3uryPJgQDUfKMYTmYXqDpmFKR4WzNUgPzP8EUj5gKnv/V449xbNxa4MYmK
ZrK36XL2VMdLxlRogkZt+OYH0V1Pgms08fPGfMWU2vrxDa7XJLhU1bkNNUfvWnJf
ahk45Tbi2TjlqjfhA/zgaY1cmg9jPX0fowMl2YYk4cvqOoBvViaUL/ouQCBuovgs
pUh+VCjWrNQfnjz7mUD6iGuU7iwOODzugtHODKAE4gQuCQTHybFQy2cEj3D2BlWz
ZwPLXhSmc5argCT5ZzeoZbN1U7Wjg+ldk+3ja6x2l7K8RJ7u2ZGwyHAY/tZLr67W
bm87qvMyTzmIdH69Jik5yxfYNWTHspqvMLJPAWTZZ8AxrzlYDYV+ZHZgxHln/L9J
sJ0bEkwrJkDAkPa7BhpVlEiAh4vyRA72sx0TnLxT/uoK3Zvt8Ak=
=O5/j
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--
