Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DE9C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 10:58:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5970720738
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 10:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZO2opZ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5970720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2YAd-00049f-BA
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 06:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k2Y9G-0002VO-Kt; Mon, 03 Aug 2020 06:56:54 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:44594)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k2Y9F-00026h-3Q; Mon, 03 Aug 2020 06:56:54 -0400
Received: by mail-wr1-x42b.google.com with SMTP id b6so33754109wrs.11;
 Mon, 03 Aug 2020 03:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FDLL9mpytzeUOW3SyMq5rHzKTExLRt72OxDLspn4Qd8=;
 b=vZO2opZ7Ag/vrZ7xp4skvsoh/pvfOy1bkcQpcKdket15UCMLdvugufSiCvxGTvRPT0
 c8O7OmWfVMiT677KcnB0V/Hl2fc53AaR94/eFZu+fU5FT33WD+rNn6r4rxgM2tIMicOb
 xcZIcQZMUtkgXew80skuHV7l70Ot6mZnewoH30JirOftEQw1Gyr7CAfdA6SNYyVd4zIy
 rJ/EiLEWQsSmUP3iQd3+Wrx8ZQrupCWOox9W40j3SBNngmiTtUv/nXNSjAt3vNvVaedb
 IYM0IosYAZ7QZwNys8kuUnHLbKq39oBJGLLIrpF8T9JbYkHh+Fed8VLqLAJvqx7E8IUX
 TS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=FDLL9mpytzeUOW3SyMq5rHzKTExLRt72OxDLspn4Qd8=;
 b=g7BNDQwt5w7cki/pnOvQHonf+ms1NW+EC95NwTIUlgrQ187V8wVabRa3dUjx2BjvEo
 PCC51D+cDN1Epng6VGiIqD9ne1Av/kzJlcqURocnTU4e/AT1vTF7Kgt+2B1peeTpVrWO
 f+64AgpF1+Od1p9eu7EqH0WtOmZbbEbab57nKifjYEcMffKwwQtt4TzlZQlTia4efhZh
 8y0y5Ue84jJ+y+KeR0o/Udt3aNmVjRkN6DLVddwTv9szgN7ldwo2t8pTop7iCfIm3fcf
 nFly70BI+co362j1cDIUy/romcuRJzuHIPv2czNvyH/Q1TMqUSYNvg+IfIjOZcjkDAw6
 oabw==
X-Gm-Message-State: AOAM5326zimwxI0hug38jmYKVpOk9Vs6wqG1peIa/k8dkYA4g+tUBe+f
 qmwqYvKdXKrUlna3p48UvjxM8jm/
X-Google-Smtp-Source: ABdhPJz7UZGUBWRPMyTQvRwTA4VlPy+dEpAJy3m4QMzOHhxCTyrgfgRgcSKvYhl93QgBKDC6ylZzxQ==
X-Received: by 2002:adf:e845:: with SMTP id d5mr14786871wrn.228.1596452210093; 
 Mon, 03 Aug 2020 03:56:50 -0700 (PDT)
Received: from localhost.localdomain (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id z11sm23103477wrw.93.2020.08.03.03.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 03:56:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1? 0/4] hw/arm/xilinx_zynq: Call qdev_connect_clock_in()
 before DeviceRealize
Date: Mon,  3 Aug 2020 12:56:43 +0200
Message-Id: <20200803105647.22223-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is not a critical issue, but still annoying if you use tracing.

Maybe it is worth fixing for forks that are based on release tags,
else consider it 5.2 material.

Anyway we can still discuss if qdev_connect_clock_in() is supposed to
be callable *after* DeviceRealize.

Philippe Mathieu-Daudé (4):
  hw/arm/xilinx_zynq: Uninline cadence_uart_create()
  hw/arm/xilinx_zynq: Call qdev_connect_clock_in() before DeviceRealize
  hw/qdev-clock: Uninline qdev_connect_clock_in()
  hw/qdev-clock: Avoid calling qdev_connect_clock_in after DeviceRealize

 include/hw/char/cadence_uart.h | 17 -----------------
 include/hw/qdev-clock.h        |  8 +++-----
 hw/arm/xilinx_zynq.c           | 24 +++++++++++++++++-------
 hw/core/qdev-clock.c           |  6 ++++++
 4 files changed, 26 insertions(+), 29 deletions(-)

-- 
2.21.3


