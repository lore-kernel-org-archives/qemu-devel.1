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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257BEC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 10:06:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE6252067C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 10:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U78S4HWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6252067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7c2b-0006N7-52
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 06:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k7c1G-0004PL-PC; Mon, 17 Aug 2020 06:05:34 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:38904)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k7c1F-0005vf-6M; Mon, 17 Aug 2020 06:05:34 -0400
Received: by mail-pj1-x1042.google.com with SMTP id ep8so7456715pjb.3;
 Mon, 17 Aug 2020 03:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=FLsZaHfTlGGMrLVb9xBYGkrs8wCV+0uRwO1rdXjYExo=;
 b=U78S4HWEhq7rnktFlX8hnfuPH16sQTVv6WOy98zFdElIB/3IrOZzSr9yxIG08STkob
 0svYk4kwzO7w2k9AZ2cB3OqjmUYwTIew/YekDJ2l4agmBT/VENE9MQZKwUThRRHGMtgu
 m5F2z4sUk/5Km9jqzWHQaeI1rC1MvfMMZvgt/6xlczMAgTNf7j+cV+LugeDQ4CRS7oFu
 9MKxScy68K49m+2ZwskVKjlJLyTtwljnihJrB4qCU3POr80N+IFQAlhGr0V8/LoQVPpU
 rQBUfK7wl8FGHs1vfPCQYDpPgFKdsONpUZSBhVASFmRgbyjFE1izk9qESIJW2Jth4njX
 0kbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=FLsZaHfTlGGMrLVb9xBYGkrs8wCV+0uRwO1rdXjYExo=;
 b=ikX6eOV9+YcUsd4Wz9F0ZN4dt4uEmx58HD7hElSMri25wRYQOqCQFuhvvU9X6kd7hz
 S2fPPV0LGVJ+tmmwsmetTDpfTYwvQGwQFCu3xtC7a2zRYbUn81VxfwLiUJnbNRqGbSXK
 sobYqvKSKsAMgW7tEI1mxFVwH7dw5JkeMoooVyBdT1/6/8MUppVkjfTSCtkjGft9WYfb
 imTza0IK9tVYTyYFt3YWR/oXaOLNfrG6bXjO2s1juNL3bB60+byaP4mFo/L2rb7QQ4Sg
 nqWqdxKj8pYS0NLxBWXK9qzuRCz9KGKvhZ27W8xM2Cco7+GGbjJQtX27tPKKxvoaz6Eb
 Zyng==
X-Gm-Message-State: AOAM533hD1AhvloHPss2b1K2ABTjE3MaWp+rguiOor+UMkzMpgNGvjNq
 8/Z6pdln3104kRrUfERT3UU=
X-Google-Smtp-Source: ABdhPJwOnLv+NbCC8A6oMz0LwCx0fnSPRwrfXsfqQHJdRp+tK6qkRab7yVWbVWrpeAEELDUuLCUF6g==
X-Received: by 2002:a17:902:7603:: with SMTP id
 k3mr3849320pll.113.1597658731320; 
 Mon, 17 Aug 2020 03:05:31 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id e20sm17036743pjr.28.2020.08.17.03.05.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Aug 2020 03:05:30 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
X-Google-Original-From: Bin Meng <bin.meng@windriver.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: [PATCH v2 2/3] hw/sd: sd: Correct the maximum size of a Standard
 Capacity SD Memory Card
Date: Mon, 17 Aug 2020 18:05:21 +0800
Message-Id: <1597658722-12922-3-git-send-email-bin.meng@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597658722-12922-1-git-send-email-bin.meng@windriver.com>
References: <1597658722-12922-1-git-send-email-bin.meng@windriver.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1042.google.com
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


