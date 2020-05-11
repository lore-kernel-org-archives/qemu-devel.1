Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94C5C54E8D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:35:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98395206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JgwEuY8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98395206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8ax-0003ve-MR
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8Zb-0001rF-R6
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:24 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:32848)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8Za-00071X-UX
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:23 -0400
Received: by mail-wm1-x344.google.com with SMTP id d207so3953244wmd.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 06:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=LddjfC5XvEtL1mshvkJR+ZoJ5zLFJfMEScugSYPjRjA=;
 b=JgwEuY8gJFxtRZCdIhcrPcHD1Uh8QtvEtwCKWl0PGkGNVDsFda9iHJ9hxuTNBUz/9U
 dFL7eA192d933DazuVQydJTJNOLvzY8SProVwf+TSK9QobQMb5GHP+wFy7uXCkOVAek1
 45D74u7J6PonVkmQhRgTJBLDriL/dZOTyl+hoUz79e4/7rX5fnXbDviA8o/b4r0TOYnS
 6ZFjjsRu2/9YWCpeENCc97kBzT7MSZmoJf78tiPH7VG0F+bEWANhxYxqZa1JoJaBtco/
 hokrgdMNcnH9VzF1IPSRPJJrYi+lq0a0ZNS5qKamP0UXAdNzh30Xml+DunMESV8SkHSX
 TYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LddjfC5XvEtL1mshvkJR+ZoJ5zLFJfMEScugSYPjRjA=;
 b=Jiqvf8Ssj63uU17WgRZ9k7+41FUPFKAzQoJb7rdx2edFvkTphy/ZZzIkHrEG3bu6no
 rqhZTuLOPbC1JPWA/h2IU7mn4CDQjXlpesSRUYb9e6KHSxsUoPdRbqRQ+EuoQHWMTpXx
 EDfuMGrMbCUV9UBfk3f4tIIeCAxfHX39JF6Y8O0F0t5wFPzHa/mB4wSDY5heYJb2Mg5v
 e+bT92LAwwXpBCTH1kXw0HFy13Sjc2rzup9w3oHDQL2zjAkMiw2NCarlZm0484qE5Vvd
 opyKNnP/7Iv4b8dcwcGkH1XzVEldHCXqXXPrWxL/slgRdO1Xtykeua5WTNkPgX/dbR5H
 xE4A==
X-Gm-Message-State: AGi0Puavo3fGUB6/L0pJIqaJoGsC8bOKZLo2u8oXiBPjQNbLegj3yRy3
 uEwXJ5DGj8g3r93egahEXwkgpMMLSq085g==
X-Google-Smtp-Source: APiQypJwLDY8k8vWLEVUxh86gxbBgiSn8LCb2rhkRbcgoF8oocv6nij2IMr0LZY4RIluBjX1FkVw7w==
X-Received: by 2002:a7b:c08b:: with SMTP id r11mr30182577wmh.45.1589204057772; 
 Mon, 11 May 2020 06:34:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m3sm2154818wrn.96.2020.05.11.06.34.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 06:34:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/34] exec: Fix cpu_watchpoint_address_matches address length
Date: Mon, 11 May 2020 14:33:40 +0100
Message-Id: <20200511133405.5275-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511133405.5275-1-peter.maydell@linaro.org>
References: <20200511133405.5275-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

The only caller of cpu_watchpoint_address_matches passes
TARGET_PAGE_SIZE, so the bug is not currently visible.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200508154359.7494-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index 2874bb50885..5162f0d12f9 100644
--- a/exec.c
+++ b/exec.c
@@ -1127,7 +1127,7 @@ int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len)
     int ret = 0;
 
     QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
-        if (watchpoint_address_matches(wp, addr, TARGET_PAGE_SIZE)) {
+        if (watchpoint_address_matches(wp, addr, len)) {
             ret |= wp->flags;
         }
     }
-- 
2.20.1


