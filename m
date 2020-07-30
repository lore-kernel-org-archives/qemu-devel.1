Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716CAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:08:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 393F6206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 393F6206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k19Ed-000513-IS
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 10:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1k19Dl-0004A2-Ny
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 10:07:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1976)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1k19Dj-0003KG-4R
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 10:07:45 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06UE234V011963
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 10:07:41 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32kretnjas-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 10:07:40 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06UE2Zvd015805
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 10:07:40 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32kretnj9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2020 10:07:40 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06UE5oq6022635;
 Thu, 30 Jul 2020 14:07:38 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma04ams.nl.ibm.com with ESMTP id 32gcy4p85h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2020 14:07:37 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06UE7ZYw29819290
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 14:07:35 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 709564C052;
 Thu, 30 Jul 2020 14:07:35 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 005E44C040;
 Thu, 30 Jul 2020 14:07:35 +0000 (GMT)
Received: from marcibm.ibmuc.com (unknown [9.145.35.48])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 30 Jul 2020 14:07:34 +0000 (GMT)
From: Marc Hartmayer <mhartmay@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 2/2] libvhost-user: handle endianness as mandated by the spec
Date: Thu, 30 Jul 2020 16:07:31 +0200
Message-Id: <20200730140731.32912-3-mhartmay@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200730140731.32912-1-mhartmay@linux.ibm.com>
References: <20200730140731.32912-1-mhartmay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-30_10:2020-07-30,
 2020-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300099
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mhartmay@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 07:28:21
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Since virtio existed even before it got standardized, the virtio
standard defines the following types of virtio devices:

 + legacy device (pre-virtio 1.0)
 + non-legacy or VIRTIO 1.0 device
 + transitional device (which can act both as legacy and non-legacy)

Virtio 1.0 defines the fields of the virtqueues as little endian,
while legacy uses guest's native endian [1]. Currently libvhost-user
does not handle virtio endianness at all, i.e. it works only if the
native endianness matches with whatever is actually needed. That means
things break spectacularly on big-endian targets. Let us handle virtio
endianness for non-legacy as required by the virtio specification
[1]. The fencing of legacy virtio devices is done in
`vu_set_features_exec`.

[1] https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-210003

Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
---
 contrib/libvhost-user/libvhost-user.c | 77 +++++++++++++++------------
 1 file changed, 43 insertions(+), 34 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 53f16bdf082c..e2238a0400c9 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -42,6 +42,7 @@
 
 #include "qemu/atomic.h"
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "qemu/memfd.h"
 
 #include "libvhost-user.h"
@@ -539,6 +540,14 @@ vu_set_features_exec(VuDev *dev, VhostUserMsg *vmsg)
     DPRINT("u64: 0x%016"PRIx64"\n", vmsg->payload.u64);
 
     dev->features = vmsg->payload.u64;
+    if (!vu_has_feature(dev, VIRTIO_F_VERSION_1)) {
+        /*
+         * We only support devices conforming to VIRTIO 1.0 or
+         * later
+         */
+        vu_panic(dev, "virtio legacy devices aren't supported by libvhost-user");
+        return false;
+    }
 
     if (!(dev->features & VHOST_USER_F_PROTOCOL_FEATURES)) {
         vu_set_enable_all_rings(dev, true);
@@ -1074,7 +1083,7 @@ vu_set_vring_addr_exec(VuDev *dev, VhostUserMsg *vmsg)
         return false;
     }
 
-    vq->used_idx = vq->vring.used->idx;
+    vq->used_idx = lduw_le_p(&vq->vring.used->idx);
 
     if (vq->last_avail_idx != vq->used_idx) {
         bool resume = dev->iface->queue_is_processed_in_order &&
@@ -1191,7 +1200,7 @@ vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
         return 0;
     }
 
-    vq->used_idx = vq->vring.used->idx;
+    vq->used_idx = lduw_le_p(&vq->vring.used->idx);
     vq->resubmit_num = 0;
     vq->resubmit_list = NULL;
     vq->counter = 0;
@@ -2021,13 +2030,13 @@ vu_queue_started(const VuDev *dev, const VuVirtq *vq)
 static inline uint16_t
 vring_avail_flags(VuVirtq *vq)
 {
-    return vq->vring.avail->flags;
+    return lduw_le_p(&vq->vring.avail->flags);
 }
 
 static inline uint16_t
 vring_avail_idx(VuVirtq *vq)
 {
-    vq->shadow_avail_idx = vq->vring.avail->idx;
+    vq->shadow_avail_idx = lduw_le_p(&vq->vring.avail->idx);
 
     return vq->shadow_avail_idx;
 }
@@ -2035,7 +2044,7 @@ vring_avail_idx(VuVirtq *vq)
 static inline uint16_t
 vring_avail_ring(VuVirtq *vq, int i)
 {
-    return vq->vring.avail->ring[i];
+    return lduw_le_p(&vq->vring.avail->ring[i]);
 }
 
 static inline uint16_t
@@ -2123,12 +2132,12 @@ virtqueue_read_next_desc(VuDev *dev, struct vring_desc *desc,
                          int i, unsigned int max, unsigned int *next)
 {
     /* If this descriptor says it doesn't chain, we're done. */
-    if (!(desc[i].flags & VRING_DESC_F_NEXT)) {
+    if (!(lduw_le_p(&desc[i].flags) & VRING_DESC_F_NEXT)) {
         return VIRTQUEUE_READ_DESC_DONE;
     }
 
     /* Check they're not leading us off end of descriptors. */
-    *next = desc[i].next;
+    *next = lduw_le_p(&desc[i].next);
     /* Make sure compiler knows to grab that: we don't want it changing! */
     smp_wmb();
 
@@ -2171,8 +2180,8 @@ vu_queue_get_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int *in_bytes,
         }
         desc = vq->vring.desc;
 
-        if (desc[i].flags & VRING_DESC_F_INDIRECT) {
-            if (desc[i].len % sizeof(struct vring_desc)) {
+        if (lduw_le_p(&desc[i].flags) & VRING_DESC_F_INDIRECT) {
+            if (ldl_le_p(&desc[i].len) % sizeof(struct vring_desc)) {
                 vu_panic(dev, "Invalid size for indirect buffer table");
                 goto err;
             }
@@ -2185,8 +2194,8 @@ vu_queue_get_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int *in_bytes,
 
             /* loop over the indirect descriptor table */
             indirect = 1;
-            desc_addr = desc[i].addr;
-            desc_len = desc[i].len;
+            desc_addr = ldq_le_p(&desc[i].addr);
+            desc_len = ldl_le_p(&desc[i].len);
             max = desc_len / sizeof(struct vring_desc);
             read_len = desc_len;
             desc = vu_gpa_to_va(dev, &read_len, desc_addr);
@@ -2213,10 +2222,10 @@ vu_queue_get_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int *in_bytes,
                 goto err;
             }
 
-            if (desc[i].flags & VRING_DESC_F_WRITE) {
-                in_total += desc[i].len;
+            if (lduw_le_p(&desc[i].flags) & VRING_DESC_F_WRITE) {
+                in_total += ldl_le_p(&desc[i].len);
             } else {
-                out_total += desc[i].len;
+                out_total += ldl_le_p(&desc[i].len);
             }
             if (in_total >= max_in_bytes && out_total >= max_out_bytes) {
                 goto done;
@@ -2367,7 +2376,7 @@ vring_used_flags_set_bit(VuVirtq *vq, int mask)
 
     flags = (uint16_t *)((char*)vq->vring.used +
                          offsetof(struct vring_used, flags));
-    *flags |= mask;
+    stw_le_p(flags, lduw_le_p(flags) | mask);
 }
 
 static inline void
@@ -2377,7 +2386,7 @@ vring_used_flags_unset_bit(VuVirtq *vq, int mask)
 
     flags = (uint16_t *)((char*)vq->vring.used +
                          offsetof(struct vring_used, flags));
-    *flags &= ~mask;
+    stw_le_p(flags, lduw_le_p(flags) & ~mask);
 }
 
 static inline void
@@ -2387,7 +2396,7 @@ vring_set_avail_event(VuVirtq *vq, uint16_t val)
         return;
     }
 
-    *((uint16_t *) &vq->vring.used->ring[vq->vring.num]) = val;
+    stw_le_p(&vq->vring.used->ring[vq->vring.num], val);
 }
 
 void
@@ -2476,14 +2485,14 @@ vu_queue_map_desc(VuDev *dev, VuVirtq *vq, unsigned int idx, size_t sz)
     struct vring_desc desc_buf[VIRTQUEUE_MAX_SIZE];
     int rc;
 
-    if (desc[i].flags & VRING_DESC_F_INDIRECT) {
-        if (desc[i].len % sizeof(struct vring_desc)) {
+    if (lduw_le_p(&desc[i].flags) & VRING_DESC_F_INDIRECT) {
+        if (ldl_le_p(&desc[i].len) % sizeof(struct vring_desc)) {
             vu_panic(dev, "Invalid size for indirect buffer table");
         }
 
         /* loop over the indirect descriptor table */
-        desc_addr = desc[i].addr;
-        desc_len = desc[i].len;
+        desc_addr = ldq_le_p(&desc[i].addr);
+        desc_len = ldl_le_p(&desc[i].len);
         max = desc_len / sizeof(struct vring_desc);
         read_len = desc_len;
         desc = vu_gpa_to_va(dev, &read_len, desc_addr);
@@ -2505,10 +2514,10 @@ vu_queue_map_desc(VuDev *dev, VuVirtq *vq, unsigned int idx, size_t sz)
 
     /* Collect all the descriptors */
     do {
-        if (desc[i].flags & VRING_DESC_F_WRITE) {
+        if (lduw_le_p(&desc[i].flags) & VRING_DESC_F_WRITE) {
             virtqueue_map_desc(dev, &in_num, iov + out_num,
                                VIRTQUEUE_MAX_SIZE - out_num, true,
-                               desc[i].addr, desc[i].len);
+                               ldq_le_p(&desc[i].addr), ldl_le_p(&desc[i].len));
         } else {
             if (in_num) {
                 vu_panic(dev, "Incorrect order for descriptors");
@@ -2516,7 +2525,7 @@ vu_queue_map_desc(VuDev *dev, VuVirtq *vq, unsigned int idx, size_t sz)
             }
             virtqueue_map_desc(dev, &out_num, iov,
                                VIRTQUEUE_MAX_SIZE, false,
-                               desc[i].addr, desc[i].len);
+                               ldq_le_p(&desc[i].addr), ldl_le_p(&desc[i].len));
         }
 
         /* If we've got too many, that implies a descriptor loop. */
@@ -2712,14 +2721,14 @@ vu_log_queue_fill(VuDev *dev, VuVirtq *vq,
     max = vq->vring.num;
     i = elem->index;
 
-    if (desc[i].flags & VRING_DESC_F_INDIRECT) {
-        if (desc[i].len % sizeof(struct vring_desc)) {
+    if (lduw_le_p(&desc[i].flags) & VRING_DESC_F_INDIRECT) {
+        if (ldl_le_p(&desc[i].len) % sizeof(struct vring_desc)) {
             vu_panic(dev, "Invalid size for indirect buffer table");
         }
 
         /* loop over the indirect descriptor table */
-        desc_addr = desc[i].addr;
-        desc_len = desc[i].len;
+        desc_addr = ldq_le_p(&desc[i].addr);
+        desc_len = ldl_le_p(&desc[i].len);
         max = desc_len / sizeof(struct vring_desc);
         read_len = desc_len;
         desc = vu_gpa_to_va(dev, &read_len, desc_addr);
@@ -2745,9 +2754,9 @@ vu_log_queue_fill(VuDev *dev, VuVirtq *vq,
             return;
         }
 
-        if (desc[i].flags & VRING_DESC_F_WRITE) {
-            min = MIN(desc[i].len, len);
-            vu_log_write(dev, desc[i].addr, min);
+        if (lduw_le_p(&desc[i].flags) & VRING_DESC_F_WRITE) {
+            min = MIN(ldl_le_p(&desc[i].len), len);
+            vu_log_write(dev, ldq_le_p(&desc[i].addr), min);
             len -= min;
         }
 
@@ -2772,15 +2781,15 @@ vu_queue_fill(VuDev *dev, VuVirtq *vq,
 
     idx = (idx + vq->used_idx) % vq->vring.num;
 
-    uelem.id = elem->index;
-    uelem.len = len;
+    stl_le_p(&uelem.id, elem->index);
+    stl_le_p(&uelem.len, len);
     vring_used_write(dev, vq, &uelem, idx);
 }
 
 static inline
 void vring_used_idx_set(VuDev *dev, VuVirtq *vq, uint16_t val)
 {
-    vq->vring.used->idx = val;
+    stw_le_p(&vq->vring.used->idx, val);
     vu_log_write(dev,
                  vq->vring.log_guest_addr + offsetof(struct vring_used, idx),
                  sizeof(vq->vring.used->idx));
-- 
2.25.4


