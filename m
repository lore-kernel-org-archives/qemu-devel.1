Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA9BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 10:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89F522067C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 10:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMuVnxdk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F522067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7c1H-00042k-Ls
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 06:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k7bzz-00028k-5O; Mon, 17 Aug 2020 06:04:15 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45859)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k7bzx-0005kA-FW; Mon, 17 Aug 2020 06:04:14 -0400
Received: by mail-pg1-x544.google.com with SMTP id x6so7864132pgx.12;
 Mon, 17 Aug 2020 03:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=FLsZaHfTlGGMrLVb9xBYGkrs8wCV+0uRwO1rdXjYExo=;
 b=oMuVnxdkgRn28RXXrr4pPVxeUMMkirbsVs84gBUlTxsxw8yNz0avNT7jSfrBDdbh8C
 /uAHhStjAp5f897BiGijm6O5esnrPQ7L9YHsxrUJpspXQp9jIHPgEj+cSQffS7zUjxoK
 /LBN8G3Etp4796HxGWDhCzJZCLbkz9+FDZUletAPIwa03pPmaoqygUhF7KhTd/9Ml+lA
 d9geko22kAgV6fmn/O/703ReyEPVfgve9HQwZpuBF37OLJLX2w6CpiL3pYfU5uy5UhYo
 OeIYBLj628w6UEPV4m+V2aAcvrlQ+VFeBPiIwLZL8kgbalrK71OYldQjbmgSLnOIuKFn
 La9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=FLsZaHfTlGGMrLVb9xBYGkrs8wCV+0uRwO1rdXjYExo=;
 b=TrR08U9WQk0A//6eFU3Z6i6ckAaz0AfNqGg+89Uh/UI0crIOVA6CVFN3dq3skixhcp
 IG3FvUp+fMCvQVlFK23NgXBOi/qUyR/Gcp6w8nVAqM49B8xRJNbZzWNYKWopC82hshMu
 Y3I9LZrcObE1jVd6u4iM52BFlJRZRZmXgB5WtC/YMk0J3QMPLvJlxJfqBoNE5K5b1eZZ
 Jo/6ZHpcqFBlrE1BvDUqmtj5Lb4qDEi7IpwfyYXsfiWGx/3UyUvwf7WbKRiVI1PSGWLa
 Ap3MYDssHBM7EZusUO0t7IeN/fzzNQ6Wov5u4FlhJQr0xti7gfv73OhfisvzMmNPcVPI
 ahmw==
X-Gm-Message-State: AOAM532zdcNBzD0JQ3miJN85CiD5+PC1SRDQtXybirViuCbeCzHLGvWR
 8+uc5A3OdSbTSKfHWhW4Nx8+a4r7YCM=
X-Google-Smtp-Source: ABdhPJwQERYZxPu7mpBg8As8meTDe0nAmBLCSLHI823jZtIFR5CzAbyEAoYSoK+kfPxUD8blcAj+LA==
X-Received: by 2002:a63:fc4b:: with SMTP id r11mr9222457pgk.342.1597658651754; 
 Mon, 17 Aug 2020 03:04:11 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id i1sm19417576pfo.212.2020.08.17.03.04.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Aug 2020 03:04:11 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
X-Google-Original-From: Bin Meng <bin.meng@windriver.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: [PATCH v2 2/3] hw/sd: sd: Correct the maximum size of a Standard
 Capacity SD Memory Card
Date: Mon, 17 Aug 2020 18:03:53 +0800
Message-Id: <1597658633-12802-3-git-send-email-bin.meng@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597658633-12802-1-git-send-email-bin.meng@windriver.com>
References: <1597658633-12802-1-git-send-email-bin.meng@windriver.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Per the SD spec, Standard Capacity SD Memory Card (SDSC) supports
capacity up to and including 2 GiB.

Fixes: 2d7adea4fe ("hw/sd: Support SDHC size cards")
Signed-off-by: Bin Meng <bin.meng@windriver.com>

---

Changes in v2:
- fix SDSC size check in sd_set_csd() too

 hw/sd/sd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 3226404..254d713 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -50,6 +50,8 @@
 
 //#define DEBUG_SD 1
 
+#define SDSC_MAX_CAPACITY   (2 * GiB)
+
 typedef enum {
     sd_r0 = 0,    /* no response */
     sd_r1,        /* normal response command */
@@ -313,7 +315,7 @@ static void sd_ocr_powerup(void *opaque)
     /* card power-up OK */
     sd->ocr = FIELD_DP32(sd->ocr, OCR, CARD_POWER_UP, 1);
 
-    if (sd->size > 1 * GiB) {
+    if (sd->size > SDSC_MAX_CAPACITY) {
         sd->ocr = FIELD_DP32(sd->ocr, OCR, CARD_CAPACITY, 1);
     }
 }
@@ -385,7 +387,7 @@ static void sd_set_csd(SDState *sd, uint64_t size)
     uint32_t sectsize = (1 << (SECTOR_SHIFT + 1)) - 1;
     uint32_t wpsize = (1 << (WPGROUP_SHIFT + 1)) - 1;
 
-    if (size <= 1 * GiB) { /* Standard Capacity SD */
+    if (size <= SDSC_MAX_CAPACITY) { /* Standard Capacity SD */
         sd->csd[0] = 0x00;	/* CSD structure */
         sd->csd[1] = 0x26;	/* Data read access-time-1 */
         sd->csd[2] = 0x00;	/* Data read access-time-2 */
-- 
2.7.4


