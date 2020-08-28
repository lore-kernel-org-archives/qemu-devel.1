Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A20C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:27:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FDB1208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I7e0CzT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FDB1208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBaf9-0000Y5-NR
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacQ-0003mU-Ir
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:22 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:35208)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacO-0004DP-W6
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:22 -0400
Received: by mail-wm1-x333.google.com with SMTP id o21so291657wmc.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=SofcrMgy1JA/OVtNnrIsso+Qwyi9DQ6wbkoJ4SLNNAM=;
 b=I7e0CzT0GwK3quKrcBaaFtDoqSzwvoo/NWfHPxcODUezmfcKaIr+xQH+yctA5NKVxD
 Ub8F68cPoTNOX/jnk/tIuBQ7XMgb+pKqmd1u6zeICb2/IjnXZI/oY+mInziEJw8HdgYG
 dbluta6XNpebp7DteV1VwT5M1pza17DkMKzT9YQA9kU8Gmjr1n4E2Rbnuvr0BZ6OPH+T
 K6SLlycPmuCmaBDWUEolzESMLeaVi39PJ1HflNMpJEHJGKgh0sch1eCquM9hUPbX8A5Y
 1adR171x/WWmgjzaZxoq75SQOQxXUupIDWTyuR7ZBBjL2GLtbs7vMa46HhLP0KivesZp
 ofiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SofcrMgy1JA/OVtNnrIsso+Qwyi9DQ6wbkoJ4SLNNAM=;
 b=O0TKoPFy5mtElfsSN0LGT6x1nKV/J8cBgr/8WFQjcFHnlse5r8h34XeL0ggkYLWtap
 SBGK1CT7Km8fbEax++UyxrkunexLW1qx5k7Fkm9BljT7+/6ZJZRZYGpQ6Rj3kuXG/JFs
 MNEW0I9GEUXMGd44hcxBj/OvdKjkhq1JmPmuO8clO+/eN8xeSuX1nyhm9XMT4oyWZ1WT
 FrkorKzg4TqHoc8rsWdYOngW5soaS9OLDwAginSL6YH0y3RzMgHSFYyzsTGsMWXUj+SI
 SCKBLmsAIuHNtMeWVf8lk4sj2xh894h5QFSmcXg2OCJK6dLznnPla8dX+WbTWP5NEFsN
 DSJA==
X-Gm-Message-State: AOAM532z5tqHiygf2pA1bzMvHBc59K4AyHEqoLsd38qKZrXTI5u34ndr
 vgvG7PoWNo6vhqNGFY8a+6WsLJE7cuZI6ZEm
X-Google-Smtp-Source: ABdhPJwGM4PIDoRm7RMQiSWZVUDOxCn0JVhj4uxHxKG65apDs5+m2Tuugkh/ri2GbHkTNIe4Ft+rrA==
X-Received: by 2002:a7b:c342:: with SMTP id l2mr655508wmj.153.1598606659324;
 Fri, 28 Aug 2020 02:24:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/35] hw/clock: Only propagate clock changes if the clock is
 changed
Date: Fri, 28 Aug 2020 10:23:42 +0100
Message-Id: <20200828092413.22206-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Avoid propagating the clock change when the clock does not change.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200806123858.30058-4-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/clock.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/hw/clock.h b/include/hw/clock.h
index d85af45c967..9ecd78b2c30 100644
--- a/include/hw/clock.h
+++ b/include/hw/clock.h
@@ -165,8 +165,9 @@ void clock_propagate(Clock *clk);
  */
 static inline void clock_update(Clock *clk, uint64_t value)
 {
-    clock_set(clk, value);
-    clock_propagate(clk);
+    if (clock_set(clk, value)) {
+        clock_propagate(clk);
+    }
 }
 
 static inline void clock_update_hz(Clock *clk, unsigned hz)
-- 
2.20.1


