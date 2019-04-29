Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F02C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 13:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64ABA2084B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 13:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64ABA2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57504 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL63T-00077Y-LK
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 09:10:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1hL62b-0006c4-69
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:09:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1hL62Y-0008Sa-GD
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:09:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1hL62Y-0008R0-5m
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:09:50 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3TD4b28093327
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 09:09:46 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2s60w0tt73-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 09:09:46 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Mon, 29 Apr 2019 14:09:45 +0100
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
	by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 29 Apr 2019 14:09:44 +0100
Received: from b03ledav002.gho.boulder.ibm.com
	(b03ledav002.gho.boulder.ibm.com [9.17.130.233])
	by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x3TD9gul2621718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Mon, 29 Apr 2019 13:09:42 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7A39136053;
	Mon, 29 Apr 2019 13:09:42 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13027136059;
	Mon, 29 Apr 2019 13:09:42 +0000 (GMT)
Received: from jason-laptop.endicott.ibm.com (unknown [9.60.75.221])
	by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
	Mon, 29 Apr 2019 13:09:41 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
	thuth@redhat.com, alifm@linux.ibm.com, borntraeger@de.ibm.com
Date: Mon, 29 Apr 2019 09:09:41 -0400
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19042913-0036-0000-0000-00000AB044D9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011017; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000285; SDB=6.01196077; UDB=6.00627227;
	IPR=6.00976926; 
	MB=3.00026647; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-29 13:09:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042913-0037-0000-0000-00004B932355
Message-Id: <1556543381-12671-1-git-send-email-jjherne@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-29_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904290094
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH] s390-bios: Skip bootmap signature entries
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190429130941.NWjoUGVYj080lxg2jVk2UqhyPnat3GskUT96z6Mhv6A@z>

Newer versions of zipl have the ability to write signature entries to the boot
script for secure boot. We don't yet support secure boot, but we need to skip
over signature entries while reading the boot script in order to maintain our
ability to boot guest operating systems that have a secure bootloader.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c | 19 +++++++++++++++++--
 pc-bios/s390-ccw/bootmap.h | 10 ++++++----
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 7aef65a..d13b7cb 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -254,7 +254,14 @@ static void run_eckd_boot_script(block_number_t bmt_block_nr,
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
     read_block(block_nr, sec, "Cannot read Boot Map Script");
 
-    for (i = 0; bms->entry[i].type == BOOT_SCRIPT_LOAD; i++) {
+    for (i = 0; bms->entry[i].type == BOOT_SCRIPT_LOAD ||
+                bms->entry[i].type == BOOT_SCRIPT_SIGNATURE; i++) {
+
+        /* We don't support secure boot yet, so we skip signature entries */
+        if (bms->entry[i].type == BOOT_SCRIPT_SIGNATURE) {
+            continue;
+        }
+
         address = bms->entry[i].address.load_address;
         block_nr = eckd_block_num(&bms->entry[i].blkptr.xeckd.bptr.chs);
 
@@ -489,7 +496,15 @@ static void zipl_run(ScsiBlockPtr *pte)
 
     /* Load image(s) into RAM */
     entry = (ComponentEntry *)(&header[1]);
-    while (entry->component_type == ZIPL_COMP_ENTRY_LOAD) {
+    while (entry->component_type == ZIPL_COMP_ENTRY_LOAD ||
+           entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
+
+        /* We don't support secure boot yet, so we skip signature entries */
+        if (entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
+            entry++;
+            continue;
+        }
+
         zipl_load_segment(entry);
 
         entry++;
diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index a085212..94f53a5 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -98,8 +98,9 @@ typedef struct ScsiMbr {
 #define ZIPL_COMP_HEADER_IPL    0x00
 #define ZIPL_COMP_HEADER_DUMP   0x01
 
-#define ZIPL_COMP_ENTRY_LOAD    0x02
-#define ZIPL_COMP_ENTRY_EXEC    0x01
+#define ZIPL_COMP_ENTRY_EXEC      0x01
+#define ZIPL_COMP_ENTRY_LOAD      0x02
+#define ZIPL_COMP_ENTRY_SIGNATURE 0x03
 
 typedef struct XEckdMbr {
     uint8_t magic[4];   /* == "xIPL"        */
@@ -117,8 +118,9 @@ typedef struct BootMapScriptEntry {
     BootMapPointer blkptr;
     uint8_t pad[7];
     uint8_t type;   /* == BOOT_SCRIPT_* */
-#define BOOT_SCRIPT_EXEC 0x01
-#define BOOT_SCRIPT_LOAD 0x02
+#define BOOT_SCRIPT_EXEC      0x01
+#define BOOT_SCRIPT_LOAD      0x02
+#define BOOT_SCRIPT_SIGNATURE 0x03
     union {
         uint64_t load_address;
         uint64_t load_psw;
-- 
2.7.4


