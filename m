Received: from eggs.gnu.org ([2001:4830:134:3::10]:41376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9K5E-0002QX-DK
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 21:11:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9K5D-0004EB-CG
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 21:11:40 -0400
References: <cover.1537367701.git.berto@igalia.com>
	<57d02fc28b31eebda8ee6d751587c5f25ebf5af0.1537367701.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4e4ca291-dda0-c665-b61c-83bdca930d1f@redhat.com>
Date: Mon, 8 Oct 2018 03:11:23 +0200
MIME-Version: 1.0
In-Reply-To: <57d02fc28b31eebda8ee6d751587c5f25ebf5af0.1537367701.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6AyPaR8kw06GIekbpSF3uqu4fobmJu4vB"
Subject: Re: [Qemu-devel] [PATCH 04/14] block: Use
 bdrv_reopen_set_read_only() in commit_start/complete()
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
--6AyPaR8kw06GIekbpSF3uqu4fobmJu4vB
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <4e4ca291-dda0-c665-b61c-83bdca930d1f@redhat.com>
Subject: Re: [PATCH 04/14] block: Use bdrv_reopen_set_read_only() in
 commit_start/complete()
References: <cover.1537367701.git.berto@igalia.com>
 <57d02fc28b31eebda8ee6d751587c5f25ebf5af0.1537367701.git.berto@igalia.com>
In-Reply-To: <57d02fc28b31eebda8ee6d751587c5f25ebf5af0.1537367701.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.09.18 16:47, Alberto Garcia wrote:
> This patch replaces the bdrv_reopen() calls that set and remove the
> BDRV_O_RDWR flag with the new bdrv_reopen_set_read_only() function.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/commit.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)

Will need a rebase on 22dffcbec62ba918db690ed44beba4bd4e970bb9, but that
looks like a rather simple job, so:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--6AyPaR8kw06GIekbpSF3uqu4fobmJu4vB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu6rrsACgkQ9AfbAGHV
z0DCDAf/QaMAXRiV0fHgpSNveCKGlTzc7JMj4Xx3JHV4a+E6vzlIV5my6UlIE4ln
PAfQdGeqt68ZPMR5DbZFWkGQ+67XQ/xI2cbzhDKOjShYpAHmDwi/vxfrTPWGGIcO
NkGMRbPhxm1UbFvSskip7EZzbEz8eIEVi28xcFApH6bDI90ANKBEWZgw/ItgtBKh
1/pEEcnSHdcypgAIpv+EjZquCuPvR0KPAk1HMyK9+l0iCvo9jz6OGmpVu9YtN0Rf
syKAGenCaunsVdlsLjQyYgfXgaHBpgwBWMabVnAaccR/hZyLJ6IPUkvPS84DdEwn
fC+drU+ym7fMoBBoX6Zt1+s7Xk6I6Q==
=fnMX
-----END PGP SIGNATURE-----

--6AyPaR8kw06GIekbpSF3uqu4fobmJu4vB--
