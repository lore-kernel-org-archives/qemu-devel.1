Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6770CC388F9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 19:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0879320723
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 19:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFvyLBI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0879320723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbU0W-0000Ul-3H
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 14:36:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbTyT-0007T9-Oi; Sat, 07 Nov 2020 14:34:09 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:36766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbTyS-0008L3-2J; Sat, 07 Nov 2020 14:34:09 -0500
Received: by mail-wr1-x42f.google.com with SMTP id x7so4713975wrl.3;
 Sat, 07 Nov 2020 11:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zXUTmF8bltpQpasERk68h2FB2rhq+Qm05VzeVh5NXvY=;
 b=lFvyLBI+B6fNkMilBsdB4Rs2CB5msVcgTDjgeC8c2GfCWZGsETgPlVIx6jvw8Pa+nP
 u42ddzR5naCkxpCW9CinLRF0zSb9SjLfBtBptMYTq2XuHpRe7uYll6VLu+lYpdZ77rIk
 6Mugeh1Fgj46Pbc5emMqH+gy7Mu7cK/6MrnDUd8puGXLEgqoHBobT97P5xBJaQeHC+v5
 hm0SAOKHY9oTadfI44dKidwtqPR+ALcYWJox0nqPurn4ZP0n9iiJeBQXkOPQGEveSDbN
 9tPCyG5wihGocW5dDDIkiPSSvWVLiezfFpJqpZdGZ51oabSBJNJ3FkWKrYfRjntB71FI
 rS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=zXUTmF8bltpQpasERk68h2FB2rhq+Qm05VzeVh5NXvY=;
 b=syNTFR6eDKCUWVxdV1JZpNIDpZQ+xmhJeeEfLcaJIsr38lKHSplLHA7IWhOh9idjhe
 4k/8QHwcSVHV9k8uLcEVdJlLAv45+LRCNxWbtwOm3025+c4AyXhKiBDJQVBVfC5BkywI
 A3EFiZN5QK1z1lUWgOL3/kGgBa+6JuPufDoCSeNInJV9s+24Xe7NqGj+1fERNSz4L+EK
 FuQgTdwjW0bbxOQdGw2FpmpImPlxrRCTlPD6q4PfGnmEoFsK5T05Bm8G23+uWY6AYljS
 5ALFn+2zinOpmplZ1xKs4QJTdoXGrhtuHhl/1sqrxWmxsukvavzl055YnDp7XjhcQ2PN
 7O/g==
X-Gm-Message-State: AOAM532oQRZtSN1NKKClYqmhSKEhSmxGcGvbw7+8iz4FZQylRbCs9niM
 5kHLjsqYiv8CY2iWPrPX8xwvmr+G/2Y=
X-Google-Smtp-Source: ABdhPJxRofQyXfHXnH0c5jZnQWiU14ileXQ5iM17ncOgriAQq4xLuxOeJqe1sLo+wsuXgAvxzDA/7g==
X-Received: by 2002:adf:ed49:: with SMTP id u9mr8944875wro.88.1604777645961;
 Sat, 07 Nov 2020 11:34:05 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id o11sm7851816wre.39.2020.11.07.11.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2020 11:34:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 0/5] hw/arm: Fix various incorrect IRQ handling
Date: Sat,  7 Nov 2020 20:33:58 +0100
Message-Id: <20201107193403.436146-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42f.google.com
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

This series is inspired by Peter's following patch:=0D
https://www.mail-archive.com/qemu-devel@nongnu.org/msg758178.html=0D
=0D
I started to audit the IRQ uses and fixed the easy problems.=0D
=0D
Unresolved ones:=0D
- stellaris_init() connects different TYPE_STELLARIS_GPTM=0D
  to the same ADC input (seems some weird kludge)=0D
- platform_bus_link_device() uses sysbus_has_irq() to check=0D
  if an device has IRQ mapped but it doesn't seem to work.=0D
=0D
Anyway enough audit for the day.=0D
=0D
Regards,=0D
=0D
Phil.=0D
=0D
Philippe Mathieu-Daud=C3=A9 (5):=0D
  hw/arm/armsse: Correct expansion MPC interrupt lines=0D
  hw/misc/stm32f2xx_syscfg: Remove extraneous IRQ=0D
  hw/arm/nseries: Remove invalid/unnecessary n8x0_uart_setup()=0D
  hw/arm/musicpal: Don't connect two qemu_irqs directly to the same=0D
    input=0D
  hw/arm/musicpal: Only use qdev_get_gpio_in() when necessary=0D
=0D
 include/hw/misc/stm32f2xx_syscfg.h |  2 --=0D
 hw/arm/armsse.c                    |  3 ++-=0D
 hw/arm/musicpal.c                  | 40 +++++++++++++++++++-----------=0D
 hw/arm/nseries.c                   | 11 --------=0D
 hw/arm/stm32f205_soc.c             |  1 -=0D
 hw/misc/stm32f2xx_syscfg.c         |  2 --=0D
 hw/arm/Kconfig                     |  1 +=0D
 7 files changed, 28 insertions(+), 32 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

