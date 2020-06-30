Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9794C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:52:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79539206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0iPdTLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79539206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqGga-0006l5-Nu
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGU0-0001L0-V1; Tue, 30 Jun 2020 09:39:33 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b]:40666)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGTz-0006LD-I0; Tue, 30 Jun 2020 09:39:32 -0400
Received: by mail-ed1-x52b.google.com with SMTP id b15so16234309edy.7;
 Tue, 30 Jun 2020 06:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8lBaOHF/GcJdlX2f+JY4g5jrg7UGtZKo4oX0j/i7PeY=;
 b=b0iPdTLafCOIL2wYrpU8x/TiYe8AO2FfoQ0xZsbIN7arJ+enWM0QSBBYES+MGeDYMn
 4jFiYrXWMH7XblPyxgw5xd+etUZOWpX70rPPLo6eyvigubgsrogySa5AWIfgPZlwYjYf
 VJJ+e7/gaLkHLAW+U4x4IsMTOfnKM4fJyRPMEgX+FrNWtUhiUUQG20gpW4QEmiGAXwJ/
 UxLRkkav34edDP8ysM5HUV8MbM8k6zl4pmcXRYQUZ59QNQ/vbK2MkWsRpUlg1sFo16IG
 3m9E8Y0Z/9F3nL9/3j+1rbeOX7rDOXAxbF5BpSD4bPREDpYHBTLoemR8wh3vkWGPbAuA
 Osug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8lBaOHF/GcJdlX2f+JY4g5jrg7UGtZKo4oX0j/i7PeY=;
 b=PPRSq6lytkRzb2SBtJxshhBn0D0xm3dROOTUetA1Sq4jQPhouZQfejQ5/S1lca77VV
 PnapJcfyGYLl8NI5kjWHpXpi2fZYDS6qO3gUN+c6Vwql6QPIlXbeHiW2CMN8wR8xSffT
 8PqffXeOEbyWdoRZUFo79beNws25E3AIxLsMxS3fWPJ9nJASE6bt74lf2D7X2OE9+GSI
 imh9Fxj9p2epQjRHwzhJ+RCATPH3CldQdBAorGz+8MUa0w3M/nP6VloO+LUJB328yiIq
 8w3WfI/wJtuMT/KPq/I5TDa/MmVsdxxC3EaEy9ViFZbf3lUIkscQWsdWdC4eNx26OIEq
 TNkA==
X-Gm-Message-State: AOAM532dQ6rREwRCCaBuSzirZolrq9HBcAY866rIVtr6GRVnQLNh8F8j
 i7GxfXSvSwQCG8Pa4rk3b45M9sXI/w0=
X-Google-Smtp-Source: ABdhPJwCxYkNof7NMTt+GqTjBdGAwrEJ2kqlkkf2HuxMgPVhtIUfPtoiItGXWTS/lZZHy5E7skaJmA==
X-Received: by 2002:a05:6402:b79:: with SMTP id
 cb25mr3624013edb.154.1593524369661; 
 Tue, 30 Jun 2020 06:39:29 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p18sm2099172ejm.55.2020.06.30.06.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 06:39:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 14/17] hw/sd/sdcard: Make iolen unsigned
Date: Tue, 30 Jun 2020 15:39:08 +0200
Message-Id: <20200630133912.9428-15-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630133912.9428-1-f4bug@amsat.org>
References: <20200630133912.9428-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x52b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

I/O request length can not be negative.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v4: Use uint32_t (pm215)
---
 hw/sd/sd.c         | 2 +-
 hw/sd/trace-events | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 364a6d1fcd..3e9faa8add 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1981,7 +1981,7 @@ uint8_t sd_read_data(SDState *sd)
 {
     /* TODO: Append CRCs */
     uint8_t ret;
-    int io_len;
+    uint32_t io_len;
 
     if (!sd->blk || !blk_is_inserted(sd->blk) || !sd->enable)
         return 0x00;
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 5f09d32eb2..d0cd7c6ec4 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -52,7 +52,7 @@ sdcard_unlock(void) ""
 sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint8_t value) "%s %20s/ CMD%02d value 0x%02x"
-sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, int length) "%s %20s/ CMD%02d len %d"
+sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t length) "%s %20s/ CMD%02d len %" PRIu32
 sdcard_set_voltage(uint16_t millivolts) "%u mV"
 
 # milkymist-memcard.c
-- 
2.21.3


