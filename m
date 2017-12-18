Received: from eggs.gnu.org ([2001:4830:134:3::10]:49813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eQma4-0007KK-Ks
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 22:59:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eQma0-0006Io-UZ
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 22:59:08 -0500
Date: Mon, 18 Dec 2017 14:58:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171218035857.GQ7753@umbus.fritz.box>
References: <20171212052131.24649-1-aik@ozlabs.ru>
	<20171215040731.GD7753@umbus.fritz.box>
	<20171215090428.214cc474@w520.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2D20dG0OqTzqkNh7"
Content-Disposition: inline
In-Reply-To: <20171215090428.214cc474@w520.home>
Subject: Re: [Qemu-devel] [PATCH qemu] RFC: vfio-pci: Allow mmap of MSIX BAR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--2D20dG0OqTzqkNh7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 09:04:28AM -0700, Alex Williamson wrote:
> On Fri, 15 Dec 2017 15:07:31 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, Dec 12, 2017 at 04:21:31PM +1100, Alexey Kardashevskiy wrote:
> > > This makes use of a new VFIO_REGION_INFO_CAP_MSIX_MAPPABLE capability
> > > which tells that a region with MSIX data can be mapped entirely, i.e.
> > > the VFIO PCI driver won't prevent MSIX vectors area from being mapped.
> > >=20
> > > This adds a "msix-no-mmap" property to the vfio-pci device, it is "tr=
ue"
> > > by default and "false" for pseries-2.12+ machines.
> > >=20
> > > This requites kernel's "vfio-pci: Allow mapping MSIX BAR"
> > > https://www.spinics.net/lists/kvm/msg160282.html
> > >=20
> > > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > > ---
> > >=20
> > > This is an RFC as it requires kernel headers update which is not ther=
e yet.
> > >=20
> > > I'd like to make it "msix-mmap" (without "no") but could not find a w=
ay
> > > of enabling a device property for machine versions newer than some va=
lue.
> > >=20
> > > I changed 2.11 machine just for the demonstration purpose. =20
> >=20
> > As Alex says, the mmap()ability of the MSI-X BAR isn't really the
> > point.  The point is whether we need to intercept guest MMIOs to the
> > MSI-X region.  Still, the logic's basically right, just rename your
> > property to, say, "intercept_msix_mmio".  It would be true by default,
> > set to false by the pseries machine type.
> >=20
> > I don't think you actually need to make it vary depending on the
> > version of the pseries machine type: whether the BAR is mmap()ed or
> > qemu emulated shouldn't be a guest visible change.  No PAPR guest
> > should have been directly poking the MSI-X region (ever), so we
> > shouldn't need to intercept the region even for old versions.
>=20
> I have to ask, is the vfio-pci driver really the right point in the VM
> to be understanding whether the platform requires MSI-X MMIO
> emulation?  vfio-pci is only unique here in that enabling that
> emulation harms performance, but AIUI it's unused on any device and
> there may eventually be other devices affected in the same way as
> vfio-pci.  So should there be some post-realize platform code that
> disables MSI-X MemoryRegions or should the MSI-X code call out to some
> platform hook to determine whether to enable emulation?  Seems like a
> case where the impact might be unique to vfio, but the root of the
> problem is not.  Thanks,

That's a good point.  If we can reasonably do it at the level of a
generic PCI device, that would be preferable.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2D20dG0OqTzqkNh7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo3PQEACgkQbDjKyiDZ
s5ImMhAAw9lANgbIgVQ3lm0p0v5l744Vdh3lt5z8x8HXMpIrSRDEB2eIJebxhw1v
rz0DXMsssXzQNvF8XSBDKJmg1WdeiVlwTuJCM8aaz7e0kvEURnOOsPIbpJPPuttU
VOZEtsGzWrSM6dyaZ+KtEtahc6dUtfzvEFQ40RwSD837kqZA9idsAZMuu95uXEmK
55vAIjj56JFJHhVgAiXCtq5azTLHI7SEKXfid3xxu9H2LpEXj6gP99GrZE1+uRTw
3JXuRWhXtiwHE90gfLqU6o7wU+S0aFXt/2nP+tstKBswvtn+CUhPtrf71+MrKjOM
Hm5yhAmJKMhayeottnKvTBOIHtyaXrHR/8s3l0BOwVhaw2D7E0D9vsD+QZMSTE1N
uPYwBd2/lPpT537iP33FDyzTIH5opBI7PcYvlwZL5+Zsi30kaVH6/fKGeyjbJoan
a0vXcq1Lz20COEuPDtHQWZtE/WABxlHC5q80zYjO5lcC7YtBjvP4Mzkd7ymzWjHt
Euy+reTsa9jfN28mCX+D14UWEjXmYDnG0vl/eETbOznjPkpRMiezbGtdBEi9gT9u
Znj9WoG73ovVdDNcAtFgrg4LYM2k13uuDFg5bqLVAYR+0fxpdfwKH4o6kmtUr81u
UfOfIro40wA81hmcHNTw609fn5SZ8ZQNL13cG9wn1Qs6LJ0MY4s=
=CD6k
-----END PGP SIGNATURE-----

--2D20dG0OqTzqkNh7--
