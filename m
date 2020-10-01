Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D00AC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:06:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABD7820575
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfAZnUAB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD7820575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2yV-0000mC-F9
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 14:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kO2fZ-0003WO-0C
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:47:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41689)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kO2fU-0006os-OW
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601574420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hFnF9scAiMQ534Ar+rYpee7FQAMrzoQLMyIExVO/PwY=;
 b=dfAZnUABKqRJubwaQi/IcriwgQIr4BxTQEAzeEvSll8oRg/3JuCkhRYZ6dhfnQz6EtypGE
 jWb7IeXp4kPc0AGRvGOXNk7WvxpKp3tyi29tu2bK61m3iZFGWJAgruZxYIsELBtc9musIE
 dyRxVEYl2cHUNTPk5hQhtVvAHjQJAlQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-EPdD8JVTNeGz7IL5Z_jIKw-1; Thu, 01 Oct 2020 13:46:58 -0400
X-MC-Unique: EPdD8JVTNeGz7IL5Z_jIKw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 652C0801ADA;
 Thu,  1 Oct 2020 17:46:57 +0000 (UTC)
Received: from scv.redhat.com (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CBF3E5C1CF;
 Thu,  1 Oct 2020 17:46:56 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 3/9] ide: rename cmd_write to ctrl_write
Date: Thu,  1 Oct 2020 13:46:43 -0400
Message-Id: <20201001174649.1911016-4-jsnow@redhat.com>
In-Reply-To: <20201001174649.1911016-1-jsnow@redhat.com>
References: <20201001174649.1911016-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:25:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's the Control register, part of the Control block -- Command is
misleading here. Rename all related functions and constants.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/ide/internal.h |  9 +++++----
 hw/ide/core.c             | 12 ++++++------
 hw/ide/ioport.c           |  2 +-
 hw/ide/macio.c            |  2 +-
 hw/ide/mmio.c             |  8 ++++----
 hw/ide/pci.c              | 12 ++++++------
 hw/ide/trace-events       |  2 +-
 7 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 8a95ad8c4d3..a23bb2f3481 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -57,8 +57,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(IDEBus, IDE_BUS)
 #define REL			0x04
 #define TAG_MASK		0xf8
 
-#define IDE_CMD_RESET           0x04
-#define IDE_CMD_DISABLE_IRQ     0x02
+/* Bits of Device Control register */
+#define IDE_CTRL_RESET          0x04
+#define IDE_CTRL_DISABLE_IRQ    0x02
 
 /* ACS-2 T13/2015-D Table B.2 Command codes */
 #define WIN_NOP				0x00
@@ -559,7 +560,7 @@ static inline IDEState *idebus_active_if(IDEBus *bus)
 
 static inline void ide_set_irq(IDEBus *bus)
 {
-    if (!(bus->cmd & IDE_CMD_DISABLE_IRQ)) {
+    if (!(bus->cmd & IDE_CTRL_DISABLE_IRQ)) {
         qemu_irq_raise(bus->irq);
     }
 }
@@ -598,7 +599,7 @@ void ide_atapi_io_error(IDEState *s, int ret);
 void ide_ioport_write(void *opaque, uint32_t addr, uint32_t val);
 uint32_t ide_ioport_read(void *opaque, uint32_t addr1);
 uint32_t ide_status_read(void *opaque, uint32_t addr);
-void ide_cmd_write(void *opaque, uint32_t addr, uint32_t val);
+void ide_ctrl_write(void *opaque, uint32_t addr, uint32_t val);
 void ide_data_writew(void *opaque, uint32_t addr, uint32_t val);
 uint32_t ide_data_readw(void *opaque, uint32_t addr);
 void ide_data_writel(void *opaque, uint32_t addr, uint32_t val);
diff --git a/hw/ide/core.c b/hw/ide/core.c
index f76f7e5234b..84499e2241c 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2235,25 +2235,25 @@ uint32_t ide_status_read(void *opaque, uint32_t addr)
     return ret;
 }
 
-void ide_cmd_write(void *opaque, uint32_t addr, uint32_t val)
+void ide_ctrl_write(void *opaque, uint32_t addr, uint32_t val)
 {
     IDEBus *bus = opaque;
     IDEState *s;
     int i;
 
-    trace_ide_cmd_write(addr, val, bus);
+    trace_ide_ctrl_write(addr, val, bus);
 
     /* common for both drives */
-    if (!(bus->cmd & IDE_CMD_RESET) &&
-        (val & IDE_CMD_RESET)) {
+    if (!(bus->cmd & IDE_CTRL_RESET) &&
+        (val & IDE_CTRL_RESET)) {
         /* reset low to high */
         for(i = 0;i < 2; i++) {
             s = &bus->ifs[i];
             s->status = BUSY_STAT | SEEK_STAT;
             s->error = 0x01;
         }
-    } else if ((bus->cmd & IDE_CMD_RESET) &&
-               !(val & IDE_CMD_RESET)) {
+    } else if ((bus->cmd & IDE_CTRL_RESET) &&
+               !(val & IDE_CTRL_RESET)) {
         /* high to low */
         for(i = 0;i < 2; i++) {
             s = &bus->ifs[i];
diff --git a/hw/ide/ioport.c b/hw/ide/ioport.c
index ab1f4e5d9c0..b613ff3bbaf 100644
--- a/hw/ide/ioport.c
+++ b/hw/ide/ioport.c
@@ -46,7 +46,7 @@ static const MemoryRegionPortio ide_portio_list[] = {
 };
 
 static const MemoryRegionPortio ide_portio2_list[] = {
-    { 0, 1, 1, .read = ide_status_read, .write = ide_cmd_write },
+    { 0, 1, 1, .read = ide_status_read, .write = ide_ctrl_write },
     PORTIO_END_OF_LIST(),
 };
 
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index 62a599a0751..b270a101632 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -329,7 +329,7 @@ static void pmac_ide_write(void *opaque, hwaddr addr, uint64_t val,
     case 0x8:
     case 0x16:
         if (size == 1) {
-            ide_cmd_write(&d->bus, 0, val);
+            ide_ctrl_write(&d->bus, 0, val);
         }
         break;
     case 0x20:
diff --git a/hw/ide/mmio.c b/hw/ide/mmio.c
index 4bf6e3a8b76..36e2f4790ab 100644
--- a/hw/ide/mmio.c
+++ b/hw/ide/mmio.c
@@ -98,16 +98,16 @@ static uint64_t mmio_ide_status_read(void *opaque, hwaddr addr,
     return ide_status_read(&s->bus, 0);
 }
 
-static void mmio_ide_cmd_write(void *opaque, hwaddr addr,
-                               uint64_t val, unsigned size)
+static void mmio_ide_ctrl_write(void *opaque, hwaddr addr,
+                                uint64_t val, unsigned size)
 {
     MMIOState *s = opaque;
-    ide_cmd_write(&s->bus, 0, val);
+    ide_ctrl_write(&s->bus, 0, val);
 }
 
 static const MemoryRegionOps mmio_ide_cs_ops = {
     .read = mmio_ide_status_read,
-    .write = mmio_ide_cmd_write,
+    .write = mmio_ide_ctrl_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index b50091b615c..84ba733548e 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -38,7 +38,7 @@
         (IDE_RETRY_DMA | IDE_RETRY_PIO | \
         IDE_RETRY_READ | IDE_RETRY_FLUSH)
 
-static uint64_t pci_ide_cmd_read(void *opaque, hwaddr addr, unsigned size)
+static uint64_t pci_ide_status_read(void *opaque, hwaddr addr, unsigned size)
 {
     IDEBus *bus = opaque;
 
@@ -48,20 +48,20 @@ static uint64_t pci_ide_cmd_read(void *opaque, hwaddr addr, unsigned size)
     return ide_status_read(bus, addr + 2);
 }
 
-static void pci_ide_cmd_write(void *opaque, hwaddr addr,
-                              uint64_t data, unsigned size)
+static void pci_ide_ctrl_write(void *opaque, hwaddr addr,
+                               uint64_t data, unsigned size)
 {
     IDEBus *bus = opaque;
 
     if (addr != 2 || size != 1) {
         return;
     }
-    ide_cmd_write(bus, addr + 2, data);
+    ide_ctrl_write(bus, addr + 2, data);
 }
 
 const MemoryRegionOps pci_ide_cmd_le_ops = {
-    .read = pci_ide_cmd_read,
-    .write = pci_ide_cmd_write,
+    .read = pci_ide_status_read,
+    .write = pci_ide_ctrl_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index 2e4162629f4..6e357685f9b 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -5,7 +5,7 @@
 ide_ioport_read(uint32_t addr, const char *reg, uint32_t val, void *bus, void *s)  "IDE PIO rd @ 0x%"PRIx32" (%s); val 0x%02"PRIx32"; bus %p IDEState %p"
 ide_ioport_write(uint32_t addr, const char *reg, uint32_t val, void *bus, void *s) "IDE PIO wr @ 0x%"PRIx32" (%s); val 0x%02"PRIx32"; bus %p IDEState %p"
 ide_status_read(uint32_t addr, uint32_t val, void *bus, void *s)                   "IDE PIO rd @ 0x%"PRIx32" (Alt Status); val 0x%02"PRIx32"; bus %p; IDEState %p"
-ide_cmd_write(uint32_t addr, uint32_t val, void *bus)                              "IDE PIO wr @ 0x%"PRIx32" (Device Control); val 0x%02"PRIx32"; bus %p"
+ide_ctrl_write(uint32_t addr, uint32_t val, void *bus)                             "IDE PIO wr @ 0x%"PRIx32" (Device Control); val 0x%02"PRIx32"; bus %p"
 # Warning: verbose
 ide_data_readw(uint32_t addr, uint32_t val, void *bus, void *s)                    "IDE PIO rd @ 0x%"PRIx32" (Data: Word); val 0x%04"PRIx32"; bus %p; IDEState %p"
 ide_data_writew(uint32_t addr, uint32_t val, void *bus, void *s)                   "IDE PIO wr @ 0x%"PRIx32" (Data: Word); val 0x%04"PRIx32"; bus %p; IDEState %p"
-- 
2.26.2


