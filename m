Received: from eggs.gnu.org ([2001:4830:134:3::10]:38756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chGZc-0003wl-Nw
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:10:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chGZb-00065e-Rg
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:10:16 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-36-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e26dea71-302f-f207-4fc0-aca1af90fe7f@redhat.com>
Date: Fri, 24 Feb 2017 15:10:06 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-36-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oVSjfliPXC5RdeKQUaAvJqSMtMHfQxh5p"
Subject: Re: [Qemu-devel] [PATCH 35/54] blockjob: Add permissions to
 block_job_add_bdrv()
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
--oVSjfliPXC5RdeKQUaAvJqSMtMHfQxh5p
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <e26dea71-302f-f207-4fc0-aca1af90fe7f@redhat.com>
Subject: Re: [PATCH 35/54] blockjob: Add permissions to block_job_add_bdrv()
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-36-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-36-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> Block jobs don't actually do I/O through the the reference they create
> with block_job_add_bdrv(), but they might want to use the permisssion
> system to express what the block job does to intermediate nodes. This
> adds permissions to block_job_add_bdrv() to provide the means to reques=
t
> permissions.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/backup.c           |  4 +++-
>  block/commit.c           |  8 ++++++--
>  block/mirror.c           |  9 +++++++--
>  block/stream.c           |  4 +++-
>  blockjob.c               | 36 ++++++++++++++++++++++++++++++------
>  include/block/blockjob.h |  5 ++++-
>  6 files changed, 53 insertions(+), 13 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--oVSjfliPXC5RdeKQUaAvJqSMtMHfQxh5p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliwPr4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A9agH/0OSYCjS9WWLZIZZ4UyX142AeKiU443n
7A9Eh/A+U0DPMJ67UMK9xc4+QvHIfQ3ABl/HpnOlIL2pqmSmCKmjIeyBgChbopVx
VMvgNm12VzoB5k4Sqve8xmFNSx+tVotXQwV9UZ0kkCMMsEqZ88EVTdySjY53EqpG
ZD1Ufi8FBSYNv20BZCTPmbOPD7Z40CvL7eYgJWNT5yltMe6wdlQ6/N8GQbINpwfI
m8ko1Mu8h17chTp+BOOPnBsBMAt6ydbgc8P4RWOhWi8u3Z5ybC3zan5m2c/WLBla
6fqTl60raKIPneGgyb8+X0uNHFUOUPgW3/7vM/5+W6yaXgr9vw5HxhU=
=q1Iz
-----END PGP SIGNATURE-----

--oVSjfliPXC5RdeKQUaAvJqSMtMHfQxh5p--
