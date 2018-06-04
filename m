Received: from eggs.gnu.org ([2001:4830:134:3::10]:53401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fPmjG-0006H8-EX
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fPmjF-0007rP-Io
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:28:46 -0400
References: <20180601141223.26630-1-peter.maydell@linaro.org>
	<20180601141223.26630-4-peter.maydell@linaro.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8279dc88-50d6-80d1-2a92-117a3fc2703c@redhat.com>
Date: Mon, 4 Jun 2018 12:28:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180601141223.26630-4-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0fUIZhsaByEFeqKZfMFvcGaNzoDZMpm6N"
Subject: Re: [Qemu-devel] [PATCH 3/6] hw/block/pflash_cfi02: Convert away
 from old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>, qemu-block@nongnu.org, Yongbok Kim <yongbok.kim@mips.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0fUIZhsaByEFeqKZfMFvcGaNzoDZMpm6N
From: Max Reitz <mreitz@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Kevin Wolf <kwolf@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-block@nongnu.org, Yongbok Kim <yongbok.kim@mips.com>
Message-ID: <8279dc88-50d6-80d1-2a92-117a3fc2703c@redhat.com>
Subject: Re: [PATCH 3/6] hw/block/pflash_cfi02: Convert away from old_mmio
References: <20180601141223.26630-1-peter.maydell@linaro.org>
 <20180601141223.26630-4-peter.maydell@linaro.org>
In-Reply-To: <20180601141223.26630-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-01 16:12, Peter Maydell wrote:
> Convert the pflash_cfi02 device away from using the old_mmio field
> of MemoryRegionOps.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/block/pflash_cfi02.c | 97 ++++++++---------------------------------=

>  1 file changed, 18 insertions(+), 79 deletions(-)

Acked-by: Max Reitz <mreitz@redhat.com>


--0fUIZhsaByEFeqKZfMFvcGaNzoDZMpm6N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsVFFMACgkQ9AfbAGHV
z0CjsQf+NJknhruNL/HpiUsF2Lc2DbP1HMcbXu1pyLr6so7aDPVec/HsGoGnqe0b
qFuT7ZKZEF5GZI6n65RmzPOH03a6avdnwse6+bWITl6wnjQz3lx4ZVnYHpOc3lbk
CjhwPPGiY5YGjgLmye8/jmoURc9hgkH6HbxuO7xao4Mj+jOC6F+ls2iKKwsXKbRp
j/Y3k8D0z77dzXB05+KG9Ts6Ntgqtxa3qJOfrX+f24QYf+wsm6j79VVcvm4hutNW
LQhPWm8ZU6DAJoOG2PdRypla47h5RlIS12U1NFJ7RdD3aZlSE+rWWbFzecOKkdRx
mFmSJ2tshiUYqkFlPKKxs1t5JduUqg==
=eIMl
-----END PGP SIGNATURE-----

--0fUIZhsaByEFeqKZfMFvcGaNzoDZMpm6N--
