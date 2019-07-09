Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E02C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 07:38:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7232D21537
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 07:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7232D21537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkki3-0000cV-OK
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 03:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46765)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <th.huth@gmail.com>) id 1hkkcU-0004G4-4N
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1hkkcS-0001PA-TM
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:32:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38560)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1hkkcS-0001OX-MZ
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:32:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id s15so2036379wmj.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 00:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I78EBQqoexWrd3DtAp8rimVPzXVjwKzYLMylZZ4tlN4=;
 b=AHrENkiIFYRlzj5mhKBhUsQXxLbYRla/6woWyTDgEscvINFFtpuE5aEJkg4+kFvm9y
 vDBeYLZgQGG7CTCeeJrbTDYgLLeDBxyYhjBBRl4B1HKt3jmR5cPNhGkNGOi1gJ4Mkxsz
 rVC7XAZ6i/hM8w8N3QcOdu3g2CWdFY0dy9FUHzx668Ypm5UT49mPRllA/DWv2Tb0KnV0
 O+JqhV/dX7ktZIOAxt3o06WYztl3YvVnuWQCRhsRdqCOhc3rPgedXdKZ0Y/PcR+UsDWk
 D+56fbFUgZ+q9PS8q1wXmFp7QGVKSxIk5VM1oPa9nK9wGsYESUddaxB9NCu553EiVo4c
 l9+Q==
X-Gm-Message-State: APjAAAWcwmaNW7IQyyji239O+uedrnQLns9GACKw9XfydjK99Zdnml3x
 6quQaYzoz6EehKlf9DLh3clSB2ta0Ec=
X-Google-Smtp-Source: APXvYqztzG4sDkacFxPkQoNCTZk0LffdqkjdHVzCJ2HV4e+iSEFPQ03kyKmUCDd+LhtNwmUTCooPwQ==
X-Received: by 2002:a05:600c:2117:: with SMTP id
 u23mr20587986wml.117.1562657575369; 
 Tue, 09 Jul 2019 00:32:55 -0700 (PDT)
Received: from thl530.multi.box (pD95752BD.dip0.t-ipconnect.de.
 [217.87.82.189])
 by smtp.gmail.com with ESMTPSA id l2sm1529208wmj.4.2019.07.09.00.32.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 00:32:54 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 09:32:20 +0200
Message-Id: <20190709073222.26370-5-huth@tuxfamily.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190709073222.26370-1-huth@tuxfamily.org>
References: <20190709073222.26370-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: [Qemu-devel] [PATCH v4 4/6] escc: introduce a selector for the
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
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
needed to emulate Quadra 800 and the NeXTcube machine.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
[thh: added NeXTcube to the patch description]
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/char/escc.c         | 30 ++++++++++++++++++++++++------
 include/hw/char/escc.h |  1 +
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/hw/char/escc.c b/hw/char/escc.c
index 8ddbb4be4f..2748bd62c3 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -43,14 +43,21 @@
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
@@ -170,6 +177,16 @@ static void handle_kbd_command(ESCCChannelState *s, int val);
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
@@ -434,8 +451,8 @@ static void escc_mem_write(void *opaque, hwaddr addr,
     int newreg, channel;
 
     val &= 0xff;
-    saddr = (addr >> serial->it_shift) & 1;
-    channel = (addr >> (serial->it_shift + 1)) & 1;
+    saddr = (addr >> reg_shift(serial)) & 1;
+    channel = (addr >> chn_shift(serial)) & 1;
     s = &serial->chn[channel];
     switch (saddr) {
     case SERIAL_CTRL:
@@ -545,8 +562,8 @@ static uint64_t escc_mem_read(void *opaque, hwaddr addr,
     uint32_t ret;
     int channel;
 
-    saddr = (addr >> serial->it_shift) & 1;
-    channel = (addr >> (serial->it_shift + 1)) & 1;
+    saddr = (addr >> reg_shift(serial)) & 1;
+    channel = (addr >> chn_shift(serial)) & 1;
     s = &serial->chn[channel];
     switch (saddr) {
     case SERIAL_CTRL:
@@ -830,6 +847,7 @@ static void escc_realize(DeviceState *dev, Error **errp)
 static Property escc_properties[] = {
     DEFINE_PROP_UINT32("frequency", ESCCState, frequency,   0),
     DEFINE_PROP_UINT32("it_shift",  ESCCState, it_shift,    0),
+    DEFINE_PROP_BOOL("bit_swap",    ESCCState, bit_swap,    false),
     DEFINE_PROP_UINT32("disabled",  ESCCState, disabled,    0),
     DEFINE_PROP_UINT32("chnBtype",  ESCCState, chn[0].type, 0),
     DEFINE_PROP_UINT32("chnAtype",  ESCCState, chn[1].type, 0),
diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
index 42aca83611..8762f61c14 100644
--- a/include/hw/char/escc.h
+++ b/include/hw/char/escc.h
@@ -50,6 +50,7 @@ typedef struct ESCCState {
 
     struct ESCCChannelState chn[2];
     uint32_t it_shift;
+    bool bit_swap;
     MemoryRegion mmio;
     uint32_t disabled;
     uint32_t frequency;
-- 
2.21.0


