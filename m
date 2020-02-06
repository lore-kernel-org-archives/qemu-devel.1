Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A7AC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:47:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C36121775
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C36121775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izozE-0004YI-AM
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:47:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farman@linux.ibm.com>) id 1izoxa-0002tz-5G
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:45:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farman@linux.ibm.com>) id 1izoxY-0007CX-Kk
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:45:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65260)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farman@linux.ibm.com>)
 id 1izoxY-00079U-Ad
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:45:16 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 016LeQrD016621
 for <qemu-devel@nongnu.org>; Thu, 6 Feb 2020 16:45:15 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y0p3k1paq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 16:45:15 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
 Thu, 6 Feb 2020 21:45:13 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 6 Feb 2020 21:45:11 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 016Lj9BX590292
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Feb 2020 21:45:09 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 625794C050;
 Thu,  6 Feb 2020 21:45:09 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50CB34C044;
 Thu,  6 Feb 2020 21:45:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu,  6 Feb 2020 21:45:09 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 0E7CFE0278; Thu,  6 Feb 2020 22:45:09 +0100 (CET)
From: Eric Farman <farman@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: [RFC PATCH v2 2/7] linux-headers: update
Date: Thu,  6 Feb 2020 22:45:04 +0100
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206214509.16434-1-farman@linux.ibm.com>
References: <20200206214509.16434-1-farman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20020621-4275-0000-0000-0000039EA9CA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020621-4276-0000-0000-000038B2D855
Message-Id: <20200206214509.16434-3-farman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-06_04:2020-02-06,
 2020-02-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060158
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
Cc: Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Farhan Ali <alifm@linux.ibm.com>

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---

Notes:
    v1->v2: [EF]
     - Re-ran 3 February 2020 (based on kernel tag v5.5)
    v0->v1: [EF]
     - Run scripts/update-linux-headers.sh properly, but do not
       add resulting changes to linux-headers/asm-mips/

 include/standard-headers/linux/input.h |  1 +
 linux-headers/asm-arm64/unistd.h       |  1 +
 linux-headers/linux/vfio.h             |  3 +++
 linux-headers/linux/vfio_ccw.h         | 19 +++++++++++++++++++
 4 files changed, 24 insertions(+)

diff --git a/include/standard-headers/linux/input.h b/include/standard-headers/linux/input.h
index d8914f25a5..f89c986190 100644
--- a/include/standard-headers/linux/input.h
+++ b/include/standard-headers/linux/input.h
@@ -31,6 +31,7 @@ struct input_event {
 	unsigned long __sec;
 #if defined(__sparc__) && defined(__arch64__)
 	unsigned int __usec;
+	unsigned int __pad;
 #else
 	unsigned long __usec;
 #endif
diff --git a/linux-headers/asm-arm64/unistd.h b/linux-headers/asm-arm64/unistd.h
index 4703d21866..f83a70e07d 100644
--- a/linux-headers/asm-arm64/unistd.h
+++ b/linux-headers/asm-arm64/unistd.h
@@ -19,5 +19,6 @@
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_TIME32_SYSCALLS
+#define __ARCH_WANT_SYS_CLONE3
 
 #include <asm-generic/unistd.h>
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index fb10370d29..9e227348b3 100644
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
 
diff --git a/linux-headers/linux/vfio_ccw.h b/linux-headers/linux/vfio_ccw.h
index fcc3e69ef5..c56c1a621c 100644
--- a/linux-headers/linux/vfio_ccw.h
+++ b/linux-headers/linux/vfio_ccw.h
@@ -34,4 +34,23 @@ struct ccw_cmd_region {
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
+	__u32 crw0;
+	__u32 crw1;
+} __attribute__((packed));
+
 #endif
-- 
2.17.1


