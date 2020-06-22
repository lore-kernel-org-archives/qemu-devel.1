Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D32C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 07:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 893D62547C
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 07:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893D62547C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnH7c-0004MN-Mg
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 03:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jnH6S-0002ij-Pd; Mon, 22 Jun 2020 03:42:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41078)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jnH6Q-0001tf-W4; Mon, 22 Jun 2020 03:42:52 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05M7WFIC088407; Mon, 22 Jun 2020 03:42:49 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31sqynbnn2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2020 03:42:49 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05M7gmlU119075;
 Mon, 22 Jun 2020 03:42:48 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31sqynbnm8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2020 03:42:48 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05M7eA4w002099;
 Mon, 22 Jun 2020 07:42:46 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma03ams.nl.ibm.com with ESMTP id 31sa382x58-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2020 07:42:46 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 05M7giJC57934212
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jun 2020 07:42:44 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F210CA4062;
 Mon, 22 Jun 2020 07:42:43 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B105A405B;
 Mon, 22 Jun 2020 07:42:43 +0000 (GMT)
Received: from linux01.pok.stglabs.ibm.com (unknown [9.114.17.81])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 22 Jun 2020 07:42:43 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/9] pc-bios: s390x: cio.c cleanup and compile fix
Date: Mon, 22 Jun 2020 03:42:27 -0400
Message-Id: <20200622074235.32528-2-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622074235.32528-1-frankja@linux.ibm.com>
References: <20200622074235.32528-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-22_02:2020-06-22,
 2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 mlxscore=0 suspectscore=1 spamscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxlogscore=743 priorityscore=1501 bulkscore=0
 clxscore=1015 phishscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220052
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:42:49
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 thuth@redhat.com, david@redhat.com
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


