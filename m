Received: from eggs.gnu.org ([2001:4830:134:3::10]:39428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1drMPT-0007oN-SB
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1drMPP-0002HU-Or
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:57:47 -0400
Date: Mon, 11 Sep 2017 19:49:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170911094950.GA2784@umbus.fritz.box>
References: <1504030416-18618-1-git-send-email-thuth@redhat.com>
	<20170911093207.4375c534.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20170911093207.4375c534.cohuck@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] tests: Fix broken
 ivshmem-server-msi/-irq tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2017 at 09:32:07AM +0200, Cornelia Huck wrote:
> On Tue, 29 Aug 2017 20:13:36 +0200
> Thomas Huth <thuth@redhat.com> wrote:
>=20
> > Broken with commit b4ba67d9a7025 ("libqos: Change PCI accessors to take
> > opaque BAR handle") a while ago, but nobody noticed since the tests are
> > only run in SPEED=3Dslow mode: The msix_pba_bar is not correctly initia=
lized
> > anymore if bir_pba has the same value as bir_table. With this fix,
> > "make check SPEED=3Dslow" should work fine again.
> >=20
> > Fixes: b4ba67d9a702507793c2724e56f98e9b0f7be02b
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  tests/libqos/pci.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> There really should be a better tree for that than my s390 tree, but
> the other ivshmem patch was feeling a bit lonely, so I queued this as
> well. Better than having the patch languish on the list.

Thanks, Cornelia.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm2XDsACgkQbDjKyiDZ
s5J0ZRAA5YsbXrSGFOCL4ByflXUU2ct5rahj2O0O72PKfmqZL6NnU0WLCAgviJN1
0bh26ENnYU3ef/sfsWlqdd9p1gKhz0FTmVzi0tv+41NT0TpW/wGVKvtzjSIXOz3a
YL3LyBHXf7NmKo2o1sBQu7k8N2stg/VjY0kel2ZBD6qpO6v4JnkjqwMmBfxLjTat
EfY0s/FdH+xIdgCGLBY3hMHElDEyrjHBdD++S9qw0Y5IYcGKpnNF7oWrlSRgbwch
ThuyZ6m/NedGKAqSVraFZYuHZqCUgkebz0/pdTodepwHLJ59nYI95iPkltOL8qK5
d/oMAGZhuWxbeB5sqX0vls56+yxdlLkD6Hh7YVbnatasHXk6Xud9Q8RlpNka/SlC
ixee9uo5hNxPf6Xp7ElHysfTxtD4omlJ0+7IaVwxsy9CeCkF4cUvXDyn/frrPc1R
9MfN/6iPA4IgSt5d+1u11MrCtNHqzfyWN6bq7CWZ/akDR3yojuu6iA47sPMwguDF
nP3A6zulDgeuknpr93VqPrtQRjce5Es6SxqHpPQfSnsONb1gELUgm3v4Kx+YvZ05
hvmPbuXa0xyNNHSmKlFZbeEHIXtr2BWmjEy4MYnKGPDBkooYVfj4jtckae7g/4Uz
oKAJHhy+ZlvS2zQjDIeY8LmceqmbkO50mAZglTABcVWTCQEz94I=
=Q8y2
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
