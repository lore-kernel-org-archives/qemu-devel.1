Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245B7C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 21:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBB0720863
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 21:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="f1r0GgTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB0720863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZiJo-000459-VO
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 16:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1iZiIW-0003e5-QV
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 16:23:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1iZiIV-0001cn-Gy
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 16:23:00 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37704)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1iZiIU-0001bq-Pb
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 16:22:59 -0500
Received: by mail-wr1-x441.google.com with SMTP id g7so3523200wrw.4
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 13:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=lBGJA2/RhKvSalgnovBC2N7a3rcBtlnFkJxCbDoF1h0=;
 b=f1r0GgTtxWr7q64L/SLDDrQcOHbsbh8wx1f+Y+AFmAVJyLylXntNnpoVWofutHqEJ6
 walbhegcpOT0gz1ztE0CfY1Ya/bwfKv9Pj7WOOsvoYPLLdZ/M12Fy7e5PfiFsZAs5Zeu
 B8ECCV6klm910b23K+VgD9Ga7R/Q4tggIuAe+y6zu7KIcJWM/Rbq8QImdzJB0+GjhHLb
 BSXhbo5BfVOgVRnKf1phAwnRn+TAjrrIp7k186qGmSOEnKXOTOiZOyEyrjw4BDJtcETo
 LA/+iOsgDNpvnVAn/XKaBihx1+dniHe6LtHUNcUFjFjzJZw1noyc95ro+RyB3QDoxRBG
 M/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=lBGJA2/RhKvSalgnovBC2N7a3rcBtlnFkJxCbDoF1h0=;
 b=PcVtXAFABS5irxcsWreHOBXwAW6JxwsMuOQJzoPj1YZF1qgUiDFHvGVl8Ph2Dgkc4I
 SNUncgaOrWoXTaDpZLePxkAKSfNwBrESY6yaATagCOK4gONp9F1HnO2r5+oWgM9Qn9gy
 5T1+LjlhT8Hw0+YiBwiA8m2q32kmdQU+ym7BQT0o6kXCU33VhGgGU6/GBVHvoVVe94Vi
 rG3MfK//XGXQm4/EJZ6sSp0yiDZZ8keXhLxAMuPGr+hmHDn1Y4KECq40QZEZsfs8bjkP
 33FI2JZ1LveOnIc2QcvQjVJ2sP9MG1sY7+CnWV9KBIZsAHMFvM/SSJczyAoyhJpRlDDm
 AM5w==
X-Gm-Message-State: APjAAAV8QYXwO2T9ABqjBA0hWfBsVhK7vRE9GQP3lces9anD0/yyV/s6
 bJe87e4lYXMCv/lG4FjGw9N69veP+oI=
X-Google-Smtp-Source: APXvYqzqfVhGDroq/VZjbsmWCuG61AS3uEeVZPBI5Zt8SDhwQcjdOJtrG65IQOVSEXF5PjcHOKolLg==
X-Received: by 2002:adf:f20f:: with SMTP id p15mr36686021wro.370.1574803376889; 
 Tue, 26 Nov 2019 13:22:56 -0800 (PST)
Received: from f2.redhat.com (bzq-79-182-78-197.red.bezeqint.net.
 [79.182.78.197])
 by smtp.gmail.com with ESMTPSA id g21sm17950252wrb.48.2019.11.26.13.22.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 26 Nov 2019 13:22:55 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org,
	kraxel@redhat.com
Subject: [PATCH] usbredir: remove 'remote wake' capability from configuration
 descriptor
Date: Tue, 26 Nov 2019 23:22:45 +0200
Message-Id: <20191126212245.27735-1-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: yan@daynix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the redirected device has this capability, Windows guest may
place the device into D2 and expect it to wake when the device
becomes active, but this will never happen. For example, when
internal Bluetooth adapter is redirected, keyboards and mice
connected to it do not work. Setting global property
'usb-redir.nowake=off' keeps 'remote wake' as is.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 hw/usb/redirect.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index e0f5ca6f81..e95898fe80 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -113,6 +113,7 @@ struct USBRedirDevice {
     /* Properties */
     CharBackend cs;
     bool enable_streams;
+    bool suppress_remote_wake;
     uint8_t debug;
     int32_t bootindex;
     char *filter_str;
@@ -1989,6 +1990,23 @@ static void usbredir_control_packet(void *priv, uint64_t id,
             memcpy(dev->dev.data_buf, data, data_len);
         }
         p->actual_length = len;
+        /*
+         * If this is GET_DESCRIPTOR request for configuration descriptor,
+         * remove 'remote wakeup' flag from it to prevent idle power down
+         * in Windows guest
+         */
+        if (dev->suppress_remote_wake &&
+            control_packet->requesttype == USB_DIR_IN &&
+            control_packet->request == USB_REQ_GET_DESCRIPTOR &&
+            control_packet->value == (USB_DT_CONFIG << 8) &&
+            control_packet->index == 0 &&
+            /* bmAttributes field of config descriptor */
+            len > 7 && (dev->dev.data_buf[7] & USB_CFG_ATT_WAKEUP)) {
+                DPRINTF("Removed remote wake %04X:%04X\n",
+                    dev->device_info.vendor_id,
+                    dev->device_info.product_id);
+                dev->dev.data_buf[7] &= ~USB_CFG_ATT_WAKEUP;
+            }
         usb_generic_async_ctrl_complete(&dev->dev, p);
     }
     free(data);
@@ -2530,6 +2548,7 @@ static Property usbredir_properties[] = {
     DEFINE_PROP_UINT8("debug", USBRedirDevice, debug, usbredirparser_warning),
     DEFINE_PROP_STRING("filter", USBRedirDevice, filter_str),
     DEFINE_PROP_BOOL("streams", USBRedirDevice, enable_streams, true),
+    DEFINE_PROP_BOOL("nowake", USBRedirDevice, suppress_remote_wake, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.17.1


