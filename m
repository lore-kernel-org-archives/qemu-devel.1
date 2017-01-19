Received: from eggs.gnu.org ([2001:4830:134:3::10]:34896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cUJtB-0004du-PB
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:04:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cUJtA-0001DO-6Y
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:04:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cUJtA-0001CP-0b
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:04:56 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2F7EC7FE87
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 21:04:56 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 19 Jan 2017 19:04:44 -0200
Message-Id: <20170119210449.11991-2-ehabkost@redhat.com>
In-Reply-To: <20170119210449.11991-1-ehabkost@redhat.com>
References: <20170119210449.11991-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 1/6] i386: Unset
 cannot_destroy_with_object_finalize_yet on "host" model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The class is now safe because the assert(kvm_enabled()) line was
removed by commit e435601058e656e6d24e3e87b187e5518f7bf16a.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index cff23e129d..7947c8737c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1571,8 +1571,6 @@ static void host_x86_cpu_class_init(ObjectClass *oc, void *data)
      */
 
     dc->props = host_x86_cpu_properties;
-    /* Reason: host_x86_cpu_initfn() dies when !kvm_enabled() */
-    dc->cannot_destroy_with_object_finalize_yet = true;
 }
 
 static void host_x86_cpu_initfn(Object *obj)
-- 
2.11.0.259.g40922b1
