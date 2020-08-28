Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FD3C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:30:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B272075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AFhFyX0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B272075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBaiY-0007Cn-16
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacd-0004Pc-Ta
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:35 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34380)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacc-0004IL-4G
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:35 -0400
Received: by mail-wr1-x442.google.com with SMTP id f7so640715wrw.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=pXn9jEw0LzQcgHngHnQYKyL6TbEOp1hHuZtBzavzb4E=;
 b=AFhFyX0ZeXYCzQuTsP7Sw4MZRVoG57dFOaAUTssBGEW83KVN4HXNPKnI4An/xIkmIv
 1Q8BiIX1wF6MgpF6Bo/6G6u4xVKBGGKu/iGxAbNmPO5xD6XGaYNZpNKTsjj4qxqXMkL3
 BhYjD4hzCaDwnRizYcmODwoAKoA5H3CogOSQ8BXoOy4FxUG3Mgu/xHGBJkaxvBI/zSLZ
 juN7bGUUlj8zju9tPT7ZiprI1huSSvrp/ME/XulybEI1vg6GKXXVTSFIzlkUkXbsUJ6k
 OjYhZlMJDBoQcrJ5Ot1fd5upInXhwWCYprfIJnIG7Xg8I2AUHxl/efMAfmPwHQabo5Zm
 S8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pXn9jEw0LzQcgHngHnQYKyL6TbEOp1hHuZtBzavzb4E=;
 b=WuNMD3Z5O9QL4uHrnTR+Ut+AFOid1PZBmezE0GykhyU+xCCGHcIFoTqSyjr81fy1WI
 WP8CtLSvXpFu8t71Uc7xfZAFxIA5TT3/Ac4JCUqwbVFR/QzeafNkerdiNVjqVM9zGH2g
 dqbTuA3TGb9t6TFgycq8reOobfWNDfR5XM6uUI2L8jwXxsGk8MoqyssmGyZ3wzYdNMFG
 wNN0oRrQ1pC7drIyV0jWJxam4MmkwVVb1O3Nbr4pm30KY2BrTvuVd+kaHmpnE1DhVzan
 krx3d7oK05Tc+E5KvOu6SWa1FrcIzFWPGiv1UR7d02iLDQxuDTGYkExoqm/EgEQkF2YA
 MGMg==
X-Gm-Message-State: AOAM533Hlsp22Yo7ZR7afKqgpRj7ZqbyO/eHo62/+SiiZ+8pobDdZSdx
 Q/0DzU7Ku10t4N8JqVyg4cS+g0Z0+rQ0wnG4
X-Google-Smtp-Source: ABdhPJz6MqxqcixLZhphttw4mUpvDyflaYNzhlfIhJ4s9IxNmQVjMYrdZs7akhnCzeGst4vnaYMizw==
X-Received: by 2002:adf:80c7:: with SMTP id 65mr618326wrl.35.1598606672501;
 Fri, 28 Aug 2020 02:24:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/35] hw/misc/unimp: Display value after offset
Date: Fri, 28 Aug 2020 10:23:53 +0100
Message-Id: <20200828092413.22206-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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

To better align the read/write accesses, display the value after
the offset (read accesses only display the offset).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200812190206.31595-2-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/unimp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/misc/unimp.c b/hw/misc/unimp.c
index bc4084d344e..ee2e536c8b1 100644
--- a/hw/misc/unimp.c
+++ b/hw/misc/unimp.c
@@ -22,7 +22,7 @@ static uint64_t unimp_read(void *opaque, hwaddr offset, unsigned size)
 {
     UnimplementedDeviceState *s = UNIMPLEMENTED_DEVICE(opaque);
 
-    qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read "
+    qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read  "
                   "(size %d, offset 0x%" HWADDR_PRIx ")\n",
                   s->name, size, offset);
     return 0;
@@ -34,9 +34,9 @@ static void unimp_write(void *opaque, hwaddr offset,
     UnimplementedDeviceState *s = UNIMPLEMENTED_DEVICE(opaque);
 
     qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
-                  "(size %d, value 0x%" PRIx64
-                  ", offset 0x%" HWADDR_PRIx ")\n",
-                  s->name, size, value, offset);
+                  "(size %d, offset 0x%" HWADDR_PRIx
+                  ", value 0x%" PRIx64 ")\n",
+                  s->name, size, offset, value);
 }
 
 static const MemoryRegionOps unimp_ops = {
-- 
2.20.1


