Received: from eggs.gnu.org ([2001:4830:134:3::10]:48224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIELY-0000Mr-6P
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIELX-0006DM-Bu
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:21:04 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-14-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3118da74-5e95-fc7e-e1fc-38dd48f0c455@redhat.com>
Date: Mon, 14 May 2018 16:20:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-14-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UcmoOZFwIxIX4vl4Xd04wxEmn8Wsl7fSu"
Subject: Re: [Qemu-devel] [PATCH 13/42] job: Move state transitions to Job
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
--UcmoOZFwIxIX4vl4Xd04wxEmn8Wsl7fSu
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <3118da74-5e95-fc7e-e1fc-38dd48f0c455@redhat.com>
Subject: Re: [PATCH 13/42] job: Move state transitions to Job
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-14-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-14-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> This moves BlockJob.status and the closely related functions
> (block_)job_state_transition() and (block_)job_apply_verb to Job. The
> two QAPI enums are renamed to JobStatus and JobVerb.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json     |  14 +++----
>  include/block/blockjob.h |   3 --
>  include/qemu/job.h       |  13 ++++++
>  blockjob.c               | 102 +++++++++++----------------------------=
--------
>  job.c                    |  56 ++++++++++++++++++++++++++
>  tests/test-blockjob.c    |  39 +++++++++---------
>  block/trace-events       |   2 -
>  trace-events             |   4 ++
>  8 files changed, 122 insertions(+), 111 deletions(-)

block-job-dismiss's documentation still mentions
BLOCK_JOB_STATUS_CONCLUDED, but that's cleaned up in patch 39, so I
don't mind giving a:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--UcmoOZFwIxIX4vl4Xd04wxEmn8Wsl7fSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr5m0QACgkQ9AfbAGHV
z0DwXAf/YAHvX6K1Mri/0oSV8RooGB/GIlDin85pZAsu4DrY9NhOTXxm8gDMiqWU
Uu5mXaMa/efQpTGg055/FUOHgWgnMFh6B1wqSu0KB0xjNxASNimhVjU/NocNPst5
ZPVhAiFszAcHnQJsQ/dxqKnJEqxkO1Vzk88MbVP1y3lrwL66zDZW+PNkdPAn+oko
Zkqnid8s85wLv56NrJJwcSUr2GF0FmyT/8qrsIkck1sDIwPNjI4t57DRgmzK23TT
lOUYK0Mt1o1n0Le1KbmIqhrwoMib2DRHGz4Gl5EjNwMNg8Lv0eTqk1AmKULch80m
oRIrONZ/TpngAYV+AOyTROuj2lg4Hg==
=vAMU
-----END PGP SIGNATURE-----

--UcmoOZFwIxIX4vl4Xd04wxEmn8Wsl7fSu--
