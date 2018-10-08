Received: from eggs.gnu.org ([2001:4830:134:3::10]:43260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9KEn-0006R3-7N
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 21:21:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9KEm-0003Ev-Jp
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 21:21:33 -0400
References: <cover.1537367701.git.berto@igalia.com>
	<5f1c063ccfaf20fde5d1334652648f054b0f9d8a.1537367701.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <45cbf1b9-c9d3-3894-b45c-2dbc704d11f8@redhat.com>
Date: Mon, 8 Oct 2018 03:21:22 +0200
MIME-Version: 1.0
In-Reply-To: <5f1c063ccfaf20fde5d1334652648f054b0f9d8a.1537367701.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AIV4YHjJjLVK4qoSGYddtzaKEcHep77ym"
Subject: Re: [Qemu-devel] [PATCH 06/14] block: Use
 bdrv_reopen_set_read_only() in stream_start/complete()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AIV4YHjJjLVK4qoSGYddtzaKEcHep77ym
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <45cbf1b9-c9d3-3894-b45c-2dbc704d11f8@redhat.com>
Subject: Re: [PATCH 06/14] block: Use bdrv_reopen_set_read_only() in
 stream_start/complete()
References: <cover.1537367701.git.berto@igalia.com>
 <5f1c063ccfaf20fde5d1334652648f054b0f9d8a.1537367701.git.berto@igalia.com>
In-Reply-To: <5f1c063ccfaf20fde5d1334652648f054b0f9d8a.1537367701.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.09.18 16:47, Alberto Garcia wrote:
> This patch replaces the bdrv_reopen() calls that set and remove the
> BDRV_O_RDWR flag with the new bdrv_reopen_set_read_only() function.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/stream.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

In anticipation of a rebase on 1b57488acf1:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--AIV4YHjJjLVK4qoSGYddtzaKEcHep77ym
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu6sRIACgkQ9AfbAGHV
z0CenQf+PUIA2tW2+s3ytIAi1cYzCf/QCfYGHUY+MUKPKiyMIxf2FbNJvyTCco/H
Ep/joUrtNcoKDR9ZPLwA3JqhPrmFpznNDIw+L+GPRK2XvQQN5Ww7CPeveOrkCbK1
3w4UR3F78DXh+4v9oE3YzqGIVvQe8wzEtjX1tyS2wSX4+oMSK9z20dwxIPY4/R0b
7SutqX9eNqM710l+YChpATPOxJm3AkMfXsmQ8sQ7GLm+hDIpFEYbbiet85VXm2B8
uEdKsDyqRebdmP3ONtGJW5nFdfXS7UZU8J7EcK7rxqxqW23M36+l/oLRVhewNFwk
FHg51Y9bgK5T/y4lFT9BUaOdULrO1w==
=/CJt
-----END PGP SIGNATURE-----

--AIV4YHjJjLVK4qoSGYddtzaKEcHep77ym--
