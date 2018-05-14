Received: from eggs.gnu.org ([2001:4830:134:3::10]:53753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIJI2-0003Fl-OB
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:37:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIJI2-0007dx-1N
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:37:46 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-29-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c11fe40a-eacb-9905-4e06-c3c3436b9c5c@redhat.com>
Date: Mon, 14 May 2018 21:37:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-29-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JGj29Kwv53ScaYEmJ674NTDj7QU3lGbL4"
Subject: Re: [Qemu-devel] [PATCH 28/42] job: Move .complete callback to Job
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
--JGj29Kwv53ScaYEmJ674NTDj7QU3lGbL4
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <c11fe40a-eacb-9905-4e06-c3c3436b9c5c@redhat.com>
Subject: Re: [PATCH 28/42] job: Move .complete callback to Job
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-29-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-29-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> This moves the .complete callback that tells a READY job to complete
> from BlockJobDriver to JobDriver. The wrapper function job_complete()
> doesn't require anything block job specific any more and can be moved
> to Job.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/blockjob.h     | 10 ----------
>  include/block/blockjob_int.h |  6 ------
>  include/qemu/job.h           |  8 ++++++++
>  block/mirror.c               | 10 +++++-----
>  blockdev.c                   |  2 +-
>  blockjob.c                   | 23 +++++------------------
>  job.c                        | 16 ++++++++++++++++
>  tests/test-bdrv-drain.c      |  6 +++---
>  tests/test-blockjob.c        | 10 +++++-----
>  9 files changed, 43 insertions(+), 48 deletions(-)
Reviewed-by: Max Reitz <mreitz@redhat.com>


--JGj29Kwv53ScaYEmJ674NTDj7QU3lGbL4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr55YQACgkQ9AfbAGHV
z0BVjwgAoeC9saOljdLfvnIpsMK1bdQiA5jlCxOc6g5xqfzS5HtBkpRqPfdZZDf1
2VN5anxv13HeBTe+XnqjYcFIHA2DUu1QCtjSZegArXOVZCWjkXoPt2jdQeliXzdJ
c++h/YStRNKaMCGuDoeNbCCsy3so2vFUduiEdPoD+9fPWQd1+N9wYnmoUrM2aRH2
gOoe+ykpc86kcwMTQs1WudPEuNsk/GHA0aqMOq/Ah9cKEDo25OCHqZvpcLrlOW6+
+onP5PbM2DoXQFrR22bwmf9N69UDd8BAY2y0CSWpw9j4DfAi5IhcnPyMPOvvNpl0
lis88xT3uBBgt3WciEWSzWO6wnzrgA==
=uuBQ
-----END PGP SIGNATURE-----

--JGj29Kwv53ScaYEmJ674NTDj7QU3lGbL4--
