Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF806C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FDF02166E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FDF02166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfr9-0003FG-R8
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51179)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sbhat@linux.ibm.com>) id 1hqfqw-0002kU-Dy
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sbhat@linux.ibm.com>) id 1hqfqv-0004zy-Fs
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:40:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49166)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1hqfqv-0004zG-5n
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:40:21 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6PFdJC0124752
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 11:40:19 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tydjgw05q-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 11:40:19 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
 Thu, 25 Jul 2019 16:40:16 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 25 Jul 2019 16:40:13 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6PFeCUV37683398
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jul 2019 15:40:13 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9A5B11C05B;
 Thu, 25 Jul 2019 15:40:12 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3563911C05C;
 Thu, 25 Jul 2019 15:40:12 +0000 (GMT)
Received: from lep8c.aus.stglabs.ibm.com (unknown [9.40.192.207])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 25 Jul 2019 15:40:12 +0000 (GMT)
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Date: Thu, 25 Jul 2019 10:40:11 -0500
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19072515-0020-0000-0000-000003572C5F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072515-0021-0000-0000-000021AB219A
Message-Id: <156406920211.26945.15588948639720429804.stgit@lep8c.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-25_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=980 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907250183
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH] ppc: remove redundant capability check for
 unset irq
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
Cc: groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The KVM_CAP_PPC_UNSET_IRQ is part of kernel since v2.6.36.
Kernels older than that are not supported anymore.
So, remove the checks.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 target/ppc/kvm.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 5ab5e6c6a9..94a2ecb84f 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -55,7 +55,6 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
 };
 
-static int cap_interrupt_unset;
 static int cap_segstate;
 static int cap_booke_sregs;
 static int cap_ppc_smt;
@@ -104,7 +103,6 @@ static int kvmppc_get_dec_bits(void);
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
-    cap_interrupt_unset = kvm_check_extension(s, KVM_CAP_PPC_UNSET_IRQ);
     cap_segstate = kvm_check_extension(s, KVM_CAP_PPC_SEGSTATE);
     cap_booke_sregs = kvm_check_extension(s, KVM_CAP_PPC_BOOKE_SREGS);
     cap_ppc_smt_possible = kvm_vm_check_extension(s, KVM_CAP_PPC_SMT_POSSIBLE);
@@ -1309,7 +1307,7 @@ int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, int level)
         return 0;
     }
 
-    if (!kvm_enabled() || !cap_interrupt_unset) {
+    if (!kvm_enabled()) {
         return 0;
     }
 


