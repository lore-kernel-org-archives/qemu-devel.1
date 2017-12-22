Received: from eggs.gnu.org ([2001:4830:134:3::10]:60792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <miika9764@gmail.com>) id 1eSPDG-0003Mt-Vw
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:26:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <miika9764@gmail.com>) id 1eSPDG-0001LM-6E
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:26:19 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:39555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <miika9764@gmail.com>) id 1eSPDF-0001Kh-Ua
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:26:18 -0500
Received: by mail-lf0-x244.google.com with SMTP id m20so18783708lfi.6
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 07:26:17 -0800 (PST)
From: Miika S <miika9764@gmail.com>
Date: Fri, 22 Dec 2017 17:25:30 +0200
Message-Id: <20171222152531.1849-3-miika9764@gmail.com>
In-Reply-To: <20171222152531.1849-1-miika9764@gmail.com>
References: <20171222152531.1849-1-miika9764@gmail.com>
Subject: [Qemu-devel] [PATCH 2/3] input: add mouse side buttons to virtio
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
Cc: kraxel@redhat.com, berrange@redhat.com, Miika S <miika9764@gmail.com>

Signed-off-by: Miika S <miika9764@gmail.com>
---
 hw/input/virtio-input-hid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 9628d289f9..2cac659469 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -154,6 +154,8 @@ static const unsigned int keymap_button[INPUT_BUTTON__MAX] = {
     [INPUT_BUTTON_MIDDLE]            = BTN_MIDDLE,
     [INPUT_BUTTON_WHEEL_UP]          = BTN_GEAR_UP,
     [INPUT_BUTTON_WHEEL_DOWN]        = BTN_GEAR_DOWN,
+    [INPUT_BUTTON_SIDE]              = BTN_SIDE,
+    [INPUT_BUTTON_EXTRA]             = BTN_EXTRA,
 };
 
 static const unsigned int axismap_rel[INPUT_AXIS__MAX] = {
-- 
2.15.1
