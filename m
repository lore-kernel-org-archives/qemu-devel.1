Received: from eggs.gnu.org ([2001:4830:134:3::10]:48020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKnpp-0001LR-EO
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:06:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKnpl-0002IB-8s
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:06:41 -0500
Date: Fri, 1 Dec 2017 15:14:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171201041423.GF30161@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-18-clg@kaod.org>
	<20171130055542.GG3023@umbus.fritz.box>
	<2cee93ff-060a-aa04-852c-d3585dba0c7f@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rWhLK7VZz0iBluhq"
Content-Disposition: inline
In-Reply-To: <2cee93ff-060a-aa04-852c-d3585dba0c7f@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 17/25] spapr: add a sPAPRXive object to the
 machine
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


--rWhLK7VZz0iBluhq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2017 at 03:15:09PM +0000, C=E9dric Le Goater wrote:
> On 11/30/2017 05:55 AM, David Gibson wrote:
> > On Thu, Nov 23, 2017 at 02:29:47PM +0100, C=E9dric Le Goater wrote:
> >> The XIVE object is designed to be always available, so it is created
> >> unconditionally on newer machines.
> >=20
> > There doesn't actually seem to be anything dependent on machine
> > version here.
>=20
> No. I thought that was too early in the patchset. This is handled=20
> in the last patch with a 'xive_exploitation' bool which is set to=20
> false on older machines.=20
>=20
> But, nevertheless, the XIVE objects are always created even if not
> used. Something to discuss.

That'll definitely break backwards migration, since the destination
won't understand the (unused but still present) xive state it
receives.  So xives can only be created on new machine types.  I'm ok
(at least tentatively) with always creating them on the newer machine
types, regardless of whether the guest ends up exploiting it or not.

> >> Depending on the configuration and
> >> the guest capabilities, the CAS negotiation process will decide which
> >> interrupt model to use, legacy or XIVE.
> >>
> >> The XIVE model makes use of the full range of the IRQ number space
> >> because the IRQ numbers for the CPU IPIs are allocated in the range
> >> below XICS_IRQ_BASE, which is unused by XICS.
> >=20
> > Ok.  And I take it 4096 is enough space for the XIVE IPIs for the
> > forseeable future?
>=20
> The biggest real system I am aware of as 16 sockets, 192 cores, SMT8.=20
> That's 1536 cpus. pseries has a max_cpus of 1024.

Ok, so we can go to double the current system size, but not 4x.  Not
sure if that seems adequate or not.  Still it's a relatively minor
detail.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rWhLK7VZz0iBluhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlog1x8ACgkQbDjKyiDZ
s5ITYA/9HjQo7xQ97UiaNP99lFMS5a5bhwLXrngdaJpmQwCYsKwoF3zRZeEUG5kN
/+OGoSmKeVZSIn7lE2LnQGKpgJ7H6vk6hTTaxN9/2sHTr3F3upRUofnfP7bCuqIc
cYbvmsRCgVjprLdIHZprucJGTceY8gSHB/HoEUkJMlxlGN9+YdCD4ZCVRr1XjOZ1
QBACBh19cJwmmR40MHWlC9O+cb0Cz27uJDoYB2i/ZZr4OGgOJbK7iWSOok7blwjy
XiN2tMt33eJvCgG8ldanznPmOE/WxGbtVziHLg8nljmaRNESXbYgwnKIIJ73zsU8
eA6bgvPDmfNzmnspsPK7iQGsXq9Xj1musLQXiCWZbfGdIpoceDQuAQH+sW5tv0oh
7lfOuSRhve0ZBzbNhrun9mUOGm4W7kLkh4OkqLcpNpbudm9oD6nR5WibFDXXTLM3
H0JrgHKVrxPyiC6VM5mIFg9VBqARboOc/dskdMMPJ3YHMDuTydkxDUu6Gjc6MeYS
NI2cFkRGQuXsAL2pjgBnIpRfTAk42UP5AyZ3XvjfUclTFm8JXaTsygOq/DIJ5JNx
+F+nqHqjyFUtD60bCkWzsXShPQ0on2izQElSfEotFMYsMdWZjtrAwtiOUB3qhjzz
h1uH+vRPJB9nW+bqax19DhYHKCS25Q6oy5l2VxuVq+rQl5LiuYc=
=YzQs
-----END PGP SIGNATURE-----

--rWhLK7VZz0iBluhq--
