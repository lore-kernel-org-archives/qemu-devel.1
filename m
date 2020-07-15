Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6E2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20107205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20107205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvi5w-0004cO-Eu
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 10:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jvi5I-0003qs-Sh
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 10:08:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31974
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jvi5H-0007rW-8e
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 10:08:32 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06FE2SiE105451
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 10:08:30 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 329apxmwpk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 10:08:29 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06FE3Ckl108728
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 10:08:29 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 329apxmwnt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2020 10:08:29 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06FE67af032500;
 Wed, 15 Jul 2020 14:08:27 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma04ams.nl.ibm.com with ESMTP id 329nmygqf4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2020 14:08:27 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06FE8Pjk50135108
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jul 2020 14:08:25 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 67EC942049;
 Wed, 15 Jul 2020 14:08:25 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C045642045;
 Wed, 15 Jul 2020 14:08:24 +0000 (GMT)
Received: from linux01.pok.stglabs.ibm.com (unknown [9.114.17.81])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 15 Jul 2020 14:08:24 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] pc-bios: s390x: Add a comment to the io and external new PSW
 setup
Date: Wed, 15 Jul 2020 10:08:20 -0400
Message-Id: <20200715140820.3401-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <033b0db7-7b7d-6eb0-9018-bcc342f13509@de.ibm.com>
References: <033b0db7-7b7d-6eb0-9018-bcc342f13509@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-15_11:2020-07-15,
 2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=944
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=1 mlxscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007150111
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 09:18:04
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

Normally they don't need to be set up before waiting for an interrupt
but are set up on boot. The BIOS however might overwrite the lowcore
(and hence the PSWs) when loading a blob into memory and therefore
needs to set up those PSWs more often.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 pc-bios/s390-ccw/start.S | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
index 01c4c21b26..b0fcb918cc 100644
--- a/pc-bios/s390-ccw/start.S
+++ b/pc-bios/s390-ccw/start.S
@@ -64,7 +64,10 @@ consume_sclp_int:
         stctg   %c0,%c0,0(%r15)
         oi      6(%r15),0x2
         lctlg   %c0,%c0,0(%r15)
-        /* prepare external call handler */
+        /*
+         * Prepare external new PSW as it might have been overwritten
+         * by a loaded blob
+         */
         larl %r1, external_new_code
         stg %r1, 0x1b8
         larl %r1, external_new_mask
@@ -84,7 +87,10 @@ consume_io_int:
         stctg %c6,%c6,0(%r15)
         oi    4(%r15), 0xff
         lctlg %c6,%c6,0(%r15)
-        /* prepare i/o call handler */
+        /*
+         * Prepare i/o new PSW as it might have been overwritten
+         * by a loaded blob
+         */
         larl  %r1, io_new_code
         stg   %r1, 0x1f8
         larl  %r1, io_new_mask
-- 
2.25.1


