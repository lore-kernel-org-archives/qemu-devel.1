Received: from eggs.gnu.org ([2001:4830:134:3::10]:51592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJJJG-0006aN-82
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJJJF-0000WV-6i
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:51:10 -0400
Date: Thu, 17 May 2018 15:50:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180517135049.GC4080@localhost.localdomain>
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-43-kwolf@redhat.com>
	<49ee7d19-779d-cc1b-12a4-e4be14dc0a0f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <49ee7d19-779d-cc1b-12a4-e4be14dc0a0f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 42/42] qemu-iotests: Test job-* with block
 jobs
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


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 15.05.2018 um 01:44 hat Max Reitz geschrieben:
> On 2018-05-09 18:26, Kevin Wolf wrote:
> > This adds a test case that tests the new job-* QMP commands with
> > mirror and backup block jobs.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  tests/qemu-iotests/219     | 201 ++++++++++++++++++++++++++++
> >  tests/qemu-iotests/219.out | 327 +++++++++++++++++++++++++++++++++++++=
++++++++
> >  tests/qemu-iotests/group   |   1 +
> >  3 files changed, 529 insertions(+)
> >  create mode 100755 tests/qemu-iotests/219
> >  create mode 100644 tests/qemu-iotests/219.out

> > +Pause/resume in READY
> > +=3D=3D=3D Testing block-job-pause/block-job-resume =3D=3D=3D
> > +{u'return': {}}
> > +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data'=
: {u'status': u'standby', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
> > +{u'return': [{u'status': u'standby', u'current-progress': 4194304, u't=
otal-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
> > +{u'return': {}}
> > +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data'=
: {u'status': u'ready', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
> > +{u'return': [{u'status': u'ready', u'current-progress': 4194304, u'tot=
al-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
> > +=3D=3D=3D Testing block-job-pause/job-resume =3D=3D=3D
> > +{u'return': {}}
> > +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data'=
: {u'status': u'standby', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
> > +{u'return': [{u'status': u'standby', u'current-progress': 4194304, u't=
otal-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
> > +{u'return': {}}
> > +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data'=
: {u'status': u'ready', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
> > +{u'return': [{u'status': u'ready', u'current-progress': 4194304, u'tot=
al-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
> > +=3D=3D=3D Testing job-pause/block-job-resume =3D=3D=3D
> > +{u'return': {}}
> > +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data'=
: {u'status': u'standby', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
> > +{u'return': [{u'status': u'standby', u'current-progress': 4194304, u't=
otal-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
> > +{u'return': {}}
> > +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data'=
: {u'status': u'ready', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
> > +{u'return': [{u'status': u'ready', u'current-progress': 4194304, u'tot=
al-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
> > +=3D=3D=3D Testing job-pause/job-resume =3D=3D=3D
> > +{u'return': {}}
> > +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data'=
: {u'status': u'standby', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
> > +{u'return': [{u'status': u'standby', u'current-progress': 4194304, u't=
otal-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
> > +{u'return': {}}
> > +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data'=
: {u'status': u'ready', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
> > +{u'return': [{u'status': u'ready', u'current-progress': 4194304, u'tot=
al-progress': 4194304, u'id': u'job0', u'type': u'mirror'}]}
>=20
> This is really, really mean.  Don't you have any compassion with the
> poor little job that just wants to have Feierabend?
>=20
> It worked so hard and it's always on standby and instantly ready when
> you need it.  Yet, you keep it hanging.  That's not nice.

If you just mean that I do some testing with the poor job before I
complete it, then I'm afraid the job will have to suffer this.

But if you have a more serious concern, I don't see it. Isn't the job
properly completed in the end, as the following lines show?

> > +{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state =
'ready' cannot accept command verb 'finalize'"}}
> > +{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state =
'ready' cannot accept command verb 'dismiss'"}}
> > +{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state =
'ready' cannot accept command verb 'finalize'"}}
> > +{u'error': {u'class': u'GenericError', u'desc': u"Job 'job0' in state =
'ready' cannot accept command verb 'dismiss'"}}
> > +{u'return': {}}
> > +
> > +Waiting for PENDING state...
> > +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data'=
: {u'status': u'waiting', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
> > +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data'=
: {u'status': u'pending', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
> > +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data'=
: {u'status': u'concluded', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
> > +{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data'=
: {u'status': u'null', u'id': u'job0'}, u'event': u'JOB_STATUS_CHANGE'}
> > +{u'return': []}

Kevin

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa/Yi5AAoJEH8JsnLIjy/WAfgQAKLrkaPBOrMnIqOiIQcMDBeC
q88pqBYD+ieZQp0hQIGCA1nGCXXelifNMIfhtV+NqFJtfUaFxVJKD9mwJuSL0jLp
N1bij/3cICWtNExqB9FZimAfsMeO5YvPH3AkIE78mR3Nzy7iBNVzULymflm5UuLi
+iBZHyoZgPVAaY4gLrmVm/oRcWJqh4xfIuakStTG4zWWNT465rbwOsbQfHBzDwLS
5IYQBVpCqSLYRy1VsfwVxJYLmwucSaXLdJD2bObZdSRFEEE0hIVsEoOHD+7/iiJx
TjQ3XBGxPvBTrCpsBo0IBhGC6+408mv618a/v3C8+EDqAQL9viGuWC4aqFt7XwCD
ziajQD8T1juuympdfBOJy1upcLIf6GquZLWBINhawh0EMdpwm+5juuiXnvkL7S2Z
oAV4qageo5/qubzh4OyIrkyMKdCmsBkQZ6Sx1SCWFcbhyP5NlTOTWt45oiLiirnM
XumugJyAGB4jTRap8ATTWq0iyp4NX9Tg71KJHeTqzFF3HyEGqYV6uoogmtuKJQsy
KkHjcE6F+7tF8loB2awHiOtCyyh0drsp1EieS+FxJACC4tdlerVecjKvzvm121m4
8QTBwnM5YGfj8IqqdUh1IT67UGdzzX+L7PVq84HwxKYdc+6/XsTa+KZfZxucENJc
zwCc1+ylkirz1VugQWk/
=P/gU
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
