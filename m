Received: from eggs.gnu.org ([2001:4830:134:3::10]:47045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHGvJ-0006uK-Ks
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHGvI-00072F-Rs
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:54:01 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-11-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <aa4573ab-09a8-6c04-2ccb-b9d90bb1d0ac@redhat.com>
Date: Sat, 12 May 2018 00:53:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-11-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XUFd7zyTzdgWgcrDF6jZn4hUcgyRPRNLd"
Subject: Re: [Qemu-devel] [PATCH 10/42] job: Add JobDriver.job_type
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
--XUFd7zyTzdgWgcrDF6jZn4hUcgyRPRNLd
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <aa4573ab-09a8-6c04-2ccb-b9d90bb1d0ac@redhat.com>
Subject: Re: [PATCH 10/42] job: Add JobDriver.job_type
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-11-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-11-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> This moves the job_type field from BlockJobDriver to JobDriver.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/blockjob_int.h |  3 ---
>  include/qemu/job.h           | 11 +++++++++++
>  block/backup.c               |  2 +-
>  block/commit.c               |  2 +-
>  block/mirror.c               |  4 ++--
>  block/stream.c               |  2 +-
>  blockjob.c                   | 16 +++++++---------
>  job.c                        | 10 ++++++++++
>  8 files changed, 33 insertions(+), 17 deletions(-)
>=20

[...]

> diff --git a/include/qemu/job.h b/include/qemu/job.h
> index b4b49f19e1..c87e951c8a 100644
> --- a/include/qemu/job.h
> +++ b/include/qemu/job.h

[...]

> @@ -57,4 +62,10 @@ struct JobDriver {
>   */
>  void *job_create(const char *job_id, const JobDriver *driver, Error **=
errp);
> =20
> +/** Returns the JobType of a given Job. */
> +JobType job_type(Job *job);
> +
> +/** Returns the enum string for the JobType of a given Job. */
> +const char *job_type_str(Job *job);
> +

Is there a good reason for these not to take a const Job *?

Depending on the answer:

Reviewed-by: Max Reitz <mreitz@redhat.com>

>  #endif


--XUFd7zyTzdgWgcrDF6jZn4hUcgyRPRNLd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr2HwAACgkQ9AfbAGHV
z0BuIwf/XkicBy8W1d5tGUvRYoXysFGNYFq5lVY5ddBKftnGuBY6VOaeWxON3U4B
i4s8aGsBXrnpdW20oYtc2H6n8L9bK6bgqBzQ4THAsS1LAHlMrPOvq+mtfRhhVp4T
F05yPowkMLThHHzB4JPiEcjIFVU4AFC/HTrzmA5B+Lp80amYRVJlXsk18Q1Sz4fG
hAfww3jj5L1gSFrVtgM7PmG984zBctdjL4gtckW7kJOhbQHXoh/kM+1dtoBW1XtP
tR3c24J1BQjQScXo+U3mhXredhmSHk7jLeIRh4dLLgqYBafBiCNzR9MOD6M6mjJX
vG3wf14ippaAbsgY2C7UtUuAaHgljQ==
=sWHu
-----END PGP SIGNATURE-----

--XUFd7zyTzdgWgcrDF6jZn4hUcgyRPRNLd--
