Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297F0C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 07:56:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2C6C2085B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 07:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C6C2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo0GS-0002j6-4l
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 03:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jo0D9-0004VE-Sr
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 03:52:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33786)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jo0D4-0006ep-8y
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 03:52:46 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05O7YUaM159625
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 03:52:39 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31ux0a6y9j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 03:52:39 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05O7aIKV174297
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 03:52:39 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31ux0a6y90-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2020 03:52:39 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05O7qEfB014052;
 Wed, 24 Jun 2020 07:52:36 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma05fra.de.ibm.com with ESMTP id 31uusg05sr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2020 07:52:36 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05O7qY9948365670
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2020 07:52:34 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 910C3A4053;
 Wed, 24 Jun 2020 07:52:34 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 015A1A404D;
 Wed, 24 Jun 2020 07:52:34 +0000 (GMT)
Received: from linux01.pok.stglabs.ibm.com (unknown [9.114.17.81])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 24 Jun 2020 07:52:33 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 01/12] pc-bios: s390x: cio.c cleanup and compile fix
Date: Wed, 24 Jun 2020 03:52:15 -0400
Message-Id: <20200624075226.92728-2-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624075226.92728-1-frankja@linux.ibm.com>
References: <20200624075226.92728-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-24_04:2020-06-24,
 2020-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 cotscore=-2147483648 clxscore=1015 bulkscore=0 lowpriorityscore=0
 mlxscore=0 suspectscore=1 priorityscore=1501 phishscore=0 mlxlogscore=712
 impostorscore=0 spamscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240055
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:52:40
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
Cc: borntraeger@de.ibm.com, thuth@redhat.com, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's initialize the structs at the beginning to ease reading and also
zeroing all other fields. This also makes the compiler stop
complaining about sense_id_ccw.flags being ored into when it's not
initialized.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 pc-bios/s390-ccw/cio.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/pc-bios/s390-ccw/cio.c b/pc-bios/s390-ccw/cio.c
index 339ec5fbe7..83ca27ab41 100644
--- a/pc-bios/s390-ccw/cio.c
+++ b/pc-bios/s390-ccw/cio.c
@@ -49,13 +49,13 @@ void enable_subchannel(SubChannelId schid)
 
 uint16_t cu_type(SubChannelId schid)
 {
-    Ccw1 sense_id_ccw;
     SenseId sense_data;
-
-    sense_id_ccw.cmd_code = CCW_CMD_SENSE_ID;
-    sense_id_ccw.cda = ptr2u32(&sense_data);
-    sense_id_ccw.count = sizeof(sense_data);
-    sense_id_ccw.flags |= CCW_FLAG_SLI;
+    Ccw1 sense_id_ccw = {
+        .cmd_code = CCW_CMD_SENSE_ID,
+        .flags = CCW_FLAG_SLI,
+        .count = sizeof(sense_data),
+        .cda = ptr2u32(&sense_data),
+    };
 
     if (do_cio(schid, CU_TYPE_UNKNOWN, ptr2u32(&sense_id_ccw), CCW_FMT1)) {
         panic("Failed to run SenseID CCw\n");
@@ -67,13 +67,13 @@ uint16_t cu_type(SubChannelId schid)
 int basic_sense(SubChannelId schid, uint16_t cutype, void *sense_data,
                  uint16_t data_size)
 {
-    Ccw1 senseCcw;
+    Ccw1 senseCcw = {
+        .cmd_code = CCW_CMD_BASIC_SENSE,
+        .count = data_size,
+        .cda = ptr2u32(sense_data),
+    };
     Irb irb;
 
-    senseCcw.cmd_code = CCW_CMD_BASIC_SENSE;
-    senseCcw.cda = ptr2u32(sense_data);
-    senseCcw.count = data_size;
-
     return __do_cio(schid, ptr2u32(&senseCcw), CCW_FMT1, &irb);
 }
 
@@ -314,7 +314,17 @@ static void print_irb_err(Irb *irb)
  */
 static int __do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt, Irb *irb)
 {
-    CmdOrb orb = {};
+    /*
+     * QEMU's CIO implementation requires prefetch and 64-bit idaws. We
+     * allow all paths.
+     */
+    CmdOrb orb = {
+        .fmt = fmt,
+        .pfch = 1,
+        .c64 = 1,
+        .lpm = 0xFF,
+        .cpa = ccw_addr,
+    };
     int rc;
 
     IPL_assert(fmt == 0 || fmt == 1, "Invalid ccw format");
@@ -324,12 +334,6 @@ static int __do_cio(SubChannelId schid, uint32_t ccw_addr, int fmt, Irb *irb)
         IPL_assert(ccw_addr <= 0xFFFFFF - 8, "Invalid ccw address");
     }
 
-    orb.fmt = fmt;
-    orb.pfch = 1;  /* QEMU's cio implementation requires prefetch */
-    orb.c64 = 1;   /* QEMU's cio implementation requires 64-bit idaws */
-    orb.lpm = 0xFF; /* All paths allowed */
-    orb.cpa = ccw_addr;
-
     rc = ssch(schid, &orb);
     if (rc == 1 || rc == 2) {
         /* Subchannel status pending or busy. Eat status and ask for retry. */
-- 
2.25.1


