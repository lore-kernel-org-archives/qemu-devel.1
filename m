Received: from eggs.gnu.org ([2001:4830:134:3::10]:35160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g76XN-00041Z-2v
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 18:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g76Oc-0007Rm-QY
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 18:10:31 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:55767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g76Oc-0007OM-Ho
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 18:10:30 -0400
Received: by mail-wm1-x330.google.com with SMTP id 206-v6so276746wmb.5
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 15:10:19 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  2 Oct 2018 00:09:41 +0200
Message-Id: <20181001220942.2382-15-f4bug@amsat.org>
In-Reply-To: <20181001220942.2382-1-f4bug@amsat.org>
References: <20181001220942.2382-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 14/15] hw/hppa/dino: Remove unuseful code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/hppa/dino.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index 564b938e3a..31e09942b5 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -488,17 +488,10 @@ PCIBus *dino_init(MemoryRegion *addr_space,
     return b;
 }
 
-static int dino_pcihost_init(SysBusDevice *dev)
-{
-    return 0;
-}
-
 static void dino_pcihost_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    k->init = dino_pcihost_init;
     dc->vmsd = &vmstate_dino;
 }
 
-- 
2.19.0
