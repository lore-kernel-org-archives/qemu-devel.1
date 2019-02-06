Received: from eggs.gnu.org ([209.51.188.92]:55067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1grNBG-0006Wq-9l
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:23:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1grNBF-0007eZ-Jj
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:23:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1grNBF-0007eT-Ef
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:23:57 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C9BCF7F6C8
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 13:23:56 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  6 Feb 2019 14:23:28 +0100
Message-Id: <20190206132331.1694-2-quintela@redhat.com>
In-Reply-To: <20190206132331.1694-1-quintela@redhat.com>
References: <20190206132331.1694-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/4] multifd: Change page count default to 128
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

I haven't seend any problem about using 64 or 128.  And it make much
less contention on the locks.  Just change it.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index ef1d53cde2..f673486679 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -81,7 +81,7 @@
 /* The delay time (in ms) between two COLO checkpoints */
 #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)
 #define DEFAULT_MIGRATE_MULTIFD_CHANNELS 2
-#define DEFAULT_MIGRATE_MULTIFD_PAGE_COUNT 16
+#define DEFAULT_MIGRATE_MULTIFD_PAGE_COUNT 128
=20
 /* Background transfer rate for postcopy, 0 means unlimited, note
  * that page requests can still exceed this limit.
--=20
2.20.1
