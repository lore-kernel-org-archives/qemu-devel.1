Received: from eggs.gnu.org ([2001:4830:134:3::10]:53213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eQ8N2-0004jQ-Df
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eQ8N1-000274-R4
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:03:00 -0500
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:58852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1eQ8N1-000265-JU
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:02:59 -0500
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Sat, 16 Dec 2017 10:02:28 +0100
Message-Id: <20171216090228.28505-16-hpoussin@reactos.org>
In-Reply-To: <20171216090228.28505-1-hpoussin@reactos.org>
References: <20171216090228.28505-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 15/15] piix4: we can now instanciate a PIIX4
 with -device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

Note that the PIC master can't be connected to CPU using the command line, but
it's not necessary to have a working ISA bus (for I/O, memory and DMA).

Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/isa/piix4.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 2e9aca6659..f520452d9d 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -255,12 +255,6 @@ static void piix4_class_init(ObjectClass *klass, void *data)
     k->class_id = PCI_CLASS_BRIDGE_ISA;
     dc->desc = "ISA bridge";
     dc->vmsd = &vmstate_piix4;
-    /*
-     * Reason: part of PIIX4 southbridge, needs to be wired up,
-     * e.g. by mips_malta_init()
-     */
-    dc->user_creatable = false;
-    dc->hotpluggable = false;
 }
 
 static const TypeInfo piix4_info = {
-- 
2.11.0
