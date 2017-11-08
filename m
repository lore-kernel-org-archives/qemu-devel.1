Received: from eggs.gnu.org ([2001:4830:134:3::10]:34263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZLm-00089h-Me
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:01:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZLj-0003Hd-HO
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:01:38 -0500
Received: from mail-sn1nam02on0061.outbound.protection.outlook.com
	([104.47.36.61]:61327
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eCZLj-0003H9-7B
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:01:35 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 8 Nov 2017 14:57:20 -0800
Message-ID: <f7d570fb50927d0e4d6515c7d914931ee50b9b41.1510181732.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1510181732.git.alistair.francis@xilinx.com>
References: <cover.1510181732.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 17/45] hw/input: Replace fprintf(stderr,
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
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +

Some lines where then manually tweaked to pass checkpatch.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
---
V2:
 - Split hw patch into individual directories

 hw/input/lm832x.c           |  6 ++--
 hw/input/pckbd.c            |  3 +-
 hw/input/pxa2xx_keypad.c    |  2 +-
 hw/input/tsc2005.c          | 17 +++++------
 hw/input/tsc210x.c          | 72 ++++++++++++++++++++++-----------------------
 hw/input/virtio-input-hid.c | 14 ++++-----
 hw/input/virtio-input.c     |  5 ++--
 7 files changed, 60 insertions(+), 59 deletions(-)

diff --git a/hw/input/lm832x.c b/hw/input/lm832x.c
index d39953126b..caeeda47f2 100644
--- a/hw/input/lm832x.c
+++ b/hw/input/lm832x.c
@@ -239,7 +239,7 @@ static uint8_t lm_kbd_read(LM823KbdState *s, int reg, int byte)
 
     default:
         lm_kbd_error(s, ERR_CMDUNK);
-        fprintf(stderr, "%s: unknown command %02x\n", __func__, reg);
+        error_report("%s: unknown command %02x", __func__, reg);
         return 0x00;
     }
 
@@ -330,7 +330,7 @@ static void lm_kbd_write(LM823KbdState *s, int reg, int byte, uint8_t value)
         s->reg = LM832x_GENERAL_ERROR;
         if ((value & 3) && (value & 3) != 3) {
             lm_kbd_error(s, ERR_BADPAR);
-            fprintf(stderr, "%s: invalid clock setting in RCPWM\n",
+            error_report("%s: invalid clock setting in RCPWM",
                             __func__);
         }
         /* TODO: Validate that the command is only issued once */
@@ -378,7 +378,7 @@ static void lm_kbd_write(LM823KbdState *s, int reg, int byte, uint8_t value)
         break;
     default:
         lm_kbd_error(s, ERR_CMDUNK);
-        fprintf(stderr, "%s: unknown command %02x\n", __func__, reg);
+        error_report("%s: unknown command %02x", __func__, reg);
         break;
     }
 }
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index c479f827b6..6fb5c4dbaa 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/isa/isa.h"
 #include "hw/i386/pc.h"
@@ -307,7 +308,7 @@ static void kbd_write_command(void *opaque, hwaddr addr,
         /* ignore that */
         break;
     default:
-        fprintf(stderr, "qemu: unsupported keyboard cmd=0x%02x\n", (int)val);
+        error_report("unsupported keyboard cmd=0x%02x", (int)val);
         break;
     }
 }
diff --git a/hw/input/pxa2xx_keypad.c b/hw/input/pxa2xx_keypad.c
index 93db9ed25b..0a594c30fc 100644
--- a/hw/input/pxa2xx_keypad.c
+++ b/hw/input/pxa2xx_keypad.c
@@ -326,7 +326,7 @@ void pxa27x_register_keypad(PXA2xxKeyPadState *kp,
                             const struct keymap *map, int size)
 {
     if(!map || size < 0x80) {
-        fprintf(stderr, "%s - No PXA keypad map defined\n", __func__);
+        error_report("%s - No PXA keypad map defined", __func__);
         exit(-1);
     }
 
diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index 7990954b6c..f5057e8eeb 100644
--- a/hw/input/tsc2005.c
+++ b/hw/input/tsc2005.c
@@ -200,17 +200,17 @@ static void tsc2005_write(TSC2005State *s, int reg, uint16_t data)
         s->host_mode = (data >> 15) != 0;
         if (s->enabled != !(data & 0x4000)) {
             s->enabled = !(data & 0x4000);
-            fprintf(stderr, "%s: touchscreen sense %sabled\n",
-                            __func__, s->enabled ? "en" : "dis");
+            error_report("%s: touchscreen sense %sabled",
+                         __func__, s->enabled ? "en" : "dis");
             if (s->busy && !s->enabled)
                 timer_del(s->timer);
             s->busy = s->busy && s->enabled;
         }
         s->nextprecision = (data >> 13) & 1;
         s->timing[0] = data & 0x1fff;
-        if ((s->timing[0] >> 11) == 3)
-            fprintf(stderr, "%s: illegal conversion clock setting\n",
-                            __func__);
+        if ((s->timing[0] >> 11) == 3) {
+            error_report("%s: illegal conversion clock setting", __func__);
+        }
         break;
     case 0xd:	/* CFR1 */
         s->timing[1] = data & 0xf07;
@@ -221,8 +221,7 @@ static void tsc2005_write(TSC2005State *s, int reg, uint16_t data)
         break;
 
     default:
-        fprintf(stderr, "%s: write into read-only register %x\n",
-                        __func__, reg);
+        error_report("%s: write into read-only register %x", __func__, reg);
     }
 }
 
@@ -337,8 +336,8 @@ static uint8_t tsc2005_txrx_word(void *opaque, uint8_t value)
                 s->nextprecision = (value >> 2) & 1;
                 if (s->enabled != !(value & 1)) {
                     s->enabled = !(value & 1);
-                    fprintf(stderr, "%s: touchscreen sense %sabled\n",
-                                    __func__, s->enabled ? "en" : "dis");
+                    error_report("%s: touchscreen sense %sabled",
+                                 __func__, s->enabled ? "en" : "dis");
                     if (s->busy && !s->enabled)
                         timer_del(s->timer);
                     s->busy = s->busy && s->enabled;
diff --git a/hw/input/tsc210x.c b/hw/input/tsc210x.c
index 1cad57f644..65c7569723 100644
--- a/hw/input/tsc210x.c
+++ b/hw/input/tsc210x.c
@@ -396,8 +396,8 @@ static uint16_t tsc2102_data_register_read(TSC210xState *s, int reg)
 
     default:
 #ifdef TSC_VERBOSE
-        fprintf(stderr, "tsc2102_data_register_read: "
-                        "no such register: 0x%02x\n", reg);
+        error_report("tsc2102_data_register_read: "
+                     "no such register: 0x%02x", reg);
 #endif
         return 0xffff;
     }
@@ -447,8 +447,8 @@ static uint16_t tsc2102_control_register_read(
     default:
     bad_reg:
 #ifdef TSC_VERBOSE
-        fprintf(stderr, "tsc2102_control_register_read: "
-                        "no such register: 0x%02x\n", reg);
+        error_report("tsc2102_control_register_read: "
+                     "no such register: 0x%02x", reg);
 #endif
         return 0xffff;
     }
@@ -528,8 +528,8 @@ static uint16_t tsc2102_audio_register_read(TSC210xState *s, int reg)
 
     default:
 #ifdef TSC_VERBOSE
-        fprintf(stderr, "tsc2102_audio_register_read: "
-                        "no such register: 0x%02x\n", reg);
+        error_report("tsc2102_audio_register_read: "
+                     "no such register: 0x%02x", reg);
 #endif
         return 0xffff;
     }
@@ -553,8 +553,8 @@ static void tsc2102_data_register_write(
 
     default:
 #ifdef TSC_VERBOSE
-        fprintf(stderr, "tsc2102_data_register_write: "
-                        "no such register: 0x%02x\n", reg);
+        error_report("tsc2102_data_register_write: "
+                     "no such register: 0x%02x", reg);
 #endif
     }
 }
@@ -606,8 +606,8 @@ static void tsc2102_control_register_write(
             tsc210x_reset(s);
 #ifdef TSC_VERBOSE
         } else {
-            fprintf(stderr, "tsc2102_control_register_write: "
-                            "wrong value written into RESET\n");
+            error_report("tsc2102_control_register_write: "
+                         "wrong value written into RESET");
 #endif
         }
         return;
@@ -616,8 +616,8 @@ static void tsc2102_control_register_write(
         s->timing = value & 0x3f;
 #ifdef TSC_VERBOSE
         if (value & ~0x3f)
-            fprintf(stderr, "tsc2102_control_register_write: "
-                            "wrong value written into CONFIG\n");
+            error_report("tsc2102_control_register_write: "
+                         "wrong value written into CONFIG");
 #endif
         return;
 
@@ -637,8 +637,8 @@ static void tsc2102_control_register_write(
     default:
     bad_reg:
 #ifdef TSC_VERBOSE
-        fprintf(stderr, "tsc2102_control_register_write: "
-                        "no such register: 0x%02x\n", reg);
+        error_report("tsc2102_control_register_write: "
+                     "no such register: 0x%02x", reg);
 #endif
     }
 }
@@ -651,8 +651,8 @@ static void tsc2102_audio_register_write(
         s->audio_ctrl1 = value & 0x0f3f;
 #ifdef TSC_VERBOSE
         if ((value & ~0x0f3f) || ((value & 7) != ((value >> 3) & 7)))
-            fprintf(stderr, "tsc2102_audio_register_write: "
-                            "wrong value written into Audio 1\n");
+            error_report("tsc2102_audio_register_write: "
+                         "wrong value written into Audio 1");
 #endif
         tsc2102_audio_rate_update(s);
         tsc2102_audio_output_update(s);
@@ -661,8 +661,8 @@ static void tsc2102_audio_register_write(
     case 0x01:
 #ifdef TSC_VERBOSE
         if (value != 0xff00)
-            fprintf(stderr, "tsc2102_audio_register_write: "
-                            "wrong value written into reg 0x01\n");
+            error_report("tsc2102_audio_register_write: "
+                         "wrong value written into reg 0x01");
 #endif
         return;
 
@@ -674,8 +674,8 @@ static void tsc2102_audio_register_write(
     case 0x03:
 #ifdef TSC_VERBOSE
         if (value != 0x8b00)
-            fprintf(stderr, "tsc2102_audio_register_write: "
-                            "wrong value written into reg 0x03\n");
+            error_report("tsc2102_audio_register_write: "
+                         "wrong value written into reg 0x03");
 #endif
         return;
 
@@ -683,8 +683,8 @@ static void tsc2102_audio_register_write(
         s->audio_ctrl2 = value & 0xf7f2;
 #ifdef TSC_VERBOSE
         if (value & ~0xf7fd)
-            fprintf(stderr, "tsc2102_audio_register_write: "
-                            "wrong value written into Audio 2\n");
+            error_report("tsc2102_audio_register_write: "
+                         "wrong value written into Audio 2");
 #endif
         return;
 
@@ -695,8 +695,8 @@ static void tsc2102_audio_register_write(
         s->dac_power = value & 0x9543;
 #ifdef TSC_VERBOSE
         if ((value & ~0x9543) != 0x2aa0)
-            fprintf(stderr, "tsc2102_audio_register_write: "
-                            "wrong value written into Power\n");
+            error_report("tsc2102_audio_register_write: "
+                         "wrong value written into Power");
 #endif
         tsc2102_audio_rate_update(s);
         tsc2102_audio_output_update(s);
@@ -707,8 +707,8 @@ static void tsc2102_audio_register_write(
         s->audio_ctrl3 |= value & 0xf800;
 #ifdef TSC_VERBOSE
         if (value & ~0xf8c7)
-            fprintf(stderr, "tsc2102_audio_register_write: "
-                            "wrong value written into Audio 3\n");
+            error_report("tsc2102_audio_register_write: "
+                         "wrong value written into Audio 3");
 #endif
         tsc2102_audio_output_update(s);
         return;
@@ -740,8 +740,8 @@ static void tsc2102_audio_register_write(
         s->pll[0] = value & 0xfffc;
 #ifdef TSC_VERBOSE
         if (value & ~0xfffc)
-            fprintf(stderr, "tsc2102_audio_register_write: "
-                            "wrong value written into PLL 1\n");
+            error_report("tsc2102_audio_register_write: "
+                         "wrong value written into PLL 1");
 #endif
         return;
 
@@ -749,8 +749,8 @@ static void tsc2102_audio_register_write(
         s->pll[1] = value & 0xfffc;
 #ifdef TSC_VERBOSE
         if (value & ~0xfffc)
-            fprintf(stderr, "tsc2102_audio_register_write: "
-                            "wrong value written into PLL 2\n");
+            error_report("tsc2102_audio_register_write: "
+                         "wrong value written into PLL 2");
 #endif
         return;
 
@@ -758,15 +758,15 @@ static void tsc2102_audio_register_write(
         s->softstep = !(value & 0x4000);
 #ifdef TSC_VERBOSE
         if (value & ~0x4000)
-            fprintf(stderr, "tsc2102_audio_register_write: "
-                            "wrong value written into Audio 4\n");
+            error_report("tsc2102_audio_register_write: "
+                         "wrong value written into Audio 4");
 #endif
         return;
 
     default:
 #ifdef TSC_VERBOSE
-        fprintf(stderr, "tsc2102_audio_register_write: "
-                        "no such register: 0x%02x\n", reg);
+        error_report("tsc2102_audio_register_write: "
+                     "no such register: 0x%02x", reg);
 #endif
     }
 }
@@ -847,7 +847,7 @@ static uint16_t tsc210x_read(TSC210xState *s)
     uint16_t ret = 0x0000;
 
     if (!s->command)
-        fprintf(stderr, "tsc210x_read: SPI underrun!\n");
+        error_report("tsc210x_read: SPI underrun!");
 
     switch (s->page) {
     case TSC_DATA_REGISTERS_PAGE:
@@ -886,7 +886,7 @@ static void tsc210x_write(TSC210xState *s, uint16_t value)
         s->state = true;
     } else {
         if (s->command)
-            fprintf(stderr, "tsc210x_write: SPI overrun!\n");
+            error_report("tsc210x_write: SPI overrun!");
         else
             switch (s->page) {
             case TSC_DATA_REGISTERS_PAGE:
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index e78faec0b1..172ec2972b 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -209,8 +209,8 @@ static void virtio_input_handle_event(DeviceState *dev, QemuConsole *src,
             virtio_input_send(vinput, &event);
         } else {
             if (key->down) {
-                fprintf(stderr, "%s: unmapped key: %d [%s]\n", __func__,
-                        qcode, QKeyCode_str(qcode));
+                error_report("%s: unmapped key: %d [%s]", __func__,
+                             qcode, QKeyCode_str(qcode));
             }
         }
         break;
@@ -230,9 +230,9 @@ static void virtio_input_handle_event(DeviceState *dev, QemuConsole *src,
             virtio_input_send(vinput, &event);
         } else {
             if (btn->down) {
-                fprintf(stderr, "%s: unmapped button: %d [%s]\n", __func__,
-                        btn->button,
-                        InputButton_str(btn->button));
+                error_report("%s: unmapped button: %d [%s]", __func__,
+                             btn->button,
+                             InputButton_str(btn->button));
             }
         }
         break;
@@ -318,8 +318,8 @@ static void virtio_input_hid_handle_status(VirtIOInput *vinput,
         kbd_put_ledstate(vhid->ledstate);
         break;
     default:
-        fprintf(stderr, "%s: unknown type %d\n", __func__,
-                le16_to_cpu(event->type));
+        error_report("%s: unknown type %d", __func__,
+                     le16_to_cpu(event->type));
         break;
     }
 }
diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index 0e42f0d02c..fb5fa0a280 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -5,6 +5,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu/iov.h"
 #include "trace.h"
@@ -121,8 +122,8 @@ void virtio_input_add_config(VirtIOInput *vinput,
 
     if (virtio_input_find_config(vinput, config->select, config->subsel)) {
         /* should not happen */
-        fprintf(stderr, "%s: duplicate config: %d/%d\n",
-                __func__, config->select, config->subsel);
+        error_report("%s: duplicate config: %d/%d",
+                     __func__, config->select, config->subsel);
         abort();
     }
 
-- 
2.14.1
