Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA861C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 07:48:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFAF725474
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 07:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFAF725474
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnHBf-0003pL-PL
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 03:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jnH6X-0002rV-US; Mon, 22 Jun 2020 03:42:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1494)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jnH6W-0001vE-0V; Mon, 22 Jun 2020 03:42:57 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05M7WxQa040383; Mon, 22 Jun 2020 03:42:54 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31svf0ygem-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2020 03:42:54 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05M7Xe9i042673;
 Mon, 22 Jun 2020 03:42:53 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31svf0ygdj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2020 03:42:53 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05M7eIaO024529;
 Mon, 22 Jun 2020 07:42:51 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma04ams.nl.ibm.com with ESMTP id 31sa37twxb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2020 07:42:51 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05M7gnfO63766544
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jun 2020 07:42:49 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0AB0EA4060;
 Mon, 22 Jun 2020 07:42:49 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 58616A4054;
 Mon, 22 Jun 2020 07:42:48 +0000 (GMT)
Received: from linux01.pok.stglabs.ibm.com (unknown [9.114.17.81])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 22 Jun 2020 07:42:48 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 7/9] pc-bios: s390x: Move panic() into header and add
 infinite loop
Date: Mon, 22 Jun 2020 03:42:33 -0400
Message-Id: <20200622074235.32528-8-frankja@linux.ibm.com>
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
 phishscore=0 suspectscore=1
 mlxlogscore=999 malwarescore=0 impostorscore=0 priorityscore=1501
 adultscore=0 spamscore=0 cotscore=-2147483648 lowpriorityscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006220056
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

panic() was defined for the ccw and net bios, i.e. twice, so it's
cleaner to rather put it into the header.

Also let's add an infinite loop into the assembly of disabled_wait() so
the caller doesn't need to take care of it.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/main.c     | 7 -------
 pc-bios/s390-ccw/netmain.c  | 8 --------
 pc-bios/s390-ccw/s390-ccw.h | 9 +++++++--
 pc-bios/s390-ccw/start.S    | 5 +++--
 4 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 8b912454c9..146a50760b 100644
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
index f1ee63577a..056e93a818 100644
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
index c5820e43ae..36b884cced 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -50,12 +50,11 @@ typedef unsigned long long __u64;
 #include "iplb.h"
 
 /* start.s */
-void disabled_wait(void);
+void disabled_wait(void) __attribute__ ((__noreturn__));
 void consume_sclp_int(void);
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
index aa8fceb19d..35be141d8d 100644
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


