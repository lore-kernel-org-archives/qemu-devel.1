Received: from eggs.gnu.org ([2001:4830:134:3::10]:44907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9KW7-0000ZL-3x
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 21:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9KOD-0000ck-EG
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 21:31:18 -0400
References: <cover.1537367701.git.berto@igalia.com>
	<8f8a151dae565027208268ed8d120e4612ef5f9f.1537367701.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2e99d517-ae42-0692-fe6e-66de36f73c9d@redhat.com>
Date: Mon, 8 Oct 2018 03:31:08 +0200
MIME-Version: 1.0
In-Reply-To: <8f8a151dae565027208268ed8d120e4612ef5f9f.1537367701.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8MLtdDq1JPcEB77Co6fEMJ3t8LTYT0Avx"
Subject: Re: [Qemu-devel] [PATCH 08/14] block: Use
 bdrv_reopen_set_read_only() in external_snapshot_commit()
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
--8MLtdDq1JPcEB77Co6fEMJ3t8LTYT0Avx
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <2e99d517-ae42-0692-fe6e-66de36f73c9d@redhat.com>
Subject: Re: [PATCH 08/14] block: Use bdrv_reopen_set_read_only() in
 external_snapshot_commit()
References: <cover.1537367701.git.berto@igalia.com>
 <8f8a151dae565027208268ed8d120e4612ef5f9f.1537367701.git.berto@igalia.com>
In-Reply-To: <8f8a151dae565027208268ed8d120e4612ef5f9f.1537367701.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.09.18 16:47, Alberto Garcia wrote:
> This patch replaces the bdrv_reopen() calls that set and remove the
> BDRV_O_RDWR flag with the new bdrv_reopen_set_read_only() function.

Ha!  Got you!  It's just one call this time, not "calls"! :-)

> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  blockdev.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--8MLtdDq1JPcEB77Co6fEMJ3t8LTYT0Avx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu6s1wACgkQ9AfbAGHV
z0BUXAgAxEkYjnEofd488cJ9W47imfX2X4Mvb0+25+TXci7Rvub9oiERHxqGYvYR
Jtr8IqWM08CX/1zVUDHr0CWNuP3oPGsuc9DIINIMME2UQ4yBTmlmjt9kRMi28blu
tCBRhtC7f1FoScgwt1+oz8COHN6UiXd/rf/I4yhRFBnPhcy0y8qE0IMeKEGGtzz8
e3qeKoH2I3W4O6nhL84myFimvEdZQQrw8DzA1hrrIYVZzFYT23HD2Oi2rhMltUvt
fuD9JCFpasEgOc1XahX5qJb45Q2T+VwbvQZLMO/qsI/2b909+dgHGTekXrO84u3f
oLXHT1RHcGu07KH82aFRGEX9/Xh+9Q==
=cQzU
-----END PGP SIGNATURE-----

--8MLtdDq1JPcEB77Co6fEMJ3t8LTYT0Avx--
