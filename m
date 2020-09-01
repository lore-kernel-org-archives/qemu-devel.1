Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668B2C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:07:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D62C2137B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7cuozSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D62C2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7sM-0006fe-8X
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD7TE-0004Kn-MO; Tue, 01 Sep 2020 10:41:12 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34121)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD7TC-0008SW-QO; Tue, 01 Sep 2020 10:41:12 -0400
Received: by mail-wr1-x443.google.com with SMTP id t10so988030wrv.1;
 Tue, 01 Sep 2020 07:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/0CItXRpsjbnSZbfizzT7hsK4ATPfYOi35n7IOshX5M=;
 b=o7cuozSmNCtHclFzjtvLc+2uq/AH828HkMYG9Ib4urkGyXXrjBmIC94PEzxRVPFlIc
 uR8ZhLKi3t039gT4bAzFhwN1pd7UF6RgJoSc6znVg0FQfbLSur3e/NinKIgt/ynG7DOh
 KfecV5gm4ZfRZ0iUxJ4H4Rl7c0Atv78JJMfpO3DQ+QgFl4EthmGCnZ3++enRWd7120nz
 uC2WwMHzhHkW+RW4sOLdqjojmxPeNsudKn712JlQMK3sfIQHnt6PHH5RSXg1dh5VasNg
 zHJ48UJFESDed8Us5pTtinmkOlGsNJ0RSCjKSzq3pEG3McpA1f/afMN7yfbi2K10ZK2T
 bhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=/0CItXRpsjbnSZbfizzT7hsK4ATPfYOi35n7IOshX5M=;
 b=Tu1zFg7b9YhKB2RxoymIizbctVsXRc7vBtR8LNCpI1awXROI7Vt7ps2RcUpFQbWb67
 22k5dKMn3irGVfXaaK0HQX7qP6J9TykrDcdzQ1iBchbeeoE7rws2PuPAO7wDmIzkbeZo
 2nxxI4l4XLKt9JFt0M5UFg3WyNCN7VZTkFI/Mp/ZVzoca6QLtLQj47uZk7FUKwQ2bdAs
 LC34iay3PjMT8Fw+H4507pKaYnWZjcB0bGYMCEpF/GzcM3h4nMMmS7nmNJXiwQAKhWM+
 qmsWzMJNkJYso3VAupV3iGS9HiHiuBs2hAVkx1UZmb7Z5linitQZkSSOxdbDqzVZII5K
 F7Kw==
X-Gm-Message-State: AOAM531WUlv21WTUanzrGCHI7HhhlxbBz2Sjy7PfB3KH+VT7rFf9HxK3
 B22dc73Or0AmJMjhsK0skC9xcJqfd8U=
X-Google-Smtp-Source: ABdhPJyu703r5xF86dtH6sAH1kZE6X0yeRaqx/Eyd4WkwcnimUOmnbnFPwY54NonX61jR2xXXHiNtQ==
X-Received: by 2002:adf:aad1:: with SMTP id i17mr2433806wrc.360.1598971267766; 
 Tue, 01 Sep 2020 07:41:07 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id a82sm2213204wmc.45.2020.09.01.07.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 07:41:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] hw/misc/a9scu: Report unimplemented accesses with
 qemu_log_mask(UNIMP)
Date: Tue,  1 Sep 2020 16:41:00 +0200
Message-Id: <20200901144100.116742-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901144100.116742-1-f4bug@amsat.org>
References: <20200901144100.116742-1-f4bug@amsat.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Report unimplemented register accesses using qemu_log_mask(UNIMP).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/a9scu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/misc/a9scu.c b/hw/misc/a9scu.c
index 47f948341f7..a375ebc9878 100644
--- a/hw/misc/a9scu.c
+++ b/hw/misc/a9scu.c
@@ -13,6 +13,7 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qemu/log.h"
 #include "qemu/module.h"
 
 #define A9_SCU_CPU_MAX  4
@@ -38,6 +39,8 @@ static uint64_t a9_scu_read(void *opaque, hwaddr offset,
     case 0x54: /* SCU Non-secure Access Control Register */
         /* unimplemented, fall through */
     default:
+        qemu_log_mask(LOG_UNIMP, "%s: Unsupported offset 0x%"HWADDR_PRIx"\n",
+                      __func__, offset);
         return 0;
     }
 }
@@ -67,6 +70,9 @@ static void a9_scu_write(void *opaque, hwaddr offset,
     case 0x54: /* SCU Non-secure Access Control Register */
         /* unimplemented, fall through */
     default:
+        qemu_log_mask(LOG_UNIMP, "%s: Unsupported offset 0x%"HWADDR_PRIx
+                                 " value 0x%"PRIx64"\n",
+                      __func__, offset, value);
         break;
     }
 }
-- 
2.26.2


