Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03801C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C844B20663
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C844B20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdY9b-0005d3-VZ
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 07:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jdY6u-0001Rf-Cm
 for qemu-devel@nongnu.org; Tue, 26 May 2020 07:51:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44670
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jdY6t-0004qM-AA
 for qemu-devel@nongnu.org; Tue, 26 May 2020 07:51:08 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04QBWHj1110656; Tue, 26 May 2020 07:50:34 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com with ESMTP id 316yqj2a52-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 May 2020 07:50:33 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04QBbkpZ004662;
 Tue, 26 May 2020 11:50:32 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma01fra.de.ibm.com with ESMTP id 316uf8jcfw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 May 2020 11:50:32 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04QBoTPN39125236
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 May 2020 11:50:29 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A30A04C046;
 Tue, 26 May 2020 11:50:29 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 722404C058;
 Tue, 26 May 2020 11:50:29 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Tue, 26 May 2020 11:50:29 +0000 (GMT)
Received: from bahia.ibmuc.com (sig-9-145-63-64.uk.ibm.com [9.145.63.64])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id BC55222003E;
 Tue, 26 May 2020 13:50:28 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/5] Revert "9p: init_in_iov_from_pdu can truncate the size"
Date: Tue, 26 May 2020 13:49:30 +0200
Message-Id: <20200526114931.391049-4-groug@kaod.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526114931.391049-1-groug@kaod.org>
References: <20200526114931.391049-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-05-26_01:2020-05-26,
 2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1034 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005260083
Received-SPF: softfail client-ip=148.163.158.5; envelope-from=groug@kaod.org;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 07:50:54
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_SOFTFAIL=0.665,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Stefano Stabellini <stefano.stabellini@xilinx.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefano Stabellini <stefano.stabellini@xilinx.com>

This reverts commit 16724a173049ac29c7b5ade741da93a0f46edff7.
It causes https://bugs.launchpad.net/bugs/1877688.

Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-Id: <20200521192627.15259-1-sstabellini@kernel.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c               | 33 +++++++++++----------------------
 hw/9pfs/9p.h               |  2 +-
 hw/9pfs/virtio-9p-device.c | 11 ++++-------
 hw/9pfs/xen-9p-backend.c   | 15 ++++++---------
 4 files changed, 22 insertions(+), 39 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 68c2df7333f9..45a788f6e675 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2103,29 +2103,22 @@ out_nofid:
  * with qemu_iovec_destroy().
  */
 static void v9fs_init_qiov_from_pdu(QEMUIOVector *qiov, V9fsPDU *pdu,
-                                    size_t skip, size_t *size,
+                                    size_t skip, size_t size,
                                     bool is_write)
 {
     QEMUIOVector elem;
     struct iovec *iov;
     unsigned int niov;
-    size_t alloc_size =3D *size + skip;
=20
     if (is_write) {
-        pdu->s->transport->init_out_iov_from_pdu(pdu, &iov, &niov, alloc=
_size);
+        pdu->s->transport->init_out_iov_from_pdu(pdu, &iov, &niov, size =
+ skip);
     } else {
-        pdu->s->transport->init_in_iov_from_pdu(pdu, &iov, &niov, &alloc=
_size);
-    }
-
-    if (alloc_size < skip) {
-        *size =3D 0;
-    } else {
-        *size =3D alloc_size - skip;
+        pdu->s->transport->init_in_iov_from_pdu(pdu, &iov, &niov, size +=
 skip);
     }
=20
     qemu_iovec_init_external(&elem, iov, niov);
     qemu_iovec_init(qiov, niov);
-    qemu_iovec_concat(qiov, &elem, skip, *size);
+    qemu_iovec_concat(qiov, &elem, skip, size);
 }
=20
 static int v9fs_xattr_read(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fid=
p,
@@ -2133,14 +2126,15 @@ static int v9fs_xattr_read(V9fsState *s, V9fsPDU =
*pdu, V9fsFidState *fidp,
 {
     ssize_t err;
     size_t offset =3D 7;
-    size_t read_count;
+    uint64_t read_count;
     QEMUIOVector qiov_full;
=20
     if (fidp->fs.xattr.len < off) {
         read_count =3D 0;
-    } else if (fidp->fs.xattr.len - off < max_count) {
-        read_count =3D fidp->fs.xattr.len - off;
     } else {
+        read_count =3D fidp->fs.xattr.len - off;
+    }
+    if (read_count > max_count) {
         read_count =3D max_count;
     }
     err =3D pdu_marshal(pdu, offset, "d", read_count);
@@ -2149,7 +2143,7 @@ static int v9fs_xattr_read(V9fsState *s, V9fsPDU *p=
du, V9fsFidState *fidp,
     }
     offset +=3D err;
=20
-    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, &read_count, false)=
;
+    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, read_count, false);
     err =3D v9fs_pack(qiov_full.iov, qiov_full.niov, 0,
                     ((char *)fidp->fs.xattr.value) + off,
                     read_count);
@@ -2278,11 +2272,9 @@ static void coroutine_fn v9fs_read(void *opaque)
         QEMUIOVector qiov_full;
         QEMUIOVector qiov;
         int32_t len;
-        size_t size =3D max_count;
=20
-        v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset + 4, &size, fals=
e);
+        v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset + 4, max_count, =
false);
         qemu_iovec_init(&qiov, qiov_full.niov);
-        max_count =3D size;
         do {
             qemu_iovec_reset(&qiov);
             qemu_iovec_concat(&qiov, &qiov_full, count, qiov_full.size -=
 count);
@@ -2533,7 +2525,6 @@ static void coroutine_fn v9fs_write(void *opaque)
     int32_t len =3D 0;
     int32_t total =3D 0;
     size_t offset =3D 7;
-    size_t size;
     V9fsFidState *fidp;
     V9fsPDU *pdu =3D opaque;
     V9fsState *s =3D pdu->s;
@@ -2546,9 +2537,7 @@ static void coroutine_fn v9fs_write(void *opaque)
         return;
     }
     offset +=3D err;
-    size =3D count;
-    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, &size, true);
-    count =3D size;
+    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, count, true);
     trace_v9fs_write(pdu->tag, pdu->id, fid, off, count, qiov_full.niov)=
;
=20
     fidp =3D get_fid(pdu, fid);
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 3ab580764cf8..ee2271663c50 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -436,7 +436,7 @@ struct V9fsTransport {
     ssize_t     (*pdu_vunmarshal)(V9fsPDU *pdu, size_t offset, const cha=
r *fmt,
                                   va_list ap);
     void        (*init_in_iov_from_pdu)(V9fsPDU *pdu, struct iovec **pio=
v,
-                                        unsigned int *pniov, size_t *siz=
e);
+                                        unsigned int *pniov, size_t size=
);
     void        (*init_out_iov_from_pdu)(V9fsPDU *pdu, struct iovec **pi=
ov,
                                          unsigned int *pniov, size_t siz=
e);
     void        (*push_and_notify)(V9fsPDU *pdu);
diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index e5b44977c768..36f3aa9352f2 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -147,22 +147,19 @@ static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, =
size_t offset,
 }
=20
 static void virtio_init_in_iov_from_pdu(V9fsPDU *pdu, struct iovec **pio=
v,
-                                        unsigned int *pniov, size_t *siz=
e)
+                                        unsigned int *pniov, size_t size=
)
 {
     V9fsState *s =3D pdu->s;
     V9fsVirtioState *v =3D container_of(s, V9fsVirtioState, state);
     VirtQueueElement *elem =3D v->elems[pdu->idx];
     size_t buf_size =3D iov_size(elem->in_sg, elem->in_num);
=20
-    if (buf_size < P9_IOHDRSZ) {
+    if (buf_size < size) {
         VirtIODevice *vdev =3D VIRTIO_DEVICE(v);
=20
         virtio_error(vdev,
-                     "VirtFS reply type %d needs %zu bytes, buffer has %=
zu, less than minimum",
-                     pdu->id + 1, *size, buf_size);
-    }
-    if (buf_size < *size) {
-        *size =3D buf_size;
+                     "VirtFS reply type %d needs %zu bytes, buffer has %=
zu",
+                     pdu->id + 1, size, buf_size);
     }
=20
     *piov =3D elem->in_sg;
diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index f04caabfe51e..fc197f6c8aaa 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -188,7 +188,7 @@ static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU *p=
du,
 static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
                                           struct iovec **piov,
                                           unsigned int *pniov,
-                                          size_t *size)
+                                          size_t size)
 {
     Xen9pfsDev *xen_9pfs =3D container_of(pdu->s, Xen9pfsDev, state);
     Xen9pfsRing *ring =3D &xen_9pfs->rings[pdu->tag % xen_9pfs->num_ring=
s];
@@ -198,19 +198,16 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *=
pdu,
     g_free(ring->sg);
=20
     ring->sg =3D g_new0(struct iovec, 2);
-    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, *size);
+    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, size);
=20
     buf_size =3D iov_size(ring->sg, num);
-    if (buf_size  < P9_IOHDRSZ) {
-        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs reply type %d need=
s "
-                      "%zu bytes, buffer has %zu, less than minimum\n",
-                      pdu->id + 1, *size, buf_size);
+    if (buf_size  < size) {
+        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs request type %d"
+                "needs %zu bytes, buffer has %zu\n", pdu->id, size,
+                buf_size);
         xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
         xen_9pfs_disconnect(&xen_9pfs->xendev);
     }
-    if (buf_size  < *size) {
-        *size =3D buf_size;
-    }
=20
     *piov =3D ring->sg;
     *pniov =3D num;
--=20
2.21.3


