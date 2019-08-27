Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AE8C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 19:26:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C6022186A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 19:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C6022186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2h6s-0000Zv-NC
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 15:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i2h66-0000An-2a
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 15:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i2h63-0003P3-Hx
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 15:25:41 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:38549)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i2h63-0003Ku-5N
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 15:25:39 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mae7u-1ieVgR3bru-00cA8a; Tue, 27 Aug 2019 21:25:30 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 21:25:26 +0200
Message-Id: <20190827192526.21780-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:c6jN/412YU2hqpQX6X6ZNAEOBLSwZQcyUVQAAugPmh1YuAWg78Q
 Mnby1Z/V8jHgD5VzphyaIvUx2zxiB5bn8j3/rzlizEWL/HRPEokeZgJFuLKbFAELrqcBnak
 VCzgH81m2Ia2cOuM90VB0XrluyqJvaGZifuCxZF4uNI/43B0HBKrasy3/Up/ySx5JWzVAYo
 s64BX4QWDOt26/Px++LWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r+2nC0AsYtY=:ntZj7xALPN0cvmN+40hXNs
 9X6t5fJOf7xEIeBy0QxFTLEVzX1W+ZVwUcNK00tfECVc7DUqiMwfIpBfoFFEPA3SHdNgYkRPD
 +LcoOguEeSa6xFUCe+GU+fkeYXM0QrseBosk7cwBVBWtSEh+q78BbcCEdfYVxZbLs6vQlnULc
 vVjiMesvFjz8vt3hGBvKQwEbyz3iqnUoKSEN3t7Zpg8xBeDbajXbJvU9/G3VgsadIiFD939n3
 owcaCWPqS/RFqbgdUrpqbpCi88mk3LHXWf2y9uecGSROd+5E7V14FSUHJ83O/CraCKrG72zAq
 OGH95XNetjCFfyB2LlHmKCRd+Az9zVFNCOd6nCq/ggFm+kDQx6Y4aWu71X9vH3RrjGZzNj1bd
 lJ00Jhstds59wzo3ZGeF2DyeIh3kSQJaEajIHJ4qkTcz/D8mMzd7pjjXSPvM0t28xtfQ2xaJF
 mPMe3JAjAU6q0FIfQCKu0qTg92crEifmqXYagf7XZx4uFUE1AAzaAK+A1XFXnSrVtqG5ZwD9p
 lucO7S0ctGvJycfm/PVuSe/pSkqi1QrG/HShjO5W7oGBIc9iAeIC7dZ7vLB+LVPd1sZ8s32M2
 GJqNSosMhqCL7+mjQ7RODLsUpDEbZzJHyJOUd0Ym4EcCE0CLR3ioOvmC2rsURe/LbrCRJaMkU
 ml6SMaDBCwsuR1N+gKICfBNg47pVog1AprdnENde5mQSSwMsXiwDJubB/Fc1FFY1tMBDArpKi
 tejyZWxYeiVl7vOY1BoyfoqHCOWR/gMYqxJlpQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
Subject: [Qemu-devel] [RFC,Draft] ui: add an embedded Barrier client
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows to receive mouse and keyboard events from
a Barrier server.

This is enabled by adding the following parameter on the
command line

    ... -object input-barrier,id=$id,name=$name ...

Where $name is the name declared in the screens section of barrier.conf

The barrier server (barriers) must be configured and must run on the
local host.

For instance:

  section: screens
      localhost:
          ...
      VM-1:
          ...
      end

  section: links
      localhost:
          right = VM-1
      VM-1:
          left = localhost
  end

Then on the QEMU command line:

    ... -object input-barrier,id=barrie0,name=VM-1 ...

When the mouse will move out of the screen of the local host on
the right, the mouse and the keyboard will be grabbed and all
related events will be send to the guest OS.

This is usefull when qemu is configured without emulated graphic card
but with a VFIO attached graphic card.

More information about Barrier can be found at:

  https://github.com/debauchee/barrier

This avoids to install the Barrier server in the guest OS,
for instance when it is not supported or during the installation.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 ui/Makefile.objs   |   1 +
 ui/input-barrier.c | 639 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 640 insertions(+)
 create mode 100644 ui/input-barrier.c

diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index cc2bf5b180f3..95b69a87444d 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -9,6 +9,7 @@ vnc-obj-y += vnc-jobs.o
 
 common-obj-y += keymaps.o console.o cursor.o qemu-pixman.o
 common-obj-y += input.o input-keymap.o input-legacy.o kbd-state.o
+common-obj-y += input-barrier.o
 common-obj-$(CONFIG_LINUX) += input-linux.o
 common-obj-$(CONFIG_SPICE) += spice-core.o spice-input.o spice-display.o
 common-obj-$(CONFIG_COCOA) += cocoa.o
diff --git a/ui/input-barrier.c b/ui/input-barrier.c
new file mode 100644
index 000000000000..3fdcbc194f95
--- /dev/null
+++ b/ui/input-barrier.c
@@ -0,0 +1,639 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/main-loop.h"
+#include "qemu/sockets.h"
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
+#include "io/channel-socket.h"
+#include "ui/input.h"
+
+#define TYPE_INPUT_BARRIER "input-barrier"
+#define INPUT_BARRIER(obj) \
+    OBJECT_CHECK(InputBarrier, (obj), TYPE_INPUT_BARRIER)
+#define INPUT_BARRIER_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(InputBarrierClass, (obj), TYPE_INPUT_BARRIER)
+#define INPUT_BARRIER_CLASS(klass) \
+    OBJECT_CLASS_CHECK(InputBarrierClass, (klass), TYPE_INPUT_BARRIER)
+
+typedef struct InputBarrier InputBarrier;
+typedef struct InputBarrierClass InputBarrierClass;
+
+#define MAX_HELLO_LENGTH 1024
+
+struct InputBarrier {
+    Object parent;
+
+    QIOChannelSocket *sioc;
+    guint ioc_tag;
+
+    /* display properties */
+    char *name;
+
+    /*
+     * XXX:
+     * add x-origin, y-origin, width and height
+     * add Barrier server IP address and port
+     */
+
+    char buffer[MAX_HELLO_LENGTH];
+};
+
+struct InputBarrierClass {
+    ObjectClass parent_class;
+};
+
+/* Barrier protocol */
+#define BARRIER_VERSION_MAJOR 1
+#define BARRIER_VERSION_MINOR 6
+
+enum cmdids {
+    MSG_CNoop,
+    MSG_CClose,
+    MSG_CEnter,
+    MSG_CLeave,
+    MSG_CClipboard,
+    MSG_CScreenSaver,
+    MSG_CResetOptions,
+    MSG_CInfoAck,
+    MSG_CKeepAlive,
+    MSG_DKeyDown,
+    MSG_DKeyRepeat,
+    MSG_DKeyUp,
+    MSG_DMouseDown,
+    MSG_DMouseUp,
+    MSG_DMouseMove,
+    MSG_DMouseRelMove,
+    MSG_DMouseWheel,
+    MSG_DClipboard,
+    MSG_DInfo,
+    MSG_DSetOptions,
+    MSG_DFileTransfer,
+    MSG_DDragInfo,
+    MSG_QInfo,
+    MSG_EIncompatible,
+    MSG_EBusy,
+    MSG_EUnknown,
+    MSG_EBad,
+    /* connection sequence */
+    MSG_Hello,
+    MSG_HelloBack,
+};
+
+struct version {
+    int16_t major;
+    int16_t minor;
+};
+
+struct mousebutton {
+    int8_t buttonid;
+};
+
+struct enter {
+    int16_t x;
+    int16_t y;
+    int32_t seqn;
+    int16_t modifier;
+};
+
+struct mousepos {
+    int16_t x;
+    int16_t y;
+};
+
+struct key {
+    int16_t keyid;
+    int16_t modifier;
+    int16_t button;
+};
+
+struct repeat {
+    int16_t keyid;
+    int16_t modifier;
+    int16_t repeat;
+    int16_t button;
+};
+
+#define MAX_OPTIONS 32
+struct set {
+    int nb;
+    struct {
+        int id;
+        char nul;
+        int value;
+    } option[MAX_OPTIONS];
+};
+
+struct msg {
+    enum cmdids cmd;
+    union {
+        struct version version;
+        struct mousebutton mousebutton;
+        struct mousepos mousepos;
+        struct enter enter;
+        struct key key;
+        struct repeat repeat;
+        struct set set;
+    };
+};
+
+const char *cmd_names[] = {
+    [MSG_CNoop]          = "CNOP",
+    [MSG_CClose]         = "CBYE",
+    [MSG_CEnter]         = "CINN",
+    [MSG_CLeave]         = "COUT",
+    [MSG_CClipboard]     = "CCLP",
+    [MSG_CScreenSaver]   = "CSEC",
+    [MSG_CResetOptions]  = "CROP",
+    [MSG_CInfoAck]       = "CIAK",
+    [MSG_CKeepAlive]     = "CALV",
+    [MSG_DKeyDown]       = "DKDN",
+    [MSG_DKeyRepeat]     = "DKRP",
+    [MSG_DKeyUp]         = "DKUP",
+    [MSG_DMouseDown]     = "DMDN",
+    [MSG_DMouseUp]       = "DMUP",
+    [MSG_DMouseMove]     = "DMMV",
+    [MSG_DMouseRelMove]  = "DMRM",
+    [MSG_DMouseWheel]    = "DMWM",
+    [MSG_DClipboard]     = "DCLP",
+    [MSG_DInfo]          = "DINF",
+    [MSG_DSetOptions]    = "DSOP",
+    [MSG_DFileTransfer]  = "DFTR",
+    [MSG_DDragInfo]      = "DDRG",
+    [MSG_QInfo]          = "QINF",
+    [MSG_EIncompatible]  = "EICV",
+    [MSG_EBusy]          = "EBSY",
+    [MSG_EUnknown]       = "EUNK",
+    [MSG_EBad]           = "EBAD",
+    [MSG_Hello]          = "Barrier",
+    [MSG_HelloBack]      = "Barrier",
+};
+
+static char *read_char(char *p, char *v, int *len)
+{
+    if (*len < sizeof(char)) {
+        return NULL;
+    }
+
+    *v = *p;
+    p += sizeof(char);
+    *len -= sizeof(char);
+
+    return p;
+}
+
+static char *read_short(char *p, short *v, int *len)
+{
+    if (*len < sizeof(short)) {
+        return NULL;
+    }
+
+    *v = ntohs(*(short *)p);
+    p += sizeof(short);
+    *len -= sizeof(short);
+
+    return p;
+}
+
+static char *read_int(char *p, int *v, int *len)
+{
+    if (*len < sizeof(int)) {
+        return NULL;
+    }
+
+    *v = ntohl(*(int *)p);
+    p += sizeof(int);
+    *len -= sizeof(int);
+
+    return p;
+}
+static int readcmd(InputBarrier *ib, struct msg *msg)
+{
+    int ret, len, i;
+    enum cmdids cmd;
+    char *p;
+
+    ret = qio_channel_read(QIO_CHANNEL(ib->sioc), (char *)&len, sizeof(len),
+                           NULL);
+    if (ret < 0) {
+        return -1;
+    }
+
+    len = ntohl(len);
+    assert(len <= MAX_HELLO_LENGTH);
+
+    ret = qio_channel_read(QIO_CHANNEL(ib->sioc), ib->buffer, len, NULL);
+    if (ret < 0) {
+        return -1;
+    }
+
+    p = ib->buffer;
+    if (len >= strlen(cmd_names[MSG_Hello]) &&
+        memcmp(p, cmd_names[MSG_Hello], strlen(cmd_names[MSG_Hello])) == 0) {
+        cmd = MSG_Hello;
+        p += strlen(cmd_names[MSG_Hello]);
+        len -= strlen(cmd_names[MSG_Hello]);
+    } else {
+        for (cmd = 0; cmd < MSG_Hello; cmd++) {
+            if (memcmp(ib->buffer, cmd_names[cmd], 4) == 0) {
+                break;
+            }
+        }
+
+        if (cmd == MSG_Hello) {
+            return -2;
+        }
+        p += 4;
+        len -= 4;
+    }
+
+    msg->cmd = cmd;
+    switch (cmd) {
+    case MSG_Hello:
+        p = read_short(p, &msg->version.major, &len);
+        p = read_short(p, &msg->version.minor, &len);
+        break;
+    case MSG_DSetOptions:
+        p = read_int(p, &i, &len);
+        if (!p) {
+            break;
+        }
+        msg->set.nb = i / 2;
+        assert(msg->set.nb < MAX_OPTIONS);
+        i = 0;
+        while (len && i < msg->set.nb) {
+            p = read_int(p, &msg->set.option[i].id, &len);
+            /* it's a string, restore endianness */
+            msg->set.option[i].id = htonl(msg->set.option[i].id);
+            msg->set.option[i].nul = 0;
+            p = read_int(p, &msg->set.option[i].value, &len);
+            i++;
+        }
+        break;
+    case MSG_DMouseMove:
+    case MSG_DMouseRelMove:
+        p = read_short(p, &msg->mousepos.x, &len);
+        p = read_short(p, &msg->mousepos.y, &len);
+        break;
+    case MSG_DKeyDown:
+    case MSG_DKeyUp:
+        p = read_short(p, &msg->key.keyid, &len);
+        p = read_short(p, &msg->key.modifier, &len);
+        msg->key.button = 0;
+        if (len) {
+            p = read_short(p, &msg->key.button, &len);
+        }
+        break;
+    case MSG_DKeyRepeat:
+        p = read_short(p, &msg->repeat.keyid, &len);
+        p = read_short(p, &msg->repeat.modifier, &len);
+        p = read_short(p, &msg->repeat.repeat, &len);
+        msg->repeat.button = 0;
+        if (len) {
+            p = read_short(p, &msg->repeat.button, &len);
+        }
+        break;
+    case MSG_DMouseDown:
+    case MSG_DMouseUp:
+        p = read_char(p, (char *)&msg->mousebutton.buttonid, &len);
+        break;
+    case MSG_DMouseWheel:
+        p = read_short(p, &msg->mousepos.x, &len);
+        msg->mousepos.y = 0;
+        if (len) {
+            p = read_short(p, &msg->mousepos.y, &len);
+        }
+        break;
+    case MSG_QInfo:
+    case MSG_CInfoAck:
+    case MSG_CResetOptions:
+    case MSG_CEnter:
+    case MSG_DClipboard:
+    case MSG_CKeepAlive:
+    case MSG_CLeave:
+    case MSG_CClose:
+        break;
+    /* Error codes */
+    case MSG_EIncompatible:
+        p = read_short(p, &msg->version.major, &len);
+        p = read_short(p, &msg->version.minor, &len);
+        break;
+    case MSG_EBusy:
+    case MSG_EUnknown:
+    case MSG_EBad:
+        break;
+    default:
+        return -2;
+    }
+
+    return 0;
+}
+
+static int free_space(InputBarrier *ib, char *p)
+{
+    return MAX_HELLO_LENGTH - (p - ib->buffer);
+}
+
+static char *write_short(InputBarrier *ib, char *p, short v)
+{
+    if (free_space(ib, p) < sizeof(short)) {
+        return NULL;
+    }
+
+    *(short *)p = htons(v);
+    p += sizeof(short);
+
+    return p;
+}
+
+static char *write_int(InputBarrier *ib, char *p, int v)
+{
+    if (free_space(ib, p) < sizeof(int)) {
+        return NULL;
+    }
+
+    *(int *)p = htonl(v);
+    p += sizeof(int);
+
+    return p;
+}
+
+static char *write_cmd(InputBarrier *ib, char *p, enum cmdids cmd)
+{
+    int len;
+
+    len = strlen(cmd_names[cmd]);
+
+    if (len > free_space(ib, p)) {
+        return NULL;
+    }
+
+    memcpy(p, cmd_names[cmd], len);
+    p += len;
+
+    return p;
+}
+
+static char *write_string(InputBarrier *ib, char *p, const char *s)
+{
+    int len;
+    int n = free_space(ib, p);
+
+    len = strlen(s);
+    if (n < sizeof(len)) {
+        return NULL;
+    }
+
+    *(int *)p = htonl(len);
+    p += sizeof(int);
+    n -= sizeof(int);
+
+    if (len > n) {
+        return NULL;
+    }
+
+    memcpy(p, s, len);
+    p += len;
+
+    return p;
+}
+
+static int input_barrier_to_qcode(uint16_t keyid)
+{
+    if (keyid >= 0xE000 && keyid <= 0xEFFF) {
+        keyid += 0x1000;
+    }
+
+    return qemu_input_map_x11_to_qcode[keyid];
+}
+
+static int input_barrier_to_mouse(uint8_t buttonid)
+{
+    switch (buttonid) {
+    case 1: return INPUT_BUTTON_LEFT;
+    case 2: return INPUT_BUTTON_MIDDLE;
+    case 3: return INPUT_BUTTON_RIGHT;
+    case 4: return INPUT_BUTTON_SIDE;
+    case 5: return INPUT_BUTTON_EXTRA;
+    }
+    return 0;
+}
+
+static gboolean input_barrier_event(QIOChannel *ioc G_GNUC_UNUSED,
+                                    GIOCondition condition, void *opaque)
+{
+    InputBarrier *ib = opaque;
+    struct msg msg;
+    char *p;
+    int ret, len;
+
+    ret = readcmd(ib, &msg);
+    if (ret < 0) {
+        return 1;
+    }
+
+    p = ib->buffer + sizeof(int);
+
+    switch (msg.cmd) {
+    case MSG_Hello:
+        if (msg.version.major < BARRIER_VERSION_MAJOR ||
+            (msg.version.major == BARRIER_VERSION_MAJOR &&
+             msg.version.minor < BARRIER_VERSION_MINOR)) {
+            return 1;
+        }
+        p = write_cmd(ib, p, MSG_HelloBack);
+        p = write_short(ib, p, BARRIER_VERSION_MAJOR);
+        p = write_short(ib, p, BARRIER_VERSION_MINOR);
+        p = write_string(ib, p, ib->name);
+        break;
+    case MSG_CClose:
+        break;
+    case MSG_QInfo:
+        p = write_cmd(ib, p, MSG_DInfo);
+        p = write_short(ib, p, 0);    /* x origin */
+        p = write_short(ib, p, 0);    /* y origin */
+        p = write_short(ib, p, 1920); /* width */
+        p = write_short(ib, p, 1080); /* height */
+        p = write_short(ib, p, 0);    /* warpsize (obsolete) */
+        p = write_short(ib, p, 0);    /* mouse x */
+        p = write_short(ib, p, 0);    /* mouse y */
+        break;
+    case MSG_CInfoAck:
+        break;
+    case MSG_CResetOptions:
+        /* TODO: reset options */
+        break;
+    case MSG_DSetOptions:
+        /* TODO: set options */
+        break;
+    case MSG_CEnter:
+        break;
+    case MSG_DClipboard:
+        break;
+    case MSG_CKeepAlive:
+        p = write_cmd(ib, p, MSG_CKeepAlive);
+        break;
+    case MSG_DMouseMove:
+        qemu_input_queue_abs(NULL, INPUT_AXIS_X, msg.mousepos.x, 0, 1920);
+        qemu_input_queue_abs(NULL, INPUT_AXIS_Y, msg.mousepos.y, 0, 1080);
+        qemu_input_event_sync();
+        break;
+    case MSG_DMouseRelMove:
+        qemu_input_queue_rel(NULL, INPUT_AXIS_X, msg.mousepos.x);
+        qemu_input_queue_rel(NULL, INPUT_AXIS_Y, msg.mousepos.y);
+        qemu_input_event_sync();
+        break;
+    case MSG_CLeave:
+        break;
+    case MSG_DKeyDown:
+        qemu_input_event_send_key_qcode(NULL,
+                                        input_barrier_to_qcode(msg.key.keyid),
+                                        true);
+        break;
+    case MSG_DKeyRepeat:
+        qemu_input_event_send_key_qcode(NULL,
+                                        input_barrier_to_qcode(msg.key.keyid),
+                                        false);
+        qemu_input_event_send_key_qcode(NULL,
+                                        input_barrier_to_qcode(msg.key.keyid),
+                                        true);
+        break;
+    case MSG_DKeyUp:
+        qemu_input_event_send_key_qcode(NULL,
+                                        input_barrier_to_qcode(msg.key.keyid),
+                                        false);
+        break;
+    case MSG_DMouseDown:
+        qemu_input_queue_btn(NULL,
+                             input_barrier_to_mouse(msg.mousebutton.buttonid),
+                             true);
+        qemu_input_event_sync();
+        break;
+    case MSG_DMouseUp:
+        qemu_input_queue_btn(NULL,
+                             input_barrier_to_mouse(msg.mousebutton.buttonid),
+                             false);
+        qemu_input_event_sync();
+        break;
+    case MSG_DMouseWheel:
+        qemu_input_queue_btn(NULL, (msg.mousepos.y > 0) ? INPUT_BUTTON_WHEEL_UP
+                             : INPUT_BUTTON_WHEEL_DOWN, true);
+        qemu_input_event_sync();
+        qemu_input_queue_btn(NULL, (msg.mousepos.y > 0) ? INPUT_BUTTON_WHEEL_UP
+                             : INPUT_BUTTON_WHEEL_DOWN, false);
+        qemu_input_event_sync();
+        break;
+    default:
+        p = write_cmd(ib, p, MSG_EUnknown);
+        break;;
+    }
+    /* write the length of the message */
+
+    len = p - ib->buffer - 4;
+    if (len) {
+        write_int(ib, ib->buffer, len);
+        ret = qio_channel_write(QIO_CHANNEL(ib->sioc), ib->buffer,
+                                len + 4, NULL);
+    }
+
+    return true;
+}
+
+static void input_barrier_complete(UserCreatable *uc, Error **errp)
+{
+    InputBarrier *ib = INPUT_BARRIER(uc);
+    Error *local_err = NULL;
+    SocketAddress addr;
+
+    addr.type = SOCKET_ADDRESS_TYPE_INET;
+    addr.u.inet.host = g_strdup("localhost");
+    addr.u.inet.port = g_strdup("24800");
+
+    /*
+     * Connect to the primary
+     * Primary is the server where the keyboard and the mouse
+     * are connected and forwarded to the secondary (the client)
+     */
+
+    ib->sioc = qio_channel_socket_new();
+    qio_channel_set_name(QIO_CHANNEL(ib->sioc), "barrier-client");
+
+    qio_channel_socket_connect_sync(ib->sioc, &addr, &local_err);
+    if (local_err) {
+        object_unref(OBJECT(ib->sioc));
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    qio_channel_set_delay(QIO_CHANNEL(ib->sioc), false);
+
+    ib->ioc_tag = qio_channel_add_watch(QIO_CHANNEL(ib->sioc), G_IO_IN,
+                                        input_barrier_event, ib, NULL);
+}
+
+static void input_barrier_instance_finalize(Object *obj)
+{
+    InputBarrier *ib = INPUT_BARRIER(obj);
+
+    g_source_remove(ib->ioc_tag);
+    g_free(ib->name);
+}
+
+static char *input_barrier_get_name(Object *obj, Error **errp)
+{
+    InputBarrier *ib = INPUT_BARRIER(obj);
+
+    return g_strdup(ib->name);
+}
+
+static void input_barrier_set_name(Object *obj, const char *value,
+                                  Error **errp)
+{
+    InputBarrier *ib = INPUT_BARRIER(obj);
+
+    if (ib->name) {
+        error_setg(errp, "name property already set");
+        return;
+    }
+    ib->name = g_strdup(value);
+}
+
+static void input_barrier_instance_init(Object *obj)
+{
+    object_property_add_str(obj, "name",
+                            input_barrier_get_name,
+                            input_barrier_set_name, NULL);
+}
+
+static void input_barrier_class_init(ObjectClass *oc, void *data)
+{
+    UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
+
+    ucc->complete = input_barrier_complete;
+}
+
+static const TypeInfo input_barrier_info = {
+    .name = TYPE_INPUT_BARRIER,
+    .parent = TYPE_OBJECT,
+    .class_size = sizeof(InputBarrierClass),
+    .class_init = input_barrier_class_init,
+    .instance_size = sizeof(InputBarrier),
+    .instance_init = input_barrier_instance_init,
+    .instance_finalize = input_barrier_instance_finalize,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+static void register_types(void)
+{
+    type_register_static(&input_barrier_info);
+}
+
+type_init(register_types);
-- 
2.21.0


