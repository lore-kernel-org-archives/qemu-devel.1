Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBF0C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 11:42:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C46E720771
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 11:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7yuzF/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46E720771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpVhf-0007HT-39
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 07:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erik.lucas.smit@gmail.com>)
 id 1jpVgm-0006iz-Ua; Sun, 28 Jun 2020 07:41:37 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:41854)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <erik.lucas.smit@gmail.com>)
 id 1jpVgl-00005E-9N; Sun, 28 Jun 2020 07:41:36 -0400
Received: by mail-ed1-x543.google.com with SMTP id e22so10359955edq.8;
 Sun, 28 Jun 2020 04:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qQ7KhWLM70SKr/8xeZkY9OAmuoyEXa2XjMmlR4yRXUc=;
 b=d7yuzF/3ZZHbqZTtfmHIW6Ja+pCwlXNVY8BFIfMkKc8D4p/k3lSYVxlmmVd97/IuVj
 kNwl0tuFHiq3U2DVxk9YKTm9spp2mdgtIvrHtt5b/tNxpUCRPXDePQzJQFPZmzrQ8ErY
 V1+ocZG43hEN9Mo1bmK+JgYNX0FAoMGvhYklVTZl2iu56n6PUR4edUeUkpM2J6wtW6O5
 ZpBwuC2pNqtbvbTsROIfP5g9js72E/A4fEk4YKHfJdh2xlkvTkW/wixN3Y1q8WqVOrxX
 opAogYPJqPm7PVIaEho5eUg2sywWdRespU6AQxLwAxSE7vIPpJ0XhBJoJpYfA0rp5J0b
 fAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qQ7KhWLM70SKr/8xeZkY9OAmuoyEXa2XjMmlR4yRXUc=;
 b=tKhgwJUSuidhWYxi2uk/Xji+xunG8FuW+up0kPskUDNhk7UVQjvi5LKACGkqVLaJ6P
 +MBlmZrr8f7IU6yOvrJZiQKiJ90P0Spi8cPLw8i/xsPWjr8N/umlrlB2TT0FRVzWfdzi
 KFWOjRk9DNZVyotFwxvYvQDy1D33Ovsm2PVF5u8s6Dbpl8LCJSOeIt/1MZ8vL0e2ailL
 bUrRQJ5HHCR17N/Lgb9MMzL/NF02eM2zDVohp/FttT9rNO7M8h8kYLemrwlDip4YZa5r
 QHxH+eab5XDuOBM+BjOhGaKN+msb/ia3BoKZTE8IyI+EY6ryZ2Pt0Eo+VwEL74tbMcLi
 zj7g==
X-Gm-Message-State: AOAM533AXTHQ6QVuunan2TxKrr9Pi240H96Q0KW4XOh6UyKOGswD4qk+
 ZtJJuTFqbqqT0t/6mtD+Gdg=
X-Google-Smtp-Source: ABdhPJyk8WYFNCB13on+ByOH/9vQiE3ICVcyXKkCYVhRnKX6Ew9FrtjH1FZ1wDmeVVrd1Mj8EUw6VA==
X-Received: by 2002:a05:6402:22a5:: with SMTP id
 cx5mr12972971edb.246.1593344492859; 
 Sun, 28 Jun 2020 04:41:32 -0700 (PDT)
Received: from Tank.localdomain (82-73-161-131.cable.dynamic.v4.ziggo.nl.
 [82.73.161.131])
 by smtp.gmail.com with ESMTPSA id s1sm19253904edy.1.2020.06.28.04.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2020 04:41:32 -0700 (PDT)
From: erik-smit <erik.lucas.smit@gmail.com>
To: erik.lucas.smit@gmail.com
Subject: [PATCH] ftgmac100: fix dblac write test
Date: Sun, 28 Jun 2020 13:40:58 +0200
Message-Id: <20200628114057.6666-1-erik.lucas.smit@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=erik.lucas.smit@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Jason Wang <jasowang@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The test of the write of the dblac register was testing the old value
instead of the new value. This would accept the write of an invalid value
but subsequently refuse any following valid writes.

Signed-off-by: erik-smit <erik.lucas.smit@gmail.com>
---
 hw/net/ftgmac100.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 043ba61b86..9db0d27ea6 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -810,16 +810,16 @@ static void ftgmac100_write(void *opaque, hwaddr addr,
         s->phydata = value & 0xffff;
         break;
     case FTGMAC100_DBLAC: /* DMA Burst Length and Arbitration Control */
-        if (FTGMAC100_DBLAC_TXDES_SIZE(s->dblac) < sizeof(FTGMAC100Desc)) {
+        if (FTGMAC100_DBLAC_TXDES_SIZE(value) < sizeof(FTGMAC100Desc)) {
             qemu_log_mask(LOG_GUEST_ERROR,
-                          "%s: transmit descriptor too small : %d bytes\n",
-                          __func__, FTGMAC100_DBLAC_TXDES_SIZE(s->dblac));
+                          "%s: transmit descriptor too small : %ld bytes\n",
+                          __func__, FTGMAC100_DBLAC_TXDES_SIZE(value));
             break;
         }
-        if (FTGMAC100_DBLAC_RXDES_SIZE(s->dblac) < sizeof(FTGMAC100Desc)) {
+        if (FTGMAC100_DBLAC_RXDES_SIZE(value) < sizeof(FTGMAC100Desc)) {
             qemu_log_mask(LOG_GUEST_ERROR,
-                          "%s: receive descriptor too small : %d bytes\n",
-                          __func__, FTGMAC100_DBLAC_RXDES_SIZE(s->dblac));
+                          "%s: receive descriptor too small : %ld bytes\n",
+                          __func__, FTGMAC100_DBLAC_RXDES_SIZE(value));
             break;
         }
         s->dblac = value;
-- 
2.25.1


