Received: from eggs.gnu.org ([2001:4830:134:3::10]:59704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cJORq-0001NM-0t
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 12:43:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cJORn-0008Qz-BP
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 12:43:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cJORn-0008Qs-5C
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 12:43:31 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 20 Dec 2016 15:43:07 -0200
Message-Id: <1482255793-19057-2-git-send-email-ehabkost@redhat.com>
In-Reply-To: <1482255793-19057-1-git-send-email-ehabkost@redhat.com>
References: <1482255793-19057-1-git-send-email-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 1/7] xen: Move xen-*-stub.c to stubs/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xensource.com, Paolo Bonzini <pbonzini@redhat.com>

Move xen stubs to stubs/ so they are handled automatically by
libqemustub.a.

Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: xen-devel@lists.xensource.com
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 Makefile.target                   | 2 --
 xen-hvm-stub.c => stubs/xen-hvm.c | 0
 xen-common-stub.c => stubs/xen.c  | 0
 stubs/Makefile.objs               | 2 ++
 4 files changed, 2 insertions(+), 2 deletions(-)
 rename xen-hvm-stub.c => stubs/xen-hvm.c (100%)
 rename xen-common-stub.c => stubs/xen.c (100%)

diff --git a/Makefile.target b/Makefile.target
index 7a5080e..7c2fda9 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -147,8 +147,6 @@ LIBS := $(libs_softmmu) $(LIBS)
 # xen support
 obj-$(CONFIG_XEN) += xen-common.o
 obj-$(CONFIG_XEN_I386) += xen-hvm.o xen-mapcache.o
-obj-$(call lnot,$(CONFIG_XEN)) += xen-common-stub.o
-obj-$(call lnot,$(CONFIG_XEN_I386)) += xen-hvm-stub.o
 
 # Hardware support
 ifeq ($(TARGET_NAME), sparc64)
diff --git a/xen-hvm-stub.c b/stubs/xen-hvm.c
similarity index 100%
rename from xen-hvm-stub.c
rename to stubs/xen-hvm.c
diff --git a/xen-common-stub.c b/stubs/xen.c
similarity index 100%
rename from xen-common-stub.c
rename to stubs/xen.c
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 2b5bb74..227e154 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -50,3 +50,5 @@ stub-obj-y += smbios_type_38.o
 stub-obj-y += ipmi.o
 stub-obj-y += pc_madt_cpu_entry.o
 stub-obj-y += migration-colo.o
+stub-obj-y += xen.o
+stub-obj-y += xen-hvm.o
-- 
2.7.4
