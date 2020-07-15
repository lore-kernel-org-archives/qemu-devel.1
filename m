Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD48FC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:44:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 829AF2065D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829AF2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvdxd-0004F7-Oz
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 05:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jvduq-0008Lg-Nq
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 05:41:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37950
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jvduo-0006H5-Jq
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 05:41:28 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06F9XsBN155645
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 05:41:25 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 329r1hma5m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 05:41:25 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06F9fP2E192048
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 05:41:25 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 329r1hma4v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2020 05:41:24 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06F9ZokG023486;
 Wed, 15 Jul 2020 09:41:23 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma04ams.nl.ibm.com with ESMTP id 329nmygfq8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2020 09:41:23 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06F9fL0S21889490
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jul 2020 09:41:21 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD9BD4C05A;
 Wed, 15 Jul 2020 09:41:20 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 474074C040;
 Wed, 15 Jul 2020 09:41:20 +0000 (GMT)
Received: from linux01.pok.stglabs.ibm.com (unknown [9.114.17.81])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 15 Jul 2020 09:41:20 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/7] pc-bios: s390x: Setup io and ext new psws only once
Date: Wed, 15 Jul 2020 05:40:45 -0400
Message-Id: <20200715094045.381984-8-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715094045.381984-1-frankja@linux.ibm.com>
References: <20200715094045.381984-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-15_07:2020-07-15,
 2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 priorityscore=1501 spamscore=0 mlxlogscore=731 lowpriorityscore=0
 impostorscore=0 adultscore=0 mlxscore=0 bulkscore=0 phishscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150077
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 05:27:14
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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

Absolutely no need to set them up every time before we enable our
interrupt masks.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 pc-bios/s390-ccw/start.S | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
index 01c4c21b26..0059a15d21 100644
--- a/pc-bios/s390-ccw/start.S
+++ b/pc-bios/s390-ccw/start.S
@@ -34,6 +34,12 @@ loop:
 remainder:
 	larl	%r2,memsetxc
 	ex	%r3,0(%r2)
+        /* Store io new PSW */
+        larl	%r1,io_new_psw
+        mvc	0x1f0(16),0(%r1)
+	/* Store ext new PSW */
+        larl	%r1,external_new_psw
+        mvc	0x1b0(16),0(%r1)
 done:
 	j      main		/* And call C */
 
@@ -64,11 +70,6 @@ consume_sclp_int:
         stctg   %c0,%c0,0(%r15)
         oi      6(%r15),0x2
         lctlg   %c0,%c0,0(%r15)
-        /* prepare external call handler */
-        larl %r1, external_new_code
-        stg %r1, 0x1b8
-        larl %r1, external_new_mask
-        mvc 0x1b0(8),0(%r1)
         /* load enabled wait PSW */
         larl %r1, enabled_wait_psw
         lpswe 0(%r1)
@@ -81,14 +82,9 @@ consume_sclp_int:
         .globl consume_io_int
 consume_io_int:
         /* enable I/O interrupts in cr6 */
-        stctg %c6,%c6,0(%r15)
-        oi    4(%r15), 0xff
-        lctlg %c6,%c6,0(%r15)
-        /* prepare i/o call handler */
-        larl  %r1, io_new_code
-        stg   %r1, 0x1f8
-        larl  %r1, io_new_mask
-        mvc   0x1f0(8),0(%r1)
+        stctg	%c6, %c6, 0(%r15)
+        oi	4(%r15), 0xff
+        lctlg	%c6, %c6, 0(%r15)
         /* load enabled wait PSW */
         larl  %r1, enabled_wait_psw
         lpswe 0(%r1)
@@ -112,7 +108,7 @@ disabled_wait_psw:
         .quad   PSW_MASK_DWAIT, 0x0000000000000000
 enabled_wait_psw:
         .quad   PSW_MASK_EWAIT, 0x0000000000000000
-external_new_mask:
-        .quad   PSW_MASK_64
-io_new_mask:
-        .quad   PSW_MASK_64
+external_new_psw:
+        .quad   PSW_MASK_64, external_new_code
+io_new_psw:
+        .quad   PSW_MASK_64, io_new_code
-- 
2.25.1


