Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CC1C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 18:59:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7BAB20853
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 18:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yhcmqblO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7BAB20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPVi0-0006tM-MF
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 14:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kPVaA-0006e3-WA
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 14:51:35 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33696)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kPVa8-00083H-P3
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 14:51:34 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095Io7mH039152;
 Mon, 5 Oct 2020 18:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=F5KUQv/vKsYh7uKLscY8hTmbJrAI+N34Wz3kDgIpXQg=;
 b=yhcmqblOEq9nlpWPvePVybv28pzeletaKkxtTdMUi2GpA+OW3qyUq3HWy+QoLCC+MGfV
 h2QSFX6gJNZHDi+21tnUm4QAVr+TEf2aC0DbgPb64d5ZQqJ8bjDQyz8YeL4BOODcFu6M
 35KnF0QD8N9bw41W2+NGEynfzwhXeEpnvlrbL2vlBQXokuw6UsgdBTUaRJqV80du8FAf
 u4kiqixvsw3ut5RWbC84mmSKv0TxfEgP4/0X9ivYUhjwdb92qHnwOjoc2APABnz7EDi1
 0njnL9m5qHcoSLI8PqTZjds+Sv9sSrgg8o5YPvq1KoK49mtuth+DM1nTJeStHf9+Lo3d ig== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 33xetaqcjb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 05 Oct 2020 18:51:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095IpDiw182554;
 Mon, 5 Oct 2020 18:51:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 33y2vkvexv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 05 Oct 2020 18:51:17 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 095IpFhU001783;
 Mon, 5 Oct 2020 18:51:15 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 05 Oct 2020 11:51:15 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v10 03/19] multi-process: setup PCI host bridge for remote
 device
Date: Mon,  5 Oct 2020 11:50:51 -0700
Message-Id: <e9a3fc6777b3aafd2c5dc51ed9a5f220f9c79c56.1601923020.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1601923020.git.elena.ufimtseva@oracle.com>
References: <cover.1601923020.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 malwarescore=0 suspectscore=1 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=1 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010050136
Received-SPF: pass client-ip=141.146.126.79;
 envelope-from=elena.ufimtseva@oracle.com; helo=aserp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 14:51:28
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
 stefanha@redhat.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jagannathan Raman <jag.raman@oracle.com>

PCI host bridge is setup for the remote device process. It is
implemented using remote-pcihost object. It is an extension of the PCI
host bridge setup by QEMU.
Remote-pcihost configures a PCI bus which could be used by the remote
PCI device to latch on to.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS                  |  8 ++++
 hw/pci-host/meson.build      |  1 +
 hw/pci-host/remote.c         | 75 ++++++++++++++++++++++++++++++++++++
 include/hw/pci-host/remote.h | 30 +++++++++++++++
 4 files changed, 114 insertions(+)
 create mode 100644 hw/pci-host/remote.c
 create mode 100644 include/hw/pci-host/remote.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5a22c8be42..76cff0fc12 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3036,6 +3036,14 @@ S: Maintained
 F: hw/semihosting/
 F: include/hw/semihosting/
 
+Multi-process QEMU
+M: Jagannathan Raman <jag.raman@oracle.com>
+M: Elena Ufimtseva <elena.ufimtseva@oracle.com>
+M: John G Johnson <john.g.johnson@oracle.com>
+S: Maintained
+F: hw/pci-host/remote.c
+F: include/hw/pci-host/remote.h
+
 Build and test automation
 -------------------------
 Build and test automation
diff --git a/hw/pci-host/meson.build b/hw/pci-host/meson.build
index cd52f6ff1c..85d8b3db3d 100644
--- a/hw/pci-host/meson.build
+++ b/hw/pci-host/meson.build
@@ -8,6 +8,7 @@ pci_ss.add(when: 'CONFIG_PCI_EXPRESS_XILINX', if_true: files('xilinx-pcie.c'))
 pci_ss.add(when: 'CONFIG_PCI_I440FX', if_true: files('i440fx.c'))
 pci_ss.add(when: 'CONFIG_PCI_SABRE', if_true: files('sabre.c'))
 pci_ss.add(when: 'CONFIG_XEN_IGD_PASSTHROUGH', if_true: files('xen_igd_pt.c'))
+pci_ss.add(when: 'CONFIG_MPQEMU', if_true: files('remote.c'))
 
 # PPC devices
 pci_ss.add(when: 'CONFIG_PREP_PCI', if_true: files('prep.c'))
diff --git a/hw/pci-host/remote.c b/hw/pci-host/remote.c
new file mode 100644
index 0000000000..11325e2207
--- /dev/null
+++ b/hw/pci-host/remote.c
@@ -0,0 +1,75 @@
+/*
+ * Remote PCI host device
+ *
+ * Unlike PCI host devices that model physical hardware, the purpose
+ * of this PCI host is to host multi-process QEMU devices.
+ *
+ * Multi-process QEMU extends the PCI host of a QEMU machine into a
+ * remote process. Any PCI device attached to the remote process is
+ * visible in the QEMU guest. This allows existing QEMU device models
+ * to be reused in the remote process.
+ *
+ * This PCI host is purely a container for PCI devices. It's fake in the
+ * sense that the guest never sees this PCI host and has no way of
+ * accessing it. Its job is just to provide the environment that QEMU
+ * PCI device models need when running in a remote process.
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
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_host.h"
+#include "hw/pci/pcie_host.h"
+#include "hw/qdev-properties.h"
+#include "hw/pci-host/remote.h"
+#include "exec/memory.h"
+
+static const char *remote_pcihost_root_bus_path(PCIHostState *host_bridge,
+                                                PCIBus *rootbus)
+{
+    return "0000:00";
+}
+
+static void remote_pcihost_realize(DeviceState *dev, Error **errp)
+{
+    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
+    RemotePCIHost *s = REMOTE_HOST_DEVICE(dev);
+
+    pci->bus = pci_root_bus_new(DEVICE(s), "remote-pci",
+                                s->mr_pci_mem, s->mr_sys_io,
+                                0, TYPE_PCIE_BUS);
+}
+
+static void remote_pcihost_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(klass);
+
+    hc->root_bus_path = remote_pcihost_root_bus_path;
+    dc->realize = remote_pcihost_realize;
+
+    dc->user_creatable = false;
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->fw_name = "pci";
+}
+
+static const TypeInfo remote_pcihost_info = {
+    .name = TYPE_REMOTE_HOST_DEVICE,
+    .parent = TYPE_PCIE_HOST_BRIDGE,
+    .instance_size = sizeof(RemotePCIHost),
+    .class_init = remote_pcihost_class_init,
+};
+
+static void remote_pcihost_register(void)
+{
+    type_register_static(&remote_pcihost_info);
+}
+
+type_init(remote_pcihost_register)
diff --git a/include/hw/pci-host/remote.h b/include/hw/pci-host/remote.h
new file mode 100644
index 0000000000..bab6d3c4f0
--- /dev/null
+++ b/include/hw/pci-host/remote.h
@@ -0,0 +1,30 @@
+/*
+ * PCI Host for remote device
+ *
+ * Copyright © 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef REMOTE_PCIHOST_H
+#define REMOTE_PCIHOST_H
+
+#include "exec/memory.h"
+#include "hw/pci/pcie_host.h"
+
+#define TYPE_REMOTE_HOST_DEVICE "remote-pcihost"
+#define REMOTE_HOST_DEVICE(obj) \
+    OBJECT_CHECK(RemotePCIHost, (obj), TYPE_REMOTE_HOST_DEVICE)
+
+typedef struct RemotePCIHost {
+    /*< private >*/
+    PCIExpressHost parent_obj;
+    /*< public >*/
+
+    MemoryRegion *mr_pci_mem;
+    MemoryRegion *mr_sys_io;
+} RemotePCIHost;
+
+#endif
-- 
2.25.GIT


