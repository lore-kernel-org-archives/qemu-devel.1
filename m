Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DAFC33C9E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1A482067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OQoNxuTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A482067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipNSL-0003v5-Un
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 21:21:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNO1-0007FY-FT
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:17:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNO0-00088e-6q
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:17:25 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:38330)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ipNO0-00086l-1J
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:17:24 -0500
Received: by mail-pj1-x1044.google.com with SMTP id l35so438251pje.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 18:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ggTNIXckHEhs6NEA+P+FO98Kh7NZuAYc0hm4wcTirRY=;
 b=OQoNxuTJI4X9Dq7yjWdNkLddYniY1zFSLk6MnaecmRqplXArLbeTjytpfaQ47j69eG
 9Oht3XGM4nI8tCBu2wjuIEZclvERC8A2+fwSevE6CxiQBKyKXYr97GKPiXJTt5LfLfsl
 D0qbCalJiILRip/zJ95AOTdWDWta8YGZT1ne+F8wYR2NZhWIkLsV9cn/lFtWlMnnredM
 loaqiAbU2EJl5D1SS0uihO7wJYZuu5XpcM7qrI6dmkZY9mW5UOcYox5+IWbgTW3GKejP
 djYWVEoN38atM5rcLM+QC7iXotg6vqj+185pun6luR7IR64fVhjjXvGiCOy+cXgxpmJk
 JBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ggTNIXckHEhs6NEA+P+FO98Kh7NZuAYc0hm4wcTirRY=;
 b=MNlOI+NbVLjI8DS78JEuy1CL6WBwZH5HDXf1pR3ah8/ZO5hNP58V3DZBFgz14bX3Dc
 fc52JMgQowWKHjPqsKDc1dEvy6Ja3bLMH0w5zBn8eokTDyZcaiyt6KkiFoFSuxBP2CvQ
 4PGfLJ5KysYtXM5Jh9xqzUceXWv7V5Vt39ydtaRiRa1I4kkWb4uAf3RWBvrG/RgOoT/f
 YlbnmSzOLz5sK9jRrKDOSAVU4/IYDbzTVsHquLp0DzjM7ogeHiUK8qwRvl11vAXssj4H
 pnHk7F5OIKBYWnM+cQ6q8WZnILpzW9TbziCaQF73r8wniJl+7dT41FfTkfoJUQOFhDVx
 ZyIQ==
X-Gm-Message-State: APjAAAW4WFtvsn5Rs6Cx4EjoC8Fg2fbHB9NTpbig0tWFi8MPWGTmJNW+
 S6jCbVbCY9qbEALLYtxzyKlu0x0bG+fwxA==
X-Google-Smtp-Source: APXvYqzPSjGUKI8Prlov2PiBK8AqJTLC3BadY0la/IfH+uKgx6S9IM/H4kWP3htuqlZI6CPSPO7LgA==
X-Received: by 2002:a17:90a:e982:: with SMTP id
 v2mr2306669pjy.53.1578536242765; 
 Wed, 08 Jan 2020 18:17:22 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id n26sm5166715pgd.46.2020.01.08.18.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 18:17:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] vl: Remove useless test in configure_accelerators
Date: Thu,  9 Jan 2020 13:17:09 +1100
Message-Id: <20200109021710.1219-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200109021710.1219-1-richard.henderson@linaro.org>
References: <20200109021710.1219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The result of g_strsplit is never NULL.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index c9329fe699..887dbfbb5d 100644
--- a/vl.c
+++ b/vl.c
@@ -2776,7 +2776,7 @@ static void configure_accelerators(const char *progname)
 
         accel_list = g_strsplit(accel, ":", 0);
 
-        for (tmp = accel_list; tmp && *tmp; tmp++) {
+        for (tmp = accel_list; *tmp; tmp++) {
             /*
              * Filter invalid accelerators here, to prevent obscenities
              * such as "-machine accel=tcg,,thread=single".
-- 
2.20.1


