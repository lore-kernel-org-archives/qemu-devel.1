Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9A0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BACF92074B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uZWKnxaR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACF92074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj8y6-0003Ml-RM
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 18:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jj8uT-0005wi-BQ; Wed, 10 Jun 2020 18:09:25 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52707)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jj8uS-0008IE-Hq; Wed, 10 Jun 2020 18:09:24 -0400
Received: by mail-wm1-x344.google.com with SMTP id r9so3239103wmh.2;
 Wed, 10 Jun 2020 15:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fCWXr6zHNQbQPJ8BLLwrAx76MymcZFD1NlfKOZXdkr4=;
 b=uZWKnxaRDpKGzUjo9WJF4UAfNQeHO8Pr6Nu3oUn/eU7p4YeGVkVwVh71HpuWF1AEJa
 BYWQ+lHAGNzmvyINp2MR+Ew/EJ8Kt/RQHSsBH/tXvwcRUTy4R+JLEpXO8oTGjOu807Rt
 Xx0RUavFJeGzcbbvIOFztOGEKLNahigIMPzyGjUx7r4YmVtcYEgg5dTMqZGqxZDTALG8
 kC7gelvuZ0oAg8WtAbFYgZwJTiGgLLGmNlW+QVMsQLCrw4pj8hc0/yfteibekUT9zq/+
 Jn0acq/ULpN9nugW/f6UVdG7T+6Mdv4kdys0pbA8/3A+GQ+eZK++OM1MLao97ZYpnX/t
 lweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=fCWXr6zHNQbQPJ8BLLwrAx76MymcZFD1NlfKOZXdkr4=;
 b=E8lt/lC1ZfFy639x/5hp/2LxNqCcPmFNoMEmbuqPo7slHfBq1pw73cmPZbCFpJvhvV
 lmUYp8in8mWP8rO+NL6W9LZ5VJs0GFvSFaLPcVFzHvdnzeP6m3OTybqyk1FS96kUYWp1
 eliR0JBjADYi01fp2i1Qmeh2LDuSGNC74rM6H0pu6IL7n6X7+D5RyEiMVLDrR+pZpy9m
 FMKvvhl3ku2pXJIQrlA8bbKdDyJP9nPt/8urSGO/ArVePjhJp40FFeKza8jYRpM7MZnx
 98/bd41hoRBV864OROPILz+osKBUnrW9ukg0nARuQMTwv4xctdtDfDHWbIx2wZiIZVCj
 FDKA==
X-Gm-Message-State: AOAM531hcJ0z1pvvXa5LBKXgLRkl5iiaejcozEhwI7p0uCVKxhAQqiNH
 VSBRO3zzy6iTLrNQR5NQaEiGGYUv
X-Google-Smtp-Source: ABdhPJwQx0tWiic5WPjQpeO61Qydwb9ShWvGEbP5yjG0ZsbvDXvSevcXlNSWgkKquz7g2Ph9LIlNzg==
X-Received: by 2002:a1c:6244:: with SMTP id w65mr5031214wmb.82.1591826950036; 
 Wed, 10 Jun 2020 15:09:10 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id 40sm1819354wrc.15.2020.06.10.15.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 15:09:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/11] hw/timer/sh_timer: Remove unused 'qemu/timer.h'
 include
Date: Thu, 11 Jun 2020 00:08:51 +0200
Message-Id: <20200610220853.8558-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200610220853.8558-1-f4bug@amsat.org>
References: <20200610220853.8558-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove unused "qemu/timer.h" include.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/timer/sh_timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/timer/sh_timer.c b/hw/timer/sh_timer.c
index b9cbacf5d0..bb0e1c8ee5 100644
--- a/hw/timer/sh_timer.c
+++ b/hw/timer/sh_timer.c
@@ -13,7 +13,6 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sh4/sh.h"
-#include "qemu/timer.h"
 #include "hw/timer/tmu012.h"
 #include "hw/ptimer.h"
 
-- 
2.21.3


