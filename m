Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8591EC43613
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 22:23:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56A1D215EA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 22:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A1D215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42298 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdiyq-0003En-Do
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 18:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35949)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hdiwp-0001ek-2b
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 18:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hdiwn-0007iE-LH
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 18:20:55 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:35475)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hdiwn-0007fN-CR
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 18:20:53 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MzR0i-1iYppW0ujA-00vQg8; Thu, 20 Jun 2019 00:19:50 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu, 20 Jun 2019 00:19:24 +0200
Message-Id: <20190619221933.1981-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619221933.1981-1-laurent@vivier.eu>
References: <20190619221933.1981-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NhQqWsTeW+0bMiwGym5bYPXwjtBviGB7fMaeSNfiDskP9v+uBIR
 zXBNyy84abGm/ReAdsHskhlu5vFGVJ5RvdqUY2HASBTJJPtF//3euJizJ6uCMkkjpgCIUNY
 2HNAzRTnVKvRY2KTgCVohNSnma4Wm90Uz3+s25k5i87gW6iR4vcKs8eEG0M7Wb0+OLwQMlm
 sY3h6WDtAC9NsH7MkKg2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nbd5B4q3H70=:QHw8bso+Zx9yb4HmNY+v7Y
 mX1wEVPcYz1GEtr3WPJ76hVF5Q+mj3LnExYyY715u5HYJ7BgP+/NShu/SXlhb0wBj7sNvB+Fe
 nSV9ZsWPpBf9CnpwLGoxukba3plA0JbiZGG3W3zK0GlgqnwOdGI0tJCikkQxy4LLpKh2pM3/G
 PJPJZ9sytZzQrD7U7cDqh3lfvirzRnUJ5Eth0XoAEOd38XQ3+MVsauaYgkR8N3Wp7709chzy6
 CrLevY0htOsyL2d17Cehg06A+GQGeob97LAoocaAFEkNWrYyvgrNng97yEIwQFrj7C0ejrXXK
 fF0C0Bpa067pKJ7Oo6JJ5K7vNJx9/1KhcfqwFg3JbxJCxAdFqYy/VAIC1K86Sr6NZ1j+ekPlM
 qcX/2k3Ln3HwHQrvkJl/cKArAOJhLUaUTUsGcF1Uc/KrHIJlVoQQHToQ5VYaMjdIqMJUrO5Lg
 0bZBN6LJE8WhVTOk/Gif9/D51VEH86E+fiIhqsCv3ZEfoiUQEG5j2tDToHF0QvpmN4SXztQrV
 I9VbiXgFd/95ip2iEFvzBADY6qi/yMj5pc7m3anL/y7ZpmPiZZTHfanBs4amX3ryyBMtqCvIS
 G9WZjifLTIFfDqQ30Q61GjsWY2MygVKhQMO0syyoTIG21JiCEK7Cv13WjUtBSVjY54KBo9Sxb
 Ru5N3e3BCMHbMtokBX9ok0+XYQxl/9lwMU2zBeMY1OO+xQkw8gaW6KFeVgKmM14WIRrUs0m+Q
 8sjR3s/oVwpiJxyyVfAGK6VSPeuy+rr91/mn99Ca/3S1ggZvoUqEbvdFt3Q=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
Subject: [Qemu-devel] [PATCH v8 01/10] escc: introduce a selector for the
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sparc and PowerMac, the bit 0 of the address
selects the register type (control or data) and
bit 1 selects the channel (B or A).

On m68k Macintosh, the bit 0 selects the channel and
bit 1 the register type.

This patch introduces a new parameter (bit_swap) to
the device interface to indicate bits usage must
be swapped between registers and channels.

For the moment all the machines use the bit 0,
but this change will be needed to emulate Quadra 800.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
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


