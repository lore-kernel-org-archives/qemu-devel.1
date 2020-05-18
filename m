Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09019C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C942070A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2UWzEgc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C942070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jacSM-0004YC-1e
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 05:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jacRL-000302-UG; Mon, 18 May 2020 05:52:07 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:40294)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jacRL-00016w-CO; Mon, 18 May 2020 05:52:07 -0400
Received: by mail-wm1-x333.google.com with SMTP id n18so5324710wmj.5;
 Mon, 18 May 2020 02:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WvhO0XD3doXCMQ8rMKnn7mvCal5MZcCXsSjroK8mK+I=;
 b=d2UWzEgc8cVSkySrFiLuj7Dov2JtYTEcKnj5CSeqb8hvzCF1JgVXG2Ma5u7eUuu1fQ
 UwAEgheDs4KvjbZWbrcgP/MfOPyHF3qRb4pIGywu8HtUQu/OLgoUV6qkXxwxnG4ZTLf5
 NIf6+QzNG9O2jgbr/OlqWD3hfq368uEyo9qUDoiozjfpgpjudgSsScmRLfg/uNnC2Z50
 zFeMRDhOy/wfHwk6VIpaJnMpuG5sT9uR4Ri0vcDwUD3tDo93KRgONv87jdTP5v6vpsem
 crTE+FAyia0PmxmO38thTI5D4G6qCco+S8yS4Qic4T9wxt6Q0Yqap01jbVZZr4m2kQIf
 G7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=WvhO0XD3doXCMQ8rMKnn7mvCal5MZcCXsSjroK8mK+I=;
 b=ItMK92yIzMN9LxPSDn9zpZ8fni/hKLMJIAtX+0uyo4qTXDjJ2jVO36UR7715eOM5ly
 BT97vcnqr1ROWN5c5muuH1O1GySPRlIzB/j8OCfdvEP8CIzwS42FKfj9HhwEZK7eY+/j
 QMhQVipGPjSpgmog5ReeKtrxmZM5k1ELWSgF5Ksu4f642cXmx5D+nQ8Bcgn4+Y+uRrfu
 KfF9/n5Pd4/PZKq7lzgAVtTDCJiOyXGxNqcDc1QbVkn2QjTxWyeU59Dihddab4I1nUfC
 bc1TbHSGhW+rwZsYjHPWy7eYz0addXzxvltkFOoXkUuBXCYR0N1y0W7SxkLlQcIloZ4i
 ZSIA==
X-Gm-Message-State: AOAM533C0XOQftokTtac27PS+gNltVpP4ZBKOzSHHXEXjNmQoqKmZHJz
 Be6uJ8TDY/T/R+BHsv2dAMGg6Pbg+OM=
X-Google-Smtp-Source: ABdhPJw60BZSNh4jvBOluni5EHk5+3HaVE7TitnRZRQqPEubLuXG+CGiucGxVp3HPuzBF2of/xVtKg==
X-Received: by 2002:a1c:3bc5:: with SMTP id i188mr18483971wma.90.1589795525481; 
 Mon, 18 May 2020 02:52:05 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id r9sm5453542wra.52.2020.05.18.02.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 02:52:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] hw/arm: Replace hw_error() by qemu_log_mask()
Date: Mon, 18 May 2020 11:51:59 +0200
Message-Id: <20200518095203.1013-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When fuzzing the devices, we don't want the whole process to
exit calling hw_error().
Replace these calls by qemu_log_mask LOG_GUEST_ERROR/LOG_UNIMP
when possible.

Philippe Mathieu-Daudé (4):
  hw/arm/integratorcp: Replace hw_error() by qemu_log_mask()
  hw/arm/pxa2xx: Replace hw_error() by qemu_log_mask()
  hw/char/xilinx_uartlite: Replace hw_error() by qemu_log_mask()
  hw/timer/exynos4210_mct: Replace hw_error() by qemu_log_mask()

 hw/arm/integratorcp.c     | 23 +++++++++++++++--------
 hw/arm/pxa2xx_gpio.c      |  7 ++++---
 hw/char/xilinx_uartlite.c |  5 +++--
 hw/display/pxa2xx_lcd.c   |  8 +++++---
 hw/dma/pxa2xx_dma.c       | 14 +++++++++-----
 hw/timer/exynos4210_mct.c | 10 ++++------
 6 files changed, 40 insertions(+), 27 deletions(-)

-- 
2.21.3


