Received: from eggs.gnu.org ([2001:4830:134:3::10]:40712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cik8p-0004gR-Gl
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:56:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cik8o-00041l-Op
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:56:43 -0500
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
	<1488286469-9381-36-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9ab107b2-f5b8-22c1-ddcd-25ec24962972@redhat.com>
Date: Tue, 28 Feb 2017 16:56:33 +0100
MIME-Version: 1.0
In-Reply-To: <1488286469-9381-36-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CH1edN7IOSvFJ8ODBrgImbuN6Xsu6KjVq"
Subject: Re: [Qemu-devel] [PATCH v3 35/44] commit: Add filter-node-name to
 block-commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CH1edN7IOSvFJ8ODBrgImbuN6Xsu6KjVq
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <9ab107b2-f5b8-22c1-ddcd-25ec24962972@redhat.com>
Subject: Re: [PATCH v3 35/44] commit: Add filter-node-name to block-commit
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
 <1488286469-9381-36-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488286469-9381-36-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 28.02.2017 13:54, Kevin Wolf wrote:
> Management tools need to be able to know about every node in the graph
> and need a way to address them. Changing the graph structure was okay
> because libvirt doesn't really manage the node level yet, but future
> libvirt versions need to deal with both new and old version of qemu.
>=20
> This new option to blockdev-commit allows the client to set a node-name=

> for the automatically inserted filter driver, and at the same time
> serves as a witness for a future libvirt that this version of qemu does=

> automatically insert a filter driver.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/commit.c            |  5 +++--
>  block/mirror.c            |  3 ++-
>  block/replication.c       |  2 +-
>  blockdev.c                | 10 +++++++---
>  include/block/block_int.h | 13 ++++++++++---
>  qapi/block-core.json      |  8 +++++++-
>  qemu-img.c                |  4 ++--
>  7 files changed, 32 insertions(+), 13 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--CH1edN7IOSvFJ8ODBrgImbuN6Xsu6KjVq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli1nbISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AclYH/1sZXxv/276aiLS7nMKDNQe48dGjpZLU
kPJfV0GxHdDk/66IsmfBbVKj/qI9wARaWSLQUKPcsBh2SUdgrzuC1Hn07QpqYalb
vpmULMsCSfXscQAxlFEedCQMTfINc08olxrI57cRuTWw4Vo6CJE9Dcm53vw/C/6F
T5zOMif+Pe6JroYAqz3x3Lfr2B9Wp88beo1uzvRYoE0FG97c+ZmYHlttNphEyGSW
6bGDgYQK4ikjmPLGfApiQItsLnO0VcTJLAi5/zbmn8zluu1tIPO/nSLa6hUpvvCk
svwzyN5Cc5KYC9dBjmXS6HtvKtbTV1lsvKLKeEvlSxxK8OjQQPlvpTw=
=/cfx
-----END PGP SIGNATURE-----

--CH1edN7IOSvFJ8ODBrgImbuN6Xsu6KjVq--
