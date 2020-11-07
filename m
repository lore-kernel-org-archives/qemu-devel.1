Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE02C388F9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 19:36:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7080020723
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 19:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlud5Q7k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7080020723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbU0u-0000vc-H2
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 14:36:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbTyZ-0007aR-1F; Sat, 07 Nov 2020 14:34:15 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43426)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbTyX-0008LK-M6; Sat, 07 Nov 2020 14:34:14 -0500
Received: by mail-wr1-x442.google.com with SMTP id g12so4697301wrp.10;
 Sat, 07 Nov 2020 11:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QOn2Yk5sEGXZTzwuGFFHfpa3H/VY3D0NQ01szmHIhVo=;
 b=jlud5Q7k6eQATQlh6MIXGRBdIMGkwhlkNYIWqj4aasCGq3sRmuX3LnDT3yqd9T4X/y
 T7CYaQPAjtVCdsxDeMnK3LyoupaS9zpaEC38edlYUEelhfyS3q9R6s0UPomrRSi2iCie
 WFTJPMDiooZrMSVQffelHGfoWlEzxWZj4o69AKt8D3PEbbzjIfJw92GNYfXoSh9KO3UY
 1ArXWTPiswFW1xwRMREWIfbVpz7ICCWFf2vqwslB7CTvelMXu/28xg9doc3F+1n205ya
 aK/78zuUTpyMLMC7fpGXpeC6k0/us6ISSOLDoKFG0ejg7ro4ZTP+xXc4WcKafgR2a7jw
 t08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=QOn2Yk5sEGXZTzwuGFFHfpa3H/VY3D0NQ01szmHIhVo=;
 b=cA3kVFamq4aw5ZFlJ4WdjnC9YpbNaIkIkarR9vZTGuMPOKbTgSknWP5f18k1kxTsaF
 AqABzj0CDgSs/ki5bACpV9Iu3xtT+1K43p1Ik7R6bX2WY7QzAh55OYY8Fccjn4Iw3tn4
 JqT1AVtjjksFk0ISuoEuQZyjQ45xUkBxhkWIEu9w6gLvzb54wCZ/V876ySO8YH+lyAi7
 39eE2aKBbWzNL7NyZgnsSuSBp++/LUGI9k6yJ+9+WwShz1pb4tMxUTuwYWJ9uO6DI2Zb
 VAvn+rf3UOV+QNRGreT1NsS3OA+PaXoyMr+PNZgaJIK7ZzkQua7FdxdyWPB9ys4U3Jz1
 Lp1Q==
X-Gm-Message-State: AOAM532es721pU2bImkJ6PxNl87mbcdBf/febP8BMXiFTjcBJ45ESa7g
 0//eTMAnApI5QnC8JchcERCVavSlY+A=
X-Google-Smtp-Source: ABdhPJybY066lfW/fMBdzUGWF9/1HcWQq6qbAeO82b/kRpfA5DrdLO1AOQZqL936YyB4vAeiUZkn0g==
X-Received: by 2002:a5d:4f8c:: with SMTP id d12mr9721319wru.351.1604777650856; 
 Sat, 07 Nov 2020 11:34:10 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id t5sm7852016wmg.19.2020.11.07.11.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2020 11:34:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 1/5] hw/arm/armsse: Correct expansion MPC interrupt
 lines
Date: Sat,  7 Nov 2020 20:33:59 +0100
Message-Id: <20201107193403.436146-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201107193403.436146-1-f4bug@amsat.org>
References: <20201107193403.436146-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can use one MPC per SRAM bank, but we currently only wire the
IRQ from the first expansion MPC to the IRQ splitter. Fix that.

Fixes: bb75e16d5e6 ("hw/arm/iotkit: Wire up MPC interrupt lines")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/armsse.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index a93da37dcbb..baac027659d 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -1074,7 +1074,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                                         qdev_get_gpio_in(dev_splitter, 0));
             qdev_connect_gpio_out(dev_splitter, 0,
                                   qdev_get_gpio_in_named(dev_secctl,
-                                                         "mpc_status", 0));
+                                                         "mpc_status",
+                                                         i - IOTS_NUM_EXP_MPC));
         }
 
         qdev_connect_gpio_out(dev_splitter, 1,
-- 
2.26.2


