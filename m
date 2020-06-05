Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202B1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD7422077D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vhXk41YN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7422077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFaI-0006Pq-1s
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFXs-0001BI-5s
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:16 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38728)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFXq-0001dy-MH
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:15 -0400
Received: by mail-wm1-x341.google.com with SMTP id f185so9782452wmf.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 09:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=2W0hZmJmprXTXvmQPYEl3pMM+b1VTyiikXeZP4VVDCo=;
 b=vhXk41YNLDta19kH6i1sDaAlHGnb/sY7HtNDvgflsmmZ+DwdXqdmxtwFyYQinUPqXz
 rm/8MWHlpPQjGuIWUUY9vl4wWnC9uBliua+TYah/yYBzidTzVL2KEsA7ApHH1MZJVAcU
 5/uG0rDJB9/wSSkzZQ46ioFPT4TD5Xzd2VRtxSqhZ9Ir+8gwOrJkrR5vZZSMNPg+Jnmr
 s0TDrMVvVE0pfdv/R3brWC8+r5jshs74ZyhaPq39IuW/2wqnEetC6PFavujQByTDntJo
 RGRzRVDs11RinleYOLBOY8rrG+lO8gG6RuHdcOuwGDcN6C0SD3GwWbDSLgOVowubyQ1Q
 dYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2W0hZmJmprXTXvmQPYEl3pMM+b1VTyiikXeZP4VVDCo=;
 b=H0fCA9RZdqk7Ka1pbqQKRKrtmi8aQzX7B/S2jTfkxTaZvVfXCY0t6gt0gVfCd1OUC9
 QbVinSJ8hJqr7Lww7LSJcYVYntKBOqe6Rw6pxWt2BKjyGJYGlmF3RPcZ95BNXgDpf8JR
 eRdIXT3XbQuXP5RXc4tCQZPBISUwL6BRFz8yCFxZu+oaO3pdjY4EYKmH/yeI/PP6hW7h
 K485RxzJWMuxeeMqjtT11y6ZWNUQlvkOoSD0cfyawApwITkoD4O/CVCDydeTfTjuz2YM
 pms48bs/QmF3wCqU6RxO19hsrbQSIwn5+iaKJZdsFzg7WA79bCVETbaFTip/ZsbvQJhe
 Z9ow==
X-Gm-Message-State: AOAM531CYpgTpBVgs20xn5EQZJpjw5noALtMwKv1WvqGWStEfKa3Dk2M
 B8O0bK/3EAotHZWZ+ewcejjxVXQZ23mUyA==
X-Google-Smtp-Source: ABdhPJxMEr+ZnCLOe7lWNNjTnd9p5hxs+luGWp8KGC+x9tAWGBlJSUQycZaTMo4KQtq+lfAQ/z4cYQ==
X-Received: by 2002:a7b:ce88:: with SMTP id q8mr3533881wmj.176.1591375812952; 
 Fri, 05 Jun 2020 09:50:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c140sm12272724wmd.18.2020.06.05.09.50.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 09:50:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/29] hw/input/pxa2xx_keypad: Replace hw_error() by
 qemu_log_mask()
Date: Fri,  5 Jun 2020 17:49:41 +0100
Message-Id: <20200605165007.12095-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200605165007.12095-1-peter.maydell@linaro.org>
References: <20200605165007.12095-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

hw_error() calls exit(). This a bit overkill when we can log
the accesses as unimplemented or guest error.

When fuzzing the devices, we don't want the whole process to
exit. Replace some hw_error() calls by qemu_log_mask()
(missed in commit 5a0001ec7e).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200525114123.21317-2-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/input/pxa2xx_keypad.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/input/pxa2xx_keypad.c b/hw/input/pxa2xx_keypad.c
index 31862a7d16c..62aa6f6b15a 100644
--- a/hw/input/pxa2xx_keypad.c
+++ b/hw/input/pxa2xx_keypad.c
@@ -12,7 +12,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/hw.h"
+#include "qemu/log.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "hw/arm/pxa.h"
@@ -233,7 +233,9 @@ static uint64_t pxa2xx_keypad_read(void *opaque, hwaddr offset,
         return s->kpkdi;
         break;
     default:
-        hw_error("%s: Bad offset " REG_FMT "\n", __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
+                      __func__, offset);
     }
 
     return 0;
@@ -280,7 +282,9 @@ static void pxa2xx_keypad_write(void *opaque, hwaddr offset,
         break;
 
     default:
-        hw_error("%s: Bad offset " REG_FMT "\n", __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
+                      __func__, offset);
     }
 }
 
-- 
2.20.1


