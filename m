Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E69C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:44:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A24223BF
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uuQl3lsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A24223BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVIAP-0003a5-OU
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVI1M-0003cO-FA
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:35:34 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:51124)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVI1L-0006GV-42
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:35:32 -0400
Received: by mail-wm1-x336.google.com with SMTP id 13so2988690wmf.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W5cNhnlAua+FOcK+awIb+jUgiTp6wkKIcsuybacXu04=;
 b=uuQl3lsG6QEoeL871Ku7B2hgq+rS8wCFkbhrhZiPMVZzvNv2ik3yLV/g/DwtBFYJVh
 J8/jaLeMX98KAb7+d6uS+U7KfikqP5JljWzzY1iIxE6x1RHj4mg5kMYIT/62Ems8r+Kc
 rVjfH0qkzGSSeu19Rqq8Xr4ofqLNyMf6xsgt5sfnwT+PHKvqaqH+67ttvurBq7agxyi2
 PGOZY2jLqY8HCXuHkU6evHwREcD3qjkZDpkH2wAwyeljGNNyJ2Nr/13VdGaQuBOBhl0x
 DxeGjg0omDFiKLoFFHBF8mwRnOMxCg0AmD+OIcvioOKjcNOzbgz/q0yDbBLHF6mChkd6
 878w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=W5cNhnlAua+FOcK+awIb+jUgiTp6wkKIcsuybacXu04=;
 b=SMY5u/VQU/C0bRGG0TIAQ779ngZVbh5wq+VKlDHu3t1zAMV7kqrN5IWT6iwsosh8nT
 JOLIpVahx5WQlTrl9qe6FuheSSFdfhKFax5YwiusftivOm/dhRrjE0YQBLTWGS62Fhl2
 HYTUEUy8oomyKYrUKplxSgOBypGE4pfNMKqG5S249Ic5vJ/fOWVSO9/l//CtTyrvoRU8
 nIeQp3pa+R/MO2xXOL7nMZPC8S455Q+Yu4iTFEqcvysPWqfC6cT8OAHpMYZ49llMdFU8
 iNN5ca3hK8UR+Ynb7J28s0axM/k6HW0R2K724PAHUAt3CrnE5UJxwJzMQGjPAfTh9BAr
 RZ7w==
X-Gm-Message-State: AOAM533xxjs8l0KKGAJKkRMy7FGLli3BRGlJjk4onWsUt76rSpa/+XBO
 mD4uHpuaM6XJHuiu5xOjoyI3B5J3lZc=
X-Google-Smtp-Source: ABdhPJxqB4H7EHrnxUhjd98VCfoocJJcFw13ayFKIk/phEUEE4OjLvC4e0hCiTw01XWOsZxFipWkfg==
X-Received: by 2002:a1c:2042:: with SMTP id g63mr4539960wmg.174.1603301729666; 
 Wed, 21 Oct 2020 10:35:29 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id d129sm4719627wmd.5.2020.10.21.10.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:35:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/13] hw/sd/sdcard: Add trace event for ERASE command (CMD38)
Date: Wed, 21 Oct 2020 19:34:45 +0200
Message-Id: <20201021173450.2616910-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201021173450.2616910-1-f4bug@amsat.org>
References: <20201021173450.2616910-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Trace addresses provided to the ERASE command.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20201015063824.212980-2-f4bug@amsat.org>
---
 hw/sd/sd.c         | 2 +-
 hw/sd/trace-events | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 00128822224..2606b969e34 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -749,7 +749,7 @@ static void sd_erase(SDState *sd)
     uint64_t erase_start = sd->erase_start;
     uint64_t erase_end = sd->erase_end;
 
-    trace_sdcard_erase();
+    trace_sdcard_erase(sd->erase_start, sd->erase_end);
     if (!sd->erase_start || !sd->erase_end) {
         sd->card_status |= ERASE_SEQ_ERROR;
         return;
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index a87d7355fb8..96c7ea5e52f 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -46,7 +46,7 @@ sdcard_reset(void) ""
 sdcard_set_blocklen(uint16_t length) "0x%03x"
 sdcard_inserted(bool readonly) "read_only: %u"
 sdcard_ejected(void) ""
-sdcard_erase(void) ""
+sdcard_erase(uint32_t first, uint32_t last) "addr first 0x%" PRIx32" last 0x%" PRIx32
 sdcard_lock(void) ""
 sdcard_unlock(void) ""
 sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
-- 
2.26.2


