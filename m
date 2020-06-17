Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044F9C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 19:22:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45DF208D5
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 19:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPAlcmlC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45DF208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlde5-00085R-34
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 15:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jldX9-0004Za-21
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 15:15:39 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:34018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jldX7-0006Uc-El
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 15:15:38 -0400
Received: by mail-ed1-x543.google.com with SMTP id w7so2976176edt.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 12:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nrmkQ/EOlQRnkklRoevO7IWC+EItEHCLWkyyjykQYg4=;
 b=dPAlcmlCz7Pmgi2aakpkHlSsPjaF1Tv31VreSx/DlOR8VyG5i93rcYanKb4p+G5ueR
 etKJo4urUUgAYCOKb0Aj7hOAfoDgkYBBm5yK94RtV+07NxCq4F4n98CmTXQPkzQTh6z1
 Tiprcx5Do3df1ObCYEbtiGRHO+pN2ojN0WJxuPthWZupoCe2855jycq/dQaA5XI5C7bg
 gb0CiLHlZrldnLVKMYrSRDRiM8IMF3xThuT0KdmOSmRJh+p2IrlEYRPkBDaQsRRyCqao
 +I4voT0gKEHZC/H8E28h4IaCGtCM0fqPpyDJ0WGfBcP1yGZPPmEXSZjbXQpdGqSZq1XN
 VO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nrmkQ/EOlQRnkklRoevO7IWC+EItEHCLWkyyjykQYg4=;
 b=Wc1ZCOgluHE6paIrfOEQikivAvtH7xw/YRAP4/AHBGwEDgNQUX5ifjcGwg5liyzjsl
 YSXDJKJKvad3NsHx6VSlBgIHqBwyMAs+Pgf7sRriTJB14ym97Iclyh+DdDEV4WdggFqa
 FTF3WKhKh89dmbpMy8izFtNeT3dbWF5deOrdBgGTiSBJuoatnKXaeNfCHvPpS9R04Gxb
 VcMn63bIZBsda/RqWKjbJAz6GOIWa3hjbRC0qCom1RoC12S5/KLLE1LM+4p8JSNv5Lbl
 /rPgqntBOi0xg4UJBubpPNbVMFubZloXChDLx26wr8EjlmMVcZ8W3jwmMjZg1uQ5ZllJ
 oZuQ==
X-Gm-Message-State: AOAM530vK6ffbuJaU6IR821qZfSDYa/GzRkoHh7NBlm/UZfZRNPjCNk1
 6Bq179jt4Flg0BPDWZ4TVms=
X-Google-Smtp-Source: ABdhPJyiTeYMN0vlMNUzpAW5RSoN6joIme0/7LTyKKlYqL8L3wkPODSoLWL4B51GXhqygyrtDsA6xg==
X-Received: by 2002:a50:f1d9:: with SMTP id y25mr631175edl.292.1592421336156; 
 Wed, 17 Jun 2020 12:15:36 -0700 (PDT)
Received: from x1w.redhat.com (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id y21sm324308edl.72.2020.06.17.12.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 12:15:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Richard Henderson <rth@twiddle.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
Subject: [PATCH rc1 11/15] hw/rx: Honor -accel qtest
Date: Wed, 17 Jun 2020 21:15:15 +0200
Message-Id: <20200617191519.14842-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200617191519.14842-1-f4bug@amsat.org>
References: <20200617191519.14842-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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


