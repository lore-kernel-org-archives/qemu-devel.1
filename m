Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48375C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:10:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1336A206CC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+2wLrhl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1336A206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jADg6-000479-8E
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 09:10:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jandryuk@gmail.com>) id 1jADfV-0003hx-Nl
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:09:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jandryuk@gmail.com>) id 1jADfU-00006x-Dl
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:09:37 -0500
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:34108)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jandryuk@gmail.com>) id 1jADfU-0008O9-94
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:09:36 -0500
Received: by mail-qk1-x744.google.com with SMTP id f3so2402882qkh.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 06:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Nt6m3TsjhXX+wO8W6KtjYMSRFi76O8CJKhcmejzM/Y4=;
 b=Z+2wLrhlgFbq6YMtgEnu5i9zdSJFsRE72aN70BdVXOE+Umf0fZ6t7QdRLmGbGokyxq
 c+JLPhNRXa2ph6rDa8g1XKhVeVApWzFBmvJBLDp38ORjsoHCtvSCq3fZHv5NxPZ0LmV3
 r5a65fVfS2NkMTJN6Nkq9b4Nciwto4Skoah00g41RVDeJoRLfmsYLQAKkkeaKCKNyRwO
 3kUjjkLsVDJH6+ylVqZoKYGoQyFDx/xXqL6lo6/8yRiZ7CCFsDDoCDKVT3OSW7l8lVoi
 jfgZJMlFeNNzIys92i8HDspFXoBlCAeHUV0wSWMjnJvOaRmbfPxIMl8pLy473C5PDQlN
 OYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Nt6m3TsjhXX+wO8W6KtjYMSRFi76O8CJKhcmejzM/Y4=;
 b=nqDziMRMA704ddlsvejUDyWMq7YQ3keNo0kk7iy+lv4y0s4TIP6W/latbRWgVJO/28
 Bf4RoN6MbExZHj7mAekv6VgrSspRzV7EA3aRgkj35g+yexLXaAIPp8MikI7SZQ8PqqUG
 tTB0+1mSHPuSRO8eE0WObmS/zrNdIZIzpEwWQmnsjpaVCk10laSbaBHoaaLUHeXXo0uK
 idOVktclpOTA2Xamg0fxSv0TCF7DOzX0oo6p3/yeNYwz+mrlJOoeZRiidAMmJp/2ftfY
 032ijz8Sfx5VFSi9bCVZ2niAY/to4cBXTYlYaOPcyM9fMohhUoZ0wyFk0ufZSio1AI7b
 gDAQ==
X-Gm-Message-State: ANhLgQ1QRg+KNJh7R/JEDZfCqBLJWqQNKtpQsdva1tUf52v6Ti8qO2RI
 bctSqftXh48PmFsEXPCxX9s=
X-Google-Smtp-Source: ADFU+vvpcdirx7cEHiUJaZX+1MwCcxGY2FXfsR6mlqdcav3AUb7FtGZ1K9Ibzj3Hr6DAxcS8SD3FCg==
X-Received: by 2002:a37:aa88:: with SMTP id t130mr3192546qke.452.1583503775003; 
 Fri, 06 Mar 2020 06:09:35 -0800 (PST)
Received: from pm2-ws13.praxislan02.com ([2001:470:8:67e:ba27:ebff:fee8:ce27])
 by smtp.gmail.com with ESMTPSA id
 o16sm4749282qkm.68.2020.03.06.06.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 06:09:34 -0800 (PST)
From: Jason Andryuk <jandryuk@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH] usb-serial: wakeup device on input
Date: Fri,  6 Mar 2020 09:09:17 -0500
Message-Id: <20200306140917.26726-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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

Currently usb-serial devices are unable to send data into guests with
the xhci controller.  Data is copied into the usb-serial's buffer, but
it is not sent into the guest.  Data coming out of the guest works
properly.  usb-serial devices work properly with ehci.

Have usb-serial call usb_wakeup() when receiving data from the chardev.
This seems to notify the xhci controller and fix inbound data flow.

Also add USB_CFG_ATT_WAKEUP to the device's bmAttributes.  This matches
a real FTDI serial adapter's bmAttributes.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>

---
Other devices added USB_CFG_ATT_WAKEUP which is why it is repeated here.
Inbound data flow works without it, but it seems like USB_CFG_ATT_WAKEUP
should be set when using usb_wakeup.
---
 hw/usb/dev-serial.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 98465990ef..daac75b7ae 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -98,6 +98,7 @@ do { printf("usb-serial: " fmt , ## __VA_ARGS__); } while (0)
 
 typedef struct {
     USBDevice dev;
+    USBEndpoint *intr;
     uint8_t recv_buf[RECV_BUF];
     uint16_t recv_ptr;
     uint16_t recv_used;
@@ -153,7 +154,7 @@ static const USBDescDevice desc_device = {
         {
             .bNumInterfaces        = 1,
             .bConfigurationValue   = 1,
-            .bmAttributes          = USB_CFG_ATT_ONE,
+            .bmAttributes          = USB_CFG_ATT_ONE | USB_CFG_ATT_WAKEUP,
             .bMaxPower             = 50,
             .nif = 1,
             .ifs = &desc_iface0,
@@ -459,6 +460,8 @@ static void usb_serial_read(void *opaque, const uint8_t *buf, int size)
         memcpy(s->recv_buf + start, buf, size);
     }
     s->recv_used += size;
+
+    usb_wakeup(s->intr, 0);
 }
 
 static void usb_serial_event(void *opaque, QEMUChrEvent event)
@@ -513,6 +516,7 @@ static void usb_serial_realize(USBDevice *dev, Error **errp)
     if (qemu_chr_fe_backend_open(&s->cs) && !dev->attached) {
         usb_device_attach(dev, &error_abort);
     }
+    s->intr = usb_ep_get(dev, USB_TOKEN_IN, 1);
 }
 
 static USBDevice *usb_braille_init(USBBus *bus, const char *unused)
-- 
2.24.1


