Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BC1C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 15:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA35216F4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 15:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqZt/0sF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA35216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iahtq-0000vM-AP
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 10:09:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bilalwasim676@gmail.com>) id 1iahpj-0007eG-Bp
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 10:05:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bilalwasim676@gmail.com>) id 1iahpd-00021n-84
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 10:05:20 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34959)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bilalwasim676@gmail.com>)
 id 1iahpd-0001w6-0W; Fri, 29 Nov 2019 10:05:17 -0500
Received: by mail-wm1-x342.google.com with SMTP id n5so15446956wmc.0;
 Fri, 29 Nov 2019 07:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IP/SLTFWhk4WDxJ1ziCkF6+oL9+QPiFnZPV17DQ8R5U=;
 b=UqZt/0sF6K3hSurWZjirrNXqcWwXrukOFmuTPzKfJwKDBaAA+AaplJ5xTOBoWj/vaZ
 oHPCv7uR6jFVcxIUQlF6BcvGAe9durEObp3zng0zJV4wfK7RGG2UIg1pFw8MSIOJC9dK
 o2aS74idukEd2Pl/49GOUPpbqrIfeZ0Hg9Xr4YatEdMkOvDev4gT8/syCtX3pEViJOmG
 acceuJQUjZA6/G8j81sa48b6XQFY8rR0Xy5lDKBoSw+VWPpCPPRVyVP/LfHwRh4JXmGV
 5s1tlBT6PUgp4yXdyahk6YopshUJKI1bjj49NUyS0Gf+K0RCVHVMpOXa/ffoX/jPZjHN
 3irQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IP/SLTFWhk4WDxJ1ziCkF6+oL9+QPiFnZPV17DQ8R5U=;
 b=RfLKxpMblNRVQDJu5IAEbRzm8sdADUvPELav0sU0nV6m/XM6si0+So3xPIPQFKMPY1
 sOlsh3Pz9/BIoKnB0R26Sy+CPXnE1qt7sQjDnjE2x6dIJow8XUIT0LA7cFWLU0Cbdjda
 VjFu1Rbc38zh4W9ZB38rcs9PZHmtZbSocFmBUFbFa4VhBLvYUZ77ECowY7Ff4M3lJAIB
 omD49HJsteOTAPcPGq0fm2bsRxznWYDIBqHhTC7Z5yh2dfmTLkNDawpYOVSK2RXqg+Vk
 TLcamdhlU566Da21eODe/nQlYz+HSTeERlBUbekMtNgdzsIV6qgvb+7GbR/glmAO6bYq
 dMFg==
X-Gm-Message-State: APjAAAX9GP+E87ysqagqS9UP3qk/B5GtV3MUU/paXAWZpN2FS/eibmIr
 AM4xTVQR076+cStTDgAcaedENnB4u34=
X-Google-Smtp-Source: APXvYqw7wSlSfmEgnoLUm9hxVaNc9nWlGA4F2c2ZKys3SWjL/QWyCOubTlmEEYyrnM+jUbGvMhlk0g==
X-Received: by 2002:a7b:c5d0:: with SMTP id n16mr15744553wmk.78.1575039914542; 
 Fri, 29 Nov 2019 07:05:14 -0800 (PST)
Received: from PKL-BWASIM-LT.mgc.mentorg.com ([110.93.212.98])
 by smtp.gmail.com with ESMTPSA id c1sm26928066wrs.24.2019.11.29.07.05.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 29 Nov 2019 07:05:13 -0800 (PST)
From: bilalwasim676@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH] net/imx_fec: Updating the IMX_FEC IP to support loopback mode.
Date: Fri, 29 Nov 2019 20:05:08 +0500
Message-Id: <20191129150508.24404-1-bilalwasim676@gmail.com>
X-Mailer: git-send-email 2.19.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: peter.maydell@linaro.org, aa1ronham@gmail.com, jcd@tribudubois.net,
 qemu-arm@nongnu.org, bilal_wasim@mentor.com, linux@roeck-us.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: bwasim <bilal_wasim@mentor.com>

Loopback mode only works when specific conditions (as dictated
by the IP guide) are met, i.e. the MII_MODE is set and the
RMII_MODE is cleared. If not, we simply send the packet on the
output queue (for TX to the host network). Tested by running a
custom RTOS and TXing a ton of packets. The same packets were
received on the RX side..

Signed-off-by: Bilal Wasim <bilal_wasim@mentor.com>
---
 hw/net/imx_fec.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index bd99236864..c51e7f7363 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -256,6 +256,29 @@ static const VMStateDescription vmstate_imx_eth = {
 
 static void imx_eth_update(IMXFECState *s);
 
+/*
+ * Function to check if the MAC is configured to run in loopback mode.
+ * If so, invoke the "receive" routine.
+ * Else write to the output.
+ * */
+static void send_pkt(IMXFECState *s, uint8_t *frame, int frame_size)
+{
+    NetClientState *nc = qemu_get_queue(s->nic);
+
+    /*
+     * Loopback or Normal mode ?
+     * Per the FEC Manual: If loopback is enabled, the MII_MODE
+     * should be SET and the RMII_MODE should be cleared. Loopback
+     * will only work if this criterion is met. If not met,
+     * we will send the frame on the output queue. */
+    if ((s->regs[ENET_RCR] & ENET_RCR_LOOP) && (s->regs[ENET_RCR] & ENET_RCR_MII_MODE)
+            && !(s->regs[ENET_RCR] & ENET_RCR_RMII_MODE)) {
+        nc->info->receive(nc, frame, frame_size);
+    } else {
+        qemu_send_packet(nc, frame, frame_size);
+    }
+}
+
 /*
  * The MII phy could raise a GPIO to the processor which in turn
  * could be handled as an interrpt by the OS.
@@ -488,7 +511,7 @@ static void imx_fec_do_tx(IMXFECState *s)
         frame_size += len;
         if (bd.flags & ENET_BD_L) {
             /* Last buffer in frame.  */
-            qemu_send_packet(qemu_get_queue(s->nic), s->frame, frame_size);
+            send_pkt(s, (uint8_t *)&s->frame, frame_size);
             ptr = s->frame;
             frame_size = 0;
             s->regs[ENET_EIR] |= ENET_INT_TXF;
@@ -586,7 +609,7 @@ static void imx_enet_do_tx(IMXFECState *s, uint32_t index)
             }
             /* Last buffer in frame.  */
 
-            qemu_send_packet(qemu_get_queue(s->nic), s->frame, frame_size);
+            send_pkt(s, (uint8_t *)&s->frame, frame_size);
             ptr = s->frame;
 
             frame_size = 0;
-- 
2.19.1.windows.1


