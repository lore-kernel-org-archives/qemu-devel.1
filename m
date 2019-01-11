Received: from eggs.gnu.org ([209.51.188.92]:53184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghxvQ-0004Ia-Ce
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:36:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghxvP-0004GI-Ob
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:36:44 -0500
References: <1542006398-30037-1-git-send-email-marcolso@amazon.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <34d19406-8ead-8168-18f6-453a822e5de2@redhat.com>
Date: Fri, 11 Jan 2019 15:36:25 +0100
MIME-Version: 1.0
In-Reply-To: <1542006398-30037-1-git-send-email-marcolso@amazon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RTw6XJABWNvZLkLRBc3essqW5UdEIqDqi"
Subject: Re: [Qemu-devel] [PATCH v3 1/3] blkdebug: fix one shot rule
 processing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc Olson <marcolso@amazon.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RTw6XJABWNvZLkLRBc3essqW5UdEIqDqi
From: Max Reitz <mreitz@redhat.com>
To: Marc Olson <marcolso@amazon.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <34d19406-8ead-8168-18f6-453a822e5de2@redhat.com>
Subject: Re: [PATCH v3 1/3] blkdebug: fix one shot rule processing
References: <1542006398-30037-1-git-send-email-marcolso@amazon.com>
In-Reply-To: <1542006398-30037-1-git-send-email-marcolso@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.11.18 08:06, Marc Olson wrote:
> If 'once' is specified, the rule should execute just once, regardless i=
f
> it is supposed to return an error or not. Take the example where you
> want the first IO to an LBA to succeed, but subsequent IOs to fail. You=

> could either use state transitions, or create two rules, one with
> error =3D 0 and once set to true, and one with a non-zero error.
>=20
> Signed-off-by: Marc Olson <marcolso@amazon.com>
> ---
>  block/blkdebug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I don't quite see the point, because the example in the commit message
clearly should be done with a state transition, but the code change
looks reasonable, so:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--RTw6XJABWNvZLkLRBc3essqW5UdEIqDqi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw4qekACgkQ9AfbAGHV
z0AKsQgAwgYiEPHLPXKFERNKQ6SJxj2+fARFyW3Xe6Vdh03nXL7y0K4CBfb1dE+G
xZhe32qVPr1EMhKW8NvHGqOve9eLAbKKX2XwmGPPy3bgDkci9GGB/n7tp3LHHE/H
F8u22nF38DEHqH5zSELSpaqOlV6U1u2HEdVN/kqE/ogHsb/xwKzRdf4cYQI7C5VA
Wn/y3vyZBxrEBjryyW23euxEkXCRlFVQsqCvemlRg8B9p80lBjPKH5IVw1oAvxwP
UFOHY0hrz0SHzeYjlb2VYLdDRAhbNbWcQfnvxJ9yN2R7giudbe7MgPZXeRBxKyjP
LdfJKO+Tzpm0XjGMbRQ+YSw5OYcJUQ==
=J1V7
-----END PGP SIGNATURE-----

--RTw6XJABWNvZLkLRBc3essqW5UdEIqDqi--
