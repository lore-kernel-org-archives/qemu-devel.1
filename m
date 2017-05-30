Received: from eggs.gnu.org ([2001:4830:134:3::10]:55202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFjcK-0002r9-MM
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:03:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFjcJ-0006iO-TX
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:03:32 -0400
References: <1496157773-10779-1-git-send-email-kwolf@redhat.com>
	<1496157773-10779-5-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cf160a74-42c3-7387-6b75-8910a9228cdd@redhat.com>
Date: Tue, 30 May 2017 11:03:23 -0500
MIME-Version: 1.0
In-Reply-To: <1496157773-10779-5-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hQ46PhkASGqeeWoqwH5jqlQnNkcof0q94"
Subject: Re: [Qemu-devel] [PATCH v2 4/4] qemu-iotests: Block migration test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hQ46PhkASGqeeWoqwH5jqlQnNkcof0q94
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <cf160a74-42c3-7387-6b75-8910a9228cdd@redhat.com>
Subject: Re: [PATCH v2 4/4] qemu-iotests: Block migration test
References: <1496157773-10779-1-git-send-email-kwolf@redhat.com>
 <1496157773-10779-5-git-send-email-kwolf@redhat.com>
In-Reply-To: <1496157773-10779-5-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 10:22 AM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/183     | 143 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/183.out |  46 +++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 190 insertions(+)
>  create mode 100755 tests/qemu-iotests/183
>  create mode 100644 tests/qemu-iotests/183.out
>=20

In addition to Jeff's review comments:

> +
> +_cleanup()
> +{
> +    rm -f "${MIG_SOCKET}"
> +    rm -f "${TEST_IMG}.dest"
> +	_cleanup_test_img
> +    _cleanup_qemu

Odd indentation.

> +echo
> +echo =3D=3D=3D Do block migration to destination =3D=3D=3D
> +echo
> +
> +reply=3D"$(_send_qemu_cmd $src \
> +    "{ 'execute': 'migrate',
> +       'arguments': { 'uri': 'unix:${MIG_SOCKET}', 'blk': true } }" \
> +    'return\|error')"
> +echo "$reply"
> +if echo "$reply" | grep "compiled without old-style" > /dev/null; then=

> +    _notrun "migrate -b support not compiled in"
> +fi

Oh cool - I didn't realize that _notrun already existed as our way to
skip a test, even if we've already produced unexpected output (if we
ever want to play with exit status 77 in the future for skipped tests,
then _notrun would be a great place to centralize that).

> +
> +while _send_qemu_cmd $src "{ 'execute': 'query-migrate' }" "return"  |=

> +      grep '"status": "active"' > /dev/null
> +do
> +    sleep 0.1

More interesting indentation (I would have probably stuck to 4 spaces on
both lines)

With the nits fixed,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--hQ46PhkASGqeeWoqwH5jqlQnNkcof0q94
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLZfLAAoJEKeha0olJ0NqK0YH/jKodvLe3Rp7atMe63h/Ju2y
027OK1dWSdzxlkuxdRyH3VhidO9rsl2g9CMVcQ4sVpuaKMJzajDZ8y+6yhSnc+Vn
8imCT1hQorS24OmWR8TXParTglHzZHWebAIeRiAMlu28mkQ4O8V0ZP7pBQXeFZxE
z0B71s/T3FKSrPdtRdfUAQbaNcz16Tp7I420UFiBLfl+SX68KvQXFZ0UT3G+c+KO
//95mPakpcJ4vO33vCLm93I8PoJ/osV+5iRAnxjq3mtlN7/jB4a1AFGg2QYHg6H8
xMrd3NA92gRj5qQ68ryUEa6nf5K75JtOQr6TFgH8/1RS7vtyjij16yoCOM1wDHU=
=yVXG
-----END PGP SIGNATURE-----

--hQ46PhkASGqeeWoqwH5jqlQnNkcof0q94--
