Received: from eggs.gnu.org ([2001:4830:134:3::10]:57997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFfnh-00032G-Nw
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFfnf-00007r-B7
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:35:49 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 25 Oct 2018 10:32:35 -0300
Message-Id: <20181025133301.16578-18-ehabkost@redhat.com>
In-Reply-To: <20181025133301.16578-1-ehabkost@redhat.com>
References: <20181025133301.16578-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL v2 17/43] memory-device: fix alignment error
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

We're missing "x" after the leading 0.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20181005092024.14344-2-david@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/mem/memory-device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 6de4f70bb4..0b52fe2c5e 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -120,7 +120,7 @@ uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
 
     /* address_space_start indicates the maximum alignment we expect */
     if (QEMU_ALIGN_UP(address_space_start, align) != address_space_start) {
-        error_setg(errp, "the alignment (0%" PRIx64 ") is not supported",
+        error_setg(errp, "the alignment (0x%" PRIx64 ") is not supported",
                    align);
         return 0;
     }
-- 
2.18.0.rc1.1.g3f1ff2140
