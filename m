Received: from eggs.gnu.org ([2001:4830:134:3::10]:34151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fY92k-0004PK-Dj
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fY92j-0006Pq-MZ
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:55:26 -0400
Date: Wed, 27 Jun 2018 12:55:18 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180627115518.GH5955@stefanha-x1.localdomain>
References: <20180626142434.22090-1-kwolf@redhat.com>
	<20180626142434.22090-4-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1xGqyAVbSpAWs5A"
Content-Disposition: inline
In-Reply-To: <20180626142434.22090-4-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/6] qcow2: Remove coroutine trampoline
 for preallocate_co()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org


--X1xGqyAVbSpAWs5A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2018 at 04:24:31PM +0200, Kevin Wolf wrote:
> All callers are coroutine_fns now, so we can just directly call
> preallocate_co().
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2.c | 51 ++++++++-------------------------------------------
>  1 file changed, 8 insertions(+), 43 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--X1xGqyAVbSpAWs5A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbM3smAAoJEJykq7OBq3PIRhEH/3hPG/0d1J2MZ54daFgIb8/S
Z6xlJC9kNagts6xzlmCr1/ZiecKvsv7TnkRb4k3wyLeUWAWw0d2E/affGlr8mWie
UC48y8jPdqug1cUDfvjAErG4dIAZB6lYgir+13ovwvY9cHF/aUmCN509ZcJ5Qfm/
dFKC1kRFCiSkWbS7K0jCTjgxGU6mj1ERwpuGt/1IYGNnBwg2jSKYo/n7U1T4MRti
XcqsHnCLtSSHgOGsvzNdEr09qmjg9wWoyrryh1TkCtyiQRWvW8fssO+xdkh83Qf9
jzEn67QRDOuBIXwC+k6g7Y4vvGfbTrg/UMQUjYdTUFkZGFvqQngMR7BYO0nuInk=
=0SJy
-----END PGP SIGNATURE-----

--X1xGqyAVbSpAWs5A--
