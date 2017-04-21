Received: from eggs.gnu.org ([2001:4830:134:3::10]:46095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XDG-0003fa-Oi
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XDC-0007vX-Te
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:58:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d1XDC-0007vO-N9
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:58:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 966AC2EAAB4
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 11:58:53 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 21 Apr 2017 13:56:43 +0200
Message-Id: <20170421115646.15544-63-quintela@redhat.com>
In-Reply-To: <20170421115646.15544-1-quintela@redhat.com>
References: <20170421115646.15544-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 62/65] migration: set current_active_state once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

We set it right above this one. No need to set it twice.

CC: Juan Quintela <quintela@redhat.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 31e8141..dd7f721 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1941,7 +1941,6 @@ static void *migration_thread(void *opaque)
     qemu_savevm_state_begin(s->to_dst_file, &s->params);
=20
     s->setup_time =3D qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
-    current_active_state =3D MIGRATION_STATUS_ACTIVE;
     migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                       MIGRATION_STATUS_ACTIVE);
=20
--=20
2.9.3
