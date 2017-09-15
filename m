Received: from eggs.gnu.org ([2001:4830:134:3::10]:59002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dslmY-0001SE-3E
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dslmU-0004RY-Lx
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:15:26 -0400
Date: Fri, 15 Sep 2017 16:35:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170915063540.GF5250@umbus.fritz.box>
References: <150541711102.1616.2690784964841960181.stgit@bahia.lan>
	<150541714343.1616.11893912014879112098.stgit@bahia.lan>
	<19f09a67-5b16-6bdf-5c72-c2df84537ea7@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O98KdSgI27dgYlM5"
Content-Disposition: inline
In-Reply-To: <19f09a67-5b16-6bdf-5c72-c2df84537ea7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] ppc/kvm: check some capabilities with
 kvm_vm_check_extension()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Sam Bobroff <sam.bobroff@au1.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>


--O98KdSgI27dgYlM5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2017 at 07:15:41AM +0200, Thomas Huth wrote:
> On 14.09.2017 21:25, Greg Kurz wrote:
> > The following capabilities are VM specific:
> > - KVM_CAP_PPC_SMT_POSSIBLE
> > - KVM_CAP_PPC_HTAB_FD
>=20
> BTW, looks like kvmppc_has_cap_htab_fd() is dead code ... should we
> either remove it or check it somewhere?

It's checked in kvmppc_get_htab_fd().

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--O98KdSgI27dgYlM5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm7dLsACgkQbDjKyiDZ
s5IT2g/+LDoDsdoVb6E4hOO0mYup0QoPfJFWNpIDiHhAupKXqiCT8jX6SAhMPDbh
MyIGeQBZBcMcq3G2nufOGWQqnUyzPo4aMwcT83NlZ2dvlqa/vuWTTwYOG/8qsDsC
1vFb/NvKi95fML9GfHXgatj0JtW+GMQc1izi7xRyb0STNCiNKOD8WzrAEewktKNN
WjhkOjRYY0BbIldYJRiIzzwFDSJEQ6kPfTUHflSVFDLv9Ede2yFYgM9I7peo/Xcy
QzIHZ4hT6yspnc1WrHhFwxriTYhffnpRpQOIkQn9mLyOMakrcyoi0/RDsxd2Z2HG
EAcubc+1Xg5dX7wyWdzndYo8Un3izKUxkJJUisvjUx9GWZ/VT/zhO+LnvFhhBdHf
RJuJhfHgqFYZg/ul1Cq+pGEkaknGrXRFl1n9hD1XVxilxG4JHP2WyfDxVpKftNB/
g1e8bp9B+O92a/BSWsYO1MV5iFNIge2DHJ/dkNzlF6/GqGa6AmEexRAekNsWWqSr
JNYdGau700fPSnPzhQU/w3feYYhEPTQ/6t8ibRdZ4knamLf15ChGeVYFW1NbV7k7
GCLKQr6nSNycyoCTOvEXp9JzSMxXf/HqTESEqJWdSQo1MyL9kQg/1A2RJYPmyRzO
YTRCg4iLo3NHfuebsJQJCWQJ76MunJau43aWxRxM6o0nH4Rov4U=
=P7DF
-----END PGP SIGNATURE-----

--O98KdSgI27dgYlM5--
