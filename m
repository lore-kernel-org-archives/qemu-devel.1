Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075F9C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:35:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D206C207E0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D206C207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDS3n-0001H5-FN
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 07:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imbrenda@linux.ibm.com>) id 1iDS22-0007jU-HC
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:34:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imbrenda@linux.ibm.com>) id 1iDS20-0007nV-5z
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:33:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23128
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imbrenda@linux.ibm.com>)
 id 1iDS20-0007jh-1S
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:33:56 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8QBWFxj029729
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 07:33:49 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v8ur5tc8k-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 07:33:49 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <imbrenda@linux.ibm.com>;
 Thu, 26 Sep 2019 12:33:48 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 26 Sep 2019 12:33:44 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8QBXhBl50397318
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Sep 2019 11:33:43 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FDEA4C044;
 Thu, 26 Sep 2019 11:33:43 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D755B4C040;
 Thu, 26 Sep 2019 11:33:42 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.39])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu, 26 Sep 2019 11:33:42 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v1 1/2] s390x: Add sclp boundary check and fix error priority
Date: Thu, 26 Sep 2019 13:33:41 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569497622-12496-1-git-send-email-imbrenda@linux.ibm.com>
References: <1569497622-12496-1-git-send-email-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19092611-0028-0000-0000-000003A2DE34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092611-0029-0000-0000-00002464FBA7
Message-Id: <1569497622-12496-2-git-send-email-imbrenda@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-26_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909260111
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
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

* All sclp codes need to be checked for page boundary violations.
* Requests over 4k are not a spec exception.
* Invalid command checking has to be done before the boundary check.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 hw/s390x/event-facility.c |  3 ---
 hw/s390x/sclp.c           | 25 ++++++++++++++++++++++---
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 797ecbb..6620569 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -377,9 +377,6 @@ static void command_handler(SCLPEventFacility *ef, SCCB *sccb, uint64_t code)
     case SCLP_CMD_WRITE_EVENT_MASK:
         write_event_mask(ef, sccb);
         break;
-    default:
-        sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
-        break;
     }
 }
 
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index fac7c3b..76feac8 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -213,14 +213,33 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
     cpu_physical_memory_read(sccb, &work_sccb, sccb_len);
 
     /* Valid sccb sizes */
-    if (be16_to_cpu(work_sccb.h.length) < sizeof(SCCBHeader) ||
-        be16_to_cpu(work_sccb.h.length) > SCCB_SIZE) {
+    if (be16_to_cpu(work_sccb.h.length) < sizeof(SCCBHeader)) {
         r = -PGM_SPECIFICATION;
         goto out;
     }
 
-    sclp_c->execute(sclp, &work_sccb, code);
+    switch (code & SCLP_CMD_CODE_MASK) {
+    case SCLP_CMDW_READ_SCP_INFO:
+    case SCLP_CMDW_READ_SCP_INFO_FORCED:
+    case SCLP_CMDW_READ_CPU_INFO:
+    case SCLP_CMDW_CONFIGURE_IOA:
+    case SCLP_CMDW_DECONFIGURE_IOA:
+    case SCLP_CMD_READ_EVENT_DATA:
+    case SCLP_CMD_WRITE_EVENT_DATA:
+    case SCLP_CMD_WRITE_EVENT_MASK:
+        break;
+    default:
+        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
+        goto out_write;
+    }
 
+    if ((sccb + work_sccb.h.length) > ((sccb & PAGE_MASK) + PAGE_SIZE)) {
+        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
+        goto out_write;
+    }
+
+    sclp_c->execute(sclp, &work_sccb, code);
+out_write:
     cpu_physical_memory_write(sccb, &work_sccb,
                               be16_to_cpu(work_sccb.h.length));
 
-- 
2.7.4


