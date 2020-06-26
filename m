Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC459C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:38:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7150D207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXxHiMsx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7150D207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorN5-0004LN-D7
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorDS-0005m6-UN; Fri, 26 Jun 2020 12:28:38 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorDR-0003Mm-BI; Fri, 26 Jun 2020 12:28:38 -0400
Received: by mail-wr1-x442.google.com with SMTP id j4so7627574wrp.10;
 Fri, 26 Jun 2020 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VIIvOy6xGDcv8qAbLrm/t2ngeo9iKJmDK5qOtaGJrrc=;
 b=XXxHiMsxsZGwFtGngMUd2Ed2otjmy/3JGSIvBaS6xaKOt+8tnstXbCRlrcIiC6o0cP
 occfP2XzcmBzNWyLX2sTXHwLwyt4I+VklK5Qo5vC9sFDLr4lU50EpyhOUFyBgc6DPQKz
 KDJu2HzIcZo++i+fmsUQMuSbxWwSdDEJPpsYVmnkwXDFatnAA67kl6Moq7rWwxTHE6ji
 VSrdZ61Ob3arnBibk9QLvhSIwmsWpsOa8Uii+Bbk+0eL+Hg59aT0EtpZ9sOaESFYV+oA
 XaTK9rI/7b9NlASrj9QoMqs1M/6NXCkEr9V/pA7wmTIFQRRR+PH4In34MDzzlGzG5A6F
 YTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=VIIvOy6xGDcv8qAbLrm/t2ngeo9iKJmDK5qOtaGJrrc=;
 b=WWrVCUfz9W/x0/dg9fMZb5cfXkiYt/r1wNmLi5BHKmj3kFSLR9gYvPSQk12Qz6Zy/C
 +RhC16aaMIVgQq0CO5WHc5KJO9HDhEoUtdr2fTKIn5sLWnLe50Ht7iTUbemQS7SOFHsW
 1qoIVVoUE44KSyQ0LA73onwBjZ1tYWxKBhRi3nk3IvDdyTVzc0yXMxF0dnXWCPGihNl+
 r9igkoVVWtQYiyZyyWmDbzc6Mftc/7VL8D061ZGyzN5eWrdQL7iUFEeLi+a63oNqAKfL
 5FE7yf1Xc9Uqp9iiF2JqX+nGYSHGiWhqAmgU03dWKzw5BtEPAFM3rM9pNBHF9e3VptXk
 iTgA==
X-Gm-Message-State: AOAM532HOcUl17icPlMI4BuN0A7VvOgnmCMu30bH3px9A6rtFAQd7pP9
 P9HwCraDNKVgXxz04986ecsV3RP2
X-Google-Smtp-Source: ABdhPJzmE2rNgHQDzCXusMKCqM6qIZB+15ipTBPlkOtJet7/QdzMLf5jhysAqFJad00nfssFQUCIpQ==
X-Received: by 2002:adf:e2c9:: with SMTP id d9mr4541191wrj.227.1593188915584; 
 Fri, 26 Jun 2020 09:28:35 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 12sm4867255wmg.6.2020.06.26.09.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 09:28:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 13/14] hw/sd/sdcard: Display offset in read/write_data()
 trace events
Date: Fri, 26 Jun 2020 18:28:17 +0200
Message-Id: <20200626162818.25840-14-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200626162818.25840-1-f4bug@amsat.org>
References: <20200626162818.25840-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Having 'base address' and 'relative offset' displayed
separately is more helpful than the absolute address.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c         | 8 ++++----
 hw/sd/trace-events | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 798a2346a7..8fdee4ed56 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1841,8 +1841,8 @@ void sd_write_data(SDState *sd, uint8_t value)
         return;
 
     trace_sdcard_write_data(sd->proto_name,
-                            sd_current_cmd_name(sd),
-                            sd->current_cmd, value);
+                            sd_current_cmd_name(sd), sd->current_cmd,
+                            sd->data_start, sd->data_offset, value);
     switch (sd->current_cmd) {
     case 24:	/* CMD24:  WRITE_SINGLE_BLOCK */
         sd->data[sd->data_offset ++] = value;
@@ -1995,8 +1995,8 @@ uint8_t sd_read_data(SDState *sd)
     io_len = (sd->ocr & (1 << 30)) ? HWBLOCK_SIZE : sd->blk_len;
 
     trace_sdcard_read_data(sd->proto_name,
-                           sd_current_cmd_name(sd),
-                           sd->current_cmd, io_len);
+                           sd_current_cmd_name(sd), sd->current_cmd,
+                           sd->data_start, sd->data_offset, io_len);
     switch (sd->current_cmd) {
     case 6:	/* CMD6:   SWITCH_FUNCTION */
         ret = sd->data[sd->data_offset ++];
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index d0cd7c6ec4..946923223b 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -51,8 +51,8 @@ sdcard_lock(void) ""
 sdcard_unlock(void) ""
 sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
-sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint8_t value) "%s %20s/ CMD%02d value 0x%02x"
-sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t length) "%s %20s/ CMD%02d len %" PRIu32
+sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint64_t address, uint32_t offset, uint8_t value) "%s %20s/ CMD%02d addr 0x%" PRIx64 " ofs 0x%" PRIx32 " val 0x%02x"
+sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint64_t address, uint32_t offset, uint32_t length) "%s %20s/ CMD%02d addr 0x%" PRIx64 " ofs 0x%" PRIx32 " len %" PRIu32
 sdcard_set_voltage(uint16_t millivolts) "%u mV"
 
 # milkymist-memcard.c
-- 
2.21.3


