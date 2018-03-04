Received: from eggs.gnu.org ([2001:4830:134:3::10]:50371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1esddC-0005pb-IT
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 19:05:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1esdd9-0002Yh-DB
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 19:05:30 -0500
Date: Mon, 5 Mar 2018 10:55:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180304235557.GB2650@umbus.fritz.box>
References: <20180302060350.24330-1-david@gibson.dropbear.id.au>
	<CAFEAcA9ZRSX9FBwaiA8Th3mrO4KSOaDPqnH5F==5xNESOf+Dwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9ZRSX9FBwaiA8Th3mrO4KSOaDPqnH5F==5xNESOf+Dwg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/24] ppc-for-2.12 queue 20180302
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, surajjs@au1.ibm.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 02, 2018 at 02:26:49PM +0000, Peter Maydell wrote:
> On 2 March 2018 at 06:03, David Gibson <david@gibson.dropbear.id.au> wrot=
e:
> > The following changes since commit 0dc8ae5e8e693737dfe65ba02d0c6eccb58a=
9c67:
> >
> >   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180301-v2' =
into staging (2018-03-01 17:08:16 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180302
> >
> > for you to fetch changes up to 57ae75b2e401f1d04f37a8cd26212eb3134c51a6:
> >
> >   hw/ppc/spapr,e500: Use new property "stdout-path" for boot console (2=
018-03-02 12:24:44 +1100)
> >
> > ----------------------------------------------------------------
> > ppc patch queue 2018-03-02
> >
> > Here's the next batch of accumulated spapr and ppc patches.
> > Highlights are:
> >     * New Sam460ex machine type
> >     * Yet more fixes related to vcpu id allocation for spapr
> >     * Numerous macio cleanupsr
> >     * Some enhancements to the Spectre/Meltdown fixes for pseries,
> >       allowing use of a better mitigation for indirect branch based
> >       exploits
> >     * New pseries machine types with Spectre/Meltdown mitigations
> >       enabled (stop gap until libvirt and management understands the
> >       machine options)
> >     * A handful of other fixes
> >
>=20
> Hi. This generates a compile error from some compilers in my test set
> (I think just the older gccs):
>=20
> /home/petmay01/linaro/qemu-for-merges/hw/ppc/ppc440_uc.c: In function
> =E2=80=98ppc460ex_pcie_realize=E2=80=99:
> /home/petmay01/linaro/qemu-for-merges/hw/ppc/ppc440_uc.c:1054:5:
> error: =E2=80=98id=E2=80=99 may be used uninitialized in this function
> [-Werror=3Dmaybe-uninitialized]
>      snprintf(buf, sizeof(buf), "pcie%d-io", id);
>      ^
> cc1: all warnings being treated as errors
>=20
> Looks like a valid complaint to me -- the realize function
> should check that dcrn_base was set to a valid value, fail
> realize if it wasn't, and have a 'default:' case in the
> switch with g_assert_not_reached().

Bother.  I wonder why my compiler didn't catch that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqch4wACgkQbDjKyiDZ
s5I8gw/+NQcD5RejtNEnXYqyclM5heuy2lE8bBYgWf0qXzDiPgwUSBZJY6a4rNDw
j/+cGDmS/Xnuw8RNfzpvjIioM3Q3F51BW+kUgJR26NineZlAtNcPgyjOxUEiKgO2
mYsDgUmZppIJW6cEmjwipiJsvzAIqk6wySe5BQB4Ne6Lju40l6d8ponaEPRNQp/8
x+ciKrpKgRyK7Iiv6V1BNZ3BagEHDDCfZ0J4npKPhVT6GQMJwXImJ3Dc9s3LKmO0
KmcMso+HaWQ5CnQrEI5D+725YsaNAUjIE6SoLwzUUQUykChZHG0XuFm1LVJV2SpF
lG8arq61CR3YW1DuRmG11hcjmsTz8nrLGD8p2XJSESnUCYS+1Hya6/CuudsiPRTW
pS75Lh5wYFSGm4bHukuXpwBANrElFvGBVQAvRBUhkwRoS6V3kAAfrUkfXNKEzjxJ
DdyFtGXAjN0fLJkeDsLuXhvf7D6OSnOFLSfFnvkMOo1rzqZJ5ewQLyZdCLPiftlH
LuyH8/dqx6FRdU7GPOoBj83WaYH9ss/whkyjkONvjDzbUkItN0XZyg6l0jq3zZNq
jrUUgGtL/q5VFkvwiFdhA1vb/JzqZSLY69PFVNVkvnuqk5cVbTujvxVEa4UAkeI4
g1ZfL+pHDF5H1Orl0fGRcicqqol2cenz3jMTSO6dJOepA0L/SjY=
=5c+H
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
