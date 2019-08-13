Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ECBC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:56:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75BE820578
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BE820578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxZ9c-0006KR-NJ
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 11:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52598)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hxZ1Q-0004kC-Mz
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hxZ1O-0002ke-Cj
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:47:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16743)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hxZ1O-0002jh-7l
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:47:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9143783F45;
 Tue, 13 Aug 2019 15:47:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C76A18E35;
 Tue, 13 Aug 2019 15:47:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E7B22113645E; Tue, 13 Aug 2019 17:46:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 13 Aug 2019 17:46:47 +0200
Message-Id: <20190813154653.20568-24-armbru@redhat.com>
In-Reply-To: <20190813154653.20568-1-armbru@redhat.com>
References: <20190813154653.20568-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 13 Aug 2019 15:47:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 23/29] numa: Don't include hw/boards.h into
 sysemu/numa.h
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
Cc: Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

sysemu/numa.h includes hw/boards.h just for the CPUArchId typedef, at
the cost of pulling in more than two dozen extra headers indirectly.

I could move the typedef from hw/boards.h to qemu/typedefs.h.  But
it's used in just two headers: boards.h and numa.h.

I could move it to another header both its users include.
exec/cpu-common.h seems to be the least bad fit.

But I'm keeping this simple & stupid: declare the struct tag in
numa.h.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190812052359.30071-24-armbru@redhat.com>
---
 include/hw/boards.h   | 2 +-
 include/sysemu/numa.h | 9 +++++++--
 hw/mem/pc-dimm.c      | 1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 67e551636a..739d109fe1 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -86,7 +86,7 @@ void machine_class_allow_dynamic_sysbus_dev(MachineClas=
s *mc, const char *type);
  * @props - CPU object properties, initialized by board
  * #vcpus_count - number of threads provided by @cpu object
  */
-typedef struct {
+typedef struct CPUArchId {
     uint64_t arch_id;
     int64_t vcpus_count;
     CpuInstanceProperties props;
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 01a263eba2..4c4c1dee9b 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -4,7 +4,10 @@
 #include "qemu/bitmap.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/hostmem.h"
-#include "hw/boards.h"
+#include "qapi/qapi-types-machine.h"
+#include "exec/cpu-common.h"
+
+struct CPUArchId;
=20
 extern int nb_numa_nodes;   /* Number of NUMA nodes */
 extern bool have_numa_distance;
@@ -32,5 +35,7 @@ void numa_legacy_auto_assign_ram(MachineClass *mc, Node=
Info *nodes,
                                  int nb_nodes, ram_addr_t size);
 void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
                                   int nb_nodes, ram_addr_t size);
-void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **=
errp);
+void numa_cpu_pre_plug(const struct CPUArchId *slot, DeviceState *dev,
+                       Error **errp);
+
 #endif
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 1f3e676066..dea48f9163 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -19,6 +19,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/boards.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
--=20
2.21.0


