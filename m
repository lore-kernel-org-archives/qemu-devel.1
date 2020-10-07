Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E970FC4727F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:30:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4912D2064E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M5AiJrKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4912D2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCKp-0001Wj-3O
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQC0t-0004TZ-SJ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:10:00 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36872)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQC0q-0003FI-T1
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:09:59 -0400
Received: by mail-wr1-x442.google.com with SMTP id h7so2864007wre.4
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 09:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+Y7JJC94TIFLpziM9oLysAyjCZPEwl4nWDswqxAf3S8=;
 b=M5AiJrKTijnIR9cmvzIYNlZagbKnO6tLu/QYl6hX/7EMdq6j7JItJORsSlqQK+1+ie
 cNOa+msbPbwBcsF4wYxiC+AckSasPAy8/Q/wTxghknQpOCpVzh64Y5k1Gqn80bFawb55
 uDti81ZNmGQHSbH2YlMjkJCuDSf9HblS6KPr+fXYoM46PiSSQnc4yCBzEEjfdJ1atrEb
 gwadLVVIvrvHxTN7w+rZGVd1r+Tq41i08P0strhu9ueKDcpa18yDq2tYICuYbJSwDzoX
 pGztZkCxCnCvhMXy0CrXqyloZkV15XocFZLBEVY4u5dJdHTefi6PJbBUI7mrRInkxiOS
 0HSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+Y7JJC94TIFLpziM9oLysAyjCZPEwl4nWDswqxAf3S8=;
 b=FHIdIIEl7YS2hBpw7vfWL5Wc43JezCAqivqmG1xolIrYFkurEcDXgQCTYXt02XfKUh
 YeHvdfasphnYYuAXvO6/outRmkHK91OwfRZ6oj8SURZfdovI00lafjiw+7u5qhKRZ9fY
 EY6IwigvstjTxwhNu6+mdQizA/e5kddUdz+sU4icLiEWheHWWLEO/tKw2sOiMY+wcLEr
 HOLepJtqnKd4QimhZLZAumHbEwplvfjoFQRK5Vjfr5n0S+mQyREGZVsQpX6jmxHQDQq0
 aS8cC4slMrltx9tf2JMCE/Y+AWfG0qyyEHMTucZc3uuaIpr0AyEGVg/hbE4rW2pvtjKc
 0nQg==
X-Gm-Message-State: AOAM533rD9icwkvyzEqXLNaefRl+vdopebUJpvFednIMsK2DWNBp0tZD
 AGgq4a4iP5pmrfcLPNSY0Bl+oA==
X-Google-Smtp-Source: ABdhPJw03v+/eJ53ZyfWzQRGQMLUBJX76DIr2+3BWO/yb4bWo2vGWnbwhTEX/IjFzSDq9umHPntgeQ==
X-Received: by 2002:a5d:570b:: with SMTP id a11mr4451726wrv.139.1602086994890; 
 Wed, 07 Oct 2020 09:09:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z5sm2142984wrw.37.2020.10.07.09.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:09:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A97991FFA5;
 Wed,  7 Oct 2020 17:00:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 17/22] contrib/gitdm: Add Yandex to the domain map
Date: Wed,  7 Oct 2020 17:00:33 +0100
Message-Id: <20201007160038.26953-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007160038.26953-1-alex.bennee@linaro.org>
References: <20201007160038.26953-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: Roman Kagan <rvkagan@yandex-team.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

There is a number of contributors from this domain,
add its own entry to the gitdm domain map.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Roman Kagan <rvkagan@yandex-team.ru>
Message-Id: <20201006160653.2391972-12-f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 1572070cf4..0074da618f 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -33,3 +33,4 @@ virtuozzo.com   Virtuozzo
 wdc.com         Western Digital
 xilinx.com      Xilinx
 yadro.com       YADRO
+yandex-team.ru  Yandex
-- 
2.20.1


