Received: from eggs.gnu.org ([2001:4830:134:3::10]:46262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLlo-0005Un-1S
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLlj-0001f5-Fm
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:53:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1duLlj-0001eA-80
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:53:07 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 19 Sep 2017 18:52:07 +0200
Message-Id: <20170919165226.23022-9-marcandre.lureau@redhat.com>
In-Reply-To: <20170919165226.23022-1-marcandre.lureau@redhat.com>
References: <20170919165226.23022-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 08/27] vhost-user-scsi: code style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, changpeng.liu@intel.com, f4bug@amsat.org, felipe@nutanix.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index e01bf31296..fe567452cd 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -305,7 +305,8 @@ fail:
 }
=20
 static struct scsi_task *scsi_task_new(int cdb_len, uint8_t *cdb, int di=
r,
-                                       int xfer_len) {
+                                       int xfer_len)
+{
     struct scsi_task *task;
=20
     assert(cdb_len > 0);
@@ -344,7 +345,8 @@ static int handle_cmd_sync(struct iscsi_context *ctx,
                            VirtIOSCSICmdReq *req,
                            struct iovec *out, unsigned int out_len,
                            VirtIOSCSICmdResp *rsp,
-                           struct iovec *in, unsigned int in_len) {
+                           struct iovec *in, unsigned int in_len)
+{
     struct scsi_task *task;
     uint32_t dir;
     uint32_t len;
@@ -454,7 +456,8 @@ static void vus_panic_cb(VuDev *vu_dev, const char *b=
uf)
 }
=20
 static void vus_add_watch_cb(VuDev *vu_dev, int fd, int vu_evt, vu_watch=
_cb cb,
-                             void *pvt) {
+                             void *pvt)
+{
     vhost_scsi_dev_t *vdev_scsi;
     guint id;
=20
@@ -529,7 +532,7 @@ static void vus_proc_req(VuDev *vu_dev, int idx)
         return;
     }
=20
-    if ((idx < 0) || (idx >=3D VHOST_MAX_NR_VIRTQUEUE)) {
+    if (idx < 0 || idx >=3D VHOST_MAX_NR_VIRTQUEUE) {
         PERR("VQ Index out of range: %d", idx);
         vus_panic_cb(vu_dev, NULL);
         return;
@@ -556,8 +559,8 @@ static void vus_proc_req(VuDev *vu_dev, int idx)
         }
         PDBG("Popped elem@%p", elem);
=20
-        assert(!((elem->out_num > 1) && (elem->in_num > 1)));
-        assert((elem->out_num > 0) && (elem->in_num > 0));
+        assert(!(elem->out_num > 1 && elem->in_num > 1));
+        assert(elem->out_num > 0 && elem->in_num > 0);
=20
         if (elem->out_sg[0].iov_len < sizeof(VirtIOSCSICmdReq)) {
             PERR("Invalid virtio-scsi req header");
@@ -593,7 +596,7 @@ static void vus_queue_set_started(VuDev *vu_dev, int =
idx, bool started)
=20
     assert(vu_dev);
=20
-    if ((idx < 0) || (idx >=3D VHOST_MAX_NR_VIRTQUEUE)) {
+    if (idx < 0 || idx >=3D VHOST_MAX_NR_VIRTQUEUE) {
         PERR("VQ Index out of range: %d", idx);
         vus_panic_cb(vu_dev, NULL);
         return;
@@ -748,7 +751,8 @@ err:
 }
=20
 static int vdev_scsi_add_iscsi_lun(vhost_scsi_dev_t *vdev_scsi,
-                                   char *iscsi_uri, uint32_t lun) {
+                                   char *iscsi_uri, uint32_t lun)
+{
     assert(vdev_scsi);
     assert(iscsi_uri);
     assert(lun < VUS_MAX_LUNS);
--=20
2.14.1.146.gd35faa819
