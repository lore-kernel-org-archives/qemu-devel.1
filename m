Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B94C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:44:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D74206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z+0UNYSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D74206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPjW2-0000NQ-Gs
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 05:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kPjUv-0007ZB-Hz
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:43:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19376
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kPjUt-0002E7-G9
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:43:05 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0969WGBE115185
 for <qemu-devel@nongnu.org>; Tue, 6 Oct 2020 05:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Meo3yYgoewKhZPN+zN1BhVnb0lBhWLH5mHe+wthkhpg=;
 b=Z+0UNYShPg0lioyGAp4IOkDMJQQGvlMNoHVM7i3yGnS6V3I3l+tATXfkaPDdwFuGuYut
 0oEusHllT0x/8lpnDWMCQobapa2IoWeBElJ5SPTcEShSEfAgdKh6qLIQrUZhzs/jOmxu
 oEKInA3oe4upnL2YmjY6R+ItuNmmcNfQ6yjpbDyTO5LkYPzD0xiTLNNHcWnrjk6NiwS1
 0VhoK+0R97N9d/Qhys/zlbOlas9vdFCO6/xMzGbbDzUOgwh/4DdPmd2ahsUdj9JE2zs7
 OjXBD3VQmL1wlP6C1f9nFDGTN22yeQsEoPGRbGBMjWRoanU+KH3STET+tgUviVFAXFv0 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 340nuc8mqd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 05:43:02 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0969XM67118295
 for <qemu-devel@nongnu.org>; Tue, 6 Oct 2020 05:43:02 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 340nuc8mps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2020 05:43:02 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0969SCJd000424;
 Tue, 6 Oct 2020 09:43:00 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma03fra.de.ibm.com with ESMTP id 33xgx7sk6m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2020 09:43:00 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0969gwjq31195482
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2020 09:42:58 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 230CB5204F;
 Tue,  6 Oct 2020 09:42:58 +0000 (GMT)
Received: from linux01.pok.stglabs.ibm.com (unknown [9.114.17.81])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 858B152051;
 Tue,  6 Oct 2020 09:42:57 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/4] pc-bios: s390x: Use reset PSW if avaliable
Date: Tue,  6 Oct 2020 05:42:48 -0400
Message-Id: <20201006094249.50640-4-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201006094249.50640-1-frankja@linux.ibm.com>
References: <20201006094249.50640-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-06_03:2020-10-06,
 2020-10-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0
 suspectscore=1 bulkscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010060058
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 05:43:01
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

If a blob provides a reset PSW then we should use it instead of
branching to the PSW address and using our own mask.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/bootmap.c  |  6 ++++--
 pc-bios/s390-ccw/jump2ipl.c | 26 +++++++++++++++++++-------
 pc-bios/s390-ccw/s390-ccw.h |  1 +
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 8747c4ea26..88bd12d5d7 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -273,7 +273,8 @@ static void run_eckd_boot_script(block_number_t bmt_block_nr,
 
     IPL_assert(bms->entry[i].type == BOOT_SCRIPT_EXEC,
                "Unknown script entry type");
-    jump_to_IPL_code(bms->entry[i].address.load_address); /* no return */
+    write_reset_psw(bms->entry[i].address.load_address); /* no return */
+    jump_to_IPL_code(0); /* no return */
 }
 
 static void ipl_eckd_cdl(void)
@@ -515,7 +516,8 @@ static void zipl_run(ScsiBlockPtr *pte)
     IPL_assert(entry->component_type == ZIPL_COMP_ENTRY_EXEC, "No EXEC entry");
 
     /* should not return */
-    jump_to_IPL_code(entry->compdat.load_psw & PSW_MASK_SHORT_ADDR);
+    write_reset_psw(entry->compdat.load_psw);
+    jump_to_IPL_code(0);
 }
 
 static void ipl_scsi(void)
diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
index b6aad32def..63afa4a349 100644
--- a/pc-bios/s390-ccw/jump2ipl.c
+++ b/pc-bios/s390-ccw/jump2ipl.c
@@ -12,15 +12,21 @@
 
 #define KERN_IMAGE_START 0x010000UL
 #define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_64)
+#define RESET_PSW ((uint64_t)&jump_to_IPL_addr | RESET_PSW_MASK)
 
 static uint64_t *reset_psw = 0, save_psw, ipl_continue;
 
+void write_reset_psw(uint64_t psw)
+{
+    *reset_psw = psw;
+}
+
 static void jump_to_IPL_addr(void)
 {
     __attribute__((noreturn)) void (*ipl)(void) = (void *)ipl_continue;
 
     /* Restore reset PSW */
-    *reset_psw = save_psw;
+    write_reset_psw(save_psw);
 
     ipl();
     /* should not return */
@@ -43,11 +49,12 @@ void jump_to_IPL_code(uint64_t address)
      * content of non-BIOS memory after we loaded the guest, so we
      * save the original content and restore it in jump_to_IPL_2.
      */
-    save_psw = *reset_psw;
-    *reset_psw = (uint64_t) &jump_to_IPL_addr;
-    *reset_psw |= RESET_PSW_MASK;
-    ipl_continue = address;
-    debug_print_int("set IPL addr to", ipl_continue);
+    if (address) {
+        save_psw = *reset_psw;
+        write_reset_psw(RESET_PSW);
+        ipl_continue = address;
+    }
+    debug_print_int("set IPL addr to", address ? address : *reset_psw & PSW_MASK_SHORT_ADDR);
 
     /* Ensure the guest output starts fresh */
     sclp_print("\n");
@@ -77,7 +84,12 @@ void jump_to_low_kernel(void)
 
     /* Trying to get PSW at zero address */
     if (*((uint64_t *)0) & RESET_PSW_MASK) {
-        jump_to_IPL_code((*((uint64_t *)0)) & PSW_MASK_SHORT_ADDR);
+        /*
+         * Surely nobody will try running directly from lowcore, so
+         * let's use 0 as an indication that we want to load the reset
+         * psw at 0x0 and not jump to the entry.
+         */
+        jump_to_IPL_code(0);
     }
 
     /* No other option left, so use the Linux kernel start address */
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 36b884cced..7090720422 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -78,6 +78,7 @@ int virtio_read(ulong sector, void *load_addr);
 void zipl_load(void);
 
 /* jump2ipl.c */
+void write_reset_psw(uint64_t psw);
 void jump_to_IPL_code(uint64_t address);
 void jump_to_low_kernel(void);
 
-- 
2.25.1


