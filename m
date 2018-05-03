Received: from eggs.gnu.org ([2001:4830:134:3::10]:33955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE73p-0004su-Qy
	for qemu-devel@nongnu.org; Thu, 03 May 2018 01:45:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE73o-0001U8-M9
	for qemu-devel@nongnu.org; Thu, 03 May 2018 01:45:45 -0400
Date: Thu, 3 May 2018 15:45:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180503054534.GU13229@umbus.fritz.box>
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-8-clg@kaod.org>
	<20180426072501.GK8800@umbus.fritz.box>
	<312cdfe7-bc6b-3eed-588e-a71ce1385988@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MjBORTcaENZKFEO1"
Content-Disposition: inline
In-Reply-To: <312cdfe7-bc6b-3eed-588e-a71ce1385988@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 07/35] spapr/xive: introduce the XIVE
 Event Queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--MjBORTcaENZKFEO1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 11:48:06AM +0200, C=E9dric Le Goater wrote:
> On 04/26/2018 09:25 AM, David Gibson wrote:
> > On Thu, Apr 19, 2018 at 02:43:03PM +0200, C=E9dric Le Goater wrote:
> >> The Event Queue Descriptor (EQD) table is an internal table of the
> >> XIVE routing sub-engine. It specifies on which Event Queue the event
> >> data should be posted when an exception occurs (later on pulled by the
> >> OS) and which Virtual Processor to notify.
> >=20
> > Uhhh.. I thought the IVT said which queue and vp to notify, and the
> > EQD gave metadata for event queues.
>=20
> yes. the above poorly written. The Event Queue Descriptor contains the
> guest address of the event queue in which the data is written. I will=20
> rephrase.     =20
>=20
> The IVT contains IVEs which indeed define for an IRQ which EQ to notify=
=20
> and what data to push on the queue.=20
> =20
> >> The Event Queue is a much
> >> more complex structure but we start with a simple model for the sPAPR
> >> machine.
> >>
> >> There is one XiveEQ per priority and these are stored under the XIVE
> >> virtualization presenter (sPAPRXiveNVT). EQs are simply indexed with :
> >>
> >>        (server << 3) | (priority & 0x7)
> >>
> >> This is not in the XIVE architecture but as the EQ index is never
> >> exposed to the guest, in the hcalls nor in the device tree, we are
> >> free to use what fits best the current model.
>=20
> This EQ indexing is important to notice because it will also show up=20
> in KVM to build the IVE from the KVM irq state.

Ok, are you saying that while this combined EQ index will never appear
in guest <-> host interfaces, it might show up in qemu <-> KVM
interfaces?

> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > Is the EQD actually modifiable by a guest?  Or are the settings of the
> > EQs fixed by PAPR?
>=20
> The guest uses the H_INT_SET_QUEUE_CONFIG hcall to define the address
> of the event queue for a couple prio/server.

Ok, so the EQD can be modified by the guest.  In which case we need to
work out what object owns it, since it'll need to migrate it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MjBORTcaENZKFEO1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrqof4ACgkQbDjKyiDZ
s5ImgBAArE9+FqfKGy5HtklyAMJN/LDsbhn2Q0t1WDV37UvGcjpAj9ERivqT1A8x
HnT+yzRsLPSQvjHD6CfnmnVGDhl/mttx23tMEMb7cBEcot20ZgxQ19cK1HbTOE8n
UozJvjdXpneKrHtH7MQ2PRhSVqa2g+P7/eWRLJXj/eyPCMe3+QLpsznczNCrLvJS
zdxlWYOwFnf75tK/ComNTlWbxDCMHrtMBqGwMh0EyHtNgxTZdaVuwTUMI1DzyT3V
FmVM/juEZH2DGQv59DorUhYvcZLT7qsOFdiKU9ZzcsMKQtwijlQn226DQ/pg+b+o
t5A2Gh/IWYazlhkEhiZkvytwRddx7nEQnxRTuNA0uc/wkI/fRN2mtV5Do39eRL0U
jlFWG4sbND6IspRLsaDgvOHeQdkyzJlC8IcrrZ2JQIDBswYdSA4HzaFPKK1mM+2D
X0G62sOPkyRTb+W36mNSnbSezxqN74CMbEMsYwhieGUHGk7NAPmk0Jx3P//zBvyc
4PhpRQmPqnNpYWvmv6ZNMzoOXyU+ECiUsklKn3NbNp57in0hHXpaZlHe4A/25hkj
LACUzv43hpJ35NG25CCOXB/XI9tATA4bjSBmFJY0VT5Efzlowe4Px4bKDDNhLRSc
vSvXXgp/59tBVMRpZ3bXs4rLqK44NnU+oKiMJbRcfhhptvkkLog=
=cUfI
-----END PGP SIGNATURE-----

--MjBORTcaENZKFEO1--
