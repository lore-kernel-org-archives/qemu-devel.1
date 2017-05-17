Received: from eggs.gnu.org ([2001:4830:134:3::10]:59296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dAzDk-0006BY-5K
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dAzDh-0004Mb-To
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:42:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dAzDh-0004M5-N8
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:42:29 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 17 May 2017 10:40:01 -0300
Message-Id: <20170517134003.17110-21-ehabkost@redhat.com>
In-Reply-To: <20170517134003.17110-1-ehabkost@redhat.com>
References: <20170517134003.17110-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 20/22] xen-sysdev: Remove user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Juergen Gross <jgross@suse.com>, Thomas Huth <thuth@redhat.com>, sstabellini@kernel.org, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>

TYPE_XENSYSDEV is only used internally by xen_be_init(), and is
not supposed to be plugged/unplugged dynamically. Remove the
user_creatable flag from the device class.

Cc: Juergen Gross <jgross@suse.com>,
Cc: Peter Maydell <peter.maydell@linaro.org>,
Cc: Thomas Huth <thuth@redhat.com>
Cc: sstabellini@kernel.org
Cc: Markus Armbruster <armbru@redhat.com>,
Cc: Marcel Apfelbaum <marcel@redhat.com>,
Cc: Laszlo Ersek <lersek@redhat.com>
Acked-by: Juergen Gross <jgross@suse.com>
Acked-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170503203604.31462-21-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/xen/xen_backend.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
index 8cc0e1e1e5..3570f37e56 100644
--- a/hw/xen/xen_backend.c
+++ b/hw/xen/xen_backend.c
@@ -664,11 +664,6 @@ static void xen_sysdev_class_init(ObjectClass *klass, void *data)
     k->init = xen_sysdev_init;
     dc->props = xen_sysdev_properties;
     dc->bus_type = TYPE_XENSYSBUS;
-    /*
-     * FIXME: Set only because we are not sure yet if this device
-     * will be outside the q35 sysbus whitelist.
-     */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo xensysdev_info = {
-- 
2.11.0.259.g40922b1
