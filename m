Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAF8C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 03:53:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DE5220792
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 03:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE5220792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy5ol-00089X-AK
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 23:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1jy5nc-0006Pl-Uj; Tue, 21 Jul 2020 23:52:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56332)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1jy5na-0003tc-GT; Tue, 21 Jul 2020 23:52:08 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06M3XhV1153682; Tue, 21 Jul 2020 23:51:39 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32e1vrbppe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2020 23:51:39 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06M3kh8A183032;
 Tue, 21 Jul 2020 23:51:39 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32e1vrbpnv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2020 23:51:39 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06M3oG6F010307;
 Wed, 22 Jul 2020 03:51:38 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma04dal.us.ibm.com with ESMTP id 32d5dq6ncv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jul 2020 03:51:38 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06M3pbRi57868566
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Jul 2020 03:51:37 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D883AE05F;
 Wed, 22 Jul 2020 03:51:37 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3891EAE05C;
 Wed, 22 Jul 2020 03:51:31 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.163.58.88])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 22 Jul 2020 03:51:30 +0000 (GMT)
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v2 3/9] ppc/spapr: Use start-powered-off CPUState property
Date: Wed, 22 Jul 2020 00:50:10 -0300
Message-Id: <20200722035016.469075-4-bauerman@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200722035016.469075-1-bauerman@linux.ibm.com>
References: <20200722035016.469075-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-22_01:2020-07-21,
 2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=1
 mlxlogscore=999 malwarescore=0 priorityscore=1501 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007220020
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=bauerman@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:52:01
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
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PowerPC sPAPR CPUs start in the halted state, and spapr_reset_vcpu()
attempts to implement this by setting CPUState::halted to 1. But that's too
late for the case of hotplugged CPUs in a machine configure with 2 or more
threads per core.

By then, other parts of QEMU have already caused the vCPU to run in an
unitialized state a couple of times. For example, ppc_cpu_reset() calls
ppc_tlb_invalidate_all(), which ends up calling async_run_on_cpu(). This
kicks the new vCPU while it has CPUState::halted = 0, causing QEMU to issue
a KVM_RUN ioctl on the new vCPU before the guest is able to make the
start-cpu RTAS call to initialize its register state.

This problem doesn't seem to cause visible issues for regular guests, but
on a secure guest running under the Ultravisor it does. The Ultravisor
relies on being able to snoop on the start-cpu RTAS call to map vCPUs to
guests, and this issue causes it to see a stray vCPU that doesn't belong to
any guest.

Fix by setting the start-powered-off CPUState property in
spapr_create_vcpu(), which makes cpu_common_reset() initialize
CPUState::halted to 1 at an earlier moment.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 hw/ppc/spapr_cpu_core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

NB: Tested on ppc64le pseries KVM guest with two threads per core. 
Hot-plugging additional cores doesn't cause the bug described above
anymore.

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index c4f47dcc04..09feeb5f8f 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -36,11 +36,6 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
 
     cpu_reset(cs);
 
-    /* All CPUs start halted.  CPU0 is unhalted from the machine level
-     * reset code and the rest are explicitly started up by the guest
-     * using an RTAS call */
-    cs->halted = 1;
-
     env->spr[SPR_HIOR] = 0;
 
     lpcr = env->spr[SPR_LPCR];
@@ -288,6 +283,13 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **errp)
 
     cpu->machine_data = g_new0(SpaprCpuState, 1);
 
+    /*
+     * All CPUs start halted. CPU0 is unhalted from the machine level reset code
+     * and the rest are explicitly started up by the guest using an RTAS call.
+     */
+    object_property_set_bool(OBJECT(cs), "start-powered-off", true,
+                             &error_abort);
+
     object_unref(obj);
     return cpu;
 

