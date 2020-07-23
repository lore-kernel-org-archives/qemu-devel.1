Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CEAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 02:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85CA2206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 02:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CA2206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyRS3-0005rG-Ni
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 22:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1jyRQk-0003lH-8v; Wed, 22 Jul 2020 22:57:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64892)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1jyRQi-0002v3-7t; Wed, 22 Jul 2020 22:57:58 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06N2coPJ089293; Wed, 22 Jul 2020 22:57:31 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32f1pmrhkf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jul 2020 22:57:31 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06N2hRrc099473;
 Wed, 22 Jul 2020 22:57:31 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32f1pmrhk6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jul 2020 22:57:30 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06N2naCc029267;
 Thu, 23 Jul 2020 02:57:30 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma01wdc.us.ibm.com with ESMTP id 32brq9915x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jul 2020 02:57:30 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06N2vTBR31785268
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Jul 2020 02:57:29 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9815AC05B;
 Thu, 23 Jul 2020 02:57:29 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C5A5AC05E;
 Thu, 23 Jul 2020 02:57:22 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.211.93.190])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 23 Jul 2020 02:57:22 +0000 (GMT)
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v3 1/8] target/arm: Move start-powered-off property to generic
 CPUState
Date: Wed, 22 Jul 2020 23:56:50 -0300
Message-Id: <20200723025657.644724-2-bauerman@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200723025657.644724-1-bauerman@linux.ibm.com>
References: <20200723025657.644724-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-22_17:2020-07-22,
 2020-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 suspectscore=1 mlxlogscore=999 phishscore=0 spamscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007230014
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=bauerman@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 22:57:54
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are other platforms which also have CPUs that start powered off, so
generalize the start-powered-off property so that it can be used by them.

Note that ARMv7MState also has a property of the same name but this patch
doesn't change it because that class isn't a subclass of CPUState so it
wouldn't be a trivial change.

This change should not cause any change in behavior.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 exec.c                | 1 +
 include/hw/core/cpu.h | 4 ++++
 target/arm/cpu.c      | 5 ++---
 target/arm/cpu.h      | 3 ---
 target/arm/kvm32.c    | 2 +-
 target/arm/kvm64.c    | 2 +-
 6 files changed, 9 insertions(+), 8 deletions(-)

NB: I was only able to test that this patch builds. I wasn't able to
run it.

diff --git a/exec.c b/exec.c
index 6f381f98e2..82e82fab09 100644
--- a/exec.c
+++ b/exec.c
@@ -899,6 +899,7 @@ Property cpu_common_props[] = {
     DEFINE_PROP_LINK("memory", CPUState, memory, TYPE_MEMORY_REGION,
                      MemoryRegion *),
 #endif
+    DEFINE_PROP_BOOL("start-powered-off", CPUState, start_powered_off, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 8f145733ce..9fc2696db5 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -374,6 +374,10 @@ struct CPUState {
     bool created;
     bool stop;
     bool stopped;
+
+    /* Should CPU start in powered-off state? */
+    bool start_powered_off;
+
     bool unplug;
     bool crash_occurred;
     bool exit_request;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 111579554f..ec65c7653f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -174,8 +174,8 @@ static void arm_cpu_reset(DeviceState *dev)
     env->vfp.xregs[ARM_VFP_MVFR1] = cpu->isar.mvfr1;
     env->vfp.xregs[ARM_VFP_MVFR2] = cpu->isar.mvfr2;
 
-    cpu->power_state = cpu->start_powered_off ? PSCI_OFF : PSCI_ON;
-    s->halted = cpu->start_powered_off;
+    cpu->power_state = s->start_powered_off ? PSCI_OFF : PSCI_ON;
+    s->halted = s->start_powered_off;
 
     if (arm_feature(env, ARM_FEATURE_IWMMXT)) {
         env->iwmmxt.cregs[ARM_IWMMXT_wCID] = 0x69051000 | 'Q';
@@ -2182,7 +2182,6 @@ static const ARMCPUInfo arm_cpus[] = {
 };
 
 static Property arm_cpu_properties[] = {
-    DEFINE_PROP_BOOL("start-powered-off", ARMCPU, start_powered_off, false),
     DEFINE_PROP_UINT32("psci-conduit", ARMCPU, psci_conduit, 0),
     DEFINE_PROP_UINT64("midr", ARMCPU, midr, 0),
     DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9e8ed423ea..a925d26996 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -810,9 +810,6 @@ struct ARMCPU {
      */
     uint32_t psci_version;
 
-    /* Should CPU start in PSCI powered-off state? */
-    bool start_powered_off;
-
     /* Current power state, access guarded by BQL */
     ARMPSCIState power_state;
 
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 0af46b41c8..1f2b8f8b7a 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -218,7 +218,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
     /* Determine init features for this CPU */
     memset(cpu->kvm_init_features, 0, sizeof(cpu->kvm_init_features));
-    if (cpu->start_powered_off) {
+    if (cs->start_powered_off) {
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_POWER_OFF;
     }
     if (kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PSCI_0_2)) {
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 1169237905..f8a6d905fb 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -775,7 +775,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
     /* Determine init features for this CPU */
     memset(cpu->kvm_init_features, 0, sizeof(cpu->kvm_init_features));
-    if (cpu->start_powered_off) {
+    if (cs->start_powered_off) {
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_POWER_OFF;
     }
     if (kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PSCI_0_2)) {

