Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5411C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:18:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF98720775
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jmacZJXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF98720775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpETN-0004Sr-TT
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 13:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpEN3-00028v-4P
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:12:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48162)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpEMz-0007PW-Pq
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:12:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RH2KqD156328;
 Sat, 27 Jun 2020 17:11:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=XhxaWg4QsxSZZBdKA4EujWfXqG4S2H13WsNoHJUbqLQ=;
 b=jmacZJXq7FqeVezql+X7f06yH0uaptMs5fEAkdlhKSLacjO9i1OPqmvqHkXdx9dC6bol
 9OXeps0urB3ucyee6T7cX5Ydp7UY5cClWFO2WA5JRup0gdd8ihPsyGCz6m7Ad7tPqA1n
 k/UgyhHjwjy9D2FUS/SBUXStBmksWheMnQ+6WasC+7IL3ZgPG2RgtTHawE6wDbEvf1t5
 PX4wjt2/NIVXdBN00sLlwwkeD405Ye2Pwiy4hUgIu+zQ6rO1g2cq2qCDOqbVmw76fb7o
 DOg58anPNTEbgCQas35k3E6nGm6CbnAXdhl+iRMCzEbvbtaVEsNOoL9Ot/q2Rcl9Z1Si bA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 31wx2m9b11-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 27 Jun 2020 17:11:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RH8Hdf080915;
 Sat, 27 Jun 2020 17:09:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 31wv59awae-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 27 Jun 2020 17:09:56 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05RH9sdG002820;
 Sat, 27 Jun 2020 17:09:54 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 27 Jun 2020 10:09:53 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v7 04/21] multi-process: setup a machine object for remote
 device process
Date: Sat, 27 Jun 2020 10:09:26 -0700
Message-Id: <e0192d9ae8c34016a834872dc037a04b4d66fdda.1593273671.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1593273671.git.elena.ufimtseva@oracle.com>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9665
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=1 bulkscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006270124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9665
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 impostorscore=0 cotscore=-2147483648 priorityscore=1501 malwarescore=0
 phishscore=0 suspectscore=1 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006270123
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=elena.ufimtseva@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 13:10:09
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jagannathan Raman <jag.raman@oracle.com>

remote-machine object sets up various subsystems of the remote
device process. Instantiate PCI host bridge object and initialize RAM, IO &
PCI memory regions.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 MAINTAINERS              |  2 ++
 hw/i386/Makefile.objs    |  1 +
 hw/i386/remote.c         | 64 ++++++++++++++++++++++++++++++++++++++++
 include/hw/i386/remote.h | 31 +++++++++++++++++++
 4 files changed, 98 insertions(+)
 create mode 100644 hw/i386/remote.c
 create mode 100644 include/hw/i386/remote.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e46f1960bf..83aae5b441 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2945,6 +2945,8 @@ M: John G Johnson <john.g.johnson@oracle.com>
 S: Maintained
 F: hw/pci-host/remote.c
 F: include/hw/pci-host/remote.h
+F: hw/i386/remote.c
+F: include/hw/i386/remote.h
 
 Build and test automation
 -------------------------
diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 6abc74551a..5ead266a15 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -14,6 +14,7 @@ obj-$(CONFIG_XEN) += ../xenpv/ xen/
 obj-$(CONFIG_VMPORT) += vmport.o
 obj-$(CONFIG_VMMOUSE) += vmmouse.o
 obj-$(CONFIG_PC) += port92.o
+obj-$(CONFIG_MPQEMU) += remote.o
 
 obj-y += kvmvapic.o
 obj-$(CONFIG_ACPI) += acpi-common.o
diff --git a/hw/i386/remote.c b/hw/i386/remote.c
new file mode 100644
index 0000000000..4d13abe9f3
--- /dev/null
+++ b/hw/i386/remote.c
@@ -0,0 +1,64 @@
+/*
+ * Machine for remote device
+ *
+ * Copyright © 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+
+#include "hw/i386/remote.h"
+#include "exec/address-spaces.h"
+#include "exec/memory.h"
+#include "qapi/error.h"
+
+static void remote_machine_init(MachineState *machine)
+{
+    MemoryRegion *system_memory, *system_io, *pci_memory;
+    RemMachineState *s = REMOTE_MACHINE(machine);
+    RemotePCIHost *rem_host;
+
+    system_memory = get_system_memory();
+    system_io = get_system_io();
+
+    pci_memory = g_new(MemoryRegion, 1);
+    memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
+
+    rem_host = REMOTE_HOST_DEVICE(qdev_new(TYPE_REMOTE_HOST_DEVICE));
+
+    rem_host->mr_pci_mem = pci_memory;
+    rem_host->mr_sys_mem = system_memory;
+    rem_host->mr_sys_io = system_io;
+
+    s->host = rem_host;
+
+    object_property_add_child(OBJECT(s), "remote-device", OBJECT(rem_host));
+    memory_region_add_subregion_overlap(system_memory, 0x0, pci_memory, -1);
+
+    qdev_realize(DEVICE(rem_host), sysbus_get_default(), &error_fatal);
+}
+
+static void remote_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->init = remote_machine_init;
+}
+
+static const TypeInfo remote_machine = {
+    .name = TYPE_REMOTE_MACHINE,
+    .parent = TYPE_MACHINE,
+    .instance_size = sizeof(RemMachineState),
+    .class_init = remote_machine_class_init,
+};
+
+static void remote_machine_register_types(void)
+{
+    type_register_static(&remote_machine);
+}
+
+type_init(remote_machine_register_types);
diff --git a/include/hw/i386/remote.h b/include/hw/i386/remote.h
new file mode 100644
index 0000000000..d118a940be
--- /dev/null
+++ b/include/hw/i386/remote.h
@@ -0,0 +1,31 @@
+/*
+ * Remote machine configuration
+ *
+ * Copyright © 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef REMOTE_MACHINE_H
+#define REMOTE_MACHINE_H
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+
+#include "qom/object.h"
+#include "hw/boards.h"
+#include "hw/pci-host/remote.h"
+
+typedef struct RemMachineState {
+    MachineState parent_obj;
+
+    RemotePCIHost *host;
+} RemMachineState;
+
+#define TYPE_REMOTE_MACHINE "remote-machine"
+#define REMOTE_MACHINE(obj) \
+    OBJECT_CHECK(RemMachineState, (obj), TYPE_REMOTE_MACHINE)
+
+#endif
-- 
2.25.GIT


