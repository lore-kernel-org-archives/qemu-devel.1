Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8114C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 23:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E722173E
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 23:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E722173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXCAX-0001Ke-Pz
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 19:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jXC71-0003Sw-Cz; Fri, 08 May 2020 19:08:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jXC6r-0005tI-6w; Fri, 08 May 2020 19:08:59 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 048N3cXO181546; Fri, 8 May 2020 19:08:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30vtt4b4xv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2020 19:08:47 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 048N3pWE182106;
 Fri, 8 May 2020 19:08:47 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30vtt4b4xn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2020 19:08:47 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 048N0PMH019040;
 Fri, 8 May 2020 23:08:46 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma04dal.us.ibm.com with ESMTP id 30s0g7txx1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2020 23:08:46 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 048N8jUB47841746
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 May 2020 23:08:45 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70E86AC05F;
 Fri,  8 May 2020 23:08:45 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 242C3AC05E;
 Fri,  8 May 2020 23:08:45 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.189.36])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri,  8 May 2020 23:08:45 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v1 8/8] s390: diagnose 318 info reset and migration support
Date: Fri,  8 May 2020 19:08:23 -0400
Message-Id: <20200508230823.22956-9-walling@linux.ibm.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200508230823.22956-1-walling@linux.ibm.com>
References: <20200508230823.22956-1-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-08_20:2020-05-08,
 2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005080193
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 19:08:46
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, mst@redhat.com,
 svens@linux.ibm.com, pbonzini@redhat.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The DIAGNOSE 318 (diag318) instruction allows the guest to store
diagnostic data that is collected by the firmware in the case of
hardware/firmware service events. The instruction is invoked in the
Linux kernel and intercepted in KVM. QEMU needs to collect this data
for migration so that it is consistent on the destination machine.

Availability of this instruction is determined by byte 134, bit 0
of the SCLP Read Info block. This coincidentally expands into the
space used for CPU entries, which means VMs running with the diag318
capability will not be able to read information regarding all CPUs.

This feature depends on the Extended-Length SCCB (els) feature.

Diag318 is set to 0 during modified clear and load normal resets.

This feature is not supported in protected virtualization mode.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c          | 45 +++++++++++++++++++++++++++
 hw/s390x/sclp.c                     |  5 +++
 include/hw/s390x/s390-virtio-ccw.h  |  1 +
 include/hw/s390x/sclp.h             |  3 ++
 target/s390x/cpu.c                  | 19 ++++++++++++
 target/s390x/cpu.h                  |  4 +++
 target/s390x/cpu_features.h         |  1 +
 target/s390x/cpu_features_def.inc.h |  3 ++
 target/s390x/cpu_models.c           |  1 +
 target/s390x/gen-features.c         |  1 +
 target/s390x/kvm-stub.c             | 10 ++++++
 target/s390x/kvm.c                  | 48 +++++++++++++++++++++++++++++
 target/s390x/kvm_s390x.h            |  3 ++
 13 files changed, 144 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 45292fb5a8..dc4eb20ec8 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -242,6 +242,40 @@ static void s390_create_sclpconsole(const char *type, Chardev *chardev)
     qdev_init_nofail(dev);
 }
 
+static int diag318_post_load(void *opaque, int version_id)
+{
+    S390CcwMachineState *d = opaque;
+
+    s390_set_diag318_info(d->diag318_info);
+    return 0;
+}
+
+static int diag318_pre_save(void *opaque)
+{
+    S390CcwMachineState *d = opaque;
+
+    s390_get_diag318_info(&d->diag318_info);
+    return 0;
+}
+
+static bool diag318_needed(void *opaque)
+{
+    return s390_diag318_is_allowed();
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
+        VMSTATE_UINT64(diag318_info, S390CcwMachineState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void ccw_init(MachineState *machine)
 {
     int ret;
@@ -299,6 +333,8 @@ static void ccw_init(MachineState *machine)
 
     /* init the TOD clock */
     s390_init_tod();
+
+    vmstate_register(NULL, 0, &vmstate_diag318, machine);
 }
 
 static void s390_cpu_plug(HotplugHandler *hotplug_dev,
@@ -404,6 +440,13 @@ static void s390_pv_prepare_reset(S390CcwMachineState *ms)
     s390_pv_perf_clear_reset();
 }
 
+static void s390_diag318_reset(void)
+{
+    if (s390_diag318_is_allowed()) {
+        s390_set_diag318_info(0);
+    }
+}
+
 static void s390_machine_reset(MachineState *machine)
 {
     S390CcwMachineState *ms = S390_CCW_MACHINE(machine);
@@ -440,6 +483,7 @@ static void s390_machine_reset(MachineState *machine)
         subsystem_reset();
         s390_crypto_reset();
         s390_pv_prepare_reset(ms);
+        s390_diag318_reset();
         CPU_FOREACH(t) {
             run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
         }
@@ -452,6 +496,7 @@ static void s390_machine_reset(MachineState *machine)
          */
         subsystem_reset();
         s390_pv_prepare_reset(ms);
+        s390_diag318_reset();
         CPU_FOREACH(t) {
             if (t == cs) {
                 continue;
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index b5c89760e7..ae3de14e63 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -143,6 +143,11 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     s390_get_feat_block(S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT,
                          read_info->conf_char_ext);
 
+    if (s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB)) {
+        s390_get_feat_block(S390_FEAT_TYPE_SCLP_BYTE_134,
+                            &read_info->byte_134);
+    }
+
     read_info->facilities = cpu_to_be64(SCLP_HAS_CPU_INFO |
                                         SCLP_HAS_IOA_RECONFIG);
 
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index cd1dccc6e3..1134da4d75 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -30,6 +30,7 @@ typedef struct S390CcwMachineState {
     bool dea_key_wrap;
     bool pv;
     uint8_t loadparm[8];
+    uint64_t diag318_info;
 } S390CcwMachineState;
 
 typedef struct S390CcwMachineClass {
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index ef2d63eae9..b42a6b6f5a 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -133,6 +133,9 @@ typedef struct ReadInfo {
     uint16_t highest_cpu;
     uint8_t  _reserved5[124 - 122];     /* 122-123 */
     uint32_t hmfai;
+    uint8_t  _reserved7[134 - 128];     /* 128-133 */
+    uint8_t  byte_134;
+    uint8_t  _reserved8[144 - 135];     /* 135-143 */
     struct CPUEntry entries[];
 } QEMU_PACKED ReadInfo;
 
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index f2ccf0a06a..47284a4a62 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -446,6 +446,25 @@ void s390_enable_css_support(S390CPU *cpu)
         kvm_s390_enable_css_support(cpu);
     }
 }
+
+void s390_get_diag318_info(uint64_t *info)
+{
+    if (kvm_enabled()) {
+        kvm_s390_get_diag318_info(info);
+    }
+}
+
+void s390_set_diag318_info(uint64_t info)
+{
+    if (kvm_enabled()) {
+        kvm_s390_set_diag318_info(info);
+    }
+}
+
+bool s390_diag318_is_allowed(void)
+{
+    return kvm_enabled() && kvm_s390_diag318_is_allowed();
+}
 #endif
 
 static gchar *s390_gdb_arch_name(CPUState *cs)
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 035427521c..db80c1f89f 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -769,6 +769,10 @@ void s390_cmma_reset(void);
 void s390_enable_css_support(S390CPU *cpu);
 int s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch_id,
                                 int vq, bool assign);
+void s390_get_diag318_info(uint64_t *info);
+void s390_set_diag318_info(uint64_t info);
+bool s390_diag318_is_allowed(void);
+
 #ifndef CONFIG_USER_ONLY
 unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu);
 #else
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index da695a8346..954544eed7 100644
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
index 3548d65a69..01b877d180 100644
--- a/target/s390x/cpu_features_def.inc.h
+++ b/target/s390x/cpu_features_def.inc.h
@@ -122,6 +122,9 @@ DEF_FEAT(SIE_CMMA, "cmma", SCLP_CONF_CHAR_EXT, 1, "SIE: Collaborative-memory-man
 DEF_FEAT(SIE_PFMFI, "pfmfi", SCLP_CONF_CHAR_EXT, 9, "SIE: PFMF interpretation facility")
 DEF_FEAT(SIE_IBS, "ibs", SCLP_CONF_CHAR_EXT, 10, "SIE: Interlock-and-broadcast-suppression facility")
 
+/* Features exposed via SCLP SCCB Byte 134 (bit numbers relative to byte-134) */
+DEF_FEAT(DIAG318, "diag318", SCLP_BYTE_134, 0, "Control program name and version codes")
+
 /* Features exposed via SCLP CPU info. */
 DEF_FEAT(SIE_F2, "sief2", SCLP_CPU, 4, "SIE: interception format 2 (Virtual SIE)")
 DEF_FEAT(SIE_SKEY, "skey", SCLP_CPU, 5, "SIE: Storage-key facility")
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 7c32180269..c445aa08ee 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -827,6 +827,7 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_PTFF_STOE, S390_FEAT_MULTIPLE_EPOCH },
         { S390_FEAT_PTFF_STOUE, S390_FEAT_MULTIPLE_EPOCH },
         { S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, S390_FEAT_AP },
+        { S390_FEAT_DIAG318, S390_FEAT_EXTENDED_LENGTH_SCCB },
     };
     int i;
 
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 6857f657fb..df90f5a7e8 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -523,6 +523,7 @@ static uint16_t full_GEN12_GA1[] = {
     S390_FEAT_AP_FACILITIES_TEST,
     S390_FEAT_AP,
     S390_FEAT_EXTENDED_LENGTH_SCCB,
+    S390_FEAT_DIAG318,
 };
 
 static uint16_t full_GEN12_GA2[] = {
diff --git a/target/s390x/kvm-stub.c b/target/s390x/kvm-stub.c
index aa185017a2..669dcbc80b 100644
--- a/target/s390x/kvm-stub.c
+++ b/target/s390x/kvm-stub.c
@@ -120,3 +120,13 @@ void kvm_s390_stop_interrupt(S390CPU *cpu)
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
index 380fb81822..839564e83c 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -814,6 +814,44 @@ int kvm_s390_set_clock_ext(uint8_t tod_high, uint64_t tod_low)
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
+bool kvm_s390_diag318_is_allowed(void)
+{
+    return s390_has_feat(S390_FEAT_DIAG318) &&
+           s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB);
+}
+
+static int kvm_s390_enable_diag318(void)
+{
+    struct kvm_device_attr attr = {
+        .group = KVM_S390_VM_MISC,
+        .attr = KVM_S390_VM_MISC_ENABLE_DIAG318,
+    };
+
+    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
+}
+
 /**
  * kvm_s390_mem_op:
  * @addr:      the logical start address in guest memory
@@ -2460,6 +2498,12 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
     /* Extended-Length SCCB is handled entirely within QEMU */
     set_bit(S390_FEAT_EXTENDED_LENGTH_SCCB, model->features);
 
+    /* Allow diag318 iff KVM supported and not in PV mode */
+    if (!s390_is_pv() && kvm_vm_check_attr(kvm_state,
+        KVM_S390_VM_MISC, KVM_S390_VM_MISC_DIAG318)) {
+        set_bit(S390_FEAT_DIAG318, model->features);
+    }
+
     /* strip of features that are not part of the maximum model */
     bitmap_and(model->features, model->features, model->def->full_feat,
                S390_FEAT_MAX);
@@ -2528,6 +2572,10 @@ void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
     if (test_bit(S390_FEAT_AP, model->features)) {
         kvm_s390_configure_apie(true);
     }
+
+    if (kvm_s390_diag318_is_allowed()) {
+        kvm_s390_enable_diag318();
+    }
 }
 
 void kvm_s390_restart_interrupt(S390CPU *cpu)
diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
index 6ab17c81b7..d7666fbd55 100644
--- a/target/s390x/kvm_s390x.h
+++ b/target/s390x/kvm_s390x.h
@@ -32,6 +32,9 @@ int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_clock);
 int kvm_s390_get_clock_ext(uint8_t *tod_high, uint64_t *tod_clock);
 int kvm_s390_set_clock(uint8_t tod_high, uint64_t tod_clock);
 int kvm_s390_set_clock_ext(uint8_t tod_high, uint64_t tod_clock);
+int kvm_s390_get_diag318_info(uint64_t *info);
+int kvm_s390_set_diag318_info(uint64_t info);
+bool kvm_s390_diag318_is_allowed(void);
 void kvm_s390_enable_css_support(S390CPU *cpu);
 int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
                                     int vq, bool assign);
-- 
2.21.1


