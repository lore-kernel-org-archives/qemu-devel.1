Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1DCC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:57:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1601206E7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rqPFAbpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1601206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCNOp-0001Sz-S0
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 08:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jandryuk@gmail.com>) id 1jCNNs-00007v-IW
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:56:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jandryuk@gmail.com>) id 1jCNNr-0006yd-Eb
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:56:20 -0400
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41]:40836)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jandryuk@gmail.com>) id 1jCNNr-0006yQ-AX
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:56:19 -0400
Received: by mail-qv1-xf41.google.com with SMTP id u17so2513065qvv.7
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 05:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4z9fu4xftoAJXpbaT1HbZZon3sBmsuESzWRYay2EczM=;
 b=rqPFAbpujbuqIWfV0t/8pk2q2TiJNsEPYy5iFs/3l0DX9ja66X7vVAb7ILOLm9aEbx
 9X9Cb6k7qJ1fROdhm+HRqNuu/AlmOgQmEh6NGAuaZrjNYAEWUYjBwAHIzgSynn9EAzMx
 THXIazwrOvUUSGQKoPnFkasIh5UxFJoI/fPm/zjZcnSe/HQ/CzBUoP3iEPfHu3clGQ1t
 cGMeig9s5SVgE6RA2vxBSznkxlebr3PXEA3h4oisokTarv6HzqhV1xfkvEG8CAUGfdwV
 lclUMqRaKQx07/uVSxK+Fyk2ngrjlg4132TMcuCyPQPH9U0D6MHye7yDKWEdwUcMVGML
 knyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4z9fu4xftoAJXpbaT1HbZZon3sBmsuESzWRYay2EczM=;
 b=PWSAReilF1BW9AzJ5CPdZg0XEwumnCKp9cMZWa7Ix9HvV5pint9ZEPeKP4jKXbR6n1
 IOli0qtrFdu8nBvs2QVCdkmTACRpqdGRAVrZZQAKXj/AcD+HAWl7etWW3MH/I+Kv0oP1
 OqDQ2vguECps4wkwhWQUPu22r2txbPdRJap7nQ5VApC5k66v3xkJRSrBRSQ99R6l8Q6w
 Zdxg+KN6o9zHwyt28Xsmr8N7ABZ3IAKAUHVSmLwDbLLWcsR9DF6s2uMa/P8U5VR1imrE
 x7L6iixfbkHLEJDI61sz/JGrTHfTZGgmvNYvxx57btGmfJZMgXObLbQe3ezSdU79j8cs
 LmYQ==
X-Gm-Message-State: ANhLgQ1TWqTc/IOLNalWpVUcWZe7T6MVvGzN1QkblS2cuCT6OqkO37Yb
 nY6YDNYPrYWdvzfZEm0YHQA=
X-Google-Smtp-Source: ADFU+vtjOgVbtAYoWDePx8jh8danVl7zMEXxJJP8City2OKT5rati/En6CzdzN4EwpKTQycwGB4qNw==
X-Received: by 2002:ad4:4862:: with SMTP id u2mr7249542qvy.67.1584017778757;
 Thu, 12 Mar 2020 05:56:18 -0700 (PDT)
Received: from pm2-ws13.praxislan02.com ([2001:470:8:67e:ba27:ebff:fee8:ce27])
 by smtp.gmail.com with ESMTPSA id
 u3sm8001236qkc.4.2020.03.12.05.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 05:56:17 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 2/4] usb-serial: chunk data to wMaxPacketSize
Date: Thu, 12 Mar 2020 08:55:21 -0400
Message-Id: <20200312125524.7812-3-jandryuk@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200312125524.7812-1-jandryuk@gmail.com>
References: <20200312125524.7812-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f41
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
Cc: qemu-devel@nongnu.org, Jason Andryuk <jandryuk@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

usb-serial has issues with xHCI controllers where data is lost in the
VM.  Inspecting the URBs in the guest, EHCI starts every 64 byte boundary
(wMaxPacketSize) with a header.  EHCI hands packets into
usb_serial_token_in() with size 64, so these cannot cross the 64 byte
boundary.  The xHCI controller has packets of 512 bytes and the usb-serial
will just write through the 64 byte boundary.  In the guest, this means
data bytes are interpreted as header, so data bytes don't make it out
the serial interface.

Re-work usb_serial_token_in to chunk data into 64 byte units - 2 byte
header and 62 bytes data.  The Linux driver reads wMaxPacketSize to find
the chunk size, so we match that.

Real hardware was observed to pass in 512 byte URBs (496 bytes data +
8 * 2 byte headers).  Since usb-serial only buffers 384 bytes of data,
usb-serial will pass in 6 64 byte blocks and 1 12 byte partial block for
462 bytes max.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
 hw/usb/dev-serial.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 71fa786bd8..96b6c34202 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -360,15 +360,16 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
 
 static void usb_serial_token_in(USBSerialState *s, USBPacket *p)
 {
-    int first_len, len;
+    const int max_packet_size = desc_iface0.eps[0].wMaxPacketSize;
+    int packet_len;
     uint8_t header[2];
 
-    first_len = RECV_BUF - s->recv_ptr;
-    len = p->iov.size;
-    if (len <= 2) {
+    packet_len = p->iov.size;
+    if (packet_len <= 2) {
         p->status = USB_RET_NAK;
         return;
     }
+
     header[0] = usb_get_modem_lines(s) | 1;
     /* We do not have the uart details */
     /* handle serial break */
@@ -380,21 +381,31 @@ static void usb_serial_token_in(USBSerialState *s, USBPacket *p)
     } else {
         header[1] = 0;
     }
-    len -= 2;
-    if (len > s->recv_used)
-        len = s->recv_used;
-    if (!len) {
+
+    if (!s->recv_used) {
         p->status = USB_RET_NAK;
         return;
     }
-    if (first_len > len)
-        first_len = len;
-    usb_packet_copy(p, header, 2);
-    usb_packet_copy(p, s->recv_buf + s->recv_ptr, first_len);
-    if (len > first_len)
-        usb_packet_copy(p, s->recv_buf, len - first_len);
-    s->recv_used -= len;
-    s->recv_ptr = (s->recv_ptr + len) % RECV_BUF;
+
+    while (s->recv_used && packet_len > 2) {
+        int first_len, len;
+
+        len = MIN(packet_len, max_packet_size);
+        len -= 2;
+        if (len > s->recv_used)
+            len = s->recv_used;
+
+        first_len = RECV_BUF - s->recv_ptr;
+        if (first_len > len)
+            first_len = len;
+        usb_packet_copy(p, header, 2);
+        usb_packet_copy(p, s->recv_buf + s->recv_ptr, first_len);
+        if (len > first_len)
+            usb_packet_copy(p, s->recv_buf, len - first_len);
+        s->recv_used -= len;
+        s->recv_ptr = (s->recv_ptr + len) % RECV_BUF;
+        packet_len -= len + 2;
+    }
 
     return;
 }
-- 
2.24.1


