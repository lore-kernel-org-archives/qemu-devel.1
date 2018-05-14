Received: from eggs.gnu.org ([2001:4830:134:3::10]:54488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIBhD-0005z9-6b
	for qemu-devel@nongnu.org; Mon, 14 May 2018 07:31:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIBh9-0003yS-DV
	for qemu-devel@nongnu.org; Mon, 14 May 2018 07:31:15 -0400
Date: Mon, 14 May 2018 13:31:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180514113100.GC6665@localhost.localdomain>
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-11-kwolf@redhat.com>
	<aa4573ab-09a8-6c04-2ccb-b9d90bb1d0ac@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
In-Reply-To: <aa4573ab-09a8-6c04-2ccb-b9d90bb1d0ac@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 10/42] job: Add JobDriver.job_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 12.05.2018 um 00:53 hat Max Reitz geschrieben:
> On 2018-05-09 18:26, Kevin Wolf wrote:
> > This moves the job_type field from BlockJobDriver to JobDriver.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  include/block/blockjob_int.h |  3 ---
> >  include/qemu/job.h           | 11 +++++++++++
> >  block/backup.c               |  2 +-
> >  block/commit.c               |  2 +-
> >  block/mirror.c               |  4 ++--
> >  block/stream.c               |  2 +-
> >  blockjob.c                   | 16 +++++++---------
> >  job.c                        | 10 ++++++++++
> >  8 files changed, 33 insertions(+), 17 deletions(-)
> >=20
>=20
> [...]
>=20
> > diff --git a/include/qemu/job.h b/include/qemu/job.h
> > index b4b49f19e1..c87e951c8a 100644
> > --- a/include/qemu/job.h
> > +++ b/include/qemu/job.h
>=20
> [...]
>=20
> > @@ -57,4 +62,10 @@ struct JobDriver {
> >   */
> >  void *job_create(const char *job_id, const JobDriver *driver, Error **=
errp);
> > =20
> > +/** Returns the JobType of a given Job. */
> > +JobType job_type(Job *job);
> > +
> > +/** Returns the enum string for the JobType of a given Job. */
> > +const char *job_type_str(Job *job);
> > +
>=20
> Is there a good reason for these not to take a const Job *?
>=20
> Depending on the answer:
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Not really. I'll change it and take your R-b.

Kevin

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa+XN0AAoJEH8JsnLIjy/WP7oP/3pcDPjqfvZERFfQSFsUm3aM
LhdgZsnaZ2izW6D5thnXwMqAaHYo4IjNdr4ht0Bl9ApH0lej42DCJZbdc3ovBCrH
JzVnQSE1NnVTQcKgTv5RtD445jCNCr1OAcXOzOmCaTSpgo6KSXltJGpsrm+vrR4z
3KBn0EvWKVLURwrJ/nXo/3ze86TyNMzqi48rpGkrO9sElcXbvWhcNCXrlqdFHliW
XPwJlUZBR/DsQLL+wmHGsCp9XqxYMzHODD3YKHdTgIKJd/D3sga36AEmfMJBom8y
SG/cjUE+/Dgq558Ix+2IhpNbjDXk3JsxE5BGjJrUo1S0y8lIuCHPH/T3GrNeTjIz
zbSbiEs2PYNCYVwRrpJ05n3VOLh1WOTcUU4hqTI/M/mnU0tumx7Zv/oFGR1QOx71
A7McUIVY7TJYofoF1Oc0AE1uVDb8BwdDgZlJ/h99qbQYJwLP7tZEWgmJzh6KTAMM
3kSmNAsh1ygDeQNIym2i61n5JDHT8LMfFy090BJJUDWFAaQHnsRYt6IQXptiAe+b
6+zgZUxnwCvFZKB4fneOseCOJ8ab6CKEUddivErpL3SwwVxHyyuoLXhPgue79GXW
acsLOc59F1AV22tT6r6+l2vApYtUEtZhfWhMJ5UQfcmtIuite0HXKMb+dJlKMbXG
Dnt+KCqoSaMR87K3BjIF
=6K4k
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
