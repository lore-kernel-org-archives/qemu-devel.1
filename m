Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D46C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:14:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57DF82076F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57DF82076F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGlGZ-00074f-GM
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 11:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jGlBd-0007DQ-BY
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:09:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jGlBc-0003Lq-7O
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:09:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43328)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jGlBb-0003Ky-VJ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:09:48 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02OF5mFl059476
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 11:09:47 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yxw7dfbhm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 11:09:46 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Tue, 24 Mar 2020 15:09:43 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 24 Mar 2020 15:09:40 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 02OF9ema44957982
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2020 15:09:41 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E51ACA4060;
 Tue, 24 Mar 2020 15:09:40 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92C34A405B;
 Tue, 24 Mar 2020 15:09:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.9.40])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 24 Mar 2020 15:09:39 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/8] pc-bios: s390x: Replace 0x00 with 0x0 or 0
Date: Tue, 24 Mar 2020 11:08:46 -0400
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324150847.10476-1-frankja@linux.ibm.com>
References: <20200324150847.10476-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20032415-0012-0000-0000-00000396E73F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032415-0013-0000-0000-000021D3DBAE
Message-Id: <20200324150847.10476-8-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-24_05:2020-03-23,
 2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=456
 mlxscore=0 suspectscore=1 bulkscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240079
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

0x00 looks odd, time to replace it with 0 or 0x0 (for pointers).

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 pc-bios/s390-ccw/dasd-ipl.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/pc-bios/s390-ccw/dasd-ipl.c b/pc-bios/s390-ccw/dasd-ipl.c
index b932531e6f838405..764ee89e92e3ae8d 100644
--- a/pc-bios/s390-ccw/dasd-ipl.c
+++ b/pc-bios/s390-ccw/dasd-ipl.c
@@ -98,18 +98,18 @@ static int run_dynamic_ccw_program(SubChannelId schid, uint16_t cutype,
 
 static void make_readipl(void)
 {
-    Ccw0 *ccwIplRead = (Ccw0 *)0x00;
+    Ccw0 *ccwIplRead = (Ccw0 *)0x0;
 
     /* Create Read IPL ccw at address 0 */
     ccwIplRead->cmd_code = CCW_CMD_READ_IPL;
-    ccwIplRead->cda = 0x00; /* Read into address 0x00 in main memory */
+    ccwIplRead->cda = 0x0; /* Read into address 0x00 in main memory */
     ccwIplRead->chain = 0; /* Chain flag */
     ccwIplRead->count = 0x18; /* Read 0x18 bytes of data */
 }
 
 static void run_readipl(SubChannelId schid, uint16_t cutype)
 {
-    if (do_cio(schid, cutype, 0x00, CCW_FMT0)) {
+    if (do_cio(schid, cutype, 0x0, CCW_FMT0)) {
         panic("dasd-ipl: Failed to run Read IPL channel program\n");
     }
 }
@@ -133,10 +133,10 @@ static void check_ipl2(uint32_t ipl2_addr)
 {
     Ccw0 *ccw = u32toptr(ipl2_addr);
 
-    if (ipl2_addr == 0x00) {
+    if (ipl2_addr == 0) {
         panic("IPL2 address invalid. Is this disk really bootable?\n");
     }
-    if (ccw->cmd_code == 0x00) {
+    if (ccw->cmd_code == 0) {
         panic("IPL2 ccw data invalid. Is this disk really bootable?\n");
     }
 }
@@ -161,7 +161,7 @@ static void ipl1_fixup(void)
     memcpy(ccwRead, (void *)0x08, 16);
 
     /* Disable chaining so we don't TIC to IPL2 channel program */
-    ccwRead->chain = 0x00;
+    ccwRead->chain = 0;
 
     ccwSeek->cmd_code = CCW_CMD_DASD_SEEK;
     ccwSeek->cda = ptr2u32(seekData);
@@ -206,7 +206,7 @@ static void run_ipl2(SubChannelId schid, uint16_t cutype, uint32_t addr)
  */
 void dasd_ipl(SubChannelId schid, uint16_t cutype)
 {
-    PSWLegacy *pswl = (PSWLegacy *) 0x00;
+    PSWLegacy *pswl = (PSWLegacy *) 0x0;
     uint32_t ipl2_addr;
 
     /* Construct Read IPL CCW and run it to read IPL1 from boot disk */
-- 
2.25.1


