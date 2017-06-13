Received: from eggs.gnu.org ([2001:4830:134:3::10]:57116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiUA-0001Br-Hj
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiU9-0003Mp-On
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dKiU9-0003MT-Jd
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8BCE080485
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 09:51:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 13 Jun 2017 11:51:14 +0200
Message-Id: <20170613095120.11373-9-quintela@redhat.com>
In-Reply-To: <20170613095120.11373-1-quintela@redhat.com>
References: <20170613095120.11373-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/14] migration: Move
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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
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
=20
+/* migration/savevm.c */
+
+void dump_vmstate_json_to_file(FILE *out_fp);
+
 #endif
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 9ad4ba1..79a4b35 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1003,8 +1003,6 @@ void vmstate_register_ram(struct MemoryRegion *memo=
ry, DeviceState *dev);
 void vmstate_unregister_ram(struct MemoryRegion *memory, DeviceState *de=
v);
 void vmstate_register_ram_global(struct MemoryRegion *memory);
=20
-void dump_vmstate_json_to_file(FILE *out_fp);
-
 bool vmstate_check_only_migratable(const VMStateDescription *vmsd);
=20
 #endif
--=20
2.9.4
