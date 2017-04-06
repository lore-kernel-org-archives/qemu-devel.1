Received: from eggs.gnu.org ([2001:4830:134:3::10]:52362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cw9pG-0000DF-1n
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:59:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cw9pC-0003FL-UV
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:59:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cw9pC-0003Er-OP
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:59:54 -0400
Date: Thu, 6 Apr 2017 16:59:52 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170406155952.GF31259@stefanha-x1.localdomain>
References: <1491405126-30591-1-git-send-email-den@openvz.org>
	<1491405126-30591-3-git-send-email-den@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Wb5NtZlyOqqy58h0"
Content-Disposition: inline
In-Reply-To: <1491405126-30591-3-git-send-email-den@openvz.org>
Subject: Re: [Qemu-devel] [PATCH 2/2] parallels: relax check for auto switch
 of prealloc_mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org


--Wb5NtZlyOqqy58h0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 06:12:06PM +0300, Denis V. Lunev wrote:
> PRL_PREALLOC_MODE_TRUNCATE can be set only through command line. Remove
> the check that bdrv_truncate() is working on, this is almost always the
> case, while the check could lead to serious consequences during migration
> etc when we should not even try to API which technically could change the
> image (asserts are possible).
>=20
> Let us keep this simple.
>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/parallels.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Wb5NtZlyOqqy58h0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY5mX3AAoJEJykq7OBq3PITfgIAIZsGa6UUWEul7BjKrLveXis
526hfpgmFSmJ1jLn4yQjURCHtqSScT1cgnHgGcYNU4iIeDtHc7oEIEruQrdtrdL3
Qx9Zi+pQPay4kQJ+kGTDVA/DEJ8rS4aYEMn0zvbJ6/yQ978n6Y+Rr6gQa3Qrnf36
k1a/fcK6gml4yXA2/v8VqPyFpFPt8l41HCRld7PGPdcGkgI0osqsuGj0k+NLXXCh
EKhfHhDVYq52Av24RpwMaJz/pM1hR2wKTuJyqAj+nWD1nq+U5ivN9FR7e2/knNQJ
V8g3NXdueXJipde1l91PQh9SrdCNNoXIjTLLKQOF+ZuO/4TmhgbbuPe/HM0LHkU=
=N+c7
-----END PGP SIGNATURE-----

--Wb5NtZlyOqqy58h0--
