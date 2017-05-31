Received: from eggs.gnu.org ([2001:4830:134:3::10]:55740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dFxFa-0008Eu-9g
	for qemu-devel@nongnu.org; Wed, 31 May 2017 02:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dFxFW-0005Iz-DV
	for qemu-devel@nongnu.org; Wed, 31 May 2017 02:36:58 -0400
Date: Wed, 31 May 2017 16:33:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170531063321.GL12163@umbus.fritz.box>
References: <20170525035132.24268-1-david@gibson.dropbear.id.au>
	<20170525035132.24268-12-david@gibson.dropbear.id.au>
	<20170529231408.43f12e95@bahia.ttt.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qo7zVO9a9OQ5oQtr"
Content-Disposition: inline
In-Reply-To: <20170529231408.43f12e95@bahia.ttt.fr.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 11/18] pseries: Split CAS PVR
 negotiation out into a separate function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, sursingh@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, sbobroff@redhat.com


--qo7zVO9a9OQ5oQtr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2017 at 11:14:08PM +0200, Greg Kurz wrote:
> On Thu, 25 May 2017 13:51:25 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > Guests of the qemu machine type go through a feature negotiation process
> > known as "client architecture support" (CAS) during early boot.  This d=
oes
> > a number of things, one of which is finding a CPU compatibility mode wh=
ich
> > can be supported by both guest and host.
> >=20
> > In fact the CPU negotiation is probably the single most complex part of=
 the
> > CAS process, so this splits it out into a helper function.  We've recen=
tly
> > made some mistakes in maintaining backward compatibility for old machine
> > types here.  Splitting this out will also make it easier to fix this.
> >=20
> > This also adds a possibly useful error message if the negotiation fails
> > (i.e. if there isn't a CPU mode that's suitable for both guest and host=
).
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> > ---
>=20
> Any reason for not seing these patches as well in this pull request ?
>=20
> pseries: Restore PVR negotiation logic for  pre-2.9 machine types
> pseries: Improve tracing of CPU  compatibility negotiation

Yes.  After more discussion; and comparison with analogous x86 cases
that came up with Igor's NUMA cleanups, I've decided that the
behaviour here while guest visible comes under the heading of a
firmware behaviour change, which we don't typically arrange 100%
matching behaviour for.  Meanwhile, I also found out more things that
suggest matching old behaviour correctly is going to be even messier
than I though.

So, I've decided that leaving the behaviour change in place is the
better course.  Note that it won't affect migration (at least after
the other compat/migration fixes are merged).

I'll reconsider if we observe a real problem in the wild with it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qo7zVO9a9OQ5oQtr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZLmOvAAoJEGw4ysog2bOSZT8QANhOD+2M8jTl0cxDKoAAr/AU
iBfFTr+gAGNZe52D5VRCvkpBeYfOfrYM8gqWO3Fth1xcawTdkb0Vwz8ri/0aPaLb
C3W+qesWA/u3dJrNfbxjRijDML0zAF859qmb6U1iKcDecwENZUzQAU0B0By2zipG
utay8Ug0TQCFq1MCFkc6T2LQ10uOEt0BcL8dwL+Rd/e/EmwMu0QFNNhfZg0s4f4H
6x2R07QsCfCvA/hhK7ouQdkXQiziF9MS2VCksknHZwItnoFfLsZAFiyOufgM/ur+
dg7AOnCpkiiF4plJnHHCoen4kyF4Jfd1tS/0WrE7Kz0kVMTNnZ2M9c5/F8aQRf4V
TbClRhRwTFTGOl+c8Up0agDZ/ibu0FVliJiegktKXZV/UA3aBwzlU9Cm3S7Dz4ER
hJ2PvI5VAVrEYVrpybcdd4Sg+YcdJYVkmcePXNpmy0Ya3JwbAINrAU24S2cLzrQ2
0Rnxs3k/3/ANOfE7Jhz4haE2i1/uLD9J6DZg4/j4sOHDcCPS6Ay1NIIuQD/bNN68
BU96UPlee4XmyLXHqaGR1AVmDdlVIv0cbDUdy376u4XRwqxldly938Sw/nF4dpud
Hdhs/NfgmCmDterrDFgYftfq80jXnFd4ehyvwyxPId95cmy8QtYHl988OPkMKIjV
I+qzinJ+MeRDNCnrhNqw
=Pc6n
-----END PGP SIGNATURE-----

--qo7zVO9a9OQ5oQtr--
