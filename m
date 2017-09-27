Received: from eggs.gnu.org ([2001:4830:134:3::10]:36363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx602-0003Xs-F9
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 02:39:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx601-0000Zk-JD
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 02:39:14 -0400
Date: Wed, 27 Sep 2017 16:21:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170927062143.GN12504@umbus>
References: <150633285374.14880.11614678065344980502.stgit@bahia.lan>
	<20170926025739.GF12504@umbus> <20170926091928.50e115ff@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nRwNdQxTdQ7rZk9A"
Content-Disposition: inline
In-Reply-To: <20170926091928.50e115ff@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] spapr: move registration of "host" CPU
 core type to machine code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Igor Mammedov <imammedo@redhat.com>


--nRwNdQxTdQ7rZk9A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2017 at 09:19:28AM +0200, Greg Kurz wrote:
> On Tue, 26 Sep 2017 12:57:39 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Mon, Sep 25, 2017 at 11:47:33AM +0200, Greg Kurz wrote:
> > > The CPU core abstraction belongs to the machine code. This also gets
> > > rid of some code duplication.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >=20
> > > hw/ppc/spapr_cpu_core.h is also included elsewhere in target/ppc/kvm.c
> > > but this is already handled by the following cleanup patch: =20
> >=20
> > I don't really see what the advantage of this is.  As others have
> > pointed out it leads to the host type being registered very late,
> > which could cause problems.
> >=20
>=20
> Well, the goal was to consolidate the code to register sPAPRCPUCore types=
 in
> the spapr code, instead of open-coding it in spapr_cpu_core.c and kvm.c..=
=2E=20
>=20
> But now I realize that delaying the registration even more is a bad idea.=
 And,
> the other way round, registering a static type earlier as asked by Igor w=
ould
> require all parent types to be already registered, which seems to be impo=
ssible
> to guarantee with the current code.
>=20
> Maybe we could at least have kvm_ppc_register_host_cpu_type() to call a
> function in spapr_cpu_core.c instead of duplicating the registration
> code ?

I think that sounds like a better idea.  It's still a little bodgy
with the abstraction boundaries, but I think that's unavoidable: this
fundamentally depends on both KVM's presence and use of the PAPR
machine type.  Whichever place we put it, you could argue it belongs
better in the other one.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nRwNdQxTdQ7rZk9A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnLQ3cACgkQbDjKyiDZ
s5Iv5A/8CRAC11GmwPEYMi3yzjeigmBHzTUVA5bPqhPs8dc63G35iPbaANNzp7Zv
BwMhRbVEY5eIm0LKiI9p6SkEYa3kVl2khkbsVbOIWTRRX+28rp0b2HjzvoQcUpqX
YQuFqBCLg9q3g0zflvavGnywZ1xSMZwwjCbn0QrVQFaXxFjsZ/DVUEQdy/RoMqEp
WNQuwUc21o9D4wLO9S60X/eCXzF+dJbIAQiHCzH0JFK8Qjk238vx0igJsgORjmrP
P4HOIAyRAcECsAkT00rWYlYBylkdHhvpft3UWppp1G0yvzZQr4bH+9Eyy1CsuobP
RJkp0SnZg766Tbh4higDhyXhuUJ1BZ5ff4+EQ9E3HqyH8kbgv7Kl3GOdldj9BM4R
MmSvQ909R3Xb+tHjOvUvxFJN/8RnDe5hATepV3x8hIleFSW1GI9LwhjmHg+tFCx7
qwvBTObZrjQ45TuCgHcA1VvhAICmDNfCJbpytDVFPoRoaixJGmbWztkYkTU96vEL
uB5lHJzmHbA8B2JknZayAE5yccYrL/HI1a76Iqgf1+TK2Kay7VWzvUqBVN3FODQO
JpRIneTO6272fFqgVEltMUlTRmzrpuyxdj1PaRUZsOA37t44qIakIOZ9ySRYMMPq
X206+1QZ3gW41ZLdrnn0ugiKtLQMeRT+ptR7OPZz/Wt7v6UAY4w=
=Wd1Q
-----END PGP SIGNATURE-----

--nRwNdQxTdQ7rZk9A--
