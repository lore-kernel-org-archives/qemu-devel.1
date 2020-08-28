Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0739C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:30:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F64F2075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u3affaXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F64F2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBaia-0007Jg-Pk
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacc-0004K9-16
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:34 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:35211)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBaca-0004H0-0v
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:33 -0400
Received: by mail-wm1-x335.google.com with SMTP id o21so292071wmc.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=1gok0g3o4pUp/eSELbYdMh9Pl1EH6eZS749zzpCBZqo=;
 b=u3affaXkilCDoJ8VvexIYE27PHnh30EsIjy8x5H/xX0QOOa9j9UO8Ay7FXcqSt8XVe
 uHVSsXk6E1lrE+uyB5QPJlUog+HB883Ht5cZ1CZdAi3KsCuco0ZfMjznprcikSn9+gtD
 gfgm+ck3jPNKDGIqMfAZKg8GVZEcJsUng6xR3YAgul3uJvndjE6BSGhSuUDhUcdETStM
 8/+xAXvtyqPEoniD0kOKAgVbf3XzWM7ybuTZxyGO7ooE6TBkJNSJNd2/Wnjek1rG3FM3
 a3eteCqY7SYjzR1ZAKK8NSP7Pj+txgtpOmYl0mrIwRuGYdZoAm2rUT1eQB61LLzwSCX3
 yLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1gok0g3o4pUp/eSELbYdMh9Pl1EH6eZS749zzpCBZqo=;
 b=o9I5uPpyJF7Ru6kZSbAbx5TOKpTsmqA0b6pygAYwaAmigQkFWACDi1u15F39ELv/UQ
 8W912V+PB74Tg9hrLWNleRzLn0JGnKRt+hsnutYXmbgdzMSxC9w0fSHbkbIm89B0lmSg
 7Wt6xUAUH3yOpF6hcppaqAXTsUgRVruwd+NCfyWv20EYbs5fSQkvJaPyPihtpqiaMZy/
 KrTPXg+FJ5BG3vkCzvxzvEITSIy6SJxaq5/uWSaMvie0FZcxlycAFWih94Qbua7xwHZY
 oOT794WdmtrKvqIxE0S4wTJr8FaAW5r1f0iQH+g1HoPNzYvZCyeyKvNIriNKsI3g5Zqk
 JxGg==
X-Gm-Message-State: AOAM532l6XU1PyV25squPkrzuNg0zN3YaMyOrpT7+hhP9dQjyjzboYmS
 1RSX2RtdX3ZC84JZAUKgMUKBLo4cE42dnPiv
X-Google-Smtp-Source: ABdhPJxMJGm05xAJYEvi8kgZX4SXKxZm1WLav+PVNy7qvo0fBfl0pgPAnkmjRivR2VmRJm0uHuW/Eg==
X-Received: by 2002:a1c:81cb:: with SMTP id c194mr717508wmd.45.1598606670342; 
 Fri, 28 Aug 2020 02:24:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/35] hw/qdev-clock: Uninline qdev_connect_clock_in()
Date: Fri, 28 Aug 2020 10:23:51 +0100
Message-Id: <20200828092413.22206-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

We want to assert the device is not realized. To avoid overloading
this header including "hw/qdev-core.h", uninline the function first.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200803105647.22223-4-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/qdev-clock.h | 6 +-----
 hw/core/qdev-clock.c    | 5 +++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/hw/qdev-clock.h b/include/hw/qdev-clock.h
index a340f65ff90..a897f7c9d0f 100644
--- a/include/hw/qdev-clock.h
+++ b/include/hw/qdev-clock.h
@@ -71,11 +71,7 @@ Clock *qdev_get_clock_out(DeviceState *dev, const char *name);
  * Set the source clock of input clock @name of device @dev to @source.
  * @source period update will be propagated to @name clock.
  */
-static inline void qdev_connect_clock_in(DeviceState *dev, const char *name,
-                                         Clock *source)
-{
-    clock_set_source(qdev_get_clock_in(dev, name), source);
-}
+void qdev_connect_clock_in(DeviceState *dev, const char *name, Clock *source);
 
 /**
  * qdev_alias_clock:
diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
index 5cc1e82e510..f139b68b881 100644
--- a/hw/core/qdev-clock.c
+++ b/hw/core/qdev-clock.c
@@ -183,3 +183,8 @@ Clock *qdev_alias_clock(DeviceState *dev, const char *name,
 
     return ncl->clock;
 }
+
+void qdev_connect_clock_in(DeviceState *dev, const char *name, Clock *source)
+{
+    clock_set_source(qdev_get_clock_in(dev, name), source);
+}
-- 
2.20.1


