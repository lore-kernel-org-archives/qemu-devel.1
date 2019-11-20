Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6890C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C992223D0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C992223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXOZ7-0005Sg-AE
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 06:54:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iXOOv-00038u-MD
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:44:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iXOOu-0003Ds-8m
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:44:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23126)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iXOOt-00039F-Us
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:44:00 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAKBfvGC089583
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 06:43:58 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wbxndrtn0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 06:43:58 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 20 Nov 2019 11:43:56 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 20 Nov 2019 11:43:53 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAKBhqwT36176082
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Nov 2019 11:43:52 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E9244C040;
 Wed, 20 Nov 2019 11:43:52 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15EC34C044;
 Wed, 20 Nov 2019 11:43:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.152.224.205])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 20 Nov 2019 11:43:50 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/15] Header sync protvirt
Date: Wed, 20 Nov 2019 06:43:23 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191120114334.2287-1-frankja@linux.ibm.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112011-0008-0000-0000-00000335273E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112011-0009-0000-0000-00004A544B71
Message-Id: <20191120114334.2287-5-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_03:2019-11-15,2019-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 suspectscore=1 phishscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911200107
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's sync all the protvirt header changes

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 linux-headers/asm-s390/kvm.h |  3 ++-
 linux-headers/linux/kvm.h    | 42 ++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index 03ab5968c7..41976d33f0 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -255,7 +255,8 @@ struct kvm_sync_regs {
 	__u8  reserved[512];	/* for future vector expansion */
 	__u32 fpc;		/* valid on KVM_SYNC_VRS or KVM_SYNC_FPRS */
 	__u8 bpbc : 1;		/* bp mode */
-	__u8 reserved2 : 7;
+	__u8 pv : 1;		/* pv mode */
+	__u8 reserved2 : 6;
 	__u8 padding1[51];	/* riccb needs to be 64byte aligned */
 	__u8 riccb[64];		/* runtime instrumentation controls block */
 	__u8 padding2[192];	/* sdnx needs to be 256byte aligned */
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 18892d6541..d031051601 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -995,6 +995,8 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_SVE 170
 #define KVM_CAP_ARM_PTRAUTH_ADDRESS 171
 #define KVM_CAP_ARM_PTRAUTH_GENERIC 172
+#define KVM_CAP_S390_PROTECTED 180
+#define KVM_CAP_S390_VCPU_RESETS 181
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1453,6 +1455,46 @@ struct kvm_enc_region {
 /* Available with KVM_CAP_ARM_SVE */
 #define KVM_ARM_VCPU_FINALIZE	  _IOW(KVMIO,  0xc2, int)
 
+struct kvm_s390_pv_sec_parm {
+	__u64	origin;
+	__u64	length;
+};
+
+struct kvm_s390_pv_unp {
+	__u64 addr;
+	__u64 size;
+	__u64 tweak;
+};
+
+enum pv_cmd_id {
+	KVM_PV_VM_CREATE,
+	KVM_PV_VM_DESTROY,
+	KVM_PV_VM_SET_SEC_PARMS,
+	KVM_PV_VM_UNPACK,
+	KVM_PV_VM_VERIFY,
+	KVM_PV_VM_PERF_CLEAR_RESET,
+	KVM_PV_VM_UNSHARE,
+	KVM_PV_VCPU_CREATE,
+	KVM_PV_VCPU_DESTROY,
+};
+
+struct kvm_pv_cmd {
+	__u32	cmd;
+	__u16	rc;
+	__u16	rrc;
+	__u64	data;
+};
+
+/* Available with KVM_CAP_S390_PROTECTED */
+#define KVM_S390_PV_COMMAND		_IOW(KVMIO, 0xc3, struct kvm_pv_cmd)
+#define KVM_S390_PV_COMMAND_VCPU	_IOW(KVMIO, 0xc4, struct kvm_pv_cmd)
+
+#define KVM_S390_VCPU_RESET_NORMAL	0
+#define KVM_S390_VCPU_RESET_INITIAL	1
+#define KVM_S390_VCPU_RESET_CLEAR	2
+
+#define KVM_S390_VCPU_RESET    _IO(KVMIO,   0xc5)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
-- 
2.20.1


