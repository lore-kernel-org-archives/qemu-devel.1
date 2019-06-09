Return-Path: <SRS0=Ju6v=UI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6436C28EBD
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2019 13:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FCAD208E4
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2019 13:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qaimbRc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FCAD208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35808 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZxjn-0004rB-ML
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 09:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43660)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rfried.dev@gmail.com>) id 1hZukp-0002Ep-J4
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 06:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rfried.dev@gmail.com>) id 1hZuko-00021W-Iu
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 06:08:47 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43256)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rfried.dev@gmail.com>)
 id 1hZuko-0001zV-8f; Sun, 09 Jun 2019 06:08:46 -0400
Received: by mail-wr1-x441.google.com with SMTP id r18so6218344wrm.10;
 Sun, 09 Jun 2019 03:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kaWWm0ENYxNgcYgQBzQeXcaAs8MtTpRpm/vY6XfUhz4=;
 b=qaimbRc96cSGFiPbM8dpCk8yeYaLpBBNbLXjz5ZWLeUcy10hajOPZcLYt8uLu/l6Ds
 cCgEH8JIsg5z1MrIjPyd0oVCxPMcbalC2C0md+tGYnwio1Oxw8XvKtRj7psIO/5DHk54
 czc2oDWwhuTOI/O16DxwPWRZMgSbId9VPKPHqa/lQRoUJHuOC4AVY8fdv2Zj1Cjk3igY
 GKC0JPEeW/nT/2L2dG7GZ7kv8d8BpZBWfup53TDO76c6aQIapZmQnmX24JkvMdqIe6Po
 vMbYID9Xv4B7YLCMLvP2oyoIXaRZO4Jmy7FCsexWOyHDDfOzXpFufJQucghet9TV1viF
 h0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kaWWm0ENYxNgcYgQBzQeXcaAs8MtTpRpm/vY6XfUhz4=;
 b=oGVyHyCOxHLdGikHvUx+Ru3MbAhRYGkRrCGHr9RWTbatVe5Dfbn5LzLbGDJVZB0nDh
 Vj+tPnWeC2Iw4SAyvVjkFQ/jfCURJS1Xa7v/bLP0KqROk18nb/YW349fu2jq1K6fTsa+
 whjZdSsttGZx9o6Hu8SmjxQJolupp44bOjc6eicbkfSuo0++k6A9v1IZb+D/JHqbRgXb
 gmeUrkqq8aXTP+es9aldLDJeAH6jj3XtgtjtYOueuPPoqW55ARgqAwSybwsBQrav8CC9
 rlsDOG+5A3BedL6rU0R/nySZzUT3C1mE9qWI+YAVIxKEpZR/TzokQ3rgbX96Ngq8EvwF
 XQEA==
X-Gm-Message-State: APjAAAWSS3HtT06FXt2CfQWyv1zPWICpsm6SObfxC25b0uBWh4SSp7J9
 27owrnopB4FYijWqy3FU3Fay/p7Wo+k=
X-Google-Smtp-Source: APXvYqyowD5mpDzcMmtM27X20fFjf6txXt/FICG3Nkj1+yCdOZP1i6slxBg32mmjDxUJ7n+PPJHNMA==
X-Received: by 2002:adf:f50c:: with SMTP id q12mr13423140wro.300.1560074924479; 
 Sun, 09 Jun 2019 03:08:44 -0700 (PDT)
Received: from localhost.localdomain ([141.226.31.91])
 by smtp.gmail.com with ESMTPSA id u12sm6667304wrt.13.2019.06.09.03.08.42
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 09 Jun 2019 03:08:43 -0700 (PDT)
From: Ramon Fried <rfried.dev@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun,  9 Jun 2019 13:08:37 +0300
Message-Id: <20190609100837.17586-1-rfried.dev@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
X-Mailman-Approved-At: Sun, 09 Jun 2019 09:19:11 -0400
Subject: [Qemu-devel] [PATCH] net: cadence_gem: fix compilation error when
 debug is on
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:Xilinx Zynq" <qemu-arm@nongnu.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

defining CADENCE_GEM_ERR_DEBUG causes compilation
errors, fix that.

Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
---
 hw/net/cadence_gem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 7f63411430..5cc5a71524 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -982,8 +982,8 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
             return -1;
         }
 
-        DB_PRINT("copy %d bytes to 0x%x\n", MIN(bytes_to_copy, rxbufsize),
-                rx_desc_get_buffer(s->rx_desc[q]));
+        DB_PRINT("copy %d bytes to 0x%lx\n", MIN(bytes_to_copy, rxbufsize),
+                rx_desc_get_buffer(s, s->rx_desc[q]));
 
         /* Copy packet data to emulated DMA buffer */
         address_space_write(&s->dma_as, rx_desc_get_buffer(s, s->rx_desc[q]) +
@@ -1156,7 +1156,7 @@ static void gem_transmit(CadenceGEMState *s)
             if (tx_desc_get_length(desc) > sizeof(tx_packet) -
                                                (p - tx_packet)) {
                 DB_PRINT("TX descriptor @ 0x%x too large: size 0x%x space " \
-                         "0x%x\n", (unsigned)packet_desc_addr,
+                         "0x%lx\n", (unsigned)packet_desc_addr,
                          (unsigned)tx_desc_get_length(desc),
                          sizeof(tx_packet) - (p - tx_packet));
                 break;
-- 
2.21.0


