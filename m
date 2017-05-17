Received: from eggs.gnu.org ([2001:4830:134:3::10]:48661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAyTx-00081y-5r
	for qemu-devel@nongnu.org; Wed, 17 May 2017 08:55:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAyTt-0007ET-8G
	for qemu-devel@nongnu.org; Wed, 17 May 2017 08:55:13 -0400
Date: Wed, 17 May 2017 13:55:01 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170517125501.GG8260@stefanha-x1.localdomain>
References: <20170516155420.10106-1-jcody@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1XWsVB21DFCvn2e8"
Content-Disposition: inline
In-Reply-To: <20170516155420.10106-1-jcody@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PULL 0/8] Block patches for curl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-block@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org


--1XWsVB21DFCvn2e8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 16, 2017 at 11:54:12AM -0400, Jeff Cody wrote:
> The following changes since commit 3a8760664d5c1a1a93c9012bdb8ac07ab8fd4b=
0d:
>=20
>   Merge tag 'tracing-pull-request' into staging (2017-05-12 10:39:35 -040=
0)
>=20
> are available in the git repository at:
>=20
>   git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request
>=20
> for you to fetch changes up to 2bb5c936c5827e1d831002f7a7517cb8c2c2201d:
>=20
>   curl: do not do aio_poll when waiting for a free CURLState (2017-05-16 =
10:34:50 -0400)
>=20
> ----------------------------------------------------------------
> Curl patches
> ----------------------------------------------------------------
>=20
> Paolo Bonzini (7):
>   curl: strengthen assertion in curl_clean_state
>   curl: never invoke callbacks with s->mutex held
>   curl: avoid recursive locking of BDRVCURLState mutex
>   curl: split curl_find_state/curl_init_state
>   curl: convert CURLAIOCB to byte values
>   curl: convert readv to coroutines
>   curl: do not do aio_poll when waiting for a free CURLState
>=20
> Peter Krempa (1):
>   block: curl: Allow passing cookies via QCryptoSecret
>=20
>  block/curl.c         | 239 ++++++++++++++++++++++++++++++---------------=
------
>  qapi/block-core.json |  12 ++-
>  2 files changed, 153 insertions(+), 98 deletions(-)
>=20
> --=20
> 2.9.3
>=20
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--1XWsVB21DFCvn2e8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZHEglAAoJEJykq7OBq3PIQ4UH/2dWaaF3Wl0yKeQkl3drYjir
NJJvzHFmC81jM2QspPzdTsdlpU6u5MX1LIZuzzSkZHNU2ouhicWqoD8Xnll4oMBj
O7aoKdf75Dbi4TyWiBBS2fu3lScfJWHqdXgH/CWzVMctB8JJ5QKYhr94z971qjnY
QU3vfkUdg22rvnehwi0KYHXF7tU4UWaSJbXXK5igFV3AY8BDvjEvj/R+hQebC/B1
zv0C91Hv+1Jb2hRoAlCesDd+qxEGCCFIeUO14uIE1PH/mLpfa1JK91hoPcYSVOWR
gw8YMxkRqPkvIlGvPcjBvXsdDln6JTR3hcWPVUgp8AFVETVQ6TRvlqEW3qO8Kv4=
=9MS1
-----END PGP SIGNATURE-----

--1XWsVB21DFCvn2e8--
