Received: from eggs.gnu.org ([2001:4830:134:3::10]:53556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAxo7-0006Sd-BN
	for qemu-devel@nongnu.org; Wed, 17 May 2017 08:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAxo6-0004gP-Kg
	for qemu-devel@nongnu.org; Wed, 17 May 2017 08:11:59 -0400
Date: Wed, 17 May 2017 13:11:53 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170517121153.GE8260@stefanha-x1.localdomain>
References: <1494851980-6831-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y2zxS2PfCDLh6JVG"
Content-Disposition: inline
In-Reply-To: <1494851980-6831-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-iotests: Test streaming
 with missing job ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org


--y2zxS2PfCDLh6JVG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2017 at 02:39:40PM +0200, Kevin Wolf wrote:
> This adds a small test for the image streaming error path for failing
> block_job_create(), which would have found the null pointer dereference
> in commit a170a91f.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/030     | 4 ++++
>  tests/qemu-iotests/030.out | 4 ++--
>  2 files changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--y2zxS2PfCDLh6JVG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZHD4JAAoJEJykq7OBq3PIChIH/3MSwTIe/wX+2eG3goT81/5/
zwd5J/qdmrlARGV+7eHosDLpvdUwE9JQjnTDNSpDKOfS0MLIAkW2x7SWMqVQmOa2
1bWhRVANLycrvS0EF/shascy6ytY/bBkLlWC5Z1LHkMHHUl1VTwu95RjMo5qFeTH
ggO1PwguMyx8iCeihl2GEtcK7LtkwdvIMg3xkYygUZsh4vEVvMgvCuVnMoaPNhnF
y5sqrcfiaeuNmNqRG4cMe3QlZ5Q56cEpkbhlC6BrtU4cixZaeoWFcHMdo8D7+qMo
fWJNZem+Srp8ewVrSZMmA9/PFqc3xiJxRQCBxcjZD+8/ZNXPQn3PWqHPKOvrwW4=
=710b
-----END PGP SIGNATURE-----

--y2zxS2PfCDLh6JVG--
