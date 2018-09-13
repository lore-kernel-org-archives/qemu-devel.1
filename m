Received: from eggs.gnu.org ([2001:4830:134:3::10]:39937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0ZoD-0001PX-DO
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 18:10:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0Zny-00076D-R8
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 18:09:47 -0400
References: <20180913125217.23173-1-kwolf@redhat.com>
	<20180913125217.23173-18-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b37355fc-855e-cc6c-a2e7-170f9fee6a07@redhat.com>
Date: Fri, 14 Sep 2018 00:05:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180913125217.23173-18-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="neEaYCIYR4xnAcl5mx9CejrEJXZAEnyMT"
Subject: Re: [Qemu-devel] [PATCH v2 17/17] test-bdrv-drain: AIO_WAIT_WHILE()
 in job .commit/.abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--neEaYCIYR4xnAcl5mx9CejrEJXZAEnyMT
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <b37355fc-855e-cc6c-a2e7-170f9fee6a07@redhat.com>
Subject: Re: [PATCH v2 17/17] test-bdrv-drain: AIO_WAIT_WHILE() in job
 .commit/.abort
References: <20180913125217.23173-1-kwolf@redhat.com>
 <20180913125217.23173-18-kwolf@redhat.com>
In-Reply-To: <20180913125217.23173-18-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.09.18 14:52, Kevin Wolf wrote:
> This adds tests for calling AIO_WAIT_WHILE() in the .commit and .abort
> callbacks. Both reasons why .abort could be called for a single job are=

> tested: Either .run or .prepare could return an error.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/test-bdrv-drain.c | 116 ++++++++++++++++++++++++++++++++++++++++=
+++-----
>  1 file changed, 104 insertions(+), 12 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--neEaYCIYR4xnAcl5mx9CejrEJXZAEnyMT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlua3zwACgkQ9AfbAGHV
z0A0owf/en0B+XBRKmVQZ9zvCi5aKyqwUK1wwzvQZiZBVT4jQypmachYO8IC40t7
pLnCpatNzCL76QMdwpKS2sG3JKpg1nwTtSM5v3892Y70XbXHZ07qNxlCHCKKxrL9
z/howeeHxdun/71vhfJ6JvyMHOvoot5l+EDZTOEsHt3sb3wZsNOiarSfg5JNK1rN
RmEr3qWyrRXvMgyo9TX1/soJ4mfuNsTVpOI8Z+1N2nrvVZnJE/GyPdiTLagIGOZ6
EFzXf+ISjc7UYgrYciP8Y7Iw9vGFJWJB8CwtKUkpoBPEanj+OTarumrF2jSzjcg1
AU4Y4wofeaLNnCqG06dKS4ngpMdDMQ==
=ts64
-----END PGP SIGNATURE-----

--neEaYCIYR4xnAcl5mx9CejrEJXZAEnyMT--
