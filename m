Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAC3C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:30:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4A162063A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A162063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwMhd-0007RT-Uf
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 05:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1jwMgm-00067f-Eg
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 05:29:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42320)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1jwMgj-0004Gt-GV
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 05:29:56 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06H92pk5124719
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 05:29:52 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32afd7dkpd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 05:29:51 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06H93Txt127543
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 05:29:51 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32afd7dknj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2020 05:29:51 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06H9BSLf031530;
 Fri, 17 Jul 2020 09:29:49 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma03ams.nl.ibm.com with ESMTP id 327527xhvs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2020 09:29:49 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06H9Tkwl10748160
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jul 2020 09:29:46 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD3A8AE051;
 Fri, 17 Jul 2020 09:29:46 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65DE3AE056;
 Fri, 17 Jul 2020 09:29:46 +0000 (GMT)
Received: from marcibm.ibmuc.com (unknown [9.145.17.123])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 17 Jul 2020 09:29:46 +0000 (GMT)
From: Marc Hartmayer <mhartmay@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Subject: [RFC v2 3/3] libvhost-user: fence legacy virtio devices
Date: Fri, 17 Jul 2020 11:29:29 +0200
Message-Id: <20200717092929.19453-4-mhartmay@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717092929.19453-1-mhartmay@linux.ibm.com>
References: <20200717092929.19453-1-mhartmay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-17_04:2020-07-17,
 2020-07-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 suspectscore=1 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007170070
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mhartmay@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 05:29:52
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

libvhost-user has no support for legacy virtio devices therefore
let's fence them.

Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
---
 contrib/libvhost-user/libvhost-access.h | 10 ++++++++++
 contrib/libvhost-user/libvhost-user.c   |  6 ++++++
 2 files changed, 16 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-access.h b/contrib/libvhost-user/libvhost-access.h
index 868ba3e7bfb8..aa505ea1ec02 100644
--- a/contrib/libvhost-user/libvhost-access.h
+++ b/contrib/libvhost-user/libvhost-access.h
@@ -1,11 +1,21 @@
 #ifndef LIBVHOST_ACCESS_H
 
+#include <assert.h>
+
 #include "qemu/bswap.h"
 
 #include "libvhost-user.h"
 
+static inline bool vu_has_feature(VuDev *dev, unsigned int fbit);
+
 static inline bool vu_access_is_big_endian(VuDev *dev)
 {
+    /*
+     * TODO: can probably be removed as the fencing is already done in
+     * `vu_set_features_exec`
+     */
+    assert(vu_has_feature(dev, VIRTIO_F_VERSION_1));
+
     /* Devices conforming to VIRTIO 1.0 or later are always LE. */
     return false;
 }
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 0214b04c5291..93c4503b1f53 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -540,6 +540,12 @@ vu_set_features_exec(VuDev *dev, VhostUserMsg *vmsg)
     DPRINT("u64: 0x%016"PRIx64"\n", vmsg->payload.u64);
 
     dev->features = vmsg->payload.u64;
+    if (!vu_has_feature(dev, VIRTIO_F_VERSION_1)) {
+        /* We only support devices conforming to VIRTIO 1.0 or
+         * later */
+        vu_panic(dev, "virtio legacy devices aren't supported by libvhost-user");
+        return false;
+    }
 
     if (!(dev->features & VHOST_USER_F_PROTOCOL_FEATURES)) {
         vu_set_enable_all_rings(dev, true);
-- 
2.25.4


