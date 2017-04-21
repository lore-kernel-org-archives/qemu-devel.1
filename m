Received: from eggs.gnu.org ([2001:4830:134:3::10]:44779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1YbQ-00049i-1Z
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1YbP-0004FO-6x
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:28:00 -0400
References: <1492761662-5644-1-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1f5db49f-0791-44a8-8482-59068eb65b2d@redhat.com>
Date: Fri, 21 Apr 2017 08:27:48 -0500
MIME-Version: 1.0
In-Reply-To: <1492761662-5644-1-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ARog1q0nGwipaawcbfOHbceTwPLWp7LrB"
Subject: Re: [Qemu-devel] [PATCH] qemu_iotests: Remove _readlink()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ARog1q0nGwipaawcbfOHbceTwPLWp7LrB
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <1f5db49f-0791-44a8-8482-59068eb65b2d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu_iotests: Remove _readlink()
References: <1492761662-5644-1-git-send-email-kwolf@redhat.com>
In-Reply-To: <1492761662-5644-1-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/21/2017 03:01 AM, Kevin Wolf wrote:
> It is unused.

Might be worth also mentioning that it was the file's only client of
perl, so removing it also makes it easier to justify removing a check
for $PERL.

>=20
> Suggestetd-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/common.config | 18 ------------------
>  1 file changed, 18 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ARog1q0nGwipaawcbfOHbceTwPLWp7LrB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY+gjUAAoJEKeha0olJ0NqJqAH/itIFEclCGqXeXI3xfvlWH3u
2bTPeYXyhT9UC+wFhC9codx8j17FOQaVAVMvwyuwbgwA46Acphk9sLq3yhngwK9g
+klLFIKphv1NocnGIJZU0AbQ9ku2fkQFLk7xpjyHxcCv2E+bBc9AAUMm2iG4L1O4
i2E4TYT2pf9k3GPZZRpJW+qwpojqJefcE3hNZ9zNO8tqo0BItZmOy1Gb0cPD5ebY
AXHC2pVy9KNyVHx5cFO9DUaD9rxeaj5mmWvLM9P+QI0ssbtQcLfXKEAF/suFoLLj
G1X/YcoUzNOP9w3TM1O2npF4u67Gc5awkTOzsniefZkObJNennGgUaBx6zR+NkE=
=ga33
-----END PGP SIGNATURE-----

--ARog1q0nGwipaawcbfOHbceTwPLWp7LrB--
