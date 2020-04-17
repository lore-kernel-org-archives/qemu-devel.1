Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA377C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 20:38:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A91F20656
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 20:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A91F20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPXl2-0004wK-Lf
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 16:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42707)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jrossi@linux.ibm.com>) id 1jPVqp-0007gZ-SL
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 14:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jrossi@linux.ibm.com>) id 1jPVqo-0001fg-MB
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 14:36:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63044)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jrossi@linux.ibm.com>)
 id 1jPVqo-0001em-G7; Fri, 17 Apr 2020 14:36:30 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03HIXDUQ070590; Fri, 17 Apr 2020 14:36:30 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30fgc0adbj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Apr 2020 14:36:29 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03HIXOFA071143;
 Fri, 17 Apr 2020 14:36:29 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30fgc0adb7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Apr 2020 14:36:29 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03HITjYw003256;
 Fri, 17 Apr 2020 18:36:27 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma01dal.us.ibm.com with ESMTP id 30b5h7sc5t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Apr 2020 18:36:27 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 03HIaQKW52560230
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Apr 2020 18:36:26 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6285EC605A;
 Fri, 17 Apr 2020 18:36:26 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A4AA9C6057;
 Fri, 17 Apr 2020 18:36:25 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.151.210])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 17 Apr 2020 18:36:25 +0000 (GMT)
From: Jared Rossi <jrossi@linux.ibm.com>
To: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 1/1] vfio-ccw: Enable transparent CCW IPL from DASD
Date: Fri, 17 Apr 2020 14:38:38 -0400
Message-Id: <20200417183838.11796-2-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200417183838.11796-1-jrossi@linux.ibm.com>
References: <20200417183838.11796-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-17_08:2020-04-17,
 2020-04-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004170142
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
X-Mailman-Approved-At: Fri, 17 Apr 2020 16:37:31 -0400
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove the explicit prefetch check when using vfio-ccw devices.
This check is not needed as all Linux channel programs are intended
to use prefetch and will be executed in the same way regardless.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 hw/vfio/ccw.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 50cc2ec75c..e649377b68 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -74,16 +74,9 @@ static IOInstEnding vfio_ccw_handle_request(SubchDev *sch)
     struct ccw_io_region *region = vcdev->io_region;
     int ret;
 
-    if (!(sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH)) {
-        if (!(vcdev->force_orb_pfch)) {
-            warn_once_pfch(vcdev, sch, "requires PFCH flag set");
-            sch_gen_unit_exception(sch);
-            css_inject_io_interrupt(sch);
-            return IOINST_CC_EXPECTED;
-        } else {
-            sch->orb.ctrl0 |= ORB_CTRL0_MASK_PFCH;
-            warn_once_pfch(vcdev, sch, "PFCH flag forced");
-        }
+    if (!(sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH) && vcdev->force_orb_pfch) {
+        sch->orb.ctrl0 |= ORB_CTRL0_MASK_PFCH;
+        warn_once_pfch(vcdev, sch, "PFCH flag forced");
     }
 
     QEMU_BUILD_BUG_ON(sizeof(region->orb_area) != sizeof(ORB));
-- 
2.21.1


