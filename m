Received: from eggs.gnu.org ([2001:4830:134:3::10]:35563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <miika9764@gmail.com>) id 1eQvPy-0003Ih-A6
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:25:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <miika9764@gmail.com>) id 1eQvPv-0007eL-Is
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:25:18 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:41490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <miika9764@gmail.com>) id 1eQvPv-0007df-BP
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:25:15 -0500
Received: by mail-lf0-x243.google.com with SMTP id f18so17727324lfg.8
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 05:25:15 -0800 (PST)
From: Miika S <miika9764@gmail.com>
Date: Mon, 18 Dec 2017 15:24:38 +0200
Message-Id: <20171218132439.2772-2-miika9764@gmail.com>
In-Reply-To: <20171218132439.2772-1-miika9764@gmail.com>
References: <20171218132439.2772-1-miika9764@gmail.com>
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
Cc: Miika S <miika9764@gmail.com>

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
