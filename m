Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E877C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F9E24641
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B51UdXVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F9E24641
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0ZM-0004oB-OB
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX0I0-0008Lr-9X; Mon, 26 Oct 2020 07:03:48 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:50224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX0Hx-0002hg-7T; Mon, 26 Oct 2020 07:03:47 -0400
Received: by mail-wm1-x331.google.com with SMTP id 13so11163579wmf.0;
 Mon, 26 Oct 2020 04:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CaEc+EndnthM/jQRSTritjVWMWjtPivpLOdnvFGKtOc=;
 b=B51UdXVNUMxIJXfJbtOeTXONrMoctRM+wW11QjE6H/PSYVoSRYayynce9vro6AfVkW
 8GKbBCnOo1VvecTZaTVZq5fx962sOXz9AeSJvUPkKPiDpS6WQrKnR3CvGQjz+i1VjJ5x
 FyiHUtyctPri1rqi2p/OHAkFRFrBS6yqSBQRRiT5CcYnvGbvdkEqYcNLEbbPLwTsvC45
 V1RdzZX7OxyPZG/Di85O8ZPk1EDt6fzwBObdQfj3s2Zhs8VWRqHai4EsOKIJFK+gt4pR
 JVsUcVGYGGBLKVdsKo7UbSL9vUJbzA5A4NYpR9qn/qHLDWRQnZVuwVjJRen/YeWHoGed
 I/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=CaEc+EndnthM/jQRSTritjVWMWjtPivpLOdnvFGKtOc=;
 b=P+J842Q6eN7fkj8KNtstbPWvXd8b7cX2Im/x108jwLqzBVTOj6ClSvcu662XI8rMPO
 eyf5Wj6WBS+7cFEz9kVtpc5wo9m8u9O9P7c8rVTWDuomkLcMBuKEhlpW/bkpjucCLOdA
 vQaC3QYtJcexKdvqvFmlvfavRaU194jbClaY5L8PnQAFopomOZzhaGITM0xTAUOU8N9S
 shJkvqq7TETNcsmhNE1IbNHU9ug6krqdbZkaRq+fJWo40JVGhB3ZSg7sUIOXOkE1QvKK
 2gR+MgtD0YWl43iexTXUZecPl61Eknugy3NToFjyURLLQFo5Bk2cAaflJsNv0gJtFzDw
 DAJA==
X-Gm-Message-State: AOAM530Xn2vbI1Xn2AbYLy7YqEmW+TvRZT2PzTdkORbt8aUw8vOJuvCk
 HBf7HpVXBHw5cwCV3QLh/M110G9gtf0=
X-Google-Smtp-Source: ABdhPJyF1JOQLXzJb3x+ZLCPuqMyMqIwI8BIc/uwm2/AcK/dwJkNka42hifUNxBvR6TNrLS6P3KkBg==
X-Received: by 2002:a1c:2302:: with SMTP id j2mr15469805wmj.100.1603710217030; 
 Mon, 26 Oct 2020 04:03:37 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id h4sm21987467wrv.11.2020.10.26.04.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 04:03:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/5] hw/sd/sdcard: Make iolen unsigned
Date: Mon, 26 Oct 2020 12:03:14 +0100
Message-Id: <20201026110315.4026183-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026110315.4026183-1-f4bug@amsat.org>
References: <20201026110315.4026183-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I/O request length can not be negative.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20200630133912.9428-15-f4bug@amsat.org>
---
 hw/sd/sd.c         | 2 +-
 hw/sd/trace-events | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index aa6059d2ad6..fcbc1fd9d6e 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1982,7 +1982,7 @@ uint8_t sd_read_byte(SDState *sd)
 {
     /* TODO: Append CRCs */
     uint8_t ret;
-    int io_len;
+    uint32_t io_len;
 
     if (!sd->blk || !blk_is_inserted(sd->blk) || !sd->enable)
         return 0x00;
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 96c7ea5e52f..4140e485403 100644
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
2.26.2


