Received: from eggs.gnu.org ([2001:4830:134:3::10]:53497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqIJT-0002gP-4a
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:55:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqIJS-000428-Bx
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:55:27 -0500
References: <20180223192549.26666-1-kwolf@redhat.com>
	<20180223192549.26666-37-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b42de8a5-3a4b-cb13-f3ff-a9d936930467@redhat.com>
Date: Mon, 26 Feb 2018 13:55:07 +0100
MIME-Version: 1.0
In-Reply-To: <20180223192549.26666-37-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LruDCCKsZLxbBb67JPtJ1raOMbS3sRLKS"
Subject: Re: [Qemu-devel] [PATCH v3 36/36] qemu-iotests: Test ssh image
 creation over QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LruDCCKsZLxbBb67JPtJ1raOMbS3sRLKS
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <b42de8a5-3a4b-cb13-f3ff-a9d936930467@redhat.com>
Subject: Re: [PATCH v3 36/36] qemu-iotests: Test ssh image creation over QMP
References: <20180223192549.26666-1-kwolf@redhat.com>
 <20180223192549.26666-37-kwolf@redhat.com>
In-Reply-To: <20180223192549.26666-37-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-23 20:25, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/207     | 261 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/207.out |  75 +++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 337 insertions(+)
>  create mode 100755 tests/qemu-iotests/207
>  create mode 100644 tests/qemu-iotests/207.out

Aw man, I've done it again and replied to the wrong version...

The gist of my reply: Maybe this should also test qcow2 creation over
ssh, but only if that doesn't force us to mark it as qcow2+ssh.

Max


--LruDCCKsZLxbBb67JPtJ1raOMbS3sRLKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqUA6sSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A4SAH/0slD0Oy8UBSbN89gYRU5OzBeZkuyn6Y
H4hkvLz3mv/npYUj0aNyg8FpSh4Yq43hs8N65xzchlXzW0HxjvR1X1Bi1ncHXFqE
WXSBBVdP25HKKuSNT4OZ5r97cErJzgXjcLyeSXQjEhitPZvUroui0LlOHQg2QJBZ
QphIhLf5nxUWV8qgv2srUwySp4ImXOoNdwHhnPPxSIYotr/gQlHgI7HTCS9ttUyt
FVTresDCw2dVfNdq2QXqbTcyObcP7Ck9G35aSaDrGlXKiDw5AszIakxBCR6NwyOK
+sQGK5D0jwnFKdSPHQQUhOlWrP8XcVHGTKkUOO/IdOQI610RRQWzl1U=
=lXlT
-----END PGP SIGNATURE-----

--LruDCCKsZLxbBb67JPtJ1raOMbS3sRLKS--
