Received: from eggs.gnu.org ([2001:4830:134:3::10]:47465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d1H8B-0002PN-Vb
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d1H88-0004lQ-Uo
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:48:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d1H88-0004lH-OL
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:48:36 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 20 Apr 2017 15:47:04 -0300
Message-Id: <20170420184705.25018-15-ehabkost@redhat.com>
In-Reply-To: <20170420184705.25018-1-ehabkost@redhat.com>
References: <20170420184705.25018-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 14/15] qdev: Constify value passed to
 qdev_prop_set_macaddr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Krzysztof Kozlowski <krzk@kernel.org>

From: Krzysztof Kozlowski <krzk@kernel.org>

The 'value' argument is not modified so this can be made const for code
safeness.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Message-Id: <20170310200550.13313-2-krzk@kernel.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/qdev-properties.h | 3 ++-
 hw/core/qdev-properties.c    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 7ac315331a..1d69fa7a8f 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -188,7 +188,8 @@ void qdev_prop_set_chr(DeviceState *dev, const char *name, Chardev *value);
 void qdev_prop_set_netdev(DeviceState *dev, const char *name, NetClientState *value);
 void qdev_prop_set_drive(DeviceState *dev, const char *name,
                          BlockBackend *value, Error **errp);
-void qdev_prop_set_macaddr(DeviceState *dev, const char *name, uint8_t *value);
+void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
+                           const uint8_t *value);
 void qdev_prop_set_enum(DeviceState *dev, const char *name, int value);
 /* FIXME: Remove opaque pointer properties.  */
 void qdev_prop_set_ptr(DeviceState *dev, const char *name, void *value);
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 6ab4265eb4..fa3617db2d 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1010,7 +1010,8 @@ void qdev_prop_set_string(DeviceState *dev, const char *name, const char *value)
     object_property_set_str(OBJECT(dev), value, name, &error_abort);
 }
 
-void qdev_prop_set_macaddr(DeviceState *dev, const char *name, uint8_t *value)
+void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
+                           const uint8_t *value)
 {
     char str[2 * 6 + 5 + 1];
     snprintf(str, sizeof(str), "%02x:%02x:%02x:%02x:%02x:%02x",
-- 
2.11.0.259.g40922b1
