Received: from eggs.gnu.org ([2001:4830:134:3::10]:39173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ctr7X-0001LQ-CA
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 03:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ctr7U-0006xw-AQ
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 03:37:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ctr7U-0006xl-40
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 03:37:16 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 31 Mar 2017 15:36:30 +0800
Message-Id: <1490945793-21276-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1490945793-21276-1-git-send-email-peterx@redhat.com>
References: <1490945793-21276-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 2/5] util: export device_init_func()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, Paolo Bonzini <pbonzini@redhat.com>, kevin.tian@intel.com, yi.l.liu@intel.com, Marcel Apfelbaum <marcel@redhat.com>, "\\  Michael S . Tsirkin \\ " <mst@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>

This general routine is used to create most of the "-device" objects.
Export it so that other modules can use it as well.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qemu-common.h | 1 +
 vl.c                  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/qemu-common.h b/include/qemu-common.h
index d218821..0e6bb3b 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -125,6 +125,7 @@ const char *qemu_get_vm_name(void);
 #define QEMU_FILE_TYPE_BIOS   0
 #define QEMU_FILE_TYPE_KEYMAP 1
 char *qemu_find_file(int type, const char *name);
+int device_init_func(void *opaque, QemuOpts *opts, Error **errp);
 
 /* OS specific functions */
 void os_setup_early_signal_handling(void);
diff --git a/vl.c b/vl.c
index 0b4ed52..b97b32a 100644
--- a/vl.c
+++ b/vl.c
@@ -2297,7 +2297,7 @@ static int device_help_func(void *opaque, QemuOpts *opts, Error **errp)
     return qdev_device_help(opts);
 }
 
-static int device_init_func(void *opaque, QemuOpts *opts, Error **errp)
+int device_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
     Error *err = NULL;
     DeviceState *dev;
-- 
2.7.4
