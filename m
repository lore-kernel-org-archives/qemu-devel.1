Received: from eggs.gnu.org ([2001:4830:134:3::10]:48441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d9D0h-0002rw-EI
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d9D0g-0005Nw-2R
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:01:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d9D0f-0005Mk-Tn
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:01:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D2B9234A6
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 16:01:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 12 May 2017 18:00:55 +0200
Message-Id: <20170512160055.9081-13-quintela@redhat.com>
In-Reply-To: <20170512160055.9081-1-quintela@redhat.com>
References: <20170512160055.9081-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 12/12] migration: migration.h was not needed
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

This files don't use any function from migration.h, so drop it.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 block/qed.c             | 1 -
 hw/i386/pc_q35.c        | 1 -
 hw/virtio/vhost-user.c  | 1 -
 hw/virtio/vhost-vsock.c | 1 -
 hw/virtio/virtio.c      | 1 -
 monitor.c               | 1 -
 6 files changed, 6 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index fd76817..8d899fd 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -19,7 +19,6 @@
 #include "trace.h"
 #include "qed.h"
 #include "qapi/qmp/qerror.h"
-#include "migration/migration.h"
 #include "sysemu/block-backend.h"
 
 static const AIOCBInfo qed_aiocb_info = {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index dd792a8..76b08f8 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -46,7 +46,6 @@
 #include "hw/ide/ahci.h"
 #include "hw/usb.h"
 #include "qemu/error-report.h"
-#include "migration/migration.h"
 
 /* ICH9 AHCI has 6 ports */
 #define MAX_SATA_PORTS     6
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 9334a8a..ebc8ccf 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -17,7 +17,6 @@
 #include "sysemu/kvm.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
-#include "migration/migration.h"
 
 #include <sys/ioctl.h>
 #include <sys/socket.h>
diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index b481562..49e0022 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -17,7 +17,6 @@
 #include "qapi/error.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
-#include "migration/migration.h"
 #include "qemu/error-report.h"
 #include "hw/virtio/vhost-vsock.h"
 #include "qemu/iov.h"
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 03592c5..2d2b6bf 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -21,7 +21,6 @@
 #include "hw/virtio/virtio.h"
 #include "qemu/atomic.h"
 #include "hw/virtio/virtio-bus.h"
-#include "migration/migration.h"
 #include "hw/virtio/virtio-access.h"
 #include "sysemu/dma.h"
 
diff --git a/monitor.c b/monitor.c
index 078cba5..fa295c4 100644
--- a/monitor.c
+++ b/monitor.c
@@ -49,7 +49,6 @@
 #include "disas/disas.h"
 #include "sysemu/balloon.h"
 #include "qemu/timer.h"
-#include "migration/migration.h"
 #include "sysemu/hw_accel.h"
 #include "qemu/acl.h"
 #include "sysemu/tpm.h"
-- 
2.9.3
