Received: from eggs.gnu.org ([2001:4830:134:3::10]:35142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g76XS-00041R-Q7
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 18:19:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g76OZ-0007QM-Br
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 18:10:30 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g76OW-0007Mh-8t
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 18:10:24 -0400
Received: by mail-wm1-x341.google.com with SMTP id 206-v6so276579wmb.5
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 15:10:12 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  2 Oct 2018 00:09:35 +0200
Message-Id: <20181001220942.2382-9-f4bug@amsat.org>
In-Reply-To: <20181001220942.2382-1-f4bug@amsat.org>
References: <20181001220942.2382-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 08/15] hw/mips/gt64xxx_pci: Mark as bridge
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>

The gt64120 is currently listed as uncategorized device.
Mark it as bridge device.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/gt64xxx_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index dcd1a66329..1cd8aac658 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -1232,6 +1232,7 @@ static void gt64120_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->reset = gt64120_reset;
     dc->vmsd = &vmstate_gt64120;
 }
-- 
2.19.0
