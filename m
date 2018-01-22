Received: from eggs.gnu.org ([2001:4830:134:3::10]:51548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1edaml-0001jd-Q5
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:01:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1edamh-0005uk-BD
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:01:11 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 22 Jan 2018 13:00:40 +0100
Message-Id: <20180122120045.13538-5-cohuck@redhat.com>
In-Reply-To: <20180122120045.13538-1-cohuck@redhat.com>
References: <20180122120045.13538-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 4/9] hw/s390x: Replace fprintf(stderr,
 "*\n" with qemu_log_mask()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Alistair Francis <alistair.francis@xilinx.com>, Cornelia Huck <cohuck@redhat.com>

From: Alistair Francis <alistair.francis@xilinx.com>

One fprintf(stderr, was manually converted to a
qemu_log_mask(LOG_GUEST_ERROR,

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <3f49c0ff601f27534d4536c87c00d01c233e067f.1513790495.git.alistair.francis@xilinx.com>
[CH: tweaked commit message]
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/virtio-ccw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 38f6a8afc9..3d8f26949b 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -426,8 +426,9 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
                  * passes us zeroes for those we don't support.
                  */
                 if (features.features) {
-                    fprintf(stderr, "Guest bug: features[%i]=%x (expected 0)\n",
-                            features.index, features.features);
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "Guest bug: features[%i]=%x (expected 0)",
+                                  features.index, features.features);
                     /* XXX: do a unit check here? */
                 }
             }
-- 
2.13.6
