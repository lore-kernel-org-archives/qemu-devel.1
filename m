Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BC7C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 12:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F6721734
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 12:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dN435W0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F6721734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaHla-0005Ju-JT
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 07:19:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kaHfV-0007dC-OH
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 07:13:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25124)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kaHfS-0007pV-37
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 07:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604492013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XQO1B98I0F1rFfgToSxd8cv4Psq5YT5gZT8FEN8MdFM=;
 b=dN435W0Z5eTKkIvbsTvY7h1Vh1IE8m3zA1nS4TT4mtbP1iLDTyNgDCtdA1JZdAc5V3R3JL
 ANr5wdqbnywN5iGnK2Ck9FPp8Pm7afGxu/ElEXSil2ZPmJGtrw7Y6mCGW6ecxot3qGKw7e
 sjpvzHs6Yx5s/sSW7jE+RJCAJm2jPGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-wLN5-f4oP5qjYkTKMgw_jA-1; Wed, 04 Nov 2020 07:13:31 -0500
X-MC-Unique: wLN5-f4oP5qjYkTKMgw_jA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 394576415F;
 Wed,  4 Nov 2020 12:13:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85DCF10074EA;
 Wed,  4 Nov 2020 12:13:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4BFF19D0F; Wed,  4 Nov 2020 13:13:21 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/8] dev-serial: style changes to improve readability and
 checkpatch fixes
Date: Wed,  4 Nov 2020 13:13:14 +0100
Message-Id: <20201104121321.7772-2-kraxel@redhat.com>
In-Reply-To: <20201104121321.7772-1-kraxel@redhat.com>
References: <20201104121321.7772-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Message-id: 20201027150456.24606-2-mark.cave-ayland@ilande.co.uk
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-serial.c | 228 ++++++++++++++++++++++++--------------------
 1 file changed, 125 insertions(+), 103 deletions(-)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index b1622b7c7f94..7a5fa3770e7f 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -33,72 +33,75 @@ do { printf("usb-serial: " fmt , ## __VA_ARGS__); } while (0)
 #define RECV_BUF (512 - (2 * 8))
 
 /* Commands */
-#define FTDI_RESET		0
-#define FTDI_SET_MDM_CTRL	1
-#define FTDI_SET_FLOW_CTRL	2
-#define FTDI_SET_BAUD		3
-#define FTDI_SET_DATA		4
-#define FTDI_GET_MDM_ST		5
-#define FTDI_SET_EVENT_CHR	6
-#define FTDI_SET_ERROR_CHR	7
-#define FTDI_SET_LATENCY	9
-#define FTDI_GET_LATENCY	10
+#define FTDI_RESET             0
+#define FTDI_SET_MDM_CTRL      1
+#define FTDI_SET_FLOW_CTRL     2
+#define FTDI_SET_BAUD          3
+#define FTDI_SET_DATA          4
+#define FTDI_GET_MDM_ST        5
+#define FTDI_SET_EVENT_CHR     6
+#define FTDI_SET_ERROR_CHR     7
+#define FTDI_SET_LATENCY       9
+#define FTDI_GET_LATENCY       10
 
-#define DeviceOutVendor	((USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_DEVICE)<<8)
-#define DeviceInVendor	((USB_DIR_IN |USB_TYPE_VENDOR|USB_RECIP_DEVICE)<<8)
+#define DeviceOutVendor \
+           ((USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE) << 8)
+#define DeviceInVendor \
+           ((USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE) << 8)
 
 /* RESET */
 
-#define FTDI_RESET_SIO	0
-#define FTDI_RESET_RX	1
-#define FTDI_RESET_TX	2
+#define FTDI_RESET_SIO 0
+#define FTDI_RESET_RX  1
+#define FTDI_RESET_TX  2
 
 /* SET_MDM_CTRL */
 
-#define FTDI_DTR	1
-#define FTDI_SET_DTR	(FTDI_DTR << 8)
-#define FTDI_RTS	2
-#define FTDI_SET_RTS	(FTDI_RTS << 8)
+#define FTDI_DTR       1
+#define FTDI_SET_DTR   (FTDI_DTR << 8)
+#define FTDI_RTS       2
+#define FTDI_SET_RTS   (FTDI_RTS << 8)
 
 /* SET_FLOW_CTRL */
 
-#define FTDI_RTS_CTS_HS		1
-#define FTDI_DTR_DSR_HS		2
-#define FTDI_XON_XOFF_HS	4
+#define FTDI_RTS_CTS_HS    1
+#define FTDI_DTR_DSR_HS    2
+#define FTDI_XON_XOFF_HS   4
 
 /* SET_DATA */
 
-#define FTDI_PARITY	(0x7 << 8)
-#define FTDI_ODD	(0x1 << 8)
-#define FTDI_EVEN	(0x2 << 8)
-#define FTDI_MARK	(0x3 << 8)
-#define FTDI_SPACE	(0x4 << 8)
+#define FTDI_PARITY    (0x7 << 8)
+#define FTDI_ODD       (0x1 << 8)
+#define FTDI_EVEN      (0x2 << 8)
+#define FTDI_MARK      (0x3 << 8)
+#define FTDI_SPACE     (0x4 << 8)
 
-#define FTDI_STOP	(0x3 << 11)
-#define FTDI_STOP1	(0x0 << 11)
-#define FTDI_STOP15	(0x1 << 11)
-#define FTDI_STOP2	(0x2 << 11)
+#define FTDI_STOP      (0x3 << 11)
+#define FTDI_STOP1     (0x0 << 11)
+#define FTDI_STOP15    (0x1 << 11)
+#define FTDI_STOP2     (0x2 << 11)
 
 /* GET_MDM_ST */
 /* TODO: should be sent every 40ms */
-#define FTDI_CTS  (1<<4)        // CTS line status
-#define FTDI_DSR  (1<<5)        // DSR line status
-#define FTDI_RI   (1<<6)        // RI line status
-#define FTDI_RLSD (1<<7)        // Receive Line Signal Detect
+#define FTDI_CTS   (1 << 4)    /* CTS line status */
+#define FTDI_DSR   (1 << 5)    /* DSR line status */
+#define FTDI_RI    (1 << 6)    /* RI line status */
+#define FTDI_RLSD  (1 << 7)    /* Receive Line Signal Detect */
 
 /* Status */
 
-#define FTDI_DR   (1<<0)        // Data Ready
-#define FTDI_OE   (1<<1)        // Overrun Err
-#define FTDI_PE   (1<<2)        // Parity Err
-#define FTDI_FE   (1<<3)        // Framing Err
-#define FTDI_BI   (1<<4)        // Break Interrupt
-#define FTDI_THRE (1<<5)        // Transmitter Holding Register
-#define FTDI_TEMT (1<<6)        // Transmitter Empty
-#define FTDI_FIFO (1<<7)        // Error in FIFO
+#define FTDI_DR    (1 << 0)    /* Data Ready */
+#define FTDI_OE    (1 << 1)    /* Overrun Err */
+#define FTDI_PE    (1 << 2)    /* Parity Err */
+#define FTDI_FE    (1 << 3)    /* Framing Err */
+#define FTDI_BI    (1 << 4)    /* Break Interrupt */
+#define FTDI_THRE  (1 << 5)    /* Transmitter Holding Register */
+#define FTDI_TEMT  (1 << 6)    /* Transmitter Empty */
+#define FTDI_FIFO  (1 << 7)    /* Error in FIFO */
 
 struct USBSerialState {
     USBDevice dev;
+
     USBEndpoint *intr;
     uint8_t recv_buf[RECV_BUF];
     uint16_t recv_ptr;
@@ -216,29 +219,34 @@ static uint8_t usb_get_modem_lines(USBSerialState *s)
 
     if (qemu_chr_fe_ioctl(&s->cs,
                           CHR_IOCTL_SERIAL_GET_TIOCM, &flags) == -ENOTSUP) {
-        return FTDI_CTS|FTDI_DSR|FTDI_RLSD;
+        return FTDI_CTS | FTDI_DSR | FTDI_RLSD;
     }
 
     ret = 0;
-    if (flags & CHR_TIOCM_CTS)
+    if (flags & CHR_TIOCM_CTS) {
         ret |= FTDI_CTS;
-    if (flags & CHR_TIOCM_DSR)
+    }
+    if (flags & CHR_TIOCM_DSR) {
         ret |= FTDI_DSR;
-    if (flags & CHR_TIOCM_RI)
+    }
+    if (flags & CHR_TIOCM_RI) {
         ret |= FTDI_RI;
-    if (flags & CHR_TIOCM_CAR)
+    }
+    if (flags & CHR_TIOCM_CAR) {
         ret |= FTDI_RLSD;
+    }
 
     return ret;
 }
 
 static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
-               int request, int value, int index, int length, uint8_t *data)
+                                      int request, int value, int index,
+                                      int length, uint8_t *data)
 {
     USBSerialState *s = (USBSerialState *)dev;
     int ret;
 
-    DPRINTF("got control %x, value %x\n",request, value);
+    DPRINTF("got control %x, value %x\n", request, value);
     ret = usb_desc_handle_control(dev, p, request, value, index, length, data);
     if (ret >= 0) {
         return;
@@ -248,7 +256,7 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
     case EndpointOutRequest | USB_REQ_CLEAR_FEATURE:
         break;
 
-        /* Class specific requests.  */
+    /* Class specific requests.  */
     case DeviceOutVendor | FTDI_RESET:
         switch (value) {
         case FTDI_RESET_SIO:
@@ -269,16 +277,18 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
         static int flags;
         qemu_chr_fe_ioctl(&s->cs, CHR_IOCTL_SERIAL_GET_TIOCM, &flags);
         if (value & FTDI_SET_RTS) {
-            if (value & FTDI_RTS)
+            if (value & FTDI_RTS) {
                 flags |= CHR_TIOCM_RTS;
-            else
+            } else {
                 flags &= ~CHR_TIOCM_RTS;
+            }
         }
         if (value & FTDI_SET_DTR) {
-            if (value & FTDI_DTR)
+            if (value & FTDI_DTR) {
                 flags |= CHR_TIOCM_DTR;
-            else
+            } else {
                 flags &= ~CHR_TIOCM_DTR;
+            }
         }
         qemu_chr_fe_ioctl(&s->cs, CHR_IOCTL_SERIAL_SET_TIOCM, &flags);
         break;
@@ -293,10 +303,12 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
         int divisor = value & 0x3fff;
 
         /* chip special cases */
-        if (divisor == 1 && subdivisor8 == 0)
+        if (divisor == 1 && subdivisor8 == 0) {
             subdivisor8 = 4;
-        if (divisor == 0 && subdivisor8 == 0)
+        }
+        if (divisor == 0 && subdivisor8 == 0) {
             divisor = 1;
+        }
 
         s->params.speed = (48000000 / 2) / (8 * divisor + subdivisor8);
         qemu_chr_fe_ioctl(&s->cs, CHR_IOCTL_SERIAL_SET_PARAMS, &s->params);
@@ -304,30 +316,32 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
     }
     case DeviceOutVendor | FTDI_SET_DATA:
         switch (value & FTDI_PARITY) {
-            case 0:
-                s->params.parity = 'N';
-                break;
-            case FTDI_ODD:
-                s->params.parity = 'O';
-                break;
-            case FTDI_EVEN:
-                s->params.parity = 'E';
-                break;
-            default:
-                DPRINTF("unsupported parity %d\n", value & FTDI_PARITY);
-                goto fail;
+        case 0:
+            s->params.parity = 'N';
+            break;
+        case FTDI_ODD:
+            s->params.parity = 'O';
+            break;
+        case FTDI_EVEN:
+            s->params.parity = 'E';
+            break;
+        default:
+            DPRINTF("unsupported parity %d\n", value & FTDI_PARITY);
+            goto fail;
         }
+
         switch (value & FTDI_STOP) {
-            case FTDI_STOP1:
-                s->params.stop_bits = 1;
-                break;
-            case FTDI_STOP2:
-                s->params.stop_bits = 2;
-                break;
-            default:
-                DPRINTF("unsupported stop bits %d\n", value & FTDI_STOP);
-                goto fail;
+        case FTDI_STOP1:
+            s->params.stop_bits = 1;
+            break;
+        case FTDI_STOP2:
+            s->params.stop_bits = 2;
+            break;
+        default:
+            DPRINTF("unsupported stop bits %d\n", value & FTDI_STOP);
+            goto fail;
         }
+
         qemu_chr_fe_ioctl(&s->cs, CHR_IOCTL_SERIAL_SET_PARAMS, &s->params);
         /* TODO: TX ON/OFF */
         break;
@@ -423,20 +437,24 @@ static void usb_serial_handle_data(USBDevice *dev, USBPacket *p)
 
     switch (p->pid) {
     case USB_TOKEN_OUT:
-        if (devep != 2)
+        if (devep != 2) {
             goto fail;
+        }
         for (i = 0; i < p->iov.niov; i++) {
             iov = p->iov.iov + i;
-            /* XXX this blocks entire thread. Rewrite to use
-             * qemu_chr_fe_write and background I/O callbacks */
+            /*
+             * XXX this blocks entire thread. Rewrite to use
+             * qemu_chr_fe_write and background I/O callbacks
+             */
             qemu_chr_fe_write_all(&s->cs, iov->iov_base, iov->iov_len);
         }
         p->actual_length = p->iov.size;
         break;
 
     case USB_TOKEN_IN:
-        if (devep != 1)
+        if (devep != 1) {
             goto fail;
+        }
         usb_serial_token_in(s, p);
         break;
 
@@ -464,21 +482,24 @@ static void usb_serial_read(void *opaque, const uint8_t *buf, int size)
     int first_size, start;
 
     /* room in the buffer? */
-    if (size > (RECV_BUF - s->recv_used))
+    if (size > (RECV_BUF - s->recv_used)) {
         size = RECV_BUF - s->recv_used;
+    }
 
     start = s->recv_ptr + s->recv_used;
     if (start < RECV_BUF) {
         /* copy data to end of buffer */
         first_size = RECV_BUF - start;
-        if (first_size > size)
+        if (first_size > size) {
             first_size = size;
+        }
 
         memcpy(s->recv_buf + start, buf, first_size);
 
         /* wrap around to front if needed */
-        if (size > first_size)
+        if (size > first_size) {
             memcpy(s->recv_buf, buf + first_size, size - first_size);
+        }
     } else {
         start -= RECV_BUF;
         memcpy(s->recv_buf + start, buf, size);
@@ -493,23 +514,23 @@ static void usb_serial_event(void *opaque, QEMUChrEvent event)
     USBSerialState *s = opaque;
 
     switch (event) {
-        case CHR_EVENT_BREAK:
-            s->event_trigger |= FTDI_BI;
-            break;
-        case CHR_EVENT_OPENED:
-            if (!s->dev.attached) {
-                usb_device_attach(&s->dev, &error_abort);
-            }
-            break;
-        case CHR_EVENT_CLOSED:
-            if (s->dev.attached) {
-                usb_device_detach(&s->dev);
-            }
-            break;
-        case CHR_EVENT_MUX_IN:
-        case CHR_EVENT_MUX_OUT:
-            /* Ignore */
-            break;
+    case CHR_EVENT_BREAK:
+        s->event_trigger |= FTDI_BI;
+        break;
+    case CHR_EVENT_OPENED:
+        if (!s->dev.attached) {
+            usb_device_attach(&s->dev, &error_abort);
+        }
+        break;
+    case CHR_EVENT_CLOSED:
+        if (s->dev.attached) {
+            usb_device_detach(&s->dev);
+        }
+        break;
+    case CHR_EVENT_MUX_IN:
+    case CHR_EVENT_MUX_OUT:
+        /* Ignore */
+        break;
     }
 }
 
@@ -549,8 +570,9 @@ static USBDevice *usb_braille_init(const char *unused)
     Chardev *cdrv;
 
     cdrv = qemu_chr_new("braille", "braille", NULL);
-    if (!cdrv)
+    if (!cdrv) {
         return NULL;
+    }
 
     dev = usb_new("usb-braille");
     qdev_prop_set_chr(&dev->qdev, "chardev", cdrv);
-- 
2.27.0


