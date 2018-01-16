Received: from eggs.gnu.org ([2001:4830:134:3::10]:59550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebR6j-0003XC-NO
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:16:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebR6e-0007mN-Nv
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:16:53 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:37524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebR6e-0007ld-I5
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:16:48 -0500
Received: by mail-qt0-x242.google.com with SMTP id d54so6062236qtd.4
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 05:16:48 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 16 Jan 2018 10:15:54 -0300
Message-Id: <20180116131555.14242-11-f4bug@amsat.org>
In-Reply-To: <20180116131555.14242-1-f4bug@amsat.org>
References: <20180116131555.14242-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 10/11] qdev: remove empty realize/unrealize
 stubs
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

they are not useful, keep the code clean.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/core/qdev.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 985f890a74..91ddbfa5f3 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -219,14 +219,6 @@ void device_listener_unregister(DeviceListener *listener)
     QTAILQ_REMOVE(&device_listeners, listener, link);
 }
 
-static void device_realize(DeviceState *dev, Error **errp)
-{
-}
-
-static void device_unrealize(DeviceState *dev, Error **errp)
-{
-}
-
 void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
                                  int required_for_version)
 {
@@ -1109,8 +1101,6 @@ static void device_class_init(ObjectClass *class, void *data)
     DeviceClass *dc = DEVICE_CLASS(class);
 
     class->unparent = device_unparent;
-    dc->realize = device_realize;
-    dc->unrealize = device_unrealize;
 
     /* by default all devices were considered as hotpluggable,
      * so with intent to check it in generic qdev_unplug() /
-- 
2.15.1
