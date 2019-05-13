Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30738C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:30:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E84B620873
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84B620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54000 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ7Ht-00086x-0h
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 05:30:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbhat@linux.ibm.com>) id 1hQ7GY-0007ND-CY
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbhat@linux.ibm.com>) id 1hQ7GW-0005yy-OY
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:29:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1hQ7GW-0005yd-H8
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:29:00 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4D9StU7144240
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 05:28:59 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sf2ekrhvc-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 05:28:57 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
	Mon, 13 May 2019 10:28:42 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 13 May 2019 10:28:39 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
	[9.149.105.232])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4D9Scol58720424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Mon, 13 May 2019 09:28:39 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FB4852090;
	Mon, 13 May 2019 09:28:38 +0000 (GMT)
Received: from lep8c.aus.stglabs.ibm.com (unknown [9.40.192.207])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0AD2052073;
	Mon, 13 May 2019 09:28:36 +0000 (GMT)
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: imammedo@redhat.com, david@gibson.dropbear.id.au,
	xiaoguangrong.eric@gmail.com, mst@redhat.com
Date: Mon, 13 May 2019 04:28:36 -0500
In-Reply-To: <155773946961.49142.5208084426066783536.stgit@lep8c.aus.stglabs.ibm.com>
References: <155773946961.49142.5208084426066783536.stgit@lep8c.aus.stglabs.ibm.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19051309-0020-0000-0000-0000033C0D5A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051309-0021-0000-0000-0000218EC163
Message-Id: <155773968985.49142.1164691973469833295.stgit@lep8c.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-13_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905130068
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [RFC v2 PATCH 3/3] spapr: Add Hcalls to support PAPR
 NVDIMM device
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

This patch implements few of the necessary hcalls for the nvdimm support.

PAPR semantics is such that each NVDIMM device is comprising of multiple
SCM(Storage Class Memory) blocks. The guest requests the hypervisor to bind
each of the SCM blocks of the NVDIMM device using hcalls. There can be
SCM block unbind requests in case of driver errors or unplug(not supported now)
use cases. The NVDIMM label read/writes are done through hcalls.

Since each virtual NVDIMM device is divided into multiple SCM blocks, the bind,
unbind, and queries using hcalls on those blocks can come independently. This
doesn't fit well into the qemu device semantics, where the map/unmap are done
at the (whole)device/object level granularity. The patch doesnt actually
bind/unbind on hcalls but let it happen at the object_add/del phase itself
instead.

The guest kernel makes bind/unbind requests for the virtual NVDIMM device at the
region level granularity. Without interleaving, each virtual NVDIMM device is
presented as separate region. There is no way to configure the virtual NVDIMM
interleaving for the guests today. So, there is no way a partial bind/unbind
request can come for the vNVDIMM in a hcall for a subset of SCM blocks of a
virtual NVDIMM. Hence it is safe to do bind/unbind everything during the
object_add/del.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 hw/ppc/spapr_hcall.c   |  202 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |    7 +-
 2 files changed, 208 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 6c16d2b120..b6e7d04dcf 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -3,11 +3,13 @@
 #include "sysemu/hw_accel.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
+#include "qemu/range.h"
 #include "qemu/error-report.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "helper_regs.h"
 #include "hw/ppc/spapr.h"
+#include "hw/ppc/spapr_drc.h"
 #include "hw/ppc/spapr_cpu_core.h"
 #include "mmu-hash64.h"
 #include "cpu-models.h"
@@ -16,6 +18,7 @@
 #include "hw/ppc/spapr_ovec.h"
 #include "mmu-book3s-v3.h"
 #include "hw/mem/memory-device.h"
+#include "hw/mem/nvdimm.h"
 
 static bool has_spr(PowerPCCPU *cpu, int spr)
 {
@@ -1795,6 +1798,199 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return H_SUCCESS;
 }
 
+static target_ulong h_scm_read_metadata(PowerPCCPU *cpu,
+                                        SpaprMachineState *spapr,
+                                        target_ulong opcode,
+                                        target_ulong *args)
+{
+    uint32_t drc_index = args[0];
+    uint64_t offset = args[1];
+    uint64_t numBytesToRead = args[2];
+    SpaprDrc *drc = spapr_drc_by_index(drc_index);
+    NVDIMMDevice *nvdimm = NULL;
+    NVDIMMClass *ddc = NULL;
+
+    if (drc && spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PMEM) {
+        return H_PARAMETER;
+    }
+
+    if (numBytesToRead != 1 && numBytesToRead != 2 &&
+        numBytesToRead != 4 && numBytesToRead != 8) {
+        return H_P3;
+    }
+
+    nvdimm = NVDIMM(drc->dev);
+    if ((offset + numBytesToRead < offset) ||
+        (nvdimm->label_size < numBytesToRead + offset)) {
+        return H_P2;
+    }
+
+    ddc = NVDIMM_GET_CLASS(nvdimm);
+    ddc->read_label_data(nvdimm, &args[0], numBytesToRead, offset);
+
+    return H_SUCCESS;
+}
+
+
+static target_ulong h_scm_write_metadata(PowerPCCPU *cpu,
+                                         SpaprMachineState *spapr,
+                                         target_ulong opcode,
+                                         target_ulong *args)
+{
+    uint32_t drc_index = args[0];
+    uint64_t offset = args[1];
+    uint64_t data = args[2];
+    int8_t numBytesToWrite = args[3];
+    SpaprDrc *drc = spapr_drc_by_index(drc_index);
+    NVDIMMDevice *nvdimm = NULL;
+    DeviceState *dev = NULL;
+    NVDIMMClass *ddc = NULL;
+
+    if (drc && spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PMEM) {
+        return H_PARAMETER;
+    }
+
+    if (numBytesToWrite != 1 && numBytesToWrite != 2 &&
+        numBytesToWrite != 4 && numBytesToWrite != 8) {
+        return H_P4;
+    }
+
+    dev = drc->dev;
+    nvdimm = NVDIMM(dev);
+    if ((nvdimm->label_size < numBytesToWrite + offset) ||
+        (offset + numBytesToWrite < offset)) {
+        return H_P2;
+    }
+
+    ddc = NVDIMM_GET_CLASS(nvdimm);
+    ddc->write_label_data(nvdimm, &data, numBytesToWrite, offset);
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_scm_bind_mem(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                                        target_ulong opcode,
+                                        target_ulong *args)
+{
+    uint32_t drc_index = args[0];
+    uint64_t starting_idx = args[1];
+    uint64_t no_of_scm_blocks_to_bind = args[2];
+    uint64_t target_logical_mem_addr = args[3];
+    uint64_t continue_token = args[4];
+    uint64_t size;
+    uint64_t total_no_of_scm_blocks;
+
+    SpaprDrc *drc = spapr_drc_by_index(drc_index);
+    hwaddr addr;
+    DeviceState *dev = NULL;
+    PCDIMMDevice *dimm = NULL;
+    Error *local_err = NULL;
+
+    if (drc && spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PMEM) {
+        return H_PARAMETER;
+    }
+
+    dev = drc->dev;
+    dimm = PC_DIMM(dev);
+
+    size = object_property_get_uint(OBJECT(dimm),
+                                    PC_DIMM_SIZE_PROP, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return H_PARAMETER;
+    }
+
+    total_no_of_scm_blocks = size / SPAPR_MINIMUM_SCM_BLOCK_SIZE;
+
+    if ((starting_idx > total_no_of_scm_blocks) ||
+        (no_of_scm_blocks_to_bind > total_no_of_scm_blocks)) {
+        return H_P2;
+    }
+
+    if (((starting_idx + no_of_scm_blocks_to_bind) < starting_idx) ||
+        ((starting_idx + no_of_scm_blocks_to_bind) > total_no_of_scm_blocks)) {
+        return H_P3;
+    }
+
+    /* Currently qemu assigns the address. */
+    if (target_logical_mem_addr != 0xffffffffffffffff) {
+        return H_OVERLAP;
+    }
+
+    /*
+     * Currently continue token should be zero qemu has already bound
+     * everything and this hcall doesnt return H_BUSY.
+     */
+    if (continue_token > 0) {
+        return H_P5;
+    }
+
+    /* NB : Already bound, Return target logical address in R4 */
+    addr = object_property_get_uint(OBJECT(dimm),
+                                    PC_DIMM_ADDR_PROP, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return H_PARAMETER;
+    }
+
+    args[1] = addr;
+    args[2] = no_of_scm_blocks_to_bind;
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_scm_unbind_mem(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                                        target_ulong opcode,
+                                        target_ulong *args)
+{
+    uint32_t drc_index = args[0];
+    uint64_t starting_scm_logical_addr = args[1];
+    uint64_t no_of_scm_blocks_to_unbind = args[2];
+    uint64_t size_to_unbind;
+    uint64_t continue_token = args[3];
+    Range blockrange = range_empty;
+    Range nvdimmrange = range_empty;
+    SpaprDrc *drc = spapr_drc_by_index(drc_index);
+    DeviceState *dev = NULL;
+    PCDIMMDevice *dimm = NULL;
+    uint64_t size, addr;
+
+    if (drc && spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PMEM) {
+        return H_PARAMETER;
+    }
+
+    /* Check if starting_scm_logical_addr is block aligned */
+    if (!QEMU_IS_ALIGNED(starting_scm_logical_addr,
+                         SPAPR_MINIMUM_SCM_BLOCK_SIZE)) {
+        return H_P2;
+    }
+
+    dev = drc->dev;
+    dimm = PC_DIMM(dev);
+    size = object_property_get_int(OBJECT(dimm), PC_DIMM_SIZE_PROP, NULL);
+    addr = object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PROP, NULL);
+
+    range_init_nofail(&nvdimmrange, addr, size);
+
+    size_to_unbind = no_of_scm_blocks_to_unbind * SPAPR_MINIMUM_SCM_BLOCK_SIZE;
+
+
+    range_init_nofail(&blockrange, starting_scm_logical_addr, size_to_unbind);
+
+    if (!range_contains_range(&nvdimmrange, &blockrange)) {
+        return H_P3;
+    }
+
+    if (continue_token > 0) {
+        return H_P3;
+    }
+
+    args[1] = no_of_scm_blocks_to_unbind;
+
+    /*NB : dont do anything, let object_del take care of this for now. */
+    return H_SUCCESS;
+}
+
 static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
 static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_HCALL_BASE + 1];
 
@@ -1894,6 +2090,12 @@ static void hypercall_register_types(void)
     /* qemu/KVM-PPC specific hcalls */
     spapr_register_hypercall(KVMPPC_H_RTAS, h_rtas);
 
+    /* qemu/scm specific hcalls */
+    spapr_register_hypercall(H_SCM_READ_METADATA, h_scm_read_metadata);
+    spapr_register_hypercall(H_SCM_WRITE_METADATA, h_scm_write_metadata);
+    spapr_register_hypercall(H_SCM_BIND_MEM, h_scm_bind_mem);
+    spapr_register_hypercall(H_SCM_UNBIND_MEM, h_scm_unbind_mem);
+
     /* ibm,client-architecture-support support */
     spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support);
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 394ea26335..48e2cc9d67 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -283,6 +283,7 @@ struct SpaprMachineState {
 #define H_P7              -60
 #define H_P8              -61
 #define H_P9              -62
+#define H_OVERLAP         -68
 #define H_UNSUPPORTED_FLAG -256
 #define H_MULTI_THREADS_ACTIVE -9005
 
@@ -490,8 +491,12 @@ struct SpaprMachineState {
 #define H_INT_ESB               0x3C8
 #define H_INT_SYNC              0x3CC
 #define H_INT_RESET             0x3D0
+#define H_SCM_READ_METADATA     0x3E4
+#define H_SCM_WRITE_METADATA    0x3E8
+#define H_SCM_BIND_MEM          0x3EC
+#define H_SCM_UNBIND_MEM        0x3F0
 
-#define MAX_HCALL_OPCODE        H_INT_RESET
+#define MAX_HCALL_OPCODE        H_SCM_UNBIND_MEM
 
 /* The hcalls above are standardized in PAPR and implemented by pHyp
  * as well.


