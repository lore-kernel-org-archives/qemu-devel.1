Received: from eggs.gnu.org ([2001:4830:134:3::10]:57870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2va-0000dP-Gt
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2vZ-0003rU-G2
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:40:42 -0400
Date: Wed, 31 May 2017 13:40:27 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531124027.GR16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-18-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6eUvXotnMb6+obQB"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-18-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 17/29] qed: Add return value
 to qed_aio_write_l1_update()
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


--6eUvXotnMb6+obQB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:21:58PM +0200, Kevin Wolf wrote:
> Don't recurse into qed_aio_next_io() and qed_aio_complete() here, but
> just return an error code and let the caller handle it.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6eUvXotnMb6+obQB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLrm7AAoJEJykq7OBq3PIrUQH/3ZMr1fhwOsxi4XPzo2RaFZ/
emDNwsszL9IpJh4XxClUg+NatZ5y8s//jdy/674gYVOEnwIMHcCFf7R3nS6K6m2e
d3drZ9erbn7MbpP34y/HblIkrIHbbvj2SJErK4kAOA8EDs9emEYg0VLad1PRJQH4
EkmnO3Sk9/Rl4LCEJSoBWNlq0RlLY4yx9UUa5TLDfq8jVEyDvydp8kK94XwOT6Kd
/TvFj8mFs33h/jvw38AwBdrEGzllJfBXlamRyZE2z6ABHZbsHO/Tjgcnn42z9Sm0
r4qWKsAI5q0r7dzq+11S10fLd+1PnB0ljDfjUhTle1GgTTlUQJtofni4Hu+tU6E=
=FaH3
-----END PGP SIGNATURE-----

--6eUvXotnMb6+obQB--
