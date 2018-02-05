Received: from eggs.gnu.org ([2001:4830:134:3::10]:44385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimRy-00049v-JM
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimRx-0004qW-DR
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:10 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:50511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimRx-0004pw-5k
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:09 -0500
Received: by mail-wm0-x244.google.com with SMTP id f71so28282268wmf.0
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:09 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:16 +0100
Message-Id: <1517858941-5538-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/47] qdev: rename typedef qdev_resetfn() ->
 DeviceReset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

following the DeviceRealize and DeviceUnrealize typedefs,
this unify a bit the new QOM API.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180114020412.26160-2-f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/qdev-core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 51473ee..85fa26d 100644
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
1.8.3.1
