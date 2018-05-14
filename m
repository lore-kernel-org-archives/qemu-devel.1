Received: from eggs.gnu.org ([2001:4830:134:3::10]:42209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIKlK-0001ku-07
	for qemu-devel@nongnu.org; Mon, 14 May 2018 17:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIKlJ-0007MA-5K
	for qemu-devel@nongnu.org; Mon, 14 May 2018 17:12:05 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-36-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f8583b0a-ddae-2bcf-4f7b-11a32af614f5@redhat.com>
Date: Mon, 14 May 2018 23:11:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-36-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ZNlbvNAxTvqqPgCy1zTOHqEsyA6kHFQam"
Subject: Re: [Qemu-devel] [PATCH 35/42] job: Add job_is_ready()
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
--ZNlbvNAxTvqqPgCy1zTOHqEsyA6kHFQam
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <f8583b0a-ddae-2bcf-4f7b-11a32af614f5@redhat.com>
Subject: Re: [PATCH 35/42] job: Add job_is_ready()
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-36-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-36-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> Instead of having a 'bool ready' in BlockJob, add a function that
> derives its value from the job status.
>=20
> At the same time, this fixes the behaviour to match what the QAPI
> documentation promises for query-block-job: 'true if the job may be
> completed'. When the ready flag was introduced in commit ef6dbf1e46e,
> the flag never had to be reset to match the description because after
> being ready, the jobs would immediately complete and disappear.
>=20
> Job transactions and manual job finalisation were introduced only later=
=2E
> With these changes, jobs may stay around even after having completed
> (and they are not ready to be completed a second time), however their
> patches forgot to reset the ready flag.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/blockjob.h |  5 -----
>  include/qemu/job.h       |  3 +++
>  blockjob.c               |  3 +--
>  job.c                    | 22 ++++++++++++++++++++++
>  qemu-img.c               |  2 +-
>  tests/test-blockjob.c    |  2 +-
>  6 files changed, 28 insertions(+), 9 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--ZNlbvNAxTvqqPgCy1zTOHqEsyA6kHFQam
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr5+5wACgkQ9AfbAGHV
z0BicwgAh71D7t99xuyB/emM/GMpdz7hlzVMlyfP7E63+VsVsTDxM+zDWluAxr0m
QJHmMg4CWnblThsEjrM7qj3eOjvZif8ugfDSMaTbUTM7YlzH8lfQ0kPUOeinEYML
GSt/P4osWmd4G0qv4gwumY1GH2zDHVMfqJwusubk7MwGWBOcVKHok9se6P5ikq8Y
ND+97NiKDk+UAFNNHrBtMB2yVR7qfoSoSXgt8s2jsht137HxbwwyjDVmBEUjSLOF
mZo0ts0L7HNSY9qAWgbLHi5y49vX6RjSzyhrcVlQhhT81UPanpbOzqLDrhZrvCC5
//ZyaiHE+UuK09O0jSUkHcettnHQUw==
=z0Vr
-----END PGP SIGNATURE-----

--ZNlbvNAxTvqqPgCy1zTOHqEsyA6kHFQam--
