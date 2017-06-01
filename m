Received: from eggs.gnu.org ([2001:4830:134:3::10]:56211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGIMk-0005Kb-BY
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 01:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGIMg-0002Xi-5m
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 01:09:46 -0400
Date: Thu, 1 Jun 2017 14:21:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170601042135.GA13397@umbus.fritz.box>
References: <20170601015218.9299-1-david@gibson.dropbear.id.au>
	<20170601040646.GB27525@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <20170601040646.GB27525@in.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] spapr:DRC cleanups (part I)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: mdroth@linux.vnet.ibm.com, lvivier@redhat.com, nikunj@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sursingh@redhat.com


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2017 at 09:36:46AM +0530, Bharata B Rao wrote:
> On Thu, Jun 01, 2017 at 11:52:14AM +1000, David Gibson wrote:
> > The code managing DRCs[0] has quite a few things that are more
> > complicated than they need to be.  In particular the object
> > representing a DRC has a bunch of method pointers, despite the fact
> > that there are currently no subclasses, and even if there were the
> > method implementations would be unlikely to differ.
>=20
> So you are getting rid of a few methods. How about other methods ?
> Specially attach and detach which have incorporated all the logic needed
> to handle logical and physical DRs into their implementations ?
>=20
> Guess these will be follow in subequent parts ?

That's the plan.  In fact I already have patches underway, these are
just the ones that are polished enough to post so far.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZL5ZNAAoJEGw4ysog2bOS9vYP/RRVH7JFl9zHRiapvXUI66We
A2mDZxIAfuJIQeNSPb/2qQ2hYkLIcpa3BdUUVcGjSfSOmrvL35onQd/cWhwFnqrU
129dobb3VBAFkG3WF549WJLIKHKgPCvJF+cqPn6QhkWUsTZ5aUWNTSWfqnuruBXl
LkZ0Y5C2jsKH7c0Zfbo9fBRRg6PZ1o1KLrGOdWdgusKFyKLAj99bBZmpyhGx86U2
gWR+lN7hfZts0/TP5OB34l97ynEwDURwRQKOzWhSP3DNY1sVQErweR7j3jUXr1HE
yfVDzzfF7QXTD4AQEUQviM3teEZRFlZqcSFx7NqgGvLdfUKUJQSEkNoK1gxspveD
Mosi3MsxNsqwz42XGB39KNKHG+O1EC9fJ04vx/vAtYD62BD2pXJE2mc9kN0qJ/io
JIQWZhpsVeizt3xqBHhz7dVDAFwqa1HKicbWx9efi3gp73mgBkF5byOVuEm6sl06
gh3tj4tvTsIiXRcKH2/g8lSRdv9FDWQOsfAM0LCC9uaGFJP1Iz18lMWzzMHObChd
4DOpzk+WpasbfoRNAPheUUDtMel2VHV/1XSJe5pCtz+ZeWfh2fledEqhnOOVAdIb
uS781BOKjHYJh0tmDWLFgxdylXNZBvrVyFIx0maJvqH0Ovb64cTGnPO0A9UEoHJD
bxoHIEQRNV/25PnAhdGl
=l4VM
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
