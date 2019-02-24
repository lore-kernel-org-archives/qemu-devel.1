Received: from eggs.gnu.org ([209.51.188.92]:37027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gy3Kz-0002bi-Mu
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 18:37:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gy3Ky-0003LS-Gf
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 18:37:37 -0500
Received: from ozlabs.org ([203.11.71.1]:34531)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gy3Kw-0003Iu-Lc
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 18:37:36 -0500
Date: Mon, 25 Feb 2019 09:49:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190224224949.GA7668@umbus.fritz.box>
References: <20190221173326.31874-1-mst@redhat.com>
	<CAFEAcA_Nmo1bpWr5rUmXotB_J9J78wvqB9TU174WWyqt+CEZZw@mail.gmail.com>
	<20190222105159-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20190222105159-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PULL 00/26] pci, pc, virtio: fixes, cleanups,
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 10:53:54AM -0500, Michael S. Tsirkin wrote:
> On Fri, Feb 22, 2019 at 03:47:36PM +0000, Peter Maydell wrote:
> > On Fri, 22 Feb 2019 at 02:40, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > The following changes since commit fc3dbb90f2eb069801bfb4cfe9cbc83cf9=
c5f4a9:
> > >
> > >   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-requ=
est' into staging (2019-02-21 13:09:33 +0000)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> > >
> > > for you to fetch changes up to 1f8c04f18d2ee2f6ec88217dfd547ab38d2be5=
c5:
> > >
> > >   pci: Sanity test minimum downstream LNKSTA (2019-02-21 12:28:41 -05=
00)
> > >
> > > ----------------------------------------------------------------
> > > pci, pc, virtio: fixes, cleanups, tests
> > >
> > > Lots of work on tests: BiosTablesTest UEFI app,
> > > vhost-user testing for non-Linux hosts.
> > > Misc cleanups and fixes all over the place
> > >
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > >
> > > ----------------------------------------------------------------
> >=20
> > Compile failure on clang:
> >=20
> > /home/petmay01/linaro/qemu-for-merges/hw/virtio/virtio-balloon.c:40:3:
> > error: redefinition of typedef 'PartiallyBalloonedPage' is a C11
> > feature [-Werror,-Wtypedef-redefinition]
> > } PartiallyBalloonedPage;
> >   ^
> > /home/petmay01/linaro/qemu-for-merges/include/hw/virtio/virtio-balloon.=
h:33:39:
> > note: previous definition is here
> > typedef struct PartiallyBalloonedPage PartiallyBalloonedPage;
> >                                       ^
> > 1 error generated.
> > /home/petmay01/linaro/qemu-for-merges/rules.mak:69: recipe for target
> > 'hw/virtio/virtio-balloon.o' failed
> >=20
> > thanks
> > -- PMM
>=20
> Fixed up and re-pushed.
> David, pls note above and don't add duplicate typedefs in the future.
> There's always include/qemu/typedefs.h if you don't know where
> to put a typedef.

Yeah, sorry.  I noticed the failure on Travis and was going to send a
fix, not realizing you'd already picked it up.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxzH4sACgkQbDjKyiDZ
s5KskxAAzah5GN5IuISWJ9MKp/6mXQtC9M42t2+27Th7mJ5sIIky4ZPg9mWoSyub
3XygZWQIKqDm3r9aRKn1D5c6mi/KbaPvbEDvxHK8TNY8w75PhXlFnF7eErcrTySn
rscmXZjsbYhF4GK8VrV3itmjpUzKtCvjt7t0WLvvyss7m/Gtt85zZWOO0QEWFTcb
pem9sfDlsB1CgP23bnOA3k8n73sM9EhfiW1NKaEsaWCcYrud+OM9q/oINu07W+6x
XgLOTLKMUR3aHGlIrVakp9h4BwWYRnet+ZM5imiDnTDyf7DoMDLbpxoxtCoGIxgs
aTJ6BTFBbDO8HhxIJGWRj2MrXVyZwZ8+Q2VW3Tmp4DQ4gIrKwYIh5N3toWwuTcOO
f0edhRikINi9MCG7suT2gxeBOJNEI3BGVe3s0DYfUBtuZC8t3m5GDj06Rej0/34J
W0W7tgELtXO5NzeLXiZf8KYa5JnXfbRZlJ0nO/p1t0NklOVfZgtzsWniyv0i4fud
4tUlrgjQCh+C9A/mVCzQRQeJlTlGJAC4mf+sFwqwBEeWkpiths2aEqSU9LBI8lbJ
KKJNvE+6fzn0CCpuTvL5bkKzkjLA+w7tB55MMwmrCJJZFTYioaypMj8vO6zrPFNv
knXGmB55L9ZB8nCGptbvm3he56Y6p92bQRYo08OmGPz2Lnxr4Ow=
=mWFZ
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
