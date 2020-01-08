Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5853C33CA2
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 16:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B9E206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 16:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B9E206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipDwb-0002ky-B2
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 11:12:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.ibm.com>) id 1ipDua-0000XS-SZ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 11:10:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.ibm.com>) id 1ipDuZ-0000qK-O5
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 11:10:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29084)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
 id 1ipDuZ-0000pF-Fi; Wed, 08 Jan 2020 11:10:23 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 008G7roq146587; Wed, 8 Jan 2020 11:10:19 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xcu57tama-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2020 11:10:19 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 008G7rII146602;
 Wed, 8 Jan 2020 11:10:18 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xcu57takn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2020 11:10:18 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 008GA0IF010579;
 Wed, 8 Jan 2020 16:10:17 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma04dal.us.ibm.com with ESMTP id 2xajb6y7ar-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2020 16:10:17 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 008GAGEu51839294
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jan 2020 16:10:16 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C1426A04F;
 Wed,  8 Jan 2020 16:10:16 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE04B6A057;
 Wed,  8 Jan 2020 16:10:15 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed,  8 Jan 2020 16:10:15 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v8 2/6] spapr: Implement get_dt_compatible() callback
Date: Wed,  8 Jan 2020 11:10:08 -0500
Message-Id: <20200108161012.1821385-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108161012.1821385-1-stefanb@linux.ibm.com>
References: <20200108161012.1821385-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-08_04:2020-01-08,
 2020-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015
 bulkscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=1
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001080132
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
Cc: marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.ibm.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Berger <stefanb@linux.vnet.ibm.com>

For devices that cannot be statically initialized, implement a
get_dt_compatible() callback that allows us to ask the device for
the 'compatible' value.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/ppc/spapr_vio.c         | 11 +++++++++--
 include/hw/ppc/spapr_vio.h |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 554de9930d..4b24b81797 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -87,6 +87,7 @@ static int vio_make_devnode(SpaprVioDevice *dev,
     SpaprVioDeviceClass *pc = VIO_SPAPR_DEVICE_GET_CLASS(dev);
     int vdevice_off, node_off, ret;
     char *dt_name;
+    const char *dt_compatible;
 
     vdevice_off = fdt_path_offset(fdt, "/vdevice");
     if (vdevice_off < 0) {
@@ -113,9 +114,15 @@ static int vio_make_devnode(SpaprVioDevice *dev,
         }
     }
 
-    if (pc->dt_compatible) {
+    if (pc->get_dt_compatible) {
+        dt_compatible = pc->get_dt_compatible(dev);
+    } else {
+        dt_compatible = pc->dt_compatible;
+    }
+
+    if (dt_compatible) {
         ret = fdt_setprop_string(fdt, node_off, "compatible",
-                                 pc->dt_compatible);
+                                 dt_compatible);
         if (ret < 0) {
             return ret;
         }
diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
index 72762ed16b..67f58b7f98 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -58,6 +58,7 @@ typedef struct SpaprVioDeviceClass {
     void (*realize)(SpaprVioDevice *dev, Error **errp);
     void (*reset)(SpaprVioDevice *dev);
     int (*devnode)(SpaprVioDevice *dev, void *fdt, int node_off);
+    const char *(*get_dt_compatible)(SpaprVioDevice *dev);
 } SpaprVioDeviceClass;
 
 struct SpaprVioDevice {
-- 
2.24.1


