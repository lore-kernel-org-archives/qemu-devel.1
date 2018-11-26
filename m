Received: from eggs.gnu.org ([2001:4830:134:3::10]:48215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gRLcy-0000fu-BU
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:29:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gRLcv-0005jK-5X
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:29:00 -0500
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:46995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gRLcu-0005iv-VA
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:28:57 -0500
Received: by mail-io1-xd44.google.com with SMTP id v10so9118995ios.13
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 10:28:56 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 26 Nov 2018 12:28:44 -0600
Message-Id: <20181126182844.23109-1-minyard@acm.org>
Subject: [Qemu-devel] [PATCH] pc:piix4: Update smbus I/O space after a
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Otherwise it won't be set up correctly and won't work after
miigration.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/piix4.c | 1 +
 1 file changed, 1 insertion(+)

A rather obvious fix, in hindsight :).

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index e330f24c71..2f4dd03b83 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -173,6 +173,7 @@ static int vmstate_acpi_post_load(void *opaque, int version_id)
     PIIX4PMState *s = opaque;
 
     pm_io_space_update(s);
+    smbus_io_space_update(s);
     return 0;
 }
 
-- 
2.17.1
