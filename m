Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C377C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 05:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2661620767
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 05:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+EL2nrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2661620767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyqC7-0002w6-7o
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 01:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jyqAp-0000yS-6j
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 01:23:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24619
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jyqAl-0007R9-Dw
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 01:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595568185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YmtE+YKrz0ZTsj6UkrwfFA8+s6YpXYdAIZoV7wnLLdc=;
 b=Y+EL2nrA8Z0LHC363xwqHXVp+6DyWPVnd13UE5mcR2V4+Q6DDYL3zRBRMrwI/3eNbH+VXO
 YI1x7fHsMNTljl5CLXJiOgJ264NdKU7nMrdBOnKP+JX8AL2hKN8bJA3+aj+7syST3KA/4o
 0qyQvPQ6klA1/WdJcNjZBD7YQ3Qg6l0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-Nq8HSymBNz6dJNKvFC954g-1; Fri, 24 Jul 2020 01:23:03 -0400
X-MC-Unique: Nq8HSymBNz6dJNKvFC954g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A434AC7465;
 Fri, 24 Jul 2020 05:23:02 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-120-206.rdu2.redhat.com [10.10.120.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED09E7AC80;
 Fri, 24 Jul 2020 05:23:01 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/7] ide: rename cmd_write to ctrl_write
Date: Fri, 24 Jul 2020 01:22:54 -0400
Message-Id: <20200724052300.1163728-2-jsnow@redhat.com>
In-Reply-To: <20200724052300.1163728-1-jsnow@redhat.com>
References: <20200724052300.1163728-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 00:00:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: kwolf@redhat.com, Alexander Bulekov <alxndr@bu.edu>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's the Control register, part of the Control block -- Command is
misleading here. Rename all related functions and constants.

Signed-off-by: John Snow <jsnow@redhat.com>
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
index 1a7869e85d..10ea6e1e23 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -57,8 +57,9 @@ typedef struct IDEDMAOps IDEDMAOps;
 #define REL			0x04
 #define TAG_MASK		0xf8
 
-#define IDE_CMD_RESET           0x04
-#define IDE_CMD_DISABLE_IRQ     0x02
+/* Bits of Device Control register */
+#define IDE_CTRL_RESET          0x04
+#define IDE_CTRL_DISABLE_IRQ    0x02
 
 /* ACS-2 T13/2015-D Table B.2 Command codes */
 #define WIN_NOP				0x00
@@ -564,7 +565,7 @@ static inline IDEState *idebus_active_if(IDEBus *bus)
 
 static inline void ide_set_irq(IDEBus *bus)
 {
-    if (!(bus->cmd & IDE_CMD_DISABLE_IRQ)) {
+    if (!(bus->cmd & IDE_CTRL_DISABLE_IRQ)) {
         qemu_irq_raise(bus->irq);
     }
 }
@@ -603,7 +604,7 @@ void ide_atapi_io_error(IDEState *s, int ret);
 void ide_ioport_write(void *opaque, uint32_t addr, uint32_t val);
 uint32_t ide_ioport_read(void *opaque, uint32_t addr1);
 uint32_t ide_status_read(void *opaque, uint32_t addr);
-void ide_cmd_write(void *opaque, uint32_t addr, uint32_t val);
+void ide_ctrl_write(void *opaque, uint32_t addr, uint32_t val);
 void ide_data_writew(void *opaque, uint32_t addr, uint32_t val);
 uint32_t ide_data_readw(void *opaque, uint32_t addr);
 void ide_data_writel(void *opaque, uint32_t addr, uint32_t val);
diff --git a/hw/ide/core.c b/hw/ide/core.c
index d997a78e47..b472220d65 100644
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
index ab1f4e5d9c..b613ff3bba 100644
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
index 62a599a075..b270a10163 100644
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
index d233bd8c01..80b8a9eb09 100644
--- a/hw/ide/mmio.c
+++ b/hw/ide/mmio.c
@@ -95,16 +95,16 @@ static uint64_t mmio_ide_status_read(void *opaque, hwaddr addr,
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
index 5e85c4ad17..59726ae453 100644
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
index 2e4162629f..6e357685f9 100644
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


