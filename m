Received: from eggs.gnu.org ([2001:4830:134:3::10]:51932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu7Cb-00058a-6W
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu7Ca-0006zd-BS
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:47:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cu7Ca-0006yw-69
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:47:36 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 31 Mar 2017 21:46:18 -0300
Message-Id: <20170401004624.30886-14-ehabkost@redhat.com>
In-Reply-To: <20170401004624.30886-1-ehabkost@redhat.com>
References: <20170401004624.30886-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 13/19] unimplemented-device: Remove
 user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>

unimplemented-device needs to be created and mapped using
create_unimplemented_device(), and won't work with -device.
Remove the user_creatable flag from the device class.

Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/misc/unimp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/misc/unimp.c b/hw/misc/unimp.c
index 284f096beb..bcbb585888 100644
--- a/hw/misc/unimp.c
+++ b/hw/misc/unimp.c
@@ -90,11 +90,6 @@ static void unimp_class_init(ObjectClass *klass, void *data)
 
     dc->realize = unimp_realize;
     dc->props = unimp_properties;
-    /*
-     * FIXME: Set only for compatibility on q35 machine-type.
-     * Probably never meant to be user-creatable
-     */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo unimp_info = {
-- 
2.11.0.259.g40922b1
