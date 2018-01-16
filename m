Received: from eggs.gnu.org ([2001:4830:134:3::10]:59549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebR6j-0003XB-MZ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:16:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebR6h-0007pS-GI
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:16:53 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:42530)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebR6h-0007pK-Ca
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:16:51 -0500
Received: by mail-qk0-x241.google.com with SMTP id k201so5735177qke.9
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 05:16:51 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 16 Jan 2018 10:15:55 -0300
Message-Id: <20180116131555.14242-12-f4bug@amsat.org>
In-Reply-To: <20180116131555.14242-1-f4bug@amsat.org>
References: <20180116131555.14242-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 11/11] qdev: rename typedef qdev_resetfn() ->
 DeviceReset()
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

following the DeviceRealize and DeviceUnrealize typedefs,
this unify a bit the QOM API.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/qdev-core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index de7fe2e6e0..8d15da1c52 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -30,9 +30,9 @@ typedef enum DeviceCategory {
     DEVICE_CATEGORY_MAX
 } DeviceCategory;
 
-typedef void (*qdev_resetfn)(DeviceState *dev);
 typedef void (*DeviceRealize)(DeviceState *dev, Error **errp);
 typedef void (*DeviceUnrealize)(DeviceState *dev, Error **errp);
+typedef void (*DeviceReset)(DeviceState *dev);
 typedef void (*BusRealize)(BusState *bus, Error **errp);
 typedef void (*BusUnrealize)(BusState *bus, Error **errp);
 
@@ -115,7 +115,7 @@ typedef struct DeviceClass {
     bool hotpluggable;
 
     /* callbacks */
-    void (*reset)(DeviceState *dev);
+    DeviceReset reset;
     DeviceRealize realize;
     DeviceUnrealize unrealize;
 
-- 
2.15.1
