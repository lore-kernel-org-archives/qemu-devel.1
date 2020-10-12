Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFA3C43467
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 13:22:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD6522072C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 13:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzEihUgm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6522072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRxmw-0007ik-R8
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 09:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRxkt-0005St-50; Mon, 12 Oct 2020 09:20:47 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41652)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRxkr-0005P7-NU; Mon, 12 Oct 2020 09:20:46 -0400
Received: by mail-wr1-x444.google.com with SMTP id s9so7073654wro.8;
 Mon, 12 Oct 2020 06:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S+qJmTO5tJK+xMnKaeXjrUuhIrSEH6LdhmvHFkUYTME=;
 b=NzEihUgmUX90wUWF8yPl3KUdmgxbrrsxWFlwmP01b5/BkqfCq8hq7WOA3Lvb8dzhV5
 za57HvFyPDuaKgajcR6oUSZZkCPHmZe19fH762COV58rtDh4Jzuw36FGmSSacc7QJK1I
 Te+v3sqLptPFly/u060MHQUZjYS0Lxod77ymSbx1Bpv8QULfXMv25RDDEjLbbuw5KKke
 2fU/qarmB4O9H2aK9GFIz+icXuXF2OFIfPB0zfHosd0CmbqO4LftlwWlACreJnMIGGkr
 ZO1z6lu0vyypGjR36kT7jqZsXik6RfZA/kAaWiFj81D7x9/LM4xoXuunay7ik5athDfx
 tSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=S+qJmTO5tJK+xMnKaeXjrUuhIrSEH6LdhmvHFkUYTME=;
 b=S1yvEEEZud7unqHQ2l0ZEcTfxgShnNif+Txjikjv3nRONv1dKlr0DCSoEyRjAPYeWj
 GI6ihdmuoXNW9/eHg/D2zU3kasZSpHVRVOTxcl6LuMSp7hC7iFfJdfFKtyyxIYmMQAGd
 jDNDdyeB/0861FLg9we4oS6+If2uWZwkX6EoirVZvZg9fggnoKdESJ/P469iu1T+JUDd
 Cu3qQqAOnp/DBJ5nMlYLA3WiW9/kWiA5kbSOUTdNsiC/fp3sD6wKaTzH54l6CpuYXvW7
 O42tSOprFYuNb8RlqFptj4Yn3dUpoAJ977XbHxsd036z9Z+/ZExffNNCW7KQ2ZBlQC0q
 IbXg==
X-Gm-Message-State: AOAM533ty6V+r/12DrFuSSIFWB6M/OyPbkMlspnCMWUUWFi1nwH2xPZU
 6MeTYd7LFYUI6Yqp76hj9TJ4yH4eqpU=
X-Google-Smtp-Source: ABdhPJxGw8nKoBf1Vz8InNroMZ38P9rTS1LCT/KEDodfanlwQgbVkZ20zwoBh17DCknoLjWkm5yVGw==
X-Received: by 2002:a5d:568a:: with SMTP id f10mr29542247wrv.30.1602508843929; 
 Mon, 12 Oct 2020 06:20:43 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id z11sm24584887wrh.70.2020.10.12.06.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 06:20:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/5] tests/qtest: Replace magic value by
 NANOSECONDS_PER_SECOND definition
Date: Mon, 12 Oct 2020 15:20:16 +0200
Message-Id: <20201012132017.3423954-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012132017.3423954-1-f4bug@amsat.org>
References: <20201012132017.3423954-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use self-explicit NANOSECONDS_PER_SECOND definition instead
of a magic value.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/qtest/rtc-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/rtc-test.c b/tests/qtest/rtc-test.c
index c7af34f6b1b..402ce2c6090 100644
--- a/tests/qtest/rtc-test.c
+++ b/tests/qtest/rtc-test.c
@@ -292,7 +292,7 @@ static void alarm_time(void)
             break;
         }
 
-        clock_step(1000000000);
+        clock_step(NANOSECONDS_PER_SECOND);
     }
 
     g_assert(get_irq(RTC_ISA_IRQ));
-- 
2.26.2


