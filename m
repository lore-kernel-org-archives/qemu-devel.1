Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9ECC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 03:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A2DD206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 03:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2DD206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVSkR-0005zk-9d
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 22:58:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farman@linux.ibm.com>) id 1iVSjl-0005YJ-SJ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 22:57:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farman@linux.ibm.com>) id 1iVSjk-0007R5-E0
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 22:57:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16278
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farman@linux.ibm.com>)
 id 1iVSjk-0007Qd-9l
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 22:57:32 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAF3YTb3117986
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 22:35:30 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2w9jtv6qgq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 22:35:29 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
 Fri, 15 Nov 2019 03:34:42 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 15 Nov 2019 03:34:39 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAF3Yc6W55115786
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Nov 2019 03:34:38 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4BCB5A4053;
 Fri, 15 Nov 2019 03:34:38 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 30E76A4051;
 Fri, 15 Nov 2019 03:34:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Fri, 15 Nov 2019 03:34:38 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id A2193E0248; Fri, 15 Nov 2019 04:34:37 +0100 (CET)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: [RFC PATCH v1 5/8] vfio-ccw: Add support for the schib region
Date: Fri, 15 Nov 2019 04:34:34 +0100
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115033437.37926-1-farman@linux.ibm.com>
References: <20191115033437.37926-1-farman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19111503-0028-0000-0000-000003B7041C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111503-0029-0000-0000-0000247A13B4
Message-Id: <20191115033437.37926-6-farman@linux.ibm.com>
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

The schib region can be used to obtain the latest SCHIB from the host
passthrough subchannel. Since the guest SCHIB is virtualized,
we currently only update the path related information so that the
guest is aware of any path related changes when it issues the
'stsch' instruction.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---

Notes:
    v0->v1: [EF]
     - Change various incarnations of "update chp status" to
       "handle_store", to reflect the STSCH instruction that will
       drive this code
     - Remove temporary variable for casting/testing purposes in
       s390_ccw_store(), and add a block comment of WHY its there.
     - Add a few comments to vfio_ccw_handle_store()

 hw/s390x/css.c              |  8 ++++--
 hw/s390x/s390-ccw.c         | 20 +++++++++++++
 hw/vfio/ccw.c               | 57 +++++++++++++++++++++++++++++++++++++
 include/hw/s390x/css.h      |  3 +-
 include/hw/s390x/s390-ccw.h |  1 +
 target/s390x/ioinst.c       |  3 +-
 6 files changed, 87 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 844caab408..6ee6a96d75 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1335,11 +1335,15 @@ static void copy_schib_to_guest(SCHIB *dest, const SCHIB *src)
     }
 }
 
-int css_do_stsch(SubchDev *sch, SCHIB *schib)
+IOInstEnding css_do_stsch(SubchDev *sch, SCHIB *schib)
 {
+    int ret = IOINST_CC_EXPECTED;
+
+    ret = s390_ccw_store(sch);
+
     /* Use current status. */
     copy_schib_to_guest(schib, &sch->curr_status);
-    return 0;
+    return ret;
 }
 
 static void copy_pmcw_from_guest(PMCW *dest, const PMCW *src)
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index 0c5a5b60bd..be0b379338 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -51,6 +51,26 @@ int s390_ccw_clear(SubchDev *sch)
     return cdc->handle_clear(sch);
 }
 
+IOInstEnding s390_ccw_store(SubchDev *sch)
+{
+    S390CCWDeviceClass *cdc = NULL;
+    int ret = IOINST_CC_EXPECTED;
+
+    /*
+     * This only applies to passthrough devices, so we can't unconditionally
+     * set this variable like we would for halt/clear.
+     */
+    if (object_dynamic_cast(OBJECT(sch->driver_data), TYPE_S390_CCW)) {
+        cdc = S390_CCW_DEVICE_GET_CLASS(sch->driver_data);
+    }
+
+    if (cdc && cdc->handle_store) {
+        ret = cdc->handle_store(sch);
+    }
+
+    return ret;
+}
+
 static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
                                   char *sysfsdev,
                                   Error **errp)
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 3e32bc1819..2ff223470f 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -41,6 +41,9 @@ struct VFIOCCWDevice {
     uint64_t async_cmd_region_size;
     uint64_t async_cmd_region_offset;
     struct ccw_cmd_region *async_cmd_region;
+    uint64_t schib_region_size;
+    uint64_t schib_region_offset;
+    struct ccw_schib_region *schib_region;
     EventNotifier io_notifier;
     bool force_orb_pfch;
     bool warned_orb_pfch;
@@ -124,6 +127,45 @@ again:
     }
 }
 
+static IOInstEnding vfio_ccw_handle_store(SubchDev *sch)
+{
+    S390CCWDevice *cdev = sch->driver_data;
+    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
+    SCHIB *schib = &sch->curr_status;
+    struct ccw_schib_region *region = vcdev->schib_region;
+    SCHIB *s = (SCHIB *)region->schib_area;
+    int ret;
+
+    /* schib region not available so nothing else to do */
+    if (!region) {
+        return IOINST_CC_EXPECTED;
+    }
+
+    memset(region, 0, sizeof(*region));
+    ret = pread(vcdev->vdev.fd, region, vcdev->schib_region_size,
+                vcdev->schib_region_offset);
+
+    if (ret == -1) {
+        /* Assume device is damaged, regardless of errno */
+        return IOINST_CC_NOT_OPERATIONAL;
+    }
+
+    /*
+     * Selectively copy path-related bits of the SCHIB,
+     * rather than copying the entire struct.
+     */
+    schib->pmcw.pnom = s->pmcw.pnom;
+    schib->pmcw.lpum = s->pmcw.lpum;
+    schib->pmcw.pam = s->pmcw.pam;
+    schib->pmcw.pom = s->pmcw.pom;
+
+    if (s->scsw.flags & SCSW_FLAGS_MASK_PNO) {
+        schib->scsw.flags |= SCSW_FLAGS_MASK_PNO;
+    }
+
+    return IOINST_CC_EXPECTED;
+}
+
 static int vfio_ccw_handle_clear(SubchDev *sch)
 {
     S390CCWDevice *cdev = sch->driver_data;
@@ -395,10 +437,23 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         vcdev->async_cmd_region = g_malloc0(info->size);
     }
 
+    ret = vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
+                                   VFIO_REGION_SUBTYPE_CCW_SCHIB, &info);
+    if (!ret) {
+        vcdev->schib_region_size = info->size;
+        if (sizeof(*vcdev->schib_region) != vcdev->schib_region_size) {
+            error_setg(errp, "vfio: Unexpected size of the schib region");
+            goto out_err;
+        }
+        vcdev->schib_region_offset = info->offset;
+        vcdev->schib_region = g_malloc(info->size);
+    }
+
     g_free(info);
     return;
 
 out_err:
+    g_free(vcdev->schib_region);
     g_free(vcdev->async_cmd_region);
     g_free(vcdev->io_region);
     g_free(info);
@@ -407,6 +462,7 @@ out_err:
 
 static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
 {
+    g_free(vcdev->schib_region);
     g_free(vcdev->async_cmd_region);
     g_free(vcdev->io_region);
 }
@@ -582,6 +638,7 @@ static void vfio_ccw_class_init(ObjectClass *klass, void *data)
     cdc->handle_request = vfio_ccw_handle_request;
     cdc->handle_halt = vfio_ccw_handle_halt;
     cdc->handle_clear = vfio_ccw_handle_clear;
+    cdc->handle_store = vfio_ccw_handle_store;
 }
 
 static const TypeInfo vfio_ccw_info = {
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index f46bcafb16..7e3a5e7433 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -218,6 +218,7 @@ IOInstEnding do_subchannel_work_passthrough(SubchDev *sub);
 
 int s390_ccw_halt(SubchDev *sch);
 int s390_ccw_clear(SubchDev *sch);
+IOInstEnding s390_ccw_store(SubchDev *sch);
 
 typedef enum {
     CSS_IO_ADAPTER_VIRTIO = 0,
@@ -242,7 +243,7 @@ SubchDev *css_find_subch(uint8_t m, uint8_t cssid, uint8_t ssid,
                          uint16_t schid);
 bool css_subch_visible(SubchDev *sch);
 void css_conditional_io_interrupt(SubchDev *sch);
-int css_do_stsch(SubchDev *sch, SCHIB *schib);
+IOInstEnding css_do_stsch(SubchDev *sch, SCHIB *schib);
 bool css_schid_final(int m, uint8_t cssid, uint8_t ssid, uint16_t schid);
 IOInstEnding css_do_msch(SubchDev *sch, const SCHIB *schib);
 IOInstEnding css_do_xsch(SubchDev *sch);
diff --git a/include/hw/s390x/s390-ccw.h b/include/hw/s390x/s390-ccw.h
index fffb54562f..4a43803ef2 100644
--- a/include/hw/s390x/s390-ccw.h
+++ b/include/hw/s390x/s390-ccw.h
@@ -37,6 +37,7 @@ typedef struct S390CCWDeviceClass {
     IOInstEnding (*handle_request) (SubchDev *sch);
     int (*handle_halt) (SubchDev *sch);
     int (*handle_clear) (SubchDev *sch);
+    IOInstEnding (*handle_store) (SubchDev *sch);
 } S390CCWDeviceClass;
 
 #endif
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index c437a1d8c6..63b4c84215 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -257,8 +257,7 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
     sch = css_find_subch(m, cssid, ssid, schid);
     if (sch) {
         if (css_subch_visible(sch)) {
-            css_do_stsch(sch, &schib);
-            cc = 0;
+            cc = css_do_stsch(sch, &schib);
         } else {
             /* Indicate no more subchannels in this css/ss */
             cc = 3;
-- 
2.17.1


