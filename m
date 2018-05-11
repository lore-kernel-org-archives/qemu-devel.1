Received: from eggs.gnu.org ([2001:4830:134:3::10]:42927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHGYP-0005vV-Fk
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHGYO-0006pC-N9
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:30:21 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-8-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <91b7384b-25f4-2141-8794-d1319aa19c2d@redhat.com>
Date: Sat, 12 May 2018 00:30:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-8-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="01aWkRlPRCtuHhnuyZbCL9ecQutjeNjyW"
Subject: Re: [Qemu-devel] [PATCH 07/42] blockjob: Remove
 block_job_pause/resume_all()
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
--01aWkRlPRCtuHhnuyZbCL9ecQutjeNjyW
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <91b7384b-25f4-2141-8794-d1319aa19c2d@redhat.com>
Subject: Re: [PATCH 07/42] blockjob: Remove block_job_pause/resume_all()
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-8-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-8-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> Commit 81193349 removed the only use of block_job_pause/resume_all(),
> which was in bdrv_drain_all(). The functions are now unused and can be
> removed.

I have a strange liking for all-digit commit hash prefixes.

> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/blockjob_int.h | 14 --------------
>  blockjob.c                   | 27 ---------------------------
>  2 files changed, 41 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--01aWkRlPRCtuHhnuyZbCL9ecQutjeNjyW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr2GXEACgkQ9AfbAGHV
z0AZpgf/cMznk/G0nOQ3+NLRLKwYbKIRXHZrDJNPGhkU6wrTZpKbvJ96vOkBDYBv
SUJI0MRboBSRExZLU1eykPZdoFuj41jjFOsOsuF19CEAvJQNOSl5dauaf38MO5a4
Dc5l+C7fx+SSEl8/w8d/usty0rA5xVl/BQtQjAd8uml/qGoGwCAB/07/aDaAlrtK
sGiksMzu/w2oqyIL8gMW5LldEgjlte1Hu5jHHGF9j1B43Ynqs564lqjvUWX1FB/j
fTrrvjvTQZzxx9jYcn8R2iXmDpIOWzMuooRWfYf0Q8/pt5207o5kH+ei4UB1HHYW
/2clq9T71tVfNsU6uqyPQmi3LqmMwg==
=7JLh
-----END PGP SIGNATURE-----

--01aWkRlPRCtuHhnuyZbCL9ecQutjeNjyW--
