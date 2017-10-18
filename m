Received: from eggs.gnu.org ([2001:4830:134:3::10]:39881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4pQO-0002n0-DA
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4pQK-0008IH-EO
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:34:24 -0400
References: <cover.1508257445.git.jcody@redhat.com>
	<b5a8ed05e7dab4d1400b12cf746cc6ef7243f870.1508257445.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <96c037b7-fd29-6ef1-595c-13c7dd048d79@redhat.com>
Date: Wed, 18 Oct 2017 09:33:45 -0500
MIME-Version: 1.0
In-Reply-To: <b5a8ed05e7dab4d1400b12cf746cc6ef7243f870.1508257445.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="C7NnEqPn48OpLJSslKMhd3bIpMSpPF8vd"
Subject: Re: [Qemu-devel] [PATCH v5 09/10] qemu-iotests: add option to save
 temp files on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C7NnEqPn48OpLJSslKMhd3bIpMSpPF8vd
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com,
 kwolf@redhat.com
Message-ID: <96c037b7-fd29-6ef1-595c-13c7dd048d79@redhat.com>
Subject: Re: [PATCH v5 09/10] qemu-iotests: add option to save temp files on
 error
References: <cover.1508257445.git.jcody@redhat.com>
 <b5a8ed05e7dab4d1400b12cf746cc6ef7243f870.1508257445.git.jcody@redhat.com>
In-Reply-To: <b5a8ed05e7dab4d1400b12cf746cc6ef7243f870.1508257445.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/17/2017 11:31 AM, Jeff Cody wrote:
> Now that ./check takes care of cleaning up after each tests, it
> can also selectively not clean up.  Add option to leave all output from=

> tests intact if that test encountered an error.
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  tests/qemu-iotests/check | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index 057ea39..a66f7b0 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -125,6 +125,7 @@ sortme=3Dfalse
>  expunge=3Dtrue
>  have_test_arg=3Dfalse
>  cachemode=3Dfalse
> +save_on_err=3Dfalse
> =20
>  tmp=3D"${TEST_DIR}"/$$
>  rm -f $tmp.list $tmp.tmp $tmp.sed
> @@ -263,6 +264,8 @@ other options
>      -o options          -o options to pass to qemu-img create/convert
>      -T                  output timestamps
>      -c mode             cache mode
> +    -s                  save test scratch directory on test failure

Is there an easy way to force all tests to fail (and thus preserve the
scratch directory for inspection, even though the test normally would
succeed)?  It might serve as a useful double-check that you got
everything in this series, maybe even worth documenting in the commit
messages.

> +
> +        if [ "$save_on_err" !=3D "true" ] || [ "$err" !=3D "true" ]
> +        then
> +            rm -rf "$TEST_DIR_SEQ"
> +        fi

I suppose the easiest way is to hack this 'if'.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--C7NnEqPn48OpLJSslKMhd3bIpMSpPF8vd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnnZkkACgkQp6FrSiUn
Q2rdIgf+Pxo4SghxBczRPGtPszRpXMcDzqkQaWifDQFzjYgFL2TS49K/rROmAHR6
7hMSWmyC9CFvFiXtX62v0L22yw2ypSX5SwmKjdD2KoDwdMyI+2BnrEg7M0lcSsOW
KZXatHKGWxj0JzqCzfQY+KAb7rJdEgd7n11Jx4eYN3xMES/qnLSxqRmyvFF+gPdG
F9rusn+uuuP/2Ez5Qb7EXSjMZYOmcgGJo6pdhpGBXMUV9MkRzIeVihlLW/Bbi6gT
xMyoyBNM6NsWeNVC2MjvKAmG15p7S+BGFRnBHdD0A9E1ryEVFFIgm+xW3oJiJJZx
C4gn+DnuG9Bsva2LGZsFpB7udCN0dw==
=0yzv
-----END PGP SIGNATURE-----

--C7NnEqPn48OpLJSslKMhd3bIpMSpPF8vd--
