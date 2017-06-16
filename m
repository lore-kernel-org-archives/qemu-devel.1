Received: from eggs.gnu.org ([2001:4830:134:3::10]:50418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dLnLi-0004Gx-Ph
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dLnLg-0007es-4v
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:15:26 -0400
Date: Fri, 16 Jun 2017 10:15:20 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170616091520.GE31462@stefanha-x1.localdomain>
References: <20170615195209.17720-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jKBxcB1XkHIR0Eqt"
Content-Disposition: inline
In-Reply-To: <20170615195209.17720-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] nbd: fix NBD over TLS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, qemu-stable@nongnu.org, qemu-block@nongnu.org


--jKBxcB1XkHIR0Eqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2017 at 09:52:09PM +0200, Paolo Bonzini wrote:
> When attaching the NBD QIOChannel to an AioContext, the TLS channel should
> be used, not the underlying socket channel.  This is because, trivially,
> the TLS channel will be the one that we read/write to and thus the one
> that will get the qio_channel_yield() call.
>=20
> Fixes: ff82911cd3f69f028f2537825c9720ff78bc3f19
> Cc: qemu-stable@nongnu.org
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/nbd-client.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--jKBxcB1XkHIR0Eqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZQ6GoAAoJEJykq7OBq3PIWDQH/1a0QgULx4eLVefaZeFmgSmy
NXN8YXrH+V4svgFGXmf34MRjik1UbNirN1kixUW0BzU0CpplXoMl79F1DfzJX2lq
OQSLfHInB+I678xUcMXih4Mw/H5IjYTPyRcCiamdhU21gHigTebDhqNTPCRo3G8e
StFrXeObzrz6lZWmYXbhfughIAGrYF189gpTVPq7SlbTWdIicHVgvibxzzenCSMU
zM7TobLL0m9X5zrC1rvDyLiKs6TabW4FKgAkiG2ZtWZyvEe84+MnZjPrifVRpL6V
rCzoUvjalz7x7nMd1ObAleK1fRvMxrLG6wpNP/Dbksh03bJ0HrA2BVC6gX0PUIg=
=F9YM
-----END PGP SIGNATURE-----

--jKBxcB1XkHIR0Eqt--
