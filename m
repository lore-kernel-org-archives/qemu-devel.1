Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B709DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 15:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A51207F7
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 15:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Fcu4tCN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A51207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5saW-0004EK-Pn
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 11:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@amarulasolutions.com>)
 id 1k5sZm-0003Pd-1X
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 11:22:02 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:39340)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael@amarulasolutions.com>)
 id 1k5sZk-00026l-1e
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 11:22:01 -0400
Received: by mail-ed1-x541.google.com with SMTP id c10so1818489edk.6
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 08:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SNSac4kZC/U1Km6KZkmjHKAARIOOQ7Fu/rZ/BGHaWgw=;
 b=Fcu4tCN5JfBEFyU5bB3X1soZA/ACwk/ojkPPqOCvRusB5/ne4j4VMr+1gLSD5pKyap
 nbxYui62v7MkWtrNRgRuv0WPGKL53Wrf+V3/KfIn/QezUH9vab3/qONDSMkMy4+EBc1D
 3aqFP/VE85UHtHsYZjjKZhhCqZn86v57R7JxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SNSac4kZC/U1Km6KZkmjHKAARIOOQ7Fu/rZ/BGHaWgw=;
 b=HAaey1J31ne5GoJSdZXw+6LZrQKqg8z8Z4ZHKv7H7O/LsVfbdXPcXXvADBNx0wW9eW
 1zXI7KqmkH8MpViIythYS0L60Ldbba/XWk9rMa7fNRW6j7hPaTK2NLuahkeG8CBuraGi
 UFEfluDJ8ADBdAImEsvNork1HkzEmPIwE6BUvjGP14y/s9JodKg6DoL/Rdct7x2KD2bZ
 BGUjAXH7Lf9GDZOIeOYU+UVrwza4Kf8etyuJiA1HqFjX/DR6jqR9uxlGfZLIeEEKQlq8
 sraCoPMzVCb2XiC5NvJ0Gm0gHruBqrhq0rMzxqZsxMFabNELmuxrL1/P7ZYm6dT/TkV+
 sccg==
X-Gm-Message-State: AOAM5319ej+1xcyzw9HQGNo2+Iaz5pCyWo7/D3D/7NsUeaK5bax7ZczF
 Fteh4kdCjsBkfDbN/c1d3ljyRQ==
X-Google-Smtp-Source: ABdhPJziCMfwSIE+FbDSu7vgJShoXH6d08kemQBDAnvIggwrjjgHqBk4EZ0lkj7slo0fUZ6bGQOxVQ==
X-Received: by 2002:aa7:da48:: with SMTP id w8mr371087eds.329.1597245717511;
 Wed, 12 Aug 2020 08:21:57 -0700 (PDT)
Received: from localhost.localdomain ([151.61.166.176])
 by smtp.gmail.com with ESMTPSA id t26sm1731331ejd.55.2020.08.12.08.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 08:21:56 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] hw: dev-wacom: Support wacom tablet emulation in linux qemu
Date: Wed, 12 Aug 2020 17:21:49 +0200
Message-Id: <20200812152149.260163-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=michael@amarulasolutions.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Linux need to fill up the hid descriptor in order to let
the driver be emulated. This patch was tested on top of
qemu 4.2.0 and recent linux kernel.

modprobe wacom.ko
evtest tool

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 hw/usb/dev-wacom.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/hw/usb/dev-wacom.c b/hw/usb/dev-wacom.c
index 8aba44b8bc..fe95699672 100644
--- a/hw/usb/dev-wacom.c
+++ b/hw/usb/dev-wacom.c
@@ -259,6 +259,64 @@ static void usb_wacom_handle_reset(USBDevice *dev)
     s->mode = WACOM_MODE_HID;
 }
 
+static const uint8_t qemu_wacom_hid_report_descriptor[] = {
+	0x05, 0x01,
+	0x09, 0x02,
+	0xa1, 0x01,
+	0x85, 0x01,
+	0x09, 0x01,
+	0xa1, 0x00,
+	0x05, 0x09,
+	0x19, 0x01,
+	0x29, 0x03,
+	0x15, 0x00,
+	0x25, 0x01,
+	0x95, 0x03,
+	0x75, 0x01,
+	0x81, 0x02,
+	0x95, 0x01,
+	0x75, 0x05,
+	0x81, 0x01,
+	0x05, 0x01,
+	0x09, 0x30,
+	0x09, 0x31,
+	0x09, 0x38,
+	0x15, 0x81,
+	0x25, 0x7f,
+	0x75, 0x08,
+	0x95, 0x03,
+	0x81, 0x06,
+	0x95, 0x03,
+	0x81, 0x01,
+	0xc0, 0xc0,
+	0x05, 0x0d,
+	0x09, 0x01,
+	0xa1, 0x01,
+	0x85, 0x02,
+	0xa1, 0x00,
+	0x06, 0x00,
+	0xff, 0x09,
+	0x01, 0x15,
+	0x00, 0x26,
+	0xff, 0x00,
+	0x75, 0x08,
+	0x95, 0x07,
+	0x81, 0x02,
+	0xc0, 0x09,
+	0x01, 0x85,
+	0x63, 0x95,
+	0x07, 0x81,
+	0x02, 0x09,
+	0x01, 0x85,
+	0x02, 0x95,
+	0x01, 0xb1,
+	0x02, 0x09,
+	0x01, 0x85,
+	0x03, 0x95,
+	0x01, 0xb1,
+	0x02, 0xc0,
+};
+
 static void usb_wacom_handle_control(USBDevice *dev, USBPacket *p,
                int request, int value, int index, int length, uint8_t *data)
 {
@@ -271,6 +329,18 @@ static void usb_wacom_handle_control(USBDevice *dev, USBPacket *p,
     }
 
     switch (request) {
+    case InterfaceRequest | USB_REQ_GET_DESCRIPTOR:
+        switch (value >> 8) {
+        case 0x22:
+                memcpy(data, qemu_wacom_hid_report_descriptor,
+                       sizeof(qemu_wacom_hid_report_descriptor));
+                p->actual_length = sizeof(qemu_wacom_hid_report_descriptor);
+            break;
+        default:
+            goto fail;
+        }
+        break;
+
     case WACOM_SET_REPORT:
         if (s->mouse_grabbed) {
             qemu_remove_mouse_event_handler(s->eh_entry);
-- 
2.25.1


