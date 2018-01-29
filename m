Received: from eggs.gnu.org ([2001:4830:134:3::10]:45366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eg6b6-0006Pv-2j
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:23:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eg6b1-0001WO-DJ
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:23:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eg6b1-0001VV-71
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:23:27 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 Jan 2018 11:23:14 +0100
Message-Id: <20180129102320.21534-2-kraxel@redhat.com>
In-Reply-To: <20180129102320.21534-1-kraxel@redhat.com>
References: <20180129102320.21534-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/7] input: add mouse side buttons to virtio
 input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Miika S <miika9764@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

From: Miika S <miika9764@gmail.com>

Signed-off-by: Miika S <miika9764@gmail.com>
Message-Id: <20171222152531.1849-3-miika9764@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/input/virtio-input-hid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index e78faec0b1..a5917c2754 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -147,6 +147,8 @@ static const unsigned int keymap_button[INPUT_BUTTON__MAX] = {
     [INPUT_BUTTON_MIDDLE]            = BTN_MIDDLE,
     [INPUT_BUTTON_WHEEL_UP]          = BTN_GEAR_UP,
     [INPUT_BUTTON_WHEEL_DOWN]        = BTN_GEAR_DOWN,
+    [INPUT_BUTTON_SIDE]              = BTN_SIDE,
+    [INPUT_BUTTON_EXTRA]             = BTN_EXTRA,
 };
 
 static const unsigned int axismap_rel[INPUT_AXIS__MAX] = {
-- 
2.9.3
