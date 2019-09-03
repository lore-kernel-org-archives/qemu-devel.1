Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C193FC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 781B621883
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZC4asmQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 781B621883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Fp8-0005Qi-Vb
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 16:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5Fa2-0007cb-0t
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5FZx-0000SD-Qz
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60078)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5FZx-0000Qe-ES
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KXlhH062406;
 Tue, 3 Sep 2019 20:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=N8fcMVeZCfr+KZMIgLeOLBI1SDd2vaoWnXFbjaNitj4=;
 b=ZC4asmQ+6gkS7lDRU24RWUDjwT/8hESKSyP6P5cxUBadMuOkK4EvIygEexoejy1ZGwId
 mwkCcm7/RJ8V67NWemszR+SL5CetJmkNE2qPSnSbJKwXnr0TJTNioEsOPrf7t3+I3npJ
 dfwGEaGNcjGQMpk7JdERLs0u7RFWUhuAcVLU7jlXDBm/DX0OtPSxkGNVPFAcSaaujySx
 2ZkR4c7jpLB8y6pBvXNkbZflN9z1znqGwNplvl+8lFRUIbrcXbKpGHkXGi7WZMsB21Wv
 fc2ZUsP+so4mkqCGiKoeu+8JKioKxWn0/YCKkgVaackLy/REnXMR7KAs0UBdY7dcDtgg 5w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2usy66r2f5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:38:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KcJwb188092;
 Tue, 3 Sep 2019 20:38:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2usu511853-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:38:56 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x83KcsTX017531;
 Tue, 3 Sep 2019 20:38:54 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:38:53 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:37:46 -0400
Message-Id: <9cae96e67e5464081f378d3efd3e0274ab92a8ca.1567534653.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030207
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030206
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [RFC v3 PATCH 20/45] multi-process: Synchronize remote
 memory
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 kraxel@redhat.com, jag.raman@oracle.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add memory-listener object which is used to keep the view of the RAM
in sync between QEMU and remote process.
A MemoryListener is registered for system-memory AddressSpace. The
listener sends SYNC_SYSMEM message to the remote process when memory
listener commits the changes to memory, the remote process receives
the message and processes it in the handler for SYNC_SYSMEM message.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 v2 -> v3:
   - Refactored code to obtain fd from host address, added
     get_fd_from_hostaddr().
   - Discovered a bug which results in invalid FDs (-1) being
     sent over to the remote process. Fixed this by checking
     if the FD value is valid before sending over to remote.

 Makefile.target                |   1 +
 hw/proxy/memory-sync.c         | 226 +++++++++++++++++++++++++++++++++++++++++
 hw/proxy/qemu-proxy.c          |   5 +
 include/hw/proxy/memory-sync.h |  51 ++++++++++
 include/hw/proxy/qemu-proxy.h  |   2 +
 remote/remote-main.c           |  11 ++
 6 files changed, 296 insertions(+)
 create mode 100644 hw/proxy/memory-sync.c
 create mode 100644 include/hw/proxy/memory-sync.h

diff --git a/Makefile.target b/Makefile.target
index 931ee80..3aa2ac8 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -125,6 +125,7 @@ obj-$(CONFIG_TCG) += fpu/softfloat.o
 obj-y += target/$(TARGET_BASE_ARCH)/
 obj-y += disas.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
+obj-$(CONFIG_MPQEMU) += hw/proxy/memory-sync.o
 LIBS := $(libs_cpu) $(LIBS)
 
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) += accel/stubs/kvm-stub.o
diff --git a/hw/proxy/memory-sync.c b/hw/proxy/memory-sync.c
new file mode 100644
index 0000000..5e57784
--- /dev/null
+++ b/hw/proxy/memory-sync.c
@@ -0,0 +1,226 @@
+/*
+ * Copyright 2019, Oracle and/or its affiliates.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include <sys/types.h>
+#include <stdio.h>
+#include <string.h>
+
+#include "qemu/osdep.h"
+#include "qemu/compiler.h"
+#include "qemu/int128.h"
+#include "qemu/range.h"
+#include "exec/memory.h"
+#include "exec/cpu-common.h"
+#include "cpu.h"
+#include "exec/ram_addr.h"
+#include "exec/address-spaces.h"
+#include "io/proxy-link.h"
+#include "hw/proxy/memory-sync.h"
+
+static const TypeInfo remote_mem_sync_type_info = {
+    .name          = TYPE_MEMORY_LISTENER,
+    .parent        = TYPE_OBJECT,
+    .instance_size = sizeof(RemoteMemSync),
+};
+
+static void remote_mem_sync_register_types(void)
+{
+    type_register_static(&remote_mem_sync_type_info);
+}
+
+type_init(remote_mem_sync_register_types)
+
+static void proxy_ml_begin(MemoryListener *listener)
+{
+    RemoteMemSync *sync = container_of(listener, RemoteMemSync, listener);
+    int mrs;
+
+    for (mrs = 0; mrs < sync->n_mr_sections; mrs++) {
+        memory_region_unref(sync->mr_sections[mrs].mr);
+    }
+
+    g_free(sync->mr_sections);
+    sync->mr_sections = NULL;
+    sync->n_mr_sections = 0;
+}
+
+static int get_fd_from_hostaddr(uint64_t host, ram_addr_t *offset)
+{
+    MemoryRegion *mr;
+    ram_addr_t off;
+
+    mr = memory_region_from_host((void *)(uintptr_t)host, &off);
+
+    if (offset) {
+        *offset = off;
+    }
+
+    return memory_region_get_fd(mr);
+}
+
+static bool proxy_mrs_can_merge(uint64_t host, uint64_t prev_host, size_t size)
+{
+    bool merge;
+    int fd1, fd2;
+
+    fd1 = get_fd_from_hostaddr(host, NULL);
+
+    fd2 = get_fd_from_hostaddr(prev_host, NULL);
+
+    merge = (fd1 == fd2);
+
+    merge &= ((prev_host + size) == host);
+
+    return merge;
+}
+
+static void proxy_ml_region_addnop(MemoryListener *listener,
+                                   MemoryRegionSection *section)
+{
+    RemoteMemSync *sync = container_of(listener, RemoteMemSync, listener);
+    bool need_add = true;
+    uint64_t mrs_size, mrs_gpa, mrs_page;
+    uintptr_t mrs_host;
+    RAMBlock *mrs_rb;
+    MemoryRegionSection *prev_sec;
+
+    if (!(memory_region_is_ram(section->mr) &&
+          !memory_region_is_rom(section->mr))) {
+        return;
+    }
+
+    mrs_rb = section->mr->ram_block;
+    mrs_page = (uint64_t)qemu_ram_pagesize(mrs_rb);
+    mrs_size = int128_get64(section->size);
+    mrs_gpa = section->offset_within_address_space;
+    mrs_host = (uintptr_t)memory_region_get_ram_ptr(section->mr) +
+               section->offset_within_region;
+
+    if (get_fd_from_hostaddr(mrs_host, NULL) <= 0) {
+        return;
+    }
+
+    mrs_host = mrs_host & ~(mrs_page - 1);
+    mrs_gpa = mrs_gpa & ~(mrs_page - 1);
+    mrs_size = ROUND_UP(mrs_size, mrs_page);
+
+    if (sync->n_mr_sections) {
+        prev_sec = sync->mr_sections + (sync->n_mr_sections - 1);
+        uint64_t prev_gpa_start = prev_sec->offset_within_address_space;
+        uint64_t prev_size = int128_get64(prev_sec->size);
+        uint64_t prev_gpa_end   = range_get_last(prev_gpa_start, prev_size);
+        uint64_t prev_host_start =
+            (uintptr_t)memory_region_get_ram_ptr(prev_sec->mr) +
+            prev_sec->offset_within_region;
+        uint64_t prev_host_end = range_get_last(prev_host_start, prev_size);
+
+        if (mrs_gpa <= (prev_gpa_end + 1)) {
+            if (mrs_gpa < prev_gpa_start) {
+                assert(0);
+            }
+
+            if ((section->mr == prev_sec->mr) &&
+                proxy_mrs_can_merge(mrs_host, prev_host_start,
+                                    (mrs_gpa - prev_gpa_start))) {
+                uint64_t max_end = MAX(prev_host_end, mrs_host + mrs_size);
+                need_add = false;
+                prev_sec->offset_within_address_space =
+                    MIN(prev_gpa_start, mrs_gpa);
+                prev_sec->offset_within_region =
+                    MIN(prev_host_start, mrs_host) -
+                    (uintptr_t)memory_region_get_ram_ptr(prev_sec->mr);
+                prev_sec->size = int128_make64(max_end - MIN(prev_host_start,
+                                                             mrs_host));
+            }
+        }
+    }
+
+    if (need_add) {
+        ++sync->n_mr_sections;
+        sync->mr_sections = g_renew(MemoryRegionSection, sync->mr_sections,
+                                    sync->n_mr_sections);
+        sync->mr_sections[sync->n_mr_sections - 1] = *section;
+        sync->mr_sections[sync->n_mr_sections - 1].fv = NULL;
+        memory_region_ref(section->mr);
+    }
+}
+
+static void proxy_ml_commit(MemoryListener *listener)
+{
+    RemoteMemSync *sync = container_of(listener, RemoteMemSync, listener);
+    ProcMsg msg;
+    MemoryRegionSection section;
+    ram_addr_t offset;
+    uintptr_t host_addr;
+    int region;
+
+    memset(&msg, 0, sizeof(ProcMsg));
+
+    msg.cmd = SYNC_SYSMEM;
+    msg.bytestream = 0;
+    msg.num_fds = sync->n_mr_sections;
+    msg.size = sizeof(msg.data1);
+    assert(msg.num_fds <= REMOTE_MAX_FDS);
+
+    for (region = 0; region < sync->n_mr_sections; region++) {
+        section = sync->mr_sections[region];
+        msg.data1.sync_sysmem.gpas[region] =
+            section.offset_within_address_space;
+        msg.data1.sync_sysmem.sizes[region] = int128_get64(section.size);
+        host_addr = (uintptr_t)memory_region_get_ram_ptr(section.mr) +
+                    section.offset_within_region;
+        msg.fds[region] = get_fd_from_hostaddr(host_addr, &offset);
+        msg.data1.sync_sysmem.offsets[region] = offset;
+    }
+    proxy_proc_send(sync->proxy_link, &msg, sync->proxy_link->com);
+}
+
+void deconfigure_memory_sync(RemoteMemSync *sync)
+{
+    memory_listener_unregister(&sync->listener);
+}
+
+/*
+ * TODO: Memory Sync need not be instantianted once per every proxy device.
+ *       All remote devices are going to get the exact same updates at the
+ *       same time. It therefore makes sense to have a broadcast model.
+ *
+ *       Broadcast model would involve running the MemorySync object in a
+ *       thread. MemorySync would contain a list of proxy_link objects
+ *       that need notification. proxy_ml_commit() could send the same
+ *       message to all the links at the same time.
+ */
+void configure_memory_sync(RemoteMemSync *sync, ProxyLinkState *proxy_link)
+{
+    sync->n_mr_sections = 0;
+    sync->mr_sections = NULL;
+
+    sync->proxy_link = proxy_link;
+
+    sync->listener.begin = proxy_ml_begin;
+    sync->listener.commit = proxy_ml_commit;
+    sync->listener.region_add = proxy_ml_region_addnop;
+    sync->listener.region_nop = proxy_ml_region_addnop;
+    sync->listener.priority = 10;
+
+    memory_listener_register(&sync->listener, &address_space_memory);
+}
diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 789f39a..158d8d7 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -42,6 +42,8 @@
 #include "qapi/qmp/qstring.h"
 #include "sysemu/sysemu.h"
 #include "hw/proxy/qemu-proxy.h"
+#include "hw/proxy/memory-sync.h"
+#include "qom/object.h"
 
 static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
 
@@ -277,6 +279,8 @@ static void init_proxy(PCIDevice *dev, char *command, bool need_spawn, Error **e
 
     proxy_link_init_channel(pdev->proxy_link, &pdev->proxy_link->com,
                             pdev->socket);
+
+    configure_memory_sync(pdev->sync, pdev->proxy_link);
 }
 
 static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
@@ -295,6 +299,7 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
     dev->set_proxy_sock = set_proxy_sock;
     dev->get_proxy_sock = get_proxy_sock;
     dev->init_proxy = init_proxy;
+    dev->sync = REMOTE_MEM_SYNC(object_new(TYPE_MEMORY_LISTENER));
 }
 
 static void send_bar_access_msg(PCIProxyDev *dev, MemoryRegion *mr,
diff --git a/include/hw/proxy/memory-sync.h b/include/hw/proxy/memory-sync.h
new file mode 100644
index 0000000..56d7268
--- /dev/null
+++ b/include/hw/proxy/memory-sync.h
@@ -0,0 +1,51 @@
+/*
+ * Copyright 2019, Oracle and/or its affiliates.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef MEMORY_SYNC_H
+#define MEMORY_SYNC_H
+
+#include <sys/types.h>
+
+#include "qemu/osdep.h"
+#include "qom/object.h"
+#include "exec/memory.h"
+#include "io/proxy-link.h"
+
+#define TYPE_MEMORY_LISTENER "memory-listener"
+#define REMOTE_MEM_SYNC(obj) \
+            OBJECT_CHECK(RemoteMemSync, (obj), TYPE_MEMORY_LISTENER)
+
+typedef struct RemoteMemSync {
+    Object obj;
+
+    MemoryListener listener;
+
+    int n_mr_sections;
+    MemoryRegionSection *mr_sections;
+
+    ProxyLinkState *proxy_link;
+} RemoteMemSync;
+
+void configure_memory_sync(RemoteMemSync *sync, ProxyLinkState *proxy_link);
+void deconfigure_memory_sync(RemoteMemSync *sync);
+
+#endif
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index a951570..cf8e006 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -24,6 +24,7 @@
 #define QEMU_PROXY_H
 
 #include "io/proxy-link.h"
+#include "hw/proxy/memory-sync.h"
 
 #define TYPE_PCI_PROXY_DEV "pci-proxy-dev"
 
@@ -44,6 +45,7 @@ typedef struct PCIProxyDev {
 
     ProxyLinkState *proxy_link;
 
+    RemoteMemSync *sync;
     EventNotifier intr;
     EventNotifier resample;
 
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 43fe50a..bf2a77c 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -46,6 +46,7 @@
 #include "sysemu/sysemu.h"
 #include "block/block.h"
 #include "exec/memattrs.h"
+#include "exec/address-spaces.h"
 
 static ProxyLinkState *proxy_link;
 PCIDevice *remote_pci_dev;
@@ -174,6 +175,16 @@ static void process_msg(GIOCondition cond, ProcChannel *chan)
             goto finalize_loop;
         }
         break;
+    case SYNC_SYSMEM:
+        /*
+         * TODO: ensure no active DMA is happening when
+         * sysmem is being updated
+         */
+        remote_sysmem_reconfig(msg, &err);
+        if (err) {
+            goto finalize_loop;
+        }
+        break;
     default:
         error_setg(&err, "Unknown command");
         goto finalize_loop;
-- 
1.8.3.1


