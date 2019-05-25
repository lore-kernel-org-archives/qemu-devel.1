Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADA8C07542
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 23:15:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A3A32075E
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 23:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3A32075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47527 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUft0-0005Ex-MP
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 19:15:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hUflD-0006f1-HL
	for qemu-devel@nongnu.org; Sat, 25 May 2019 19:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hUfVD-0002YM-I7
	for qemu-devel@nongnu.org; Sat, 25 May 2019 18:51:01 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:49447)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hUfV6-0002Nl-Ih; Sat, 25 May 2019 18:50:52 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MwgKC-1ggRFs1DVi-00y7UD; Sun, 26 May 2019 00:50:22 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Sun, 26 May 2019 00:50:04 +0200
Message-Id: <20190525225013.13916-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525225013.13916-1-laurent@vivier.eu>
References: <20190525225013.13916-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gdgqlnd/RVlkWCviSEo0FWZtirTvv0+CDYd/USC4nCAQhkhJPEm
	6ZF8Fx0FcyYFmCErOiTBaX8oTm5I9NbbAf7kvWthODatguj1KqbdbbKLNaI9D3jwjGwcmwk
	Kvw8qkPQrG6k1aeykxCAYQNDMrSXeAdzG215oku2leaadb34uvdielN3M+wKcytYHmPoXVG
	1ZaHHIirPS+Wu+7iAwETA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gVZbSFfgSAA=:IffxhrUjD8JGF7wfE0oPIt
	jqWX3nGGBCpHCcPfkLD/UVmTu4ugrcCPlVyFDAL7RLk18tVjyda46ICheid6eBwpPuDQZ5CEz
	MtXFKUbVgn/kf7f6dV0myz0C8ZTUcK1prcoyZObQJY7IpBMJSScA0QxGB1aWYszw1M6VRLQmB
	LNsWnLFg2BbR+a71Ylm7W7MPFEKfnPdACQevQF+qUnzCLx0Z/Sc/RrfhQ4SlmSHb7JgBWtcWy
	ZUjrX5BU4EKEiKB+XP4CkzcfNbzFSJaWN2F0nf0d5tSM2oQVmfYbMKX/8lsY4KclHqHir7f5c
	wxgS1Ro2M06uH8nXIl6Ywn8Vcog9kV45NihIeDACYQqBZ+CAWzaMQX7mZI2aO/j2Xhks+6k17
	IntrSzKd2UlSBGE/QnsEl/u3D1FxedbqmC7oxJAIxz3iM6JxtuI6yr3v56utLjaVxGPok3ZUb
	zJXzCBpg+WNjpmdRip5kfJCFDxd1GyOckHBiLJ08vRUYLRj0JxzX6krB1B12ePfzPRUemxkLX
	2f6NiCDMFsALMGbWKYg562A0CTtle1qZfQhwRhQ8qvi1dU9UA1C2swv5JxVw2eGnCMe13O241
	dBvB4DG9aSekkSxTQIPIH4xJTieJDoJLuWQDYyQsTem2V25ICEwC8yEtJK7vhzny8RAER9gvi
	zZ94yYc/n4v70/D1Bck41fxUXLTcXS8rd+QuRzA/VjiaUGWjRe1qwNVKwVUJZ1aHAcrzcQeEO
	fPXy/ag0arL49ARKZH5Ly6BUzu72MQePW24eBN/yFQv7Njr5aP8vXJsvHs4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PATCH v7 01/10] escc: introduce a selector for the
 register bit
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
	Jason Wang <jasowang@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
	=?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
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
---
 hw/char/escc.c         | 30 ++++++++++++++++++++++++------
 include/hw/char/escc.h |  1 +
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/hw/char/escc.c b/hw/char/escc.c
index c5b05a63f1..3eee2e66e8 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -42,14 +42,21 @@
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
@@ -169,6 +176,16 @@ static void handle_kbd_command(ESCCChannelState *s, int val);
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
@@ -433,8 +450,8 @@ static void escc_mem_write(void *opaque, hwaddr addr,
     int newreg, channel;
 
     val &= 0xff;
-    saddr = (addr >> serial->it_shift) & 1;
-    channel = (addr >> (serial->it_shift + 1)) & 1;
+    saddr = (addr >> reg_shift(serial)) & 1;
+    channel = (addr >> chn_shift(serial)) & 1;
     s = &serial->chn[channel];
     switch (saddr) {
     case SERIAL_CTRL:
@@ -544,8 +561,8 @@ static uint64_t escc_mem_read(void *opaque, hwaddr addr,
     uint32_t ret;
     int channel;
 
-    saddr = (addr >> serial->it_shift) & 1;
-    channel = (addr >> (serial->it_shift + 1)) & 1;
+    saddr = (addr >> reg_shift(serial)) & 1;
+    channel = (addr >> chn_shift(serial)) & 1;
     s = &serial->chn[channel];
     switch (saddr) {
     case SERIAL_CTRL:
@@ -829,6 +846,7 @@ static void escc_realize(DeviceState *dev, Error **errp)
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
2.20.1


