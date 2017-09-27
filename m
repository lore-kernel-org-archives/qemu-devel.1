Received: from eggs.gnu.org ([2001:4830:134:3::10]:43292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxJv3-0005Fd-Tm
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 17:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxJv3-0007aJ-1S
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 17:31:01 -0400
References: <20170927211334.3988-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0d109afc-c083-7488-8979-21a112ea6031@redhat.com>
Date: Wed, 27 Sep 2017 16:30:53 -0500
MIME-Version: 1.0
In-Reply-To: <20170927211334.3988-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FQNvofBVT2rDEl87evcSjgfmNnV5JHJv8"
Subject: Re: [Qemu-devel] [PATCH] iotests: Fix 195 if IMGFMT is part of
 TEST_DIR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FQNvofBVT2rDEl87evcSjgfmNnV5JHJv8
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <0d109afc-c083-7488-8979-21a112ea6031@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Fix 195 if IMGFMT is part of
 TEST_DIR
References: <20170927211334.3988-1-mreitz@redhat.com>
In-Reply-To: <20170927211334.3988-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/27/2017 04:13 PM, Max Reitz wrote:
> do_run_qemu() in iotest 195 first applies _filter_imgfmt when printing
> qemu's command line and _filter_testdir only afterwards.  Therefore, if=

> the image format is part of the test directory path, _filter_testdir
> will no longer apply and the actual output will differ from the
> reference output even in case of success.
>=20
> For example, TEST_DIR might be "/tmp/test-qcow2", in which case
> _filter_imgfmt first transforms this to "/tmp/test-IMGFMT" which is no
> longer recognized as the TEST_DIR by _filter_testdir.
>=20
> Fix this by not applying _filter_imgfmt in do_run_qemu() but in
> run_qemu() instead, and only after _filter_testdir.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/195 | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--FQNvofBVT2rDEl87evcSjgfmNnV5JHJv8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnMGI0ACgkQp6FrSiUn
Q2p2fQf/bsKIHmo6lBbLGTX/B1OG+7yi9GuI0Q7tsfC1mbSj2jaCW5vtcqnNvHHu
eEQpISGd0poHFSBqsuyr0KV2qi2wBqyftDVkGF8YxEtH103lbkIxOGfvNguNZzSf
WLXvDIHFderkePt91QLhDlRSClWGXPC27oBcI2ua/1zg31LYUriYGcUQYW71P3tG
7POhYXcZzuMaf5fj3ji8a8pVdo7dyCCjJY0E5avvl3N6uARd4AqfsTpziqpQUHVT
CgAajcpxhlxuMVukOKjvlqb6T3EYcwLVr5h3e9h+on/cFsbab53QmwuIpRrpdaIZ
bPNxC2+GgfP9NYLTL5lTKpY7IPgCdg==
=sMIE
-----END PGP SIGNATURE-----

--FQNvofBVT2rDEl87evcSjgfmNnV5JHJv8--
