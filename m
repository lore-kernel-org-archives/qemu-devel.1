Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F575C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22BD020780
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dWgyu+Am"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BD020780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO06l-0006wx-2i
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsh-0005LF-GL
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:27 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:32919)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsf-00031j-Of
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:27 -0400
Received: by mail-wr1-x441.google.com with SMTP id m6so6131930wrn.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 07:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=d0y5K6KRHiKmYugnVjPJ0WrocgiRHX3D6Xfcay0Qg9E=;
 b=dWgyu+Ame1E+4rhugoalxSFas4vP04ZWXS5ECCAvlsv5u8QuNjXL2I7FW5TnGV83IF
 yBy2HhplWvO4m6kc4GnWOzQNbkX+Nj3e+C5tAUaymyAbOMlZRG8sugR1aRetryMhC7Jr
 yAjgxffcvFkK70JP98NwmLXDfo22rVb+illeLWOC4LT6pC5tl2g6bYvKCAEIdqU8cOTp
 621+fk2qNAu2p38cXwX7GGC0S4ypaHPA0HmLkkX4hurOn6+hijtONIqaOF8PGCh3rt/+
 /74GwR+SGjr6cpa5Wq1zMTKvbDc6wEZk0Mb0JrgTvPwdadfXJm8bQRfBOjwq3+ZB1zc7
 YB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d0y5K6KRHiKmYugnVjPJ0WrocgiRHX3D6Xfcay0Qg9E=;
 b=qT2H+9m8vimTrFwEopvHernSAMp1wJO5s1maRb/o5pEf25nXqDhBTB4H7prD0CurMb
 jESbyiXRDaX+ufXdq4QhG8bSazp1wdY5PyLmDrMGeEYLJMeiaUCT3TuZH0JuN78sE2E8
 hrkXUzbav0b6cUuY90kLez7JpnjoB5V3NEYtRmCtyQNpb3aWGkoY9OJ/897xyvB4N1ek
 Mq3ffX9nm9boFEfBqrzImkOJMxe0kPiNR6AMrK6MD8zjkErQV5AJBWRkrY4yuDDTVEyF
 gpeicaKniQ9fB/Ezx4EYf+TfrNDGUtdPw252wZfzFEJIizZbAzj8AFYyT0z9f2zHx9yu
 e3fA==
X-Gm-Message-State: AOAM533z2LaJy0fVpxKvqwWrMK1QMO3KqZd7hT1qymOmyzqkyyaeFHog
 So2OuteYDkgQjWAqfsa+J37JiWoC5H4YM21s
X-Google-Smtp-Source: ABdhPJyme2WriagkxGFAAxgMgwdMSKLkoioOSsTE6Ae8CgLB7y9W/CkxT3veiczgTyENjYJAdoTLSg==
X-Received: by 2002:a05:6000:7:: with SMTP id h7mr9988047wrx.16.1601563704144; 
 Thu, 01 Oct 2020 07:48:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 70sm342052wme.15.2020.10.01.07.48.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 07:48:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/18] hw/arm/raspi: Use RaspiProcessorId to set the firmware
 load address
Date: Thu,  1 Oct 2020 15:47:58 +0100
Message-Id: <20201001144759.5964-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201001144759.5964-1-peter.maydell@linaro.org>
References: <20201001144759.5964-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
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

The firmware load address depends on the SoC ("processor id") used,
not on the version of the board.

Suggested-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200924111808.77168-8-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/raspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 0d8e5a34c78..ae98a2fbfca 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -238,7 +238,8 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
      * the normal Linux boot process
      */
     if (machine->firmware) {
-        hwaddr firmware_addr = version == 3 ? FIRMWARE_ADDR_3 : FIRMWARE_ADDR_2;
+        hwaddr firmware_addr = processor_id <= PROCESSOR_ID_BCM2836
+                             ? FIRMWARE_ADDR_2 : FIRMWARE_ADDR_3;
         /* load the firmware image (typically kernel.img) */
         r = load_image_targphys(machine->firmware, firmware_addr,
                                 ram_size - firmware_addr);
-- 
2.20.1


