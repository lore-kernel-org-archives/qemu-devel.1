Received: from eggs.gnu.org ([2001:4830:134:3::10]:59456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebR6d-0003QX-DN
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:16:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebR6X-0007dU-S3
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:16:47 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:39546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebR6X-0007co-Oh
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:16:41 -0500
Received: by mail-qt0-x243.google.com with SMTP id k19so18149307qtj.6
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 05:16:41 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 16 Jan 2018 10:15:52 -0300
Message-Id: <20180116131555.14242-9-f4bug@amsat.org>
In-Reply-To: <20180116131555.14242-1-f4bug@amsat.org>
References: <20180116131555.14242-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 08/11] qdev: remove DeviceClass::init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

it has no more users.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/qdev-core.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 0a71bf83f0..de063b232f 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -30,7 +30,6 @@ typedef enum DeviceCategory {
     DEVICE_CATEGORY_MAX
 } DeviceCategory;
 
-typedef int (*qdev_initfn)(DeviceState *dev);
 typedef int (*qdev_event)(DeviceState *dev);
 typedef void (*qdev_resetfn)(DeviceState *dev);
 typedef void (*DeviceRealize)(DeviceState *dev, Error **errp);
@@ -125,7 +124,6 @@ typedef struct DeviceClass {
     const struct VMStateDescription *vmsd;
 
     /* Private to qdev / bus.  */
-    qdev_initfn init; /* TODO remove, once users are converted to realize */
     qdev_event exit; /* TODO remove, once users are converted to unrealize */
     const char *bus_type;
 } DeviceClass;
-- 
2.15.1
