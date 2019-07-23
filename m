Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FF5C76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:02:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C822239F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C822239F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpyAs-0005Z5-CC
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 13:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42301)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hpyAD-00041H-9G
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:01:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hpyAC-00054m-33
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:01:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52914
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hpyAB-000540-UK
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:01:20 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6NGkgNh133352
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 13:01:17 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tx60rrnek-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 13:01:17 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
 Tue, 23 Jul 2019 18:01:16 +0100
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
 by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 23 Jul 2019 18:01:15 +0100
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6NH1ElR62390588
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2019 17:01:14 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65992BE051;
 Tue, 23 Jul 2019 17:01:14 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 564C9BE058;
 Tue, 23 Jul 2019 17:01:14 +0000 (GMT)
Received: from localhost (unknown [9.53.179.212])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jul 2019 17:01:14 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Jul 2019 12:00:37 -0500
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
References: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19072317-0036-0000-0000-00000ADD79EA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011482; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01236375; UDB=6.00651638; IPR=6.01017731; 
 MB=3.00027856; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-23 17:01:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072317-0037-0000-0000-00004CB756D0
Message-Id: <20190723170104.4327-10-mdroth@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-23_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907230169
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH 09/36] exec.c: Don't reallocate IOMMUNotifiers
 that are in use
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

The tcg_register_iommu_notifier() code has a GArray of
TCGIOMMUNotifier structs which it has registered by passing
memory_region_register_iommu_notifier() a pointer to the embedded
IOMMUNotifier field. Unfortunately, if we need to enlarge the
array via g_array_set_size() this can cause a realloc(), which
invalidates the pointer that memory_region_register_iommu_notifier()
put into the MemoryRegion's iommu_notify list. This can result
in segfaults.

Switch the GArray to holding pointers to the TCGIOMMUNotifier
structs, so that we can individually allocate and free them.

Cc: qemu-stable@nongnu.org
Fixes: 1f871c5e6b0f30644a60a ("exec.c: Handle IOMMUs in address_space_translate_for_iotlb()")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190128174241.5860-1-peter.maydell@linaro.org
(cherry picked from commit 5601be3b01d73e21c09331599e2ce62df016ff94)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 exec.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index bb6170dbff..df5571eb3d 100644
--- a/exec.c
+++ b/exec.c
@@ -664,7 +664,7 @@ static void tcg_register_iommu_notifier(CPUState *cpu,
     int i;
 
     for (i = 0; i < cpu->iommu_notifiers->len; i++) {
-        notifier = &g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier, i);
+        notifier = g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier *, i);
         if (notifier->mr == mr && notifier->iommu_idx == iommu_idx) {
             break;
         }
@@ -672,7 +672,8 @@ static void tcg_register_iommu_notifier(CPUState *cpu,
     if (i == cpu->iommu_notifiers->len) {
         /* Not found, add a new entry at the end of the array */
         cpu->iommu_notifiers = g_array_set_size(cpu->iommu_notifiers, i + 1);
-        notifier = &g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier, i);
+        notifier = g_new0(TCGIOMMUNotifier, 1);
+        g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier *, i) = notifier;
 
         notifier->mr = mr;
         notifier->iommu_idx = iommu_idx;
@@ -704,8 +705,9 @@ static void tcg_iommu_free_notifier_list(CPUState *cpu)
     TCGIOMMUNotifier *notifier;
 
     for (i = 0; i < cpu->iommu_notifiers->len; i++) {
-        notifier = &g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier, i);
+        notifier = g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier *, i);
         memory_region_unregister_iommu_notifier(notifier->mr, &notifier->n);
+        g_free(notifier);
     }
     g_array_free(cpu->iommu_notifiers, true);
 }
@@ -975,7 +977,7 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
         vmstate_register(NULL, cpu->cpu_index, cc->vmsd, cpu);
     }
 
-    cpu->iommu_notifiers = g_array_new(false, true, sizeof(TCGIOMMUNotifier));
+    cpu->iommu_notifiers = g_array_new(false, true, sizeof(TCGIOMMUNotifier *));
 #endif
 }
 
-- 
2.17.1


