Return-Path: <SRS0=aRDT=W3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA53C3A5A6
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 07:48:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B232343A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 07:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B232343A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3y7t-0002fA-C8
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 03:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <th.huth@gmail.com>) id 1i3y4x-0000zO-P7
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 03:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1i3y4t-0005r4-QF
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 03:45:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32797)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1i3y4r-0005XF-Ri
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 03:45:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id r17so7967930wme.0
 for <qemu-devel@nongnu.org>; Sat, 31 Aug 2019 00:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H0UFyDpbbv8A9RAHWSXrFtp5QPIF2nD2VJ3/zYyAEC0=;
 b=fCp0v8DL45CXaOey6z1WLWDjaYuUwNNuI5JrpYFe8sJvCdIwhKqDf4p41YoTuQF3nk
 TGTeqHRxlmOBut51AIu+2iKg7iMs8V7hG5b5AizHuZFmvg8RTbH0ARnEjsr7dU/Vugjj
 6ED6FoAwg/KBUMt3/dt+21+xMlV4tAf8KBZC8oDr4vwvVuR01xzSFjPr8EG2lLdO4EMB
 7ER9/MYncWXcRjQj6riSWl2ix5M62gv5ZbZ1Rm7wawLrpWYVMAdqTzFTe3kRD5Ur6DPD
 BwM0zcoo+AtrZhWc0QAcxPpmLBgWpoJ29YwX6Y1qZRDQOZhSIu9cWJKhZnmCo1lbT1kO
 SCxw==
X-Gm-Message-State: APjAAAUp4EdsYFaXxHpoZzA33/18HwONP28TvOhOfR/CJghbY2X3pgu1
 54Lq+40Dt+w3iyGgIj96Xj94yp41/E4=
X-Google-Smtp-Source: APXvYqxOCUMolDxlEmVFhGPDNzLaxC8XqBrzAeiWg1UjUqyGPGOuJ6aok6QPy04ncPUQcpHBSTl+ng==
X-Received: by 2002:a05:600c:20c2:: with SMTP id
 y2mr3382368wmm.68.1567237533630; 
 Sat, 31 Aug 2019 00:45:33 -0700 (PDT)
Received: from thl530.multi.box (pD9E83624.dip0.t-ipconnect.de.
 [217.232.54.36])
 by smtp.gmail.com with ESMTPSA id w1sm7546650wrm.38.2019.08.31.00.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Aug 2019 00:45:33 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org
Date: Sat, 31 Aug 2019 09:45:17 +0200
Message-Id: <20190831074519.32613-5-huth@tuxfamily.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190831074519.32613-1-huth@tuxfamily.org>
References: <20190831074519.32613-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: [Qemu-devel] [PATCH v5 4/6] escc: introduce a selector for the
 register bit
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <laurent@vivier.eu>

On Sparc and PowerMac, the bit 0 of the address selects the register
type (control or data) and bit 1 selects the channel (B or A).

On m68k Macintosh and NeXTcube, the bit 0 selects the channel and
bit 1 the register type.

This patch introduces a new parameter (bit_swap) to the device interface
to indicate bits usage must be swapped between registers and channels.

For the moment all the machines use the bit 0, but this change will be
needed to emulate the Quadra 800 or NeXTcube machine.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
[thh: added NeXTcube to the patch description]
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/char/escc.c         | 30 ++++++++++++++++++++++++------
 include/hw/char/escc.h |  1 +
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/hw/char/escc.c b/hw/char/escc.c
index e185522e27..8f7bf322cb 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -45,14 +45,21 @@
  * mouse and keyboard ports don't implement all functions and they are
  * only asynchronous. There is no DMA.
  *
- * Z85C30 is also used on PowerMacs. There are some small differences
- * between Sparc version (sunzilog) and PowerMac (pmac):
+ * Z85C30 is also used on PowerMacs and m68k Macs.
+ *
+ * There are some small differences between Sparc version (sunzilog)
+ * and PowerMac (pmac):
  *  Offset between control and data registers
  *  There is some kind of lockup bug, but we can ignore it
  *  CTS is inverted
  *  DMA on pmac using DBDMA chip
  *  pmac can do IRDA and faster rates, sunzilog can only do 38400
  *  pmac baud rate generator clock is 3.6864 MHz, sunzilog 4.9152 MHz
+ *
+ * Linux driver for m68k Macs is the same as for PowerMac (pmac_zilog),
+ * but registers are grouped by type and not by channel:
+ * channel is selected by bit 0 of the address (instead of bit 1)
+ * and register is selected by bit 1 of the address (instead of bit 0).
  */
 
 /*
@@ -172,6 +179,16 @@ static void handle_kbd_command(ESCCChannelState *s, int val);
 static int serial_can_receive(void *opaque);
 static void serial_receive_byte(ESCCChannelState *s, int ch);
 
+static int reg_shift(ESCCState *s)
+{
+    return s->bit_swap ? s->it_shift + 1 : s->it_shift;
+}
+
+static int chn_shift(ESCCState *s)
+{
+    return s->bit_swap ? s->it_shift : s->it_shift + 1;
+}
+
 static void clear_queue(void *opaque)
 {
     ESCCChannelState *s = opaque;
@@ -436,8 +453,8 @@ static void escc_mem_write(void *opaque, hwaddr addr,
     int newreg, channel;
 
     val &= 0xff;
-    saddr = (addr >> serial->it_shift) & 1;
-    channel = (addr >> (serial->it_shift + 1)) & 1;
+    saddr = (addr >> reg_shift(serial)) & 1;
+    channel = (addr >> chn_shift(serial)) & 1;
     s = &serial->chn[channel];
     switch (saddr) {
     case SERIAL_CTRL:
@@ -547,8 +564,8 @@ static uint64_t escc_mem_read(void *opaque, hwaddr addr,
     uint32_t ret;
     int channel;
 
-    saddr = (addr >> serial->it_shift) & 1;
-    channel = (addr >> (serial->it_shift + 1)) & 1;
+    saddr = (addr >> reg_shift(serial)) & 1;
+    channel = (addr >> chn_shift(serial)) & 1;
     s = &serial->chn[channel];
     switch (saddr) {
     case SERIAL_CTRL:
@@ -832,6 +849,7 @@ static void escc_realize(DeviceState *dev, Error **errp)
 static Property escc_properties[] = {
     DEFINE_PROP_UINT32("frequency", ESCCState, frequency,   0),
     DEFINE_PROP_UINT32("it_shift",  ESCCState, it_shift,    0),
+    DEFINE_PROP_BOOL("bit_swap",    ESCCState, bit_swap,    false),
     DEFINE_PROP_UINT32("disabled",  ESCCState, disabled,    0),
     DEFINE_PROP_UINT32("chnBtype",  ESCCState, chn[0].type, 0),
     DEFINE_PROP_UINT32("chnAtype",  ESCCState, chn[1].type, 0),
diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
index d5196c53e6..794b653484 100644
--- a/include/hw/char/escc.h
+++ b/include/hw/char/escc.h
@@ -51,6 +51,7 @@ typedef struct ESCCState {
 
     struct ESCCChannelState chn[2];
     uint32_t it_shift;
+    bool bit_swap;
     MemoryRegion mmio;
     uint32_t disabled;
     uint32_t frequency;
-- 
2.21.0


