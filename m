Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E12CC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 14:30:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F9E7206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 14:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F9E7206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWL4B-0000yr-47
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 10:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jWL1k-0005Xw-6C
 for qemu-devel@nongnu.org; Wed, 06 May 2020 10:28:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32500)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jWL1i-0004QR-Nk
 for qemu-devel@nongnu.org; Wed, 06 May 2020 10:27:59 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 046E1ids047482; Wed, 6 May 2020 10:27:50 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30u8t70ucu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 May 2020 10:27:50 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 046E1tgs048528;
 Wed, 6 May 2020 10:27:50 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30u8t70ucd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 May 2020 10:27:50 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 046EPK2U001460;
 Wed, 6 May 2020 14:27:48 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma03wdc.us.ibm.com with ESMTP id 30s0g71u2f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 May 2020 14:27:48 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 046ERm5R42336700
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 May 2020 14:27:48 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6BAE0B2064;
 Wed,  6 May 2020 14:27:48 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52592B206B;
 Wed,  6 May 2020 14:27:48 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed,  6 May 2020 14:27:48 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 3/3] hw: add compat machines for 5.1
Date: Wed,  6 May 2020 10:27:46 -0400
Message-Id: <20200506142746.369563-4-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200506142746.369563-1-stefanb@linux.vnet.ibm.com>
References: <20200506142746.369563-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-05-06_06:2020-05-05,
 2020-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 suspectscore=1 bulkscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 phishscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060108
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=stefanb@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 10:27:51
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, Cornelia Huck <cohuck@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cornelia Huck <cohuck@redhat.com>

Add 5.1 machine types for arm/i440fx/q35/s390x/spapr.

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Message-id: 20200429144605.7262-1-cohuck@redhat.com
---
 hw/arm/virt.c              |  8 +++++++-
 hw/core/machine.c          |  3 +++
 hw/i386/pc.c               |  3 +++
 hw/i386/pc_piix.c          | 14 +++++++++++++-
 hw/i386/pc_q35.c           | 13 ++++++++++++-
 hw/ppc/spapr.c             | 15 +++++++++++++--
 hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
 include/hw/boards.h        |  3 +++
 include/hw/i386/pc.h       |  3 +++
 9 files changed, 70 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index dd024d0780..634db0cfe9 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2352,10 +2352,16 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
+static void virt_machine_5_1_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(5, 1)
+
 static void virt_machine_5_0_options(MachineClass *mc)
 {
+    virt_machine_5_1_options(mc);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(5, 0)
+DEFINE_VIRT_MACHINE(5, 0)
 
 static void virt_machine_4_2_options(MachineClass *mc)
 {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index c1a444cb75..7a50dd518f 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -28,6 +28,9 @@
 #include "hw/mem/nvdimm.h"
 #include "migration/vmstate.h"
 
+GlobalProperty hw_compat_5_0[] = {};
+const size_t hw_compat_5_0_len = G_N_ELEMENTS(hw_compat_5_0);
+
 GlobalProperty hw_compat_4_2[] = {
     { "virtio-blk-device", "queue-size", "128"},
     { "virtio-scsi-device", "virtqueue_size", "128"},
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f6b8431c8b..97e345faea 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -95,6 +95,9 @@
 #include "fw_cfg.h"
 #include "trace.h"
 
+GlobalProperty pc_compat_5_0[] = {};
+const size_t pc_compat_5_0_len = G_N_ELEMENTS(pc_compat_5_0);
+
 GlobalProperty pc_compat_4_2[] = {
     { "mch", "smbase-smram", "off" },
 };
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index b75087d71b..3862e5120e 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -421,7 +421,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
 }
 
-static void pc_i440fx_5_0_machine_options(MachineClass *m)
+static void pc_i440fx_5_1_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_i440fx_machine_options(m);
@@ -430,6 +430,18 @@ static void pc_i440fx_5_0_machine_options(MachineClass *m)
     pcmc->default_cpu_version = 1;
 }
 
+DEFINE_I440FX_MACHINE(v5_1, "pc-i440fx-5.1", NULL,
+                      pc_i440fx_5_1_machine_options);
+
+static void pc_i440fx_5_0_machine_options(MachineClass *m)
+{
+    pc_i440fx_5_1_machine_options(m);
+    m->alias = NULL;
+    m->is_default = false;
+    compat_props_add(m->compat_props, hw_compat_5_0, hw_compat_5_0_len);
+    compat_props_add(m->compat_props, pc_compat_5_0, pc_compat_5_0_len);
+}
+
 DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0", NULL,
                       pc_i440fx_5_0_machine_options);
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d2806c1b29..3349e38a4c 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -351,7 +351,7 @@ static void pc_q35_machine_options(MachineClass *m)
     m->max_cpus = 288;
 }
 
-static void pc_q35_5_0_machine_options(MachineClass *m)
+static void pc_q35_5_1_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_q35_machine_options(m);
@@ -359,6 +359,17 @@ static void pc_q35_5_0_machine_options(MachineClass *m)
     pcmc->default_cpu_version = 1;
 }
 
+DEFINE_Q35_MACHINE(v5_1, "pc-q35-5.1", NULL,
+                   pc_q35_5_1_machine_options);
+
+static void pc_q35_5_0_machine_options(MachineClass *m)
+{
+    pc_q35_5_1_machine_options(m);
+    m->alias = NULL;
+    compat_props_add(m->compat_props, hw_compat_5_0, hw_compat_5_0_len);
+    compat_props_add(m->compat_props, pc_compat_5_0, pc_compat_5_0_len);
+}
+
 DEFINE_Q35_MACHINE(v5_0, "pc-q35-5.0", NULL,
                    pc_q35_5_0_machine_options);
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9a2bd501aa..fd5bfd11a8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4599,15 +4599,26 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
     }                                                                \
     type_init(spapr_machine_register_##suffix)
 
+/*
+ * pseries-5.1
+ */
+static void spapr_machine_5_1_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class */
+}
+
+DEFINE_SPAPR_MACHINE(5_1, "5.1", true);
+
 /*
  * pseries-5.0
  */
 static void spapr_machine_5_0_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class */
+    spapr_machine_5_1_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
 }
 
-DEFINE_SPAPR_MACHINE(5_0, "5.0", true);
+DEFINE_SPAPR_MACHINE(5_0, "5.0", false);
 
 /*
  * pseries-4.2
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 45292fb5a8..f660070d22 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -801,14 +801,26 @@ bool css_migration_enabled(void)
     }                                                                         \
     type_init(ccw_machine_register_##suffix)
 
+static void ccw_machine_5_1_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_5_1_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE(5_1, "5.1", true);
+
 static void ccw_machine_5_0_instance_options(MachineState *machine)
 {
+    ccw_machine_5_1_instance_options(machine);
 }
 
 static void ccw_machine_5_0_class_options(MachineClass *mc)
 {
+    ccw_machine_5_1_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
 }
-DEFINE_CCW_MACHINE(5_0, "5.0", true);
+DEFINE_CCW_MACHINE(5_0, "5.0", false);
 
 static void ccw_machine_4_2_instance_options(MachineState *machine)
 {
diff --git a/include/hw/boards.h b/include/hw/boards.h
index fd4d62b501..18815d9be2 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -318,6 +318,9 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
 
+extern GlobalProperty hw_compat_5_0[];
+extern const size_t hw_compat_5_0_len;
+
 extern GlobalProperty hw_compat_4_2[];
 extern const size_t hw_compat_4_2_len;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 05e19455bb..8d764f965c 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -191,6 +191,9 @@ void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
 void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
                        const CPUArchIdList *apic_ids, GArray *entry);
 
+extern GlobalProperty pc_compat_5_0[];
+extern const size_t pc_compat_5_0_len;
+
 extern GlobalProperty pc_compat_4_2[];
 extern const size_t pc_compat_4_2_len;
 
-- 
2.24.1


