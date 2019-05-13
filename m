Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817B1C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:29:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F82B20873
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F82B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53991 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ7HF-0007dH-AU
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 05:29:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbhat@linux.ibm.com>) id 1hQ7Fo-0006nS-D0
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:28:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbhat@linux.ibm.com>) id 1hQ7Fk-0005ef-T7
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:28:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1hQ7Fk-0005eA-L5
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:28:12 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4D9RMDp052743
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 05:28:11 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sf4y72hsv-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 05:28:10 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
	Mon, 13 May 2019 10:28:08 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 13 May 2019 10:28:05 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
	(b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4D9S44g43515990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Mon, 13 May 2019 09:28:04 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B03B8A405C;
	Mon, 13 May 2019 09:28:04 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A207A405F;
	Mon, 13 May 2019 09:28:03 +0000 (GMT)
Received: from lep8c.aus.stglabs.ibm.com (unknown [9.40.192.207])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon, 13 May 2019 09:28:03 +0000 (GMT)
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: imammedo@redhat.com, david@gibson.dropbear.id.au,
	xiaoguangrong.eric@gmail.com, mst@redhat.com
Date: Mon, 13 May 2019 04:28:02 -0500
In-Reply-To: <155773946961.49142.5208084426066783536.stgit@lep8c.aus.stglabs.ibm.com>
References: <155773946961.49142.5208084426066783536.stgit@lep8c.aus.stglabs.ibm.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19051309-0020-0000-0000-0000033C0D4B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051309-0021-0000-0000-0000218EC152
Message-Id: <155773963257.49142.17067912880307967487.stgit@lep8c.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-13_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905130068
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [RFC v2 PATCH 2/3] spapr: Add NVDIMM device support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sbhat@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add support for NVDIMM devices for sPAPR. Piggyback on existing nvdimm
device interface in QEMU to support virtual NVDIMM devices for Power (May have
to re-look at this later).  Create the required DT entries for the
device (some entries have dummy values right now).

The patch creates the required DT node and sends a hotplug
interrupt to the guest. Guest is expected to undertake the normal
DR resource add path in response and start issuing PAPR SCM hcalls.

This is how it can be used ..
Add nvdimm=on to the qemu machine argument.
Ex : -machine pseries,nvdimm=on
For coldplug, the device to be added in qemu command line as shown below
-object memory-backend-file,id=memnvdimm0,prealloc=yes,mem-path=/tmp/nvdimm0,share=yes,size=1073872896
-device nvdimm,label-size=128k,uuid=75a3cdd7-6a2f-4791-8d15-fe0a920e8e9e,memdev=memnvdimm0,id=nvdimm0,slot=0

For hotplug, the device to be added from monitor as below
object_add memory-backend-file,id=memnvdimm0,prealloc=yes,mem-path=/tmp/nvdimm0,share=yes,size=1073872896
device_add nvdimm,label-size=128k,uuid=75a3cdd7-6a2f-4791-8d15-fe0a920e8e9e,memdev=memnvdimm0,id=nvdimm0,slot=0

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
               [Early implementation]
---
---
 default-configs/ppc64-softmmu.mak |    1 
 hw/mem/Kconfig                    |    2 
 hw/mem/nvdimm.c                   |   43 ++++++++
 hw/ppc/spapr.c                    |  202 +++++++++++++++++++++++++++++++++++--
 hw/ppc/spapr_drc.c                |   18 +++
 hw/ppc/spapr_events.c             |    4 +
 include/hw/mem/nvdimm.h           |    6 +
 include/hw/ppc/spapr.h            |   12 ++
 include/hw/ppc/spapr_drc.h        |    9 ++
 9 files changed, 286 insertions(+), 11 deletions(-)

diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-softmmu.mak
index cca52665d9..ae0841fa3a 100644
--- a/default-configs/ppc64-softmmu.mak
+++ b/default-configs/ppc64-softmmu.mak
@@ -8,3 +8,4 @@ CONFIG_POWERNV=y
 
 # For pSeries
 CONFIG_PSERIES=y
+CONFIG_NVDIMM=y
diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
index 620fd4cb59..2ad052a536 100644
--- a/hw/mem/Kconfig
+++ b/hw/mem/Kconfig
@@ -8,4 +8,4 @@ config MEM_DEVICE
 config NVDIMM
     bool
     default y
-    depends on PC
+    depends on (PC || PSERIES)
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index f221ec7a9a..deaebaaaa5 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -93,11 +93,54 @@ out:
     error_propagate(errp, local_err);
 }
 
+static void nvdimm_get_uuid(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    NVDIMMDevice *nvdimm = NVDIMM(obj);
+    char *value = NULL;
+
+    value = qemu_uuid_unparse_strdup(&nvdimm->uuid);
+
+    visit_type_str(v, name, &value, errp);
+}
+
+
+static void nvdimm_set_uuid(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    NVDIMMDevice *nvdimm = NVDIMM(obj);
+    Error *local_err = NULL;
+    char *value;
+
+    visit_type_str(v, name, &value, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
+    if (strcmp(value, "") == 0) {
+        error_setg(&local_err, "Property '%s.%s' %s is required"
+                   " at least 0x%lx", object_get_typename(obj),
+                   name, value, MIN_NAMESPACE_LABEL_SIZE);
+        goto out;
+    }
+
+    if (qemu_uuid_parse(value, &nvdimm->uuid) != 0) {
+        error_setg(errp, "Invalid UUID");
+        return;
+    }
+out:
+    error_propagate(errp, local_err);
+}
+
+
 static void nvdimm_init(Object *obj)
 {
     object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "int",
                         nvdimm_get_label_size, nvdimm_set_label_size, NULL,
                         NULL, NULL);
+
+    object_property_add(obj, NVDIMM_UUID_PROP, "QemuUUID", nvdimm_get_uuid,
+                        nvdimm_set_uuid, NULL, NULL, NULL);
 }
 
 static void nvdimm_finalize(Object *obj)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2ef3ce4362..b6951577e7 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -74,6 +74,7 @@
 #include "qemu/cutils.h"
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/mem/memory-device.h"
+#include "hw/mem/nvdimm.h"
 
 #include <libfdt.h>
 
@@ -699,6 +700,7 @@ static int spapr_populate_drmem_v2(SpaprMachineState *spapr, void *fdt,
     uint8_t *int_buf, *cur_index;
     int ret;
     uint64_t lmb_size = SPAPR_MEMORY_BLOCK_SIZE;
+    uint64_t scm_block_size = SPAPR_MINIMUM_SCM_BLOCK_SIZE;
     uint64_t addr, cur_addr, size;
     uint32_t nr_boot_lmbs = (machine->device_memory->base / lmb_size);
     uint64_t mem_end = machine->device_memory->base +
@@ -735,12 +737,20 @@ static int spapr_populate_drmem_v2(SpaprMachineState *spapr, void *fdt,
             nr_entries++;
         }
 
-        /* Entry for DIMM */
-        drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, addr / lmb_size);
-        g_assert(drc);
-        elem = spapr_get_drconf_cell(size / lmb_size, addr,
-                                     spapr_drc_index(drc), node,
-                                     SPAPR_LMB_FLAGS_ASSIGNED);
+        if (info->value->type == MEMORY_DEVICE_INFO_KIND_NVDIMM) {
+            /* Entry for NVDIMM */
+            drc = spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM, addr / scm_block_size);
+            g_assert(drc);
+            elem = spapr_get_drconf_cell(size / scm_block_size, addr,
+                                         spapr_drc_index(drc), -1, 0);
+        } else {
+            /* Entry for DIMM */
+            drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, addr / lmb_size);
+            g_assert(drc);
+            elem = spapr_get_drconf_cell(size / lmb_size, addr,
+                                         spapr_drc_index(drc), node,
+                                         SPAPR_LMB_FLAGS_ASSIGNED);
+        }
         QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
         nr_entries++;
         cur_addr = addr + size;
@@ -1235,6 +1245,87 @@ static void spapr_dt_hypervisor(SpaprMachineState *spapr, void *fdt)
     }
 }
 
+static int spapr_populate_nvdimm_node(void *fdt, int parent_offset,
+                                      NVDIMMDevice *nvdimm)
+{
+    int child_offset;
+    char buf[40];
+    SpaprDrc *drc;
+    uint32_t drc_idx;
+    uint32_t node = object_property_get_uint(OBJECT(nvdimm), PC_DIMM_NODE_PROP,
+                                             &error_abort);
+    uint64_t addr = object_property_get_uint(OBJECT(nvdimm), PC_DIMM_ADDR_PROP,
+                                             &error_abort);
+    uint32_t associativity[] = {
+        cpu_to_be32(0x4), /* length */
+        cpu_to_be32(0x0), cpu_to_be32(0x0),
+        cpu_to_be32(0x0), cpu_to_be32(node)
+    };
+    uint64_t lsize = nvdimm->label_size;
+    uint64_t size = object_property_get_int(OBJECT(nvdimm), PC_DIMM_SIZE_PROP,
+                                            NULL);
+
+    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM,
+                          addr / SPAPR_MINIMUM_SCM_BLOCK_SIZE);
+    g_assert(drc);
+
+    drc_idx = spapr_drc_index(drc);
+
+    sprintf(buf, "pmem@%x", drc_idx);
+    child_offset = fdt_add_subnode(fdt, parent_offset, buf);
+    _FDT(child_offset);
+
+    _FDT((fdt_setprop_cell(fdt, child_offset, "reg", drc_idx)));
+    _FDT((fdt_setprop_string(fdt, child_offset, "compatible", "ibm,pmemory")));
+    _FDT((fdt_setprop_string(fdt, child_offset, "device_type", "ibm,pmemory")));
+
+    _FDT((fdt_setprop(fdt, child_offset, "ibm,associativity", associativity,
+                      sizeof(associativity))));
+
+    qemu_uuid_unparse(&nvdimm->uuid, buf);
+    _FDT((fdt_setprop_string(fdt, child_offset, "ibm,unit-guid", buf)));
+
+    _FDT((fdt_setprop_cell(fdt, child_offset, "ibm,my-drc-index", drc_idx)));
+
+    /*NB : What it should be? */
+    _FDT(fdt_setprop_cell(fdt, child_offset, "ibm,latency-attribute", 828));
+
+    _FDT((fdt_setprop_u64(fdt, child_offset, "ibm,block-size",
+                          SPAPR_MINIMUM_SCM_BLOCK_SIZE)));
+    _FDT((fdt_setprop_u64(fdt, child_offset, "ibm,number-of-blocks",
+                          size / SPAPR_MINIMUM_SCM_BLOCK_SIZE)));
+    _FDT((fdt_setprop_cell(fdt, child_offset, "ibm,metadata-size", lsize)));
+
+    return child_offset;
+}
+
+static void spapr_dt_nvdimm(void *fdt)
+{
+    int offset = fdt_subnode_offset(fdt, 0, "persistent-memory");
+    GSList *dimms = NULL;
+
+    if (offset < 0) {
+        offset = fdt_add_subnode(fdt, 0, "persistent-memory");
+        _FDT(offset);
+        _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 0x2)));
+        _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 0x0)));
+        _FDT((fdt_setprop_string(fdt, offset, "device_type",
+                                 "ibm,persistent-memory")));
+    }
+
+    /*NB : Add drc-info array here */
+
+    /* Create DT entries for cold plugged NVDIMM devices */
+    dimms = nvdimm_get_device_list();
+    for (; dimms; dimms = dimms->next) {
+        NVDIMMDevice *nvdimm = dimms->data;
+
+        spapr_populate_nvdimm_node(fdt, offset, nvdimm);
+    }
+    g_slist_free(dimms);
+    return;
+}
+
 static void *spapr_build_fdt(SpaprMachineState *spapr)
 {
     MachineState *machine = MACHINE(spapr);
@@ -1368,6 +1459,11 @@ static void *spapr_build_fdt(SpaprMachineState *spapr)
         }
     }
 
+    /* NVDIMM devices */
+    if (spapr->nvdimm_enabled) {
+        spapr_dt_nvdimm(fdt);
+    }
+
     return fdt;
 }
 
@@ -3324,6 +3420,20 @@ static void spapr_set_host_serial(Object *obj, const char *value, Error **errp)
     spapr->host_serial = g_strdup(value);
 }
 
+static bool spapr_get_nvdimm(Object *obj, Error **errp)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(obj);
+
+    return spapr->nvdimm_enabled;
+}
+
+static void spapr_set_nvdimm(Object *obj, bool value, Error **errp)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(obj);
+
+    spapr->nvdimm_enabled = value;
+}
+
 static void spapr_instance_init(Object *obj)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(obj);
@@ -3380,6 +3490,12 @@ static void spapr_instance_init(Object *obj)
         &error_abort);
     object_property_set_description(obj, "host-serial",
         "Host serial number to advertise in guest device tree", &error_abort);
+
+    object_property_add_bool(obj, "nvdimm",
+                            spapr_get_nvdimm, spapr_set_nvdimm, NULL);
+    object_property_set_description(obj, "nvdimm",
+                                    "Enable support for nvdimm devices",
+                                    NULL);
 }
 
 static void spapr_machine_finalizefn(Object *obj)
@@ -3404,6 +3520,16 @@ static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
     }
 }
 
+int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
+                           void *fdt, int *fdt_start_offset, Error **errp)
+{
+    NVDIMMDevice *nvdimm = NVDIMM(drc->dev);
+
+    *fdt_start_offset = spapr_populate_nvdimm_node(fdt, 0, nvdimm);
+
+    return 0;
+}
+
 int spapr_lmb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                           void *fdt, int *fdt_start_offset, Error **errp)
 {
@@ -3466,12 +3592,37 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
     }
 }
 
+static void spapr_add_nvdimm(DeviceState *dev, uint64_t addr, Error **errp)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_hotplug_handler(dev));
+    SpaprDrc *drc;
+    bool hotplugged = spapr_drc_hotplugged(dev);
+    Error *local_err = NULL;
+
+    spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_PMEM,
+                           addr / SPAPR_MINIMUM_SCM_BLOCK_SIZE);
+    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM,
+                          addr / SPAPR_MINIMUM_SCM_BLOCK_SIZE);
+    g_assert(drc);
+
+    spapr_drc_attach(drc, dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (hotplugged) {
+        spapr_hotplug_req_add_by_index(drc);
+    }
+}
+
 static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                               Error **errp)
 {
     Error *local_err = NULL;
     SpaprMachineState *ms = SPAPR_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm = PC_DIMM(dev);
+    bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
     uint64_t size, addr;
 
     size = memory_device_get_region_size(MEMORY_DEVICE(dev), &error_abort);
@@ -3487,8 +3638,14 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         goto out_unplug;
     }
 
-    spapr_add_lmbs(dev, addr, size, spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
-                   &local_err);
+    if (!is_nvdimm) {
+        spapr_add_lmbs(dev, addr, size,
+                       spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
+                       &local_err);
+    } else {
+        spapr_add_nvdimm(dev, addr, &local_err);
+    }
+
     if (local_err) {
         goto out_unplug;
     }
@@ -3506,6 +3663,7 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     const SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(hotplug_dev);
     SpaprMachineState *spapr = SPAPR_MACHINE(hotplug_dev);
+    bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
     PCDIMMDevice *dimm = PC_DIMM(dev);
     Error *local_err = NULL;
     uint64_t size;
@@ -3523,10 +3681,28 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    if (size % SPAPR_MEMORY_BLOCK_SIZE) {
+    if (!is_nvdimm && size % SPAPR_MEMORY_BLOCK_SIZE) {
         error_setg(errp, "Hotplugged memory size must be a multiple of "
-                      "%" PRIu64 " MB", SPAPR_MEMORY_BLOCK_SIZE / MiB);
+                          "%" PRIu64 " MB", SPAPR_MEMORY_BLOCK_SIZE / MiB);
         return;
+    } else if (is_nvdimm) {
+        char *uuidstr = NULL;
+        QemuUUID uuid;
+        if (size % SPAPR_MINIMUM_SCM_BLOCK_SIZE) {
+            error_setg(errp, "NVDIMM memory size excluding the label area"
+                       " must be a multiple of "
+                       "%" PRIu64 "MB",
+                       SPAPR_MINIMUM_SCM_BLOCK_SIZE / MiB);
+            return;
+        }
+
+        uuidstr = object_property_get_str(OBJECT(dimm), NVDIMM_UUID_PROP, NULL);
+        qemu_uuid_parse(uuidstr, &uuid);
+        if (qemu_uuid_is_null(&uuid)) {
+            error_setg(errp, "NVDIMM device requires the uuid to be set");
+            return;
+        }
+        g_free(uuidstr);
     }
 
     memdev = object_property_get_link(OBJECT(dimm), PC_DIMM_MEMDEV_PROP,
@@ -3666,6 +3842,12 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
     int i;
     SpaprDrc *drc;
 
+    if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
+        error_setg(&local_err,
+                   "nvdimm device hot unplug is not supported yet.");
+        goto out;
+    }
+
     size = memory_device_get_region_size(MEMORY_DEVICE(dimm), &error_abort);
     nr_lmbs = size / SPAPR_MEMORY_BLOCK_SIZE;
 
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 597f236b9c..983440a711 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -707,6 +707,17 @@ static void spapr_drc_phb_class_init(ObjectClass *k, void *data)
     drck->dt_populate = spapr_phb_dt_populate;
 }
 
+static void spapr_drc_pmem_class_init(ObjectClass *k, void *data)
+{
+    SpaprDrcClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
+
+    drck->typeshift = SPAPR_DR_CONNECTOR_TYPE_SHIFT_PMEM;
+    drck->typename = "MEM";
+    drck->drc_name_prefix = "PMEM ";
+    drck->release = NULL;
+    drck->dt_populate = spapr_pmem_dt_populate;
+}
+
 static const TypeInfo spapr_dr_connector_info = {
     .name          = TYPE_SPAPR_DR_CONNECTOR,
     .parent        = TYPE_DEVICE,
@@ -757,6 +768,12 @@ static const TypeInfo spapr_drc_phb_info = {
     .class_init    = spapr_drc_phb_class_init,
 };
 
+static const TypeInfo spapr_drc_pmem_info = {
+    .name          = TYPE_SPAPR_DRC_PMEM,
+    .parent        = TYPE_SPAPR_DRC_LOGICAL,
+    .class_init    = spapr_drc_pmem_class_init,
+};
+
 /* helper functions for external users */
 
 SpaprDrc *spapr_drc_by_index(uint32_t index)
@@ -1226,6 +1243,7 @@ static void spapr_drc_register_types(void)
     type_register_static(&spapr_drc_pci_info);
     type_register_static(&spapr_drc_lmb_info);
     type_register_static(&spapr_drc_phb_info);
+    type_register_static(&spapr_drc_pmem_info);
 
     spapr_rtas_register(RTAS_SET_INDICATOR, "set-indicator",
                         rtas_set_indicator);
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index ae0f093f59..1141203a87 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -193,6 +193,7 @@ struct rtas_event_log_v6_hp {
 #define RTAS_LOG_V6_HP_TYPE_SLOT                         3
 #define RTAS_LOG_V6_HP_TYPE_PHB                          4
 #define RTAS_LOG_V6_HP_TYPE_PCI                          5
+#define RTAS_LOG_V6_HP_TYPE_PMEM                         6
     uint8_t hotplug_action;
 #define RTAS_LOG_V6_HP_ACTION_ADD                        1
 #define RTAS_LOG_V6_HP_ACTION_REMOVE                     2
@@ -529,6 +530,9 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
     case SPAPR_DR_CONNECTOR_TYPE_PHB:
         hp->hotplug_type = RTAS_LOG_V6_HP_TYPE_PHB;
         break;
+    case SPAPR_DR_CONNECTOR_TYPE_PMEM:
+        hp->hotplug_type = RTAS_LOG_V6_HP_TYPE_PMEM;
+        break;
     default:
         /* we shouldn't be signaling hotplug events for resources
          * that don't support them
diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index bad4fc04b5..3089615e17 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -49,6 +49,7 @@
                                                TYPE_NVDIMM)
 
 #define NVDIMM_LABEL_SIZE_PROP "label-size"
+#define NVDIMM_UUID_PROP "uuid"
 #define NVDIMM_UNARMED_PROP    "unarmed"
 
 struct NVDIMMDevice {
@@ -83,6 +84,11 @@ struct NVDIMMDevice {
      * the guest write persistence.
      */
     bool unarmed;
+
+    /*
+     * The PPC64 - spapr requires each nvdimm device have a uuid.
+     */
+    QemuUUID uuid;
 };
 typedef struct NVDIMMDevice NVDIMMDevice;
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 7e32f309c2..394ea26335 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -202,6 +202,7 @@ struct SpaprMachineState {
     SpaprCapabilities def, eff, mig;
 
     unsigned gpu_numa_id;
+    bool nvdimm_enabled;
 };
 
 #define H_SUCCESS         0
@@ -794,6 +795,8 @@ int spapr_core_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
 void spapr_lmb_release(DeviceState *dev);
 int spapr_lmb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                           void *fdt, int *fdt_start_offset, Error **errp);
+int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
+                          void *fdt, int *fdt_start_offset, Error **errp);
 void spapr_phb_release(DeviceState *dev);
 int spapr_phb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                           void *fdt, int *fdt_start_offset, Error **errp);
@@ -829,6 +832,15 @@ int spapr_rtc_import_offset(SpaprRtcState *rtc, int64_t legacy_offset);
 #define SPAPR_LMB_FLAGS_DRC_INVALID 0x00000020
 #define SPAPR_LMB_FLAGS_RESERVED 0x00000080
 
+/*
+ * The nvdimm size should be aligned to SCM block size.
+ * The SCM block size should be aligned to SPAPR_MEMORY_BLOCK_SIZE
+ * inorder to have SCM regions not to overlap with dimm memory regions.
+ * The SCM devices can have variable block sizes. For now, fixing the
+ * block size to the minimum value.
+ */
+#define SPAPR_MINIMUM_SCM_BLOCK_SIZE SPAPR_MEMORY_BLOCK_SIZE
+
 void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg);
 
 #define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index fad0a887f9..8b7ce41a0f 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -79,6 +79,13 @@
 #define SPAPR_DRC_PHB(obj) OBJECT_CHECK(SpaprDrc, (obj), \
                                         TYPE_SPAPR_DRC_PHB)
 
+#define TYPE_SPAPR_DRC_PMEM "spapr-drc-pmem"
+#define SPAPR_DRC_PMEM_GET_CLASS(obj) \
+        OBJECT_GET_CLASS(SpaprDrcClass, obj, TYPE_SPAPR_DRC_PMEM)
+#define SPAPR_DRC_PMEM_CLASS(klass) \
+        OBJECT_CLASS_CHECK(SpaprDrcClass, klass, TYPE_SPAPR_DRC_PMEM)
+#define SPAPR_DRC_PMEM(obj) OBJECT_CHECK(SpaprDrc, (obj), \
+                                        TYPE_SPAPR_DRC_PMEM)
 /*
  * Various hotplug types managed by SpaprDrc
  *
@@ -96,6 +103,7 @@ typedef enum {
     SPAPR_DR_CONNECTOR_TYPE_SHIFT_VIO = 3,
     SPAPR_DR_CONNECTOR_TYPE_SHIFT_PCI = 4,
     SPAPR_DR_CONNECTOR_TYPE_SHIFT_LMB = 8,
+    SPAPR_DR_CONNECTOR_TYPE_SHIFT_PMEM = 9,
 } SpaprDrcTypeShift;
 
 typedef enum {
@@ -105,6 +113,7 @@ typedef enum {
     SPAPR_DR_CONNECTOR_TYPE_VIO = 1 << SPAPR_DR_CONNECTOR_TYPE_SHIFT_VIO,
     SPAPR_DR_CONNECTOR_TYPE_PCI = 1 << SPAPR_DR_CONNECTOR_TYPE_SHIFT_PCI,
     SPAPR_DR_CONNECTOR_TYPE_LMB = 1 << SPAPR_DR_CONNECTOR_TYPE_SHIFT_LMB,
+    SPAPR_DR_CONNECTOR_TYPE_PMEM = 1 << SPAPR_DR_CONNECTOR_TYPE_SHIFT_PMEM,
 } SpaprDrcType;
 
 /*


