Received: from eggs.gnu.org ([2001:4830:134:3::10]:33091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG37j-0008Hb-G1
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:53:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG37i-0008GZ-T0
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:53:15 -0400
Date: Wed, 31 May 2017 13:53:07 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531125307.GA16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-27-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wHmMVWdCgqSO3x88"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-27-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 26/29] qed: Use CoQueue for serialising
 allocations
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


--wHmMVWdCgqSO3x88
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:22:07PM +0200, Kevin Wolf wrote:
> Now that we're running in coroutine context, the ad-hoc serialisation
> code (which drops a request that has to wait out of coroutine context)
> can be replaced by a CoQueue.
>=20
> This means that when we resume a serialised request, it is running in
> coroutine context again and its I/O isn't blocking any more.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed.c | 49 +++++++++++++++++--------------------------------
>  block/qed.h |  3 ++-
>  2 files changed, 19 insertions(+), 33 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--wHmMVWdCgqSO3x88
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLryzAAoJEJykq7OBq3PIGWQIAJ48CFqPVqN0ywiTUBpcltjK
rqkrkcDpT8QsLzvJTaYbWa1G4e0elLXMROJ/pyCDC0Eu315PjCkfj4I54KhO08hR
XJGvi9qhi8JBQZbtZcj2EzsUZ6yG5aTeVACm0EKEAKgNFrdnPj1BH/iGEWhXTgIh
2HjIcZyhqQonb2cPEVLdFFEk8MQM6SWbQEy5PvJIvuviSEmtnI2BSeeJ1KXZuzC2
Zrng02++oB+b0tSiiAM3fOZm3LT70mr9mPKnQ/iaPeTxD9UiSWHqQJqUu9IjvBVn
dPi2XnkcDGdGowT5VTNhcmjm+n+buRDFILlMPdHWBR7ifC0X/5HBYh6Pe7dfGao=
=x7TS
-----END PGP SIGNATURE-----

--wHmMVWdCgqSO3x88--
