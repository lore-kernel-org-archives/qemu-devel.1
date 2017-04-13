Received: from eggs.gnu.org ([2001:4830:134:3::10]:40043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cylVq-0006Su-M2
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 16:38:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cylVp-0006tR-Ok
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 16:38:42 -0400
References: <20170207235757.2026-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <efaef6ef-a1a5-a767-72a6-8c93ba0d9dd1@redhat.com>
Date: Thu, 13 Apr 2017 22:38:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170207235757.2026-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NQsnBKIP6LIvC0FK0mNTsVJ7KNM7xbNCQ"
Subject: Re: [Qemu-devel] [PATCH] progress: Show current progress on SIGINFO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NQsnBKIP6LIvC0FK0mNTsVJ7KNM7xbNCQ
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <efaef6ef-a1a5-a767-72a6-8c93ba0d9dd1@redhat.com>
Subject: Re: [PATCH] progress: Show current progress on SIGINFO
References: <20170207235757.2026-1-mreitz@redhat.com>
In-Reply-To: <20170207235757.2026-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.02.2017 00:57, Max Reitz wrote:
> Currently we only print progress information on retrieval of SIGUSR1.
> Some systems have a dedicated SIGINFO for this, however, so it should b=
e
> handled appropriately if it is available.
>=20
> Buglink: https://bugs.launchpad.net/qemu/+bug/1662468
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> Can anyone test this on a BSD system? O:-)
> ---
>  util/qemu-progress.c | 3 +++
>  qemu-img.texi        | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)

Ping

(If nobody replies in the next month or so, I'm just going to merge
this, as util/qemu-progress.c doesn't have a maintainer.)


--NQsnBKIP6LIvC0FK0mNTsVJ7KNM7xbNCQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljv4ckSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AY9sH/1EDuJ8TxUT8EkjNOWBQajnRvjSA4WeP
XqVTAvgPTSSq0xq5jJNXHiTT25bjIcBcr51QoImlPwib+lR/Wd4VBBJBYzGbOae5
i16Tnz1/OjQhTpCtde2CvXV75iGpGSbfcEqhGjzLW5Mmzu782pFYobzUB/IrawuG
J7g6Akcq2LuJQKxG2+gz+Mt+VvY/Ewz3gRJjf8AQVcUljWpkFblYsflCD8Oj9bfD
s1qcJm56UROQG+snFIrb3pOxVYYraBhll9oeKy6u9zLPzmyZ99uakO+Ct8H7RNr9
Y7J0B0iI3lGJimiHWyYGHkHbIZkEc//FFlzrW6FHYglPt5QWr/cDdjY=
=MEsR
-----END PGP SIGNATURE-----

--NQsnBKIP6LIvC0FK0mNTsVJ7KNM7xbNCQ--
