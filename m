Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B851C73C6D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 06:07:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D432A20665
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 06:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D432A20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl5lS-0004Mb-4I
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 02:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35628)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bharata@linux.ibm.com>) id 1hl5ka-0003qZ-Br
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 02:06:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bharata@linux.ibm.com>) id 1hl5kY-0002xn-UJ
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 02:06:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13470)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bharata@linux.ibm.com>)
 id 1hl5kY-0002tw-Jp
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 02:06:42 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6A62dhd013198
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 02:06:34 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tn7exnsge-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 02:06:34 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bharata@linux.ibm.com>;
 Wed, 10 Jul 2019 07:06:31 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 10 Jul 2019 07:06:28 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6A66RmH49741970
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jul 2019 06:06:28 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D135A52057;
 Wed, 10 Jul 2019 06:06:27 +0000 (GMT)
Received: from bharata.in.ibm.com (unknown [9.124.35.218])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D570E52052;
 Wed, 10 Jul 2019 06:06:26 +0000 (GMT)
From: Bharata B Rao <bharata@linux.ibm.com>
To: qemu-devel@nongnu.org
Date: Wed, 10 Jul 2019 11:36:21 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19071006-0008-0000-0000-000002FB7D51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071006-0009-0000-0000-00002268DFF9
Message-Id: <20190710060621.16430-1-bharata@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-10_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907100074
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH v0] ppc/spapr: Support reboot of secure pseries
 guest
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
Cc: linuxram@us.ibm.com, Bharata B Rao <bharata@linux.ibm.com>,
 qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A pseries guest can be run as a secure guest on Ultravisor-enabled
POWER platforms. When such a secure guest is reset, we need to
release/reset a few resources both on ultravisor and hypervisor side.
This is achieved by invoking this new ioctl KVM_PPC_SVM_OFF from the
machine reset path.

As part of this ioctl, the secure guest is essentially transitioned
back to normal mode so that it can reboot like a regular guest and
become secure again.

This ioctl has no effect when invoked for a normal guest.

Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
---
* The ioctl implementation in the kernel can be found as part of this patchset:
  https://www.spinics.net/lists/linux-mm/msg184366.html
* Updated linux-headers/linux/kvm.h here for completeness as the
  definition of KVM_PPC_SVM_OFF isn't yet part of upstream kernel.

 hw/ppc/spapr.c            | 1 +
 linux-headers/linux/kvm.h | 1 +
 target/ppc/kvm.c          | 7 +++++++
 target/ppc/kvm_ppc.h      | 6 ++++++
 4 files changed, 15 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 821f0d4a49..6abf71f159 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1709,6 +1709,7 @@ static void spapr_machine_reset(MachineState *machine)
     void *fdt;
     int rc;
 
+    kvmppc_svm_off();
     spapr_caps_apply(spapr);
 
     first_ppc_cpu = POWERPC_CPU(first_cpu);
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index c8423e760c..9603fef9bf 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -1327,6 +1327,7 @@ struct kvm_s390_ucas_mapping {
 #define KVM_PPC_GET_RMMU_INFO	  _IOW(KVMIO,  0xb0, struct kvm_ppc_rmmu_info)
 /* Available with KVM_CAP_PPC_GET_CPU_CHAR */
 #define KVM_PPC_GET_CPU_CHAR	  _IOR(KVMIO,  0xb1, struct kvm_ppc_cpu_char)
+#define KVM_PPC_SVM_OFF           _IO(KVMIO, 0xb2)
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 8a06d3171e..079d83ce6c 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2953,3 +2953,10 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset)
         kvm_set_one_reg(cs, KVM_REG_PPC_TB_OFFSET, &tb_offset);
     }
 }
+
+int kvmppc_svm_off(void)
+{
+    KVMState *s = KVM_STATE(current_machine->accelerator);
+
+    return kvm_vm_ioctl(s, KVM_PPC_SVM_OFF);
+}
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 98bd7d5da6..0fd80e1100 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -37,6 +37,7 @@ int kvmppc_booke_watchdog_enable(PowerPCCPU *cpu);
 target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
                                      bool radix, bool gtse,
                                      uint64_t proc_tbl);
+int kvmppc_svm_off(void);
 #ifndef CONFIG_USER_ONLY
 bool kvmppc_spapr_use_multitce(void);
 int kvmppc_spapr_enable_inkernel_multitce(void);
@@ -201,6 +202,11 @@ static inline target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
     return 0;
 }
 
+static inline int kvmppc_svm_off(void)
+{
+	return 0;
+}
+
 static inline void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu,
                                              unsigned int online)
 {
-- 
2.21.0


