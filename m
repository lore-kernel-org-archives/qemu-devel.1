Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62CFC76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:08:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB7562239F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7562239F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpyGn-0002bA-Kb
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 13:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43340)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hpyBN-000820-Q7
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:02:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hpyBM-0006FI-EC
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:02:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23904
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hpyBM-0005qQ-7o; Tue, 23 Jul 2019 13:02:32 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6NH20Nm111583; Tue, 23 Jul 2019 13:02:10 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tx6110kwj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2019 13:02:09 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x6NH27eQ112194;
 Tue, 23 Jul 2019 13:02:07 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tx6110k6j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2019 13:02:07 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6NH0KHM032278;
 Tue, 23 Jul 2019 17:01:28 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma04dal.us.ibm.com with ESMTP id 2tx61mr2gx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2019 17:01:28 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6NH1R1m54264078
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2019 17:01:27 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD84FBE054;
 Tue, 23 Jul 2019 17:01:26 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1212BE063;
 Tue, 23 Jul 2019 17:01:26 +0000 (GMT)
Received: from localhost (unknown [9.53.179.212])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jul 2019 17:01:26 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Jul 2019 12:01:04 -0500
Message-Id: <20190723170104.4327-37-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
References: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-23_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907230170
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH 36/36] vhost: fix vhost_log size overflow
 during migration
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
Cc: Li Hangjing <lihangjing@baidu.com>, qemu-stable@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Hangjing <lihangjing@baidu.com>

When a guest which doesn't support multiqueue is migrated with a multi queues
vhost-user-blk deivce, a crash will occur like:

0 qemu_memfd_alloc (name=<value optimized out>, size=562949953421312, seals=<value optimized out>, fd=0x7f87171fe8b4, errp=0x7f87171fe8a8) at util/memfd.c:153
1 0x00007f883559d7cf in vhost_log_alloc (size=70368744177664, share=true) at hw/virtio/vhost.c:186
2 0x00007f88355a0758 in vhost_log_get (listener=0x7f8838bd7940, enable=1) at qemu-2-12/hw/virtio/vhost.c:211
3 vhost_dev_log_resize (listener=0x7f8838bd7940, enable=1) at hw/virtio/vhost.c:263
4 vhost_migration_log (listener=0x7f8838bd7940, enable=1) at hw/virtio/vhost.c:787
5 0x00007f88355463d6 in memory_global_dirty_log_start () at memory.c:2503
6 0x00007f8835550577 in ram_init_bitmaps (f=0x7f88384ce600, opaque=0x7f8836024098) at migration/ram.c:2173
7 ram_init_all (f=0x7f88384ce600, opaque=0x7f8836024098) at migration/ram.c:2192
8 ram_save_setup (f=0x7f88384ce600, opaque=0x7f8836024098) at migration/ram.c:2219
9 0x00007f88357a419d in qemu_savevm_state_setup (f=0x7f88384ce600) at migration/savevm.c:1002
10 0x00007f883579fc3e in migration_thread (opaque=0x7f8837530400) at migration/migration.c:2382
11 0x00007f8832447893 in start_thread () from /lib64/libpthread.so.0
12 0x00007f8832178bfd in clone () from /lib64/libc.so.6

This is because vhost_get_log_size() returns a overflowed vhost-log size.
In this function, it uses the uninitialized variable vqs->used_phys and
vqs->used_size to get the vhost-log size.

Signed-off-by: Li Hangjing <lihangjing@baidu.com>
Reviewed-by: Xie Yongji <xieyongji@baidu.com>
Reviewed-by: Chai Wen <chaiwen@baidu.com>
Message-Id: <20190603061524.24076-1-lihangjing@baidu.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 240e647a14df9677b3a501f7b8b870e40aac3fd5)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/vhost.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 569c4053ea..be38b39242 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -131,6 +131,11 @@ static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
     }
     for (i = 0; i < dev->nvqs; ++i) {
         struct vhost_virtqueue *vq = dev->vqs + i;
+
+        if (!vq->used_phys && !vq->used_size) {
+            continue;
+        }
+
         vhost_dev_sync_region(dev, section, start_addr, end_addr, vq->used_phys,
                               range_get_last(vq->used_phys, vq->used_size));
     }
@@ -168,6 +173,11 @@ static uint64_t vhost_get_log_size(struct vhost_dev *dev)
     }
     for (i = 0; i < dev->nvqs; ++i) {
         struct vhost_virtqueue *vq = dev->vqs + i;
+
+        if (!vq->used_phys && !vq->used_size) {
+            continue;
+        }
+
         uint64_t last = vq->used_phys + vq->used_size - 1;
         log_size = MAX(log_size, last / VHOST_LOG_CHUNK + 1);
     }
-- 
2.17.1


