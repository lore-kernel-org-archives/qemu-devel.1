Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6038BC0030B
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 15:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A554218AC
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 15:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A554218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6cya-0005VW-W7
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 11:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <th.huth@gmail.com>) id 1i6cwQ-0003k4-55
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 11:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1i6cwO-0007iP-L0
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 11:47:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33677)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1i6cwO-0007hf-E2
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 11:47:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so9510973wrr.0
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2019 08:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gPC/iaasD4XtjfEeV3SmRnKdOOaU73cKcFnYiqh/4z0=;
 b=nnGyowOoCPJoYGpQI+oVRopT+RHD4h3E/6LxYmYaA4vTayKQnESsTXpqR8kIhoCKnh
 6SYl+JwIe9PzPOkLZ+4Y1223wLh/6kqqCDchZlf2iEBcBQ9ipSPuPKcXspnhFNoGWn83
 IAx7Vh01MJc2r/bdzjzFzq26omOtn0CjeBiVasdJy3ZeZA/1uzvzcVnMViPbDfrMI/87
 vzspFFdM54YQH/sOljwsa6/1eO8+2AHCDjJANBU61nDqzAAwR1vVeDVdyk51BVwv1+zN
 oVrL9KUJkSD/iQpeOTVbtWptU69XigoKlk8Kb/7E8YvYbuyY/pQjPNf7DvGJoSaBF7kv
 gaPQ==
X-Gm-Message-State: APjAAAXDV6H3VhWLz/Fbn0mcp9towuUK8FnOYvQqFxznVvUqz37Z8ytw
 uBI4eiU7kJeGIVs7fa8taOU=
X-Google-Smtp-Source: APXvYqzxJDJsiC+8asg4bOahtuuAXKjY3mycOh94gNHDgXVd0nwj/0P0UuPA7OZTGNDqtMk/Nk78Tg==
X-Received: by 2002:a5d:5402:: with SMTP id g2mr12424695wrv.291.1567871275558; 
 Sat, 07 Sep 2019 08:47:55 -0700 (PDT)
Received: from thl530.multi.box (pD9E8385F.dip0.t-ipconnect.de.
 [217.232.56.95])
 by smtp.gmail.com with ESMTPSA id s19sm17173418wrb.14.2019.09.07.08.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2019 08:47:55 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Sat,  7 Sep 2019 17:47:40 +0200
Message-Id: <20190907154744.4136-5-huth@tuxfamily.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190907154744.4136-1-huth@tuxfamily.org>
References: <20190907154744.4136-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: [Qemu-devel] [PULL 4/8] escc: introduce a selector for the register
 bit
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
Message-Id: <20190831074519.32613-5-huth@tuxfamily.org>
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


