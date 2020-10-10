Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B625C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:55:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3208207C4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMfW6z11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3208207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRLtV-00058l-Ib
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 16:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLiD-0000Ta-1O
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:32 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41661)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLiB-0007Rm-Fv
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:28 -0400
Received: by mail-wr1-x443.google.com with SMTP id s9so2061028wro.8
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 13:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TJh7BI4acX0SbBZ5nZKwJOsX7BWS7AOVMyaKy5mLNnQ=;
 b=FMfW6z1188lRehRgoD7J5kOTHv4sgzjppDVAeBuxMdzGtD4wyTrIumM0jpUNen61Z0
 48LJnR2ulM1RfkHRWKjFCMyFI9A4OA8gV0jXt35azTp0oaTHp8F3WVBrZkBqFnMKj2u0
 u1MI+oO+0pOPZ6MsaHu8elE99rx4Swnxti2ftHsbUqLO0M7rdnO9jVr59PM1KS11wC1m
 kho+2lTQsGVUp9Z6b3Cz+m/+bJFNudU312daWSrQSzhnVEpha8BrHV7UaO9I7PFiq65w
 GkCPO4VwIGV9D7760F4xVC3vdX5s00gCnJtojsavJdvy8+mnX912g1p4RSnQrTE5aWit
 QRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=TJh7BI4acX0SbBZ5nZKwJOsX7BWS7AOVMyaKy5mLNnQ=;
 b=hTpnXbsndgK+EAklPO0TdVnUmyaMw+MJ5ZEFYerOs+QMYlCzfpW/few+9dSvnE1h3t
 fNP8YV/ts0gVYSer6UEKfm03t2+kzvSQkvYdWuKIAa8v5ReTJqVQmmfAOMcbC6T2e3Br
 hXnhfMqYs+TphFYAjjgtX1tcj/QOneP6V3g273hCWitHfrCHD7YZ5yVc3JCh5/6QFTLd
 uOELQ58u3F49RInqR5qTCIQp/WDNtzkWFWitz7zvkQQ/qeBlVBCCThYd0mteGN1d2zu6
 T4ysJj6ROEbZETzOcjrPG4rbmqgiH42u9piBi+EJ8SqozG58CwRKIm79rcUfEoJnJYhY
 +MNA==
X-Gm-Message-State: AOAM5325Te9tCoBQIhimRrbleKyYlpKD9mys+T7KHZo8tJCfG3hFmpgA
 WWONDw+b+y2ZQutn3tXjhoOAOGW8mds=
X-Google-Smtp-Source: ABdhPJzG5RfvOrjAj977eltUm1J+wtBCSu3E/HxEX9DZtzLk0gnvDEjBvq9AtqEc/z1pjMMSb3qPLA==
X-Received: by 2002:adf:f709:: with SMTP id r9mr21973258wrp.266.1602362605953; 
 Sat, 10 Oct 2020 13:43:25 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 205sm2705471wme.38.2020.10.10.13.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 13:43:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/20] hw/qdev-clock: Display error hint when clock is
 missing from device
Date: Sat, 10 Oct 2020 22:43:02 +0200
Message-Id: <20201010204319.3119239-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010204319.3119239-1-f4bug@amsat.org>
References: <20201010204319.3119239-1-f4bug@amsat.org>
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
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
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


