Received: from eggs.gnu.org ([2001:4830:134:3::10]:55099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ddcS4-0005Av-BX
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ddc6S-0005rl-2k
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 08:54:40 -0400
Date: Fri, 4 Aug 2017 13:51:27 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170804125127.GD14565@stefanha-x1.localdomain>
References: <20170804105036.11879-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7DO5AaGCk89r4vaK"
Content-Disposition: inline
In-Reply-To: <20170804105036.11879-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: move trace probes into
 bdrv_co_preadv|pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>


--7DO5AaGCk89r4vaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2017 at 11:50:36AM +0100, Daniel P. Berrange wrote:
> There are trace probes in bdrv_co_readv|writev, however, the
> block drivers are being gradually moved over to using the
> bdrv_co_preadv|pwritev functions instead. As a result some
> block drivers miss the current probes. Move the probes
> into bdrv_co_preadv|pwritev instead, so that they are triggered
> by more (all?) I/O code paths.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/io.c         | 8 ++++----
>  block/trace-events | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--7DO5AaGCk89r4vaK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZhG3PAAoJEJykq7OBq3PIfkIIAIkCvym1RvPJGvsx/FUhIQ5q
gS/RI080yoXxHt7m2p8M+18w5+goWj2aFfNtf5TRQHDnRgOJSFbhkkbWXcdvsTfv
Tm/WladCOvfg+NZF9M901f5bR3qTZ1CM2A51byZwNDiex88N7krmCQBTf6nq9dmN
Ya6lhFjKRHCHA5k1rPWc+KZcZzrYN7hHB89TJp0QPinS3QFYB5fME1tt27/CDcAH
tAOEtrPIYIBueDPCHTH2WZ2aGlrf4FxdFF77KYjuyRNk4A1UzIqVF0LGFiWo+s5W
WeQeBhAq5YOMbtZBzHgS30+dnZFGpra8f0JkLiIpTFArinAchc06IMU57aH4p3I=
=z2AN
-----END PGP SIGNATURE-----

--7DO5AaGCk89r4vaK--
