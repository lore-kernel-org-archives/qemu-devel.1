Received: from eggs.gnu.org ([2001:4830:134:3::10]:41486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQ4k-0004ia-SM
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:41:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQ4j-0003FP-QN
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:41:10 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Sep 2017 12:39:51 -0300
Message-Id: <20170922154014.29350-12-f4bug@amsat.org>
In-Reply-To: <20170922154014.29350-1-f4bug@amsat.org>
References: <20170922154014.29350-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 11/34] i386/pc: use TYPE_PORT92
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/i386/pc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 05985d4927..f116cede91 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1577,7 +1577,7 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
         qdev_prop_set_ptr(dev, "ps2_mouse", i8042);
         qdev_init_nofail(dev);
     }
-    port92 = isa_create_simple(isa_bus, "port92");
+    port92 = isa_create_simple(isa_bus, TYPE_PORT92);
     port92_init(port92, a20_line[1]);
     g_free(a20_line);
 
-- 
2.14.1
