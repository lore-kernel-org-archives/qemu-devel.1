Received: from eggs.gnu.org ([209.51.188.92]:45794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNQ8j-0001ol-2M
	for qemu-devel@nongnu.org; Sun, 05 May 2019 19:01:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNQ8i-0002SA-4C
	for qemu-devel@nongnu.org; Sun, 05 May 2019 19:01:49 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon,  6 May 2019 01:01:40 +0200
Message-Id: <20190505230140.5661-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] hw/sd/sdcard: Use the available enums
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

We already define SDCardModes/SDCardStates as enums. Declare
the mode/state as enums too, this make gdb debugging sessions
friendlier: instead of numbers, the mode/state name is displayed.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/sd/sd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index aaab15f3868..a66b3d5b45e 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -96,8 +96,8 @@ struct SDState {
     BlockBackend *blk;
     bool spi;
=20
-    uint32_t mode;    /* current card mode, one of SDCardModes */
-    int32_t state;    /* current card state, one of SDCardStates */
+    enum SDCardModes mode;
+    enum SDCardStates state;
     uint32_t vhs;
     bool wp_switch;
     unsigned long *wp_groups;
@@ -1640,7 +1640,7 @@ static int cmd_valid_while_locked(SDState *sd, SDRe=
quest *req)
=20
 int sd_do_command(SDState *sd, SDRequest *req,
                   uint8_t *response) {
-    int last_state;
+    enum SDCardStates last_state;
     sd_rsp_type_t rtype;
     int rsplen;
=20
--=20
2.20.1
