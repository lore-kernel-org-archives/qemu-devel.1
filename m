Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F80C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A19206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSW7gXTE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A19206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD6vZ-0007ww-Bm
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD6tX-0003xG-1C; Tue, 01 Sep 2020 10:04:19 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46334)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD6tV-0002mm-FV; Tue, 01 Sep 2020 10:04:18 -0400
Received: by mail-wr1-x443.google.com with SMTP id o5so1652393wrn.13;
 Tue, 01 Sep 2020 07:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nVzUwFb/Pru0mu/Wze/TshCcACe4nWk3tSS2yGusfjU=;
 b=YSW7gXTErhA8CgLNJvuA23gm6mNXiDk/En+AaYxJ71kpBt2hAaeH7C6k8/wtb9uHcj
 toGBzVuwY1yS4wzogAfFLJ+XPg7qKPZbqDtexrMk52piNaUCvZEeBZTi43Pk2juLrSGj
 bB+aD2MiVyEU5du/LfBPT7EXmoYJrLtHM6WsVQULYHP0FYAbe08yYcfw3tfUiV8TZcR7
 U4IcI2tz+bg/bNgnaySzHnoK3kTZI3sM4fELu3lHzrV6GLp0TlSQxfjrV4RyqCQFABoC
 W9Re0IS4u/t8m1j4nc3p+8kWgLwn3acb8Qu+HdsMA86kwJV7zUF74Bb7lSAIVrONjAy4
 3KSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nVzUwFb/Pru0mu/Wze/TshCcACe4nWk3tSS2yGusfjU=;
 b=I+S2WXIYyNskopT9+z8ZhpHWUC2xMUo08zVc6txN+DjOY2uubvVwbX6FKqPXewYRhd
 ixS2Tz9cZbQ4o5eMZ+gsp/e4SgqCDY9fRU5vEAHDhPYeQblRMVJcF6vi0xpxYOtL+lN/
 VDqHLXNZ/SPdcHh6X2WdYUljQRnv+3d1chSD2GV46QBnKtz9PIRzQ5MIc1DF0Z7iLqmQ
 dBgL5NhXta8xSd/cjlxtuikhhK3eCJtsrvTz+D+9tIWSnk60Clwe3xuVoNWnwzuG9akn
 6qgR/ZYVlNWborazcnhCa0NNNF8eWJVjJFRfQdxMBLGAdvLvc70tdICmi6/jmn7JTT2L
 NSAw==
X-Gm-Message-State: AOAM533oaRg3HxP87EINFG1HMJa8B2Cff1b6/V8EkEx+wAgdTqACc6Sy
 K/0SHcCubJ/gd8cJZ+X6PjzK/Dw3neI=
X-Google-Smtp-Source: ABdhPJzXi4qPizW450aFl/1wmOy0dnd8Tci92ijCNLKFzo75+bsU9mWCfT5qMUxaQpTPMAjk9sp45A==
X-Received: by 2002:a05:6000:110a:: with SMTP id
 z10mr2183221wrw.374.1598969054946; 
 Tue, 01 Sep 2020 07:04:14 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id p22sm1872505wmc.38.2020.09.01.07.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 07:04:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] hw/sd/sdhci: Fix qemu_log_mask() format string
Date: Tue,  1 Sep 2020 16:04:09 +0200
Message-Id: <20200901140411.112150-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140411.112150-1-f4bug@amsat.org>
References: <20200901140411.112150-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alexander Bulekov <alxndr@bu.edu>, bugs-syssec@rub.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add missing newline character in qemu_log_mask() format.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 1785d7e1f79..e2ef288052e 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1109,7 +1109,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         /* Limit block size to the maximum buffer size */
         if (extract32(s->blksize, 0, 12) > s->buf_maxsz) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: Size 0x%x is larger than "
-                          "the maximum buffer 0x%x", __func__, s->blksize,
+                          "the maximum buffer 0x%x\n", __func__, s->blksize,
                           s->buf_maxsz);
 
             s->blksize = deposit32(s->blksize, 0, 12, s->buf_maxsz);
-- 
2.26.2


