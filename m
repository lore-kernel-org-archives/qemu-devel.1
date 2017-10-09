Received: from eggs.gnu.org ([2001:4830:134:3::10]:50262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1gbq-0002Va-Gb
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:33:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1gbp-0001D3-JU
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:33:14 -0400
References: <20171009215533.12530-1-mreitz@redhat.com>
	<20171009215533.12530-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8172fdc2-91cc-7696-abe1-5a5159d226b2@redhat.com>
Date: Mon, 9 Oct 2017 17:32:59 -0500
MIME-Version: 1.0
In-Reply-To: <20171009215533.12530-4-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="m8no2A84Img53M5gmHWINnHxSw3C381HB"
Subject: Re: [Qemu-devel] [PATCH 3/3] iotests: Add cluster_size=64k to 125
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m8no2A84Img53M5gmHWINnHxSw3C381HB
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <8172fdc2-91cc-7696-abe1-5a5159d226b2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] iotests: Add cluster_size=64k to 125
References: <20171009215533.12530-1-mreitz@redhat.com>
 <20171009215533.12530-4-mreitz@redhat.com>
In-Reply-To: <20171009215533.12530-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/09/2017 04:55 PM, Max Reitz wrote:
> Apparently it would be a good idea to test that, too.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/125     |   7 +-
>  tests/qemu-iotests/125.out | 480 +++++++++++++++++++++++++++++++++++++=
+++-----
>  2 files changed, 437 insertions(+), 50 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

The test is already long, and you've doubled its running time.  It's
already not part of CI runs (it's not part of -g quick); but the tests
get run manually by enough developers that it will still be a useful
potential regression catcher.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--m8no2A84Img53M5gmHWINnHxSw3C381HB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnb+RsACgkQp6FrSiUn
Q2ofXwf+NJe5QVFbUoZk1kUXXWkdec6JZG2kkom77RztGZgnhfIEyl1KcHvgiyFB
8/gxpfjtFgmlN96fphGv4IB221iugiPDzrzxsvAe944HxfsAJXFPiv4v8PIgrqvq
hjpQwfir4FcvDAUfffNVE7QKU5bbDsTv25bzcTCsGzesft/zKRIIcllrA/T4L78T
dewy0rWZ9zCdbUSxcp5GdXn2FROapynHWHqWTP4ojjQcpZQDbuQA8e99W84qAApr
xEd4FmG4gfDWc4N8OghgZXPxGhbNnNgSFvd9ww3NKZgSYw0kJiWzzrfwHhBHElSp
w4Ko/x5EQ2D+q/RM/JF5yaGpf8pMIA==
=Sbut
-----END PGP SIGNATURE-----

--m8no2A84Img53M5gmHWINnHxSw3C381HB--
