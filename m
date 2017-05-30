Received: from eggs.gnu.org ([2001:4830:134:3::10]:47262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFdhu-0002fS-8V
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFdht-0002uv-63
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:44:54 -0400
Date: Tue, 30 May 2017 10:44:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170530094444.GN11362@stefanha-x1.localdomain>
References: <1496070414-6744-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0aF+6pWUK5w8WdCh"
Content-Disposition: inline
In-Reply-To: <1496070414-6744-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PULL 00/15] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org


--0aF+6pWUK5w8WdCh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2017 at 05:06:39PM +0200, Kevin Wolf wrote:
> The following changes since commit 9964e96dc9999cf7f7c936ee854a795415d19b=
60:
>=20
>   Merge remote-tracking branch 'jasowang/tags/net-pull-request' into stag=
ing (2017-05-23 15:01:31 +0100)
>=20
> are available in the git repository at:
>=20
>=20
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>=20
> for you to fetch changes up to 42a48128417b3bfade93d1a4721348cc480e9e50:
>=20
>   Merge remote-tracking branch 'mreitz/tags/pull-block-2017-05-29-v3' int=
o queue-block (2017-05-29 16:34:27 +0200)
>=20
> ----------------------------------------------------------------
>=20
> Block layer patches
>=20
> ----------------------------------------------------------------
> Alberto Garcia (2):
>       stream: fix crash in stream_start() when block_job_create() fails
>       qcow2: remove extra local_error variable
>=20
> Daniel P. Berrange (4):
>       qemu-img: add support for --object with 'dd' command
>       qemu-img: fix --image-opts usage with dd command
>       qemu-img: introduce --target-image-opts for 'convert' command
>       qemu-img: copy *key-secret opts when opening newly created files
>=20
> Eric Blake (1):
>       block: Tweak error message related to qemu-img amend
>=20
> Fam Zheng (3):
>       iotests: 147: Don't test inet6 if not available
>       qemu-img: Fix documentation of convert
>       qemu-img: Fix leakage of options on error
>=20
> Kevin Wolf (3):
>       qemu-iotests: Test streaming with missing job ID
>       mirror: Drop permissions on s->target on completion
>       Merge remote-tracking branch 'mreitz/tags/pull-block-2017-05-29-v3'=
 into queue-block
>=20
> Max Reitz (2):
>       block: Fix backing paths for filenames with colons
>       block/file-*: *_parse_filename() and colons
>=20
> Stephen Bates (1):
>       nvme: Add support for Controller Memory Buffers
>=20
>  block.c                    |  50 +++++++++++++--
>  block/file-posix.c         |  17 +-----
>  block/file-win32.c         |  12 +---
>  block/mirror.c             |   7 ++-
>  block/qcow2-cluster.c      |   3 +-
>  block/qcow2.c              |   5 +-
>  block/stream.c             |   2 +-
>  hw/block/nvme.c            |  75 +++++++++++++++++++++--
>  hw/block/nvme.h            |  73 ++++++++++++++++++++++
>  include/block/block_int.h  |   3 +
>  qemu-img-cmds.hx           |   4 +-
>  qemu-img.c                 | 148 +++++++++++++++++++++++++++++++++++----=
------
>  qemu-img.texi              |  12 +++-
>  tests/qemu-iotests/030     |   4 ++
>  tests/qemu-iotests/030.out |   4 +-
>  tests/qemu-iotests/060.out |   2 +-
>  tests/qemu-iotests/147     |   7 +++
>  17 files changed, 351 insertions(+), 77 deletions(-)
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--0aF+6pWUK5w8WdCh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLT8MAAoJEJykq7OBq3PIjEIH/3DRfaqkPWvZ43sMdaf6e3+w
YWQg1SyZNu4LWxCt5mzhtuQvtyyeYBOJOLSe2ZhQlZc+qY/JU/mQqCHfvUHnev6m
GGBm/Xp6fnhBcnPJS7J9+ejfNVqgcHsbtD+qcPO//nSbnTan3MiQqT2/bIWPnzSt
BATVKbkZ8kida8cNmmnG7F9cM8hGyYBpYBGdsBVn+ePug9QyHuAurlqBPL8sEZ2F
6V9ecg+37P22XX1dbPcURbqyXqX1uhPDQwbSAtNkozKpkbzF1fHbWhK+IqmsMdjw
qjvFEdbC7h89QgjO+QQQcRAs9Q+FpLc4DUD3KExfnHRhVR5iwhNzvDUGoH5fI9s=
=8lg2
-----END PGP SIGNATURE-----

--0aF+6pWUK5w8WdCh--
