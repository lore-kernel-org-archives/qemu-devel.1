Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA47C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 04:46:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7EF0217D7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 04:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUON9jRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7EF0217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvaJN-0002dN-Ud
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 00:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52048)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvaIs-0001iz-03
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 00:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvaIq-00057c-VL
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 00:45:29 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hvaIq-00057B-O0; Thu, 08 Aug 2019 00:45:28 -0400
Received: by mail-pl1-x641.google.com with SMTP id m9so42825644pls.8;
 Wed, 07 Aug 2019 21:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=E6yxnr+XaLfykr9binetZruI0I2aHRyZR2ZqXqM16+Q=;
 b=hUON9jRVNF7N/A24B0IPUEFT28l8jnaBbCe5NxkH6Ul/h8+XxuLBlhXnjki8xVcquw
 zxrQ0yp0ywDQCwjutT7YOgpQSiOTbe/VFujGo5OdnbQMq1H3srkdDc8yRtRlk5IggUWm
 0AmESPv3m7T+duoVP2Rd1OF6dDV1Jp+387GHVgLqNTRWtSmNVAyuRDAUtbUpv+jiV9M5
 hgS3PIpvAj+jVSZdI850JvEGGWGSyd+VKATwjDKqQqdFXcQUq8DXNSJikHaN4841nC5K
 lSViqGmiahEDc6DQaZvewY1lquNwZ8pxQsbzkuMU3hlPlbdjrRwPWRJKH79Nmp9VpdtX
 GKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=E6yxnr+XaLfykr9binetZruI0I2aHRyZR2ZqXqM16+Q=;
 b=lbp8o+Gn5yGT6M+Oi4GBRkTfmWDtSdfZAaWI8svK1X9QBmgidAu2gPZFpBOpTtT1j8
 pmW1jPjB5TF7r6JPj21mCWW7obX7fcw2G5f6NSVCJJh/vIsmuraKbdG6btQAeQs8WSoN
 4S7MgP9N+EwqnyXjkVedsvEfbKp1I90yzzK4pURkgFCYn3zEBtv1VcXkRnzK8Tpa01aU
 W2FTO3hXIwXSLOZwiIsarH7fthpb4ocICHPHFIjfRA/wWSwYB5u7Q02SlXb2FXzQFPLY
 K0DerqHafc4ELZKEuo5eA/aAfJeOZTBfdRGm2zU+3VHqsK7bXsdG/ikz6wzsZal7kPzq
 JUkA==
X-Gm-Message-State: APjAAAUwB3Qyd/zZgGcAlyzOXQyt26mDvGpZn744VmoMrgl/J9Kugrjq
 aPJF1X7KOJ2gUczH2etgfdE=
X-Google-Smtp-Source: APXvYqw4z9WWpJ45iE0nPmX+JnmRsVo9AeOAKqblWrZWfPh+jxTnQc8XRWzz2T+12bm2cya6y5P8Hw==
X-Received: by 2002:a17:902:b949:: with SMTP id
 h9mr10738694pls.120.1565239527351; 
 Wed, 07 Aug 2019 21:45:27 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id h26sm98458499pfq.64.2019.08.07.21.45.26
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Wed, 07 Aug 2019 21:45:26 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Date: Wed,  7 Aug 2019 21:44:39 -0700
Message-Id: <1565239479-2130-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565020374-23888-1-git-send-email-bmeng.cn@gmail.com>
References: <1565020374-23888-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v2] hw: net: cadence_gem: Fix build errors in
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

Changes in v2:
- use HWADDR_PRIx instead of TARGET_FMT_plx for consistency
- use 'z' modifier to print sizeof(..)

 hw/net/cadence_gem.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index d412085..b6ff2c1 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -983,8 +983,9 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
             return -1;
         }
 
-        DB_PRINT("copy %d bytes to 0x%x\n", MIN(bytes_to_copy, rxbufsize),
-                rx_desc_get_buffer(s->rx_desc[q]));
+        DB_PRINT("copy %d bytes to 0x%" HWADDR_PRIx "\n",
+                 MIN(bytes_to_copy, rxbufsize),
+                 rx_desc_get_buffer(s, s->rx_desc[q]));
 
         /* Copy packet data to emulated DMA buffer */
         address_space_write(&s->dma_as, rx_desc_get_buffer(s, s->rx_desc[q]) +
@@ -1157,7 +1158,7 @@ static void gem_transmit(CadenceGEMState *s)
             if (tx_desc_get_length(desc) > sizeof(tx_packet) -
                                                (p - tx_packet)) {
                 DB_PRINT("TX descriptor @ 0x%x too large: size 0x%x space " \
-                         "0x%x\n", (unsigned)packet_desc_addr,
+                         "0x%zx\n", (unsigned)packet_desc_addr,
                          (unsigned)tx_desc_get_length(desc),
                          sizeof(tx_packet) - (p - tx_packet));
                 break;
-- 
2.7.4


