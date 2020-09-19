Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E090EC43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 13:25:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 312A1208C3
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 13:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYm7E7Ke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312A1208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJcrv-0008HT-W7
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 09:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJcr4-0007qx-U0; Sat, 19 Sep 2020 09:24:42 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35968)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJcr2-0003Yh-Kv; Sat, 19 Sep 2020 09:24:42 -0400
Received: by mail-wr1-x441.google.com with SMTP id z1so8278788wrt.3;
 Sat, 19 Sep 2020 06:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=apNiNwtCTkCJZflMQCw25LK+sf/BwC+K1q+Rj9YfQ1k=;
 b=HYm7E7KeFgPd3AN4N5LzKzdbFZpTIeyfPZfhPbZkDrHrHqS2pJdzUaQiuq5i5DYFRH
 joXSLEJT9VfFTDc8kd8/le0nBySj3fWMcc/KEI9KptiU8MxN5nBhfUqO53OcveJQxMDD
 U0KkW4h9PiozlgG3R+3zRpbpr+iSmcGbcMYi3s0SkMGg7I8RHXyUcwzY/vWlWJgtBEMM
 GqheZ/0qMi5D8WXZvUIQPLgF5fMFReYD8tCxv8O6yhzrmDFOX6x3p2TDR0ZDjslSVWk1
 O0zJJzb680g2mhRKhg8O+tKKiE/N9EBmJApdFv9AaiYyATOa5DF6Mr+aCQHf0W+d2gkd
 lptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=apNiNwtCTkCJZflMQCw25LK+sf/BwC+K1q+Rj9YfQ1k=;
 b=GwV0q9EYdL8JVskUdC9C12tN2miG+2+sbJtQXmlF5JVYwUvqPR5GFBvzCQDIEno1GC
 Yr5SDruQzBeerFVgepnopTb761ZP6CNE540sfpJzIGNCzIrscWIKZl0luXSjg8VhWT1n
 5SqOo2a2StWmT141ZU0Q3WDiUxqsiU/nn3ga+XkUV+dW9FRhgq/ZjtnJ2QfKnHNX9Y6C
 Q2XHyRhBpB1fnszcGCPwEItIbFkWxEpP8XlwBTXi/b7y6F1I2h4M7SqA+hlREdq80TkV
 VVWdkfJp2sB9D4FnipohKFbdH3q7djOOORfZIBcWFExn+i1vgmFD06uswJsDe4BbBth3
 vzzg==
X-Gm-Message-State: AOAM532G7bVb+xNkY62RKJhgOFRZ7QM1BXgndnmH49PGPlh+sTIZoOvw
 fJ1ymihpV19kGXxbLX/52Z6CAXQLd0s=
X-Google-Smtp-Source: ABdhPJxY35h5rPeG8embz1az1CPijlMYmaWEWPR3XTztEWh/JkY232N3kUSZKqiGBhIm9YxZN2QBjA==
X-Received: by 2002:adf:ba4f:: with SMTP id t15mr19868280wrg.335.1600521878572; 
 Sat, 19 Sep 2020 06:24:38 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id a20sm10167454wmm.40.2020.09.19.06.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2020 06:24:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/ssi/npcm7xx_fiu: Fix handling of unsigned integer
Date: Sat, 19 Sep 2020 15:24:35 +0200
Message-Id: <20200919132435.310527-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
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
Cc: Tyrone Ting <kfting@nuvoton.com>, Alistair Francis <alistair@alistair23.me>,
 Havard Skinnemoen <hskinnemoen@google.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
2.26.2


