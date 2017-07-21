Received: from eggs.gnu.org ([2001:4830:134:3::10]:43533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dYShj-0002oI-8D
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 03:50:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dYShg-0001mX-3F
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 03:50:31 -0400
Date: Fri, 21 Jul 2017 17:50:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170721075015.GE3717@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-5-git-send-email-clg@kaod.org>
	<20170719030849.GQ3140@umbus.fritz.box>
	<1500436938.3350.11.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VdOwlNaOFKGAtAAV"
Content-Disposition: inline
In-Reply-To: <1500436938.3350.11.camel@kernel.crashing.org>
Subject: Re: [Qemu-devel] [RFC PATCH 04/26] ppc/xive: introduce a skeleton
 for the XIVE interrupt controller model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--VdOwlNaOFKGAtAAV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2017 at 02:02:18PM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2017-07-19 at 13:08 +1000, David Gibson wrote:
> >=20
> > I'm somewhat uncomfortable with an irq allocater here in the intc
> > code.  As a rule, irq allocation is the responsibility of the machine,
> > not any sub-component.  Furthermore, it should allocate in a way which
> > is repeatable, since they need to stay stable across reboots and
> > migrations.
> >=20
> > And, yes, we have an allocator of sorts in XICS - it has caused a
> > number of problems in the past.
>=20
> So....
>=20
> For a bare metal model (which we don't have yet) of XIVE, the IRQ
> numbering is entirely an artifact of how the HW is configured. There
> should thus be no interrupt numbers visible to qemu.

Uh.. I don't entirely follow.  Do you mean that during boot the guest
programs the irq numbers into the various components?

In that case this allocator stuff definitely doesn't belong on the
xive code.

> For a PAPR model things are a bit different, but if we want to
> maximize code re-use between the two, we probably need to make sure
> the interrupts "allocated" by the machine for XIVE can be represented
> by the HW model.
>=20
> That means:
>=20
>  - Each chip has a range (high bits are the block ID, which maps to a
> chip, low bits, around 512K to 1M interrupts is the per-chip space).
>=20
>  - Interrupts 0...N of that range (N depends on how much backing
> memory and MMIO space is provisioned for each chip) are "generic IPIs"
> which are somewhat generic interrupt source that can be triggered with
> an MMIO store and routed to any target. Those are used in PAPR for
> things like IPIs and some type of accelerator interrupts.
>=20
>  - Portions of that range (which may or may not overlap the 0...N
> above, if they do they "shadow" the generic interrupts) can be
> configured to be the HW sources from the various PCIe bridges and
> the PSI controller.

Err.. I'm confused how this not sure this relates to spapr.  There are
no chips or PSI there, and the PCI bridges aren't really the same
thing.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VdOwlNaOFKGAtAAV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAllxsjQACgkQbDjKyiDZ
s5LvHA//TuhJWZJnvpy9SeIwo8965SrMY+/tLjLSNRZ2ZtaQ419Gnei4lcqKfAmi
0XqZ/e8KPOSuCO5yyPccwambjbyGhn+eAv4Iehu1szW1o7ASmj0xt2ZiEiYkuDif
aYsHwPwbnmvCjOmzj0wfNw16Ue24HWz1JzQ2txRZcgURSL25LGpCldaayVGLQBDb
98Re1Sia/KMX1RnOjiuftk19EtPVcLM4OvSfsvSmGZmiKvAH++/iM/tIMYktqQdX
2zvLxlmgNElWsihdK+7ZKAmJeW8kH/YoB05N37OdcgC9KzGNiM3WBg6j8uO+gxkK
t6PLTthhJXLCjFQ7gmP+w5wcfQMiyjai2+lDLJ+CHueCH1uV58ZYgZarQ84alabN
6j91hUBIDfpQUpLrbv4ZifvwRVq8h9D5ic9Phhaukrb4MZplAVuKl7A5czBd4mrE
KoiuOWp4Wy9tK0S2WoEMX63wS/z3jpebwG5ENi4wilAZgPsJifscI1YVfI7fLuWZ
lcFYBjV+XYnpRCFXyq+e8RfIR8B6TsXfjuDF8nLMmqh+N1p7+oFk1n1u8cFT5PX+
7Wun1Xv22qOQjgljEZ2R5fbrxfsNzaF15tkfl9LehMgYuoTYuYxj4MimMXWT48DQ
RXVi4aXGWg+DnC4Ocj5OJUsAOxaaHOpamZas2TwaktpGiIbVc64=
=HjAC
-----END PGP SIGNATURE-----

--VdOwlNaOFKGAtAAV--
