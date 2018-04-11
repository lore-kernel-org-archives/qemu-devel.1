Received: from eggs.gnu.org ([2001:4830:134:3::10]:52676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f67e8-0005lu-FS
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 00:46:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f67e4-0006Qq-9n
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 00:46:12 -0400
Date: Wed, 11 Apr 2018 14:21:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180411042143.GB2124@umbus.fritz.box>
References: <20180409062538.1095-1-bharata@linux.vnet.ibm.com>
	<20180410030245.GF3361@umbus.fritz.box>
	<20180410041521.GA14855@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
In-Reply-To: <20180410041521.GA14855@in.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2] spapr: Support ibm,
 dynamic-memory-v2 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>, y@umbus.fritz.box
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, nfont@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, imammedo@redhat.com


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 10, 2018 at 09:45:21AM +0530, Bharata B Rao wrote:
> On Tue, Apr 10, 2018 at 01:02:45PM +1000, David Gibson wrote:
> > On Mon, Apr 09, 2018 at 11:55:38AM +0530, Bharata B Rao wrote:
> > > The new property ibm,dynamic-memory-v2 allows memory to be represented
> > > in a more compact manner in device tree.
> >=20
> > I still need to look at this in more detail, but to start with:
> > what's the rationale for this new format?
> >=20
> > It's more compact, but why do we care?  The embedded people always
> > whinge about the size of the deivce tree, but I didn't think that was
> > really a concern with PAPR.
>=20
> Here's a real example of how this has affected us earlier:
>=20
> SLOF's CAS FDT buffer size was initially 32K, was changed to 64k to
> support 1TB guest memory and again changed to 2MB to support 16TB guest
> memory.

Ah.. I hadn't thought of the CAS buffer, that's a legitimate concern.

> With ibm,dynamic-memory-v2 we are less likely to hit such scenarios.
>=20
> Also, theoretically it should be more efficient in the guest kernel
> to handle LMB-sets than individual LMBs.
>=20
> We aren't there yet, but I believe grouping of LMBs should eventually
> help us do memory hotplug at set (or DIMM) granularity than at individual
> LMB granularity (Again theoretical possibility)

Ok, sounds like it might be useful.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrNjVcACgkQbDjKyiDZ
s5KrPw//Y0rB54al42Zxd+MLlY9wB0Fms6WrUVZZ4qP88dq5R7lTyXmxYFvvsmfx
PqXJy+AZ3i+YCpzwG45sjkFzNb5236Uw9bktzKsWoN6dApDIh9S1r2xJR3td1F7X
XnIkPt2laXAq30LwaU1NzWyeM8ax+3mB0e5YWLlvO7DVuwVpT3kpNK9Duuda0h+j
k+lvmslxNNNVQWQW4liRPuqlcfiUoMw2EK/Q5jAL+VtOtMSZdtTJwe07EYJpp86w
txuJsNp5YLdDUsIhmNy9Kgw+wqOp0xEBhcXbmlrM5fz7AZ4D/Zbj13gzF/7btZPD
FTsuqfNnoVmMO1ufm13qNxEwGUpMwbyEp9kZVAAJpeZ/pGyuo7rgxJlcB+gx/ia3
jtdHBtphjCa8p/RvXk/zAeu6B1FiH48bzJvkbZuqjNtxAC9BoQSc+DrP3IlM5Jwq
QLPNl9nH1sjlXq3GmXFe7YSmxpNrVWJgLi8W3SxepuJ2l7dbMRV9WYjiKE96VsnE
fW7fZU+Za0qBHUVBneoLul9wMUR45gqFSfyPfx/rrmWgcOZArA4fIBVhTPyLiCiq
qyzxCGFzMz1CypMNfjCO0aTuuNZqGZWnS777TfhpyWahSseQqGdTvqA4BYNNYudD
NchnrOVVoh9uG7zGzkD6pVwyrI+A54YI8OfVWMg/AgUXryef0kc=
=Qd8I
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
