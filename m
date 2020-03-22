Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E5FC1975A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 22:33:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA4F92070A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 22:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5ssOkFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4F92070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG99l-00034j-U8
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 18:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jG95U-0005in-JS
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 18:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pauldzim@gmail.com>) id 1jG95T-0001nR-7u
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 18:28:56 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37226)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pauldzim@gmail.com>) id 1jG95T-0001nA-0d
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 18:28:55 -0400
Received: by mail-pg1-x544.google.com with SMTP id a32so6162724pga.4
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 15:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Npg8JalYe1HijpKYZStrn0sHUDbUYw/7P2A9MctKrDA=;
 b=U5ssOkFFnkoSWM/82qA2AmrPLUIQ8PVkBd+mmSoZMlHZsvYk0f34M+JycQ5GAtRyPZ
 hwoTSs93oA9z0lAmUlzvFSwH4Ezr/IOAFO/AhwOxvuv1UrK2v6qk3nq7iyo6yPaZTd1v
 ZRJOueariRXdNGL0E/7yhs4jDUQKQ6mfGnHhXJTnQ/sV+eY4Su5otPhXNBrewCKfupgi
 oNgIMROOIFbxZU61fUvPKooKVW4Dzdb3sVWHmi1P7SXDkKGSrRge/tVSV12P7THN2nc9
 lyBMLyzocazykwDFPyG2nIVK4434QhmcxAj0py1jdyeel38u4UAV2oSi0HsWkd0scJ/D
 PdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Npg8JalYe1HijpKYZStrn0sHUDbUYw/7P2A9MctKrDA=;
 b=JQr0G7/6/8YjDmfeL0uj0owSEkRGF5fz24AgsLLLDTAC6ooCoejK4b4t1OdU7JcAG4
 inAPmefpIGxC3sPgC/uc/DFgh8DetNs6YHjzkhClV3eblWKUtkRC1eRjdoeYcFM52LVY
 eqJdAdGnJbRsDs6cIqhNL09Q+o94iQmmkE9VMeUFKotJ2BLE0cTEYmUF3M8DpXjKHUT8
 s/xbumrUA887qOlav4fW2nBKcHJA6T3s2+Q1Z/VqfdnEzt0H8JjBoi+XGUGTC4xpx4zR
 nk3q5FLhdOyFRssaekfzclggF+sj92UqyBTK5+7XGP8nmun6yaj0eQf4TBydKoMz4H32
 UVgg==
X-Gm-Message-State: ANhLgQ301712cex/7Lqrg4TBVgH0BVIMknM9wbcMGrytfyvuB1Ck6Uzl
 KiS0Ei+NBnuAIRzhBC8oq7U3j+DTYCvqcQ==
X-Google-Smtp-Source: ADFU+vvgvDFARlqHgIEJRtOEm2ppUcx/TCDNI07CaHV2myUuwu3QX/k4KT+YYxMxJbk5U8wUOAuP0w==
X-Received: by 2002:a65:641a:: with SMTP id a26mr12525738pgv.247.1584916133953; 
 Sun, 22 Mar 2020 15:28:53 -0700 (PDT)
Received: from localhost.localdomain ([75.167.220.149])
 by smtp.gmail.com with ESMTPSA id e10sm11440315pfm.121.2020.03.22.15.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2020 15:28:53 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: kraxel@redhat.com
Subject: [PATCH 5/6] Add short-packet handling to usb-storage driver
Date: Sun, 22 Mar 2020 15:27:25 -0700
Message-Id: <20200322222726.10244-6-pauldzim@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200322222726.10244-1-pauldzim@gmail.com>
References: <20200322222726.10244-1-pauldzim@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: peter.maydell@linaro.org, stefanha@gmail.com, qemu-devel@nongnu.org,
 Paul Zimmerman <pauldzim@gmail.com>, jsnow@redhat.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The dwc-hsotg (dwc2) USB host depends on a short packet to
indicate the end of an IN transfer. The usb-storage driver
currently doesn't provide this, so fix it.

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


