Received: from eggs.gnu.org ([2001:4830:134:3::10]:35090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZN3-0000wa-IW
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:02:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZN0-0003na-CF
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:02:57 -0500
Received: from mail-cys01nam02on0085.outbound.protection.outlook.com
	([104.47.37.85]:43670
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eCZN0-0003nP-39
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:02:54 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 8 Nov 2017 14:58:45 -0800
Message-ID: <0dd38e3350c564a1a6ffc2ce48085877fa8c977a.1510181732.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1510181732.git.alistair.francis@xilinx.com>
References: <cover.1510181732.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 38/45] hw/timer: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_=
report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_re=
port("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report=
("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("=
\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1=
"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\=
2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2)=
;|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|=
Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig=
}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}'=
 \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +

Some lines where then manually tweaked to pass checkpatch.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
V2:
 - Split hw patch into individual directories

 hw/timer/omap_gptimer.c | 11 ++++++-----
 hw/timer/twl92230.c     |  2 +-
 hw/timer/xilinx_timer.c |  8 ++++----
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/hw/timer/omap_gptimer.c b/hw/timer/omap_gptimer.c
index ae2dc99832..0f064241d3 100644
--- a/hw/timer/omap_gptimer.c
+++ b/hw/timer/omap_gptimer.c
@@ -18,6 +18,7 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "qemu/timer.h"
 #include "hw/arm/omap.h"
@@ -356,7 +357,7 @@ static void omap_gp_timer_write(void *opaque, hwaddr ad=
dr,
     case 0x10:	/* TIOCP_CFG */
         s->config =3D value & 0x33d;
         if (((value >> 3) & 3) =3D=3D 3)				/* IDLEMODE */
-            fprintf(stderr, "%s: illegal IDLEMODE value in TIOCP_CFG\n",
+            error_report("%s: illegal IDLEMODE value in TIOCP_CFG",
                             __func__);
         if (value & 2)						/* SOFTRESET */
             omap_gp_timer_reset(s);
@@ -394,11 +395,11 @@ static void omap_gp_timer_write(void *opaque, hwaddr =
addr,
         s->ar =3D (value >> 1) & 1;
         s->st =3D (value >> 0) & 1;
         if (s->inout && s->trigger !=3D gpt_trigger_none)
-            fprintf(stderr, "%s: GP timer pin must be an output "
-                            "for this trigger mode\n", __func__);
+            error_report("%s: GP timer pin must be an output "
+                         "for this trigger mode", __func__);
         if (!s->inout && s->capture !=3D gpt_capture_none)
-            fprintf(stderr, "%s: GP timer pin must be an input "
-                            "for this capture mode\n", __func__);
+            error_report("%s: GP timer pin must be an input "
+                         "for this capture mode", __func__);
         if (s->trigger =3D=3D gpt_trigger_none)
             omap_gp_timer_out(s, s->scpwm);
         /* TODO: make sure this doesn't overflow 32-bits */
diff --git a/hw/timer/twl92230.c b/hw/timer/twl92230.c
index ef116c636c..18880884c6 100644
--- a/hw/timer/twl92230.c
+++ b/hw/timer/twl92230.c
@@ -614,7 +614,7 @@ static void menelaus_write(void *opaque, uint8_t addr, =
uint8_t value)
             break;
         rtc_badness:
         default:
-            fprintf(stderr, "%s: bad RTC_UPDATE value %02x\n",
+            error_report("%s: bad RTC_UPDATE value %02x",
                             __func__, value);
             s->status |=3D 1 << 10;				/* RTCERR */
             menelaus_update(s);
diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index 59439c05be..a80bba846b 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -127,7 +127,7 @@ timer_read(void *opaque, hwaddr addr, unsigned int size=
)
             break;
=20
     }
-    D(fprintf(stderr, "%s timer=3D%d %x=3D%x\n", __func__, timer, addr * 4=
, r));
+    D(error_report("%s timer=3D%d %x=3D%x", __func__, timer, addr * 4, r))=
;
     return r;
 }
=20
@@ -135,7 +135,7 @@ static void timer_enable(struct xlx_timer *xt)
 {
     uint64_t count;
=20
-    D(fprintf(stderr, "%s timer=3D%d down=3D%d\n", __func__,
+    D(error_report("%s timer=3D%d down=3D%d", __func__,
               xt->nr, xt->regs[R_TCSR] & TCSR_UDT));
=20
     ptimer_stop(xt->ptimer);
@@ -160,7 +160,7 @@ timer_write(void *opaque, hwaddr addr,
     addr >>=3D 2;
     timer =3D timer_from_addr(addr);
     xt =3D &t->timers[timer];
-    D(fprintf(stderr, "%s addr=3D%x val=3D%x (timer=3D%d off=3D%d)\n",
+    D(error_report("%s addr=3D%x val=3D%x (timer=3D%d off=3D%d)",
              __func__, addr * 4, value, timer, addr & 3));
     /* Further decoding to address a specific timers reg.  */
     addr &=3D 3;
@@ -197,7 +197,7 @@ static void timer_hit(void *opaque)
 {
     struct xlx_timer *xt =3D opaque;
     struct timerblock *t =3D xt->parent;
-    D(fprintf(stderr, "%s %d\n", __func__, xt->nr));
+    D(error_report("%s %d", __func__, xt->nr));
     xt->regs[R_TCSR] |=3D TCSR_TINT;
=20
     if (xt->regs[R_TCSR] & TCSR_ARHT)
--=20
2.14.1
