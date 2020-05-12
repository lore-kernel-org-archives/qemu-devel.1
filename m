Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BE0C54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 06:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3D1620752
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 06:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8jshY3E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D1620752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYOnB-0002Vb-35
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 02:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jYOkQ-0006H8-7q
 for qemu-devel@nongnu.org; Tue, 12 May 2020 02:50:38 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:53521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jYOkP-0003Tq-4q
 for qemu-devel@nongnu.org; Tue, 12 May 2020 02:50:37 -0400
Received: by mail-pj1-x1042.google.com with SMTP id hi11so9041072pjb.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 23:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PXKXjtVVrrXV5MvzLqoNhi8atJWdX4WMW2e8oHa6A4c=;
 b=H8jshY3E5l09GqKyMgJcRLXyP8fb51o92xmKJcaq8+Eb/HApHP9VJ1AM8N2DHCoawD
 Knen/Xgyo+VMLMDuTFOMyweHGe+YfTVCgFjQuMYdcO595E7Ev8uYYTpgquA5O/RHAyv2
 hEy2gmwumxv90dPtkE1dlLK6/oG7TDSQC5gPI7YbTdqom1PEr4lmc35zlaUFL3UDL7cO
 zTJcdS91zmYD5Ys7amqhkH+cJfLTZf43yyxfwqOXjPFbg6UssworpqK7j31trAlD/lEo
 /Sdg9/8fpk2B4YzE8JfFTRHXW0S9XIUsEStQpyJCAL/54mQNpw9jSbvtiFhioed/KhVK
 6UnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PXKXjtVVrrXV5MvzLqoNhi8atJWdX4WMW2e8oHa6A4c=;
 b=S643lahPup7/0lwxXsb/Rpd+Gh5B6DH/teeEhn4iLYYcRQe6H5+EcKCWJmNV82fO0Z
 FeoV8SeW1vOCC4km+jakUIiXbn0ZCnyGKgogJEbiQXkc4ZJiXMOLFyfCNRVjKLUK72zy
 u4fZcJJNg2gwDlOjGFAM+PfIaN3/PamkrhG/BBr6997RKNpSZk+ahlYJztrzIO5KbNYx
 +WJfvR+uV4/Uk/VqSQklUWJS9ri8sa0svptjYyIQYJOTby/X20f3BuF1O4qOoMuD/CiW
 Ow/nDx1GecPRVGpWj160dVpahs276jo8MBwY3Yz/NOkWwS2wYHFHB6E3Hww7bC+TaEKA
 ASwQ==
X-Gm-Message-State: AOAM531Cp3wYm2F8y43zsB1r925rYF4TlKrjYp2RPGwtuU5Sf28i90Sb
 BSOIMW6nkNAJROB59LTrZ3pOEDp6qlWXRQ==
X-Google-Smtp-Source: ABdhPJyWAqZ6BN/bpo28Y6Z2ishHFFnKPEfh0pc7AWkAsdm+7tW5a3Fo9YV77GQ+ca4rVcZPPhdyxw==
X-Received: by 2002:a17:90a:22d0:: with SMTP id
 s74mr3416741pjc.28.1589266235654; 
 Mon, 11 May 2020 23:50:35 -0700 (PDT)
Received: from localhost.localdomain ([75.167.104.59])
 by smtp.gmail.com with ESMTPSA id j7sm11837286pjy.9.2020.05.11.23.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 23:50:35 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v5 5/7] usb: add short-packet handling to usb-storage driver
Date: Mon, 11 May 2020 23:48:58 -0700
Message-Id: <20200512064900.28554-6-pauldzim@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512064900.28554-1-pauldzim@gmail.com>
References: <20200512064900.28554-1-pauldzim@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=pauldzim@gmail.com; helo=mail-pj1-x1042.google.com
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


