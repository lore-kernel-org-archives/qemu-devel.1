Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C28DC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 23:11:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3FD12173E
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 23:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FD12173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXC9g-0008JS-4C
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 19:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jXC70-0003RK-5N; Fri, 08 May 2020 19:08:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16838
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jXC6q-0005p8-JW; Fri, 08 May 2020 19:08:57 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 048N2j82015569; Fri, 8 May 2020 19:08:46 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 30vtwd3486-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2020 19:08:46 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 048N4HJg020734;
 Fri, 8 May 2020 19:08:46 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0b-001b2d01.pphosted.com with ESMTP id 30vtwd3480-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2020 19:08:46 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 048N65js026464;
 Fri, 8 May 2020 23:08:45 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma02dal.us.ibm.com with ESMTP id 30s0g7jxmk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2020 23:08:45 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 048N8itL9634080
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 May 2020 23:08:44 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE049AC05E;
 Fri,  8 May 2020 23:08:44 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89BA4AC060;
 Fri,  8 May 2020 23:08:44 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.189.36])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri,  8 May 2020 23:08:44 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v1 6/8] s390/sclp: add extended-length sccb support for kvm
 guest
Date: Fri,  8 May 2020 19:08:21 -0400
Message-Id: <20200508230823.22956-7-walling@linux.ibm.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200508230823.22956-1-walling@linux.ibm.com>
References: <20200508230823.22956-1-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-08_19:2020-05-08,
 2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2005080190
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 19:08:45
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

As more features and facilities are added to the Read SCP Info (RSCPI)
response, more space is required to store them. The space used to store
these new features intrudes on the space originally used to store CPU
entries. This means as more features and facilities are added to the
RSCPI response, less space can be used to store CPU entries.

With the Extended-Length SCCB (ELS) facility, a KVM guest can execute
the RSCPI command and determine if the SCCB is large enough to store a
complete reponse. If it is not large enough, then the required length
will be set in the SCCB header.

The caller of the SCLP command is responsible for creating a
large-enough SCCB to store a complete response. Proper checking should
be in place, and the caller should execute the command once-more with
the large-enough SCCB.

This facility also enables an extended SCCB for the Read CPU Info
(RCPUI) command.

When this facility is enabled, the boundary violation response cannot
be a result from the RSCPI, RSCPI Forced, or RCPUI commands.

In order to tolerate kernels that do not yet have full support for this
feature, a "fixed" offset to the start of the CPU Entries within the
Read SCP Info struct is set to allow for the original 248 max entries.

Additionally, this is introduced as a CPU feature to protect the guest
from migrating to a machine that does not support storing an extended
SCCB. This could otherwise hinder the VM from being able to read all
available CPU entries after migration.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 hw/s390x/sclp.c                     | 23 +++++++++++++++++++++--
 include/hw/s390x/sclp.h             |  1 +
 target/s390x/cpu_features_def.inc.h |  1 +
 target/s390x/gen-features.c         |  1 +
 target/s390x/kvm.c                  |  4 ++++
 5 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index c47bd3b5ab..b5c89760e7 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -56,6 +56,18 @@ static bool check_sccb_boundary_valid(uint64_t sccb_addr, uint32_t code,
     uint64_t allowed_len = (sccb_addr & PAGE_MASK) + PAGE_SIZE;
 
     switch (code & SCLP_CMD_CODE_MASK) {
+    case SCLP_CMDW_READ_SCP_INFO:
+    case SCLP_CMDW_READ_SCP_INFO_FORCED:
+    case SCLP_CMDW_READ_CPU_INFO:
+        /*
+         * An extended-length SCCB is only allowed for RSCPI and RSCPU and is
+         * allowed to exceed the 4k boundary. The respective commands will
+         * set the length field to the required length if an insufficient
+         * SCCB length is provided.
+         */
+        if (s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB)) {
+            return true;
+        }
     default:
         if (current_len <= allowed_len) {
             return true;
@@ -72,6 +84,10 @@ static bool check_sufficient_sccb_len(SCCB *sccb, int size)
 
     if (be16_to_cpu(sccb->h.length) < required_len) {
         sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
+        if (s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB) &&
+            sccb->h.control_mask[2] & SCLP_VARIABLE_LENGTH_RESPONSE) {
+            sccb->h.length = required_len;
+        }
         return false;
     }
     return true;
@@ -103,10 +119,13 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     int cpu_count;
     int rnsize, rnmax;
     IplParameterBlock *ipib = s390_ipl_get_iplb();
-    int offset_cpu = offsetof(ReadInfo, entries);
+    int offset_cpu = s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB) ?
+                     offsetof(ReadInfo, entries) :
+                     SCLP_READ_SCP_INFO_FIXED_CPU_OFFSET;
     CPUEntry *entries_start = (void *)sccb + offset_cpu;
 
-    if (!check_sufficient_sccb_len(sccb, sizeof(ReadInfo))) {
+    if (!check_sufficient_sccb_len(sccb, offset_cpu)) {
+        warn_report("insufficient sccb size to store full read scp info response");
         return;
     }
 
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index 822eff4396..ef2d63eae9 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -110,6 +110,7 @@ typedef struct CPUEntry {
     uint8_t reserved1;
 } QEMU_PACKED CPUEntry;
 
+#define SCLP_READ_SCP_INFO_FIXED_CPU_OFFSET     128
 typedef struct ReadInfo {
     SCCBHeader h;
     uint16_t rnmax;
diff --git a/target/s390x/cpu_features_def.inc.h b/target/s390x/cpu_features_def.inc.h
index 60db28351d..3548d65a69 100644
--- a/target/s390x/cpu_features_def.inc.h
+++ b/target/s390x/cpu_features_def.inc.h
@@ -97,6 +97,7 @@ DEF_FEAT(GUARDED_STORAGE, "gs", STFL, 133, "Guarded-storage facility")
 DEF_FEAT(VECTOR_PACKED_DECIMAL, "vxpd", STFL, 134, "Vector packed decimal facility")
 DEF_FEAT(VECTOR_ENH, "vxeh", STFL, 135, "Vector enhancements facility")
 DEF_FEAT(MULTIPLE_EPOCH, "mepoch", STFL, 139, "Multiple-epoch facility")
+DEF_FEAT(EXTENDED_LENGTH_SCCB, "els", STFL, 140, "Extended-length SCCB facility")
 DEF_FEAT(TEST_PENDING_EXT_INTERRUPTION, "tpei", STFL, 144, "Test-pending-external-interruption facility")
 DEF_FEAT(INSERT_REFERENCE_BITS_MULT, "irbm", STFL, 145, "Insert-reference-bits-multiple facility")
 DEF_FEAT(MSA_EXT_8, "msa8-base", STFL, 146, "Message-security-assist-extension-8 facility (excluding subfunctions)")
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 8ddeebc544..6857f657fb 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -522,6 +522,7 @@ static uint16_t full_GEN12_GA1[] = {
     S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL,
     S390_FEAT_AP_FACILITIES_TEST,
     S390_FEAT_AP,
+    S390_FEAT_EXTENDED_LENGTH_SCCB,
 };
 
 static uint16_t full_GEN12_GA2[] = {
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 69881a0da0..380fb81822 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2456,6 +2456,10 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
         KVM_S390_VM_CRYPTO_ENABLE_APIE)) {
         set_bit(S390_FEAT_AP, model->features);
     }
+
+    /* Extended-Length SCCB is handled entirely within QEMU */
+    set_bit(S390_FEAT_EXTENDED_LENGTH_SCCB, model->features);
+
     /* strip of features that are not part of the maximum model */
     bitmap_and(model->features, model->features, model->def->full_feat,
                S390_FEAT_MAX);
-- 
2.21.1


