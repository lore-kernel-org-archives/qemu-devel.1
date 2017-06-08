Received: from eggs.gnu.org ([2001:4830:134:3::10]:39915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dImlR-0007Xj-GS
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 22:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dImlQ-0004Wi-GN
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 22:01:33 -0400
Date: Thu, 8 Jun 2017 11:53:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170608015329.GS13397@umbus.fritz.box>
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
	<149685582923.12025.13700165807436904935.stgit@bahia.lan>
	<c632e0a3-c6bb-2637-40c3-5098937476a5@kaod.org>
	<20170607225507.5d2c6c33@bahia.ttt.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n1q7a47AT2c4WQJe"
Content-Disposition: inline
In-Reply-To: <20170607225507.5d2c6c33@bahia.ttt.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/5] xics: setup cpu at realize time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--n1q7a47AT2c4WQJe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2017 at 10:55:07PM +0200, Greg Kurz wrote:
> On Wed, 7 Jun 2017 20:11:38 +0200
> C=E9dric Le Goater <clg@kaod.org> wrote:
>=20
> > On 06/07/2017 07:17 PM, Greg Kurz wrote:
> > > Until recently, spapr used to allocate ICPState objects for the lifet=
ime
> > > of the machine. They would only be associated to vCPUs in xics_cpu_se=
tup()
> > > when plugging a CPU core.
> > >=20
> > > Now that ICPState objects have the same lifecycle as vCPUs, it is
> > > possible to associate them during realization.
> > >=20
> > > This patch hence open-codes xics_cpu_setup() in icp_realize(). The vC=
PU
> > > is passed as a property. Note that vCPU now needs to be realized first
> > > for the IRQs to be allocated. It also needs to resetted before ICPSta=
te
> > > realization in order to synchronize with KVM.
> > >=20
> > > Since ICPState objects are freed when unrealized, xics_cpu_destroy() =
isn't
> > > needed anymore and can be safely dropped. =20
> >=20
> > I like the idea but I think the assignment of ->cs attribute should be=
=20
> > moved under icp_kvm_cpu_setup(), as it is only used under xics_kvm by=
=20
> > the kvm_vcpu_ioctl() calls.=20
> >=20
>=20
> Well, cs->cpu_index is also used for traces and to implement the 'info pi=
c'
> monitor command.

Right.  I think it makes sense for the ICP to have a handle on it's
associated CPU, even if we don't actually use it in all cases right
now.  So I have no problem with the property being in all ICPs; I
think that will be cleaner than special casing xics_kvm.  Especially
if we have to un-special-case it sometime in future because we need
to access the CPU object for some reason we haven't thought of yet.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--n1q7a47AT2c4WQJe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOK4ZAAoJEGw4ysog2bOSjDUQALacjSCmb40qMZPOZ590vyGI
fZZXYbmef7KU+aexcFHW//yGG5GhQjti6RH/spOAkV6AiXjoAr4gabQTYWIEq83o
oPa7lZraSjvjYzdrLs/0lsDM3OG6pCCiap0ozPb/Wnjlo1RjVPX4PSA3k6bARuvp
qSxEqr7cldcZ++kqw06TVXZD/pwVMnubhLFScWQg/zKNYBVAPzFcYbYXOx1z5J2L
D9wpUljeb1goUGorx36u/jEp8KFNdh/Swv4feoiV7OAc2pD+tXN5cObNQCDMQ+i3
o8k/Eghafc0d//Be16pvz7zi0/99WGnEu3heKIjgzPiBsh1kh/hhPX2wcviTz4B/
CrT5tW4h2QQx1j67buf+dOCCaalkhvZAiHL2TDjQaIiH96Mte85q1HMy/ix+jaEl
qMfMPfaViZTD4D1vv84ZRfPun1/FBRAzfgohjW1bRbPY6W34MbhSye8Zc0MgOOQF
DFh7iy2pLdzkx6hxSG0dBLybZorkTlW1//Npg/rLRyVQoXO4+VzFDmaAF7poWL7L
9ADV5T7Uoj3bJe60nauNspbsFWLGDJKoaxndw+0PvdetyY5k6Xd+/RCx+giGD0nL
rdEFlFqB1NW4R42lPiM598i4/4T8oEDcNP5M4724OBp25dCtm8NOen3iPQfUKkYN
sC/vcSXGFaPdzTLqp38N
=H+ld
-----END PGP SIGNATURE-----

--n1q7a47AT2c4WQJe--
