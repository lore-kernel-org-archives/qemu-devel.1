Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CB9C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:14:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B55572074D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55572074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGlFs-000637-UH
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 11:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jGlBZ-00075b-Th
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jGlBY-0003HY-Oq
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:09:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23936
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jGlBY-0003H7-Jy
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:09:44 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02OF5JN6103394
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 11:09:44 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yyj4053t3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 11:09:43 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Tue, 24 Mar 2020 15:09:39 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 24 Mar 2020 15:09:35 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02OF9btf28966934
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2020 15:09:37 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 691C2A4062;
 Tue, 24 Mar 2020 15:09:37 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 123C5A405F;
 Tue, 24 Mar 2020 15:09:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.9.40])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 24 Mar 2020 15:09:35 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/8] pc-bios: s390x: Move panic() into header and add infinite
 loop
Date: Tue, 24 Mar 2020 11:08:44 -0400
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324150847.10476-1-frankja@linux.ibm.com>
References: <20200324150847.10476-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20032415-0020-0000-0000-000003BA359D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032415-0021-0000-0000-00002212B6C4
Message-Id: <20200324150847.10476-6-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-24_05:2020-03-23,
 2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=1 priorityscore=1501
 mlxscore=0 malwarescore=0 mlxlogscore=961 bulkscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240079
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

panic() was defined for the ccw and net bios, i.e. twice, so it's
cleaner to rather put it into the header.

Also let's add an infinite loop into the assembly of disabled_wait() so
the caller doesn't need to take care of it.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
---
 pc-bios/s390-ccw/main.c     | 7 -------
 pc-bios/s390-ccw/netmain.c  | 8 --------
 pc-bios/s390-ccw/s390-ccw.h | 7 ++++++-
 pc-bios/s390-ccw/start.S    | 5 +++--
 4 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 8b912454c940a390..146a50760bc70af7 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -46,13 +46,6 @@ void write_iplb_location(void)
     lowcore->ptr_iplb = ptr2u32(&iplb);
 }
 
-void panic(const char *string)
-{
-    sclp_print(string);
-    disabled_wait();
-    while (1) { }
-}
-
 unsigned int get_loadparm_index(void)
 {
     return atoui(loadparm_str);
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index a8e2b1b6233735d8..ca23f9bb19a3e04c 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -439,14 +439,6 @@ static int net_try_direct_tftp_load(filename_ip_t *fn_ip)
     return rc;
 }
 
-void panic(const char *string)
-{
-    sclp_print(string);
-    for (;;) {
-        disabled_wait();
-    }
-}
-
 void write_subsystem_identification(void)
 {
     SubChannelId *schid = (SubChannelId *) 184;
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index c5820e43aed143d0..b3dcfbc3c9b3814c 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -55,7 +55,6 @@ void consume_sclp_int(void);
 void consume_io_int(void);
 
 /* main.c */
-void panic(const char *string);
 void write_subsystem_identification(void);
 void write_iplb_location(void);
 extern char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
@@ -91,6 +90,12 @@ bool menu_is_enabled_enum(void);
 
 #define MAX_BOOT_ENTRIES  31
 
+static inline void panic(const char *string)
+{
+    sclp_print(string);
+    disabled_wait();
+}
+
 static inline void fill_hex(char *out, unsigned char val)
 {
     const char hex[] = "0123456789abcdef";
diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
index aa8fceb19da2164a..35be141d8da38d07 100644
--- a/pc-bios/s390-ccw/start.S
+++ b/pc-bios/s390-ccw/start.S
@@ -47,8 +47,9 @@ memsetxc:
  */
 	.globl disabled_wait
 disabled_wait:
-        larl %r1,disabled_wait_psw
-        lpswe   0(%r1)
+        larl	%r1,disabled_wait_psw
+        lpswe	0(%r1)
+1:	j	1b
 
 
 /*
-- 
2.25.1


