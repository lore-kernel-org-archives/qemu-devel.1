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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785CEC18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:46:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46B2620674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="riJ5KKx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B2620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDukU-00071Z-ED
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jandryuk@gmail.com>) id 1jDtp9-0002uZ-Qm
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:46:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jandryuk@gmail.com>) id 1jDtp8-0001sk-JT
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:46:47 -0400
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:44798)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jandryuk@gmail.com>) id 1jDtp8-0001nG-C4
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:46:46 -0400
Received: by mail-qv1-xf44.google.com with SMTP id w5so9314087qvp.11
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6huCwRcLnrRmQGGZQ5LTMmE1f5Gb39vHnRRdbzeE9oQ=;
 b=riJ5KKx/n6cd1x54GENcAF7aQNNiVgjydeEQZNAHeFiosmD7yakWh9dJeuKVXRpZ2c
 kbjUBlZbUunPMs4xgs63cWG9Ua3Fc9i2wE2LvNhG+hZ4RgNOtnDRMb/JxpPHYY9/IdQX
 lk02+ZNEr1CJ3u7Mo7di+Y/3U1ww8KUp2YIgmFZqUy3gE2u907olHLJrmK8ikqhM1h9F
 D9+TCV3f/29h2BqKxyLKyEXhfC2U9WrBqjMHKISe5yvMKZN6DzpjvDULJlI43Bx9En5h
 YQYGPYnKmCn9VuiwXYyXjDgSUM3X5k442vHYu753gMdzmVjsPLRciGJP+X740TFROs0W
 Zo7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6huCwRcLnrRmQGGZQ5LTMmE1f5Gb39vHnRRdbzeE9oQ=;
 b=umL4Hu9pAH+kYliwgS5EhMZvqF/M0guKYMjgzolPeiYqqS69yp0Jdj7QdcUvesAdH8
 Il5frmylHquzt3R7d0XfSfOsgI0cyPQgnLWFbS7HSGrgblzdPOg7cvU5NAdCsd/aVJG6
 3h1a7+r7mQvnDFwFTtySTqC0bAOIIPBU+AKscCAp8753wm8UT49ZtDK1MEkANp5wgs0s
 NuvW2miuHJQbDeTlngf2BSHwbYofOJ8zGjtA3iS2M2990T9HzXK4BgXilzfMQvMnIRhz
 KVJoTi9D1uJrwCG/oSXMXVpLX6NKPrj69xmMAQ5mjRyCZR0jFh8VaFuJm4oSLucDm/4Z
 9Pbg==
X-Gm-Message-State: ANhLgQ2DDbs34PU5vFu1Q0yrc52GmM5AavkaZiDj2rUyJFKUThUS4zGD
 4NsFGY5eZo/eP3INjzgE140=
X-Google-Smtp-Source: ADFU+vtN9nk2QWpxiagC7U9vH719Qyp0iS5F2Zllla44w+9M/Geou7UIRG5cALvADIyg2kykZdUW3A==
X-Received: by 2002:ad4:45e9:: with SMTP id q9mr910584qvu.199.1584380805774;
 Mon, 16 Mar 2020 10:46:45 -0700 (PDT)
Received: from pm2-ws13.praxislan02.com ([2001:470:8:67e:7408:9006:8741:9ceb])
 by smtp.gmail.com with ESMTPSA id
 g7sm218422qki.64.2020.03.16.10.46.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 10:46:45 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH v2 1/4] usb-serial: Move USB_TOKEN_IN into a helper function
Date: Mon, 16 Mar 2020 13:46:07 -0400
Message-Id: <20200316174610.115820-2-jandryuk@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316174610.115820-1-jandryuk@gmail.com>
References: <20200316174610.115820-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f44
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

We'll be adding a loop, so move the code into a helper function.  breaks
are replaced with returns.  While making this change, add braces to
single line if statements to comply with coding style and keep
checkpatch happy.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
v2: Add braces to single line if statements to comply with coding style.

 hw/usb/dev-serial.c | 80 ++++++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 34 deletions(-)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index daac75b7ae..d807ce5771 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -358,13 +358,56 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
     }
 }
 
+static void usb_serial_token_in(USBSerialState *s, USBPacket *p)
+{
+    int first_len, len;
+    uint8_t header[2];
+
+    first_len = RECV_BUF - s->recv_ptr;
+    len = p->iov.size;
+    if (len <= 2) {
+        p->status = USB_RET_NAK;
+        return;
+    }
+    header[0] = usb_get_modem_lines(s) | 1;
+    /* We do not have the uart details */
+    /* handle serial break */
+    if (s->event_trigger && s->event_trigger & FTDI_BI) {
+        s->event_trigger &= ~FTDI_BI;
+        header[1] = FTDI_BI;
+        usb_packet_copy(p, header, 2);
+        return;
+    } else {
+        header[1] = 0;
+    }
+    len -= 2;
+    if (len > s->recv_used) {
+        len = s->recv_used;
+    }
+    if (!len) {
+        p->status = USB_RET_NAK;
+        return;
+    }
+    if (first_len > len) {
+        first_len = len;
+    }
+    usb_packet_copy(p, header, 2);
+    usb_packet_copy(p, s->recv_buf + s->recv_ptr, first_len);
+    if (len > first_len) {
+        usb_packet_copy(p, s->recv_buf, len - first_len);
+    }
+    s->recv_used -= len;
+    s->recv_ptr = (s->recv_ptr + len) % RECV_BUF;
+
+    return;
+}
+
 static void usb_serial_handle_data(USBDevice *dev, USBPacket *p)
 {
     USBSerialState *s = (USBSerialState *)dev;
     uint8_t devep = p->ep->nr;
     struct iovec *iov;
-    uint8_t header[2];
-    int i, first_len, len;
+    int i;
 
     switch (p->pid) {
     case USB_TOKEN_OUT:
@@ -382,38 +425,7 @@ static void usb_serial_handle_data(USBDevice *dev, USBPacket *p)
     case USB_TOKEN_IN:
         if (devep != 1)
             goto fail;
-        first_len = RECV_BUF - s->recv_ptr;
-        len = p->iov.size;
-        if (len <= 2) {
-            p->status = USB_RET_NAK;
-            break;
-        }
-        header[0] = usb_get_modem_lines(s) | 1;
-        /* We do not have the uart details */
-        /* handle serial break */
-        if (s->event_trigger && s->event_trigger & FTDI_BI) {
-            s->event_trigger &= ~FTDI_BI;
-            header[1] = FTDI_BI;
-            usb_packet_copy(p, header, 2);
-            break;
-        } else {
-            header[1] = 0;
-        }
-        len -= 2;
-        if (len > s->recv_used)
-            len = s->recv_used;
-        if (!len) {
-            p->status = USB_RET_NAK;
-            break;
-        }
-        if (first_len > len)
-            first_len = len;
-        usb_packet_copy(p, header, 2);
-        usb_packet_copy(p, s->recv_buf + s->recv_ptr, first_len);
-        if (len > first_len)
-            usb_packet_copy(p, s->recv_buf, len - first_len);
-        s->recv_used -= len;
-        s->recv_ptr = (s->recv_ptr + len) % RECV_BUF;
+        usb_serial_token_in(s, p);
         break;
 
     default:
-- 
2.24.1


