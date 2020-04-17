Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF803C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 02:35:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A55221E8
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 02:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A55221E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPGrG-0004Zx-PY
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 22:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farman@linux.ibm.com>) id 1jPGq9-0003aa-O8
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 22:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farman@linux.ibm.com>) id 1jPGq8-0002Ep-Hk
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 22:34:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55102)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farman@linux.ibm.com>)
 id 1jPGq8-0002Df-9h
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 22:34:48 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03H2XO6s003236
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 22:34:47 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30et5xr9tc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 22:34:47 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
 Fri, 17 Apr 2020 03:34:15 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 17 Apr 2020 03:34:13 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 03H2YeVg59441192
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Apr 2020 02:34:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6FFE42045;
 Fri, 17 Apr 2020 02:34:40 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C3CE842042;
 Fri, 17 Apr 2020 02:34:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Fri, 17 Apr 2020 02:34:40 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 7421CE02A3; Fri, 17 Apr 2020 04:34:40 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v3 2/7] vfio-ccw: Refactor cleanup of regions
Date: Fri, 17 Apr 2020 04:34:35 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417023440.70514-1-farman@linux.ibm.com>
References: <20200417023440.70514-1-farman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20041702-0008-0000-0000-0000037214B9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041702-0009-0000-0000-00004A93CEA0
Message-Id: <20200417023440.70514-3-farman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-16_10:2020-04-14,
 2020-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=916
 priorityscore=1501 malwarescore=0 suspectscore=2 mlxscore=0 spamscore=0
 impostorscore=0 adultscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004170019
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While we're at it, add a g_free() for the async_cmd_region that
is the last thing currently created.  g_free() knows how to handle
NULL pointers, so this makes it easier to remember what cleanups
need to be performed when new regions are added.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---

Notes:
    v1-v2:
     - Add Conny's r-b

 hw/vfio/ccw.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 50cc2ec75c..ae9e396367 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -370,8 +370,7 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
     vcdev->io_region_size = info->size;
     if (sizeof(*vcdev->io_region) != vcdev->io_region_size) {
         error_setg(errp, "vfio: Unexpected size of the I/O region");
-        g_free(info);
-        return;
+        goto out_err;
     }
 
     vcdev->io_region_offset = info->offset;
@@ -384,15 +383,20 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         vcdev->async_cmd_region_size = info->size;
         if (sizeof(*vcdev->async_cmd_region) != vcdev->async_cmd_region_size) {
             error_setg(errp, "vfio: Unexpected size of the async cmd region");
-            g_free(vcdev->io_region);
-            g_free(info);
-            return;
+            goto out_err;
         }
         vcdev->async_cmd_region_offset = info->offset;
         vcdev->async_cmd_region = g_malloc0(info->size);
     }
 
     g_free(info);
+    return;
+
+out_err:
+    g_free(vcdev->async_cmd_region);
+    g_free(vcdev->io_region);
+    g_free(info);
+    return;
 }
 
 static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
-- 
2.17.1


