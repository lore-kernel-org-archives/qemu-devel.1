Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98DEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:50:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8476C206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O38u1ySL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8476C206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorYE-00012I-Mh
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorPE-0000Ni-U5; Fri, 26 Jun 2020 12:40:49 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorPD-0006C7-8r; Fri, 26 Jun 2020 12:40:48 -0400
Received: by mail-wm1-x344.google.com with SMTP id o2so9976156wmh.2;
 Fri, 26 Jun 2020 09:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CxSm3RJicBxIxL9H3OtOu6SC+lfHczHb+nqiITfjkFo=;
 b=O38u1ySLdnGFNGDYs80fx+cer0q+9pMWx0E8C8eLrCXJxJ44JVNkA5tBoHZ/AFkFIX
 ts+gtYlFbFnMDVoEWNKV/mPqLElbqq3OxrzBhJ1RVZ5OgGuFjhc9NQOACdJEhMm8E5q6
 zZKzOeYTCz3XdsLgl0iPI3CWotVAoNUxgmYkXA/XyFpjKo28AW2aAYlQQrWWj+w5barm
 8MNZP+EV0SK741j9t/3dN4zK2r0rxf6BkJwkfyVsAcrka5KaJH99DzYSEvlJxhTJ0EPy
 4u7mT9LSM46Gz0dar/Cpj3or43n6TbVHfY8FEDPhbTWIF4J/jWbb7bAhe5WcN2Fa6lWL
 KHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=CxSm3RJicBxIxL9H3OtOu6SC+lfHczHb+nqiITfjkFo=;
 b=UJT2/Ck8ZtLPBCgUuPr95opY26yDpFUW5grCnL7MailoSIb7qPy/wOQ/PQqejeRzCN
 NtxtWm6zYu0KJl3+eMAlfxVU6ScvM+ohkQdJpoi5tZcjBxv7KxB+9EkkOA7fLrPvMBK6
 W1HAYb5d0MFemT6z3ShmwxYxJJKrJgQc32OtU+ZhR1uRoB1urR5TEDGNfNsAjGq9QeMN
 zyP6zDJrN//5JlGZQe86D2KeYGeHQJVNBhURwPamkoC1UctB1OgB0P1ToRIZgvd3AZYr
 1ufYk2jo6nB98BDJf+ZaN6aRmbYfz7AsFrnvP/sV91B0KC07hvBvGiKCaR854B8K7Hbq
 G6tQ==
X-Gm-Message-State: AOAM5334AWwCvkoRyLC+A+79ZcgFe6+b143jknXleya4Il7+cN9qLC5y
 xjS5Ky5IR+pOfszO5BCgHJUfV/Vy
X-Google-Smtp-Source: ABdhPJyheW8g+c3jvsg/8xPrYOqNdcTNTejNQp9/dLB7JYLPRJ4zYgkU70fNexb1gl7gIpNA8+1M4A==
X-Received: by 2002:a1c:9cd0:: with SMTP id f199mr4200564wme.94.1593189645288; 
 Fri, 26 Jun 2020 09:40:45 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id f12sm24623646wrw.53.2020.06.26.09.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 09:40:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 14/15] hw/sd/sdcard: Display offset in read/write_data()
 trace events
Date: Fri, 26 Jun 2020 18:40:25 +0200
Message-Id: <20200626164026.766-15-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200626164026.766-1-f4bug@amsat.org>
References: <20200626164026.766-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
index e05af50cdb..f0b5527eaf 100644
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


