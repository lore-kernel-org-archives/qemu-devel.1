Received: from eggs.gnu.org ([2001:4830:134:3::10]:39910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dImlR-0007Xh-Db
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 22:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dImlQ-0004Ws-H8
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 22:01:33 -0400
Date: Thu, 8 Jun 2017 11:44:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170608014445.GR13397@umbus.fritz.box>
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
	<149685582071.12025.6876143197982490443.stgit@bahia.lan>
	<a5acff8a-62dc-6d76-4d54-2a952423ab77@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9/lmB/GmAksD4Nrg"
Content-Disposition: inline
In-Reply-To: <a5acff8a-62dc-6d76-4d54-2a952423ab77@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] xics: add reset() handler to
 ICPStateClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--9/lmB/GmAksD4Nrg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2017 at 07:47:04PM +0200, C=E9dric Le Goater wrote:
1;4602;0c> On 06/07/2017 07:17 PM, Greg Kurz wrote:
> > Taking into account that qemu_set_irq() returns immediatly if its first
> > argument is NULL, icp_kvm_reset() largely duplicates icp_reset().
> >=20
> > This patch introduces a reset() handler, so that the common logic can
> > be implemented in icp_reset() only.
> >=20
> > While there we can also drop icp_kvm_realize() and icp_kvm_unrealize().=
 This
> > causes icp-kvm to be realized in icp_realize(), which sets icp->xics, b=
ut
> > it has no impact.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
>=20
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> > ---
> >  hw/intc/xics.c        |    5 +++++
> >  hw/intc/xics_kvm.c    |   27 ++-------------------------
> >  include/hw/ppc/xics.h |    1 +
> >  3 files changed, 8 insertions(+), 25 deletions(-)
>=20
> another good cleanup !

I concur.  Applied to ppc-for-2.10.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9/lmB/GmAksD4Nrg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOKwNAAoJEGw4ysog2bOSFGQQAM8EZaV2Uj+xJVaCX3EZ0dIp
rnN/l3bCQ1fiv6+f1g+iSSC7Car2LER983I6eKWcxn5lUo/6oYKM1gGFhF6hJ+rJ
v0Iwt2FYi3jnpfvfjkOtbgsa9lmN1WYtvnpN6eH6Itm6nO4xjxkWY5ZdxibDp/ov
Q+Pl1jiwFsceE0GHYNd+muAhoR60zJtkRQSv+jr+PLfHbz42NSo4iTIAELHhR8gT
qOLbSv6F7m+T07sr/VTd4wPWHPYJ80yA8Mo8cuBGvB3Qmuk1FFSHi6c80p+cYQ86
PlRhgL2ERTUE95j/dp6Yp38bxNi0Wr9XI5UfbZXU/ISJpoiyccz4BLZ2HbtfWDr9
ifxPPzuuJg5SwiJHsqOqw/JqUkmAIYoE7+DYNUjDlLGkcqfypO4pUwGBkkjvnmxG
HQazpihmj04GwU4B0J4/PQ8yoUmBtRSdgBfhsPAa5P/IL/svJCjGxl+2JXlR29EP
sllPrYHsvB6mZbc8wDFAR7Se6C5qOSLtgFCzNXvdmyvd4HaFex521aqY8fIhF36F
3g3ymUxL5N3iH0OMp/md7rsD+9eIAhrhfOBJzRgD6cc3STCvIlaRQ+THw4RZgY2+
leA3dYIzYt0FL0KL1FyVkiLctgekAkPJFCBCZUPX1enWDSMDZl3bpGVhQm8icUfB
RYUBRIEDVVgSxYI9BV+5
=1li7
-----END PGP SIGNATURE-----

--9/lmB/GmAksD4Nrg--
