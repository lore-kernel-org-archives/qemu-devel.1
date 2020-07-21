Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A0AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 10:32:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBB3C20771
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 10:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB3C20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxpZw-0004J3-TO
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 06:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@de.ibm.com>)
 id 1jxpZF-0003rT-O9; Tue, 21 Jul 2020 06:32:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@de.ibm.com>)
 id 1jxpZE-0003iw-0l; Tue, 21 Jul 2020 06:32:13 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06LA3US8028739; Tue, 21 Jul 2020 06:32:08 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32d5h8m6ud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2020 06:32:07 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06LA3d99029577;
 Tue, 21 Jul 2020 06:32:07 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32d5h8m6tq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2020 06:32:07 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06LAVQQQ022284;
 Tue, 21 Jul 2020 10:32:05 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma04wdc.us.ibm.com with ESMTP id 32brq921uu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2020 10:32:05 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06LAW21464749868
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jul 2020 10:32:02 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8CD0AC6057;
 Tue, 21 Jul 2020 10:32:04 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 083E7C605D;
 Tue, 21 Jul 2020 10:32:03 +0000 (GMT)
Received: from est4106.pok.stglabs.ibm.com (unknown [9.114.17.106])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 21 Jul 2020 10:32:03 +0000 (GMT)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 1/1] s390x/protvirt: allow to IPL secure execution guests with
 -no-reboot
Date: Tue, 21 Jul 2020 06:32:02 -0400
Message-Id: <20200721103202.30610-1-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-21_03:2020-07-21,
 2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007210070
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@de.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 06:32:08
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Right now -no-reboot does prevent secure execution guests from running.
This is right from an implementation aspect, as we have modeled the
transition from non-secure to secure as a program directed IPL.
From a user perspective, this is not the behavior of least surprise.

We should implement the IPL into secure mode similar to the functions
that we use for kdump/kexec. In other words we do not stop here when
-no-reboot is specified on the command line. Like function 0 or function
1 Function 10 is not a classic reboot. For example it can only be called
once. To call it a 2nd time a real reboot/reset must happen in-between.
So function code 10 is more or less a state transition reset, but not a
"standard" reset or reboot.

Fixes: 4d226deafc44 ("s390x: protvirt: Support unpack facility")
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/ipl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index ce21494c08..e312a35133 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -633,7 +633,8 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
         }
     }
     if (reset_type == S390_RESET_MODIFIED_CLEAR ||
-        reset_type == S390_RESET_LOAD_NORMAL) {
+        reset_type == S390_RESET_LOAD_NORMAL ||
+        reset_type == S390_RESET_PV) {
         /* ignore -no-reboot, send no event  */
         qemu_system_reset_request(SHUTDOWN_CAUSE_SUBSYSTEM_RESET);
     } else {
-- 
2.25.1


