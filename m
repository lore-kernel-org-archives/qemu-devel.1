Received: from eggs.gnu.org ([2001:4830:134:3::10]:57739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIJdk-0002P1-6d
	for qemu-devel@nongnu.org; Mon, 14 May 2018 16:00:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIJdj-0000VS-CE
	for qemu-devel@nongnu.org; Mon, 14 May 2018 16:00:12 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-31-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <149220a2-9299-463c-5f92-e0a165d839bc@redhat.com>
Date: Mon, 14 May 2018 22:00:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-31-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HtpdK3oXdyx181cINuJmPPZdLac5tbkZI"
Subject: Re: [Qemu-devel] [PATCH 30/42] job: Switch transactions to JobTxn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HtpdK3oXdyx181cINuJmPPZdLac5tbkZI
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <149220a2-9299-463c-5f92-e0a165d839bc@redhat.com>
Subject: Re: [PATCH 30/42] job: Switch transactions to JobTxn
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-31-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-31-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> This doesn't actually move any transaction code to Job yet, but it
> renames the type for transactions from BlockJobTxn to JobTxn and makes
> them contain Jobs rather than BlockJobs
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block_int.h    |  2 +-
>  include/block/blockjob.h     | 11 ++++----
>  include/block/blockjob_int.h |  2 +-
>  include/qemu/job.h           |  3 +++
>  block/backup.c               |  2 +-
>  blockdev.c                   | 14 +++++------
>  blockjob.c                   | 60 +++++++++++++++++++++++-------------=
--------
>  tests/test-blockjob-txn.c    |  8 +++---
>  8 files changed, 54 insertions(+), 48 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--HtpdK3oXdyx181cINuJmPPZdLac5tbkZI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr56sMACgkQ9AfbAGHV
z0Bvawf/ecoCMNI06umd9MHNyiAiq6ub5ybnv5+RNxGOEcTP82rdrXSyrWoquU5c
M5NkIQkUGBKck6XpW52c+L0tvYPA5kWmjXbQrFRSzK3Xkmm1tKQUpHbxGQXtxIkR
axBBAPAAxG4o0b0jXj/ZpHbHdApYknDfyqGSvYfiFgsdIe/vm66tu3+FA01Dllmx
D3bgKXdliikBXMwIBiUUs7frNxBp56fswnPdWAY0k6Nsr7FmqYitoTQYQfLWAIZU
n5FbBHAAG5AYv0bUDCPjzJjF/ah/jXePkxP/YN7DX9g1qUjf9jFfWaEDo8iF985g
KYyAu67BSy+C0aQXcHR2rM8IC+c5Xg==
=px4K
-----END PGP SIGNATURE-----

--HtpdK3oXdyx181cINuJmPPZdLac5tbkZI--
