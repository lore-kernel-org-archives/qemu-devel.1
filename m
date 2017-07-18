Received: from eggs.gnu.org ([2001:4830:134:3::10]:40532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXUzc-0006bp-9R
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:05:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXUzb-0004kU-8o
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:05:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dXUzb-0004kD-3R
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:04:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 164DB7F3E4
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 16:04:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170704220346.29244-15-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 5 Jul 2017
	00:03:25 +0200")
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<20170704220346.29244-15-marcandre.lureau@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 18 Jul 2017 18:04:53 +0200
Message-ID: <877ez5k9y2.fsf@secure.mitica>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  migration/migration.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 51ccd1a4c5..3370482637 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -303,7 +303,8 @@ static void process_incoming_migration_bh(void *opaqu=
e)
>      migration_incoming_state_destroy();
>  }
>=20=20
> -static void process_incoming_migration_co(void *opaque)
> +static void coroutine_fn
> +process_incoming_migration_co(void *opaque)
>  {
>      QEMUFile *f =3D opaque;
>      MigrationIncomingState *mis =3D migration_incoming_get_current();

Reviewed-by: Juan Quintela <quintela@redhat.com>


Should I include it on the next migration PULL or is this entering some
other way?

Later, Juan.

>  LocalWords:  Quintela
