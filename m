Received: from eggs.gnu.org ([209.51.188.92]:35814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gjmgO-00085e-Aq
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 10:00:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gjmgJ-0006PJ-VI
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 10:00:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gjmgJ-00067A-K7
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 10:00:39 -0500
Date: Wed, 16 Jan 2019 15:00:22 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190116150022.GC2351@work-vm>
References: <20190113140849.38339-1-lifei1214@126.com>
	<6aa36ba5-1784-b927-b75f-b56ec8d96d4c@gmail.com>
	<c32370f9-41c0-49a2-920f-e7cc984237cd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c32370f9-41c0-49a2-920f-e7cc984237cd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/5] fix some segmentation faults
 and migration issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Fei Li <shirley17fei@gmail.com>, Fei Li <lifei1214@126.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

* Philippe Mathieu-Daud=C3=A9 (philmd@redhat.com) wrote:
> On 1/16/19 5:50 AM, Fei Li wrote:
> > Hi all,
> >=20
> > Kindly ping. :)
> >=20
> > As my v10 of qemu_thread_create partly rely on this patch series, I'd
> > like to know
> > when will these 5 patches be merged, or I join them with v10 of
> > qemu_thread_create
> > and send together. Could anyone shed light on me? Thanks for the advi=
ce
> > in advance.
>=20
> This series would get merged quicker if you include the maintainers :)
>=20
> $ ./scripts/get_maintainer.pl -f migration/*
> Juan Quintela <quintela@redhat.com> (maintainer:Migration)
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> (maintainer:Migration)
>=20
> Doing that for you by responding to this mail.

We can do it via migration now the set is complete.

Dave

>=20
> Regards,
>=20
> Phil.
>=20
> >=20
> >=20
> > Have a nice day
> > Fei
> > =E5=9C=A8 2019/1/13 =E4=B8=8B=E5=8D=8810:08, Fei Li =E5=86=99=E9=81=93=
:
> >> All these five patches have gotten the Reviewed-by: the first patch
> >> is to fix one segmentation fault and the other four are to fix some
> >> migration issues.
> >>
> >> To be more detail, they are extracted from previous
> >> "[PATCH for-4.0 v9 16/16] qemu_thread_create: propagate errors to
> >> callers to handle.", but actually these five patches are derivative
> >> and not relevant to the mentioned qemu_thread_create patch series.
> >> Thus send them separately to make them be merged earlier.
> >>
> >> Fei Li (5):
> >> =C2=A0=C2=A0 Fix segmentation fault when qemu_signal_init fails
> >> =C2=A0=C2=A0 migration: fix the multifd code when receiving less cha=
nnels
> >> =C2=A0=C2=A0 migration: multifd_save_cleanup() can't fail, simplify
> >> =C2=A0=C2=A0 migration: add more error handling for postcopy_ram_ena=
ble_notify
> >> =C2=A0=C2=A0 migration: unify error handling for process_incoming_mi=
gration_co
> >>
> >> =C2=A0 migration/channel.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 11 ++++++=
-----
> >> =C2=A0 migration/migration.c=C2=A0=C2=A0=C2=A0 | 40 ++++++++++++++++=
+++++-------------------
> >> =C2=A0 migration/migration.h=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> >> =C2=A0 migration/postcopy-ram.c |=C2=A0 1 +
> >> =C2=A0 migration/ram.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 28 ++++++++++++++++++----------
> >> =C2=A0 migration/ram.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 4 ++--
> >> =C2=A0 migration/savevm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 1 +
> >> =C2=A0 util/main-loop.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 8 ++++----
> >> =C2=A0 8 files changed, 54 insertions(+), 41 deletions(-)
> >>
> >=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
