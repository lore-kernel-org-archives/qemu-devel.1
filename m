Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EFFC4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:27:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFA6C20739
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vnna0l4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA6C20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQWtH-0005oS-OX
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 10:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWrv-0004BD-EH
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:26:07 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:46614)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWrr-0005y1-Kr
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:26:07 -0400
Received: by mail-wr1-x432.google.com with SMTP id n6so6546895wrm.13
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 07:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=9RUnT5Ix7DudVKkch5jxVyO4juXX54tuStniLRWABm0=;
 b=Vnna0l4au39C+KvMxRPK6rYHXMji8mnakh9bnZWGE5Ce4dhdphB4j+8LiPvAq9PuaN
 M+SuZ6+7hI3gZiyh3g6ro13Dh5nfZwfzXS0ITuSOtPVqPdFeX3NKsIKiC8DPk5Sjezmb
 /M25SHHuuppu64cqee08V7BzpFWj7d9jZAJuSgGAe5YP53T3oLR8iJDQnHrZQ+boEKJN
 Uvjahmmaf476lOCFzkQAqQxSt3ot0ql2XyEp1Fm+3wrHOU1kazLWiY2/oxUzuZ/Legj2
 rr954683SC+Oga7vMxx3d6RRG1KKkiwNChtWVJoHkrUuuzNSDi1cWK//4TIj0BCNl7op
 XQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9RUnT5Ix7DudVKkch5jxVyO4juXX54tuStniLRWABm0=;
 b=Puie3PJCGqtNBSibT+rxuNwAz8lUknL06d6MxL73pKjH2j+mNozOdegECuPMV3SaFZ
 ShBmPqnEjg8n1YR5kL5UCmvvqZzadXpdQaDgdg+3d83YTaWBqgh2QfZlU+OrmnSb60eI
 sx8BeM/2II0CJhM2gcS6fKpQlS49yqQOMe1AsBqyq7aQa6Jp5zRylXEFC36MTQfvBYSw
 724oawwBg67ExEaKtM28I/OwOTEBbQr2X2ryrUpglOsvlHQwbHAiTGkfppQl+pSb3S2B
 FZNXNBQ85aYCYNJ1Aw7k2DOMr6uygT3w77DJ2AEsfRvbADlJX05PFCWaTpfuiXIMo++w
 4vag==
X-Gm-Message-State: AOAM530rdq3kStnfdlkLTIWAW0vErgBZmfStVy0rTj1Cmwmtzlt+WL6M
 YpWnURHU/ZdQGg3t4ELk3fofLERRqdJs8ycp
X-Google-Smtp-Source: ABdhPJyl6SrHluJmalYx4QMGHgUqjX9qAApH/jWThyls+ErkEluXi8cqAhjSbz8wYHXn82M/qXQxNA==
X-Received: by 2002:adf:e445:: with SMTP id t5mr9271764wrm.387.1602167161584; 
 Thu, 08 Oct 2020 07:26:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j1sm7905104wrc.28.2020.10.08.07.26.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 07:26:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/12] hw/ssi/npcm7xx_fiu: Fix handling of unsigned integer
Date: Thu,  8 Oct 2020 15:25:46 +0100
Message-Id: <20201008142557.9845-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201008142557.9845-1-peter.maydell@linaro.org>
References: <20201008142557.9845-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Fix integer handling issues handling issue reported by Coverity:

  hw/ssi/npcm7xx_fiu.c: 162 in npcm7xx_fiu_flash_read()
  >>>     CID 1432730:  Integer handling issues  (NEGATIVE_RETURNS)
  >>>     "npcm7xx_fiu_cs_index(fiu, f)" is passed to a parameter that cannot be negative.
  162         npcm7xx_fiu_select(fiu, npcm7xx_fiu_cs_index(fiu, f));

  hw/ssi/npcm7xx_fiu.c: 221 in npcm7xx_fiu_flash_write()
  218         cs_id = npcm7xx_fiu_cs_index(fiu, f);
  219         trace_npcm7xx_fiu_flash_write(DEVICE(fiu)->canonical_path, cs_id, addr,
  220                                       size, v);
  >>>     CID 1432729:  Integer handling issues  (NEGATIVE_RETURNS)
  >>>     "cs_id" is passed to a parameter that cannot be negative.
  221         npcm7xx_fiu_select(fiu, cs_id);

Since the index of the flash can not be negative, return an
unsigned type.

Reported-by: Coverity (CID 1432729 & 1432730: NEGATIVE_RETURNS)
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Havard Skinnemoen <hskinnemoen@google.com>
Message-id: 20200919132435.310527-1-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/npcm7xx_fiu.c | 12 ++++++------
 hw/ssi/trace-events  |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/ssi/npcm7xx_fiu.c b/hw/ssi/npcm7xx_fiu.c
index 104e8f2b963..5040132b074 100644
--- a/hw/ssi/npcm7xx_fiu.c
+++ b/hw/ssi/npcm7xx_fiu.c
@@ -103,7 +103,8 @@ enum NPCM7xxFIURegister {
  * Returns the index of flash in the fiu->flash array. This corresponds to the
  * chip select ID of the flash.
  */
-static int npcm7xx_fiu_cs_index(NPCM7xxFIUState *fiu, NPCM7xxFIUFlash *flash)
+static unsigned npcm7xx_fiu_cs_index(NPCM7xxFIUState *fiu,
+                                     NPCM7xxFIUFlash *flash)
 {
     int index = flash - fiu->flash;
 
@@ -113,20 +114,19 @@ static int npcm7xx_fiu_cs_index(NPCM7xxFIUState *fiu, NPCM7xxFIUFlash *flash)
 }
 
 /* Assert the chip select specified in the UMA Control/Status Register. */
-static void npcm7xx_fiu_select(NPCM7xxFIUState *s, int cs_id)
+static void npcm7xx_fiu_select(NPCM7xxFIUState *s, unsigned cs_id)
 {
     trace_npcm7xx_fiu_select(DEVICE(s)->canonical_path, cs_id);
 
     if (cs_id < s->cs_count) {
         qemu_irq_lower(s->cs_lines[cs_id]);
+        s->active_cs = cs_id;
     } else {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: UMA to CS%d; this module has only %d chip selects",
                       DEVICE(s)->canonical_path, cs_id, s->cs_count);
-        cs_id = -1;
+        s->active_cs = -1;
     }
-
-    s->active_cs = cs_id;
 }
 
 /* Deassert the currently active chip select. */
@@ -206,7 +206,7 @@ static void npcm7xx_fiu_flash_write(void *opaque, hwaddr addr, uint64_t v,
     NPCM7xxFIUFlash *f = opaque;
     NPCM7xxFIUState *fiu = f->fiu;
     uint32_t dwr_cfg;
-    int cs_id;
+    unsigned cs_id;
     int i;
 
     if (fiu->active_cs != -1) {
diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
index 2f83ef833fb..612d3d6087a 100644
--- a/hw/ssi/trace-events
+++ b/hw/ssi/trace-events
@@ -19,4 +19,4 @@ npcm7xx_fiu_deselect(const char *id, int cs) "%s deselect CS%d"
 npcm7xx_fiu_ctrl_read(const char *id, uint64_t addr, uint32_t data) "%s offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
 npcm7xx_fiu_ctrl_write(const char *id, uint64_t addr, uint32_t data) "%s offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
 npcm7xx_fiu_flash_read(const char *id, int cs, uint64_t addr, unsigned int size, uint64_t value) "%s[%d] offset: 0x%08" PRIx64 " size: %u value: 0x%" PRIx64
-npcm7xx_fiu_flash_write(const char *id, int cs, uint64_t addr, unsigned int size, uint64_t value) "%s[%d] offset: 0x%08" PRIx64 " size: %u value: 0x%" PRIx64
+npcm7xx_fiu_flash_write(const char *id, unsigned cs, uint64_t addr, unsigned int size, uint64_t value) "%s[%d] offset: 0x%08" PRIx64 " size: %u value: 0x%" PRIx64
-- 
2.20.1


