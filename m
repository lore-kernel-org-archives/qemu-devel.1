Received: from eggs.gnu.org ([2001:4830:134:3::10]:60216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gaBDW-0000kp-4E
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 22:11:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gaBDU-0003HF-Rq
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 22:11:14 -0500
Date: Fri, 21 Dec 2018 12:50:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181221015048.GA20009@umbus.fritz.box>
References: <20181211223823.13770-1-clg@kaod.org>
	<20181211223823.13770-12-clg@kaod.org>
	<20181217060717.GI5597@umbus.fritz.box>
	<dcfacfb6-8fec-04b0-4f2a-c20097511559@kaod.org>
	<602c3aab-5eca-7011-966e-3a84df5ce4b3@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <602c3aab-5eca-7011-966e-3a84df5ce4b3@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v8 11/12] spapr: introduce a new sPAPR IRQ
 backend supporting XIVE and XICS
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


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 19, 2018 at 08:15:36PM +0100, C=E9dric Le Goater wrote:
> [ ... ]
>=20
> >>> +static qemu_irq spapr_qirq_dual(sPAPRMachineState *spapr, int irq)
> >>> +{
> >>> +    return spapr_irq_current(spapr)->qirq(spapr, irq);
> >>> +}
> >>
> >> This still makes me really nervous - I'd really prefer to have qirqs
> >> independent of the backend, rather than relying on *every* irq using
> >> device never looking up qirqs in advance.
> >=20
> > I will take a look. This is a large rework I won't have time to address=
=20
> > this year. I have removed the dual machine from v9.
> >=20
> > You would move the qirq array at the machine level ? =20
>=20
> I took a look today and did a few changes :=20
>=20
>  - move the qirq array at the machine level
>  - introduced a 'set_irq' method to sPAPR IRQ
>  - adapted the 'qirq' method of sPAPR IRQ. We still need to perform some
>    checks and to handle the IRQ number offset.
>=20
> It falls well in place, a part for the ICS source of the PnvPSI model=20
> which does not have any qirq anymore. For PSI, I am thinking of moving=20
> the qirq array under PnvPSI model, like I did for the machine.=20
>=20
> Would that be ok ?

That sounds reasonable.  I'd been thinking of having a qirq array at
the machine level which dispatched to other qirq arrays at the ICS or
XiveSource levels, but if you don't need that, that's ok too.
>=20
> I think there are a couple more possible cleanups on the different ICS=20
> models to do if these changes are acceptable.=20
>=20
> C.=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwcRvYACgkQbDjKyiDZ
s5KuFBAA3NVPyGSV3OLDyDEZNXYBzCt/kbwGGzaAV2gCUHu1DPUOw9R3mwUYEveF
NkYPRsCyIfEIhQfJCG+kRtpvfvmNm4826VM0ShixQnwNlHQ+5xvxEnvjRw+hBmZg
bg/3bdK7IolyBfXflja1PWy10kVdCCn+8f6xR/BTaxCZ8Gd1QwuD/fAmBZjB5Nkx
gHgzbNPjsSx+3DJOvB9ETJxOT+vYC1x4sseR/Et94s4ZbSpeO/LWi+mXoO+9K0qb
+gdk+MTf5QpOkpBhN7GnNpQ1ISUQKuPTQmx4cTSEjPMdAW1aYHw4fsg2igA4abbl
Zf2mQ4EqFm7n+laLrOEPLAyxXlCd1oGgoMEPv7Y0ur9XX+3M6cccjc2er4XjuzrM
qGTohaPYHYkLqTuUwUuADUbZRndZptWl9f2Zqj2xA5XXR7ChXgUpUIKnC9sbDNOB
NCZIfJ2hxUcza1GU8krRsCoAURkIynWCoNfJ37qnG4KeU00ayO5pSAiKe5iW/I+t
B/IzWTf9nODcMoPlf5g9EQlLzfnmMv3KVs7ejZxIq+PRv1h6wx5oR3cxqbwKY8F6
/tyDT2ymkbYWEWoX8cObskDlACeBmCWODEOwSsEDmtsmTpFfBVk9SIFHLcVXKxpY
iVtpwlsOD5wAiSbyKn0tOjdzpRt+3TLO571Ew+FkFaS9EViTri8=
=LcLM
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
