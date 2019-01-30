Received: from eggs.gnu.org ([209.51.188.92]:36761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1goppi-0001NT-1A
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:23:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1goppf-0006PB-OX
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:23:13 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 30 Jan 2019 14:22:05 +0100
Message-Id: <20190130132214.25493-5-laurent@vivier.eu>
In-Reply-To: <20190130132214.25493-1-laurent@vivier.eu>
References: <20190130132214.25493-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/13] hw: sd: set category of the sd memory card
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jiri Slaby <jslaby@suse.cz>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Stefan Hajnoczi <stefanha@redhat.com>, Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, kumar sourav <sourav.jb1988@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>

From: kumar sourav <sourav.jb1988@gmail.com>

Sets the category of the sd memory card as DEVICE_CATEGORY_STORAGE.
Devices should be assigned to one of DEVICE_CATEGORY_XXXX.

Signed-off-by: kumar sourav <sourav.jb1988@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190124162045.10474-1-sourav.jb1988@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/sd/sd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d4356e9b73..aaab15f386 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2121,6 +2121,7 @@ static void sd_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &sd_vmstate;
     dc->reset = sd_reset;
     dc->bus_type = TYPE_SD_BUS;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 
     sc->set_voltage = sd_set_voltage;
     sc->get_dat_lines = sd_get_dat_lines;
-- 
2.20.1
