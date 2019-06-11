Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0B9C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 15:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B15208E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 15:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYMOEX4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B15208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59970 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haiLK-0002mo-JN
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 11:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48214)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rfried.dev@gmail.com>) id 1haiFa-0007g5-0r
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 10:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rfried.dev@gmail.com>) id 1haiC9-0001zR-N4
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 10:56:18 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40779)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rfried.dev@gmail.com>)
 id 1haiC9-0001z7-HA; Tue, 11 Jun 2019 10:56:17 -0400
Received: by mail-wr1-x444.google.com with SMTP id p11so13401719wre.7;
 Tue, 11 Jun 2019 07:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b8QxGLK6EVt7cbCYgVtj1jSDrG4K14o9KcZtEODesBA=;
 b=ZYMOEX4zTFZPD17SXfo4vTcVyh779cTHfYlRemdj9zF0aEhXQrf7s6EmncsEiiY9hI
 PV7v3hCLwNP0JZnFc8alVDW2Cd/6stlfUVpIdlbMdk1OCyqaMcZDOqpnEunz5JU2FY7l
 k+rkHMt7MzSI9qan3mIDDLUj6cmu0T8CjtsN84HMTjm9h/iSi8AhAhWEWu7rH/jcaA1e
 3FZ0pZ749M4s9BKySPW93ctUbMa9SbBgwF98/p2ZJw9mXkesOzTpxwwX4uhLlVj500ra
 6P62p9Xsc5wDL0HeTYclYZCeWVClMYFLyfZwJfCtGNbt54mAo8VLFDTZATm6xN5+eSYC
 ncsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b8QxGLK6EVt7cbCYgVtj1jSDrG4K14o9KcZtEODesBA=;
 b=sEMkUTR8eYp+mnOx96bAeHFPcLaq2Ty+n+YNCKlLufMH4ylxDh5VFF4qpsuZPzHiP3
 e8eCsDz/u9ecElYL9bV9HPM7cFjAFEefEQ3aKt7Nok3e2Tut7qY+XNOzeursJVnXj15n
 e8D4hBQ7s+Gp80LywdKN76NKSCe78PQI+5W400UtzCL9yTGz/sqtmF9RddZqlf8ncgYu
 WJHQfc85gElhQjRNVeKFORzBYU+n542HcO/80lMwssuctoqSucH8m1aZccEeLAq/yexR
 KwTxNiwJK/rmE74NtWt4cFXVmRukqsPl7F6CHuCyN/6xa7aSmmCsBQuc2kz7eQHOUTph
 eV5g==
X-Gm-Message-State: APjAAAXbP/BYCOg5vxRPlDstbytGLR/vsv5U9RM9iOkdG/ojdytSXam3
 gejxBKG13xEypdTu9k82H7h68N2tzTg=
X-Google-Smtp-Source: APXvYqxd+yONIAO8l3krTtlBPd4Qy0u1tMLozFUfpu5L1DfNBHrw8uaXTWqeomKbodFeNp8kFJeEEg==
X-Received: by 2002:a5d:6190:: with SMTP id j16mr1300461wru.49.1560264976135; 
 Tue, 11 Jun 2019 07:56:16 -0700 (PDT)
Received: from localhost.localdomain ([141.226.31.91])
 by smtp.gmail.com with ESMTPSA id v3sm1806137wmh.31.2019.06.11.07.56.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 11 Jun 2019 07:56:15 -0700 (PDT)
From: Ramon Fried <rfried.dev@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-trivial@nongnu.org
Date: Tue, 11 Jun 2019 17:55:56 +0300
Message-Id: <20190611145556.12940-1-rfried.dev@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v2] net: cadence_gem: fix compilation error
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

 hw/net/cadence_gem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 7f63411430..e9b1b1e2eb 100644
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
+                         "0x%zdx\n", (unsigned)packet_desc_addr,
                          (unsigned)tx_desc_get_length(desc),
                          sizeof(tx_packet) - (p - tx_packet));
                 break;
-- 
2.21.0


