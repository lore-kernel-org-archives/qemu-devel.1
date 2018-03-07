Received: from eggs.gnu.org ([2001:4830:134:3::10]:40652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1etevh-0005BH-JL
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 14:40:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1etevg-00055N-Rl
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 14:40:49 -0500
References: <20180307185946.29366-1-kwolf@redhat.com>
	<20180307185946.29366-34-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4acb4be5-1f1b-392a-6a8f-88578cff1500@redhat.com>
Date: Wed, 7 Mar 2018 20:40:24 +0100
MIME-Version: 1.0
In-Reply-To: <20180307185946.29366-34-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RL2IueKvpffZeeVXU5JenVMGWtpc88Y3B"
Subject: Re: [Qemu-devel] [PATCH v4 33/37] ssh: Support .bdrv_co_create
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
--RL2IueKvpffZeeVXU5JenVMGWtpc88Y3B
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <4acb4be5-1f1b-392a-6a8f-88578cff1500@redhat.com>
Subject: Re: [PATCH v4 33/37] ssh: Support .bdrv_co_create
References: <20180307185946.29366-1-kwolf@redhat.com>
 <20180307185946.29366-34-kwolf@redhat.com>
In-Reply-To: <20180307185946.29366-34-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-07 19:59, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to ssh, which enables
> image creation over QMP.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json | 16 +++++++++-
>  block/ssh.c          | 83 ++++++++++++++++++++++++++++++--------------=
--------
>  2 files changed, 63 insertions(+), 36 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--RL2IueKvpffZeeVXU5JenVMGWtpc88Y3B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqgQCkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A1SQH/1vpNdrpxGgowqwVHexO1KCNh6gBXivD
iVvD6lKl52+5d1EAD1hR5SBFkmgcipRGCFSenZcww1Vz5ouTc14s9hu1OEj7QmTO
mgyWzz2pgcyQPUKnFzvzhCj5pYhzfaIqaUb4SnjaXEYX4LvPpnVG9QNE0FvZiU1B
+frMXHdBIxJ9IudMxb0JkBBmihgINK9iBr+NcA1gX833ZygCTOyxRxGy1Ot1pIed
8v1IlJtC1BsNuI5XdNokqlaO5JcTsDgG5o9XP6UeTOkAJtLJWhNGugRKWbKQHjUN
GG7ZrxsS5TDkDlkq8Kyu2JByk3V70V8sUQ49Nq2qPJ+V9J7YeOtmjTg=
=Ri5r
-----END PGP SIGNATURE-----

--RL2IueKvpffZeeVXU5JenVMGWtpc88Y3B--
