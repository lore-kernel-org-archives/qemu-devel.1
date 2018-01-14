Received: from eggs.gnu.org ([2001:4830:134:3::10]:54227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaXfD-00075V-Ip
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 21:04:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaXfA-0006pH-63
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 21:04:47 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaXfA-0006p5-1z
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 21:04:44 -0500
Received: by mail-qt0-x241.google.com with SMTP id a16so10483451qtj.3
	for <qemu-devel@nongnu.org>; Sat, 13 Jan 2018 18:04:43 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Jan 2018 23:04:10 -0300
Message-Id: <20180114020412.26160-2-f4bug@amsat.org>
In-Reply-To: <20180114020412.26160-1-f4bug@amsat.org>
References: <20180114020412.26160-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 1/3] qdev: rename typedef qdev_resetfn() ->
 DeviceReset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

following the DeviceRealize and DeviceUnrealize typedefs,
this unify a bit the new QOM API.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/qdev-core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 0a71bf83f0..83db53b3f5 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -32,9 +32,9 @@ typedef enum DeviceCategory {
 
 typedef int (*qdev_initfn)(DeviceState *dev);
 typedef int (*qdev_event)(DeviceState *dev);
-typedef void (*qdev_resetfn)(DeviceState *dev);
 typedef void (*DeviceRealize)(DeviceState *dev, Error **errp);
 typedef void (*DeviceUnrealize)(DeviceState *dev, Error **errp);
+typedef void (*DeviceReset)(DeviceState *dev);
 typedef void (*BusRealize)(BusState *bus, Error **errp);
 typedef void (*BusUnrealize)(BusState *bus, Error **errp);
 
@@ -117,7 +117,7 @@ typedef struct DeviceClass {
     bool hotpluggable;
 
     /* callbacks */
-    void (*reset)(DeviceState *dev);
+    DeviceReset reset;
     DeviceRealize realize;
     DeviceUnrealize unrealize;
 
-- 
2.15.1
