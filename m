Received: from eggs.gnu.org ([2001:4830:134:3::10]:38853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fPlhc-0003L3-0D
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fPlhX-0002uM-Lf
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:23:00 -0400
Date: Mon, 4 Jun 2018 10:22:52 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180604092252.GB13674@stefanha-x1.localdomain>
References: <20180531004323.4611-1-jsnow@redhat.com>
	<1b6be0a7-9420-0cf7-63f8-0cd124873d96@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline
In-Reply-To: <1b6be0a7-9420-0cf7-63f8-0cd124873d96@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/3] ahci: fix completion race
 condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 31, 2018 at 08:00:34PM -0400, John Snow wrote:
> On 05/30/2018 08:43 PM, John Snow wrote:
> > Commit d759c951f changed the main thread lock release/reacquisition,
> > and in so doing apparently jostled loose a race condition in the AHCI
> > code.
> >=20
> > Patch 2 should be sufficient to fix this, and patches 1 and 3 are just
> > little trivial fixes.
> >=20
> > This might be sufficient to fix the bug as reported at
> > https://bugs.launchpad.net/qemu/+bug/1769189
> > but the nature of the timing changes make it difficult to confirm,
> > so I am posting this patchset for the reporters to help test.
> >=20
> > John Snow (3):
> >   ahci: trim signatures on raise/lower
> >   ahci: fix PxCI register race
> >   ahci: don't schedule unnecessary BH
> >=20
> >  hw/ide/ahci.c | 24 +++++++++++-------------
> >  1 file changed, 11 insertions(+), 13 deletions(-)
> >=20
>=20
> Thanks for the testing and reviews, everyone!
>=20
> Thanks, applied to my IDE tree:
>=20
> https://github.com/jnsnow/qemu/commits/ide
> https://github.com/jnsnow/qemu.git

Also CCing stable.  This should go into QEMU 2.12.1.

Stefan

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbFQTsAAoJEJykq7OBq3PIpPEIAKYYiNbktjbDgxV1J44TBQ2Z
RTs4/GmgyLFgK0qtzPVaA7tq4v4uwg86beRcJcTjnHlgXmwmJyjvSdQfsWEIo91m
+zoqenOdK+B11mneTihIUwPtPQxqTMCRoCmWvD+/MEPEkhOjohh/2YgPI7MvTfaT
edMGvosgcrj9q8L4M8ZBUP8yL60t0Znv/ZoCiIuA8yi/RrD/uUACuU8KugjfTltB
kbI8G9/ZDpSphEX+D5k12fYQcG3kU/N5gNFTIYQhzAwSDRkOOaS0x4pvuF/wlHl4
hIB7kIEjpNaIblT3CSfSG6XpyPNc+om7EfzOYzsKCB//lD8yxKuSSpE7tYBSAP0=
=qPvY
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
