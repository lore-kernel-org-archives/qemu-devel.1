Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F26FC54FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 01:54:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29AD42078C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 01:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1ufUuY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29AD42078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQi7Q-0007oR-An
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 21:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jQi1S-0006rZ-Kl
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 21:48:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jQi1S-0005VJ-5a
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 21:48:26 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33141)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jQi1R-0005U8-QL
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 21:48:25 -0400
Received: by mail-pg1-x541.google.com with SMTP id d17so6037843pgo.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 18:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PXKXjtVVrrXV5MvzLqoNhi8atJWdX4WMW2e8oHa6A4c=;
 b=I1ufUuY0NM0+i95ebcliC4UvksZSVIbfSiqAlGGA3OK12a9czxxNC3flwNI7qUbWhQ
 oCEPED+crdEsD4tNWfTpJVDCnlJ8rK6MpGIDDsmb2f8g2JSIEiVl7XrTQBcAljBAljs/
 oFXts8JLR7PhS8ba3kAEM7Qds/NAbcE5FTJ3IBcIC7f7M1Mcnl3/WYHpEByO6e+S7v+X
 A56PJO7HO5UjymYKWeAGOTomurEntECAdT2zZ69AtPWsGLhwckJOkg6Sthvlq/QsugzO
 h1ciozn8HVNYG5gBAvlC2BdlahNwQqavazX5vxpZqiZoehiIcZJbiElhDwsjJM3DQ7I7
 nsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PXKXjtVVrrXV5MvzLqoNhi8atJWdX4WMW2e8oHa6A4c=;
 b=qSqBXCVqCUWEl5MmmKaDzs32vO9lswv83DjZExWvMg7iH7aWFGYxjz2CspZ0oFr4KY
 XiQxRONbWQ9yJvEXEiA+4o+tNBKIL5VYJ0IXYeIC38gVvy2mMvkM9/iU2S5mH6Tpvfyz
 H6ZFFYSf0ixyHOB/hSIUjId8RbgNofa1N0uwJeQFugTAAnAbh32GAx7J+ck5ThD6JVH4
 mGUEE0fHXW06a0m1GUCaV+uldIDh5eJkHc4RPabk1xgaHqcsNXaVomnYvCU1VwR1Q9qf
 1PSIy/8WAKCeVoV8ZBXfzVP+N8bya+fUwOxC0I7GXTGcyx0hYTrqTkNDrTym+U7Kjelo
 VTpg==
X-Gm-Message-State: AGi0Puaxz66rKRHmZSLwZlNJ3X5rs40uFgZY4g8x1CDrba0hQ1a76Wuw
 ZK3qfPjj8WFcixo7ran/MhM=
X-Google-Smtp-Source: APiQypLOC3f2O2axV9o+1oStq1at+WwnH4KL0n9JtHukJ62Kem2U7ypHhbbJk2s7j5F5Zcgs05IxWw==
X-Received: by 2002:a62:e414:: with SMTP id r20mr19110066pfh.96.1587433704581; 
 Mon, 20 Apr 2020 18:48:24 -0700 (PDT)
Received: from localhost.localdomain ([75.167.104.59])
 by smtp.gmail.com with ESMTPSA id q11sm654868pgs.25.2020.04.20.18.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 18:48:24 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 5/7] usb: add short-packet handling to usb-storage driver
Date: Mon, 20 Apr 2020 18:45:49 -0700
Message-Id: <20200421014551.10426-6-pauldzim@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200421014551.10426-1-pauldzim@gmail.com>
References: <20200421014551.10426-1-pauldzim@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=pauldzim@gmail.com; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::541
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
 Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
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


