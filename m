Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0868FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 08:40:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E37223B0
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 08:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E37223B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWy3h-0001F0-4w
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 04:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kWxxj-0003JD-ON
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 04:34:43 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:46974
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kWxxg-000601-T7
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 04:34:43 -0400
Received: from host86-148-103-79.range86-148.btcentralplus.com
 ([86.148.103.79] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kWxxj-00082O-UZ; Mon, 26 Oct 2020 08:34:48 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	kraxel@redhat.com,
	samuel.thibault@ens-lyon.org
Date: Mon, 26 Oct 2020 08:33:57 +0000
Message-Id: <20201026083401.13231-6-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201026083401.13231-1-mark.cave-ayland@ilande.co.uk>
References: <20201026083401.13231-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.148.103.79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 5/9] dev-serial: replace DeviceOutVendor/DeviceInVendor with
 equivalent macros from usb.h
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The DeviceOutVendor and DeviceInVendor macros can be replaced with their
equivalent VendorDeviceOutRequest and VendorDeviceRequest macros from usb.h.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/usb/dev-serial.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index badf8785db..92c35615eb 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -37,11 +37,6 @@
 #define FTDI_SET_LATENCY       9
 #define FTDI_GET_LATENCY       10
 
-#define DeviceOutVendor \
-           ((USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE) << 8)
-#define DeviceInVendor \
-           ((USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE) << 8)
-
 /* RESET */
 
 #define FTDI_RESET_SIO 0
@@ -253,7 +248,7 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
         break;
 
     /* Class specific requests.  */
-    case DeviceOutVendor | FTDI_RESET:
+    case VendorDeviceOutRequest | FTDI_RESET:
         switch (value) {
         case FTDI_RESET_SIO:
             usb_serial_reset(s);
@@ -268,7 +263,7 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
             break;
         }
         break;
-    case DeviceOutVendor | FTDI_SET_MDM_CTRL:
+    case VendorDeviceOutRequest | FTDI_SET_MDM_CTRL:
     {
         static int flags;
         qemu_chr_fe_ioctl(&s->cs, CHR_IOCTL_SERIAL_GET_TIOCM, &flags);
@@ -289,10 +284,10 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
         qemu_chr_fe_ioctl(&s->cs, CHR_IOCTL_SERIAL_SET_TIOCM, &flags);
         break;
     }
-    case DeviceOutVendor | FTDI_SET_FLOW_CTRL:
+    case VendorDeviceOutRequest | FTDI_SET_FLOW_CTRL:
         /* TODO: ioctl */
         break;
-    case DeviceOutVendor | FTDI_SET_BAUD: {
+    case VendorDeviceOutRequest | FTDI_SET_BAUD: {
         static const int subdivisors8[8] = { 0, 4, 2, 1, 3, 5, 6, 7 };
         int subdivisor8 = subdivisors8[((value & 0xc000) >> 14)
                                      | ((index & 1) << 2)];
@@ -311,7 +306,7 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
         qemu_chr_fe_ioctl(&s->cs, CHR_IOCTL_SERIAL_SET_PARAMS, &s->params);
         break;
     }
-    case DeviceOutVendor | FTDI_SET_DATA:
+    case VendorDeviceOutRequest | FTDI_SET_DATA:
         switch (value & FTDI_PARITY) {
         case 0:
             s->params.parity = 'N';
@@ -346,23 +341,23 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
         qemu_chr_fe_ioctl(&s->cs, CHR_IOCTL_SERIAL_SET_PARAMS, &s->params);
         /* TODO: TX ON/OFF */
         break;
-    case DeviceInVendor | FTDI_GET_MDM_ST:
+    case VendorDeviceRequest | FTDI_GET_MDM_ST:
         data[0] = usb_get_modem_lines(s) | 1;
         data[1] = FTDI_THRE | FTDI_TEMT;
         p->actual_length = 2;
         break;
-    case DeviceOutVendor | FTDI_SET_EVENT_CHR:
+    case VendorDeviceOutRequest | FTDI_SET_EVENT_CHR:
         /* TODO: handle it */
         s->event_chr = value;
         break;
-    case DeviceOutVendor | FTDI_SET_ERROR_CHR:
+    case VendorDeviceOutRequest | FTDI_SET_ERROR_CHR:
         /* TODO: handle it */
         s->error_chr = value;
         break;
-    case DeviceOutVendor | FTDI_SET_LATENCY:
+    case VendorDeviceOutRequest | FTDI_SET_LATENCY:
         s->latency = value;
         break;
-    case DeviceInVendor | FTDI_GET_LATENCY:
+    case VendorDeviceRequest | FTDI_GET_LATENCY:
         data[0] = s->latency;
         p->actual_length = 1;
         break;
-- 
2.20.1


