Received: from eggs.gnu.org ([2001:4830:134:3::10]:58647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMFt4-000473-Kk
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMFt3-0002wZ-RN
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:48:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45632 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fMFt3-0002wM-Mp
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:48:17 -0400
Date: Fri, 25 May 2018 19:48:16 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527266793-301361-20-git-send-email-mst@redhat.com>
References: <1527266793-301361-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1527266793-301361-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 19/20] ui: use local path for local headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, peter.maydell@linaro.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Gerd Hoffmann <kraxel@redhat.com>

When pulling in headers that are in the same directory as C file (as
opposed to one in include/), we should use its relative path, without a
directory.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 ui/gtk.c          | 2 +-
 ui/input-keymap.c | 2 +-
 ui/input-legacy.c | 2 +-
 ui/spice-input.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index dbce970..903f136 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -66,7 +66,7 @@
 #define VC_SCALE_STEP   0.25
=20
 #ifdef GDK_WINDOWING_X11
-#include "ui/x_keymap.h"
+#include "x_keymap.h"
=20
 /* Gtk2 compat */
 #ifndef GDK_IS_X11_DISPLAY
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index 3d4e66b..87cc301 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
-#include "ui/keymaps.h"
+#include "keymaps.h"
 #include "ui/input.h"
=20
 #include "standard-headers/linux/input.h"
diff --git a/ui/input-legacy.c b/ui/input-legacy.c
index e5d4db1..549654e 100644
--- a/ui/input-legacy.c
+++ b/ui/input-legacy.c
@@ -26,7 +26,7 @@
 #include "qapi/qapi-commands-ui.h"
 #include "sysemu/sysemu.h"
 #include "ui/console.h"
-#include "ui/keymaps.h"
+#include "keymaps.h"
 #include "ui/input.h"
=20
 struct QEMUPutMouseEntry {
diff --git a/ui/spice-input.c b/ui/spice-input.c
index 3d41aa1..a426c03 100644
--- a/ui/spice-input.c
+++ b/ui/spice-input.c
@@ -23,7 +23,7 @@
 #include "qemu-common.h"
 #include "ui/qemu-spice.h"
 #include "ui/console.h"
-#include "ui/keymaps.h"
+#include "keymaps.h"
 #include "ui/input.h"
=20
 /* keyboard bits */
--=20
MST
