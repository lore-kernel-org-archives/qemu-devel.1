Received: from eggs.gnu.org ([2001:4830:134:3::10]:55482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8HXo-0008Ek-IV
	for qemu-devel@nongnu.org; Tue, 09 May 2017 22:40:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8HXn-0008Lp-2h
	for qemu-devel@nongnu.org; Tue, 09 May 2017 22:40:04 -0400
Date: Wed, 10 May 2017 10:57:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170510005708.GQ25748@umbus.fritz.box>
References: <20170505101930.45837-1-aik@ozlabs.ru>
	<20170508055324.GF25748@umbus.fritz.box>
	<4997c37b-c0d4-e4f4-2b05-353f8223b0dc@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OxDG9cJJSSQMUzGF"
Content-Disposition: inline
In-Reply-To: <4997c37b-c0d4-e4f4-2b05-353f8223b0dc@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v6] memory/iommu: QOM'fy IOMMU
 MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>


--OxDG9cJJSSQMUzGF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2017 at 09:35:23PM +1000, Alexey Kardashevskiy wrote:
> On 08/05/17 15:53, David Gibson wrote:
> > On Fri, May 05, 2017 at 08:19:30PM +1000, Alexey Kardashevskiy wrote:
> >> This defines new QOM object - IOMMUMemoryRegion - with MemoryRegion
> >> as a parent.
> >>
> >> This moves IOMMU-related fields from MR to IOMMU MR. However to avoid
> >> dymanic QOM casting in fast path (address_space_translate, etc),
> >> this adds an @is_iommu boolean flag to MR and provides new helper to
> >> do simple cast to IOMMU MR - memory_region_get_iommu. The flag
> >> is set in the instance init callback. This defines
> >> memory_region_is_iommu as memory_region_get_iommu()!=3DNULL.
> >>
> >> This switches MemoryRegion to IOMMUMemoryRegion in most places except
> >> the ones where MemoryRegion may be an alias.
> >>
> >> This defines memory_region_init_iommu_type() to allow creating
> >> IOMMUMemoryRegion subclasses. In order to support custom QOM type,
> >> this splits memory_region_init() to object_initialize() +
> >> memory_region_do_init.
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >=20
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >=20
> > With the caveat that this will conflict with Peter Xu's outstanding
> > patches which adjust the semantics of the IOMMU translate function.
>=20
> Sigh... So I'll wait till that reaches upstream and repost.

No, that's fine - your patches are much simpler and closer to ready
than Peter's, so I think you go first.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OxDG9cJJSSQMUzGF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZEmViAAoJEGw4ysog2bOSSzQQAJdc6l9WlNQH3z+L/p1sNMJg
PlRmS1NiM0c+XSeOr0+XuecASMXefL//EG2hK6Z3XsKFFfx0N2vAmp4lc+Vws7m6
Wnk4OJ72lAcpYDc18jbWykEosLAh1ePMzOB6mwtBmAh/mcJ6ob9hLqFVbDrpZeYg
HGX8yUNtmQC9plR1R7varlGByU/q2TkNp8h5IpusZ5mc6PZMMVKzVpneFODV1HNp
MWJEKurypXRK5aEUXYgGSwGtr6bGO+ppd0N3aG8N2TcH0+8YsvmckPVTPVaEIleP
QIGksbUcKuRM/3CWBR6ANXQ8FBAtffRQQ/WNVfP1+BMxXoGVz0ZtvLAgqSBxyfuE
7WNcy1oHYQngkZKkwSd3LS7rHvHUAx5HVF4W3k/Tucns2Rayf22jc3/O8B5Jlbkl
xG3NdluxWsX8Cao93TWL1djDM4zNoIZFTPmLAYb/g1VWZnsTMo3DQTyPMnxAvOi8
LcRnbNUDhVF61iDzhCCRntjmq1OsUL8bWLwCzbGdatOkHr8f5Os64V2OJVZqcpmx
rBAM2Oz/NznmwumtjZp5aHM2cS9yuuo/PqHp467++1vnrvFci1eDxqXrp7wZrwy+
o6hGz1XfRDu9gE8GX4Vzf5I/Wx9HXSkCN/AdPNCR8K823DZr/+banZxpjDOuEFnv
khwlyk6n5P81toewL7gG
=2Pij
-----END PGP SIGNATURE-----

--OxDG9cJJSSQMUzGF--
