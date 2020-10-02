Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D21C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9426120719
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDh4pV1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9426120719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOOFE-0003Fi-FA
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 12:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOO8Y-0004GW-SR; Fri, 02 Oct 2020 12:42:26 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40167)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOO8X-0005dE-BB; Fri, 02 Oct 2020 12:42:26 -0400
Received: by mail-wr1-x441.google.com with SMTP id j2so2519012wrx.7;
 Fri, 02 Oct 2020 09:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QJ73gD1Uc7sEkC9QbqMVDttq6asn/T6Kh/yxfjBEUp0=;
 b=KDh4pV1ceGZZTuxJs5aUhU91MGb4YjeVBG+mdh69E4f53aSZQpk2Ta8E9dvUBVXeLm
 +oya7gV69PW7WNIEKhAPgTLmNnCuDmPGAD1E66kMAYV5QU7/eHKslc7fdOCMKiTbbGvy
 8mPvqGPw1H2pr+wA07HKTvYscP4yrj/viDkqRuc7HFtgVBPnvMugAmqUw5xFZ/yd788n
 g1mG8sspfPy3ZyvqQj8HejfJ/dMTODJ6lEOmxDqa/0UVJCcj2gNbNi/NhX/Kfmk7zeo4
 HO4ipcOSdAgpvLRSsh263eLDg+8L911wWrwGytG5TM8Ju4cQqbdJ8g/MveOZyrYZ7jRZ
 0ymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=QJ73gD1Uc7sEkC9QbqMVDttq6asn/T6Kh/yxfjBEUp0=;
 b=YTYwItm5XF/5dbPkJ7kOPdHCnVdUQrJjgLdFUMyKvI4fEhwnDLxe4wWvJuOywm1OXc
 5LA5BeIEr0so3bnUwXyTo0D4OycYiXVq8GDRQ4QbEgWGPDFVdsLMq/U06KRNm3in75Qn
 cGR/7tOgI4H6qoXdANlABIiFnJmCp2e52dYhml/QseO0S5cjwRkygIhnTR7cyWtJhJlk
 5eqAmNRsPpsde+9sqhc4JVaehvyePxqjtnF5JOYYvDi9ZLfBd+Doc5vq0VJwbPuiJPMa
 7DIZtvdDQvXqxSekONZFQYtqbWzp//ticSPU20hsHoU7eskw61cOrt9RpYv2i/GvHZHl
 ITXw==
X-Gm-Message-State: AOAM5325pEqIqkFItUs5QKAp2pIpNVukWnggBb/AfcH/H1l3/G9YKy7v
 ikEF2vZ3sHHtjZg3aK3sN6xVEmZr+Ms=
X-Google-Smtp-Source: ABdhPJydccUqaErHkbxPw5tJExtimzS0oH/uUzTQN4k89U5DRCsxarx2xO12IwWgAyZwBX+5RSLOyA==
X-Received: by 2002:a5d:4104:: with SMTP id l4mr4078197wrp.396.1601656943473; 
 Fri, 02 Oct 2020 09:42:23 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id t17sm2378673wrx.82.2020.10.02.09.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 09:42:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/4] hw/arm/bcm2835_peripherals: Correctly wire the
 SYS_timer IRQs
Date: Fri,  2 Oct 2020 18:42:16 +0200
Message-Id: <20201002164216.1741110-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201002164216.1741110-1-f4bug@amsat.org>
References: <20201002164216.1741110-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The SYS_timer is not directly wired to the ARM core, but to the
SoC (peripheral) interrupt controller.

Fixes: 0e5bbd74064 ("hw/arm/bcm2835_peripherals: Use the SYS_timer")
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2835_peripherals.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 15c5c72e46..48909a43c3 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -171,8 +171,17 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->peri_mr, ST_OFFSET,
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->systmr), 0));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->systmr), 0,
-        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_ARM_IRQ,
-                               INTERRUPT_ARM_TIMER));
+        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
+                               INTERRUPT_TIMER0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->systmr), 1,
+        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
+                               INTERRUPT_TIMER1));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->systmr), 2,
+        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
+                               INTERRUPT_TIMER2));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->systmr), 3,
+        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
+                               INTERRUPT_TIMER3));
 
     /* UART0 */
     qdev_prop_set_chr(DEVICE(&s->uart0), "chardev", serial_hd(0));
-- 
2.26.2


