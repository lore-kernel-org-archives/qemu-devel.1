Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEACC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 07:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EBFE2547C
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 07:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EBFE2547C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnH7f-0004Nw-Bg
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 03:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jnH6U-0002jK-1P; Mon, 22 Jun 2020 03:42:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44408
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jnH6S-0001u2-1y; Mon, 22 Jun 2020 03:42:53 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05M7X0Na072983; Mon, 22 Jun 2020 03:42:51 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31spnuuftk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2020 03:42:50 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05M7YgfL081463;
 Mon, 22 Jun 2020 03:42:50 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31spnuufsm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2020 03:42:50 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05M7eOOJ024846;
 Mon, 22 Jun 2020 07:42:48 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma04ams.nl.ibm.com with ESMTP id 31sa37twx7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2020 07:42:48 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05M7gkvN64290956
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jun 2020 07:42:46 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BBB0A405C;
 Mon, 22 Jun 2020 07:42:46 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9CEBA4054;
 Mon, 22 Jun 2020 07:42:45 +0000 (GMT)
Received: from linux01.pok.stglabs.ibm.com (unknown [9.114.17.81])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 22 Jun 2020 07:42:45 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/9] pc-bios: s390x: Get rid of magic offsets into the
 lowcore
Date: Mon, 22 Jun 2020 03:42:30 -0400
Message-Id: <20200622074235.32528-5-frankja@linux.ibm.com>
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
 suspectscore=1
 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 cotscore=-2147483648 impostorscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=754 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220052
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:20:35
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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

If we have a lowcore struct that has members for offsets that we want
to touch, why not use it?

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 pc-bios/s390-ccw/cio.h  | 17 +++++++++++------
 pc-bios/s390-ccw/main.c |  8 +++-----
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
index aaa432dedd..1e5d4e92e1 100644
--- a/pc-bios/s390-ccw/cio.h
+++ b/pc-bios/s390-ccw/cio.h
@@ -122,12 +122,17 @@ typedef struct schib {
 } __attribute__ ((packed, aligned(4))) Schib;
 
 typedef struct subchannel_id {
-        __u32 cssid:8;
-        __u32:4;
-        __u32 m:1;
-        __u32 ssid:2;
-        __u32 one:1;
-        __u32 sch_no:16;
+    union {
+        struct {
+            __u16 cssid:8;
+            __u16 reserved:4;
+            __u16 m:1;
+            __u16 ssid:2;
+            __u16 one:1;
+        };
+        __u16 sch_id;
+    };
+    __u16 sch_no;
 } __attribute__ ((packed, aligned(4))) SubChannelId;
 
 struct chsc_header {
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 4e65b411e1..8b912454c9 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -36,11 +36,9 @@ LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
  */
 void write_subsystem_identification(void)
 {
-    SubChannelId *schid = (SubChannelId *) 184;
-    uint32_t *zeroes = (uint32_t *) 188;
-
-    *schid = blk_schid;
-    *zeroes = 0;
+    lowcore->subchannel_id = blk_schid.sch_id;
+    lowcore->subchannel_nr = blk_schid.sch_no;
+    lowcore->io_int_parm = 0;
 }
 
 void write_iplb_location(void)
-- 
2.25.1


