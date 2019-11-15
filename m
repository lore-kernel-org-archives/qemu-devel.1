Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03F3C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 03:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 751A0206D3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 03:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751A0206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVSR9-0006RK-I2
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 22:38:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farman@linux.ibm.com>) id 1iVSQH-0005Z0-26
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 22:37:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farman@linux.ibm.com>) id 1iVSQF-0003pr-VD
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 22:37:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17234
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farman@linux.ibm.com>)
 id 1iVSQF-0003pj-Qr
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 22:37:23 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAF3YTpK117994
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 22:37:23 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2w9jtv6qgf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 22:37:22 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
 Fri, 15 Nov 2019 03:34:42 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 15 Nov 2019 03:34:39 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAF3YceO53280838
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Nov 2019 03:34:38 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 514984C044;
 Fri, 15 Nov 2019 03:34:38 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D2FD4C04E;
 Fri, 15 Nov 2019 03:34:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Fri, 15 Nov 2019 03:34:38 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id A4976E0285; Fri, 15 Nov 2019 04:34:37 +0100 (CET)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: [RFC PATCH v1 6/8] vfio-ccw: Add support for the crw region
Date: Fri, 15 Nov 2019 04:34:35 +0100
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115033437.37926-1-farman@linux.ibm.com>
References: <20191115033437.37926-1-farman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19111503-0028-0000-0000-000003B7041B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111503-0029-0000-0000-0000247A13B5
Message-Id: <20191115033437.37926-7-farman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-14_07:2019-11-14,2019-11-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=2
 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911150029
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Farhan Ali <alifm@linux.ibm.com>

The crw region can be used to obtain information about
Channel Report Words (CRW) from vfio-ccw driver.

Currently only channel path related CRWs are passed to
QEMU from vfio-ccw driver.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---

Notes:
    v0->v1: [EF]
     - Fixed copy/paste error in error message (s/schib/CRW)

 hw/vfio/ccw.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 2ff223470f..2b1a83b94c 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -44,6 +44,9 @@ struct VFIOCCWDevice {
     uint64_t schib_region_size;
     uint64_t schib_region_offset;
     struct ccw_schib_region *schib_region;
+    uint64_t crw_region_size;
+    uint64_t crw_region_offset;
+    struct ccw_crw_region *crw_region;
     EventNotifier io_notifier;
     bool force_orb_pfch;
     bool warned_orb_pfch;
@@ -449,10 +452,24 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         vcdev->schib_region = g_malloc(info->size);
     }
 
+    ret = vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
+                                   VFIO_REGION_SUBTYPE_CCW_CRW, &info);
+
+    if (!ret) {
+        vcdev->crw_region_size = info->size;
+        if (sizeof(*vcdev->crw_region) != vcdev->crw_region_size) {
+            error_setg(errp, "vfio: Unexpected size of the CRW region");
+            goto out_err;
+        }
+        vcdev->crw_region_offset = info->offset;
+        vcdev->crw_region = g_malloc(info->size);
+    }
+
     g_free(info);
     return;
 
 out_err:
+    g_free(vcdev->crw_region);
     g_free(vcdev->schib_region);
     g_free(vcdev->async_cmd_region);
     g_free(vcdev->io_region);
@@ -462,6 +479,7 @@ out_err:
 
 static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
 {
+    g_free(vcdev->crw_region);
     g_free(vcdev->schib_region);
     g_free(vcdev->async_cmd_region);
     g_free(vcdev->io_region);
-- 
2.17.1


