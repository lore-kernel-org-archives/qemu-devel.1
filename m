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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D783C1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2173206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pr7tUsKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2173206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCNPq-0002pz-0v
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 08:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jandryuk@gmail.com>) id 1jCNNl-0008RL-HG
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:56:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jandryuk@gmail.com>) id 1jCNNk-0006vv-FM
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:56:13 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:42959)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jandryuk@gmail.com>) id 1jCNNk-0006vd-BH
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:56:12 -0400
Received: by mail-qk1-x743.google.com with SMTP id e11so5888771qkg.9
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 05:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S4VyMnnrXmFdqqKgbyIqtVlSvsxqhziTW8yuqDzG8uY=;
 b=Pr7tUsKGJi3dEZRTd3xcTFE7RxiTs3vIQ2t0jwiZc+DNXOUAhCsP9XH8cJaCxsdI0u
 2tv6TACuE1ktqkCX3yNXWr2aWtnPwo8AR/+2O/oxscvWz6ciQnw+K9aeuRAuCsu+bFLD
 hrSky4SXWFmfshaJ3ciO2lZN31FLt+tfYFfSK+vzgNGRiSmnknXZgqKbD3SQlK9HIoiN
 sFEOkuCeAbk1G/cEIT54adOLfqrARBs+SNqTf6JmZCKDxX+bGNwJN+RM741XN79JbhAk
 ycDCy95kakQc+snjBsX3PoNahnQ/s88t5z+hVuWYL46DE4iKmkQYxjKEVQI/M7aAPOCr
 KUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S4VyMnnrXmFdqqKgbyIqtVlSvsxqhziTW8yuqDzG8uY=;
 b=dJzTDrV3ZMf0F5P/tf7BJB+vBIda7fTwIb1oNnYmkpn+yOPidguGoFNqbWjUmfSmpI
 Hk4+JCyEM9hYmqsWuV7sbIIOTtW8I7eSmgKwQ8Osj8/m2MoKPax9zlTPr6MUgenlSLtU
 u4RKBwIgB0y1994diozr7zPi9gSKAuqt6ipICyn02t83Y+WYVo+PHzyqEvOquHpTKxKE
 8BbvQgPIvzSs6I8PYWM6IxRhqHnj3ufCkmc4ikzcZ29wG4Md0wnr+l+G02txzo+dqP9P
 0G/suftAMXQ4L99jG0aWsGMGwuKBcBvPLa/ZRRIWMU1iWHEVoVHSklVoagtFY2r4V/LK
 6zPg==
X-Gm-Message-State: ANhLgQ0+LVriJ6bisRbUWjK1H9uZm8ibZU6joZvL7ThIHyNkbnpO9I1r
 UOeTacFV2KrsLOs4zaFIepI=
X-Google-Smtp-Source: ADFU+vuYq5CWSFKQGOP/W+a57/GZLJAjsFxOKEk51zmAUl3nxjekLuONwtouc9cJxNbSRQ6y46k+rw==
X-Received: by 2002:a05:620a:895:: with SMTP id
 b21mr7524363qka.318.1584017771671; 
 Thu, 12 Mar 2020 05:56:11 -0700 (PDT)
Received: from pm2-ws13.praxislan02.com ([2001:470:8:67e:ba27:ebff:fee8:ce27])
 by smtp.gmail.com with ESMTPSA id
 u3sm8001236qkc.4.2020.03.12.05.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 05:56:10 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 1/4] usb-serial: Move USB_TOKEN_IN into a helper function
Date: Thu, 12 Mar 2020 08:55:20 -0400
Message-Id: <20200312125524.7812-2-jandryuk@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200312125524.7812-1-jandryuk@gmail.com>
References: <20200312125524.7812-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
are replaced with returns.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
 hw/usb/dev-serial.c | 77 +++++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 34 deletions(-)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index daac75b7ae..71fa786bd8 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -358,13 +358,53 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
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
+    if (len > s->recv_used)
+        len = s->recv_used;
+    if (!len) {
+        p->status = USB_RET_NAK;
+        return;
+    }
+    if (first_len > len)
+        first_len = len;
+    usb_packet_copy(p, header, 2);
+    usb_packet_copy(p, s->recv_buf + s->recv_ptr, first_len);
+    if (len > first_len)
+        usb_packet_copy(p, s->recv_buf, len - first_len);
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
@@ -382,38 +422,7 @@ static void usb_serial_handle_data(USBDevice *dev, USBPacket *p)
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


