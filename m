Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CECC7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 21:00:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01AD52173E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 21:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01AD52173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnr2J-0004ja-Rl
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 17:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42620)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hnr1v-0003oQ-Vr
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 17:00:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hnr1t-0006oS-OO
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 17:00:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57880
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hnr1t-0006mR-Gq
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 17:00:01 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6HKvER8069275
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 17:00:01 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tt9nrbunn-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 17:00:00 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
 Wed, 17 Jul 2019 22:00:00 +0100
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
 by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 17 Jul 2019 21:59:58 +0100
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6HKxvRX52035888
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2019 20:59:57 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 444587805C;
 Wed, 17 Jul 2019 20:59:57 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E1FB17805E;
 Wed, 17 Jul 2019 20:59:56 +0000 (GMT)
Received: from localhost (unknown [9.80.82.153])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jul 2019 20:59:56 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 15:58:42 -0500
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190717205842.17827-1-mdroth@linux.vnet.ibm.com>
References: <20190717205842.17827-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19071720-0036-0000-0000-00000ADB5B16
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011448; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01233612; UDB=6.00650028; IPR=6.01014937; 
 MB=3.00027766; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-17 20:59:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071720-0037-0000-0000-00004CA405EF
Message-Id: <20190717205842.17827-3-mdroth@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-17_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907170237
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH for-4.2 v2 2/2] spapr: initial implementation
 for H_TPM_COMM/spapr-tpm-proxy
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
Cc: linuxram@us.ibm.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This implements the H_TPM_COMM hypercall, which is used by an
Ultravisor to pass TPM commands directly to the host's TPM device, or
a TPM Resource Manager associated with the device.

This also introduces a new virtual device, spapr-tpm-proxy, which
is used to configure the host TPM path to be used to service
requests sent by H_TPM_COMM hcalls, for example:

  -device spapr-tpm-proxy,id=tpmp0,host-path=/dev/tpmrm0

By default, no spapr-tpm-proxy will be created, and hcalls will return
H_FUNCTION.

The full specification for this hypercall can be found in
docs/specs/ppc-spapr-uv-hcalls.txt

Since SVM-related hcalls like H_TPM_COMM use a reserved range of
0xEF00-0xEF80, we introduce a separate hcall table here to handle
them.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com
---
 hw/ppc/Makefile.objs             |   1 +
 hw/ppc/spapr.c                   |  33 +++++-
 hw/ppc/spapr_hcall.c             |  13 +++
 hw/ppc/spapr_tpm_proxy.c         | 176 +++++++++++++++++++++++++++++++
 hw/ppc/trace-events              |   4 +
 include/hw/ppc/spapr.h           |  11 ++
 include/hw/ppc/spapr_tpm_proxy.h |  31 ++++++
 7 files changed, 268 insertions(+), 1 deletion(-)
 create mode 100644 hw/ppc/spapr_tpm_proxy.c
 create mode 100644 include/hw/ppc/spapr_tpm_proxy.h

diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 9da93af905..2c4e1c8de0 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -5,6 +5,7 @@ obj-$(CONFIG_PSERIES) += spapr.o spapr_caps.o spapr_vio.o spapr_events.o
 obj-$(CONFIG_PSERIES) += spapr_hcall.o spapr_iommu.o spapr_rtas.o
 obj-$(CONFIG_PSERIES) += spapr_pci.o spapr_rtc.o spapr_drc.o
 obj-$(CONFIG_PSERIES) += spapr_cpu_core.o spapr_ovec.o spapr_irq.o
+obj-$(CONFIG_PSERIES) += spapr_tpm_proxy.o
 obj-$(CONFIG_SPAPR_RNG) +=  spapr_rng.o
 # IBM PowerNV
 obj-$(CONFIG_POWERNV) += pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_psi.o pnv_occ.o pnv_bmc.o
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8783b43396..0ddf129abe 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -75,6 +75,7 @@
 #include "qemu/cutils.h"
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/mem/memory-device.h"
+#include "hw/ppc/spapr_tpm_proxy.h"
 
 #include <libfdt.h>
 
@@ -4031,6 +4032,29 @@ static void spapr_phb_unplug_request(HotplugHandler *hotplug_dev,
     }
 }
 
+static void spapr_tpm_proxy_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                                 Error **errp)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
+    SpaprTpmProxy *tpm_proxy = SPAPR_TPM_PROXY(dev);
+
+    if (spapr->tpm_proxy != NULL) {
+        error_setg(errp, "Only one TPM proxy can be specified for this machine");
+        return;
+    }
+
+    spapr->tpm_proxy = tpm_proxy;
+}
+
+static void spapr_tpm_proxy_unplug(HotplugHandler *hotplug_dev, DeviceState *dev)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
+
+    object_property_set_bool(OBJECT(dev), false, "realized", NULL);
+    object_unparent(OBJECT(dev));
+    spapr->tpm_proxy = NULL;
+}
+
 static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
                                       DeviceState *dev, Error **errp)
 {
@@ -4040,6 +4064,8 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
         spapr_core_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
         spapr_phb_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_TPM_PROXY)) {
+        spapr_tpm_proxy_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -4052,6 +4078,8 @@ static void spapr_machine_device_unplug(HotplugHandler *hotplug_dev,
         spapr_core_unplug(hotplug_dev, dev);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
         spapr_phb_unplug(hotplug_dev, dev);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_TPM_PROXY)) {
+        spapr_tpm_proxy_unplug(hotplug_dev, dev);
     }
 }
 
@@ -4086,6 +4114,8 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
             return;
         }
         spapr_phb_unplug_request(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_TPM_PROXY)) {
+        spapr_tpm_proxy_unplug(hotplug_dev, dev);
     }
 }
 
@@ -4106,7 +4136,8 @@ static HotplugHandler *spapr_get_hotplug_handler(MachineState *machine,
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
         object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE) ||
-        object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
+        object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_TPM_PROXY)) {
         return HOTPLUG_HANDLER(machine);
     }
     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 0fc58156a0..97e41b5730 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1826,6 +1826,7 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, SpaprMachineState *spapr,
 
 static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
 static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_HCALL_BASE + 1];
+static spapr_hcall_fn svm_hypercall_table[(SVM_HCALL_MAX - SVM_HCALL_BASE) / 4 + 1];
 
 void spapr_register_hypercall(target_ulong opcode, spapr_hcall_fn fn)
 {
@@ -1835,6 +1836,11 @@ void spapr_register_hypercall(target_ulong opcode, spapr_hcall_fn fn)
         assert((opcode & 0x3) == 0);
 
         slot = &papr_hypercall_table[opcode / 4];
+    } else if (opcode >= SVM_HCALL_BASE && opcode <= SVM_HCALL_MAX) {
+        /* we only have SVM-related hcall numbers assigned in multiples of 4 */
+        assert((opcode & 0x3) == 0);
+
+        slot = &svm_hypercall_table[(opcode - SVM_HCALL_BASE) / 4];
     } else {
         assert((opcode >= KVMPPC_HCALL_BASE) && (opcode <= KVMPPC_HCALL_MAX));
 
@@ -1854,6 +1860,13 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
         && ((opcode & 0x3) == 0)) {
         spapr_hcall_fn fn = papr_hypercall_table[opcode / 4];
 
+        if (fn) {
+            return fn(cpu, spapr, opcode, args);
+        }
+    } else if ((opcode >= SVM_HCALL_BASE) &&
+               (opcode <= SVM_HCALL_MAX)) {
+        spapr_hcall_fn fn = svm_hypercall_table[(opcode - SVM_HCALL_BASE) / 4];
+
         if (fn) {
             return fn(cpu, spapr, opcode, args);
         }
diff --git a/hw/ppc/spapr_tpm_proxy.c b/hw/ppc/spapr_tpm_proxy.c
new file mode 100644
index 0000000000..435ba8e2c1
--- /dev/null
+++ b/hw/ppc/spapr_tpm_proxy.c
@@ -0,0 +1,176 @@
+/*
+ * SPAPR TPM Proxy/Hypercall
+ *
+ * Copyright IBM Corp. 2019
+ *
+ * Authors:
+ *  Michael Roth      <mdroth@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "cpu.h"
+#include "hw/ppc/spapr.h"
+#include "trace.h"
+
+#define TPM_SPAPR_BUFSIZE 4096
+
+enum {
+    TPM_COMM_OP_EXECUTE = 1,
+    TPM_COMM_OP_CLOSE_SESSION = 2,
+};
+
+static void spapr_tpm_proxy_reset(void *opaque)
+{
+    SpaprTpmProxy *tpm_proxy = SPAPR_TPM_PROXY(opaque);
+
+    if (tpm_proxy->host_fd != -1) {
+        close(tpm_proxy->host_fd);
+        tpm_proxy->host_fd = -1;
+    }
+}
+
+static ssize_t tpm_execute(SpaprTpmProxy *tpm_proxy, target_ulong *args)
+{
+    uint64_t data_in = ppc64_phys_to_real(args[1]);
+    target_ulong data_in_size = args[2];
+    uint64_t data_out = ppc64_phys_to_real(args[3]);
+    target_ulong data_out_size = args[4];
+    uint8_t buf_in[TPM_SPAPR_BUFSIZE];
+    uint8_t buf_out[TPM_SPAPR_BUFSIZE];
+    ssize_t ret;
+
+    trace_spapr_tpm_execute(data_in, data_in_size, data_out, data_out_size);
+
+    if (data_in_size > TPM_SPAPR_BUFSIZE) {
+        error_report("invalid TPM input buffer size: " TARGET_FMT_lu,
+                     data_in_size);
+        return H_P3;
+    }
+
+    if (data_out_size < TPM_SPAPR_BUFSIZE) {
+        error_report("invalid TPM output buffer size: " TARGET_FMT_lu,
+                     data_out_size);
+        return H_P5;
+    }
+
+    if (tpm_proxy->host_fd == -1) {
+        tpm_proxy->host_fd = open(tpm_proxy->host_path, O_RDWR);
+        if (tpm_proxy->host_fd == -1) {
+            error_report("failed to open TPM device %s: %d",
+                         tpm_proxy->host_path, errno);
+            return H_RESOURCE;
+        }
+    }
+
+    cpu_physical_memory_read(data_in, buf_in, data_in_size);
+
+    do {
+        ret = write(tpm_proxy->host_fd, buf_in, data_in_size);
+        if (ret > 0) {
+            data_in_size -= ret;
+        }
+    } while ((ret >= 0 && data_in_size > 0) || (ret == -1 && errno == EINTR));
+
+    if (ret == -1) {
+        error_report("failed to write to TPM device %s: %d",
+                     tpm_proxy->host_path, errno);
+        return H_RESOURCE;
+    }
+
+    do {
+        ret = read(tpm_proxy->host_fd, buf_out, data_out_size);
+    } while (ret == 0 || (ret == -1 && errno == EINTR));
+
+    if (ret == -1) {
+        error_report("failed to read from TPM device %s: %d",
+                     tpm_proxy->host_path, errno);
+        return H_RESOURCE;
+    }
+
+    cpu_physical_memory_write(data_out, buf_out, ret);
+    args[0] = ret;
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_tpm_comm(PowerPCCPU *cpu,
+                               SpaprMachineState *spapr,
+                               target_ulong opcode,
+                               target_ulong *args)
+{
+    target_ulong op = args[0];
+    SpaprTpmProxy *tpm_proxy = spapr->tpm_proxy;
+
+    if (!tpm_proxy) {
+        error_report("TPM proxy not available");
+        return H_FUNCTION;
+    }
+
+    trace_spapr_h_tpm_comm(tpm_proxy->host_path ?: "null", op);
+
+    switch (op) {
+    case TPM_COMM_OP_EXECUTE:
+        return tpm_execute(tpm_proxy, args);
+    case TPM_COMM_OP_CLOSE_SESSION:
+        spapr_tpm_proxy_reset(tpm_proxy);
+        return H_SUCCESS;
+    default:
+        return H_PARAMETER;
+    }
+}
+
+static void spapr_tpm_proxy_realize(DeviceState *d, Error **errp)
+{
+    SpaprTpmProxy *tpm_proxy = SPAPR_TPM_PROXY(d);
+
+    if (tpm_proxy->host_path == NULL) {
+        error_setg(errp, "must specify 'host-path' option for device");
+        return;
+    }
+
+    tpm_proxy->host_fd = -1;
+    qemu_register_reset(spapr_tpm_proxy_reset, tpm_proxy);
+}
+
+static void spapr_tpm_proxy_unrealize(DeviceState *d, Error **errp)
+{
+    SpaprTpmProxy *tpm_proxy = SPAPR_TPM_PROXY(d);
+
+    qemu_unregister_reset(spapr_tpm_proxy_reset, tpm_proxy);
+}
+
+static Property spapr_tpm_proxy_properties[] = {
+    DEFINE_PROP_STRING("host-path", SpaprTpmProxy, host_path),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void spapr_tpm_proxy_class_init(ObjectClass *k, void *data)
+{
+    DeviceClass *dk = DEVICE_CLASS(k);
+
+    dk->realize = spapr_tpm_proxy_realize;
+    dk->unrealize = spapr_tpm_proxy_unrealize;
+    dk->user_creatable = true;
+    dk->props = spapr_tpm_proxy_properties;
+}
+
+static const TypeInfo spapr_tpm_proxy_info = {
+    .name          = TYPE_SPAPR_TPM_PROXY,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(SpaprTpmProxy),
+    .class_init    = spapr_tpm_proxy_class_init,
+};
+
+static void spapr_tpm_proxy_register_types(void)
+{
+    type_register_static(&spapr_tpm_proxy_info);
+    spapr_register_hypercall(SVM_H_TPM_COMM, h_tpm_comm);
+}
+
+type_init(spapr_tpm_proxy_register_types)
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index f76448f532..96dad767a1 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -25,6 +25,10 @@ spapr_update_dt(unsigned cb) "New blob %u bytes"
 spapr_update_dt_failed_size(unsigned cbold, unsigned cbnew, unsigned magic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
 spapr_update_dt_failed_check(unsigned cbold, unsigned cbnew, unsigned magic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
 
+# spapr_hcall_tpm.c
+spapr_h_tpm_comm(const char *device_path, uint64_t operation) "tpm_device_path=%s operation=0x%"PRIu64
+spapr_tpm_execute(uint64_t data_in, uint64_t data_in_sz, uint64_t data_out, uint64_t data_out_sz) "data_in=0x%"PRIx64", data_in_sz=%"PRIu64", data_out=0x%"PRIx64", data_out_sz=%"PRIu64
+
 # spapr_iommu.c
 spapr_iommu_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t ret) "liobn=0x%"PRIx64" ioba=0x%"PRIx64" tce=0x%"PRIx64" ret=%"PRId64
 spapr_iommu_get(uint64_t liobn, uint64_t ioba, uint64_t ret, uint64_t tce) "liobn=0x%"PRIx64" ioba=0x%"PRIx64" ret=%"PRId64" tce=0x%"PRIx64
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 60553d32c4..76dec20680 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -10,6 +10,7 @@
 #include "hw/ppc/spapr_irq.h"
 #include "hw/ppc/spapr_xive.h"  /* For SpaprXive */
 #include "hw/ppc/xics.h"        /* For ICSState */
+#include "hw/ppc/spapr_tpm_proxy.h"
 
 struct SpaprVioBus;
 struct SpaprPhbState;
@@ -203,6 +204,7 @@ struct SpaprMachineState {
     SpaprCapabilities def, eff, mig;
 
     unsigned gpu_numa_id;
+    SpaprTpmProxy *tpm_proxy;
 };
 
 #define H_SUCCESS         0
@@ -508,6 +510,15 @@ struct SpaprMachineState {
 #define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
 #define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
 
+/*
+ * The hcall range 0xEF00 to 0xEF80 is reserved for use in facilitating
+ * Secure VM mode via an Ultravisor / Protected Execution Facility
+ */
+#define SVM_HCALL_BASE              0xEF00
+#define SVM_H_TPM_COMM              0xEF10
+#define SVM_HCALL_MAX               SVM_H_TPM_COMM
+
+
 typedef struct SpaprDeviceTreeUpdateHeader {
     uint32_t version_id;
 } SpaprDeviceTreeUpdateHeader;
diff --git a/include/hw/ppc/spapr_tpm_proxy.h b/include/hw/ppc/spapr_tpm_proxy.h
new file mode 100644
index 0000000000..4843cdaf58
--- /dev/null
+++ b/include/hw/ppc/spapr_tpm_proxy.h
@@ -0,0 +1,31 @@
+/*
+ * SPAPR TPM Proxy/Hypercall
+ *
+ * Copyright IBM Corp. 2019
+ *
+ * Authors:
+ *  Michael Roth      <mdroth@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_SPAPR_TPM_PROXY_H
+#define HW_SPAPR_TPM_PROXY_H
+
+#include "qom/object.h"
+#include "hw/qdev.h"
+
+#define TYPE_SPAPR_TPM_PROXY "spapr-tpm-proxy"
+#define SPAPR_TPM_PROXY(obj) OBJECT_CHECK(SpaprTpmProxy, (obj), \
+                                          TYPE_SPAPR_TPM_PROXY)
+
+typedef struct SpaprTpmProxy {
+    /*< private >*/
+    DeviceState parent;
+
+    char *host_path;
+    int host_fd;
+} SpaprTpmProxy;
+
+#endif /* HW_SPAPR_TPM_PROXY_H */
-- 
2.17.1


