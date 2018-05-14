Received: from eggs.gnu.org ([2001:4830:134:3::10]:52219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fID3g-0006L8-17
	for qemu-devel@nongnu.org; Mon, 14 May 2018 08:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fID3f-0003AF-0r
	for qemu-devel@nongnu.org; Mon, 14 May 2018 08:58:32 -0400
Date: Mon, 14 May 2018 14:58:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180514125819.GD6665@localhost.localdomain>
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-9-kwolf@redhat.com>
	<1981b40b-40c2-4378-35a5-02cc20361370@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Content-Disposition: inline
In-Reply-To: <1981b40b-40c2-4378-35a5-02cc20361370@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/42] job: Create Job,
 JobDriver and job_create()
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


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 12.05.2018 um 00:46 hat Max Reitz geschrieben:
> On 2018-05-09 18:26, Kevin Wolf wrote:
> > This is the first step towards creating an infrastructure for generic
> > background jobs that aren't tied to a block device. For now, Job only
> > stores its ID and JobDriver, the rest stays in BlockJob.
> >=20
> > The following patches will move over more parts of BlockJob to Job if
> > they are meaningful outside the context of a block job.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  include/block/blockjob.h     |  9 +++----
> >  include/block/blockjob_int.h |  4 +--
> >  include/qemu/job.h           | 60 ++++++++++++++++++++++++++++++++++++=
++++++++
> >  block/backup.c               |  4 ++-
> >  block/commit.c               |  4 ++-
> >  block/mirror.c               | 10 +++++---
> >  block/stream.c               |  4 ++-
> >  blockjob.c                   | 46 ++++++++++++++++-----------------
> >  job.c                        | 48 +++++++++++++++++++++++++++++++++++
> >  tests/test-bdrv-drain.c      |  4 ++-
> >  tests/test-blockjob-txn.c    |  4 ++-
> >  tests/test-blockjob.c        | 12 ++++++---
> >  MAINTAINERS                  |  2 ++
> >  Makefile.objs                |  2 +-
> >  14 files changed, 169 insertions(+), 44 deletions(-)
> >  create mode 100644 include/qemu/job.h
> >  create mode 100644 job.c
> >=20
> > diff --git a/include/block/blockjob.h b/include/block/blockjob.h
> > index 0b57d53084..8acc1a236a 100644
> > --- a/include/block/blockjob.h
> > +++ b/include/block/blockjob.h
>=20
> [...]
>=20
> > @@ -40,6 +41,9 @@ typedef struct BlockJobTxn BlockJobTxn;
> >   * Long-running operation on a BlockDriverState.
> >   */
> >  typedef struct BlockJob {
> > +    /** Data belonging to the generic Job infrastructure */
> > +    Job job;
> > +
> >      /** The job type, including the job vtable.  */
> >      const BlockJobDriver *driver;
>=20
> Any reason why you keep this field around?  Shouldn't it be just
> DO_UPCAST(const BlockJobDriver, job_driver, job.driver)?

I left it around to avoid unnecessary churn at this point. However, I
intended to remove it at the end of the series, which I seem to have
forgotten. I'll add a patch to this effect.

Kevin

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa+YfrAAoJEH8JsnLIjy/WFcUP/jbCUzHtDR80H1y/HPOp2/Lh
1VqP41yoZAhREZUeoz61FGM4cpXnXxUCfYy46J5RRFr2puAThXpCOAwW27r6tA52
aS9OCsPclzmYSX1WLGEXT7cuOa/bn1Ae9mc2xeRkS2veUBsNIQBIHPhmDBh4tIrX
uEf8Wu31yOdTaV5DAMG6pJ2EUnY0OCIszmdzXhl7nldBgpHuxK7szsONS132Oigj
iuhLIpp58oHdi1t/DSiW5q5EJdQYeaZ8GkwaaCI+8XjkLEn9oGBT93O3g1YVu7Q8
jjrnW6B7jDIZEapBodEd65ceBgG8xb7xFhoaouN7xnj1ktb3K5Utps0+qcHRKFpB
6S7MM73z/P6hPKlk3uv7iKr61Cks+Av0rh8cv+7sXEsrAnGUjQCYsG33dPzG1+S5
378NDUgx7apkWF3OHnX9i/EAl+TcEoPeO2n3DTlxVOflp6th4sOGAPH1RuHm1qec
5hyYL/rKpAS5Xe7IqXI6c+4SSCSZ3vKcZOtoqpj8IQK6G2m3wYm2Nsbchdm9YQZ2
1FtVCd9y8VoVJE/Pwx5MV1aZq9zIMLIlHvw/vQfvKMCK7fkv9bo7+1gguc6EHaji
xk/4NAiqW7xa45QwWxJH+j88wWCiaQQQVXr/4+rp7Ngqhqb4ruCHQRQS9ILaTa5G
vq7iCTdAN9CFk5pHCfnb
=RXCU
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--
