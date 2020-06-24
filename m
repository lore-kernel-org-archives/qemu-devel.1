Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E2EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 20:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2A432080C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 20:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A432080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joBy0-0001q9-1V
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 16:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1joBvz-0006P6-IT; Wed, 24 Jun 2020 16:23:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1joBvt-00031q-Qr; Wed, 24 Jun 2020 16:23:51 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05OK2sxI045878; Wed, 24 Jun 2020 16:23:44 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31vbn6bxb5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2020 16:23:44 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05OK3ofr049047;
 Wed, 24 Jun 2020 16:23:43 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31vbn6bxau-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2020 16:23:43 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05OKJjjx015032;
 Wed, 24 Jun 2020 20:23:42 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma02dal.us.ibm.com with ESMTP id 31uurt0677-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2020 20:23:42 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05OKNgWO50856374
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2020 20:23:42 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3BC9AE060;
 Wed, 24 Jun 2020 20:23:41 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ABB10AE067;
 Wed, 24 Jun 2020 20:23:41 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.198.108])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 24 Jun 2020 20:23:41 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v4 4/8] s390/sclp: read sccb from mem based on sccb length
Date: Wed, 24 Jun 2020 16:23:08 -0400
Message-Id: <20200624202312.28349-5-walling@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624202312.28349-1-walling@linux.ibm.com>
References: <20200624202312.28349-1-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-24_15:2020-06-24,
 2020-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 cotscore=-2147483648 suspectscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006240129
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 15:31:11
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, david@redhat.com,
 cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, mst@redhat.com,
 svens@linux.ibm.com, pbonzini@redhat.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The header of the SCCB contains the actual length of the SCCB. Instead
of using a static 4K size, let's allow for a variable size determined
by the value set in the header. The proper checks are already in place
to ensure the SCCB length is sufficent to store a full response, and
that the length does not cross any explicitly-set boundaries.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/sclp.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 5899c1e3b8..1feba6f692 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -251,9 +251,8 @@ int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
     SCLPDevice *sclp = get_sclp_device();
     SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
     SCCB work_sccb;
-    hwaddr sccb_len = sizeof(SCCB);
 
-    s390_cpu_pv_mem_read(env_archcpu(env), 0, &work_sccb, sccb_len);
+    s390_cpu_pv_mem_read(env_archcpu(env), 0, &work_sccb, sizeof(SCCBHeader));
 
     if (!sclp_command_code_valid(code)) {
         work_sccb.h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
@@ -264,6 +263,9 @@ int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
         goto out_write;
     }
 
+    s390_cpu_pv_mem_read(env_archcpu(env), 0, &work_sccb,
+                         be16_to_cpu(work_sccb.h.length));
+
     sclp_c->execute(sclp, &work_sccb, code);
 out_write:
     s390_cpu_pv_mem_write(env_archcpu(env), 0, &work_sccb,
@@ -278,8 +280,6 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
     SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
     SCCB work_sccb;
 
-    hwaddr sccb_len = sizeof(SCCB);
-
     /* first some basic checks on program checks */
     if (env->psw.mask & PSW_MASK_PSTATE) {
         return -PGM_PRIVILEGED;
@@ -297,7 +297,7 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
      * from playing dirty tricks by modifying the memory content after
      * the host has checked the values
      */
-    cpu_physical_memory_read(sccb, &work_sccb, sccb_len);
+    cpu_physical_memory_read(sccb, &work_sccb, sizeof(SCCBHeader));
 
     /* Valid sccb sizes */
     if (be16_to_cpu(work_sccb.h.length) < sizeof(SCCBHeader)) {
@@ -313,6 +313,9 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
         goto out_write;
     }
 
+    /* the header contains the actual length of the sccb */
+    cpu_physical_memory_read(sccb, &work_sccb, be16_to_cpu(work_sccb.h.length));
+
     sclp_c->execute(sclp, &work_sccb, code);
 out_write:
     cpu_physical_memory_write(sccb, &work_sccb,
-- 
2.26.2


