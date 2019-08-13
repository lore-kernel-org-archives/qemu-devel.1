Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD9AC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:56:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8559C20840
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8559C20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxZ9b-0006GU-Pe
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 11:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52439)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hxZ15-0004Mt-Cn
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hxZ13-0002YN-SL
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:47:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44828)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hxZ13-0002Xq-LC
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:47:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F0884307BCC4;
 Tue, 13 Aug 2019 15:47:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EA6118E35;
 Tue, 13 Aug 2019 15:47:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EEDF3113304E; Tue, 13 Aug 2019 17:46:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 13 Aug 2019 17:46:49 +0200
Message-Id: <20190813154653.20568-26-armbru@redhat.com>
In-Reply-To: <20190813154653.20568-1-armbru@redhat.com>
References: <20190813154653.20568-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 13 Aug 2019 15:47:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 25/29] numa: Move remaining NUMA declarations
 from sysemu.h to numa.h
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit e35704ba9c "numa: Move NUMA declarations from sysemu.h to
numa.h" left a few NUMA-related macros behind.  Move them now.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190812052359.30071-26-armbru@redhat.com>
---
 include/sysemu/hostmem.h | 2 +-
 include/sysemu/numa.h    | 9 +++++++--
 include/sysemu/sysemu.h  | 7 -------
 exec.c                   | 2 +-
 hw/core/numa.c           | 1 +
 hw/mem/pc-dimm.c         | 1 +
 hw/pci/pci.c             | 2 +-
 hw/ppc/spapr.c           | 1 +
 8 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index afeb5db1b1..4dbdadd39e 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -13,7 +13,7 @@
 #ifndef SYSEMU_HOSTMEM_H
 #define SYSEMU_HOSTMEM_H
=20
-#include "sysemu/sysemu.h" /* for MAX_NODES */
+#include "sysemu/numa.h"
 #include "qapi/qapi-types-machine.h"
 #include "qom/object.h"
 #include "exec/memory.h"
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 4c4c1dee9b..7a4ce89765 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -2,13 +2,18 @@
 #define SYSEMU_NUMA_H
=20
 #include "qemu/bitmap.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/hostmem.h"
 #include "qapi/qapi-types-machine.h"
 #include "exec/cpu-common.h"
=20
 struct CPUArchId;
=20
+#define MAX_NODES 128
+#define NUMA_NODE_UNASSIGNED MAX_NODES
+#define NUMA_DISTANCE_MIN         10
+#define NUMA_DISTANCE_DEFAULT     20
+#define NUMA_DISTANCE_MAX         254
+#define NUMA_DISTANCE_UNREACHABLE 255
+
 extern int nb_numa_nodes;   /* Number of NUMA nodes */
 extern bool have_numa_distance;
=20
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index ac18a1184a..227202999d 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -117,13 +117,6 @@ extern QEMUClockType rtc_clock;
 extern const char *mem_path;
 extern int mem_prealloc;
=20
-#define MAX_NODES 128
-#define NUMA_NODE_UNASSIGNED MAX_NODES
-#define NUMA_DISTANCE_MIN         10
-#define NUMA_DISTANCE_DEFAULT     20
-#define NUMA_DISTANCE_MAX         254
-#define NUMA_DISTANCE_UNREACHABLE 255
-
 #define MAX_OPTION_ROMS 16
 typedef struct QEMUOptionRom {
     const char *name;
diff --git a/exec.c b/exec.c
index 78f849de99..4aaa14b075 100644
--- a/exec.c
+++ b/exec.c
@@ -45,7 +45,7 @@
 #include "exec/memory.h"
 #include "exec/ioport.h"
 #include "sysemu/dma.h"
-#include "sysemu/numa.h"
+#include "sysemu/hostmem.h"
 #include "sysemu/hw_accel.h"
 #include "exec/address-spaces.h"
 #include "sysemu/xen-mapcache.h"
diff --git a/hw/core/numa.c b/hw/core/numa.c
index d817f06ead..450c522dd8 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "sysemu/hostmem.h"
 #include "sysemu/numa.h"
 #include "exec/cpu-common.h"
 #include "exec/ramlist.h"
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index dea48f9163..7c324a1329 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -28,6 +28,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qemu/module.h"
+#include "sysemu/hostmem.h"
 #include "sysemu/numa.h"
 #include "trace.h"
=20
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 9001b81daa..4b6ffab13d 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -34,7 +34,7 @@
 #include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "net/net.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/numa.h"
 #include "hw/loader.h"
 #include "qemu/error-report.h"
 #include "qemu/range.h"
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 06d23a5004..4044e61a0c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -29,6 +29,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/hostmem.h"
 #include "sysemu/numa.h"
 #include "sysemu/qtest.h"
 #include "sysemu/reset.h"
--=20
2.21.0


