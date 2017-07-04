Received: from eggs.gnu.org ([2001:4830:134:3::10]:48757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVwg-0008B9-R7
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:05:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVwg-0000TG-2B
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:05:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dSVwf-0000Sm-SM
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:05:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D937B80F94
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 22:05:20 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:25 +0200
Message-Id: <20170704220346.29244-15-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 14/35] migration: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 migration/migration.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 51ccd1a4c5..3370482637 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -303,7 +303,8 @@ static void process_incoming_migration_bh(void *opaqu=
e)
     migration_incoming_state_destroy();
 }
=20
-static void process_incoming_migration_co(void *opaque)
+static void coroutine_fn
+process_incoming_migration_co(void *opaque)
 {
     QEMUFile *f =3D opaque;
     MigrationIncomingState *mis =3D migration_incoming_get_current();
--=20
2.13.1.395.gf7b71de06
