Received: from eggs.gnu.org ([2001:4830:134:3::10]:56103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkJp8-0002yw-E6
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 20:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkJoE-0005hE-8V
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 20:47:10 -0400
Date: Wed, 23 Aug 2017 10:43:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170823004337.GG5379@umbus.fritz.box>
References: <150287457293.9760.17827532208744487789.stgit@aravinda>
	<20170817033554.ip36jmv6kwf7bpbp@tungsten.ozlabs.ibm.com>
	<7f67f71b-1661-09cb-1b6f-c8edeaa54144@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p7qwJlK53pWzbayA"
Content-Disposition: inline
In-Reply-To: <7f67f71b-1661-09cb-1b6f-c8edeaa54144@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/5] target-ppc/spapr: Add FWNMI support
 in QEMU for PowerKVM guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: Sam Bobroff <sam.bobroff@au1.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, mahesh@linux.vnet.ibm.com, benh@au1.ibm.com, paulus@samba.org


--p7qwJlK53pWzbayA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2017 at 02:40:17PM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Thursday 17 August 2017 09:05 AM, Sam Bobroff wrote:
> > On Wed, Aug 16, 2017 at 02:41:59PM +0530, Aravinda Prasad wrote:
> >> This series of patches adds support for FWNMI in PowerKVM guests.
> >>
> >> Memory error such as bit flips that cannot be corrected
> >> by hardware is passed on to the kernel for handling
> >> by raising machine check exception (an NMI). Upon such
> >> machine check exception, if the address in error belongs
> >> to guest then KVM causes a guest exit with KVM_EXIT_NMI
> >> exit reason.
> >>
> >> This patch series adds functionality to pass on such
> >> machine check exception to the guest kernel by suitably
> >> handling KVM_EXIT_NMI exit and building the error log.
> >>
> >> The KVM changes are now part of the upstream kernel
> >> (commit e20bbd3d). This series contain QEMU changes.
> >=20
> > [snip]
> >=20
> > Hi,
> >=20
> > I'm concerned that this implementation may introduce a problem with
> > kexec. If a VM registers an NMI handler, then kexecs to a new kernel
> > and an NMI is received before the new kernel has registered it's
> > handler, won't QEMU cause the guest to jump to the old, now invalid,
> > handler address? Is this worth worrying about?
>=20
> I think there is a small time window till the kexec kernel registers a
> new handler during which NMI can branch to the old invalid address.
>=20
> Two points of interest. First, I did not find any "ibm,nmi-unregister"
> call. Hence, once the VM registers for NMI it cannot unregister it.
> Second, if kexec is triggered due to VM crash, then the guest will not
> get the opportunity to unregister NMI even in case something similar to
> "ibm,nmi-unregister" is available.
>=20
> Not sure if this is worth handling as machine check NMIs are rare, and
> getting a machine check NMI during that small time window is very
> rare.

I tend to agree.  PAPR basically doesn't let us fix this, so crossing
our fingers and hoping not get an NMI in the window is about the best
we can do.

We could potentially define a way to unregister (e.g. passing 0,0 or
0x100,0x200 to nmi-register, maybe), but that can be an enhancement
for another day.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--p7qwJlK53pWzbayA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmcz7kACgkQbDjKyiDZ
s5LcfhAApTGakLWihBjFy1A+yIeoAUqHgvZfXlEfCqJgtdWRS8KGvGjlbWyOOvgi
bR3aiUFpfWKgf5J90RJ5mNRdZ1Bh3SzTXtPr5TLd5jqxDWJAjAP/fjTmLYddhhh6
T15iKjSuAjBAnlJ3+LfFCJWNYrpbl9CxtlwO22Uu8ZmO3/ANws0zF50VKzjp5BKD
XNiH+QwiV+vWQFv5tH4fSTDNuR8O2iHkythv+3rt1g/1RjbMdImjNqTw0IfZza4v
RcbxyICcdt56QXcd+WttvZunaIdz5stJ4imEmQH/dHQiVtjTrLodftBFPk2NXmoW
zJD/Km5A78wey2FMrnmi3OCm+DWc1WqrZ89EcpAllRum+vwNf14HWh2MjnJbMGJf
6AwadZ3YHRk3uLeUmcPP9RIJtFmA9CpaKvueqwZMT/PMawbMmZlkBHaiTBFDWMCR
mZEysvZi3eTNsStUkgn+h/gdOCmSCDgHiQtEONVJISNlHaKrt61+smtbsDMk6rP3
WRJps/7LEEUuv9oqECprx1Dafdnm3b60sDoPlGY2p1k0kV69e/bDx/ROBBr8zSnq
DYC5uzJZKLL9xHm/UBPxIpEB6E8QQLmFphtlR2WiZ7/JFvsgjSwBVOgRfq3Z5MW6
lv6O/HTLnM/eIK0jc17xTdiSvG6/DZZ8BhkWBwRxuIVyLre7oFE=
=heMZ
-----END PGP SIGNATURE-----

--p7qwJlK53pWzbayA--
