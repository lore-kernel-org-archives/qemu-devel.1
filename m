Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC76CC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A76D72075B
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uIffK0z2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76D72075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hufIg-0003B8-1D
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 11:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56703)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufIG-0002gw-Q5
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufIF-0007B5-Rw
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:53:04 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33841)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hufID-00079C-J1; Mon, 05 Aug 2019 11:53:01 -0400
Received: by mail-pf1-x444.google.com with SMTP id b13so39862427pfo.1;
 Mon, 05 Aug 2019 08:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id;
 bh=4SPPJgNtAYWlUS/b4VSRjowngisQkXo6hrKl8n1KWO4=;
 b=uIffK0z2uDgH2P8uHHWrRt5I4VI+rjfRYoDXUFMhC42dC5R6LWwsPldemY26wUrLeJ
 uO11zxkVf3WFGm1yOHNdfecF9m9Izsst0BA9VQ+vtiBIX0kuKxAc2mfThZop21Is07Ut
 Wo6hjvdYbKAh36jbGVyr546yYyoUBIsve+TUsC1vLLTAq6vWJqfXgEwIPhiVUCZ0DN3/
 QMP9oLxQx9yqrovdhV6wcIz4tK25jspiKnWBTG8UcLS8HufJmx+owX5tPczIxwaFG/3e
 2SXvVn91qTfiVuD1IPCz7d3neE3/klRuniiYj19QPVgR0Cd7Y79leROKBOYaGtaP6n+/
 Z+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=4SPPJgNtAYWlUS/b4VSRjowngisQkXo6hrKl8n1KWO4=;
 b=NrZLmTx/AUS2UpYtPtjvjFCzWh+YqiVLRB8NX6zWgqiKQ2nZSyPcU+tRX5LdL5eQ5T
 TGTN6NSQOyVUmq5xJ8Dk4/J2lEcCcKXaMhIZyVHID/Ola/fIpTWPiKp74med4EnQ27UF
 Zy0WOUnSypzCQ0t4k6Aw//iYrh0V/vn8dopxlXx4QP6gqEHJCs3GglQ4ZkvPk4kfyXAK
 VloWkwJ4vw5roOYxjEDGZsF1G3VjwKBmc8LNkNqodD9wsyYW9lNXVRkU5MYb+6Pfkk5J
 tlYFUC2nIHXhEc8BxMo77Bs/7jXzysMZ4z+pwzjCmjZbiANnHSVBGIupds//u9l2JNYG
 dzjQ==
X-Gm-Message-State: APjAAAUY/BTuuwhJ8m+rBA3FUbzIPRI8714rUB4MEKFkQwyO3MBNDCEN
 BQxQtTOTsZg+/o6BJfx6L2Q=
X-Google-Smtp-Source: APXvYqxDZwqZMiLSe6+9yXKe29Tc1BXJUbWKGYkF8xiHIJi/R2wrv5JCjNQaP+uyhH14bKalJgAdBA==
X-Received: by 2002:aa7:9254:: with SMTP id 20mr76151944pfp.212.1565020379724; 
 Mon, 05 Aug 2019 08:52:59 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id y11sm86499328pfb.119.2019.08.05.08.52.58
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 05 Aug 2019 08:52:59 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Date: Mon,  5 Aug 2019 08:52:54 -0700
Message-Id: <1565020374-23888-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH] hw: net: cadence_gem: Fix build errors in
 DB_PRINT()
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When CADENCE_GEM_ERR_DEBUG is turned on, there are several
compilation errors in DB_PRINT(). Fix them.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 hw/net/cadence_gem.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index d412085..7516e8f 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -983,8 +983,9 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
             return -1;
         }
 
-        DB_PRINT("copy %d bytes to 0x%x\n", MIN(bytes_to_copy, rxbufsize),
-                rx_desc_get_buffer(s->rx_desc[q]));
+        DB_PRINT("copy %d bytes to " TARGET_FMT_plx "\n",
+                 MIN(bytes_to_copy, rxbufsize),
+                 rx_desc_get_buffer(s, s->rx_desc[q]));
 
         /* Copy packet data to emulated DMA buffer */
         address_space_write(&s->dma_as, rx_desc_get_buffer(s, s->rx_desc[q]) +
@@ -1157,7 +1158,7 @@ static void gem_transmit(CadenceGEMState *s)
             if (tx_desc_get_length(desc) > sizeof(tx_packet) -
                                                (p - tx_packet)) {
                 DB_PRINT("TX descriptor @ 0x%x too large: size 0x%x space " \
-                         "0x%x\n", (unsigned)packet_desc_addr,
+                         "0x%lx\n", (unsigned)packet_desc_addr,
                          (unsigned)tx_desc_get_length(desc),
                          sizeof(tx_packet) - (p - tx_packet));
                 break;
-- 
2.7.4


