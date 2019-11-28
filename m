Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEC4C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 14:49:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A5702168B
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 14:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5702168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaL6w-0003yw-H8
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 09:49:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fiuczy@linux.ibm.com>) id 1iaKoU-0002wI-8f
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:30:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fiuczy@linux.ibm.com>) id 1iaKoP-0000AV-FQ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:30:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54102)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fiuczy@linux.ibm.com>)
 id 1iaKoP-0008T8-35
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:30:29 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xASETEeb088360
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 09:30:26 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wjaegmtmv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 09:30:26 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <fiuczy@linux.ibm.com>;
 Thu, 28 Nov 2019 14:30:24 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 28 Nov 2019 14:30:21 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xASEUKjZ63307992
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Nov 2019 14:30:20 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 650B15205F;
 Thu, 28 Nov 2019 14:30:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.152.222.65])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3689352052;
 Thu, 28 Nov 2019 14:30:20 +0000 (GMT)
From: Boris Fiuczynski <fiuczy@linux.ibm.com>
To: qemu-s390x@nongnu.org, cohuck@redhat.com, alex.williamson@redhat.com,
 farman@linux.ibm.com
Subject: [PATCH] vfio-ccw: Fix error message
Date: Thu, 28 Nov 2019 15:30:14 +0100
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112814-4275-0000-0000-0000038789DC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112814-4276-0000-0000-0000389B1C0B
Message-Id: <20191128143015.5231-1-fiuczy@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_03:2019-11-28,2019-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 phishscore=0 mlxlogscore=889 spamscore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911280126
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
---
 hw/vfio/ccw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 6863f6c69f..3b5520ae75 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -102,7 +102,7 @@ again:
         if (errno == EAGAIN) {
             goto again;
         }
-        error_report("vfio-ccw: wirte I/O region failed with errno=%d", errno);
+        error_report("vfio-ccw: write I/O region failed with errno=%d", errno);
         ret = -errno;
     } else {
         ret = region->ret_code;
-- 
2.17.0


