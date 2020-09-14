Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC6BC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:09:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5244420EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bfVwdxob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5244420EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHpB5-00079Z-BP
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 10:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp87-00021w-0E
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:06:51 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp85-0007X5-D4
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:06:50 -0400
Received: by mail-wr1-x441.google.com with SMTP id o5so18847931wrn.13
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Wi7+xfZVzT7c72yScN2Btxd8V1LM/R+FBhFAJkMkKkY=;
 b=bfVwdxob97l/yBAtw3n6LmBYpl3VWP/KapbYiDtjuIga473j3dXqRvADr9yr+ZDLBm
 r+bYlnSATV7az8I6e+VvpgLc4cEZewDw1ir7uyBB2e9GtpUyPZJGDt41FP30UkkWjbJ+
 6Lq7nqc931jRVrJ6ZUzOm4CAjgV9volbNpQR45EMDl3w+peRTW+X63qrkPhBKDNAZ2oD
 47DUVsL+xKKMpKtw8esyUERLe+MhKpBg77i6skozg7CSfoXzw21+WAVJKl4co47sAe3S
 OQ8TY5mMjiMr8HaEBnzlTj7iPNZ0VHK4OqbO4PmF10MWtGtnAfUQ+1N+mydwKRn1+NL7
 JUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Wi7+xfZVzT7c72yScN2Btxd8V1LM/R+FBhFAJkMkKkY=;
 b=lIOuo1OpGVPOZfxwyetmWGMgzVqry4kELQ/1t6nLJrgfSqcAcxNvvaFWLsKTGQCzD1
 /e38ZluZRU2kUKCz1cVJ+VrDQbEnOKU4sBFPnz6ajA5NvGdWm3o2JqI6PI/Vus2Yy33B
 OXB/rk+8KoMKJ/oQLDzgQ2a+JLHNx3+d0o4IzHVWNXHkYHNgiGh2wk7pSVgayQnpO709
 Lej74FuzGt5/vGBaFIoQRgxgMXyXB5qvSEFHH6iEB0AH1OJB5vpDEG2tURaDs24bWwXg
 OPusWWuQtAbag2QkVJ0+jCKqcci98aWHMoDedgTyp7UiIS2nY5QJsPOkUVfm8BTNIQbx
 wWsA==
X-Gm-Message-State: AOAM532GZfvJZxgkNM7VBy8mAeKgKrPHynLzjhKRQANrDW/uQhUv1cEC
 ZKXtSriDWAWC5kd5FCAh+lkkRJU0dHdomANT
X-Google-Smtp-Source: ABdhPJzl9QTlqiI+9BrUFniGeUIQI0iyonQtdDQhx88C6hS8zeoFKPo7S7HGgi4g5orz4PD1G6kPSg==
X-Received: by 2002:a5d:654e:: with SMTP id z14mr15987242wrv.400.1600092407855; 
 Mon, 14 Sep 2020 07:06:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x16sm20834041wrq.62.2020.09.14.07.06.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 07:06:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/36] hw/misc/a9scu: Report unimplemented accesses with
 qemu_log_mask(UNIMP)
Date: Mon, 14 Sep 2020 15:06:09 +0100
Message-Id: <20200914140641.21369-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914140641.21369-1-peter.maydell@linaro.org>
References: <20200914140641.21369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Report unimplemented register accesses using qemu_log_mask(UNIMP).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200901144100.116742-5-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.20.1


