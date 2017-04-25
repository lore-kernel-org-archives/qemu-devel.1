Received: from eggs.gnu.org ([2001:4830:134:3::10]:45896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d2xXt-00006V-Md
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d2xXo-0006hy-3o
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:18:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d2xXn-0006ht-U3
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:18:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC8893B71F
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 10:18:02 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 25 Apr 2017 12:17:56 +0200
Message-Id: <20170425101758.3944-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Misc migration fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Hi

This are independent of all my series, so send then here.

- check_migratable needs to now about objects, device class, etc, that
  migration code don't care.  So move it to qdev.c.

- to_dst_file is set to NULL before this call, just remove it.  Long
  term idea is that nothing outside migration.c should now about
  members of MigrationState.

Please, review.

Juan Quintela (2):
  migration: Move check_migratable() into qdev.c
  migration: to_dst_file at that point is NULL

 hw/core/qdev.c                | 15 ++++++++++++++-
 include/migration/migration.h |  3 ---
 include/migration/vmstate.h   |  2 ++
 migration/migration.c         | 15 ---------------
 migration/savevm.c            | 10 ++++++++++
 migration/socket.c            |  1 -
 migration/tls.c               |  1 -
 stubs/vmstate.c               |  5 ++---
 8 files changed, 28 insertions(+), 24 deletions(-)

-- 
2.9.3
