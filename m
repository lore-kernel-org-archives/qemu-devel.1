Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FEEC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 23:12:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69A532173E
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 23:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A532173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXCAU-0001AR-DO
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 19:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jXC6t-0003Ps-7H; Fri, 08 May 2020 19:08:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jXC6q-0005oJ-92; Fri, 08 May 2020 19:08:50 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 048N26X4037918; Fri, 8 May 2020 19:08:46 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30vtsk2r2u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2020 19:08:46 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 048N3woE042413;
 Fri, 8 May 2020 19:08:45 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30vtsk2r2f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2020 19:08:45 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 048N0QXw005153;
 Fri, 8 May 2020 23:08:44 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma01wdc.us.ibm.com with ESMTP id 30s0g75gd7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2020 23:08:44 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 048N8hGm39584124
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 May 2020 23:08:43 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BEEEEAC05E;
 Fri,  8 May 2020 23:08:43 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 861A4AC062;
 Fri,  8 May 2020 23:08:43 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.189.36])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri,  8 May 2020 23:08:43 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v1 2/8] s390/sclp: check sccb len before filling in data
Date: Fri,  8 May 2020 19:08:17 -0400
Message-Id: <20200508230823.22956-3-walling@linux.ibm.com>
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
 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005080190
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

The SCCB must be checked for a sufficient length before it is filled
with any data. If the length is insufficient, then the SCLP command
is suppressed and the proper response code is set in the SCCB header.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 hw/s390x/sclp.c | 22 ++++++++++------------
 smp.max_cpus    |  0
 2 files changed, 10 insertions(+), 12 deletions(-)
 create mode 100644 smp.max_cpus

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 156ffe3223..d08a291e40 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -76,6 +76,11 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     int rnsize, rnmax;
     IplParameterBlock *ipib = s390_ipl_get_iplb();
 
+    if (be16_to_cpu(sccb->h.length) < (sizeof(ReadInfo) + cpu_count * sizeof(CPUEntry))) {
+        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
+        return;
+    }
+
     /* CPU information */
     prepare_cpu_entries(read_info->entries, &cpu_count);
     read_info->entries_cpu = cpu_to_be16(cpu_count);
@@ -84,12 +89,6 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
 
     read_info->ibc_val = cpu_to_be32(s390_get_ibc_val());
 
-    if (be16_to_cpu(sccb->h.length) <
-            (sizeof(ReadInfo) + cpu_count * sizeof(CPUEntry))) {
-        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
-        return;
-    }
-
     /* Configuration Characteristic (Extension) */
     s390_get_feat_block(S390_FEAT_TYPE_SCLP_CONF_CHAR,
                          read_info->conf_char);
@@ -135,17 +134,16 @@ static void sclp_read_cpu_info(SCLPDevice *sclp, SCCB *sccb)
     ReadCpuInfo *cpu_info = (ReadCpuInfo *) sccb;
     int cpu_count;
 
+    if (be16_to_cpu(sccb->h.length) < (sizeof(ReadCpuInfo) + cpu_count * sizeof(CPUEntry))) {
+        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
+        return;
+    }
+
     prepare_cpu_entries(cpu_info->entries, &cpu_count);
     cpu_info->nr_configured = cpu_to_be16(cpu_count);
     cpu_info->offset_configured = cpu_to_be16(offsetof(ReadCpuInfo, entries));
     cpu_info->nr_standby = cpu_to_be16(0);
 
-    if (be16_to_cpu(sccb->h.length) <
-            (sizeof(ReadCpuInfo) + cpu_count * sizeof(CPUEntry))) {
-        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
-        return;
-    }
-
     /* The standby offset is 16-byte for each CPU */
     cpu_info->offset_standby = cpu_to_be16(cpu_info->offset_configured
         + cpu_info->nr_configured*sizeof(CPUEntry));
diff --git a/smp.max_cpus b/smp.max_cpus
new file mode 100644
index 0000000000..e69de29bb2
-- 
2.21.1


