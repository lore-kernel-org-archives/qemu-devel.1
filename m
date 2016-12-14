Received: from eggs.gnu.org ([2001:4830:134:3::10]:55514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cGzcv-0002sp-F1
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 21:49:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cGzcr-00041L-9a
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 21:49:05 -0500
Date: Wed, 14 Dec 2016 13:48:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161214024850.GF32647@umbus>
References: <3353ecef-2308-13e3-025d-df41b2e89945@ozlabs.ru>
	<1479457042.1391.11.camel@redhat.com>
	<20161123050049.GD17795@umbus.fritz.box>
	<1480081581.4367.65.camel@redhat.com>
	<20161202041835.GF10089@umbus.fritz.box>
	<1481045447.6553.36.camel@redhat.com>
	<20161207041121.GB12489@umbus.fritz.box>
	<1481128923.3620.1.camel@redhat.com>
	<491c0ca6-c559-441b-7a14-3656bfc0abfc@redhat.com>
	<1481642137.17253.68.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Pql/uPZNXIm1JCle"
Content-Disposition: inline
In-Reply-To: <1481642137.17253.68.camel@kernel.crashing.org>
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH qemu] spapr_pci: Create
 PCI-express root bus by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Andrea Bolognani <abologna@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, libvir-list@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>, Marcel Apfelbaum <mapfelba@redhat.com>


--Pql/uPZNXIm1JCle
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2016 at 09:15:37AM -0600, Benjamin Herrenschmidt wrote:
> On Tue, 2016-12-13 at 14:25 +0200, Marcel Apfelbaum wrote:
> > > > Hrm, the suggestion of providing both a vanilla-PCI and PCI-E host
> > > > bridge came up before.=A0 I think one of us spotted a problem with =
that,
> > > > but I don't recall what it was now.=A0 I guess one is how libvirt w=
ould
> > > > map it's stupid-fake-domain-numbers to which root bus to use.
> >=20
> > This would be a weird configuration, I never heard of something like th=
at
> > on a bare metal machine, but I never worked on pseries, who knows...
>=20
> That's the thing though, it's *not* bare metal ;-)
>=20
> On bare metal, we use the "powernv" platform for which we haven't yet ups=
treamed
> the PCIE support, but there we have real PCIe root ports with all what's =
exepcted
> on them.
>=20
> They come on physically different PHB, one root complex per PHB, but they=
 are
> "proper" PCIe. Hotplug is a bit weird still because it has to go through =
some
> FW interactions as the HW doesn't use the PCIe standard slot control bits=
 (and
> our qemu model doesn't handle it yet) but otherwise it's standard.
>=20
> "pseries" on the other hand is a paravirtualized platform. It's the envir=
onment
> presented to guests by our propritary hypervisor (PowerVM, aka pHyp) and
> KVM/qemu. I think there's a public spec these days but to cut the story s=
hort,
> it doesn't expose PCIe "properly" for bad historical reasons.
>=20
> It tends to hide the parent, ie, the root port for slots connected direct=
ly to
> a PHB or the entire hierarchy from the root to (and including) the downst=
ream
> switch port for slots under as switch.
>=20
> So you end up with PCIe devices devoid of a proper "parent" which is a bit
> weird.
>=20
> Hotplug is implemented using specific firmware interfaces that are identi=
cal
> with pre-PCIe (ie PCI/PCI-X) systems. The FW has interface for supporting=
 3
> kinds of hotplug:
>=20
>    - Entire PHBs
>    - P2P Bridges
>    - Individual devices on an existing PHB or P2P bridge
>=20
> In practice these days mostly the first one is used for everything under =
pHyp,
> though I think we have a mix of 1 and 3 for KVM/qemu.

Alas, no, we only have 3 on KVM/qemu.  Well, possibly you could do (2)
by plugging a bridge device using (3) then a device onto the bridge.
Whole PHB hotplug has never been implemented for qemu/KVM.. but we
probably want to.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Pql/uPZNXIm1JCle
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYULMSAAoJEGw4ysog2bOSYZsP/3i4MdmvGWI4NScEN7qHwznn
5SqlMkeWYZSbSIpoyZb6PzBDRk4H1R+C+6KgiVvZ+40u6dW5k4oWQgaYk25gfFFZ
T1SVDI90268SEKwoIbdAkkfVlLovJdePRRV3IYMURIO/wm6jhjAuW1mEUagaW216
ztDue7RozQIfv4rJg+i2CoxCX8DBftBDBvwrTa1mj95Zp+8IdIf0bFGe8IOATcT5
JpOIFkw178U/5acNxqrTxazhrbfP4UKpV9jWuWCuSUZO6myKuXVnkrorvTtNEpMY
8c7po0si+Wi4+OIO/T3f45jlW7xD4QbpxCc28Jr9IxCway8fsH7Drunk3HoplkKd
T2LnvvteyVTvZFZxFX32Zhpb60xVwAVR5HSWd+wGmJd/PXhVXGuNNr1mfnDmLnw2
WK5YaH1v9TdZPdZLhT/tbTuuj7OJwzI6uLOeQHDHELby86utJ0xwB+U8haby6ilG
tcC0zjLBDpW+czClyzYMyLAS7XRtXVbOZ1ofIeTMv9/fCoSQjEUpdw9Ka0LkTLvq
BS//rpIbdhdXIQ4oF4HcE5OavsexWTjQJgquNQMyDn9WxQcC2w8t5G6RAVhs/Xi4
sEt8AraCQtCHTrZbBzy0sJvW5ncBGGBVNDdcHpen584644+2RK6UaqTVXuCmvuWC
Cmm+aCq1WPPYlN0I0Jsp
=ryMn
-----END PGP SIGNATURE-----

--Pql/uPZNXIm1JCle--
