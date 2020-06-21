Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC7BC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 12:57:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F52F248E7
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 12:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUbUvZQP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F52F248E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmzXg-0003au-Ie
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 08:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmzOd-0005JJ-Cs
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 08:48:27 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:43655)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmzOb-0002rQ-PX
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 08:48:27 -0400
Received: by mail-wr1-x42a.google.com with SMTP id l10so13990588wrr.10
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 05:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nrmkQ/EOlQRnkklRoevO7IWC+EItEHCLWkyyjykQYg4=;
 b=rUbUvZQPRK6l8ahNcHix5CVlOp7Kg4tqkpKQU9wggMl/8GGaYlCj/phzi+DnehhOaV
 zbJcbjBXo4YKEQWRkqkCxZpjWmvaMSiV22+Pbj+Q7p8Hh07qEgInGrVqn1KaRpJCQW6P
 hoEKswRBKoX8XPLSMHi/jNXf4V36JitUTVesn3ZcPWJQTJlVd1WRbSO8L8fkLj1C2/l0
 I9TT/blOSQo4DsjvfSW8F3j2MaWwHSzFg9jFaWdhk5lby4ezRUOv7ofnd7IQoG61Ect6
 NKNj/IYuP4ElNBViH46q/ZhqpnRtqPto4GHw1J+vRmBO8LCq4XN2vXsOI2M+uLvYhvmT
 TQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nrmkQ/EOlQRnkklRoevO7IWC+EItEHCLWkyyjykQYg4=;
 b=ugvVI3VSBvAhTCDKitC/xTys4M6chOMzrOks49cdxuosnRtFzaDZBFEPSjpQz5WKuR
 wXW4LRb24IYEMcINZ4m/1rMi+BASX3wAuc66kV0/Bx87xq6z9Ph4jnO7EZ0UYPWSKUcb
 GwanjmJqCU90pHpjv6SqTIciCRXs0NF6Ee3Fi95JhXgiouOIRbNTnSPCDw4HugkWpkcA
 IH0Ow8eFoZT7fn+PW/MS8U5Q22sLRnf89elVPk7YO0s49KNPKDxPI9aW5t/x2+h/LT4W
 nL5F33euGGsodJP5tU03fS9ZuWy9qS8/6cLDmKONpunWG4wfJGlAnFgFtfY0TB3Dyza9
 mTgg==
X-Gm-Message-State: AOAM532BavsmpCmzd6Rfn7G7xzBrWVem6lU5VgvT0LpCaYW+d22/d3OS
 DSunEGXJ6Y0YT1n9TSRpsgrYbR5G
X-Google-Smtp-Source: ABdhPJygkObZExsXC4J7rxg9bU+HAguStLMr5Tj6vClRVrhx0lIBcbimmIkB6C4gNvrs/j5X6aA21w==
X-Received: by 2002:a5d:5647:: with SMTP id j7mr5734779wrw.242.1592743703981; 
 Sun, 21 Jun 2020 05:48:23 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id o10sm13779362wrj.37.2020.06.21.05.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2020 05:48:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/15] hw/rx: Honor -accel qtest
Date: Sun, 21 Jun 2020 14:48:03 +0200
Message-Id: <20200621124807.17226-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200621124807.17226-1-f4bug@amsat.org>
References: <20200621124807.17226-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42a.google.com
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Issue an error if no kernel, no bios, and not qtest'ing.
Fixes make check-qtest-rx: test/qom-test.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190531134315.4109-16-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/rx/rx62n.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index 85b7770023..d8f0fa4625 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -21,12 +21,14 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/rx/rx62n.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-properties.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/qtest.h"
 #include "cpu.h"
 
 /*
@@ -208,7 +210,12 @@ static void rx62n_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(s->sysmem, RX62N_CFLASH_BASE, &s->c_flash);
 
     if (!s->kernel) {
-        rom_add_file_fixed(bios_name, RX62N_CFLASH_BASE, 0);
+        if (bios_name) {
+            rom_add_file_fixed(bios_name, RX62N_CFLASH_BASE, 0);
+        }  else if (!qtest_enabled()) {
+            error_report("No bios or kernel specified");
+            exit(1);
+        }
     }
 
     /* Initialize CPU */
-- 
2.21.3


