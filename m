Received: from eggs.gnu.org ([209.51.188.92]:44858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz53-0005gn-Rk
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz4y-0007Y9-48
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1giz4x-0007XV-To
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:48 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 14 Jan 2019 11:02:10 +0100
Message-Id: <1547460140-1473-16-git-send-email-thuth@redhat.com>
In-Reply-To: <1547460140-1473-1-git-send-email-thuth@redhat.com>
References: <1547460140-1473-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/25] hw/bt: Remove HCIInfo from
 "qemu/typedefs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Li Qiang <liq3ea@163.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Files requiring HCIInfo already include "sysemu/bt.h".

To clean "qemu/typedefs.h", move the declaration to "sysemu/bt.h"
(removing the forward declaration).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/qemu/typedefs.h | 1 -
 include/sysemu/bt.h     | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 26e40fd..7271e98 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -35,7 +35,6 @@ typedef struct FWCfgEntry FWCfgEntry;
 typedef struct FWCfgIoState FWCfgIoState;
 typedef struct FWCfgMemState FWCfgMemState;
 typedef struct FWCfgState FWCfgState;
-typedef struct HCIInfo HCIInfo;
 typedef struct HVFX86EmulatorState HVFX86EmulatorState;
 typedef struct I2CBus I2CBus;
 typedef struct I2SCodec I2SCodec;
diff --git a/include/sysemu/bt.h b/include/sysemu/bt.h
index ddb05cd..2fd8c0f 100644
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
1.8.3.1
