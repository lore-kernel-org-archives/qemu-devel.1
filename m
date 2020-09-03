Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F141AC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:50:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEC6320639
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6xOby3t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC6320639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDx7M-0005Yz-R3
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwMM-0005RQ-4e; Thu, 03 Sep 2020 17:01:30 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45218)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwMK-0007wA-D1; Thu, 03 Sep 2020 17:01:29 -0400
Received: by mail-oi1-x244.google.com with SMTP id d189so4481960oig.12;
 Thu, 03 Sep 2020 14:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=yJG4bmyAfe4onsh//+ldhVr9OuPhOmvC3Rda7LK2uCg=;
 b=k6xOby3thIRRJDddVQLvw+z8lV4QE2aD9x/EsyTbu+ghwGLGlJVyrhLxRrPiaNbKZ1
 Dcso8v6iTgu2aFSxPr8nzYftgA0ZCbCF97uNLI3p29opJKHsH3X7fgtpdyc4Lx7ULNMv
 ruZ4ildZnd6XUZcoFQJUN7ZnSIClBaze5P3ncBdYMXqmefVLYvwwtL4mI9ziVFlNH3cu
 Vzl7GDbX4nTznbgXl7A5SJCFLOulHkM8/v2BPoSbS2LtxE8+fcuxXaescTYcjg4FjFM3
 +ZHx/mJc052FVLg0KWkPmc44rZ4HxNxpXzKHeyHJO5NPEFbKkgUL4/3Mb/QQFCiXKt7n
 nXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=yJG4bmyAfe4onsh//+ldhVr9OuPhOmvC3Rda7LK2uCg=;
 b=F474/gaPJ3kSU9GI0GZQt5KZ9+wrqM9FJTotEq/+rYiDnMB1bKBQ1h6bUQ/b0ONffY
 42KjkVxgPc3IiluOvxwYK6AHTRj8ZCYIeygTEt9MsvUJZjBxfK5l+yYqFkE2VO0xJO3X
 oqSGuKRTi2+mk53MbmiACuQ9x9aqt2ocjTY7sa0cv2J78ld/C2+4R1rcyaCHtK/qklw8
 XfFpEj4sUSd6drDa3m1TvwUUeUsQOvPFt0oBzYK/92LKXqRUUwrdz+0zozl6S2inCKIH
 lMrnatOOkmsuiTx3n+dU+43VVWVLPctpBlZaU4AvcYu3s/4YDVpPg3Zdm5vj4+9rR2KD
 T2Lg==
X-Gm-Message-State: AOAM53077Kpi5oA2lZIm/HJ8taO++5mllnbTPiivQkDxhU3K2EXmCOuo
 t9WQakRH8poF8dpZOOkr5gzW16KW6UMPKQ==
X-Google-Smtp-Source: ABdhPJwI5FZOom6VdQLObxT/oi/6gDRd470470UysICywiKz7qDdueAXK9CfupJDhmn6+N4znDpRQA==
X-Received: by 2002:aca:b705:: with SMTP id h5mr3203765oif.31.1599166886612;
 Thu, 03 Sep 2020 14:01:26 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id d28sm121339ooa.7.2020.09.03.14.01.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:01:26 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 77/77] usb: fix setup_len init (CVE-2020-14364)
Date: Thu,  3 Sep 2020 15:59:35 -0500
Message-Id: <20200903205935.27832-78-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Store calculated setup_len in a local variable, verify it, and only
write it to the struct (USBDevice->setup_len) in case it passed the
sanity checks.

This prevents other code (do_token_{in,out} functions specifically)
from working with invalid USBDevice->setup_len values and overrunning
the USBDevice->setup_buf[] buffer.

Fixes: CVE-2020-14364
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Gonglei <arei.gonglei@huawei.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Message-id: 20200825053636.29648-1-kraxel@redhat.com
(cherry picked from commit b946434f2659a182afc17e155be6791ebfb302eb)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/usb/core.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/usb/core.c b/hw/usb/core.c
index 5abd128b6b..5234dcc73f 100644
--- a/hw/usb/core.c
+++ b/hw/usb/core.c
@@ -129,6 +129,7 @@ void usb_wakeup(USBEndpoint *ep, unsigned int stream)
 static void do_token_setup(USBDevice *s, USBPacket *p)
 {
     int request, value, index;
+    unsigned int setup_len;
 
     if (p->iov.size != 8) {
         p->status = USB_RET_STALL;
@@ -138,14 +139,15 @@ static void do_token_setup(USBDevice *s, USBPacket *p)
     usb_packet_copy(p, s->setup_buf, p->iov.size);
     s->setup_index = 0;
     p->actual_length = 0;
-    s->setup_len   = (s->setup_buf[7] << 8) | s->setup_buf[6];
-    if (s->setup_len > sizeof(s->data_buf)) {
+    setup_len = (s->setup_buf[7] << 8) | s->setup_buf[6];
+    if (setup_len > sizeof(s->data_buf)) {
         fprintf(stderr,
                 "usb_generic_handle_packet: ctrl buffer too small (%d > %zu)\n",
-                s->setup_len, sizeof(s->data_buf));
+                setup_len, sizeof(s->data_buf));
         p->status = USB_RET_STALL;
         return;
     }
+    s->setup_len = setup_len;
 
     request = (s->setup_buf[0] << 8) | s->setup_buf[1];
     value   = (s->setup_buf[3] << 8) | s->setup_buf[2];
@@ -259,26 +261,28 @@ static void do_token_out(USBDevice *s, USBPacket *p)
 static void do_parameter(USBDevice *s, USBPacket *p)
 {
     int i, request, value, index;
+    unsigned int setup_len;
 
     for (i = 0; i < 8; i++) {
         s->setup_buf[i] = p->parameter >> (i*8);
     }
 
     s->setup_state = SETUP_STATE_PARAM;
-    s->setup_len   = (s->setup_buf[7] << 8) | s->setup_buf[6];
     s->setup_index = 0;
 
     request = (s->setup_buf[0] << 8) | s->setup_buf[1];
     value   = (s->setup_buf[3] << 8) | s->setup_buf[2];
     index   = (s->setup_buf[5] << 8) | s->setup_buf[4];
 
-    if (s->setup_len > sizeof(s->data_buf)) {
+    setup_len = (s->setup_buf[7] << 8) | s->setup_buf[6];
+    if (setup_len > sizeof(s->data_buf)) {
         fprintf(stderr,
                 "usb_generic_handle_packet: ctrl buffer too small (%d > %zu)\n",
-                s->setup_len, sizeof(s->data_buf));
+                setup_len, sizeof(s->data_buf));
         p->status = USB_RET_STALL;
         return;
     }
+    s->setup_len = setup_len;
 
     if (p->pid == USB_TOKEN_OUT) {
         usb_packet_copy(p, s->data_buf, s->setup_len);
-- 
2.17.1


