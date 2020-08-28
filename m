Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB00DC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7694E2075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RProm81H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7694E2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBakL-0002Fm-ML
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacc-0004Lx-JR
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:34 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:53840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBaca-0004Hy-VT
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:34 -0400
Received: by mail-wm1-x32e.google.com with SMTP id u18so294082wmc.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=d7gcMoXpU39ijrdTiJgkd9oKx1sM3y9iLjYpjdy3fPs=;
 b=RProm81Hmb1uSQSHR5BCSY8hn+ehajNFxAph8Nn2e5sp4FrTVYYYK1kksZLPJlnhju
 4qQQ+1td1spKMqLxaGUYXNqQHOpG//B8iU7OsJgX6vz99dgwJhc5Fnw1iFYWa2a2UGBP
 84V5rEhf1iAvb3MtYiW7UVlhax6Btp4dipUV+BjFjucaJTqlQkCl1DROE9pNZ+wirBMk
 5e9TX+moBlMY7agc7dX926VtcGLkpID7R9X46Y2dW3cYgA64Q3SvieCm8FRnlL85prgw
 D0Br5oT1aFMqKdNhe17AyWtrZEAL0tizeELXoEisxq8dazpaXO2nmbt6eHQD/c8AHd3t
 nkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d7gcMoXpU39ijrdTiJgkd9oKx1sM3y9iLjYpjdy3fPs=;
 b=DprumQgirkNrWIuzZ8RUO/xFllWHJS92rSTtU3n7Jupoj2KhLOyKk8i87U/B6sJDnM
 sS3JWTvuynHuwTFnNSUBNmAkVLaoV8ojCPjJLyub9tPXZRSCI7bEpUirh0JvpOhRq0tO
 jqwKmfH9bKYhI5IgAXgna1yoeZC8WQO3cu2A6xI3zOuMQowzuSj0oogOWeo9QRkzmsQR
 5B+8VAo7R7zT3v5HQze8WpWNTltN5+J0PZQWxHSPDtS5umn3w3bGagEgg6vz3024yw67
 9UIlapQhFprc/5i/xaT2KxcgiAlLcZgPoGoTyO5NzT6vDldPU0PuQf3YuKiDE9YJOwSS
 6+yw==
X-Gm-Message-State: AOAM533XfwJDhq9TT0R3ivWlYKGO2AIM2x/ZQ7AfBh2zNEBWWAjL69dp
 X4QCFg4OkYXsJaHJgm+iqlt8y6sLEl3T7Hmh
X-Google-Smtp-Source: ABdhPJx+rzz/7MvqSMUKdAjEtXe+IICJZyLftyHeMOcripUCnosdBzT7fWwOQMFZWYwu7lOCRCXhKw==
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr743899wmh.144.1598606671444;
 Fri, 28 Aug 2020 02:24:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/35] hw/qdev-clock: Avoid calling qdev_connect_clock_in after
 DeviceRealize
Date: Fri, 28 Aug 2020 10:23:52 +0100
Message-Id: <20200828092413.22206-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Clock canonical name is set in device_set_realized (see the block
added to hw/core/qdev.c in commit 0e6934f264).
If we connect a clock after the device is realized, this code is
not executed. This is currently not a problem as this name is only
used for trace events, however this disrupt tracing.

Add a comment to document qdev_connect_clock_in() must be called
before the device is realized, and assert this condition.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200803105647.22223-5-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/qdev-clock.h | 2 ++
 hw/core/qdev-clock.c    | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/hw/qdev-clock.h b/include/hw/qdev-clock.h
index a897f7c9d0f..64ca4d266f2 100644
--- a/include/hw/qdev-clock.h
+++ b/include/hw/qdev-clock.h
@@ -70,6 +70,8 @@ Clock *qdev_get_clock_out(DeviceState *dev, const char *name);
  *
  * Set the source clock of input clock @name of device @dev to @source.
  * @source period update will be propagated to @name clock.
+ *
+ * Must be called before @dev is realized.
  */
 void qdev_connect_clock_in(DeviceState *dev, const char *name, Clock *source);
 
diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
index f139b68b881..47ecb5b4fae 100644
--- a/hw/core/qdev-clock.c
+++ b/hw/core/qdev-clock.c
@@ -186,5 +186,6 @@ Clock *qdev_alias_clock(DeviceState *dev, const char *name,
 
 void qdev_connect_clock_in(DeviceState *dev, const char *name, Clock *source)
 {
+    assert(!dev->realized);
     clock_set_source(qdev_get_clock_in(dev, name), source);
 }
-- 
2.20.1


