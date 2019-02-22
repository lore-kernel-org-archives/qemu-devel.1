Received: from eggs.gnu.org ([209.51.188.92]:39340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gxCPc-0007uc-HW
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:06:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gxCPa-00065O-9f
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:06:52 -0500
References: <20190220145819.30969-1-berrange@redhat.com>
	<20190220145819.30969-2-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1b7cca35-0764-c365-169e-f46c033bd2e2@redhat.com>
Date: Fri, 22 Feb 2019 16:06:32 +0100
MIME-Version: 1.0
In-Reply-To: <20190220145819.30969-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4NJB1qu3oOAgecCgAmrG8YOJHmWlWMnzM"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] iotests: ensure we print nbd server
 log on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4NJB1qu3oOAgecCgAmrG8YOJHmWlWMnzM
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <1b7cca35-0764-c365-169e-f46c033bd2e2@redhat.com>
Subject: Re: [PATCH v2 1/2] iotests: ensure we print nbd server log on error
References: <20190220145819.30969-1-berrange@redhat.com>
 <20190220145819.30969-2-berrange@redhat.com>
In-Reply-To: <20190220145819.30969-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20.02.19 15:58, Daniel P. Berrang=C3=A9 wrote:
> If we abort the iotest early the server.log file might contain useful
> information for diagnosing the problem. Ensure its contents are
> displayed in this case.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  tests/qemu-iotests/233 | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/233 b/tests/qemu-iotests/233
> index fc345a1a46..27932df075 100755
> --- a/tests/qemu-iotests/233
> +++ b/tests/qemu-iotests/233
> @@ -30,6 +30,8 @@ _cleanup()
>  {
>      nbd_server_stop
>      _cleanup_test_img
> +    # If we aborted early we want to see this log for diagnosis
> +    test -f "$TEST_DIR/server.log" && cat "$TEST_DIR/server.log"
>      rm -f "$TEST_DIR/server.log"
>      tls_x509_cleanup
>  }
> @@ -120,6 +122,7 @@ $QEMU_IO -f $IMGFMT -r -U -c 'r -P 0x22 1m 1m' "$TE=
ST_IMG" | _filter_qemu_io
>  echo
>  echo "=3D=3D final server log =3D=3D"
>  cat "$TEST_DIR/server.log"
> +rm -f $TEST_DIR/server.log

I'm not sure how well the iotests currently cope with spaced dir names
anyway, but it looks weird to not use quotes here right after a line
that does.

Max

> =20
>  # success, all done
>  echo "*** done"
>=20



--4NJB1qu3oOAgecCgAmrG8YOJHmWlWMnzM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxwD/gACgkQ9AfbAGHV
z0Am1Af7BvIOOZFx+KRJNLHwaFWyuQNNah9LYpCcaggxa63SmolehoUgH+EaENxa
FbBSu9wP8YvKy80Zq0jEZdyeKR0vBPIm7Byyf5aMRvBW59qVHgFq6RyWGbMcchXF
okUJqNpqeWveEBrqhSofj7Fqvw+JKwWMNHMNBxVXkB80G8rQuJslOcAJxx4goKsZ
bog8jXhlNfY/EwoZ95A2n+N+PhvsoFoJRKI9T8/95pb9r7Rj5TDwiz2SAc+fuBRy
9aFdmZzdi4xx2kgPXAyk9Ti3zfyuY5j4ycPEmsBA/wY5dMo7aoUNK/eCUV9P7P2P
eTZpheXo5vrbhQ6lav2utcdc/JuB4g==
=6TZz
-----END PGP SIGNATURE-----

--4NJB1qu3oOAgecCgAmrG8YOJHmWlWMnzM--
