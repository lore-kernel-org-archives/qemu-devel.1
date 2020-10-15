Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721A7C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 06:47:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B26D121D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 06:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCExnQLT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26D121D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSx3A-0003s6-Nv
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 02:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSwuN-0005F4-Fs; Thu, 15 Oct 2020 02:38:39 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSwuL-0006sP-Nf; Thu, 15 Oct 2020 02:38:39 -0400
Received: by mail-wr1-x442.google.com with SMTP id e17so1888432wru.12;
 Wed, 14 Oct 2020 23:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BM7THxJfGf+b7XY8piPM2aMZEPnFkfmBjlshGc2heOo=;
 b=kCExnQLTOdy0eTaIM3es43d2RzUSgOtGsYf5YMDtMa53Jk9qpmPaP9jNjcD4Xaq7ix
 0wXiX+pkxCJFS6KhtKAR34R2SIKnBX+0Acf+da9onS6U4PIKuVTK7/jmoazZdzCl2GJM
 7BJZnxm6yWcb/FRqCx0aFBShLh7wzimn74tAwnQSQ5jPW6sHXuHbhhHFzJBxpBzEgLFD
 pDj4VuafWjTUTL2ASs/N+XNCpvFpDrjsEJIUMNTq2+1OhyIzXNSamGyaLT80nzRYzH/M
 NOOC2j0LnV8jtNtHd5GiqX0hSrU8hJLunNbJdzQX5sFO1TKYU+uZmoYeEK+jYtz3fJSx
 zw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=BM7THxJfGf+b7XY8piPM2aMZEPnFkfmBjlshGc2heOo=;
 b=eRixk0WQ3ygZzjKru7aSzZApMMXQEa95d1HK3NEsdkfKehpdaxDv1h7eGC3svNGjR2
 BKCruBQjs0fDY0KfiBkNLgmsXaPVDCiTrwpO3LxPXVRsJ8PWRIFXZ0Bs+lO+e3vBUYcw
 jUFfiYzjJwle9HAQit9E1oFbyNKUlsIYy7F2oQoporQo2Ry1zr/ixFH3uVQraVH0EAM1
 HOT7KGwBZ3Y4jicKXAnW+MEIxnHatBfiPR0PUqTaoL7BXsj6mDYU17Uwn4gZc4eUSEKM
 YV+fxkFudVohhQC2s8VXUhqQ7ouppOkycdC9gv6SjTV4PpjgKz9oTt8ZBBNjYAqTseKq
 mkkA==
X-Gm-Message-State: AOAM533vHIQytUi1EOVt6Tc4EmYYoreZoWBks7ns1CgXaWneLjFYt38D
 jwl5VQLAAZ/u4GXH/vXZNEVNpKz/Rfo=
X-Google-Smtp-Source: ABdhPJxW35CEtaaKI0Vm0aC6ms9AcSUfON2lrko+9RFZWnaQt+mc1unGPGms/S316mMm0yx9daZHJQ==
X-Received: by 2002:adf:b30c:: with SMTP id j12mr2424804wrd.82.1602743915849; 
 Wed, 14 Oct 2020 23:38:35 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 4sm2874292wrn.48.2020.10.14.23.38.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 23:38:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/6] hw/sd/sdcard: Introduce the INVALID_ADDRESS definition
Date: Thu, 15 Oct 2020 08:38:20 +0200
Message-Id: <20201015063824.212980-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201015063824.212980-1-f4bug@amsat.org>
References: <20201015063824.212980-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'0' is used as a value to indicate an invalid (or unset)
address. Use a definition instead of a magic value.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 2606b969e34..30ae435d669 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -53,6 +53,8 @@
 
 #define SDSC_MAX_CAPACITY   (2 * GiB)
 
+#define INVALID_ADDRESS     0
+
 typedef enum {
     sd_r0 = 0,    /* no response */
     sd_r1,        /* normal response command */
@@ -575,8 +577,8 @@ static void sd_reset(DeviceState *dev)
     sd->wpgrps_size = sect;
     sd->wp_groups = bitmap_new(sd->wpgrps_size);
     memset(sd->function_group, 0, sizeof(sd->function_group));
-    sd->erase_start = 0;
-    sd->erase_end = 0;
+    sd->erase_start = INVALID_ADDRESS;
+    sd->erase_end = INVALID_ADDRESS;
     sd->size = size;
     sd->blk_len = 0x200;
     sd->pwd_len = 0;
@@ -750,7 +752,8 @@ static void sd_erase(SDState *sd)
     uint64_t erase_end = sd->erase_end;
 
     trace_sdcard_erase(sd->erase_start, sd->erase_end);
-    if (!sd->erase_start || !sd->erase_end) {
+    if (sd->erase_start == INVALID_ADDRESS
+            || sd->erase_end == INVALID_ADDRESS) {
         sd->card_status |= ERASE_SEQ_ERROR;
         return;
     }
@@ -763,8 +766,8 @@ static void sd_erase(SDState *sd)
 
     erase_start = sd_addr_to_wpnum(erase_start);
     erase_end = sd_addr_to_wpnum(erase_end);
-    sd->erase_start = 0;
-    sd->erase_end = 0;
+    sd->erase_start = INVALID_ADDRESS;
+    sd->erase_end = INVALID_ADDRESS;
     sd->csd[14] |= 0x40;
 
     for (i = erase_start; i <= erase_end; i++) {
-- 
2.26.2


