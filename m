Received: from eggs.gnu.org ([209.51.188.92]:48240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxe0-0005j5-Hg
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:18:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxWB-0003SF-6c
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:10:39 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 11 Jan 2019 15:08:49 +0100
Message-Id: <20190111140857.4211-8-philmd@redhat.com>
In-Reply-To: <20190111140857.4211-1-philmd@redhat.com>
References: <20190111140857.4211-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 07/15] hw/bt: Remove HCIInfo from
 "qemu/typedefs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-arm@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>

Files requiring HCIInfo already include "sysemu/bt.h".

To clean "qemu/typedefs.h", move the declaration to "sysemu/bt.h"
(removing the forward declaration).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/qemu/typedefs.h | 1 -
 include/sysemu/bt.h     | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 4524e14d03..92f9996107 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -31,7 +31,6 @@ typedef struct DriveInfo DriveInfo;
 typedef struct Error Error;
 typedef struct EventNotifier EventNotifier;
 typedef struct FlatView FlatView;
-typedef struct HCIInfo HCIInfo;
 typedef struct HVFX86EmulatorState HVFX86EmulatorState;
 typedef struct I2CBus I2CBus;
 typedef struct I2SCodec I2SCodec;
diff --git a/include/sysemu/bt.h b/include/sysemu/bt.h
index ddb05cd109..2fd8c0f14b 100644
--- a/include/sysemu/bt.h
+++ b/include/sysemu/bt.h
@@ -3,7 +3,7 @@
=20
 /* BT HCI info */
=20
-struct HCIInfo {
+typedef struct HCIInfo {
     int (*bdaddr_set)(struct HCIInfo *hci, const uint8_t *bd_addr);
     void (*cmd_send)(struct HCIInfo *hci, const uint8_t *data, int len);
     void (*sco_send)(struct HCIInfo *hci, const uint8_t *data, int len);
@@ -11,7 +11,7 @@ struct HCIInfo {
     void *opaque;
     void (*evt_recv)(void *opaque, const uint8_t *data, int len);
     void (*acl_recv)(void *opaque, const uint8_t *data, int len);
-};
+} HCIInfo;
=20
 /* bt-host.c */
 struct HCIInfo *bt_host_hci(const char *id);
--=20
2.17.2
