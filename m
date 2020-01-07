Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57927C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB5182087F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5182087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioq26-0007Uh-Sl
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:40:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iootG-0001MY-Qf
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:27:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iootE-0003Mb-V8
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:27:22 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:43305)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iootE-0003Lm-Lo
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:27:20 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MNtCi-1j4JVG2Jjs-00ODoh; Tue, 07 Jan 2020 14:27:18 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 2/4] q800: add a block backend to the PRAM
Date: Tue,  7 Jan 2020 14:27:13 +0100
Message-Id: <20200107132715.722101-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107132715.722101-1-laurent@vivier.eu>
References: <20200107132715.722101-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VSkDYNS6O8gKJsAR0K+Tkh0Rb1s2elMaDTFZyrdgrasDSbfJI91
 t5fIAuvFJuk+zlviQI4CEV2hWXrPGrETxXf/fV8S9cesZ7gvtABmeGnZOWjXW+qHL1VkWnd
 g0jDTJgIQo+n4oH3412YX647sdpYLqtt+P0N6Fcjz5tX+VcjHcX9YHz1sz7c3qQy+fnZ7sx
 bj4xKuZIy+u4OIMjOWWHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ojYEpLu4bYA=:oNXset85q+GcRXUs5RdKcc
 iIYMbKbFZQV3CTzkHODEnOaFLusc87FbOuyvsGRWeqxwbPyA2dNFAcmdP9JjovfPubVqB87G1
 IjB2sUYS4eeonwZmBH1TviXR0t3C5EDa14AjUeW9t1bG64tjcbIF2RSazZt0IMX0WCJ3JcLmm
 thNvcIODHXsaoYI1KY7hQN6w+bjb8y/h5Ys/GzXOxawCUDVyOYt7fA5Z2nrZHmOnp1jogAuQG
 ZOm2h5oxgOQtJFnG406fS/+CAtoYaVUbMWkOpy+knWLnBFFpCnsyCsSNDcZG3zUg88IKqC/wg
 evsh2RBeo9Wugv7fAmYM9crDEQPVtIQ/31AbKhPEGdHFRYlI7eaK+3QCV81d/pb93S66GKn8K
 i1MJSD/AO26QkGvYI2bD7r4U0IR/P4rUoFnkxm0BK6003O2N6SXThVfEJRwNZNiFhzw4AVqRx
 dJ6FnhllFMeN0bThiTvTI4DdZMj0Xkg5fvMoLPWuz2Xb8O0VjEDKG75RGhhosf2rJPbNarYhe
 yO6OQvMqfHf7CKkqUqiajJP/r0he5pjPfJ/Was3wF3XMRxLQo6HJUXAdMkurGbHsgAYERn7Ny
 A/wv1dhm67Pke7wCHQVhPV1mR+XiF3z+PY1k1NBlpa2dzNoCuYG5JRP6we2acZo1jXSJTRk87
 tiy0ftfbc03vlxGf1xCgI//fykLVU7vLYk2QIePP+LFi8efWIeEzwDIXTlrYU7gNh+E6/5834
 M96M5kJiFLMzZfuxnUm+XVtGagkhWJwIBQM+eVTLZ6hY3GcKKUi+D3LfTCTWxsDojWQWI0l+8
 6MatKq3pTQMwtvnL4dGhyrmm7zZx+SOX7xpobNTcmS0Lvgvz7JFveueTmnvKXdS+V6u5qQZ4E
 wSbKSiJHo7XXJL+quw3w==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.133
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows to save and restore the content of the PRAM.
It may be useful if we want to check the configuration or to change it.

The backend is added using mtd interface, for instance:

    ... -drive file=pram.img,format=raw,if=mtd ...

where pram.img is the file where the data will be stored, its size must
be 256 bytes.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20191219201439.84804-3-laurent@vivier.eu>
---
 hw/m68k/q800.c            |  6 ++++
 hw/misc/mac_via.c         | 65 +++++++++++++++++++++++++++++++++++++++
 include/hw/misc/mac_via.h |  3 ++
 3 files changed, 74 insertions(+)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 4ca8678007..0c445c74bf 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -158,6 +158,7 @@ static void q800_init(MachineState *machine)
     NubusBus *nubus;
     GLUEState *irq;
     qemu_irq *pic;
+    DriveInfo *dinfo;
 
     linux_boot = (kernel_filename != NULL);
 
@@ -200,6 +201,11 @@ static void q800_init(MachineState *machine)
     /* VIA */
 
     via_dev = qdev_create(NULL, TYPE_MAC_VIA);
+    dinfo = drive_get(IF_MTD, 0, 0);
+    if (dinfo) {
+        qdev_prop_set_drive(via_dev, "drive", blk_by_legacy_dinfo(dinfo),
+                            &error_abort);
+    }
     qdev_init_nofail(via_dev);
     sysbus = SYS_BUS_DEVICE(via_dev);
     sysbus_mmio_map(sysbus, 0, VIA_BASE);
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index e5658af922..e9e6a95eab 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -27,6 +27,8 @@
 #include "sysemu/runstate.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
+#include "hw/qdev-properties.h"
+#include "sysemu/block-backend.h"
 #include "trace.h"
 
 /*
@@ -375,6 +377,15 @@ static void via2_irq_request(void *opaque, int irq, int level)
     mdc->update_irq(s);
 }
 
+
+static void pram_update(MacVIAState *m)
+{
+    if (m->blk) {
+        blk_pwrite(m->blk, 0, m->mos6522_via1.PRAM,
+                   sizeof(m->mos6522_via1.PRAM), 0);
+    }
+}
+
 /*
  * RTC Commands
  *
@@ -547,6 +558,7 @@ static void via1_rtc_update(MacVIAState *m)
             /* PRAM address 0x00 -> 0x13 */
             trace_via1_rtc_cmd_pram_write(m->cmd - REG_PRAM_ADDR, m->data_out);
             v1s->PRAM[m->cmd - REG_PRAM_ADDR] = m->data_out;
+            pram_update(m);
             m->cmd = REG_EMPTY;
             break;
         case REG_PRAM_SECT...REG_PRAM_SECT_LAST:
@@ -577,6 +589,7 @@ static void via1_rtc_update(MacVIAState *m)
     g_assert(REG_PRAM_SECT <= m->cmd && m->cmd <= REG_PRAM_SECT_LAST);
     sector = m->cmd - REG_PRAM_SECT;
     v1s->PRAM[sector * 32 + m->alt] = m->data_out;
+    pram_update(m);
     trace_via1_rtc_cmd_pram_sect_write(sector, m->alt, sector * 32 + m->alt,
                                        m->data_out);
     m->alt = REG_EMPTY;
@@ -857,6 +870,7 @@ static void mac_via_realize(DeviceState *dev, Error **errp)
     MacVIAState *m = MAC_VIA(dev);
     MOS6522State *ms;
     struct tm tm;
+    int ret;
 
     /* Init VIAs 1 and 2 */
     sysbus_init_child_obj(OBJECT(dev), "via1", &m->mos6522_via1,
@@ -890,6 +904,28 @@ static void mac_via_realize(DeviceState *dev, Error **errp)
     m->adb_poll_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, via_adb_poll, m);
     m->adb_data_ready = qdev_get_gpio_in_named(dev, "via1-irq",
                                                VIA1_IRQ_ADB_READY_BIT);
+
+    if (m->blk) {
+        int64_t len = blk_getlength(m->blk);
+        if (len < 0) {
+            error_setg_errno(errp, -len,
+                             "could not get length of backing image");
+            return;
+        }
+        ret = blk_set_perm(m->blk,
+                           BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
+                           BLK_PERM_ALL, errp);
+        if (ret < 0) {
+            return;
+        }
+
+        len = blk_pread(m->blk, 0, m->mos6522_via1.PRAM,
+                        sizeof(m->mos6522_via1.PRAM));
+        if (len != sizeof(m->mos6522_via1.PRAM)) {
+            error_setg(errp, "can't read PRAM contents");
+            return;
+        }
+    }
 }
 
 static void mac_via_init(Object *obj)
@@ -914,10 +950,33 @@ static void mac_via_init(Object *obj)
                         TYPE_ADB_BUS, DEVICE(obj), "adb.0");
 }
 
+static void postload_update_cb(void *opaque, int running, RunState state)
+{
+    MacVIAState *m = MAC_VIA(opaque);
+
+    qemu_del_vm_change_state_handler(m->vmstate);
+    m->vmstate = NULL;
+
+    pram_update(m);
+}
+
+static int mac_via_post_load(void *opaque, int version_id)
+{
+    MacVIAState *m = MAC_VIA(opaque);
+
+    if (m->blk) {
+        m->vmstate = qemu_add_vm_change_state_handler(postload_update_cb,
+                                                      m);
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_mac_via = {
     .name = "mac-via",
     .version_id = 1,
     .minimum_version_id = 1,
+    .post_load = mac_via_post_load,
     .fields = (VMStateField[]) {
         /* VIAs */
         VMSTATE_STRUCT(mos6522_via1.parent_obj, MacVIAState, 0, vmstate_mos6522,
@@ -950,6 +1009,11 @@ static const VMStateDescription vmstate_mac_via = {
     }
 };
 
+static Property mac_via_properties[] = {
+    DEFINE_PROP_DRIVE("drive", MacVIAState, blk),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void mac_via_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -957,6 +1021,7 @@ static void mac_via_class_init(ObjectClass *oc, void *data)
     dc->realize = mac_via_realize;
     dc->reset = mac_via_reset;
     dc->vmsd = &vmstate_mac_via;
+    dc->props = mac_via_properties;
 }
 
 static TypeInfo mac_via_info = {
diff --git a/include/hw/misc/mac_via.h b/include/hw/misc/mac_via.h
index 3f86fcb7e1..e74f85be0f 100644
--- a/include/hw/misc/mac_via.h
+++ b/include/hw/misc/mac_via.h
@@ -81,6 +81,8 @@ typedef struct MOS6522Q800VIA2State {
 typedef struct MacVIAState {
     SysBusDevice busdev;
 
+    VMChangeStateEntry *vmstate;
+
     /* MMIO */
     MemoryRegion mmio;
     MemoryRegion via1mem;
@@ -100,6 +102,7 @@ typedef struct MacVIAState {
     uint8_t cmd;
     int wprotect;
     int alt;
+    BlockBackend *blk;
 
     /* ADB */
     ADBBusState adb_bus;
-- 
2.24.1


