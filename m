Received: from eggs.gnu.org ([2001:4830:134:3::10]:33471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWf12-0005Cd-Kx
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 05:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWf0y-0002SR-Re
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 05:39:32 -0400
Date: Sat, 23 Jun 2018 18:58:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180623085841.GM612@umbus.fritz.box>
References: <20180622103528.28598-1-david@gibson.dropbear.id.au>
	<CAFEAcA8-jSMy-9R69d7zQoEL593iiR5xitaPh17JwNzo-2U=1g@mail.gmail.com>
	<e56f27b2-63da-a8ae-4473-e75f341ef275@ilande.co.uk>
	<20180623004105.GL612@umbus.fritz.box>
	<16faa15d-1351-265b-2b1f-3b7f0b1d5034@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="P9KQiUGMzYCFwWCN"
Content-Disposition: inline
In-Reply-To: <16faa15d-1351-265b-2b1f-3b7f0b1d5034@ilande.co.uk>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 00/25] ppc-for-3.0 queue
 2018-06-22
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, qemu-ppc <qemu-ppc@nongnu.org>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--P9KQiUGMzYCFwWCN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 23, 2018 at 07:43:04AM +0100, Mark Cave-Ayland wrote:
> On 23/06/18 01:41, David Gibson wrote:
>=20
> > On Fri, Jun 22, 2018 at 04:16:10PM +0100, Mark Cave-Ayland wrote:
> > 11;rgb:ffff/ffff/ffff> On 22/06/18 16:03, Peter Maydell wrote:
> > >=20
> > > > On 22 June 2018 at 11:35, David Gibson <david@gibson.dropbear.id.au=
> wrote:
> > > > > The following changes since commit 46012db666990ff2eed1d3dc199ab8=
006439a93b:
> > > > >=20
> > > > >     Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180=
619' into staging (2018-06-20 09:51:30 +0100)
> > > > >=20
> > > > > are available in the Git repository at:
> > > > >=20
> > > > >     git://github.com/dgibson/qemu.git tags/ppc-for-3.0-20180622
> > > > >=20
> > > > > for you to fetch changes up to e5ca28ecab5c69b7578e22391a66c97c39=
79ffd8:
> > > > >=20
> > > > >     spapr: Don't rewrite mmu capabilities in KVM mode (2018-06-22=
 14:19:07 +1000)
> > > > >=20
> > > > > ----------------------------------------------------------------
> > > > > ppc patch queue 2018-06-22
> > > > >=20
> > > > > Another assorted patch of patches for ppc and spapr.
> > > > >       * Rework of guest pagesize handling for ppc, which avoids g=
uest
> > > > >         visibly different behaviour between accelerators
> > > > >       * A number of Pnv cleanups, working towards more complete P=
OWER9
> > > > >         support
> > > > >       * Migration of VPA data, a significant bugfix
> > > >=20
> > > > Applied, thanks.
> > > >=20
> > > > -- PMM
> > >=20
> > > Looks like this is missing the 2 Mac commits I submitted that David a=
dded to
> > > the PR this morning?
> > >=20
> > > https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg06540.html
> > > https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg06536.html
> > >=20
> > > David, did you forget to re-push the updated tag?
> >=20
> > They just missed the window, sorry.  I merged them after I'd already
> > tagged and tested the pull request.
>=20
> Okay, as long as you didn't forget them :)
>=20
> My confusion came from the fact that the emails you sent for the PR
> yesterday contained my patches as patches 24 and 25, although they aren't
> included in the cover letter or the github tag.

Ah, right.  So I realized that bogus set of mails was the result of
pointing git send-email at a git range instead of the batch of mails
already prepared for the pull request.  Which meant for one they
weren't properly formatted for a PR, and also it included the couple
of patches of yours I'd applied after tagging the PR.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--P9KQiUGMzYCFwWCN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsuC78ACgkQbDjKyiDZ
s5KJAw//Tm9ZafJp2ydlyrmjle/l5n04h8zYO5HjvbhwhsN4bik77ukJDgOBfEuh
Lx3QJJEvd8VdSCEf5SioJstAWBmFGeXp3AJb4l0bkgXVOg16D0lEzatoIX3nErcV
1hCkrmjc2+zo+5bJrtsmof73urDT6jZzBogNmYzlRwLhLtk0crk4VjrdbUj+28iI
VRAJMvFY9tQxXXXYlwMoQ7rYpBmTE2KncjG7vVY2ByJny61Q8hWnEFQ50Xhpj3mP
ypg2RfjP31gy68q1m01+Jtr4SgDDWb9C2KMw4TsQ5b/jNtUegtfDW0RyUQ1T0uxN
0Tgfga3diUHcAQh8CDkK49p79QcjfPdwnKX8TdRpP6/hFZaiXW0X6QMs4BprWGip
mAo9EZrWFOSO9cTEt3bw+9f4Og8QeXlA/DFhhQfnlcGyzTXskCQMz8/wc4R0o/ub
RRDTAlDeQdTdDg0NeveiNAF84BIujA0B1VERg909ySQNE3ZWqcBLHQ7P+oWsAp5N
2g45nStQsK9kMFk5vOqlnzZ2N6YUdgxcp8i1VhxjYow/i5ogu0nM6eRkZFoe7vae
YX99lhNgCGJLy2sR7vAH8j/WWV9CLH0V0w+fwFH9b00dQQ/+PnNO7aME7YmERxsN
puMFTKy3/M49tueAOuSyYDt+ATlU0gFijBy5J6rMoytJ1F2qXhg=
=43IE
-----END PGP SIGNATURE-----

--P9KQiUGMzYCFwWCN--
