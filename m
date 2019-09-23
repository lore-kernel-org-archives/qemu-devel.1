Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92A1C3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 07:46:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A61C42064A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 07:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61C42064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCJ3N-0003Pd-Rp
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 03:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1iCIwX-0006eL-Kb
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 03:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1iCIwW-00050m-0M
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 03:39:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63712
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1iCIwV-0004zh-O9
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 03:39:31 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8N7bD7W116514
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 03:39:31 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2v6srmg81f-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 03:39:31 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Mon, 23 Sep 2019 08:39:28 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 23 Sep 2019 08:39:25 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8N7dN0U42533118
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Sep 2019 07:39:23 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 71AE352054;
 Mon, 23 Sep 2019 07:39:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 5C56052050;
 Mon, 23 Sep 2019 07:39:23 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
 id 1D24BE02AA; Mon, 23 Sep 2019 09:39:23 +0200 (CEST)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 4/5] s390x/kvm: Officially require at least kernel 3.15
Date: Mon, 23 Sep 2019 09:39:20 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190923073921.13357-1-borntraeger@de.ibm.com>
References: <20190923073921.13357-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19092307-0016-0000-0000-000002AF775B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092307-0017-0000-0000-00003310325D
Message-Id: <20190923073921.13357-5-borntraeger@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-23_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909230076
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
Cc: Yifan Luo <luoyifan@cmss.chinamobile.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Since QEMU v2.10, the KVM acceleration does not work on older kernels
anymore since the code accidentally requires the KVM_CAP_DEVICE_CTRL
capability now - it should have been optional instead.
Instead of fixing the bug, we asked in the ChangeLog of QEMU 2.11 - 3.0
that people should speak up if they still need support of QEMU running
with KVM on older kernels, but seems like nobody really complained.
Thus let's make this official now and turn it into a proper error
message, telling the users to use at least kernel 3.15 now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190913091443.27565-1-thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/intc/s390_flic_kvm.c | 6 ------
 hw/intc/trace-events    | 1 -
 target/s390x/kvm.c      | 7 +++++++
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index 819aa5e198b7..cedccba8a9c7 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -589,12 +589,6 @@ static void kvm_s390_flic_realize(DeviceState *dev, Error **errp)
         goto fail;
     }
     flic_state->fd = -1;
-    if (!kvm_check_extension(kvm_state, KVM_CAP_DEVICE_CTRL)) {
-        error_setg_errno(&errp_local, errno, "KVM is missing capability"
-                         " KVM_CAP_DEVICE_CTRL");
-        trace_flic_no_device_api(errno);
-        goto fail;
-    }
 
     cd.type = KVM_DEV_TYPE_FLIC;
     ret = kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd);
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 90c9d07c1a66..719f46b51628 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -75,7 +75,6 @@ xics_ics_simple_eoi(int nr) "ics_eoi: irq 0x%x"
 
 # s390_flic_kvm.c
 flic_create_device(int err) "flic: create device failed %d"
-flic_no_device_api(int err) "flic: no Device Contral API support %d"
 flic_reset_failed(int err) "flic: reset failed %d"
 
 # s390_flic.c
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index cea71ac7c3dd..97a662ad0ebf 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -316,6 +316,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
     mc->default_cpu_type = S390_CPU_TYPE_NAME("host");
+
+    if (!kvm_check_extension(kvm_state, KVM_CAP_DEVICE_CTRL)) {
+        error_report("KVM is missing capability KVM_CAP_DEVICE_CTRL - "
+                     "please use kernel 3.15 or newer");
+        return -1;
+    }
+
     cap_sync_regs = kvm_check_extension(s, KVM_CAP_SYNC_REGS);
     cap_async_pf = kvm_check_extension(s, KVM_CAP_ASYNC_PF);
     cap_mem_op = kvm_check_extension(s, KVM_CAP_S390_MEM_OP);
-- 
2.21.0


