Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5608BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:38:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22186207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsG66Tjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22186207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorNS-0005Ew-EX
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorDQ-0005iP-PC; Fri, 26 Jun 2020 12:28:36 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:45041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorDP-0003MP-0v; Fri, 26 Jun 2020 12:28:36 -0400
Received: by mail-wr1-x432.google.com with SMTP id b6so10058273wrs.11;
 Fri, 26 Jun 2020 09:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oHFlPrMpcTtOBWP3NYrDS+TwAAQ4/bzOCIhgvn/adfw=;
 b=RsG66TjsIQCKMEb+V8Q4ZvNkqmDMnrtWLg77QSwkYf/89eX9degbWi2evFq52Nz5jw
 yFa9OiTpILgZhb6kQzbSexTv1YagVa77F8swL6jodGIj2YTwcSRbL3EEUoiaX2e1/9v7
 lOWQvNm9HIqs/I1+cu77m9+9Ub+mJHRuWdbyBuNV8RNDxNuxJWsZ/3LQuNYnEP0AP0FH
 06QfVXMh95CsaOHZsPyaxWxhShgKfugRjVvxRkoPnBKhd3pJ5oh0q0RAtUULW98BEHTe
 csjbWvbD0bWxnToTAEq8c8qFWocPuRQixropiWjwIZIASwSDL0Kw5tbjkOVX+5dP8cXd
 cy5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=oHFlPrMpcTtOBWP3NYrDS+TwAAQ4/bzOCIhgvn/adfw=;
 b=Ia3GgvL4IFG7DgBSI0v8Fy3UrhdZpRbElyBGAulpV4QDkNkeyzE7xyvxbP66yq0Rbz
 C5UYjUAjvEIq9gMoaJAuJ7rcmwz9eBYqOeKSMAyUvrXVK0Ggmbhl5iwrF7RqTwSoMban
 ypIQfG42p8drjSe4HIjF6WdkPCsc5Bun5KpWG1NJ6DCJ6XV8m8bKWpvbhDIAj1E8qlgP
 PgHgzMcYf8OOIe3HA+kQbKvbCgo8BnlfFxVP3C6hI5a+3nr7bP7er5SnQNaZ8nat/MMb
 U0rtE98tgIM+1Id1eMljjxY5Q01a+nnz0QiFIWFEYDV+9wxeUIheDY6BFRkZYFptFHDx
 oMgQ==
X-Gm-Message-State: AOAM530osD+ZH1fnAaZpw7zCHF5SnTwvgbunamxO1eg56UXJtbuD9SEX
 hpV8g51X5Q+9VDzYp1lhgaCFc1jR
X-Google-Smtp-Source: ABdhPJzL2lWCzIRVpUZW0t7zSIVhe1fOvQ1SuouYV0gHoYnjJ2qvdtsYsHaKayvA1y1ejbuvn95SBA==
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr4549583wrs.365.1593188913262; 
 Fri, 26 Jun 2020 09:28:33 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 12sm4867255wmg.6.2020.06.26.09.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 09:28:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 11/14] hw/sd/sdcard: Make iolen unsigned
Date: Fri, 26 Jun 2020 18:28:15 +0200
Message-Id: <20200626162818.25840-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200626162818.25840-1-f4bug@amsat.org>
References: <20200626162818.25840-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x432.google.com
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
index a0500f4551..8dd83c365c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1967,7 +1967,7 @@ uint8_t sd_read_data(SDState *sd)
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


