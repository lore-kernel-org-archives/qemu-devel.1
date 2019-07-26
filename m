Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383BFC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 12:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 104C5229F9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 12:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 104C5229F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqz2u-0005FC-52
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 08:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58878)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hqyz4-0005ex-09
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hqyyu-0008EB-4w
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:05:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51782)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hqyyt-0007zW-CO
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:05:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0B13730C34CA
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 12:05:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-30.ams2.redhat.com
 [10.36.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A70DF60A35
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 12:05:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4C0DB1146439; Fri, 26 Jul 2019 14:05:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 14:05:41 +0200
Message-Id: <20190726120542.9894-28-armbru@redhat.com>
In-Reply-To: <20190726120542.9894-1-armbru@redhat.com>
References: <20190726120542.9894-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 26 Jul 2019 12:05:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 27/28] sysemu: Move the VMChangeStateEntry
 typedef to qemu/typedefs.h
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The previous commit deleted superfluous inclusions of sysemu/sysemu.h,
but that didn't really help.

Several headers include sysemu/sysemu.h just to get typedef
VMChangeStateEntry.  Move it from sysemu/sysemu.h to qemu/typedefs.h.
Spell its structure tag the same while there.

All these headers still include sysemu/sysemu.h indirectly, so this
doesn't by itself reduce its use.  It will together with the the next
commit.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/hw/ide/internal.h   | 3 ++-
 include/hw/ppc/spapr_xive.h | 1 -
 include/hw/scsi/scsi.h      | 1 -
 include/hw/virtio/virtio.h  | 1 -
 include/qemu/typedefs.h     | 1 +
 include/sysemu/sysemu.h     | 1 -
 vl.c                        | 6 +++---
 7 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index c6954c1d56..52ec197da0 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -6,11 +6,12 @@
  * only files in hw/ide/ are supposed to include this file.
  * non-internal declarations are in hw/ide.h
  */
+
+#include "qapi/qapi-types-run-state.h"
 #include "hw/ide.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
 #include "sysemu/dma.h"
-#include "sysemu/sysemu.h"
 #include "hw/block/block.h"
 #include "scsi/constants.h"
=20
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index a39e672f27..bfd40f01d8 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -12,7 +12,6 @@
=20
 #include "hw/ppc/spapr_irq.h"
 #include "hw/ppc/xive.h"
-#include "sysemu/sysemu.h"
=20
 #define TYPE_SPAPR_XIVE "spapr-xive"
 #define SPAPR_XIVE(obj) OBJECT_CHECK(SpaprXive, (obj), TYPE_SPAPR_XIVE)
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 2bfaad0fe9..d77a92361b 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -4,7 +4,6 @@
 #include "block/aio.h"
 #include "hw/block/block.h"
 #include "hw/qdev-core.h"
-#include "sysemu/sysemu.h"
 #include "scsi/utils.h"
 #include "qemu/notify.h"
=20
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index df40a46d60..48e8d04ff6 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -17,7 +17,6 @@
 #include "exec/memory.h"
 #include "hw/qdev-core.h"
 #include "net/net.h"
-#include "sysemu/sysemu.h"
 #include "migration/vmstate.h"
 #include "qemu/event_notifier.h"
 #include "standard-headers/linux/virtio_config.h"
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index f569f5f270..3fcdde8bfc 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -102,6 +102,7 @@ typedef struct SHPCDevice SHPCDevice;
 typedef struct SSIBus SSIBus;
 typedef struct VirtIODevice VirtIODevice;
 typedef struct Visitor Visitor;
+typedef struct VMChangeStateEntry VMChangeStateEntry;
 typedef struct VMStateDescription VMStateDescription;
=20
 /*
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 227202999d..7e445e0683 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -22,7 +22,6 @@ void runstate_set(RunState new_state);
 int runstate_is_running(void);
 bool runstate_needs_reset(void);
 bool runstate_store(char *str, size_t size);
-typedef struct vm_change_state_entry VMChangeStateEntry;
 typedef void VMChangeStateHandler(void *opaque, int running, RunState st=
ate);
=20
 VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandle=
r *cb,
diff --git a/vl.c b/vl.c
index df23dd6913..91255acf71 100644
--- a/vl.c
+++ b/vl.c
@@ -1362,14 +1362,14 @@ static int machine_help_func(QemuOpts *opts, Mach=
ineState *machine)
     return 1;
 }
=20
-struct vm_change_state_entry {
+struct VMChangeStateEntry {
     VMChangeStateHandler *cb;
     void *opaque;
-    QTAILQ_ENTRY(vm_change_state_entry) entries;
+    QTAILQ_ENTRY(VMChangeStateEntry) entries;
     int priority;
 };
=20
-static QTAILQ_HEAD(, vm_change_state_entry) vm_change_state_head;
+static QTAILQ_HEAD(, VMChangeStateEntry) vm_change_state_head;
=20
 /**
  * qemu_add_vm_change_state_handler_prio:
--=20
2.21.0


