Received: from eggs.gnu.org ([2001:4830:134:3::10]:57331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2tU-0007gi-IY
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:38:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2tQ-0003Io-Kh
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:38:32 -0400
Date: Wed, 31 May 2017 13:38:23 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531123823.GQ16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-17-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8RsyD0KswhpoK73Z"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-17-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 16/29] qed: Inline qed_commit_l2_update()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com


--8RsyD0KswhpoK73Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:21:57PM +0200, Kevin Wolf wrote:
> qed_commit_l2_update() is unconditionally called at the end of
> qed_aio_write_l1_update(). Inline it.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed.c | 36 ++++++++++++++----------------------
>  1 file changed, 14 insertions(+), 22 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--8RsyD0KswhpoK73Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLrk/AAoJEJykq7OBq3PIzOEH+wbR3A+FqxsPEEojkJbfoKdt
m2LVjVmElmsg5oiY+I/wFVoQHORbhvOEwmNU8JnWDvaQCqSScyRrjQRAWbID3unO
+GW994x6eZma8TPPcXYz1s/3lO04ruuHIYPgVeHMO0ugWuA+zuQ8WtOEePhAogMb
7l2ZKmxn1eS0sZma+P/Gq9vqvEPBVbu3Az28W57ssdZvtbKlA3uBHNQzZVw1542A
wC2XcG5VsROLXNcqrvYzYWsvBwTdm0EIsl4wv3puctnDaVB6h/3O0+yAuizIj6rF
DK2IhKaDZOQJVyT3W/zUGsfh312EmieGzoWemB/aaTZJYuiszqOljCZKApfwXzI=
=y/s2
-----END PGP SIGNATURE-----

--8RsyD0KswhpoK73Z--
