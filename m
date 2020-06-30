Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7D9C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:16:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83DA520760
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="si8Dl69Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DA520760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDJn-0007Fh-P7
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqD7M-0002Zt-Eq; Tue, 30 Jun 2020 06:03:56 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:45170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqD7K-0004et-Pb; Tue, 30 Jun 2020 06:03:56 -0400
Received: by mail-ej1-x643.google.com with SMTP id a1so19887048ejg.12;
 Tue, 30 Jun 2020 03:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Xe1kf7UAPTm1mbg2PINnk48fL4iH0z/PWyqjOaU27f0=;
 b=si8Dl69ZBhDWLRVxPcnx7qt4/4umv0F5TdNW9H7hh21e3zFtTlF5ZPW05z/UH4tNjl
 zXUluJW1ZWnqTUWVezcrJ1iRlvqnwrfmzkqdD88O/CM+3akaaOSFBsjOGdoGpjmOZM3R
 jul/XHjoGj66wwB2N3LuQgw0Y6QVDvCSRbzxOE4zRjOw06zGiYZYNX6jT4A9dtTQcSnP
 tva3J99wrtFEVfVa0vmphoTs+UDaAiZ55AA32TFZqRCohhUJvSt4J2LyLCbPTWQ8J5pg
 4TEI+Fk1SbJX5+E5m1gJpkm9+RZam5QwFrQja06O2vKWH6fPwOAEgEBuUvd5bewZO7AH
 99PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Xe1kf7UAPTm1mbg2PINnk48fL4iH0z/PWyqjOaU27f0=;
 b=j+Wmb5/HwaTiiJIz4vOApRpa2zg63dnYlf9diQEpD3v9UOuPQMTlCFLMZAz2fkoO1x
 I1ssdtT0mpcq5fUXFLKmQSEEfQyzdYJsxaQylKBPUiUnlOeSjirfQTInQYVJ5EuUzs2P
 6EiZYIwJjxEQTItoDmOB5nuLt9GqestZBH0U5HDwFzomNQi+dLtyPoN30Pmz+DsPqvjK
 Dvp/PiTpPADp68abe0/GSDspYnoEoNPioSCiojjW/YoE7UCQz3/DXiBG/LgamkCiEqcO
 k0aJmoeEs9HJlGgDmJVQcCQJCnv7xbZkB4JQrKAT40U/xzk0aFhSpQRK+CMk6834zdh3
 CAsw==
X-Gm-Message-State: AOAM531uSPtIF4GlWm+PAb6QMiJ4v8x6lu9xGkJ/gS8j+BQDspVrVMt2
 5axjESGSXUk26h97ZGr9TZ/8K5xvO0w=
X-Google-Smtp-Source: ABdhPJx8lEnH8z9a9zDaZjAs2+RQJL6Tp3qGpm0z+/+jzpIWVal8jEuahJ7u0KuwTxIt58FI7D6LSQ==
X-Received: by 2002:a17:906:8542:: with SMTP id
 h2mr17225994ejy.517.1593511432963; 
 Tue, 30 Jun 2020 03:03:52 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id h2sm2304697edk.54.2020.06.30.03.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 03:03:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 08/15] hw/sd/sdcard: Check address is in range
Date: Tue, 30 Jun 2020 12:03:35 +0200
Message-Id: <20200630100342.27625-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630100342.27625-1-f4bug@amsat.org>
References: <20200630100342.27625-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x643.google.com
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
v6: call sd_addr_to_wpnum on 'size - 1' in reset()
---
 hw/sd/sd.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 22392e5084..c6742c884d 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -537,8 +537,10 @@ static void sd_response_r7_make(SDState *sd, uint8_t *response)
     stl_be_p(response, sd->vhs);
 }
 
-static inline uint64_t sd_addr_to_wpnum(uint64_t addr)
+static uint64_t sd_addr_to_wpnum(SDState *sd, uint64_t addr)
 {
+    assert(addr <= sd->size);
+
     return addr >> (HWBLOCK_SHIFT + SECTOR_SHIFT + WPGROUP_SHIFT);
 }
 
@@ -575,7 +577,7 @@ static void sd_reset(DeviceState *dev)
     sd_set_cardstatus(sd);
     sd_set_sdstatus(sd);
 
-    sect = sd_addr_to_wpnum(size) + 1;
+    sect = sd_addr_to_wpnum(sd, size - 1) + 1;
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


