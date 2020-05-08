Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AECC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 23:13:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 317062070B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 23:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317062070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXCBU-0003SG-CC
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 19:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jXC71-0003SG-0k; Fri, 08 May 2020 19:08:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jXC6r-0005op-AI; Fri, 08 May 2020 19:08:58 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 048N1hgK004417; Fri, 8 May 2020 19:08:46 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30vtsf32ad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2020 19:08:46 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 048N2Esn008302;
 Fri, 8 May 2020 19:08:45 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30vtsf32a2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2020 19:08:45 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 048N1phw001097;
 Fri, 8 May 2020 23:08:44 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma03dal.us.ibm.com with ESMTP id 30s0g8ay0w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2020 23:08:44 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 048N8i7g15533042
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 May 2020 23:08:44 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D087AC05E;
 Fri,  8 May 2020 23:08:44 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C54F0AC05F;
 Fri,  8 May 2020 23:08:43 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.189.36])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri,  8 May 2020 23:08:43 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v1 3/8] s390/sclp: rework sclp boundary and length checks
Date: Fri,  8 May 2020 19:08:18 -0400
Message-Id: <20200508230823.22956-4-walling@linux.ibm.com>
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
 suspectscore=0 phishscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080190
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

Let's factor out the SCLP boundary and length checks
into separate functions.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 hw/s390x/sclp.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index d08a291e40..470d5da7a2 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -49,6 +49,34 @@ static inline bool sclp_command_code_valid(uint32_t code)
     return false;
 }
 
+static bool check_sccb_boundary_valid(uint64_t sccb_addr, uint32_t code,
+                                      SCCB *sccb)
+{
+    uint64_t current_len = sccb_addr + be16_to_cpu(sccb->h.length);
+    uint64_t allowed_len = (sccb_addr & PAGE_MASK) + PAGE_SIZE;
+
+    switch (code & SCLP_CMD_CODE_MASK) {
+    default:
+        if (current_len <= allowed_len) {
+            return true;
+        }
+    }
+    sccb->h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
+    return false;
+}
+
+static bool check_sufficient_sccb_len(SCCB *sccb, int size)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    int required_len = size + ms->possible_cpus->len * sizeof(CPUEntry);
+
+    if (be16_to_cpu(sccb->h.length) < required_len) {
+        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
+        return false;
+    }
+    return true;
+}
+
 static void prepare_cpu_entries(CPUEntry *entry, int *count)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -76,8 +104,7 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     int rnsize, rnmax;
     IplParameterBlock *ipib = s390_ipl_get_iplb();
 
-    if (be16_to_cpu(sccb->h.length) < (sizeof(ReadInfo) + cpu_count * sizeof(CPUEntry))) {
-        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
+    if (!check_sufficient_sccb_len(sccb, sizeof(ReadInfo))) {
         return;
     }
 
@@ -134,8 +161,7 @@ static void sclp_read_cpu_info(SCLPDevice *sclp, SCCB *sccb)
     ReadCpuInfo *cpu_info = (ReadCpuInfo *) sccb;
     int cpu_count;
 
-    if (be16_to_cpu(sccb->h.length) < (sizeof(ReadCpuInfo) + cpu_count * sizeof(CPUEntry))) {
-        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
+    if (!check_sufficient_sccb_len(sccb, sizeof(ReadCpuInfo))) {
         return;
     }
 
@@ -227,6 +253,10 @@ int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
         goto out_write;
     }
 
+    if (!check_sccb_boundary_valid(sccb, code, &work_sccb)) {
+        goto out_write;
+    }
+
     sclp_c->execute(sclp, &work_sccb, code);
 out_write:
     s390_cpu_pv_mem_write(env_archcpu(env), 0, &work_sccb,
@@ -272,8 +302,7 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
         goto out_write;
     }
 
-    if ((sccb + be16_to_cpu(work_sccb.h.length)) > ((sccb & PAGE_MASK) + PAGE_SIZE)) {
-        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
+    if (!check_sccb_boundary_valid(sccb, code, &work_sccb)) {
         goto out_write;
     }
 
-- 
2.21.1


