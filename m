Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD028C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:34:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF9C220773
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9C220773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEZmQ-0006YD-MZ
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 10:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jEZj4-0002cg-3l
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jEZj0-0001K6-TG
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:31:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24506
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jEZj0-0001JM-Lq
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:31:14 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02IEEAUM032669
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 10:31:14 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yu7d9n0f1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 10:31:14 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 18 Mar 2020 14:31:12 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 18 Mar 2020 14:31:09 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02IEV89Y58982634
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Mar 2020 14:31:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA12842047;
 Wed, 18 Mar 2020 14:31:08 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B0614204D;
 Wed, 18 Mar 2020 14:31:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.78.199])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 18 Mar 2020 14:31:07 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 02/16] Sync pv
Date: Wed, 18 Mar 2020 10:30:33 -0400
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200318143047.2335-1-frankja@linux.ibm.com>
References: <20200318143047.2335-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031814-0016-0000-0000-000002F33EA5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031814-0017-0000-0000-00003356C40D
Message-Id: <20200318143047.2335-3-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-18_05:2020-03-18,
 2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=1 clxscore=1015 priorityscore=1501 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003180066
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 linux-headers/linux/kvm.h | 45 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 265099100e65b3e8..c30344ab0095e856 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -474,12 +474,17 @@ struct kvm_s390_mem_op {
 	__u32 size;		/* amount of bytes */
 	__u32 op;		/* type of operation */
 	__u64 buf;		/* buffer in userspace */
-	__u8 ar;		/* the access register number */
-	__u8 reserved[31];	/* should be set to 0 */
+	union {
+		__u8 ar;	/* the access register number */
+		__u32 sida_offset; /* offset into the sida */
+		__u8 reserved[32]; /* should be set to 0 */
+	};
 };
 /* types for kvm_s390_mem_op->op */
 #define KVM_S390_MEMOP_LOGICAL_READ	0
 #define KVM_S390_MEMOP_LOGICAL_WRITE	1
+#define KVM_S390_MEMOP_SIDA_READ	2
+#define KVM_S390_MEMOP_SIDA_WRITE	3
 /* flags for kvm_s390_mem_op->flags */
 #define KVM_S390_MEMOP_F_CHECK_ONLY		(1ULL << 0)
 #define KVM_S390_MEMOP_F_INJECT_EXCEPTION	(1ULL << 1)
@@ -1010,6 +1015,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_NISV_TO_USER 177
 #define KVM_CAP_ARM_INJECT_EXT_DABT 178
 #define KVM_CAP_S390_VCPU_RESETS 179
+#define KVM_CAP_S390_PROTECTED 180
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1478,6 +1484,41 @@ struct kvm_enc_region {
 #define KVM_S390_NORMAL_RESET	_IO(KVMIO,   0xc3)
 #define KVM_S390_CLEAR_RESET	_IO(KVMIO,   0xc4)
 
+struct kvm_s390_pv_sec_parm {
+	__u64 origin;
+	__u64 length;
+};
+
+struct kvm_s390_pv_unp {
+	__u64 addr;
+	__u64 size;
+	__u64 tweak;
+};
+
+enum pv_cmd_id {
+	KVM_PV_ENABLE,
+	KVM_PV_DISABLE,
+	KVM_PV_VM_SET_SEC_PARMS,
+	KVM_PV_VM_UNPACK,
+	KVM_PV_VM_VERIFY,
+	KVM_PV_VM_PREP_RESET,
+	KVM_PV_VM_UNSHARE_ALL,
+	KVM_PV_VCPU_CREATE,
+	KVM_PV_VCPU_DESTROY,
+};
+
+struct kvm_pv_cmd {
+	__u32 cmd;	/* Command to be executed */
+	__u16 rc;	/* Ultravisor return code */
+	__u16 rrc;	/* Ultravisor return reason code */
+	__u64 data;	/* Data or address */
+	__u32 flags;    /* flags for future extensions. Must be 0 for now */
+	__u32 reserved[3];
+};
+
+/* Available with KVM_CAP_S390_PROTECTED */
+#define KVM_S390_PV_COMMAND		_IOWR(KVMIO, 0xc5, struct kvm_pv_cmd)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
-- 
2.25.1


