Received: from eggs.gnu.org ([2001:4830:134:3::10]:53587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIuV0-00041W-Mb
	for qemu-devel@nongnu.org; Wed, 16 May 2018 07:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIuUz-0001Sm-Jp
	for qemu-devel@nongnu.org; Wed, 16 May 2018 07:21:38 -0400
Date: Wed, 16 May 2018 13:21:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180516112129.GA4435@localhost.localdomain>
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-41-kwolf@redhat.com>
	<13ad0be2-6966-db50-3a84-31f4e890a6a1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <13ad0be2-6966-db50-3a84-31f4e890a6a1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 40/42] job: Add query-jobs QMP command
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


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 15.05.2018 um 01:09 hat Max Reitz geschrieben:
> On 2018-05-09 18:26, Kevin Wolf wrote:
> > This adds a minimal query-jobs implementation that shouldn't pose many
> > design questions. It can later be extended to expose more information,
> > and especially job-specific information.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>

> > +##
> > +# @JobInfo:
> > +#
> > +# Information about a job.
> > +#
> > +# @id:                  The job identifier
> > +#
> > +# @type:                The job type
>=20
> I'm not really happy with this description that effectively provides no
> information that one cannot already get from the field name, but I
> cannot come up with something better, so I'd rather stop typing now.
>=20
> (OK, my issue here is that "job type" can be anything.  That could mean
> e.g. "Is this a block job?".   Maybe an explicit reference to JobType
> might help here, although that is already part of the documentation.  On
> that note, maybe a quote from the documentation might help make my point
> that this description is not very useful:
>=20
>        "type: JobType"
>            The job type
>=20
> Maybe "The kind of job that is being performed"?)

IMHO, that's just a more verbose way of saying nothing new. The
"problem" is that "type: JobType" is already descriptive enough, there
is no real need for providing any additional information.

Also, I'd like to mention that almost all of the documentation is taken
=66rom BlockJobInfo, so if we decide to change something, we should
probably change it in both places.

> > +# @status:              Current job state/status
>=20
> Why the "state/status"?  Forgive me my incompetence, but I don't see a
> real difference here.  But in any case, one ought to be enough, no?
>=20
> (OK, full disclosure: My gut tells me "status" is what we now call the
> "progress", and this field should be called "state".  But it's called
> "status" now and it doesn't really make a difference, so it's fine to
> describe it as either.)

I'll defer to John who wrote this description originally. I think we're
just using status/state inconsistently for the same thing (JobStatus,
which represents the states of the job state machine).

> > +#
> > +# @current-progress:    The current progress value
> > +#
> > +# @total-progress:      The maximum progress value
>=20
> Hm, not really.  This makes it sound like at any point, this will be the
> maximum even in the future, but that's not true.
>=20
> Maybe "estimated progress maximum"?  Or be even more verbose (no, that
> doesn't hurt): "This is an estimation of the value @current-progress
> needs to reach for the job to complete."
>=20
> (Actually, I find it important to note that it is an estimation, maybe
> we event want to be really explicit about the fact that this value may
> change all the time, in any direction.)

I'll try to improve the documentation of these fields (both here and in
BlockJobInfo) for v2.

Kevin

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa/BQ5AAoJEH8JsnLIjy/W054P/RSkJE/amO/f2A2LIqckM66b
xtfZAKQHy5Xrm5pwDQSlcYduqmzyAYjQYRrytvHTQmJXnGacrFHLdQ0TqRzudR88
z2b8phNanNjwGArlemrFf4h/Ulim9+bRpPlcjDbHsZOP9FL9Aws2ExtqJjk8HFmU
l2EkeN4DqTT750XnRjS8c5ivmp4ktrALwhpSvPEjjGCJaoo6zJwFOl4c/VSyakVW
Mn+n4xL2aR7/0n03TFGv3SI7AD2+n4PPxwYHbUoox/V8iEV89VL47yYY7lp3YlyK
wRWDTnUyLQHQjb1H8zL7iPqx2IK2YtdnGYQtFr8nsIMjhGzN1E/5YshRf9BB4zI4
rxqt7wdV2aBmFJLnCltrKyFmZAZi9IakbpKFv2CpeTt1eVOZ8XF/N7AL9sHpLpPN
TSlmFI183NYCRwn1Q2ZxzvSOrJ0/vuOSrIJIkVdHdik7dxbSxjALM3aALG4lHmNa
//MMycoPTHxuonZ3nOkgRzQbn/kOqB5qrgBDk3OWGQ9k1CchCSamFglYtVu3OY9x
YB+foho38V6/nVD8XR2SPVSyuhbMII3koMZyV8lveD77OQOqePHhs40iRTL4qenp
TQn00Wila2ADs1+mlyhoVpIxOZp6bO7f7G1/m9Rd6Kpi8n7AX59tvPaGv18YcBxP
gJW+GlYHCYxsOwVXlkRF
=/BUA
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
