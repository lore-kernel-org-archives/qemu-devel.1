Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087EDC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:47:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC79220836
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJza6d7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC79220836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorVs-0005EL-V2
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorP8-0000GW-W7; Fri, 26 Jun 2020 12:40:43 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50744)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorP6-00066w-EC; Fri, 26 Jun 2020 12:40:41 -0400
Received: by mail-wm1-x343.google.com with SMTP id l17so9431634wmj.0;
 Fri, 26 Jun 2020 09:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R2DX/QQvHKfKb103HIE/F7gpPXUpgK50o5/9QbI2yBE=;
 b=KJza6d7/0XHGk9QScJHiogDEx4Kr/QcZg6XDP5GgSEv46bAujP6d5YNaRKpMycyeKD
 FVNJ9bVhdv/sSuEhabHCUJyzj+G+bfjBbBcNa4TrhobyzZEmNNuYgaKaEAoqy6sl3tz4
 YD7snXvqW07HGDcbDYJwpzK8+LzzcpVjcuL8pPKxLp0OaMtyMzivdpp63mwsNTJBDqxa
 n+ZNbpycmtLeh6AP79jp2/g1tZyDTkE0BkzeIr+NMpZ1tmb8Go9Cn0bbDJkxazUvH1Nu
 ma/5Fv0rDhlcQV7yai/82gPMseNHjyzT4HR4eSvcAA+vHr64oPo2fZKY8AN/R620ejZs
 cbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=R2DX/QQvHKfKb103HIE/F7gpPXUpgK50o5/9QbI2yBE=;
 b=VsEKk/9GjRY1hOilXO1yvUO7UTMp+0fgg6FAXqNOOfbnFkxFf+8iOz7On4GGBoDSvZ
 AWeclD41v+zP9v43ZV6NtWrqPfll1GxvEvuVg7svNA9D5njij7jHHF+aNTX4OHXp3KAy
 utqomVNyI00jLQxRxTiqtYPbCJSyzzwoDeSkQfW65ZuQOxGaprf2Bn0gP0Ygo/oM/7He
 0FHKjSMqJTGP8Qo/M/Tf5oPDVwd6XVljqPo5t/mErNyS5YHxx2opSfYQtHIhbFeIcbAe
 smwleSYV5XkOcmChMoFcX3v6GX9QFFPkAwVGacOJYEKIDtFOMm27VVTnSu5KVfYG9HfH
 1ghA==
X-Gm-Message-State: AOAM531PBBuU7iOUliQ31UXub3G5ohZOQb06jOJPgpI+qDUAWYr1ZkKj
 QHMh8png1iivztqQ4fHaUpxLn/SV
X-Google-Smtp-Source: ABdhPJxQ+ftUwDr3GnixSzlUlHFNC7KeT3dhTezAnQ2x5WTO94b5OefT29xSTFBQtDC90ojVI/sWcw==
X-Received: by 2002:a7b:c4d6:: with SMTP id g22mr4469593wmk.170.1593189638354; 
 Fri, 26 Jun 2020 09:40:38 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id f12sm24623646wrw.53.2020.06.26.09.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 09:40:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 08/15] hw/sd/sdcard: Check address is in range
Date: Fri, 26 Jun 2020 18:40:19 +0200
Message-Id: <20200626164026.766-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200626164026.766-1-f4bug@amsat.org>
References: <20200626164026.766-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
 hw/sd/sd.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 22392e5084..2689a27b49 100644
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
 
@@ -575,7 +577,7 @@ static void sd_reset(DeviceState *dev)
     sd_set_cardstatus(sd);
     sd_set_sdstatus(sd);
 
-    sect = sd_addr_to_wpnum(size) + 1;
+    sect = sd_addr_to_wpnum(sd, size) + 1;
     g_free(sd->wp_groups);
     sd->wp_switch = sd->blk ? blk_is_read_only(sd->blk) : false;
     sd->wpgrps_size = sect;
@@ -759,8 +761,8 @@ static void sd_erase(SDState *sd)
         erase_end *= HWBLOCK_SIZE;
     }
 
-    erase_start = sd_addr_to_wpnum(erase_start);
-    erase_end = sd_addr_to_wpnum(erase_end);
+    erase_start = sd_addr_to_wpnum(sd, erase_start);
+    erase_end = sd_addr_to_wpnum(sd, erase_end);
     sd->erase_start = 0;
     sd->erase_end = 0;
     sd->csd[14] |= 0x40;
@@ -777,7 +779,7 @@ static uint32_t sd_wpbits(SDState *sd, uint64_t addr)
     uint32_t i, wpnum;
     uint32_t ret = 0;
 
-    wpnum = sd_addr_to_wpnum(addr);
+    wpnum = sd_addr_to_wpnum(sd, addr);
 
     for (i = 0; i < 32; i++, wpnum++, addr += WPGROUP_SIZE) {
         if (addr < sd->size && test_bit(wpnum, sd->wp_groups)) {
@@ -819,7 +821,7 @@ static void sd_function_switch(SDState *sd, uint32_t arg)
 
 static inline bool sd_wp_addr(SDState *sd, uint64_t addr)
 {
-    return test_bit(sd_addr_to_wpnum(addr), sd->wp_groups);
+    return test_bit(sd_addr_to_wpnum(sd, addr), sd->wp_groups);
 }
 
 static void sd_lock_command(SDState *sd)
@@ -1331,7 +1333,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             }
 
             sd->state = sd_programming_state;
-            set_bit(sd_addr_to_wpnum(addr), sd->wp_groups);
+            set_bit(sd_addr_to_wpnum(sd, addr), sd->wp_groups);
             /* Bzzzzzzztt .... Operation complete.  */
             sd->state = sd_transfer_state;
             return sd_r1b;
@@ -1350,7 +1352,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             }
 
             sd->state = sd_programming_state;
-            clear_bit(sd_addr_to_wpnum(addr), sd->wp_groups);
+            clear_bit(sd_addr_to_wpnum(sd, addr), sd->wp_groups);
             /* Bzzzzzzztt .... Operation complete.  */
             sd->state = sd_transfer_state;
             return sd_r1b;
-- 
2.21.3


