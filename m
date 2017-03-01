Received: from eggs.gnu.org ([2001:4830:134:3::10]:47650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1citDg-0003Yd-2N
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 20:38:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1citDe-0001ZL-KN
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 20:38:20 -0500
Date: Wed, 1 Mar 2017 12:06:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170301010614.GF12571@umbus.fritz.box>
References: <20161222052212.49006-1-aik@ozlabs.ru>
	<20161222052212.49006-2-aik@ozlabs.ru>
	<20170102233423.GH12761@umbus.fritz.box>
	<36816bd7-9fc5-17a1-b5c2-1bfd0ece7988@ozlabs.ru>
	<396ef8ef-78b2-8ec9-e4d6-b45b05daa93b@redhat.com>
	<20170210004151.GQ27610@umbus.fritz.box>
	<65ea0f7e-7b4e-94df-491e-2ee15498a9bb@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FeAIMMcddNRN4P4/"
Content-Disposition: inline
In-Reply-To: <65ea0f7e-7b4e-94df-491e-2ee15498a9bb@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu 1/2] exec, kvm,
 target-ppc: Move getrampagesize() to common code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--FeAIMMcddNRN4P4/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2017 at 07:12:53PM +1100, Alexey Kardashevskiy wrote:
> On 10/02/17 11:41, David Gibson wrote:
> > On Thu, Feb 09, 2017 at 12:48:19PM +0100, Paolo Bonzini wrote:
> >>
> >>
> >> On 09/02/2017 06:43, Alexey Kardashevskiy wrote:
> >>> On 03/01/17 10:34, David Gibson wrote:
> >>>> On Thu, Dec 22, 2016 at 04:22:11PM +1100, Alexey Kardashevskiy wrote:
> >>>>> getrampagesize() returns the largest supported page size and mainly
> >>>>> used to know if huge pages are enabled.
> >>>>>
> >>>>> However is implemented in target-ppc/kvm.c and not available
> >>>>> in TCG or other architectures.
> >>>>>
> >>>>> This renames and moves gethugepagesize() to mmap-alloc.c where
> >>>>> fd-based analog of it is already implemented. This renames and moves
> >>>>> getrampagesize() to exec.c as it seems to be the common place for
> >>>>> helpers like this.
> >>>>>
> >>>>> This first user for it is going to be a spapr-pci-host-bridge which
> >>>>> needs to know the largest RAM page size so the guest could try
> >>>>> using bigger IOMMU pages to save memory.
> >>>>>
> >>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>>>
> >>>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >>>>
> >>>> Seems sensible to me, but I'm not comfortable merging this via my tr=
ee
> >>>> since it touches such core code.  Probably should go via Paolo.
> >>>
> >>> Paolo, ping?
> >>
> >> It's just code movement, go ahead.
> >=20
> > Ok, I've merged this in my tree.
>=20
>=20
> I cannot find it in any public tree, where did it go?

Bother, I thought I'd applied it, but I seem to have mislaid it.  Can
you resend it to me please.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FeAIMMcddNRN4P4/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYth6FAAoJEGw4ysog2bOSh3MQAOWMR3LkeF2jTqKBzKg26h9G
DfyZxTxU0j1xEH/WqVxiNi6QZ4H7qeVGlszpFjwy1hb6HmcjomtdMoBxwSxPY61l
SwiFsoHZZFbrSXN56Bzud2DWemOmcKoedqZZ/XfpzRbtWIVohc9xFl+mZHL/RgNz
9KOccnfAZKAMNxTxu29iR/Q/3hyMWrYGVFPOEfc6cbJyGm3RLQLTb/HsMP+Z8gLp
qWdE1LmRBd/w/RcTHef24mvu1JzeyNJElsNthfWM9043VRhmmIWQ7ZchMQEOa5uJ
Ymdi2Cic46t2dm7ZaKnjHcNe2JkBoeiZFs2Am8iqt4ZhuHDLIKqZPS/+/BA8uo7W
WGNr7c9VYILvsaBlZ8ivQ2S6saQkH4GjGTGCl/zFg2ElQXkebISRfhiQnAWZyD72
fOaexMWLRv8RbLretU5eraL0F4PsRfWt+h1XGCm2cDdYuACLQmK0q2ZWDUDJLKkw
Y63SgJwVhin5V6WwR684QyqdcFPHs2+TX+eFhBZNWNMGEJctBsdD9i8Vb22Q1Yf7
v9ZY8DXb75T4/OpJQftENPWo4yCzUQV/kbGe1Yu4Jc/caBvQgYbqE4FoNoo7Rfkb
up271K1e8Q+DQX+1TU9qSMawoiq7Mx609DPYZQy0A0GvyU30oYfoEDELtEubhqHX
BAxkICiqtp8v0arMuOVH
=a+Ff
-----END PGP SIGNATURE-----

--FeAIMMcddNRN4P4/--
