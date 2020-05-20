Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE2AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 23:58:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6965820708
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 23:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAGMbc/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6965820708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbYbi-0000oJ-JF
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 19:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jbYYO-0003BI-AO
 for qemu-devel@nongnu.org; Wed, 20 May 2020 19:55:16 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42771)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jbYYM-0000A3-VP
 for qemu-devel@nongnu.org; Wed, 20 May 2020 19:55:15 -0400
Received: by mail-pg1-x542.google.com with SMTP id n11so2215879pgl.9
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 16:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PXKXjtVVrrXV5MvzLqoNhi8atJWdX4WMW2e8oHa6A4c=;
 b=MAGMbc/XtZ48hRoodLt70KoOA86uDmGxYi2R9l5FFpaKOfQxHHUQHXeTtkEL2oPd8D
 YN/n5WOJNm7QRCogZDfr/Hmg09kcEI466D+MUyxvkc706xOYV2/iC+C5URDdv6JV8O+M
 oVnDxJZPUmqP6K+x48C+h1SQjhWDDvYz1P8TSxMwZZswIZaejUiD0Tp3QiOWlfMX+Skf
 pd2cR0CPOY2Waxyzj22T5c/zLB/qLKz6HIuj0PUpky06XQSgay6iSWKRTTpH4i7ulMb8
 vpTOMND8su73d56IQZm7SyXb+qLh9cPrErw73ARn9I7dZPobSaH3oThRHPTx0VO4iy0n
 lXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PXKXjtVVrrXV5MvzLqoNhi8atJWdX4WMW2e8oHa6A4c=;
 b=Wl1H1F29I/jDakluYv0tOfiatQfhi4X0j91PSydZcq9Tfy72yf5JQul6MTGaO81m4u
 mb3eqMcdCFoiKp0Y+vt8FYBw/u5rfswn+5aVpy10vUZl2rD/ZnkMnkwmbUeKgeE6qe1B
 kpXT4M8uOM7Vd4G9acLjQS+BpIfgM6ci7ZbonxcEJBou32meTD4NEM+h61e1+hn7vy0/
 l5IRV5Ynt32YD8+QF9/r+aLZnLM/CGBdKKrNWBYxPxSnN/f3ee01K+1ldXeulIUsW6mB
 AUYMT/yAzyIVw0Cl6JvaC0v2J49UP0N0hzBlx+SUijEFqPidwtts4YtjrUc7HOK4WWHR
 d/KQ==
X-Gm-Message-State: AOAM531og6Lp538ZOJ8nW70D4OP0KMFs4T8bfVKCAnssrBawdqaZ7+nP
 2zbBKPCENfEVZ9AFerGbouE=
X-Google-Smtp-Source: ABdhPJyU1EiKQefM9cIKwzJGgZlRVeczDrM7Vu/sCchkCXUFukcil564PQbhPbstkDyV3r9hcz4ezg==
X-Received: by 2002:a62:1b53:: with SMTP id b80mr6840701pfb.145.1590018913434; 
 Wed, 20 May 2020 16:55:13 -0700 (PDT)
Received: from localhost.localdomain ([75.167.104.59])
 by smtp.gmail.com with ESMTPSA id d20sm2761882pjs.12.2020.05.20.16.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 16:55:13 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v6 5/7] usb: add short-packet handling to usb-storage driver
Date: Wed, 20 May 2020 16:53:47 -0700
Message-Id: <20200520235349.21215-6-pauldzim@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520235349.21215-1-pauldzim@gmail.com>
References: <20200520235349.21215-1-pauldzim@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=pauldzim@gmail.com; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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


