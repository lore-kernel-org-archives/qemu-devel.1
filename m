Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9C9C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 09:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D484A208B6
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 09:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lv/TS8qX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D484A208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRucK-0001eH-R6
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 05:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRub3-000073-Tu
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:58:25 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRub2-0002mj-FF
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:58:25 -0400
Received: by mail-wr1-x443.google.com with SMTP id n18so18449898wrs.5
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 02:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TJh7BI4acX0SbBZ5nZKwJOsX7BWS7AOVMyaKy5mLNnQ=;
 b=Lv/TS8qXfKMzJ/M5MTqQnDSBHyFa/kR9hoBDRvrMI2cQvbPYn31Edq06Bm3EWtv48+
 0M76UiLbhag+d076czV/DZ+ayKJibzozlXLouFgVCjHovGIKYEK9Ah2ilqtxP2yuPcRG
 HlceeovwbvKH/DGLaxOt9ohL9u5fIwfG3PtUfBssQ/SaT4jRhk9OaDU7jpdm6w3F5KzL
 KAIrDn30q2crj2zOgPHOiQ60MK/3UPBSasWrU6XN8c4EH9oFmrbhNSnN6t55YEk81obk
 gFmztb6lcEhAcxGqIoZA+sE7Y0N/fKygjrIg4yktezJJsGc5vAcH4v8jGmSkCx5SYHho
 lGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=TJh7BI4acX0SbBZ5nZKwJOsX7BWS7AOVMyaKy5mLNnQ=;
 b=Oeukc1dUmEMNT9Yo5tbkwaRDaKkPt+7PLHoEq173DXUbCDnNpWzVWbQDNgb/JkcpGI
 GoXSm3wgS25/arh0Wzka+e32F6OQU2uTA+2pGRcde01Ov+Xv78VqK7Dbp/oA3jtqUcJW
 WtDGKKDAhYMMNKO0pbnw2waIK1FHaisLdvzcbEDA4UFVG5BlJarkiu0OZrYz0sT8tvNR
 WLA/vlyp32cehmLGUzMNcCl3f56ZbnkXFFNsXKLqMQ1yxlO970rT2Yr7VPHYwIRAqDPI
 ILkAPSIur97RnLahnAfVE8MfGByD0mOmMDYpbgGfwiYC3KgIDQibwChjBNplKARKEsOM
 TwnA==
X-Gm-Message-State: AOAM530Dqw2X1KoqNAoU+l/XbbwOFN8RhVLHI9aGEJycgrcQt79fw1Rx
 VkLFbbVqb6ScuVhVLxExV+P5SiGj4Sg=
X-Google-Smtp-Source: ABdhPJyoip+VpcdQ3F2bsI/C2YIXIjphJ0CcPY4vT2U2ISF0ShBapLCJdr2xL6wMl/FH6EK9dmUavQ==
X-Received: by 2002:adf:9d81:: with SMTP id p1mr28048520wre.13.1602496702949; 
 Mon, 12 Oct 2020 02:58:22 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id b63sm24768438wme.9.2020.10.12.02.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 02:58:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 03/21] hw/qdev-clock: Display error hint when clock is
 missing from device
Date: Mon, 12 Oct 2020 11:57:46 +0200
Message-Id: <20201012095804.3335117-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012095804.3335117-1-f4bug@amsat.org>
References: <20201012095804.3335117-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of directly aborting, display a hint to help the developer
figure out the problem (likely trying to connect a clock to a device
pre-dating the Clock API, thus not expecting clocks).

Reviewed-by: Luc Michel <luc@lmichel.fr>
Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/core/qdev-clock.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
index 47ecb5b4fae..6a9a340d0fb 100644
--- a/hw/core/qdev-clock.c
+++ b/hw/core/qdev-clock.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-core.h"
 #include "qapi/error.h"
@@ -153,6 +154,11 @@ Clock *qdev_get_clock_in(DeviceState *dev, const char *name)
     assert(name);
 
     ncl = qdev_get_clocklist(dev, name);
+    if (!ncl) {
+        error_report("Can not find clock-in '%s' for device type '%s'",
+                     name, object_get_typename(OBJECT(dev)));
+        abort();
+    }
     assert(!ncl->output);
 
     return ncl->clock;
@@ -165,6 +171,11 @@ Clock *qdev_get_clock_out(DeviceState *dev, const char *name)
     assert(name);
 
     ncl = qdev_get_clocklist(dev, name);
+    if (!ncl) {
+        error_report("Can not find clock-out '%s' for device type '%s'",
+                     name, object_get_typename(OBJECT(dev)));
+        abort();
+    }
     assert(ncl->output);
 
     return ncl->clock;
-- 
2.26.2


