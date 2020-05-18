Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA24C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:55:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D90D22070A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0FQv5iP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90D22070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jacUQ-0007ml-3Q
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 05:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jacRP-000344-S2; Mon, 18 May 2020 05:52:14 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jacRP-00017b-9S; Mon, 18 May 2020 05:52:11 -0400
Received: by mail-wr1-x442.google.com with SMTP id h17so11020862wrc.8;
 Mon, 18 May 2020 02:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pY7ifqJ3Le7BSTemy3hxz4uP2Q82R0++sumXW6Rj3rA=;
 b=Q0FQv5iPFzXNoTIkx3rArVMrJBp9YaU1FQT8Zp8Fd2LJXYuuSev4FQjM/DBm1afFST
 FavBwDCY1ZWC3tKSMNVYMH0fbWnXiRqEK6D7fGZukA5JViE1mkEA+Civ2/oBiEzbBjZI
 BRSY7iACTjQo9Fac964wsCXnlCIZX/J+xv4CUIXRPxtvdi8E2SYbNsLBk2gfSfivlKSC
 6BiwIt7yxcuRX01P+vR8T0nZaGAUEy2RD4Lt2x3RsgFJasovFALkrvsxuZ/DJCGNlaOi
 jTvDjb4v1H1bqWSKrLcjhBB0ag0h/b7bo5AofWCI4U6rWXAZjroBukw5L8Aydo7ZtG+n
 eR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=pY7ifqJ3Le7BSTemy3hxz4uP2Q82R0++sumXW6Rj3rA=;
 b=aBYJr+0cGeytbdgoXL6CWC1FAXnRb0D0C67kzXoDIyWvTHwoaMlg39cVyQ7bdz7lUR
 Q2N7nIbFvkmBss/BeThdtFI1hd1Wp87CAwoOQ3ce+Rz4+VsNuwa5ETMpvDiBXivBtR6h
 dNfFIeVhwRwdNzUpx+P9xORNgS6i8PLrhKNd/GLN0UW222IFe6Y5lEX2m6UL4E2A4ViP
 Z04z4m1HS1WMeepObhWI1FEd0bt05GXy5i9LHHWZtmo3UjwopPMRNpn0NxGyMtMGM3q2
 dMP1v7ma5F4pMtCINoy54o9g/rzY5bltc+RJkwudx3utk6IdTJU4LUenXeIwWojre0cN
 HLYg==
X-Gm-Message-State: AOAM530O36As4prfKDuiKhxkpQ9sE+nFwGpUvaZCXVoKagYVDs8qcAw2
 tQLGwgD9GexE0Is9nV6xlnavzd98sC4=
X-Google-Smtp-Source: ABdhPJzgBJlbj9iXgoaztLMj8L2GdYymlyW+Fi1nq91Owdam8CW7ErVn7rurUL8EorUzjjvZT0vlEg==
X-Received: by 2002:adf:a118:: with SMTP id o24mr18278839wro.330.1589795529501; 
 Mon, 18 May 2020 02:52:09 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id r9sm5453542wra.52.2020.05.18.02.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 02:52:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] hw/char/xilinx_uartlite: Replace hw_error() by
 qemu_log_mask()
Date: Mon, 18 May 2020 11:52:02 +0200
Message-Id: <20200518095203.1013-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200518095203.1013-1-f4bug@amsat.org>
References: <20200518095203.1013-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hw_error() calls exit(). This a bit overkill when we can log
the accesses as unimplemented or guest error.

When fuzzing the devices, we don't want the whole process to
exit. Replace some hw_error() calls by qemu_log_mask().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/char/xilinx_uartlite.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index c6512285d7..ae4ccd00c7 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/hw.h"
+#include "qemu/log.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
@@ -135,7 +135,8 @@ uart_write(void *opaque, hwaddr addr,
     switch (addr)
     {
         case R_STATUS:
-            hw_error("write to UART STATUS?\n");
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: write to UART STATUS\n",
+                          __func__);
             break;
 
         case R_CTRL:
-- 
2.21.3


