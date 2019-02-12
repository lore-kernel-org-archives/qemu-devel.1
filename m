Received: from eggs.gnu.org ([209.51.188.92]:54022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gtP6s-00037m-Ui
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 22:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gtP6f-0008Fs-Gf
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 22:51:42 -0500
Date: Tue, 12 Feb 2019 11:51:18 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190212035118.GD28401@stefanha-x1.localdomain>
References: <20190211055040.13528-1-stefanha@redhat.com>
	<CAFEAcA-pkOanLBVCry15tSH3dMp-Kuby675LYd6wGidh6E1Wig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cHMo6Wbp1wrKhbfi"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-pkOanLBVCry15tSH3dMp-Kuby675LYd6wGidh6E1Wig@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PULL 0/9] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sgarzare@redhat.com
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>


--cHMo6Wbp1wrKhbfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 11:42:14AM +0000, Peter Maydell wrote:
> On Mon, 11 Feb 2019 at 05:50, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >
> > The following changes since commit e47f81b617684c4546af286d307b69014a83=
538a:
> >
> >   Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' =
into staging (2019-02-07 18:53:25 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/stefanha/qemu.git tags/block-pull-request
> >
> > for you to fetch changes up to 55140166667bb555c5d05165b93b25557d2e6397:
> >
> >   tests/virtio-blk: add test for WRITE_ZEROES command (2019-02-11 11:58=
:17 +0800)
> >
> > ----------------------------------------------------------------
> > Pull request
> >
> > User-visible changes:
> >
> >  * virtio-blk: DISCARD and WRITE_ZEROES support
>=20
> Hi; this fails to pass "make check" (all platforms):
>=20
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=3Darm-softmmu/qemu-system-arm QTEST_QEMU_IMG=3Dqemu-img
> tests/virtio-blk-test -m
> =3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl
> --test-name=3D"virtio-blk-test"
> **
> ERROR:/home/pm215/qemu/tests/virtio-blk-test.c:272:test_basic:
> assertion failed (status =3D=3D 0): (1 =3D=3D 0)
> ERROR - too few tests run (expected 1, got 0)

Stefano, I'm dropping the virtio-blk DISCARD/WRITE_ZEROES series.
Please debug this failure.

I cannot reproduce it on a Linux host so maybe it's related to macOS.
First I thought it's because write zeroes is not supported on macOS, but
QEMU should fall back to writing a bounce buffer of zeroes.

Stefan

--cHMo6Wbp1wrKhbfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcYkK2AAoJEJykq7OBq3PIwQwH/1Q9+QF2qq3sj2/EV4ejIwJD
xRIzVO6xi+3aQ7T5VXwIYumrQDHnhHu+gaP9V2yQfFHi3vjHM1uwXRRy/3YsDzky
wmWj5aOgvoJGO27lK7kxwOIGdhXiG288iwgnBKrHjPqYXemQySNLN6TIlguc7CRA
j60cA6Nu9wRntmub1gXyjyvU5rYhCFmGSaN5Tg+N9TOpgPHonFTtzpMBkC3ksY5P
RRcb+NMmljScgK5RfBlViephPC6m/umwyQbuqJpT49X/d7IRoRpnLDF6L4EC/Fvv
x4WRqUubhf872GpL/zUEegIqjc+cDt7SEvH1El9r51/X006f7csvvry9hbPCBVg=
=yA/4
-----END PGP SIGNATURE-----

--cHMo6Wbp1wrKhbfi--
