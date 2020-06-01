Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8122FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5184B206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QE9DzSid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5184B206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfnDS-0007Ou-K0
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 12:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfn5V-0005MQ-Ne
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:14:57 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:33644)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfn5V-0001X0-0E
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:14:57 -0400
Received: by mail-wr1-x42a.google.com with SMTP id l11so445940wru.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 09:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+dT4hPe13b2V1KUy+9YeeyPPkO3c2tsutvWPTSNqBlI=;
 b=QE9DzSiduZZGcx+EVRldlAhiQa2yGvSqgoiQeNN/i0r9TyM+zD4EznYZizywXAlqNT
 QC9kdu58She2A/GFmw3V3leLugCCA08ri/3Y43mSLzmThC6lhcLumKlNdZIeNdtmFbfg
 kEZbi+L1Vl/OjMheFi1e4fA6wp+f+JLaq0plk1/d9I8KTfS8dWrPvz+CmwrNs/r/iepC
 DvIqWd45O+pbH+fNrJ7c/Q5HhnrIn+wlxeiRZL/LQ9TxK18UpXI8nyDkLu1d7fEgfVez
 sM3FJdsO+3FO8qzZSFwsMxqRqdQGnaVPq6v+YjEQFtwyl/mZjb7rum4Bkyqb+UyudE51
 DiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+dT4hPe13b2V1KUy+9YeeyPPkO3c2tsutvWPTSNqBlI=;
 b=Tcg9KdpFLR5gl6HvxUwMgLhtmahpcm0/9MooFbv6lPcZFtj27BFR6DUVMVnuPrSFlT
 JJbrySVHIyHN1x12kiLD63triWxw4CNVsNJL0G1kiVShOwZVUEMz+h9aY6rQR1mOEYJf
 N/5RGDcjSo2Wc8wTnh9zftWucH3cAOmjkBGHpIs1UmM2ssye9TeP7DXbyUZB/qcVlbfv
 QrJ0kxdw3vfn8UT4kae21yJRsciPZpov4GJVydUd2wsq9fffU49Zz0NqZOfbZcse0w/X
 nPUtCA3/IWdp5+PxSWFpWtZvbZ2d7UYYuvlf3hUfemgeJFShppGy4Rr4x/aFeMML2szy
 PdEw==
X-Gm-Message-State: AOAM531bQVfvjMuVj83vpPoa8Ut+J9eScwBMTQpVxk2Kbq1eNJpMMh4Z
 Ri+rNt0NSNKpzMZpQmTFZIE=
X-Google-Smtp-Source: ABdhPJyuoIWDg/IRINEo8r6FQ7gqfZVoXKVRznkQ6d/rPItPOCKaCpm7gZ3MuGTBrnroTDBSOGYYSg==
X-Received: by 2002:adf:f450:: with SMTP id f16mr10793564wrp.307.1591028095675; 
 Mon, 01 Jun 2020 09:14:55 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id a6sm21309896wrn.38.2020.06.01.09.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 09:14:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 08/12] hw/rx: Honor -accel qtest
Date: Mon,  1 Jun 2020 18:14:37 +0200
Message-Id: <20200601161441.8086-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200601161441.8086-1-f4bug@amsat.org>
References: <20200601161441.8086-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42a.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
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
Message-Id: <20200224141923.82118-19-ysato@users.sourceforge.jp>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/rx/rx62n.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index 13c90102b1..92d215f07a 100644
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
@@ -217,7 +219,12 @@ static void rx62n_realize(DeviceState *dev, Error **errp)
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


