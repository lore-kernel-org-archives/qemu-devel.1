Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A580BC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 20:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7584821835
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 20:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7584821835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibsJJ-0008P4-BR
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 15:28:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farosas@linux.ibm.com>) id 1ibsHW-0006tO-0Y
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 15:26:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farosas@linux.ibm.com>) id 1ibsHU-00020f-MO
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 15:26:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15426)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
 id 1ibsHT-00020C-KB; Mon, 02 Dec 2019 15:26:51 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB2KD87b127373; Mon, 2 Dec 2019 15:26:48 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wn3pcr1qu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Dec 2019 15:26:48 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xB2KPRE1066770;
 Mon, 2 Dec 2019 15:26:47 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wn3pcr1q4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Dec 2019 15:26:47 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xB2KOq2H026035;
 Mon, 2 Dec 2019 20:26:46 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma04wdc.us.ibm.com with ESMTP id 2wkg26dw1j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Dec 2019 20:26:46 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xB2KQjWo55116052
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Dec 2019 20:26:45 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3D5578063;
 Mon,  2 Dec 2019 20:26:45 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9AEC78064;
 Mon,  2 Dec 2019 20:26:43 +0000 (GMT)
Received: from farosas.linux.ibm.com.ibmuc.com (unknown [9.85.134.103])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon,  2 Dec 2019 20:26:43 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: virtio-fs@redhat.com
Subject: [PATCH] virtiofs: Relax DAX window protection for ppc
Date: Mon,  2 Dec 2019 17:26:39 -0300
Message-Id: <20191202202639.102322-1-farosas@linux.ibm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_05:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 mlxscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912020173
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When setting up the DAX window during the virtiofs driver probe inside
the guest, the Linux arch-specific function arch_add_memory is called,
which on ppc tries to do a cache flush [1] of the recently added
memory. At this point the window is mmap'ed PROT_NONE by QEMU, which
causes the following:

<snip>
[   10.136703] virtio_fs virtio0: Cache len: 0x80000000 @ 0x210000000000
[   10.165106] radix-mmu: Mapped 0xc000210000000000-0xc000210080000000 with 1.00 GiB pages
error: kvm run failed Bad address
NIP c000000000072350   LR c000000000072304 CTR 0000000001000000 XER 0000000020040000 CPU#0
MSR 8000000002009033 HID0 0000000000000000  HF 8000000000000000 iidx 3 didx 3
TB 00000000 00000000 DECR 0
GPR00 c000000000072304 c0000000fa383100 c000000001190300 0000000000000000
GPR04 0000000000000001 0000000000000000 c0000000fa383208 0000000000000080
GPR08 c000210000000000 000000008000007f 0000000001000000 6874697720303030
<snip>

The problem is the same for the memory device removal path
(e.g. during filesystem unmount).

Since powerpc expects the memory to be accessible during device
addition/removal, this patch makes the DAX window readable at creation
and after virtio-fs unmap.

1 - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fb5924fd

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
---
 hw/virtio/vhost-user-fs.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 455e97beea..92958797d0 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -24,6 +24,16 @@
 #include "exec/address-spaces.h"
 #include "trace.h"
 
+/*
+ * The powerpc kernel code expects the memory to be accessible during
+ * addition/removal.
+ */
+#if defined(TARGET_PPC64) && defined(CONFIG_LINUX)
+#define DAX_WINDOW_PROT PROT_READ
+#else
+#define DAX_WINDOW_PROT PROT_NONE
+#endif
+
 uint64_t vhost_user_fs_slave_map(struct vhost_dev *dev, VhostUserFSSlaveMsg *sm,
                                  int fd)
 {
@@ -133,8 +143,8 @@ uint64_t vhost_user_fs_slave_unmap(struct vhost_dev *dev, VhostUserFSSlaveMsg *s
             continue;
         }
 
-        ptr = mmap(cache_host + sm->c_offset[i], sm->len[i],
-                PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
+        ptr = mmap(cache_host + sm->c_offset[i], sm->len[i], DAX_WINDOW_PROT,
+                   MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
         if (ptr != (cache_host + sm->c_offset[i])) {
             res = -errno;
             fprintf(stderr, "%s: mmap failed (%s) [%d] %"
@@ -485,8 +495,9 @@ static void vuf_device_realize(DeviceState *dev, Error **errp)
 
     if (fs->conf.cache_size) {
         /* Anonymous, private memory is not counted as overcommit */
-        cache_ptr = mmap(NULL, fs->conf.cache_size, PROT_NONE,
+        cache_ptr = mmap(NULL, fs->conf.cache_size, DAX_WINDOW_PROT,
                          MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+
         if (cache_ptr == MAP_FAILED) {
             error_setg(errp, "Unable to mmap blank cache");
             return;
-- 
2.23.0


