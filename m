Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD10FC43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 03:49:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70BFA207D3
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 03:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiOAdrPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BFA207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKCp7-0008Mk-JR
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 23:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKCni-0006Ol-4T; Sun, 20 Sep 2020 23:47:38 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKCng-0001wX-AZ; Sun, 20 Sep 2020 23:47:37 -0400
Received: by mail-wm1-x342.google.com with SMTP id a9so11058969wmm.2;
 Sun, 20 Sep 2020 20:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PhiofoUUiQN7Yir5VKkk/ymgbiAyhHHgyBkdAM+UqlU=;
 b=OiOAdrPXgQZTmnKylnTxI4uCwjy52dceXO/O1uwJ1RVTemGYFdSUh9Lv+qi1is1d6A
 Jwj7JZzYzTjMhLXZRGRjBdpKJlwDqtfz+WNEwq8yfjFdb3dVytw8ld47jATPMuPixjwZ
 NkXDoLmrcDxnM/PoVKkaZlzBhYeP2O+YEIOc5LV0ei+K/pz559C7lvfFh/6npB/FXTeK
 y26r83/e+JVYgbPN3ppb/vx0ZKZNe8v9PN2ZhXzHcm0f/3AmdUmoY3xIzLBYi+y6OmG7
 0YoOf/yVdIHLZEa83hZ3iau0C8WQEjRniAgG66zoBTVZTljQ7yPrMcBJJGP/y9yHT1Tr
 tTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=PhiofoUUiQN7Yir5VKkk/ymgbiAyhHHgyBkdAM+UqlU=;
 b=L1QzdUgTABWs09+2Ryh8r4VtzTDjMYoQWtqe4BIs4iKbcxkCWy5PQBGy5Al2qcgzDY
 Z8i3kupSZs96d6nPyF+OqPGuif/ElmlxLbaCOuuxRroLCzOGMTiThg09OMzPrfy6XNNZ
 76wfVFsFqHXf3W57pnCPj46dA1yfBpS/B2JWV2ZVJ+aRp2PBG51RCqniqIcpChmWzvan
 5kJj0puT98p6ZgmE4LcmHpJpzjoAifXVYNNn8HrawJu4WuPDLZEfkaU51Hv+6869rlwP
 FcO3+REkvQwdpw5MJg8hA5ID4fnXqTpvGOkJ6fWTxesi/Odp82ZBm+c9jux3NQNRjqew
 xW4w==
X-Gm-Message-State: AOAM531ChruQyEsrI9vjNwLmXJknGvf2+tGQls1hMjvQeBMScYWuQMB7
 FajbNx3BFNfOxsLtT5YkEmwEG9VD9w0=
X-Google-Smtp-Source: ABdhPJwSb6pOUfeGT4IC3ogpNDh4NIA7qeDzIq0oLs6OYAFscbwM8sD4lqSCdzze+CXdCQB5kSxMHg==
X-Received: by 2002:a05:600c:2906:: with SMTP id
 i6mr28545718wmd.48.1600660054349; 
 Sun, 20 Sep 2020 20:47:34 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u63sm11751440wmb.13.2020.09.20.20.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2020 20:47:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] hw/arm/raspi: Remove ignore_memory_transaction_failures
 on the raspi2
Date: Mon, 21 Sep 2020 05:47:29 +0200
Message-Id: <20200921034729.432931-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921034729.432931-1-f4bug@amsat.org>
References: <20200921034729.432931-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 1c3db49d39 added the raspi3, which uses the same peripherals
than the raspi2 (but with different ARM cores). The raspi3 was
introduced without the ignore_memory_transaction_failures flag.
Almost 2 years later, the machine is usable running U-Boot and
Linux.
In commit 00cbd5bd74 we mapped a lot of unimplemented devices,
commit d442d95f added thermal block and commit 0e5bbd7406 the
system timer.
As we are happy with the raspi3, let's remove this flag on the
raspi2.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index d2f674587d3..811eaf52ff5 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -321,9 +321,6 @@ static void raspi_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpus = mc->min_cpus = mc->max_cpus = cores_count(board_rev);
     mc->default_ram_size = board_ram_size(board_rev);
     mc->default_ram_id = "ram";
-    if (board_version(board_rev) == 2) {
-        mc->ignore_memory_transaction_failures = true;
-    }
 };
 
 static const TypeInfo raspi_machine_types[] = {
-- 
2.26.2


