Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83438C31E47
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 05:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2302168B
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 05:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sA1A9QAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2302168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58760 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hc192-0000Yc-GN
	for qemu-devel@archiver.kernel.org; Sat, 15 Jun 2019 01:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50409)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rfried.dev@gmail.com>) id 1hc15z-0006IY-Si
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 01:19:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rfried.dev@gmail.com>) id 1hc12t-0004BL-CJ
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 01:16:08 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42605)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rfried.dev@gmail.com>)
 id 1hc12t-0004AY-6P; Sat, 15 Jun 2019 01:16:07 -0400
Received: by mail-wr1-x441.google.com with SMTP id x17so4502503wrl.9;
 Fri, 14 Jun 2019 22:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0bUB7uKNls6xaJY3zOblGfvogGIyYkXLiWGhdwSVXCg=;
 b=sA1A9QAW1AD0lERRtksYeJAEdb3pu8Sgo/6beN6tKJJozlUcmrc5Ku0ahjk1aKs8Yo
 jDOLov12XVIfTyXbeL/hCNctHyNqfYZRivaGYnl/ylNVe8Sq9yYI+NCJ2ESed3LwYDjk
 bO5+ka8gdt+kEiN8ZUhUxkC/sa5J+R0Bbr3OthzuwRbogVfFwAGB6/24jBX27Dd9NzM3
 O093rdDJLvlp4mpYzNo4CDqv9IQtsGwvRhHFs4jScbZiRWUmCiPXHv9Rf+FW1Qw2y3ON
 JMccGU4AhbpRw/farBoy2Ob7y3J25iNJBf3QRxuUU8dDlfsx4Tm8C+syrwJySFWdBrph
 62kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0bUB7uKNls6xaJY3zOblGfvogGIyYkXLiWGhdwSVXCg=;
 b=MymUix7mR+BngAB+DrhG7nJUbRxteN4xPKThUwjyPWLi4VHQFN3WddFY/1CSbTWvz8
 jJTg7KEsFB7p45VSbpRfdnVk8lAQk+TX6l48ujCgI3zD2PbuJcQO9MeBmI6L9Vr8ewLE
 0jQaNoDE5RlfRonAuHNreNHkijBvK3CkcWxGfVGT/vAT6WdLbn7aJPDXnwbQxnpZlLKr
 +VW7KHpR22TskTwJma4BxQRvB11EefLnj+0AKE/ZyaQjShMCKzEaeRScd3nusgZafO9r
 E71dfpe4WnLrT3XUWcaf682pB0cS+N8CyzH3C5Sb2qiWzPFvcZhG5LWwW7P5TGG6j/sS
 Rsjw==
X-Gm-Message-State: APjAAAXTYNpeLBm2+Ad/9dJUHWn0wOuOsa0qwaHp1mWLyOqiy8Ph7ZSJ
 04YQH3/rBTAYFciMMg2XrlWRKdI9JW4=
X-Google-Smtp-Source: APXvYqw/kJieG8taR4u1wpXXIpUJo4ty3r5TpFoxFAP2Z8LgISWfNmtUGWiPgrDmx5ADKxZ0V4iF8A==
X-Received: by 2002:a5d:63c9:: with SMTP id c9mr20483738wrw.81.1560575765885; 
 Fri, 14 Jun 2019 22:16:05 -0700 (PDT)
Received: from localhost.localdomain ([141.226.31.91])
 by smtp.gmail.com with ESMTPSA id y16sm3553540wru.28.2019.06.14.22.16.04
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 22:16:05 -0700 (PDT)
From: Ramon Fried <rfried.dev@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-trivial@nongnu.org
Date: Sat, 15 Jun 2019 08:15:59 +0300
Message-Id: <20190615051559.13767-1-rfried.dev@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v3] net: cadence_gem: fix compilation error
 when debug is on
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
v2: change %lx to HWADDR_PRIx and %lx to %zdx
v3: change %zdx to %zx

 hw/net/cadence_gem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 7f63411430..ecee22525c 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -982,8 +982,8 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
             return -1;
         }
 
-        DB_PRINT("copy %d bytes to 0x%x\n", MIN(bytes_to_copy, rxbufsize),
-                rx_desc_get_buffer(s->rx_desc[q]));
+        DB_PRINT("copy %d bytes to 0x%" HWADDR_PRIx "\n", MIN(bytes_to_copy, rxbufsize),
+                rx_desc_get_buffer(s, s->rx_desc[q]));
 
         /* Copy packet data to emulated DMA buffer */
         address_space_write(&s->dma_as, rx_desc_get_buffer(s, s->rx_desc[q]) +
@@ -1156,7 +1156,7 @@ static void gem_transmit(CadenceGEMState *s)
             if (tx_desc_get_length(desc) > sizeof(tx_packet) -
                                                (p - tx_packet)) {
                 DB_PRINT("TX descriptor @ 0x%x too large: size 0x%x space " \
-                         "0x%x\n", (unsigned)packet_desc_addr,
+                         "0x%zx\n", (unsigned)packet_desc_addr,
                          (unsigned)tx_desc_get_length(desc),
                          sizeof(tx_packet) - (p - tx_packet));
                 break;
-- 
2.21.0


