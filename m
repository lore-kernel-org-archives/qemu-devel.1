Received: from eggs.gnu.org ([2001:4830:134:3::10]:59168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dG71n-0006CT-Hq
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:03:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dG71m-0006gx-ON
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:03:23 -0400
References: <1496224367-24935-1-git-send-email-kwolf@redhat.com>
	<1496224367-24935-5-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b50b7d41-684a-023d-e1f2-d25233140d9f@redhat.com>
Date: Wed, 31 May 2017 12:03:15 -0500
MIME-Version: 1.0
In-Reply-To: <1496224367-24935-5-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pluowwwSjlEE18GkGl7Mkoib1aJP26XRb"
Subject: Re: [Qemu-devel] [PATCH v3 4/4] qemu-iotests: Block migration test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pluowwwSjlEE18GkGl7Mkoib1aJP26XRb
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, qemu-devel@nongnu.org
Message-ID: <b50b7d41-684a-023d-e1f2-d25233140d9f@redhat.com>
Subject: Re: [PATCH v3 4/4] qemu-iotests: Block migration test
References: <1496224367-24935-1-git-send-email-kwolf@redhat.com>
 <1496224367-24935-5-git-send-email-kwolf@redhat.com>
In-Reply-To: <1496224367-24935-5-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/31/2017 04:52 AM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/183     | 140 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/183.out |  46 +++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 187 insertions(+)
>  create mode 100755 tests/qemu-iotests/183
>  create mode 100644 tests/qemu-iotests/183.out

> +qemu_comm_method=3D"qmp"
> +
> +_launch_qemu \
> +    -drive file=3D"${TEST_IMG}",cache=3D${CACHEMODE},driver=3D$IMGFMT,=
id=3Ddisk

Inconsistent use of ${CACHEMODE} vs. $IMGFMT (I prefer the version with
less typing, but others prefer always using ${}).  In both _launch_qemu
lines.  Up to you if you want to tweak it, but either way,

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pluowwwSjlEE18GkGl7Mkoib1aJP26XRb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLvdTAAoJEKeha0olJ0NqJMYIAJEhBWKjSZN9WIaHMXWOz5K1
fHZ3Ucfhk1sXBM9XKc9ptqk4Vty0m4ZMpRP0+7MS0hZQS2ZIkRHBXaOI0AzZQ5JU
L9h4j91LoHAWJKj3ld0KGl3R3bXWFD09r2Jw2c+AKErhPCLixSJ9RWPmp+iFb4Ml
6ro4p3bK+CQGvjfcl9yTWjjqORex/al2U3YlqlxprpaJriBA7Tgs4d5IGz/Tzkf5
6yLp44VUr/XpN58/DQ/SUGhp7xsSdFkQMFKQOr/LCgfeyn8MrUbbQkQs++S/xsmH
H+YrZkZ17mZuSJn0Gstudooi3gmGHuW5FNnk7CPoSxgkJAkWhQISpfUoRjImnJY=
=Fd40
-----END PGP SIGNATURE-----

--pluowwwSjlEE18GkGl7Mkoib1aJP26XRb--
