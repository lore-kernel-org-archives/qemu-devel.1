Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EE7C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:13:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F6422072D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u7pW8AJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6422072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzDO-0001IZ-Nn
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAl-0004p1-FT
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:11 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:51348)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAj-0006bf-TH
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:11 -0400
Received: by mail-wm1-x32b.google.com with SMTP id 22so13464827wmg.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=pLks78n58shGUjzr8qBFjGZdlcgPpzMamGTQB7aIdDA=;
 b=u7pW8AJ1B/B6IQLXN4VlTtF7clsKz3z6EEfBUzxcfzC3jZ5n0pavb4g/Bh6oZMy4ds
 lVi4Ndil7QjEOg81o2jMqfVZf4yLUPcy72ePf1Sad0UAVzDiVbviiXgFi7NP6HeDSK2+
 bErOHofLuIrZLWklRv2f7ZkGvAKhL+rdILkkiuqmSJ6GncjiuehFDkab8mmi77WX+CZF
 9kPxAylsVqZb1xyyCD/rz4ColoMcaZqRCPLiTvP+DzEzyvddbuqUZBOJr9ZOONxp39IG
 0Bzsebpdyp/9+k93WvcYydPRYHImPc+4hEAhjCIEnSwj3jQIl+cgp0zb8V/3cFLebTKz
 rC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pLks78n58shGUjzr8qBFjGZdlcgPpzMamGTQB7aIdDA=;
 b=lkwF82EC1fxObAukDOoITWXoDdHLgye6WfgVTtTLAHTgzxd94Mtf4REhawuCxqsY4N
 besrYuL5DHJW/JNb0gh6n8yq7HYdxTBRP/0pjnVLFeIjpllxgcJgK7caPDExH2AzbXOs
 CzlHeDb8SWVx5vVmGiHcydOu3KnXW3GioToLxU3pjlZVD4korYS3O4axnpdTb1SkMIu9
 6byT599Olii5sUVKB6TOMbIwu+BtcfNfyyK8c59pKzIXywjUC264KZY3LRgwqaMWLxJj
 0UEh6Ga7Hpq7xjbwFNrlrFoz7ZmBKfgRttMXg6I9vZu8/D9cD4qvVeIqbGHbUsqbjaBr
 OwrA==
X-Gm-Message-State: AOAM531XKPmKfTdGegrX+qiBUnHR05HCbTdGLSsANnX9H6bFWsB7lsKL
 zDX8Q/D1vN+GiyNi3guBUehGKJOOks1+gQ==
X-Google-Smtp-Source: ABdhPJwup1qHjh0JyICExvF/CzgW5/yp4rHvlF7BJhYpxD7aA0BG/eNmdfuu1hWb7cxmlUPFLSqKZw==
X-Received: by 2002:a1c:2349:: with SMTP id j70mr182163wmj.22.1594649468170;
 Mon, 13 Jul 2020 07:11:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c136sm24031297wmd.10.2020.07.13.07.11.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:11:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/25] hw/arm/bcm2836: Remove unused 'cpu_type' field
Date: Mon, 13 Jul 2020 15:10:40 +0100
Message-Id: <20200713141104.5139-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713141104.5139-1-peter.maydell@linaro.org>
References: <20200713141104.5139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

The 'cpu_type' has been moved from BCM283XState to BCM283XClass
in commit 210f47840d, but we forgot to remove the old variable.
Do it now.

Fixes: 210f47840d ("hw/arm/bcm2836: Hardcode correct CPU type")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200703200459.23294-1-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bcm2836.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index 024af8aae4f..79dfff9d734 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -33,7 +33,6 @@ typedef struct BCM283XState {
     DeviceState parent_obj;
     /*< public >*/
 
-    char *cpu_type;
     uint32_t enabled_cpus;
 
     struct {
-- 
2.20.1


