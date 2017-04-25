Received: from eggs.gnu.org ([2001:4830:134:3::10]:55568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38ap-0007X0-Fn
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38ao-0005nn-B7
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d38ao-0005mz-50
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 292B57E9D4
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:05:53 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:04:39 +0200
Message-Id: <20170425220451.6028-30-quintela@redhat.com>
In-Reply-To: <20170425220451.6028-1-quintela@redhat.com>
References: <20170425220451.6028-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 29/41] migration: loadvm_free_handlers is only
 used in migration/
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/vmstate.h | 2 --
 migration/savevm.h          | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 6b7031f..afa43ac 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -955,8 +955,6 @@ extern const VMStateInfo vmstate_info_qtailq;
 #define VMSTATE_END_OF_LIST()                                         \
     {}
 
-void loadvm_free_handlers(MigrationIncomingState *mis);
-
 int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, int version_id);
 void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
diff --git a/migration/savevm.h b/migration/savevm.h
index f4c4bc9..75b2b8c 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -38,4 +38,6 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
 
 int qemu_loadvm_state(QEMUFile *f);
 
+void loadvm_free_handlers(MigrationIncomingState *mis);
+
 #endif
-- 
2.9.3
