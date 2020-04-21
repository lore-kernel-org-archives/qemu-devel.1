Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E45C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:14:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD7882074B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6cVo6LU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7882074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQn71-0007bn-QI
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 03:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQn6D-0006v5-1G
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:13:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQn6B-0007zi-GK
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:13:40 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35791)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQn6B-0007ru-41
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:13:39 -0400
Received: by mail-wm1-x343.google.com with SMTP id r26so2423329wmh.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 00:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nAASM20KlmtmCGTRTSznUWtd6msX/BJofWlyBMvnWBQ=;
 b=r6cVo6LUzKkVSbL5m35GIhIUGATv96tr7UBvRyCvDFEmfUfcuHPi38G04R8DLId58C
 igTgEDEnJFXn8XfQ4tEWubvgAkXD95IltuMdZCT+Tt2FB8wjNdqHDcmILybpng2lUMT/
 kNLihJX4jDG7DCBjWanswI8qqN3DZTR6kcm/iPbC7Bu+E1RsXSaYmbZEUzurSQ6XE+vp
 Y9KJ3KysCfQTD02D0p15pXc8cDfbrNhDta52A5C03ekpGYT66pzl296i/nt4bilF3XmJ
 Uxn85VYPiC+/lLN06PYJB91g266AWwn62B1zk4EJtdgHseq2N9kdZNxmAwMSoIkUxSJZ
 0jaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=nAASM20KlmtmCGTRTSznUWtd6msX/BJofWlyBMvnWBQ=;
 b=OaSl7PeUZzUGquufj6h+gT9SmiWbIl/8o6tdGOrV1dUW/7RpTFNCg83Qi7EBvENTHz
 XE43zjskS3Wy6ksCMCjtbns6faYK8v9338aig3xwxAE/neWYZmeBkED6uxKCwTjYPhx1
 LaJjuobRsCAnGQvDYtz8gF/Km2sxCXWgg8KebMltYr3zU/4ErWn53mTgD3VKB4xbQe67
 io0bfHc9BOA1TSjghb3MLWYFluGh9Trc43Msdqe6WolP/FYVQu0Y/EStdIdVRQRZ5KRu
 0KtsgO0YabcERVT5VuMO83ZWLmzU6DNjS2sPGTnnZgY3uaiyvay4WVcFiT+A0PXQiQLK
 /qhw==
X-Gm-Message-State: AGi0PuYjrJkyYGGgnQjlsZ5js22y1MM/oOcyKBUd5ETmd7Phe/fC5ey2
 Gym5aSIA1CJq8dTsswo69FWllTlOe8E=
X-Google-Smtp-Source: APiQypImksgfsR97NoQEWa1HVMIuHhE1/fFSDObUvUxmi80/NrdJyV01ssRCMFJmDSro6u48CeIr0w==
X-Received: by 2002:a1c:a58b:: with SMTP id o133mr3289452wme.5.1587453216176; 
 Tue, 21 Apr 2020 00:13:36 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id d5sm2481631wrp.44.2020.04.21.00.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 00:13:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Paul Zimmerman <pauldzim@gmail.com>
Subject: [PATCH] hw/usb/hcd-dwc2: Simplified I/O memory regions
Date: Tue, 21 Apr 2020 09:13:33 +0200
Message-Id: <20200421071333.24706-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use 1 container holding 2 regions:
- I/O registers
- FIFOs

Remove all the static base addresses.

Name address space.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Sometime a patch is cleaner/quicker than explanations.
Suggestion to be squashed on patch:
'dwc-hsotg (dwc2) USB host controller emulation'

Further simplificatio would be to move some exploded read/write
functions directly into dwc2_hsotg_read/write.

Based-on: <20200421014551.10426-1-pauldzim@gmail.com>
---
 hw/usb/hcd-dwc2.h |  17 +----
 hw/usb/hcd-dwc2.c | 181 ++++++++++++++++++++++------------------------
 2 files changed, 88 insertions(+), 110 deletions(-)

diff --git a/hw/usb/hcd-dwc2.h b/hw/usb/hcd-dwc2.h
index 403afd1747..7d7ea604a4 100644
--- a/hw/usb/hcd-dwc2.h
+++ b/hw/usb/hcd-dwc2.h
@@ -61,20 +61,9 @@ struct DWC2State {
     qemu_irq irq;
     MemoryRegion *dma_mr;
     AddressSpace dma_as;
-    MemoryRegion mem;
-    MemoryRegion mem_glbreg;
-    MemoryRegion mem_fszreg;
-    MemoryRegion mem_hreg0;
-    MemoryRegion mem_hreg1;
-    MemoryRegion mem_pcgreg;
-    MemoryRegion mem_hreg2;
-
-    uint16_t glbregbase;
-    uint16_t fszregbase;
-    uint16_t hreg0base;
-    uint16_t hreg1base;
-    uint16_t pcgregbase;
-    uint16_t hfifobase;
+    MemoryRegion container;
+    MemoryRegion hsotg;
+    MemoryRegion fifos;
 
     union {
 #define DWC2_GLBREG_SIZE    0x70
diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
index 31de82bcd3..5c0e6a66b8 100644
--- a/hw/usb/hcd-dwc2.c
+++ b/hw/usb/hcd-dwc2.c
@@ -28,6 +28,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/usb/dwc2-regs.h"
 #include "hw/usb/hcd-dwc2.h"
@@ -655,7 +656,7 @@ static const char *glbregnm[] = {
 static uint64_t dwc2_glbreg_read(void *ptr, hwaddr addr, unsigned size)
 {
     DWC2State *s = ptr;
-    uint32_t reg = s->glbregbase + addr;
+    uint32_t reg = addr;
     uint32_t val;
 
     assert(reg <= GINTSTS2);
@@ -681,7 +682,7 @@ static void dwc2_glbreg_write(void *ptr, hwaddr addr, uint64_t val,
 {
     DWC2State *s = ptr;
     uint64_t orig = val;
-    uint32_t reg = s->glbregbase + addr;
+    uint32_t reg = addr;
     uint32_t *mmio;
     uint32_t old;
     int iflg = 0;
@@ -762,10 +763,9 @@ static void dwc2_glbreg_write(void *ptr, hwaddr addr, uint64_t val,
 static uint64_t dwc2_fszreg_read(void *ptr, hwaddr addr, unsigned size)
 {
     DWC2State *s = ptr;
-    uint32_t reg = s->fszregbase + addr;
     uint32_t val;
 
-    assert(reg <= HPTXFSIZ);
+    assert(addr <= HPTXFSIZ);
     val = s->fszreg[addr >> 2];
 
     trace_usb_dwc2_fszreg_read(addr, val);
@@ -777,11 +777,10 @@ static void dwc2_fszreg_write(void *ptr, hwaddr addr, uint64_t val,
 {
     DWC2State *s = ptr;
     uint64_t orig = val;
-    uint32_t reg = s->fszregbase + addr;
     uint32_t *mmio;
     uint32_t old;
 
-    assert(reg <= HPTXFSIZ);
+    assert(addr <= HPTXFSIZ);
     mmio = &s->fszreg[addr >> 2];
     old = *mmio;
 
@@ -800,13 +799,12 @@ static const char *hreg0nm[] = {
 static uint64_t dwc2_hreg0_read(void *ptr, hwaddr addr, unsigned size)
 {
     DWC2State *s = ptr;
-    uint32_t reg = s->hreg0base + addr;
     uint32_t val;
 
-    assert(reg <= HPRT0);
+    assert(addr <= HPRT0);
     val = s->hreg0[addr >> 2];
 
-    switch (reg) {
+    switch (addr) {
     case HFNUM:
         val = (dwc2_get_frame_remaining(s) << HFNUM_FRREM_SHIFT) |
               (s->hfnum << HFNUM_FRNUM_SHIFT);
@@ -825,17 +823,16 @@ static void dwc2_hreg0_write(void *ptr, hwaddr addr, uint64_t val,
     DWC2State *s = ptr;
     USBDevice *dev = s->uport.dev;
     uint64_t orig = val;
-    uint32_t reg = s->hreg0base + addr;
     uint32_t *mmio;
     uint32_t tval, told, old;
     int prst = 0;
     int iflg = 0;
 
-    assert(reg <= HPRT0);
+    assert(addr <= HPRT0);
     mmio = &s->hreg0[addr >> 2];
     old = *mmio;
 
-    switch (reg) {
+    switch (addr) {
     case HFIR:
         break;
     case HFNUM:
@@ -915,14 +912,13 @@ static const char *hreg1nm[] = {
 static uint64_t dwc2_hreg1_read(void *ptr, hwaddr addr, unsigned size)
 {
     DWC2State *s = ptr;
-    uint32_t reg = s->hreg1base + addr;
     uint32_t val;
 
-    assert(reg <= HCDMAB(DWC2_NB_CHAN - 1));
+    assert(addr <= HCDMAB(DWC2_NB_CHAN - 1));
     val = s->hreg1[addr >> 2];
 
     trace_usb_dwc2_hreg1_read(addr, hreg1nm[(addr >> 2) & 7], addr >> 5, val);
-    assert(s->hreg1base + (addr & 0x1c) <= HCDMAB(DWC2_NB_CHAN));
+    assert((addr & 0x1c) <= HCDMAB(DWC2_NB_CHAN));
     return val;
 }
 
@@ -931,18 +927,17 @@ static void dwc2_hreg1_write(void *ptr, hwaddr addr, uint64_t val,
 {
     DWC2State *s = ptr;
     uint64_t orig = val;
-    uint32_t reg = s->hreg1base + addr;
     uint32_t *mmio;
     uint32_t old;
     int iflg = 0;
     int enflg = 0;
     int disflg = 0;
 
-    assert(reg <= HCDMAB(DWC2_NB_CHAN - 1));
+    assert(addr <= HCDMAB(DWC2_NB_CHAN - 1));
     mmio = &s->hreg1[addr >> 2];
     old = *mmio;
 
-    switch (s->hreg1base + (addr & 0x1c)) {
+    switch (addr & 0x1c) {
     case HCCHAR(0):
         if ((val & HCCHAR_CHDIS) && !(old & HCCHAR_CHDIS)) {
             val &= ~(HCCHAR_CHENA | HCCHAR_CHDIS);
@@ -1002,10 +997,9 @@ static const char *pcgregnm[] = {
 static uint64_t dwc2_pcgreg_read(void *ptr, hwaddr addr, unsigned size)
 {
     DWC2State *s = ptr;
-    uint32_t reg = s->pcgregbase + addr;
     uint32_t val;
 
-    assert(reg <= PCGCCTL1);
+    assert(addr <= PCGCCTL1);
     val = s->pcgreg[addr >> 2];
 
     trace_usb_dwc2_pcgreg_read(addr, pcgregnm[addr >> 2], val);
@@ -1017,11 +1011,10 @@ static void dwc2_pcgreg_write(void *ptr, hwaddr addr, uint64_t val,
 {
     DWC2State *s = ptr;
     uint64_t orig = val;
-    uint32_t reg = s->pcgregbase + addr;
     uint32_t *mmio;
     uint32_t old;
 
-    assert(reg <= PCGCCTL1);
+    assert(addr <= PCGCCTL1);
     mmio = &s->pcgreg[addr >> 2];
     old = *mmio;
 
@@ -1030,6 +1023,65 @@ static void dwc2_pcgreg_write(void *ptr, hwaddr addr, uint64_t val,
     *mmio = val;
 }
 
+static uint64_t dwc2_hsotg_read(void *ptr, hwaddr addr, unsigned size)
+{
+    uint64_t val;
+
+    switch (addr) {
+    case HSOTG_REG(0x000) ... HSOTG_REG(0x0fc):
+        val = dwc2_glbreg_read(ptr, addr - HSOTG_REG(0x000), size);
+        break;
+    case HSOTG_REG(0x100) ... HSOTG_REG(0x3fc):
+        val = dwc2_fszreg_read(ptr, addr - HSOTG_REG(0x100), size);
+        break;
+    case HSOTG_REG(0x400) ... HSOTG_REG(0x4fc):
+        val = dwc2_hreg0_read(ptr, addr - HSOTG_REG(0x400), size);
+        break;
+    case HSOTG_REG(0x500) ... HSOTG_REG(0xdfc):
+        val = dwc2_hreg1_read(ptr, addr - HSOTG_REG(0x500), size);
+        break;
+    case HSOTG_REG(0xe00) ... HSOTG_REG(0xffc):
+        val = dwc2_pcgreg_read(ptr, addr - HSOTG_REG(0xe00), size);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return val;
+}
+
+static void dwc2_hsotg_write(void *ptr, hwaddr addr, uint64_t val,
+                             unsigned size)
+{
+    switch (addr) {
+    case HSOTG_REG(0x000) ... HSOTG_REG(0x0fc):
+        dwc2_glbreg_write(ptr, addr - HSOTG_REG(0x000), val, size);
+        break;
+    case HSOTG_REG(0x100) ... HSOTG_REG(0x3fc):
+        dwc2_fszreg_write(ptr, addr - HSOTG_REG(0x100), val, size);
+        break;
+    case HSOTG_REG(0x400) ... HSOTG_REG(0x4fc):
+        dwc2_hreg0_write(ptr, addr - HSOTG_REG(0x400), val, size);
+        break;
+    case HSOTG_REG(0x500) ... HSOTG_REG(0xdfc):
+        dwc2_hreg1_write(ptr, addr - HSOTG_REG(0x500), val, size);
+        break;
+    case HSOTG_REG(0xe00) ... HSOTG_REG(0xffc):
+        dwc2_pcgreg_write(ptr, addr - HSOTG_REG(0xe00), val, size);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static const MemoryRegionOps dwc2_mmio_hsotg_ops = {
+    .read = dwc2_hsotg_read,
+    .write = dwc2_hsotg_write,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
 static uint64_t dwc2_hreg2_read(void *ptr, hwaddr addr, unsigned size)
 {
     /* TODO - implement FIFOs to support slave mode */
@@ -1047,46 +1099,6 @@ static void dwc2_hreg2_write(void *ptr, hwaddr addr, uint64_t val,
     trace_usb_dwc2_hreg2_write(addr, addr >> 12, orig, 0, val);
 }
 
-static const MemoryRegionOps dwc2_mmio_glbreg_ops = {
-    .read = dwc2_glbreg_read,
-    .write = dwc2_glbreg_write,
-    .valid.min_access_size = 4,
-    .valid.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-static const MemoryRegionOps dwc2_mmio_fszreg_ops = {
-    .read = dwc2_fszreg_read,
-    .write = dwc2_fszreg_write,
-    .valid.min_access_size = 4,
-    .valid.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-static const MemoryRegionOps dwc2_mmio_hreg0_ops = {
-    .read = dwc2_hreg0_read,
-    .write = dwc2_hreg0_write,
-    .valid.min_access_size = 4,
-    .valid.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-static const MemoryRegionOps dwc2_mmio_hreg1_ops = {
-    .read = dwc2_hreg1_read,
-    .write = dwc2_hreg1_write,
-    .valid.min_access_size = 4,
-    .valid.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-static const MemoryRegionOps dwc2_mmio_pcgreg_ops = {
-    .read = dwc2_pcgreg_read,
-    .write = dwc2_pcgreg_write,
-    .valid.min_access_size = 4,
-    .valid.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
 static const MemoryRegionOps dwc2_mmio_hreg2_ops = {
     .read = dwc2_hreg2_read,
     .write = dwc2_hreg2_write,
@@ -1219,7 +1231,7 @@ static void dwc2_realize(DeviceState *dev, Error **errp)
     }
 
     s->dma_mr = MEMORY_REGION(obj);
-    address_space_init(&s->dma_as, s->dma_mr, NULL);
+    address_space_init(&s->dma_as, s->dma_mr, "dwc2");
 
     usb_bus_new(&s->bus, sizeof(s->bus), &dwc2_bus_ops, dev);
     usb_register_port(&s->bus, &s->uport, s, 0, &dwc2_port_ops,
@@ -1247,35 +1259,17 @@ static void dwc2_init(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     DWC2State *s = DWC2_USB(obj);
 
-    s->glbregbase = 0;
-    s->fszregbase = 0x0100;
-    s->hreg0base = 0x0400;
-    s->hreg1base = 0x0500;
-    s->pcgregbase = 0x0e00;
-    s->hfifobase = 0x1000;
+    memory_region_init(&s->container, obj, "dwc2", DWC2_MMIO_SIZE);
+    sysbus_init_mmio(sbd, &s->container);
 
-    memory_region_init(&s->mem, obj, "dwc2", DWC2_MMIO_SIZE);
-    memory_region_init_io(&s->mem_glbreg, obj, &dwc2_mmio_glbreg_ops, s,
-                          "global", DWC2_GLBREG_SIZE);
-    memory_region_init_io(&s->mem_fszreg, obj, &dwc2_mmio_fszreg_ops, s,
-                          "hptxfsiz", DWC2_FSZREG_SIZE);
-    memory_region_init_io(&s->mem_hreg0, obj, &dwc2_mmio_hreg0_ops, s,
-                          "host", DWC2_HREG0_SIZE);
-    memory_region_init_io(&s->mem_hreg1, obj, &dwc2_mmio_hreg1_ops, s,
-                          "host channels", DWC2_HREG1_SIZE);
-    memory_region_init_io(&s->mem_pcgreg, obj, &dwc2_mmio_pcgreg_ops, s,
-                          "power/clock", DWC2_PCGREG_SIZE);
-    memory_region_init_io(&s->mem_hreg2, obj, &dwc2_mmio_hreg2_ops, s,
-                          "host fifos", DWC2_HFIFO_SIZE);
+    memory_region_init_io(&s->hsotg, obj, &dwc2_mmio_hsotg_ops, s,
+                          "dwc2-io", 4 * KiB);
+    memory_region_add_subregion(&s->container, 0x0000, &s->hsotg);
 
-    memory_region_add_subregion(&s->mem, s->glbregbase, &s->mem_glbreg);
-    memory_region_add_subregion(&s->mem, s->fszregbase, &s->mem_fszreg);
-    memory_region_add_subregion(&s->mem, s->hreg0base, &s->mem_hreg0);
-    memory_region_add_subregion(&s->mem, s->hreg1base, &s->mem_hreg1);
-    memory_region_add_subregion(&s->mem, s->pcgregbase, &s->mem_pcgreg);
-    memory_region_add_subregion(&s->mem, s->hfifobase, &s->mem_hreg2);
+    memory_region_init_io(&s->fifos, obj, &dwc2_mmio_hreg2_ops, s,
+                          "dwc2-fifo", 64 * KiB);
+    memory_region_add_subregion(&s->container, 0x1000, &s->fifos);
 
-    sysbus_init_mmio(sbd, &s->mem);
 }
 
 static const VMStateDescription vmstate_dwc2_state_packet = {
@@ -1303,13 +1297,6 @@ const VMStateDescription vmstate_dwc2_state = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT16(glbregbase, DWC2State),
-        VMSTATE_UINT16(fszregbase, DWC2State),
-        VMSTATE_UINT16(hreg0base, DWC2State),
-        VMSTATE_UINT16(hreg1base, DWC2State),
-        VMSTATE_UINT16(pcgregbase, DWC2State),
-        VMSTATE_UINT16(hfifobase, DWC2State),
-
         VMSTATE_UINT32_ARRAY(glbreg, DWC2State,
                              DWC2_GLBREG_SIZE / sizeof(uint32_t)),
         VMSTATE_UINT32_ARRAY(fszreg, DWC2State,
@@ -1343,6 +1330,8 @@ const VMStateDescription vmstate_dwc2_state = {
 
 static Property dwc2_usb_properties[] = {
     DEFINE_PROP_UINT32("usb_version", DWC2State, usb_version, 2),
+    /* FIXME isn't 'usb_version=2' const? */
+    DEFINE_PROP_END_OF_LIST()
 };
 
 static void dwc2_class_init(ObjectClass *klass, void *data)
-- 
2.21.1


