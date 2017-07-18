Received: from eggs.gnu.org ([2001:4830:134:3::10]:49338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dXVFJ-0002VL-9Z
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dXVFG-0006Vc-57
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:21:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dXVFF-0006VT-V9
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:21:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0606B7F408
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 16:21:08 +0000 (UTC)
Date: Tue, 18 Jul 2017 12:21:07 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1561464108.54982839.1500394867090.JavaMail.zimbra@redhat.com>
In-Reply-To: <877ez5k9y2.fsf@secure.mitica>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<20170704220346.29244-15-marcandre.lureau@redhat.com>
	<877ez5k9y2.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 14/35] migration: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi

----- Original Message -----
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  migration/migration.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 51ccd1a4c5..3370482637 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -303,7 +303,8 @@ static void process_incoming_migration_bh(void *opa=
que)
> >      migration_incoming_state_destroy();
> >  }
> > =20
> > -static void process_incoming_migration_co(void *opaque)
> > +static void coroutine_fn
> > +process_incoming_migration_co(void *opaque)
> >  {
> >      QEMUFile *f =3D opaque;
> >      MigrationIncomingState *mis =3D migration_incoming_get_current();
>=20
> Reviewed-by: Juan Quintela <quintela@redhat.com>
>=20
>=20
> Should I include it on the next migration PULL or is this entering some
> other way?

Not the I know of, feel free to include it next time.

Thanks
