Received: from eggs.gnu.org ([2001:4830:134:3::10]:39666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dLSLW-00069D-5g
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dLSLS-0006Ia-AQ
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:49:50 -0400
Date: Thu, 15 Jun 2017 11:49:43 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170615104943.GC27346@stefanha-x1.localdomain>
References: <20170613211612.9368-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
Content-Disposition: inline
In-Reply-To: <20170613211612.9368-1-berto@igalia.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] throttle: Update
 throttle-groups.c documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2017 at 12:16:12AM +0300, Alberto Garcia wrote:
> There used to be throttle_timers_{detach,attach}_aio_context() calls
> in bdrv_set_aio_context(), but since 7ca7f0f6db1fedd28d490795d778cf239
> they are now in blk_set_aio_context().
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/throttle-groups.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZQmZHAAoJEJykq7OBq3PI6NoIAL5ArSfe9bL3kdcRxAMmnuSi
8mRYTZ3V8fggaxH0M2xdL58zioyzRV1L3HQioKDgi/LqDIGtOZKnrhIj1LlEpFQj
LdPfwwgKkpYnI9nNauGelGkEpEHBEOmJ+nxryfEhSmoYaQkRBWJPZmmjWPrgs7Fz
79Hq/yy8+8Tz4NIiX/CbHRLN2m4vryz3ccyeGRFqHMUYM3P0sItKJ2mHuaPFWOKb
AxU5QH4PSIf58hWk8RUi7L/EsGfhEDUXZUT2lN/PRKE2obK76PQ3x2oUkdz17QY4
jRpEqsZK+gdGs971xCJxjQZVlQdD25vJZ1btB4sF+Urj/Mteb97WsVUkSphRke8=
=CQOq
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--
