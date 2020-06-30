Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50B3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:43:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EBCB20675
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJZHVbPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBCB20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqGY9-0008Gg-K2
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGTw-0001Gg-JU; Tue, 30 Jun 2020 09:39:28 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:33969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGTv-0006K8-2U; Tue, 30 Jun 2020 09:39:28 -0400
Received: by mail-ed1-x541.google.com with SMTP id a8so15033840edy.1;
 Tue, 30 Jun 2020 06:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6i321mcNSRw2m36TDk2KcjbjHnC/Dq7f3je0r+sPTKo=;
 b=WJZHVbPFMOUj0/HCodmNBPiOdNv0CqHRJBu18vHOef4cN6GdCxnWxbLRan+D8v9tRz
 QYxoCn79dslUca3ulY+yAPelyVpQsY+cGc8ve8GDTuSbzCsT3KzApqNaVlpfhk4uZTZR
 klRQdCgItjLcJU2vu+pywgrlt3YuXk6SavHh3Xj2kh5iyamhqDd8P86+ievV9Zugu2on
 +Ytxl3Fh4ps/d2fl0UWZHPtYxe51Y02CnjRTPW2CyhRvPB2iMF7zOH9w+PiKEHjP+PbK
 ydTLGgXjMvpQIAVeJIUuNlLcwAWo55IklL7zBDiyiqL7PLTAjbQOHCX2wVBgAUr2/e9B
 WnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=6i321mcNSRw2m36TDk2KcjbjHnC/Dq7f3je0r+sPTKo=;
 b=p3R8mxud1+SDKj4ajzpwwkArPCS04XvgJQDdYOMPtr8qKM0UaSQLBS6kbDsPq4KwRl
 MroRkXrPRXlG8cgm+8A2mGNym6tehBmRfQxvkzxRgoZsYktPLPIJRPDtFKtabfeiRAo9
 fG++1rhDTEZWGUaMaFUSEpCdsy2byCP7dJop9A9hPnwBzbbwULpAKkt7cmAvrOu5zRDW
 rGXbHZuCm25Dd4Nr9DaEKQmJTWVS/diPwyVpTlsm2zwp+Th5F/qGDlQedYVd9NKwH0TW
 Yea333Uodvx20IWwq5ML7s5UAS1ZCLUrlA2PMZDJnPv5qd54A1wCc/M/jsVqgn8qfX7r
 sgGA==
X-Gm-Message-State: AOAM532dmY9+jWmHhNwaWP8VzOq2DbN/T9pjHqNTTfrVsxkp79HIU9Do
 I6IyXEzMzJGHrjSR6JRJQzsJ/u/+xAo=
X-Google-Smtp-Source: ABdhPJxGfVf7TQt/b2lQW+csA7wxj4HnHYZaaDrG0EMT03/PzMTsk0nDj8z/v6CCe0XLtoinGEa9eA==
X-Received: by 2002:a50:e791:: with SMTP id b17mr24240501edn.366.1593524365176; 
 Tue, 30 Jun 2020 06:39:25 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p18sm2099172ejm.55.2020.06.30.06.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 06:39:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 10/17] hw/sd/sdcard: Check address is in range
Date: Tue, 30 Jun 2020 15:39:04 +0200
Message-Id: <20200630133912.9428-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630133912.9428-1-f4bug@amsat.org>
References: <20200630133912.9428-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x541.google.com
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

As a defense, assert if the requested address is out of the card area.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 548745614e..5d1b314a32 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -537,8 +537,10 @@ static void sd_response_r7_make(SDState *sd, uint8_t *response)
     stl_be_p(response, sd->vhs);
 }
 
-static inline uint64_t sd_addr_to_wpnum(uint64_t addr)
+static uint64_t sd_addr_to_wpnum(SDState *sd, uint64_t addr)
 {
+    assert(addr < sd->size);
+
     return addr >> (HWBLOCK_SHIFT + SECTOR_SHIFT + WPGROUP_SHIFT);
 }
 
@@ -773,8 +775,8 @@ static void sd_erase(SDState *sd)
         erase_end *= HWBLOCK_SIZE;
     }
 
-    erase_start = sd_addr_to_wpnum(erase_start);
-    erase_end = sd_addr_to_wpnum(erase_end);
+    erase_start = sd_addr_to_wpnum(sd, erase_start);
+    erase_end = sd_addr_to_wpnum(sd, erase_end);
     sd->erase_start = 0;
     sd->erase_end = 0;
     sd->csd[14] |= 0x40;
@@ -791,7 +793,7 @@ static uint32_t sd_wpbits(SDState *sd, uint64_t addr)
     uint32_t i, wpnum;
     uint32_t ret = 0;
 
-    wpnum = sd_addr_to_wpnum(addr);
+    wpnum = sd_addr_to_wpnum(sd, addr);
 
     for (i = 0; i < 32; i++, wpnum++, addr += WPGROUP_SIZE) {
         if (addr < sd->size && test_bit(wpnum, sd->wp_groups)) {
@@ -833,7 +835,7 @@ static void sd_function_switch(SDState *sd, uint32_t arg)
 
 static inline bool sd_wp_addr(SDState *sd, uint64_t addr)
 {
-    return test_bit(sd_addr_to_wpnum(addr), sd->wp_groups);
+    return test_bit(sd_addr_to_wpnum(sd, addr), sd->wp_groups);
 }
 
 static void sd_lock_command(SDState *sd)
@@ -1345,7 +1347,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             }
 
             sd->state = sd_programming_state;
-            set_bit(sd_addr_to_wpnum(addr), sd->wp_groups);
+            set_bit(sd_addr_to_wpnum(sd, addr), sd->wp_groups);
             /* Bzzzzzzztt .... Operation complete.  */
             sd->state = sd_transfer_state;
             return sd_r1b;
@@ -1364,7 +1366,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             }
 
             sd->state = sd_programming_state;
-            clear_bit(sd_addr_to_wpnum(addr), sd->wp_groups);
+            clear_bit(sd_addr_to_wpnum(sd, addr), sd->wp_groups);
             /* Bzzzzzzztt .... Operation complete.  */
             sd->state = sd_transfer_state;
             return sd_r1b;
-- 
2.21.3


