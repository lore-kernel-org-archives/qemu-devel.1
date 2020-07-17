Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA9CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:32:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D72DC2063A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72DC2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwMiu-0000my-5b
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 05:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1jwMgl-000666-9k
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 05:29:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23190)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1jwMgi-0004Gf-6D
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 05:29:55 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06H93bwd047333
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 05:29:51 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 327u1mh0ua-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 05:29:50 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06H93j8N047886
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 05:29:50 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 327u1mh0tj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2020 05:29:50 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06H9RaEc016213;
 Fri, 17 Jul 2020 09:29:48 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma06ams.nl.ibm.com with ESMTP id 3274pgxb09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2020 09:29:48 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06H9Tkcr10748410
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jul 2020 09:29:46 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52A16AE051;
 Fri, 17 Jul 2020 09:29:46 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D06F9AE055;
 Fri, 17 Jul 2020 09:29:45 +0000 (GMT)
Received: from marcibm.ibmuc.com (unknown [9.145.17.123])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 17 Jul 2020 09:29:45 +0000 (GMT)
From: Marc Hartmayer <mhartmay@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Subject: [RFC v2 2/3] libvhost-user: handle endianness as mandated by the spec
Date: Fri, 17 Jul 2020 11:29:28 +0200
Message-Id: <20200717092929.19453-3-mhartmay@linux.ibm.com>
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
 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007170066
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mhartmay@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 05:29:50
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
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
[1]. We will fence non-legacy virtio devices with the upcoming patch.

[1] https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-210003

Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>

---
Note: As we don't support legacy virtio devices there is dead code in
libvhost-access.h that could be removed. But for the sake of
completeness, I left it in the code.
---
 contrib/libvhost-user/libvhost-access.h |  61 ++++++++++++
 contrib/libvhost-user/libvhost-user.c   | 119 ++++++++++++------------
 2 files changed, 121 insertions(+), 59 deletions(-)
 create mode 100644 contrib/libvhost-user/libvhost-access.h

diff --git a/contrib/libvhost-user/libvhost-access.h b/contrib/libvhost-user/libvhost-access.h
new file mode 100644
index 000000000000..868ba3e7bfb8
--- /dev/null
+++ b/contrib/libvhost-user/libvhost-access.h
@@ -0,0 +1,61 @@
+#ifndef LIBVHOST_ACCESS_H
+
+#include "qemu/bswap.h"
+
+#include "libvhost-user.h"
+
+static inline bool vu_access_is_big_endian(VuDev *dev)
+{
+    /* Devices conforming to VIRTIO 1.0 or later are always LE. */
+    return false;
+}
+
+static inline void vu_stw_p(VuDev *vdev, void *ptr, uint16_t v)
+{
+    if (vu_access_is_big_endian(vdev)) {
+        stw_be_p(ptr, v);
+    } else {
+        stw_le_p(ptr, v);
+    }
+}
+
+static inline void vu_stl_p(VuDev *vdev, void *ptr, uint32_t v)
+{
+    if (vu_access_is_big_endian(vdev)) {
+        stl_be_p(ptr, v);
+    } else {
+        stl_le_p(ptr, v);
+    }
+}
+
+static inline void vu_stq_p(VuDev *vdev, void *ptr, uint64_t v)
+{
+    if (vu_access_is_big_endian(vdev)) {
+        stq_be_p(ptr, v);
+    } else {
+        stq_le_p(ptr, v);
+    }
+}
+
+static inline int vu_lduw_p(VuDev *vdev, const void *ptr)
+{
+    if (vu_access_is_big_endian(vdev))
+        return lduw_be_p(ptr);
+    return lduw_le_p(ptr);
+}
+
+static inline int vu_ldl_p(VuDev *vdev, const void *ptr)
+{
+    if (vu_access_is_big_endian(vdev))
+        return ldl_be_p(ptr);
+    return ldl_le_p(ptr);
+}
+
+static inline uint64_t vu_ldq_p(VuDev *vdev, const void *ptr)
+{
+    if (vu_access_is_big_endian(vdev))
+        return ldq_be_p(ptr);
+    return ldq_le_p(ptr);
+}
+
+#endif /* LIBVHOST_ACCESS_H */
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index d315db139606..0214b04c5291 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -45,6 +45,7 @@
 #include "qemu/memfd.h"
 
 #include "libvhost-user.h"
+#include "libvhost-access.h"
 
 /* usually provided by GLib */
 #ifndef MIN
@@ -1074,7 +1075,7 @@ vu_set_vring_addr_exec(VuDev *dev, VhostUserMsg *vmsg)
         return false;
     }
 
-    vq->used_idx = vq->vring.used->idx;
+    vq->used_idx = vu_lduw_p(dev, &vq->vring.used->idx);
 
     if (vq->last_avail_idx != vq->used_idx) {
         bool resume = dev->iface->queue_is_processed_in_order &&
@@ -1191,7 +1192,7 @@ vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
         return 0;
     }
 
-    vq->used_idx = vq->vring.used->idx;
+    vq->used_idx = vu_lduw_p(dev, &vq->vring.used->idx);
     vq->resubmit_num = 0;
     vq->resubmit_list = NULL;
     vq->counter = 0;
@@ -2019,35 +2020,35 @@ vu_queue_started(const VuDev *dev, const VuVirtq *vq)
 }
 
 static inline uint16_t
-vring_avail_flags(VuVirtq *vq)
+vring_avail_flags(VuDev *dev, VuVirtq *vq)
 {
-    return vq->vring.avail->flags;
+    return vu_lduw_p(dev, &vq->vring.avail->flags);
 }
 
 static inline uint16_t
-vring_avail_idx(VuVirtq *vq)
+vring_avail_idx(VuDev *dev, VuVirtq *vq)
 {
-    vq->shadow_avail_idx = vq->vring.avail->idx;
+    vq->shadow_avail_idx = vu_lduw_p(dev, &vq->vring.avail->idx);
 
     return vq->shadow_avail_idx;
 }
 
 static inline uint16_t
-vring_avail_ring(VuVirtq *vq, int i)
+vring_avail_ring(VuDev *dev, VuVirtq *vq, int i)
 {
-    return vq->vring.avail->ring[i];
+    return vu_lduw_p(dev, &vq->vring.avail->ring[i]);
 }
 
 static inline uint16_t
-vring_get_used_event(VuVirtq *vq)
+vring_get_used_event(VuDev *dev, VuVirtq *vq)
 {
-    return vring_avail_ring(vq, vq->vring.num);
+    return vring_avail_ring(dev, vq, vq->vring.num);
 }
 
 static int
 virtqueue_num_heads(VuDev *dev, VuVirtq *vq, unsigned int idx)
 {
-    uint16_t num_heads = vring_avail_idx(vq) - idx;
+    uint16_t num_heads = vring_avail_idx(dev, vq) - idx;
 
     /* Check it isn't doing very strange things with descriptor numbers. */
     if (num_heads > vq->vring.num) {
@@ -2070,7 +2071,7 @@ virtqueue_get_head(VuDev *dev, VuVirtq *vq,
 {
     /* Grab the next descriptor number they're advertising, and increment
      * the index we've seen. */
-    *head = vring_avail_ring(vq, idx % vq->vring.num);
+    *head = vring_avail_ring(dev, vq, idx % vq->vring.num);
 
     /* If their number is silly, that's a fatal mistake. */
     if (*head >= vq->vring.num) {
@@ -2123,12 +2124,12 @@ virtqueue_read_next_desc(VuDev *dev, struct vring_desc *desc,
                          int i, unsigned int max, unsigned int *next)
 {
     /* If this descriptor says it doesn't chain, we're done. */
-    if (!(desc[i].flags & VRING_DESC_F_NEXT)) {
+    if (!(vu_lduw_p(dev, &desc[i].flags) & VRING_DESC_F_NEXT)) {
         return VIRTQUEUE_READ_DESC_DONE;
     }
 
     /* Check they're not leading us off end of descriptors. */
-    *next = desc[i].next;
+    *next = vu_lduw_p(dev, &desc[i].next);
     /* Make sure compiler knows to grab that: we don't want it changing! */
     smp_wmb();
 
@@ -2171,8 +2172,8 @@ vu_queue_get_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int *in_bytes,
         }
         desc = vq->vring.desc;
 
-        if (desc[i].flags & VRING_DESC_F_INDIRECT) {
-            if (desc[i].len % sizeof(struct vring_desc)) {
+        if (vu_lduw_p(dev, &desc[i].flags) & VRING_DESC_F_INDIRECT) {
+            if (vu_ldl_p(dev, &desc[i].len) % sizeof(struct vring_desc)) {
                 vu_panic(dev, "Invalid size for indirect buffer table");
                 goto err;
             }
@@ -2185,8 +2186,8 @@ vu_queue_get_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int *in_bytes,
 
             /* loop over the indirect descriptor table */
             indirect = 1;
-            desc_addr = desc[i].addr;
-            desc_len = desc[i].len;
+            desc_addr = vu_ldq_p(dev, &desc[i].addr);
+            desc_len = vu_ldl_p(dev, &desc[i].len);
             max = desc_len / sizeof(struct vring_desc);
             read_len = desc_len;
             desc = vu_gpa_to_va(dev, &read_len, desc_addr);
@@ -2213,10 +2214,10 @@ vu_queue_get_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int *in_bytes,
                 goto err;
             }
 
-            if (desc[i].flags & VRING_DESC_F_WRITE) {
-                in_total += desc[i].len;
+            if (vu_lduw_p(dev, &desc[i].flags) & VRING_DESC_F_WRITE) {
+                in_total += vu_ldl_p(dev, &desc[i].len);
             } else {
-                out_total += desc[i].len;
+                out_total += vu_ldl_p(dev, &desc[i].len);
             }
             if (in_total >= max_in_bytes && out_total >= max_out_bytes) {
                 goto done;
@@ -2277,7 +2278,7 @@ vu_queue_empty(VuDev *dev, VuVirtq *vq)
         return false;
     }
 
-    return vring_avail_idx(vq) == vq->last_avail_idx;
+    return vring_avail_idx(dev, vq) == vq->last_avail_idx;
 }
 
 static bool
@@ -2296,14 +2297,14 @@ vring_notify(VuDev *dev, VuVirtq *vq)
     }
 
     if (!vu_has_feature(dev, VIRTIO_RING_F_EVENT_IDX)) {
-        return !(vring_avail_flags(vq) & VRING_AVAIL_F_NO_INTERRUPT);
+        return !(vring_avail_flags(dev, vq) & VRING_AVAIL_F_NO_INTERRUPT);
     }
 
     v = vq->signalled_used_valid;
     vq->signalled_used_valid = true;
     old = vq->signalled_used;
     new = vq->signalled_used = vq->used_idx;
-    return !v || vring_need_event(vring_get_used_event(vq), new, old);
+    return !v || vring_need_event(vring_get_used_event(dev, vq), new, old);
 }
 
 static void _vu_queue_notify(VuDev *dev, VuVirtq *vq, bool sync)
@@ -2361,33 +2362,33 @@ void vu_queue_notify_sync(VuDev *dev, VuVirtq *vq)
 }
 
 static inline void
-vring_used_flags_set_bit(VuVirtq *vq, int mask)
+vring_used_flags_set_bit(VuDev *dev, VuVirtq *vq, int mask)
+{
+    uint16_t *flags;
+
+    flags = (uint16_t *)(char*)vq->vring.used +
+        offsetof(struct vring_used, flags);
+    vu_stw_p(dev, flags, vu_lduw_p(dev, flags) | mask);
+}
+
+static inline void
+vring_used_flags_unset_bit(VuDev *dev, VuVirtq *vq, int mask)
 {
     uint16_t *flags;
 
     flags = (uint16_t *)((char*)vq->vring.used +
                          offsetof(struct vring_used, flags));
-    *flags |= mask;
+    vu_stw_p(dev, flags, vu_lduw_p(dev, flags) & ~mask);
 }
 
 static inline void
-vring_used_flags_unset_bit(VuVirtq *vq, int mask)
-{
-    uint16_t *flags;
-
-    flags = (uint16_t *)((char*)vq->vring.used +
-                         offsetof(struct vring_used, flags));
-    *flags &= ~mask;
-}
-
-static inline void
-vring_set_avail_event(VuVirtq *vq, uint16_t val)
+vring_set_avail_event(VuDev *dev, VuVirtq *vq, uint16_t val)
 {
     if (!vq->notification) {
         return;
     }
 
-    *((uint16_t *) &vq->vring.used->ring[vq->vring.num]) = val;
+    vu_stw_p(dev, &vq->vring.used->ring[vq->vring.num], val);
 }
 
 void
@@ -2395,11 +2396,11 @@ vu_queue_set_notification(VuDev *dev, VuVirtq *vq, int enable)
 {
     vq->notification = enable;
     if (vu_has_feature(dev, VIRTIO_RING_F_EVENT_IDX)) {
-        vring_set_avail_event(vq, vring_avail_idx(vq));
+        vring_set_avail_event(dev, vq, vring_avail_idx(dev, vq));
     } else if (enable) {
-        vring_used_flags_unset_bit(vq, VRING_USED_F_NO_NOTIFY);
+        vring_used_flags_unset_bit(dev, vq, VRING_USED_F_NO_NOTIFY);
     } else {
-        vring_used_flags_set_bit(vq, VRING_USED_F_NO_NOTIFY);
+        vring_used_flags_set_bit(dev, vq, VRING_USED_F_NO_NOTIFY);
     }
     if (enable) {
         /* Expose avail event/used flags before caller checks the avail idx. */
@@ -2476,14 +2477,14 @@ vu_queue_map_desc(VuDev *dev, VuVirtq *vq, unsigned int idx, size_t sz)
     struct vring_desc desc_buf[VIRTQUEUE_MAX_SIZE];
     int rc;
 
-    if (desc[i].flags & VRING_DESC_F_INDIRECT) {
-        if (desc[i].len % sizeof(struct vring_desc)) {
+    if (vu_lduw_p(dev, &desc[i].flags) & VRING_DESC_F_INDIRECT) {
+        if (vu_ldl_p(dev, &desc[i].len) % sizeof(struct vring_desc)) {
             vu_panic(dev, "Invalid size for indirect buffer table");
         }
 
         /* loop over the indirect descriptor table */
-        desc_addr = desc[i].addr;
-        desc_len = desc[i].len;
+        desc_addr = vu_ldq_p(dev, &desc[i].addr);
+        desc_len = vu_ldl_p(dev, &desc[i].len);
         max = desc_len / sizeof(struct vring_desc);
         read_len = desc_len;
         desc = vu_gpa_to_va(dev, &read_len, desc_addr);
@@ -2505,10 +2506,10 @@ vu_queue_map_desc(VuDev *dev, VuVirtq *vq, unsigned int idx, size_t sz)
 
     /* Collect all the descriptors */
     do {
-        if (desc[i].flags & VRING_DESC_F_WRITE) {
+        if (vu_lduw_p(dev, &desc[i].flags) & VRING_DESC_F_WRITE) {
             virtqueue_map_desc(dev, &in_num, iov + out_num,
                                VIRTQUEUE_MAX_SIZE - out_num, true,
-                               desc[i].addr, desc[i].len);
+                               vu_ldq_p(dev, &desc[i].addr), vu_ldl_p(dev, &desc[i].len));
         } else {
             if (in_num) {
                 vu_panic(dev, "Incorrect order for descriptors");
@@ -2516,7 +2517,7 @@ vu_queue_map_desc(VuDev *dev, VuVirtq *vq, unsigned int idx, size_t sz)
             }
             virtqueue_map_desc(dev, &out_num, iov,
                                VIRTQUEUE_MAX_SIZE, false,
-                               desc[i].addr, desc[i].len);
+                               vu_ldq_p(dev, &desc[i].addr), vu_ldl_p(dev, &desc[i].len));
         }
 
         /* If we've got too many, that implies a descriptor loop. */
@@ -2642,7 +2643,7 @@ vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
     }
 
     if (vu_has_feature(dev, VIRTIO_RING_F_EVENT_IDX)) {
-        vring_set_avail_event(vq, vq->last_avail_idx);
+        vring_set_avail_event(dev, vq, vq->last_avail_idx);
     }
 
     elem = vu_queue_map_desc(dev, vq, head, sz);
@@ -2712,14 +2713,14 @@ vu_log_queue_fill(VuDev *dev, VuVirtq *vq,
     max = vq->vring.num;
     i = elem->index;
 
-    if (desc[i].flags & VRING_DESC_F_INDIRECT) {
-        if (desc[i].len % sizeof(struct vring_desc)) {
+    if (vu_lduw_p(dev, &desc[i].flags) & VRING_DESC_F_INDIRECT) {
+        if (vu_ldl_p(dev, &desc[i].len) % sizeof(struct vring_desc)) {
             vu_panic(dev, "Invalid size for indirect buffer table");
         }
 
         /* loop over the indirect descriptor table */
-        desc_addr = desc[i].addr;
-        desc_len = desc[i].len;
+        desc_addr = vu_ldq_p(dev, &desc[i].addr);
+        desc_len = vu_ldl_p(dev, &desc[i].len);
         max = desc_len / sizeof(struct vring_desc);
         read_len = desc_len;
         desc = vu_gpa_to_va(dev, &read_len, desc_addr);
@@ -2745,9 +2746,9 @@ vu_log_queue_fill(VuDev *dev, VuVirtq *vq,
             return;
         }
 
-        if (desc[i].flags & VRING_DESC_F_WRITE) {
-            min = MIN(desc[i].len, len);
-            vu_log_write(dev, desc[i].addr, min);
+        if (vu_lduw_p(dev, &desc[i].flags) & VRING_DESC_F_WRITE) {
+            min = MIN(vu_ldl_p(dev, &desc[i].len), len);
+            vu_log_write(dev, vu_ldq_p(dev, &desc[i].addr), min);
             len -= min;
         }
 
@@ -2772,15 +2773,15 @@ vu_queue_fill(VuDev *dev, VuVirtq *vq,
 
     idx = (idx + vq->used_idx) % vq->vring.num;
 
-    uelem.id = elem->index;
-    uelem.len = len;
+    vu_stl_p(dev, &uelem.id, elem->index);
+    vu_stl_p(dev, &uelem.len, len);
     vring_used_write(dev, vq, &uelem, idx);
 }
 
 static inline
 void vring_used_idx_set(VuDev *dev, VuVirtq *vq, uint16_t val)
 {
-    vq->vring.used->idx = val;
+    vu_stw_p(dev, &vq->vring.used->idx, val);
     vu_log_write(dev,
                  vq->vring.log_guest_addr + offsetof(struct vring_used, idx),
                  sizeof(vq->vring.used->idx));
-- 
2.25.4


