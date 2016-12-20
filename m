Received: from eggs.gnu.org ([2001:4830:134:3::10]:59775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cJOS0-0001TR-ML
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 12:43:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cJORw-0008TP-K0
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 12:43:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cJORw-0008TI-Eu
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 12:43:40 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 913A87F7C0
	for <qemu-devel@nongnu.org>; Tue, 20 Dec 2016 17:43:39 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 20 Dec 2016 15:43:12 -0200
Message-Id: <1482255793-19057-7-git-send-email-ehabkost@redhat.com>
In-Reply-To: <1482255793-19057-1-git-send-email-ehabkost@redhat.com>
References: <1482255793-19057-1-git-send-email-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 6/7] accel: Move accel.c to accel/
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
 Makefile.objs            | 2 +-
 accel.c => accel/accel.c | 0
 accel/Makefile.objs      | 2 ++
 3 files changed, 3 insertions(+), 1 deletion(-)
 rename accel.c => accel/accel.c (100%)

diff --git a/Makefile.objs b/Makefile.objs
index 06f74b8..6d62f54 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -58,7 +58,7 @@ common-obj-$(CONFIG_SPICE) += spice-qemu-char.o
 
 common-obj-y += audio/
 common-obj-y += hw/
-common-obj-y += accel.o
+common-obj-y += accel/
 
 common-obj-y += replay/
 
diff --git a/accel.c b/accel/accel.c
similarity index 100%
rename from accel.c
rename to accel/accel.c
diff --git a/accel/Makefile.objs b/accel/Makefile.objs
index 3f3866d..52f7cac 100644
--- a/accel/Makefile.objs
+++ b/accel/Makefile.objs
@@ -3,3 +3,5 @@ obj-$(CONFIG_XEN_I386) += xen-hvm.o xen-mapcache.o
 
 obj-$(CONFIG_KVM) += kvm-common.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
+
+common-obj-y = accel.o
-- 
2.7.4
