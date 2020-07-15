Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9707BC433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:43:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C2522064B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2522064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvdwL-0001ZY-JT
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 05:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jvdun-0008GH-Vx
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 05:41:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27440)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jvdum-0006Fz-6y
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 05:41:25 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06F9Y2VZ019932
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 05:41:22 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32991ffut2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 05:41:22 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06F9cZKN045706
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 05:41:22 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32991ffus7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2020 05:41:22 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06F9bN4r031494;
 Wed, 15 Jul 2020 09:41:20 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma06ams.nl.ibm.com with ESMTP id 3274pgv57b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2020 09:41:19 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 06F9dtsn65339660
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jul 2020 09:39:55 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0E8F4C058;
 Wed, 15 Jul 2020 09:41:17 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A24A4C04E;
 Wed, 15 Jul 2020 09:41:17 +0000 (GMT)
Received: from linux01.pok.stglabs.ibm.com (unknown [9.114.17.81])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 15 Jul 2020 09:41:16 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] pc-bios: s390x: Remove unneeded dasd-ipl.c reset psw mask
 changes
Date: Wed, 15 Jul 2020 05:40:41 -0400
Message-Id: <20200715094045.381984-4-frankja@linux.ibm.com>
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
 mlxlogscore=999
 suspectscore=1 spamscore=0 impostorscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150077
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 05:41:23
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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

jump_to_low_kernel() and the functions that it calls will already or
64 bit addressing into the reset psw mask when executing
jump_to_IPL_2() after the diag308 subcode 1.

The kernel proper is then branched to rather than doing a full PSW
change.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 pc-bios/s390-ccw/dasd-ipl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/pc-bios/s390-ccw/dasd-ipl.c b/pc-bios/s390-ccw/dasd-ipl.c
index 0fc879bb8e..e8f2846740 100644
--- a/pc-bios/s390-ccw/dasd-ipl.c
+++ b/pc-bios/s390-ccw/dasd-ipl.c
@@ -206,7 +206,6 @@ static void run_ipl2(SubChannelId schid, uint16_t cutype, uint32_t addr)
  */
 void dasd_ipl(SubChannelId schid, uint16_t cutype)
 {
-    PSWLegacy *pswl = (PSWLegacy *) 0x00;
     uint32_t ipl2_addr;
 
     /* Construct Read IPL CCW and run it to read IPL1 from boot disk */
@@ -229,7 +228,5 @@ void dasd_ipl(SubChannelId schid, uint16_t cutype)
     run_ipl2(schid, cutype, ipl2_addr);
 
     /* Transfer control to the guest operating system */
-    pswl->mask |= PSW_MASK_EAMODE;   /* Force z-mode */
-    pswl->addr |= PSW_MASK_BAMODE;   /* ...          */
     jump_to_low_kernel();
 }
-- 
2.25.1


