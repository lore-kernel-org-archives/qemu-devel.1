Received: from eggs.gnu.org ([2001:4830:134:3::10]:60378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGXfH-0008Jy-8A
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 17:29:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGXfE-00081e-J1
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 17:29:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9169)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dGXfE-000812-DD
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 17:29:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 618CD142A74
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 21:29:51 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  1 Jun 2017 23:29:14 +0200
Message-Id: <20170601212921.30241-5-quintela@redhat.com>
In-Reply-To: <20170601212921.30241-1-quintela@redhat.com>
References: <20170601212921.30241-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 04/11] migration: Move
 dump_vmsate_json_to_file() to misc.h
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

It was not from vmstate.c to start with.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/misc.h    | 4 ++++
 include/migration/vmstate.h | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 60486d4..026b561 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -36,4 +36,8 @@ int64_t self_announce_delay(int round)
     return 50 + (SELF_ANNOUNCE_ROUNDS - round - 1) * 100;
 }
 
+/* migration/savevm.c */
+
+void dump_vmstate_json_to_file(FILE *out_fp);
+
 #endif
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 6de554d..ad243d4 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1004,8 +1004,6 @@ void vmstate_register_ram(struct MemoryRegion *memory, DeviceState *dev);
 void vmstate_unregister_ram(struct MemoryRegion *memory, DeviceState *dev);
 void vmstate_register_ram_global(struct MemoryRegion *memory);
 
-void dump_vmstate_json_to_file(FILE *out_fp);
-
 bool vmstate_check_only_migratable(const VMStateDescription *vmsd);
 
 #endif
-- 
2.9.4
