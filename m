Received: from eggs.gnu.org ([2001:4830:134:3::10]:59777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cJOS0-0001TU-NB
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 12:43:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cJORy-0008Tm-EH
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 12:43:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cJORy-0008Te-8L
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 12:43:42 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6A7F93F757
	for <qemu-devel@nongnu.org>; Tue, 20 Dec 2016 17:43:41 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 20 Dec 2016 15:43:13 -0200
Message-Id: <1482255793-19057-8-git-send-email-ehabkost@redhat.com>
In-Reply-To: <1482255793-19057-1-git-send-email-ehabkost@redhat.com>
References: <1482255793-19057-1-git-send-email-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 7/7] accel: Move qtest.c to accel/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 Makefile.target          | 2 +-
 qtest.c => accel/qtest.c | 0
 accel/Makefile.objs      | 2 ++
 3 files changed, 3 insertions(+), 1 deletion(-)
 rename qtest.c => accel/qtest.c (100%)

diff --git a/Makefile.target b/Makefile.target
index 70a1261..fd319ac 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -134,7 +134,7 @@ endif #CONFIG_BSD_USER
 # System emulator target
 ifdef CONFIG_SOFTMMU
 obj-y += arch_init.o cpus.o monitor.o gdbstub.o balloon.o ioport.o numa.o
-obj-y += qtest.o bootdevice.o
+obj-y += bootdevice.o
 obj-y += hw/
 obj-y += memory.o cputlb.o
 obj-y += memory_mapping.o
diff --git a/qtest.c b/accel/qtest.c
similarity index 100%
rename from qtest.c
rename to accel/qtest.c
diff --git a/accel/Makefile.objs b/accel/Makefile.objs
index 52f7cac..a71bc78 100644
--- a/accel/Makefile.objs
+++ b/accel/Makefile.objs
@@ -4,4 +4,6 @@ obj-$(CONFIG_XEN_I386) += xen-hvm.o xen-mapcache.o
 obj-$(CONFIG_KVM) += kvm-common.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
 
+obj-y += qtest.o
+
 common-obj-y = accel.o
-- 
2.7.4
