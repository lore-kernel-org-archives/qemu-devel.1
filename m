Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27667C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 22:15:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD0AE2071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 22:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0AE2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv7En-0000yN-2w
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 17:15:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <walling@linux.ibm.com>) id 1iv7De-0007oJ-T5
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 17:14:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <walling@linux.ibm.com>) id 1iv7Dc-0000FE-QF
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 17:14:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60840)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <walling@linux.ibm.com>)
 id 1iv7Dc-0000Dn-IL; Fri, 24 Jan 2020 17:14:24 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00OMC7nf097952; Fri, 24 Jan 2020 17:14:23 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xr61swh60-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jan 2020 17:14:23 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00OMD9Uj101697;
 Fri, 24 Jan 2020 17:14:22 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xr61swh5m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jan 2020 17:14:22 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00OM547f022664;
 Fri, 24 Jan 2020 22:14:21 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma01dal.us.ibm.com with ESMTP id 2xksn7rk6s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jan 2020 22:14:21 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00OMEKxV45220112
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jan 2020 22:14:20 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 155D8C60A0;
 Fri, 24 Jan 2020 22:14:20 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD9B1C609C;
 Fri, 24 Jan 2020 22:14:19 +0000 (GMT)
Received: from collin-ThinkPad-W541.pok.ibm.com (unknown [9.56.58.87])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 24 Jan 2020 22:14:19 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v6 2/2] s390: diagnose 318 info reset and migration support
Date: Fri, 24 Jan 2020 17:14:04 -0500
Message-Id: <1579904044-20790-3-git-send-email-walling@linux.ibm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579904044-20790-1-git-send-email-walling@linux.ibm.com>
References: <1579904044-20790-1-git-send-email-walling@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-24_07:2020-01-24,
 2020-01-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001240180
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DIAGNOSE 0x318 (diag318) is a privileged s390x instruction that must
be intercepted by SIE and handled via KVM. Let's introduce some
functions to communicate between QEMU and KVM via ioctls. These
will be used to get/set the diag318 information.

The availability of this instruction is determined by byte 134, bit 0
of the Read Info block. This coincidentally expands into the space used
for CPU entries by taking away one byte, which means VMs running with
the diag318 capability will not be able to retrieve information regarding
the 248th CPU. This will not effect performance, and VMs can still be
ran with 248 CPUs.

In order to simplify the migration and system reset requirements of
the diag318 data, let's introduce it as a device class and include
a VMStateDescription.

Diag318 is set to 0 during modified clear and load normal resets.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 hw/s390x/Makefile.objs              |  1 +
 hw/s390x/diag318.c                  | 85 +++++++++++++++++++++++++++++++++++++
 hw/s390x/diag318.h                  | 40 +++++++++++++++++
 hw/s390x/s390-virtio-ccw.c          | 17 ++++++++
 hw/s390x/sclp.c                     | 13 ++++++
 include/hw/s390x/sclp.h             |  2 +
 target/s390x/cpu_features.h         |  1 +
 target/s390x/cpu_features_def.inc.h |  3 ++
 target/s390x/gen-features.c         |  1 +
 target/s390x/kvm-stub.c             | 10 +++++
 target/s390x/kvm.c                  | 29 +++++++++++++
 target/s390x/kvm_s390x.h            |  2 +
 12 files changed, 204 insertions(+)
 create mode 100644 hw/s390x/diag318.c
 create mode 100644 hw/s390x/diag318.h

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index e02ed80..93621dc 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -34,3 +34,4 @@ obj-$(CONFIG_KVM) += s390-stattrib-kvm.o
 obj-y += s390-ccw.o
 obj-y += ap-device.o
 obj-y += ap-bridge.o
+obj-y += diag318.o
diff --git a/hw/s390x/diag318.c b/hw/s390x/diag318.c
new file mode 100644
index 0000000..2d30bb2
--- /dev/null
+++ b/hw/s390x/diag318.c
@@ -0,0 +1,85 @@
+/*
+ * DIAGNOSE 0x318 functions for reset and migration
+ *
+ * Copyright IBM, Corp. 2019
+ *
+ * Authors:
+ *  Collin Walling <walling@linux.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at your
+ * option) any later version. See the COPYING file in the top-level directory.
+ */
+
+#include "hw/s390x/diag318.h"
+#include "qapi/error.h"
+#include "kvm_s390x.h"
+#include "sysemu/kvm.h"
+
+static int diag318_post_load(void *opaque, int version_id)
+{
+    DIAG318State *d = opaque;
+
+    if (kvm_enabled())
+        kvm_s390_set_diag318_info(d->info);
+
+    return 0;
+}
+
+static int diag318_pre_save(void *opaque)
+{
+    DIAG318State *d = opaque;
+
+    if (kvm_enabled())
+        kvm_s390_get_diag318_info(&d->info);
+
+    return 0;
+}
+
+static bool diag318_needed(void *opaque)
+{
+    return kvm_enabled() ? s390_has_feat(S390_FEAT_DIAG318) : 0;
+}
+
+const VMStateDescription vmstate_diag318 = {
+    .name = "vmstate_diag318",
+    .post_load = diag318_post_load,
+    .pre_save = diag318_pre_save,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = diag318_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(info, DIAG318State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void s390_diag318_reset(DeviceState *dev)
+{
+    if (kvm_enabled())
+        kvm_s390_set_diag318_info(0);
+}
+
+static void s390_diag318_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = s390_diag318_reset;
+    dc->vmsd = &vmstate_diag318;
+    dc->hotpluggable = false;
+    /* Reason: Created automatically during machine instantiation */
+    dc->user_creatable = false;
+}
+
+static const TypeInfo s390_diag318_info = {
+    .class_init = s390_diag318_class_init,
+    .parent = TYPE_DEVICE,
+    .name = TYPE_S390_DIAG318,
+    .instance_size = sizeof(DIAG318State),
+};
+
+static void s390_diag318_register_types(void)
+{
+    type_register_static(&s390_diag318_info);
+}
+
+type_init(s390_diag318_register_types)
diff --git a/hw/s390x/diag318.h b/hw/s390x/diag318.h
new file mode 100644
index 0000000..06d9f67
--- /dev/null
+++ b/hw/s390x/diag318.h
@@ -0,0 +1,40 @@
+/*
+ * DIAGNOSE 0x318 functions for reset and migration
+ *
+ * Copyright IBM, Corp. 2019
+ *
+ * Authors:
+ *  Collin Walling <walling@linux.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at your
+ * option) any later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_DIAG318_H
+#define HW_DIAG318_H
+
+#include "qemu/osdep.h"
+#include "migration/vmstate.h"
+#include "qom/object.h"
+#include "hw/qdev-core.h"
+
+#define TYPE_S390_DIAG318 "diag318"
+#define DIAG318(obj) \
+    OBJECT_CHECK(DIAG318State, (obj), TYPE_S390_DIAG318)
+
+typedef struct DIAG318State {
+    /*< private >*/
+    DeviceState parent_obj;
+
+    /*< public >*/
+    uint64_t info;
+} DIAG318State;
+
+typedef struct DIAG318Class {
+    /*< private >*/
+    DeviceClass parent_class;
+
+    /*< public >*/
+} DIAG318Class;
+
+#endif /* HW_DIAG318_H */
\ No newline at end of file
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index e0e2813..d5b7a33 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -41,6 +41,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/s390x/tod.h"
 #include "sysemu/sysemu.h"
+#include "hw/s390x/diag318.h"
 
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
 {
@@ -97,6 +98,7 @@ static const char *const reset_dev_types[] = {
     "s390-sclp-event-facility",
     "s390-flic",
     "diag288",
+    TYPE_S390_DIAG318,
 };
 
 static void subsystem_reset(void)
@@ -237,6 +239,17 @@ static void s390_create_sclpconsole(const char *type, Chardev *chardev)
     qdev_init_nofail(dev);
 }
 
+static void s390_init_diag318(void)
+{
+    Object *new = object_new(TYPE_S390_DIAG318);
+    DeviceState *dev = DEVICE(new);
+
+    object_property_add_child(qdev_get_machine(), TYPE_S390_DIAG318,
+                              new, NULL);
+    object_unref(new);
+    qdev_init_nofail(dev);
+}
+
 static void ccw_init(MachineState *machine)
 {
     int ret;
@@ -294,6 +307,9 @@ static void ccw_init(MachineState *machine)
 
     /* init the TOD clock */
     s390_init_tod();
+
+    /* init object used for migrating diag318 info */
+    s390_init_diag318();
 }
 
 static void s390_cpu_plug(HotplugHandler *hotplug_dev,
@@ -566,6 +582,7 @@ static void machine_set_loadparm(Object *obj, const char *val, Error **errp)
         ms->loadparm[i] = ' '; /* pad right with spaces */
     }
 }
+
 static inline void s390_machine_initfn(Object *obj)
 {
     object_property_add_bool(obj, "aes-key-wrap",
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index f57ce7b..636348c 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "cpu.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
@@ -22,6 +23,7 @@
 #include "hw/s390x/event-facility.h"
 #include "hw/s390x/s390-pci-bus.h"
 #include "hw/s390x/ipl.h"
+#include "kvm_s390x.h"
 
 static inline SCLPDevice *get_sclp_device(void)
 {
@@ -37,10 +39,19 @@ static void prepare_cpu_entries(SCLPDevice *sclp, CPUEntry *entry, int *count)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     uint8_t features[SCCB_CPU_FEATURE_LEN] = { 0 };
+    int max_entries;
     int i;
 
+    /* Calculate the max number of CPU entries that can be stored in the SCCB */
+    max_entries = (SCCB_SIZE - offsetof(ReadInfo, entries)) / sizeof(CPUEntry);
+
     s390_get_feat_block(S390_FEAT_TYPE_SCLP_CPU, features);
     for (i = 0, *count = 0; i < ms->possible_cpus->len; i++) {
+        if (*count == max_entries) {
+            warn_report("Configuration only supports a max of %d CPU entries.",
+                        max_entries);
+            break;
+        }
         if (!ms->possible_cpus->cpus[i].cpu) {
             continue;
         }
@@ -80,6 +91,8 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     s390_get_feat_block(S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT,
                          read_info->conf_char_ext);
 
+    s390_get_feat_block(S390_FEAT_TYPE_SCLP_BYTE_134, read_info->byte_134);
+
     read_info->facilities = cpu_to_be64(SCLP_HAS_CPU_INFO |
                                         SCLP_HAS_IOA_RECONFIG);
 
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index c54413b..08813b4 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -132,6 +132,8 @@ typedef struct ReadInfo {
     uint16_t highest_cpu;
     uint8_t  _reserved5[124 - 122];     /* 122-123 */
     uint32_t hmfai;
+    uint8_t  _reserved7[134 - 128];     /* 128-133 */
+    uint8_t  byte_134[1];
     struct CPUEntry entries[0];
 } QEMU_PACKED ReadInfo;
 
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index da695a8..954544e 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -23,6 +23,7 @@ typedef enum {
     S390_FEAT_TYPE_STFL,
     S390_FEAT_TYPE_SCLP_CONF_CHAR,
     S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT,
+    S390_FEAT_TYPE_SCLP_BYTE_134,
     S390_FEAT_TYPE_SCLP_CPU,
     S390_FEAT_TYPE_MISC,
     S390_FEAT_TYPE_PLO,
diff --git a/target/s390x/cpu_features_def.inc.h b/target/s390x/cpu_features_def.inc.h
index 31dff0d..13d8da5 100644
--- a/target/s390x/cpu_features_def.inc.h
+++ b/target/s390x/cpu_features_def.inc.h
@@ -120,6 +120,9 @@ DEF_FEAT(SIE_CMMA, "cmma", SCLP_CONF_CHAR_EXT, 1, "SIE: Collaborative-memory-man
 DEF_FEAT(SIE_PFMFI, "pfmfi", SCLP_CONF_CHAR_EXT, 9, "SIE: PFMF interpretation facility")
 DEF_FEAT(SIE_IBS, "ibs", SCLP_CONF_CHAR_EXT, 10, "SIE: Interlock-and-broadcast-suppression facility")
 
+/* Features exposed via SCLP SCCB Byte 134 (bit numbers relative to byte-134) */
+DEF_FEAT(DIAG318, "diag318", SCLP_BYTE_134, 0, "Control program name and version codes")
+
 /* Features exposed via SCLP CPU info. */
 DEF_FEAT(SIE_F2, "sief2", SCLP_CPU, 4, "SIE: interception format 2 (Virtual SIE)")
 DEF_FEAT(SIE_SKEY, "skey", SCLP_CPU, 5, "SIE: Storage-key facility")
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 6278845..eaf91e6 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -522,6 +522,7 @@ static uint16_t full_GEN12_GA1[] = {
     S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL,
     S390_FEAT_AP_FACILITIES_TEST,
     S390_FEAT_AP,
+    S390_FEAT_DIAG318,
 };
 
 static uint16_t full_GEN12_GA2[] = {
diff --git a/target/s390x/kvm-stub.c b/target/s390x/kvm-stub.c
index 5152e2b..7c39d6a 100644
--- a/target/s390x/kvm-stub.c
+++ b/target/s390x/kvm-stub.c
@@ -107,3 +107,13 @@ void kvm_s390_stop_interrupt(S390CPU *cpu)
 void kvm_s390_restart_interrupt(S390CPU *cpu)
 {
 }
+
+int kvm_s390_get_diag318_info(uint64_t *info)
+{
+    return 0;
+}
+
+int kvm_s390_set_diag318_info(uint64_t info)
+{
+    return 0;
+}
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 15260ae..abc9dc2 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -775,6 +775,28 @@ int kvm_s390_set_clock_ext(uint8_t tod_high, uint64_t tod_low)
     return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
 }
 
+int kvm_s390_get_diag318_info(uint64_t *info)
+{
+    struct kvm_device_attr attr = {
+        .group = KVM_S390_VM_MISC,
+        .attr = KVM_S390_VM_MISC_DIAG318,
+        .addr = (uint64_t)info,
+    };
+
+    return kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
+}
+
+int kvm_s390_set_diag318_info(uint64_t info)
+{
+    struct kvm_device_attr attr = {
+        .group = KVM_S390_VM_MISC,
+        .attr = KVM_S390_VM_MISC_DIAG318,
+        .addr = (uint64_t)&info,
+    };
+
+    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
+}
+
 /**
  * kvm_s390_mem_op:
  * @addr:      the logical start address in guest memory
@@ -2347,6 +2369,13 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
         KVM_S390_VM_CRYPTO_ENABLE_APIE)) {
         set_bit(S390_FEAT_AP, model->features);
     }
+
+    /* if KVM supports interception of diag318, then let's provide the bit */
+    if (kvm_vm_check_attr(kvm_state, KVM_S390_VM_MISC,
+        KVM_S390_VM_MISC_DIAG318)) {
+        set_bit(S390_FEAT_DIAG318, model->features);
+    }
+
     /* strip of features that are not part of the maximum model */
     bitmap_and(model->features, model->features, model->def->full_feat,
                S390_FEAT_MAX);
diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
index caf9859..50df93e 100644
--- a/target/s390x/kvm_s390x.h
+++ b/target/s390x/kvm_s390x.h
@@ -29,6 +29,8 @@ int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_clock);
 int kvm_s390_get_clock_ext(uint8_t *tod_high, uint64_t *tod_clock);
 int kvm_s390_set_clock(uint8_t tod_high, uint64_t tod_clock);
 int kvm_s390_set_clock_ext(uint8_t tod_high, uint64_t tod_clock);
+int kvm_s390_get_diag318_info(uint64_t *info);
+int kvm_s390_set_diag318_info(uint64_t info);
 void kvm_s390_enable_css_support(S390CPU *cpu);
 int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
                                     int vq, bool assign);
-- 
2.7.4


