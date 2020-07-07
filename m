Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC6AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:01:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E6F220702
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+5GuLSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6F220702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshc2-0007Wv-FT
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jshaf-00063L-4m
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:00:29 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43523)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jshad-0002dt-HU
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:00:28 -0400
Received: by mail-wr1-x441.google.com with SMTP id j4so41529164wrp.10
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vP24btoO2N26bkXvUhS4wjNttBxYNUYpNRsjcv1D964=;
 b=a+5GuLSMKbT8Bo6jsECDLI8YaJAyjaxNIvB/RJWG2YSWAFiZYwCrpdK9qzyKMkoZhy
 kcXkvLwP7Agt3tp6oNO8CsH8IJhUddDEF3dsomDYKVbIIlpWXQgNm4iQrWeKGcbW6Wno
 mtLdFBd20+UNRVlTnbgIfR5d9CpJLSagfGISNyr/QS9ms6a6zPKRkpQEiRz1Uw29IoED
 ZNAbbEAtvMj24r4KzBbrdl+TIysQWjuBo1cvSlkGXvQ3NfytCq+ToLurrxGYdBrc89i4
 oHzgtUQgChNDQLZ8TVVFCCuz2vBI2sz6JJZ8NZiPKgsG9R8jCIvp1xPEEqVhOdY9aNe6
 Ug6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=vP24btoO2N26bkXvUhS4wjNttBxYNUYpNRsjcv1D964=;
 b=jisLvxhXl4u7QnseXQouG0FsAZoXCwR4iYV1ZnC2DJ4vNtrXeQ8MVP5AwxQKHbkl1S
 DV3/GWwfrZNNc9xecotDkGS/vcKmWGU7BkgwPUbegD0wXE/w15NdagNMv/KgJun/riMu
 88N8mkQViLsVhqsKNWjhVEXJ4WiJseRUDZ0h0hvrztoDz4y0G71/Dl1vNy5/7cC7ElJv
 axA+0tmJhjyhZB/3mto0DFR+o8ixybKTnjAyd7Bz11YzWL/5zjlfjXkep7gGxfiQ1ap8
 gwG2lieA9pKCZEZJ+SyyOBI1f817LKtQjYHtarXtliHg2afsIr6wgrLun2nxGx8bMrwm
 +l1A==
X-Gm-Message-State: AOAM533AHazxZzZhraiKfGvCdUV8px+zasUYXwmRcyJPHZk0AOIP7vQp
 y/9sz5pR5sGd/yNe6mDqHuH34Le0
X-Google-Smtp-Source: ABdhPJwrzFFJluwSjkX2DTTFXCvoDjKNbMT2AvGdjZF5Ske3VRQbfVYe/abObPFFg4v5UUx37t4jag==
X-Received: by 2002:adf:ebd0:: with SMTP id v16mr46387276wrn.241.1594105225436; 
 Tue, 07 Jul 2020 00:00:25 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id r3sm30763634wrg.70.2020.07.07.00.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:00:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] target/avr/cpu: Drop tlb_flush() in avr_cpu_reset()
Date: Tue,  7 Jul 2020 09:00:18 +0200
Message-Id: <20200707070021.10031-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200707070021.10031-1-f4bug@amsat.org>
References: <20200707070021.10031-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Thomas Huth <huth@tuxfamily.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 1f5c00cfdb tlb_flush() is called from cpu_common_reset().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/avr/cpu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 4e4dd4f6aa..50fb1c378b 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -78,8 +78,6 @@ static void avr_cpu_reset(DeviceState *ds)
     env->skip = 0;
 
     memset(env->r, 0, sizeof(env->r));
-
-    tlb_flush(cs);
 }
 
 static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
-- 
2.21.3


