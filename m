Received: from eggs.gnu.org ([2001:4830:134:3::10]:54351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZS-0006Oa-Rt
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZR-0008TT-My
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52336 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ejrZR-0008T1-HS
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:21 -0500
Date: Thu, 8 Feb 2018 21:09:20 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1518116908-10852-27-git-send-email-mst@redhat.com>
References: <1518116908-10852-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1518116908-10852-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 26/26] virtio-balloon: include statistics of
 disk/file caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>

From: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>

Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/standard-headers/linux/virtio_balloon.h | 3 ++-
 hw/virtio/virtio-balloon.c                      | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/st=
andard-headers/linux/virtio_balloon.h
index 9d06ccd..7b0a41b 100644
--- a/include/standard-headers/linux/virtio_balloon.h
+++ b/include/standard-headers/linux/virtio_balloon.h
@@ -52,7 +52,8 @@ struct virtio_balloon_config {
 #define VIRTIO_BALLOON_S_MEMFREE  4   /* Total amount of free memory */
 #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
 #define VIRTIO_BALLOON_S_AVAIL    6   /* Available memory as in /proc */
-#define VIRTIO_BALLOON_S_NR       7
+#define VIRTIO_BALLOON_S_CACHES   7   /* Disk caches */
+#define VIRTIO_BALLOON_S_NR       8
=20
 /*
  * Memory statistics structure.
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index f2104bf..179c8f5 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -50,6 +50,7 @@ static const char *balloon_stat_names[] =3D {
    [VIRTIO_BALLOON_S_MEMFREE] =3D "stat-free-memory",
    [VIRTIO_BALLOON_S_MEMTOT] =3D "stat-total-memory",
    [VIRTIO_BALLOON_S_AVAIL] =3D "stat-available-memory",
+   [VIRTIO_BALLOON_S_CACHES] =3D "stat-disk-caches",
    [VIRTIO_BALLOON_S_NR] =3D NULL
 };
=20
--=20
MST
