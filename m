Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28B8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:55:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0EDD2064B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V1i0e5Af"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EDD2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhWV-00059j-0r
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHB-0003JM-II
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:41 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:36689)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhH8-0003KA-Af
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:41 -0400
Received: by mail-wm1-x329.google.com with SMTP id 17so2865672wmo.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=evNmXaMAc+WETlIBriOddwBkHq02IBzTdOsbeZtXxH0=;
 b=V1i0e5AftduDNvxoxWYqBZHXZmxvk88QGzGVDJ/waLg36jQRM/IbMkINbierncjWc3
 Eayp5Vg8DH6J+M5PfsHxa/w7gzEfkWMhMBdeMHiNsHueA1avbOGM4ctonOrWNm3BT4aX
 iYaLoe2Er5cJ9dybxIAVzKZxqVii60+AFaepXlfuv4kWkP+Fq6WOdIe87rIjMkpyLda3
 Uw3GG5i0+o+sYHmJbgTUbudiafloYcLzh8jNrkz1g+pLtlXlBdffYR9ihGW1XhnGTC1s
 FRXycClLwJ5OAX9gPSgPfemZrbAWvtkyvrfRn2m1amC+1+DvLEr12zYdG94ZzD5RaDHb
 VUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=evNmXaMAc+WETlIBriOddwBkHq02IBzTdOsbeZtXxH0=;
 b=q9hhcBHGJdv1y5r34oe4XQPW1s2NevZf7qIMsnpbr9fxLIreDjYdOKwDEhT4N28YFf
 nA5zCLZZe3NPr7+pEEdIwrUncQ99xYWSk4WAyGbshyQDvcPg2kclMZGZANaGup/HoEqd
 P6USXj/kkuTL0dOKv3rm+S9elxt0jqCouM8BuAQph4TarTq36iH8n0utIlELQE0+oVSG
 OrkeD+DWB34smZeexCbhJ2g+uf/mMmoDk0wnSL1NyWU0+DH/k9liT+RF4PldBMeDrvTx
 Y+MLh/FqZeHDLXNAt5+DneeK/1af82fYptwJQ1V8eOs2882ZhaGso1N9psgyXvYM5Lci
 VTXw==
X-Gm-Message-State: AOAM532uPJGB0LeRJf/TXxBPtQZ9ePfrXjkvHwmHoFRFKZF8iFYzy9y0
 1NXct9Flmhz8HQ21sdCNA0PMpi8WUy3o/w==
X-Google-Smtp-Source: ABdhPJwCwqg/y288Drs+f4M02kOAwxq9jdAVf9KfGmACG8w/fQeGpf7ggDeZA0hFA05A8fBHyDVRXw==
X-Received: by 2002:a1c:1b90:: with SMTP id b138mr13305102wmb.21.1592912376598; 
 Tue, 23 Jun 2020 04:39:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/42] hw/watchdog/cmsdk-apb-watchdog: Add trace event for lock
 status
Date: Tue, 23 Jun 2020 12:38:48 +0100
Message-Id: <20200623113904.28805-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Add a trace event to see when a guest disable/enable the watchdog.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200617072539.32686-2-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/watchdog/cmsdk-apb-watchdog.c | 1 +
 hw/watchdog/trace-events         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-watchdog.c
index 1541365914e..5bbadadfa68 100644
--- a/hw/watchdog/cmsdk-apb-watchdog.c
+++ b/hw/watchdog/cmsdk-apb-watchdog.c
@@ -225,6 +225,7 @@ static void cmsdk_apb_watchdog_write(void *opaque, hwaddr offset,
         break;
     case A_WDOGLOCK:
         s->lock = (value != WDOG_UNLOCK_VALUE);
+        trace_cmsdk_apb_watchdog_lock(s->lock);
         break;
     case A_WDOGITCR:
         if (s->is_luminary) {
diff --git a/hw/watchdog/trace-events b/hw/watchdog/trace-events
index ab94d7df502..3124ca1f1b6 100644
--- a/hw/watchdog/trace-events
+++ b/hw/watchdog/trace-events
@@ -4,3 +4,4 @@
 cmsdk_apb_watchdog_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB watchdog read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 cmsdk_apb_watchdog_write(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB watchdog write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 cmsdk_apb_watchdog_reset(void) "CMSDK APB watchdog: reset"
+cmsdk_apb_watchdog_lock(uint32_t lock) "CMSDK APB watchdog: lock %" PRIu32
-- 
2.20.1


