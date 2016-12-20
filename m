Received: from eggs.gnu.org ([2001:4830:134:3::10]:59706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cJORq-0001NN-AH
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 12:43:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cJORp-0008RW-Fg
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 12:43:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cJORp-0008RI-9d
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 12:43:33 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 20 Dec 2016 15:43:08 -0200
Message-Id: <1482255793-19057-3-git-send-email-ehabkost@redhat.com>
In-Reply-To: <1482255793-19057-1-git-send-email-ehabkost@redhat.com>
References: <1482255793-19057-1-git-send-email-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 2/7] xen: Move xen files to accel/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xensource.com

Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: xen-devel@lists.xensource.com
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 Makefile.target                        | 4 +---
 xen-common.c => accel/xen-common.c     | 0
 xen-hvm.c => accel/xen-hvm.c           | 0
 xen-mapcache.c => accel/xen-mapcache.c | 0
 MAINTAINERS                            | 1 -
 accel/Makefile.objs                    | 2 ++
 6 files changed, 3 insertions(+), 4 deletions(-)
 rename xen-common.c => accel/xen-common.c (100%)
 rename xen-hvm.c => accel/xen-hvm.c (100%)
 rename xen-mapcache.c => accel/xen-mapcache.c (100%)
 create mode 100644 accel/Makefile.objs

diff --git a/Makefile.target b/Makefile.target
index 7c2fda9..0b2ad86 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -144,9 +144,7 @@ obj-y += dump.o
 obj-y += migration/ram.o migration/savevm.o
 LIBS := $(libs_softmmu) $(LIBS)
 
-# xen support
-obj-$(CONFIG_XEN) += xen-common.o
-obj-$(CONFIG_XEN_I386) += xen-hvm.o xen-mapcache.o
+obj-y += accel/
 
 # Hardware support
 ifeq ($(TARGET_NAME), sparc64)
diff --git a/xen-common.c b/accel/xen-common.c
similarity index 100%
rename from xen-common.c
rename to accel/xen-common.c
diff --git a/xen-hvm.c b/accel/xen-hvm.c
similarity index 100%
rename from xen-hvm.c
rename to accel/xen-hvm.c
diff --git a/xen-mapcache.c b/accel/xen-mapcache.c
similarity index 100%
rename from xen-mapcache.c
rename to accel/xen-mapcache.c
diff --git a/MAINTAINERS b/MAINTAINERS
index 4a60579..8e25438 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -311,7 +311,6 @@ M: Stefano Stabellini <sstabellini@kernel.org>
 M: Anthony Perard <anthony.perard@citrix.com>
 L: xen-devel@lists.xensource.com
 S: Supported
-F: xen-*
 F: */xen*
 F: hw/char/xen_console.c
 F: hw/display/xenfb.c
diff --git a/accel/Makefile.objs b/accel/Makefile.objs
new file mode 100644
index 0000000..6f3630e
--- /dev/null
+++ b/accel/Makefile.objs
@@ -0,0 +1,2 @@
+obj-$(CONFIG_XEN) += xen-common.o
+obj-$(CONFIG_XEN_I386) += xen-hvm.o xen-mapcache.o
-- 
2.7.4
