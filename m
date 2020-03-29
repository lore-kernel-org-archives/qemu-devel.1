Return-Path: <SRS0=qvFP=5O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE700C43331
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 00:19:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B82AB20732
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 00:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLBC5Usi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82AB20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jILgA-0004Gh-Sc
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 20:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jILev-0002dV-Nr
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 20:18:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pauldzim@gmail.com>) id 1jILeu-0007W0-Lc
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 20:18:37 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34782)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pauldzim@gmail.com>) id 1jILeu-0007Vm-Fu
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 20:18:36 -0400
Received: by mail-pf1-x441.google.com with SMTP id 23so6649154pfj.1
 for <qemu-devel@nongnu.org>; Sat, 28 Mar 2020 17:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PXKXjtVVrrXV5MvzLqoNhi8atJWdX4WMW2e8oHa6A4c=;
 b=TLBC5Usic+nomSwCBKgZtQ4LawEwufKB1S8nlDotSITnd8EIO41ZlwWcYbdA1hX+lQ
 s6COhLH2pCK9WhABm3eiG/uyH065vFlDhJHOQOOwjk5eDcdvXbpzvWy6ANSZ8KFBZgBo
 bU2TwxWgjk7Nsyjjx+kNjYmilUzX0cS+K4UtAPtFajO3s70Wn2QlMoraWiHm6/2qkpKe
 c55mEJN2smEcVowLPpLg4ww+WsodYo0vTp5zTE5mEjPvSQD/wG0e+0YC8PxAYDxNna0D
 DbJgpPu/joZG/ypS8LdXpp2zPa65ytXXcT3HHLgLWx/4yLPiqwV49KUHM4I4kJyadLTe
 jA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PXKXjtVVrrXV5MvzLqoNhi8atJWdX4WMW2e8oHa6A4c=;
 b=oKmRldifth4M7lltgEk8VwOsWBV+Dh5WKt1gCmgQiNMzGxpn/4bjDvC9PUBrL1fwoE
 QTSUXpR5cc1JMDsNRLRonpIqRn5RC6VaHqInGBDrQQd3SVnC2avMoeVxSianMljmewa0
 nXwxxVap6/TQ+nEqnL9MrfJQKCFhzWLpZu7O7TzBWVoYpauXzCJ6AT24xaHj3jyhXvym
 9m0bNMpxUNjhntssuI1l5x4kIhOit+hZxGnIYmPTF2gLrrjIndB8rSUOEAD9bSGWIBFa
 AqkUDVvR/VvBfnEURANKOZ8Y1yOfJ4e5Zvr8AA4vsfvh+CBZmmsPH1J5QAuBMIoMt1df
 LWRA==
X-Gm-Message-State: ANhLgQ3Qo6nSnWJ0b0UJ9awagk8UcHzW3rJwwcRVYaGSFiX/h45MCpPu
 w99wwrc++dGcDWQKFdRTirk=
X-Google-Smtp-Source: ADFU+vsOmYYyuyw2qXw3t1p6BoV+UzvliB9Uu5RJJlxoKohwiYnJLPL6lGZL3vsbRoE0Ije3HTMf2w==
X-Received: by 2002:a63:5f10:: with SMTP id t16mr6354306pgb.20.1585441115575; 
 Sat, 28 Mar 2020 17:18:35 -0700 (PDT)
Received: from paulz-G33T-M.Home ([75.167.220.149])
 by smtp.gmail.com with ESMTPSA id u14sm6626890pgg.67.2020.03.28.17.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2020 17:18:35 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 5/6] Add short-packet handling to usb-storage driver
Date: Sat, 28 Mar 2020 17:17:04 -0700
Message-Id: <20200329001705.15966-6-pauldzim@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200329001705.15966-1-pauldzim@gmail.com>
References: <20200329001705.15966-1-pauldzim@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Paul Zimmerman <pauldzim@gmail.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The dwc-hsotg (dwc2) USB host depends on a short packet to
indicate the end of an IN transfer. The usb-storage driver
currently doesn't provide this, so fix it.

I have tested this change rather extensively using a PC
emulation with xhci, ehci, and uhci controllers, and have
not observed any regressions.

Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
---
 hw/usb/dev-storage.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 5c4b57b06b..ae3c550042 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -229,6 +229,9 @@ static void usb_msd_copy_data(MSDState *s, USBPacket *p)
     usb_packet_copy(p, scsi_req_get_buf(s->req) + s->scsi_off, len);
     s->scsi_len -= len;
     s->scsi_off += len;
+    if (len > s->data_len) {
+        len = s->data_len;
+    }
     s->data_len -= len;
     if (s->scsi_len == 0 || s->data_len == 0) {
         scsi_req_continue(s->req);
@@ -303,6 +306,9 @@ static void usb_msd_command_complete(SCSIRequest *req, uint32_t status, size_t r
             if (s->data_len) {
                 int len = (p->iov.size - p->actual_length);
                 usb_packet_skip(p, len);
+                if (len > s->data_len) {
+                    len = s->data_len;
+                }
                 s->data_len -= len;
             }
             if (s->data_len == 0) {
@@ -469,6 +475,9 @@ static void usb_msd_handle_data(USBDevice *dev, USBPacket *p)
                 int len = p->iov.size - p->actual_length;
                 if (len) {
                     usb_packet_skip(p, len);
+                    if (len > s->data_len) {
+                        len = s->data_len;
+                    }
                     s->data_len -= len;
                     if (s->data_len == 0) {
                         s->mode = USB_MSDM_CSW;
@@ -528,13 +537,17 @@ static void usb_msd_handle_data(USBDevice *dev, USBPacket *p)
                 int len = p->iov.size - p->actual_length;
                 if (len) {
                     usb_packet_skip(p, len);
+                    if (len > s->data_len) {
+                        len = s->data_len;
+                    }
                     s->data_len -= len;
                     if (s->data_len == 0) {
                         s->mode = USB_MSDM_CSW;
                     }
                 }
             }
-            if (p->actual_length < p->iov.size) {
+            if (p->actual_length < p->iov.size && (p->short_not_ok ||
+                    s->scsi_len >= p->ep->max_packet_size)) {
                 DPRINTF("Deferring packet %p [wait data-in]\n", p);
                 s->packet = p;
                 p->status = USB_RET_ASYNC;
-- 
2.17.1


