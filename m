Received: from eggs.gnu.org ([2001:4830:134:3::10]:46218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHGqZ-0002h9-A9
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:49:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHGqY-0005IX-If
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:49:07 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-10-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <dce2af16-e215-730c-8222-9b4400599b48@redhat.com>
Date: Sat, 12 May 2018 00:48:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-10-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pmnyAxUDesMVkHlSF2GeOtCbeGdGf93Fe"
Subject: Re: [Qemu-devel] [PATCH 09/42] job: Rename BlockJobType into JobType
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
--pmnyAxUDesMVkHlSF2GeOtCbeGdGf93Fe
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <dce2af16-e215-730c-8222-9b4400599b48@redhat.com>
Subject: Re: [PATCH 09/42] job: Rename BlockJobType into JobType
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-10-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-10-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> QAPI types aren't externally visible, so we can rename them without
> causing problems. Before we add a job type to Job, rename the enum
> so it can be used for more than just block jobs.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  qapi/block-core.json         | 14 +++++++-------
>  include/block/blockjob_int.h |  2 +-
>  block/backup.c               |  2 +-
>  block/commit.c               |  2 +-
>  block/mirror.c               |  4 ++--
>  block/stream.c               |  2 +-
>  blockjob.c                   |  6 +++---
>  7 files changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--pmnyAxUDesMVkHlSF2GeOtCbeGdGf93Fe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr2HdsACgkQ9AfbAGHV
z0DFowf/fMoQ7E7yAi6UoKGxhOdi3AgPjVdLKDfpPYOX5B05lhnc5JMGJ/VlgfNo
SCfXTYL0peA2QQ43YTEmLuH+XsvlTqrDa81QX4Zzd2tHO0XQy0K01UV3270Mz6S+
J+FLpEnGgPqb7E+bTzCpvUD2qlVb+Bxrnq50bjw7lhJXMTWuTcpQqYS56wiT7Ncx
HCI1i7yqwc6L/SZwFfnwCkYPPmwmqYcE++7+/KrUaiLtXhZXvtYy0Zsbn6No1f+f
jId6mwEwTSpZjHyBUxrtyqBTD/wE22JJnN1Zwxsd5R8J92EM2WxMphvx/vPFBuhW
0HN9y+blAfoZJT3QwdME6U4BLpJUHQ==
=uxjF
-----END PGP SIGNATURE-----

--pmnyAxUDesMVkHlSF2GeOtCbeGdGf93Fe--
