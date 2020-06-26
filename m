Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E902C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:43:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD5092081A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9aVK0Xd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD5092081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorS8-0005hy-2O
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorP6-0000F2-V8; Fri, 26 Jun 2020 12:40:41 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorP5-00066E-9P; Fri, 26 Jun 2020 12:40:40 -0400
Received: by mail-wm1-x343.google.com with SMTP id l17so9431563wmj.0;
 Fri, 26 Jun 2020 09:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/hBqILuvbq8GQVmvRRiNXAXWPYKiP9RUKThJFiSA5Mw=;
 b=C9aVK0Xd/bqTAE4Xy/s3T9iz40yTKaHPXlKka7sM76XHmnPHHWJhs2mcl6EpzFRMVm
 rIlDLpGanwheliSjSavLbtq1/zXqPG66sWkQ6CtANnVywtYjnsgfxpYCujL0FGi/ESVY
 /OTHu597oIgyWGUfJVDb/2QbJakzbeQHd5o0hYiGBrbE9e7uwCJ7//kmzmV66jWtwLC0
 m3OXQPnYMhKr6cS1QxIhY9j/dGzmRZYrnQaTHkOyOC4sf6lC/Ug4p1xi5V3s7t8lB7xf
 GLZI3KBXdlf4IGf28nmf3Hm0vGRyWbU1zpCoFQhHAJE86m16EXqLHJX663kKcqMLK0ec
 nIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=/hBqILuvbq8GQVmvRRiNXAXWPYKiP9RUKThJFiSA5Mw=;
 b=KYyVuy4YQNBn0PpFIqhIk56MNAVUCyYa366lAgdfD9eBTYjuR2xDqwz5meV+7sETzH
 UV0DdhwJg2kJmGQS9KiDUNdhYnLfW6/B4LgSCW7V8D1KkihuNGQmYqmLDuoo+5BLSQB6
 1YoKoTu5mDTDJTlb4Wo8l1jTKbrBuocViGRyBPmL6ec9JUrsTZRorhlq/TEnDpNdeuOp
 Ieu/dNVCj5NBc6dsaua3nGre/lgvDQR1fmF4NAW2Pfyb1JUOOm7lOTjFrEohgLrXQI7m
 nmGVmegnVD19ZfdZh1tawqs2Z210Lw8BNAfPcfzzvLquQNH2/ciqbEKg/qf/9dbLEnU+
 W2uQ==
X-Gm-Message-State: AOAM531tB6eE4Vc0z1BgNKgqVtc386w/GyywHroT5z/RxMskSjy04bqS
 FIEgroDHonMS2x8mR9PCRX1PQDpO
X-Google-Smtp-Source: ABdhPJxkBeB1WtyYfV3YEqbjDHyMvw8jGV/v9JOy4Al6M4s19w+4kl0goaTLsN61LLRNn60M1DPf6g==
X-Received: by 2002:a7b:c84d:: with SMTP id c13mr4339760wml.170.1593189637181; 
 Fri, 26 Jun 2020 09:40:37 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id f12sm24623646wrw.53.2020.06.26.09.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 09:40:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 07/15] hw/sd/sdcard: Initialize constant values first
Date: Fri, 26 Jun 2020 18:40:18 +0200
Message-Id: <20200626164026.766-8-f4bug@amsat.org>
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

Reorder initialization code, constant values first.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 871c30a67f..22392e5084 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -556,22 +556,6 @@ static void sd_reset(DeviceState *dev)
     }
     size = sect << 9;
 
-    sect = sd_addr_to_wpnum(size) + 1;
-
-    sd->state = sd_idle_state;
-    sd->rca = 0x0000;
-    sd_set_ocr(sd);
-    sd_set_scr(sd);
-    sd_set_cid(sd);
-    sd_set_csd(sd, size);
-    sd_set_cardstatus(sd);
-    sd_set_sdstatus(sd);
-
-    g_free(sd->wp_groups);
-    sd->wp_switch = sd->blk ? blk_is_read_only(sd->blk) : false;
-    sd->wpgrps_size = sect;
-    sd->wp_groups = bitmap_new(sd->wpgrps_size);
-    memset(sd->function_group, 0, sizeof(sd->function_group));
     sd->erase_start = 0;
     sd->erase_end = 0;
     sd->size = size;
@@ -581,6 +565,22 @@ static void sd_reset(DeviceState *dev)
     sd->dat_lines = 0xf;
     sd->cmd_line = true;
     sd->multi_blk_cnt = 0;
+    sd->state = sd_idle_state;
+    sd->rca = 0x0000;
+
+    sd_set_ocr(sd);
+    sd_set_scr(sd);
+    sd_set_cid(sd);
+    sd_set_csd(sd, size);
+    sd_set_cardstatus(sd);
+    sd_set_sdstatus(sd);
+
+    sect = sd_addr_to_wpnum(size) + 1;
+    g_free(sd->wp_groups);
+    sd->wp_switch = sd->blk ? blk_is_read_only(sd->blk) : false;
+    sd->wpgrps_size = sect;
+    sd->wp_groups = bitmap_new(sd->wpgrps_size);
+    memset(sd->function_group, 0, sizeof(sd->function_group));
 }
 
 static bool sd_get_inserted(SDState *sd)
-- 
2.21.3


