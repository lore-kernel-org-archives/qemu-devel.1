Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAFCC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:47:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 776EC2073E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVCTUILq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776EC2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDumC-0002A9-LW
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jandryuk@gmail.com>) id 1jDtpE-00033c-Cw
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:46:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jandryuk@gmail.com>) id 1jDtpC-0002Ts-5k
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:46:51 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:39180)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jandryuk@gmail.com>) id 1jDtpB-0002OX-Ve
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:46:50 -0400
Received: by mail-qt1-x842.google.com with SMTP id f17so13678712qtq.6
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1bhwCIfQKKaw/R08di2pqGOd6dOxABFn7wMHJ0Kn9bo=;
 b=hVCTUILqyn25cAs18bIpcWe+mUdVZ5fYYw/XvvOARetvrzoNjm0MhDlkyQZXaGQNzH
 OYCfcVKfL336sVqZQs4cHS+bgUsjjixjjj8Lfkuui4WEY/6boIu6htKc3sfkTlpzFcMG
 FRYd0yVYZ18ZWauAESESj0W3q3kPn4ecz64E3TougC0kC0pyp6gAtu4rfM51SC0fI1ap
 8oCQu/6Gvk/UC4Tv/AQY4Fskww8d3GtZwMXgAJvsHfnaLbYzcndYmZ3Y+rw1Axe1gJR3
 pHUpYSPYueEG7WaYg21lbML+Kt4OKMHHIqoEMPrJ4TYTbpJfiK5gPaBDVDaf28b2uyj9
 ti6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1bhwCIfQKKaw/R08di2pqGOd6dOxABFn7wMHJ0Kn9bo=;
 b=Zoh5OIm219yjZlzBXqj3q5sX7i/gvevWDUXnttH35OMyJnGY65FeVD2rjwgh5mRiH0
 ltDOSI05im92uMA10VuvyimPYzlVHXWtG6Hn88d7YGIZEoFs7f3I5j0lYjvtdN8FHDFS
 wa1d+LLGSu1tsfqZ7l6XdX648F++7RQ9n+97CKGB3sCOsNA+2UhLVlf9drGFAFY+yNUq
 jP8fhMUjva83jhfLlwFXIUOXwRh54X+fRTx5XXaJc/dNMiyPvAk1KRDLN3Eu+/U9PRdO
 i5tPLm48oADtH8Y3l50FU1l7GpH2S5AVsKUzmCvjhy02YO07CSMXHXGYetesJuhhkd2D
 YhyA==
X-Gm-Message-State: ANhLgQ28mkKzl9cMvmguE25ywaec5YgHUnuWUInLx3wflieQOtfxAG1L
 o16jyCCtRHjjtBWDwdxXlzs=
X-Google-Smtp-Source: ADFU+vvVjtqfF5T5FJ5cYmY30KY+bFjLftrCBgzmVqIlW1PjwnJjjS77swQCKoPB1EWpFwOX4h3ptQ==
X-Received: by 2002:ac8:4cce:: with SMTP id l14mr1261605qtv.383.1584380809408; 
 Mon, 16 Mar 2020 10:46:49 -0700 (PDT)
Received: from pm2-ws13.praxislan02.com ([2001:470:8:67e:7408:9006:8741:9ceb])
 by smtp.gmail.com with ESMTPSA id
 g7sm218422qki.64.2020.03.16.10.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 10:46:48 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH v2 2/4] usb-serial: chunk data to wMaxPacketSize
Date: Mon, 16 Mar 2020 13:46:08 -0400
Message-Id: <20200316174610.115820-3-jandryuk@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316174610.115820-1-jandryuk@gmail.com>
References: <20200316174610.115820-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
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
 hw/usb/dev-serial.c | 47 ++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index d807ce5771..ec091b6a36 100644
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
@@ -380,24 +381,34 @@ static void usb_serial_token_in(USBSerialState *s, USBPacket *p)
     } else {
         header[1] = 0;
     }
-    len -= 2;
-    if (len > s->recv_used) {
-        len = s->recv_used;
-    }
-    if (!len) {
+
+    if (!s->recv_used) {
         p->status = USB_RET_NAK;
         return;
     }
-    if (first_len > len) {
-        first_len = len;
-    }
-    usb_packet_copy(p, header, 2);
-    usb_packet_copy(p, s->recv_buf + s->recv_ptr, first_len);
-    if (len > first_len) {
-        usb_packet_copy(p, s->recv_buf, len - first_len);
+
+    while (s->recv_used && packet_len > 2) {
+        int first_len, len;
+
+        len = MIN(packet_len, max_packet_size);
+        len -= 2;
+        if (len > s->recv_used) {
+            len = s->recv_used;
+        }
+
+        first_len = RECV_BUF - s->recv_ptr;
+        if (first_len > len) {
+            first_len = len;
+        }
+        usb_packet_copy(p, header, 2);
+        usb_packet_copy(p, s->recv_buf + s->recv_ptr, first_len);
+        if (len > first_len) {
+            usb_packet_copy(p, s->recv_buf, len - first_len);
+        }
+        s->recv_used -= len;
+        s->recv_ptr = (s->recv_ptr + len) % RECV_BUF;
+        packet_len -= len + 2;
     }
-    s->recv_used -= len;
-    s->recv_ptr = (s->recv_ptr + len) % RECV_BUF;
 
     return;
 }
-- 
2.24.1


