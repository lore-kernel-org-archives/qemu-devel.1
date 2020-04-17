Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E46C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 02:40:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 585B2221E8
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 02:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 585B2221E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPGvP-0001aW-Hm
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 22:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farman@linux.ibm.com>) id 1jPGqA-0003am-Ql
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 22:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farman@linux.ibm.com>) id 1jPGq9-0002FQ-3w
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 22:34:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4824
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farman@linux.ibm.com>)
 id 1jPGq8-0002DG-W6
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 22:34:49 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03H2YGaF002202
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 22:34:46 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30f198khs4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 22:34:46 -0400
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
 03H2YeCX49217550
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Apr 2020 02:34:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DAE5942049;
 Fri, 17 Apr 2020 02:34:40 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C21ED42041;
 Fri, 17 Apr 2020 02:34:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Fri, 17 Apr 2020 02:34:40 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 718F3E0271; Fri, 17 Apr 2020 04:34:40 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v3 1/7] linux-headers: update
Date: Fri, 17 Apr 2020 04:34:34 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417023440.70514-1-farman@linux.ibm.com>
References: <20200417023440.70514-1-farman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20041702-0008-0000-0000-0000037214BA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041702-0009-0000-0000-00004A93CEA1
Message-Id: <20200417023440.70514-2-farman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-16_10:2020-04-14,
 2020-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004170014
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---

Notes:
    v2->v3: [EF]
     - Re-ran 16 April 2020 (based on kernel tag v5.6, and limited to
       bits interesting to this series)
    
    v1->v2: [EF]
     - Re-ran 3 February 2020 (based on kernel tag v5.5)
    
    v0->v1: [EF]
     - Run scripts/update-linux-headers.sh properly, but do not
       add resulting changes to linux-headers/asm-mips/

 linux-headers/linux/vfio.h     | 40 ++++++++++++++++++++++++++++++++++
 linux-headers/linux/vfio_ccw.h | 18 +++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index fb10370d29..9c8d889551 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -378,6 +378,8 @@ struct vfio_region_gfx_edid {
 
 /* sub-types for VFIO_REGION_TYPE_CCW */
 #define VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD	(1)
+#define VFIO_REGION_SUBTYPE_CCW_SCHIB		(2)
+#define VFIO_REGION_SUBTYPE_CCW_CRW		(3)
 
 /*
  * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
@@ -577,6 +579,7 @@ enum {
 
 enum {
 	VFIO_CCW_IO_IRQ_INDEX,
+	VFIO_CCW_CRW_IRQ_INDEX,
 	VFIO_CCW_NUM_IRQS
 };
 
@@ -707,6 +710,43 @@ struct vfio_device_ioeventfd {
 
 #define VFIO_DEVICE_IOEVENTFD		_IO(VFIO_TYPE, VFIO_BASE + 16)
 
+/**
+ * VFIO_DEVICE_FEATURE - _IORW(VFIO_TYPE, VFIO_BASE + 17,
+ *			       struct vfio_device_feature)
+ *
+ * Get, set, or probe feature data of the device.  The feature is selected
+ * using the FEATURE_MASK portion of the flags field.  Support for a feature
+ * can be probed by setting both the FEATURE_MASK and PROBE bits.  A probe
+ * may optionally include the GET and/or SET bits to determine read vs write
+ * access of the feature respectively.  Probing a feature will return success
+ * if the feature is supported and all of the optionally indicated GET/SET
+ * methods are supported.  The format of the data portion of the structure is
+ * specific to the given feature.  The data portion is not required for
+ * probing.  GET and SET are mutually exclusive, except for use with PROBE.
+ *
+ * Return 0 on success, -errno on failure.
+ */
+struct vfio_device_feature {
+	__u32	argsz;
+	__u32	flags;
+#define VFIO_DEVICE_FEATURE_MASK	(0xffff) /* 16-bit feature index */
+#define VFIO_DEVICE_FEATURE_GET		(1 << 16) /* Get feature into data[] */
+#define VFIO_DEVICE_FEATURE_SET		(1 << 17) /* Set feature from data[] */
+#define VFIO_DEVICE_FEATURE_PROBE	(1 << 18) /* Probe feature support */
+	__u8	data[];
+};
+
+#define VFIO_DEVICE_FEATURE		_IO(VFIO_TYPE, VFIO_BASE + 17)
+
+/*
+ * Provide support for setting a PCI VF Token, which is used as a shared
+ * secret between PF and VF drivers.  This feature may only be set on a
+ * PCI SR-IOV PF when SR-IOV is enabled on the PF and there are no existing
+ * open VFs.  Data provided when setting this feature is a 16-byte array
+ * (__u8 b[16]), representing a UUID.
+ */
+#define VFIO_DEVICE_FEATURE_PCI_VF_TOKEN	(0)
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
diff --git a/linux-headers/linux/vfio_ccw.h b/linux-headers/linux/vfio_ccw.h
index fcc3e69ef5..237fd5a618 100644
--- a/linux-headers/linux/vfio_ccw.h
+++ b/linux-headers/linux/vfio_ccw.h
@@ -34,4 +34,22 @@ struct ccw_cmd_region {
 	__u32 ret_code;
 } __attribute__((packed));
 
+/*
+ * Used for processing commands that read the subchannel-information block
+ * Reading this region triggers a stsch() to hardware
+ * Note: this is controlled by a capability
+ */
+struct ccw_schib_region {
+#define SCHIB_AREA_SIZE 52
+	__u8 schib_area[SCHIB_AREA_SIZE];
+} __attribute__((packed));
+
+/*
+ * Used for returning Channel Report Word(s) to userspace.
+ * Note: this is controlled by a capability
+ */
+struct ccw_crw_region {
+	__u32 crw;
+} __attribute__((packed));
+
 #endif
-- 
2.17.1


