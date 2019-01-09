Received: from eggs.gnu.org ([209.51.188.92]:46915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghDeZ-0002zH-OY
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:12:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghDc4-0000NN-At
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:09:41 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  9 Jan 2019 14:08:40 +0100
Message-Id: <20190109130844.5172-3-laurent@vivier.eu>
In-Reply-To: <20190109130844.5172-1-laurent@vivier.eu>
References: <20190109130844.5172-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/6] hw/core: fix whitespace in a sentence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Anthony Green <green@moxielogic.com>, John Snow <jsnow@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, qemu-ppc@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=83=C2=A9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>

From: Wainer dos Santos Moschetta <wainersm@redhat.com>

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20181224154922.3338-1-wainersm@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/core/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index f8563efb86..1a0a9ab111 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -919,7 +919,7 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_add_bool(oc, "dump-guest-core",
         machine_get_dump_guest_core, machine_set_dump_guest_core, &error_abort);
     object_class_property_set_description(oc, "dump-guest-core",
-        "Include guest memory in  a core dump", &error_abort);
+        "Include guest memory in a core dump", &error_abort);
 
     object_class_property_add_bool(oc, "mem-merge",
         machine_get_mem_merge, machine_set_mem_merge, &error_abort);
-- 
2.20.1
