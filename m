Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60071C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 17:49:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B3D82076A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 17:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qApM+BKE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3D82076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw80s-0006SU-EY
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 13:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1jw80K-00061F-7p
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 13:49:08 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:33743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1jw80I-0006T3-Cq
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 13:49:07 -0400
Received: by mail-ot1-x335.google.com with SMTP id h13so4904155otr.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 10:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
 :content-disposition:content-transfer-encoding:user-agent;
 bh=DdUAmDYwe9Zfp9IM9hS+C8JuweoQCS5VTR+Tj4Mma4g=;
 b=qApM+BKENJNRA+FP4Ccf9gbPkazMRgJV6ivVOVrF/nCrN/wA43ERQEq2GPfdHeTT+0
 LgM/kMUbdw5/9IxpvDs9jx7p+spRpFO6ObMVwiUf1u2nvZ8ol5NerPwVRhU4AolrOZwQ
 qDoE4IRIBu6k/r386m1iPrpt13/CEU2GxpZIHMW07sjr2b2aUZRJ1pvapeonrFaOjUKD
 /RfMU8FFWBnHU6JgvnwG5mqpDSNezSINi1NZQL+4oBZFiQgCA3drRNcjk00IndT+RnEB
 jwV3Ajv7U0xto/4YnrspGd0cRkmjNM+SVzazebRt5jvNA78GNs7tgFv0ABxgrVq2ZINp
 1siw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :reply-to:mime-version:content-disposition:content-transfer-encoding
 :user-agent;
 bh=DdUAmDYwe9Zfp9IM9hS+C8JuweoQCS5VTR+Tj4Mma4g=;
 b=cmakuJSlwB4vfiwG9LtAM9XPwOqSCaW+tv7Q/OmvLomsameCqT4k0771MD9Yu/3bH4
 i2pVUsKVBtE5kW2kJtJoobX7OYel+ud1cpD9XNnKhZIU1Gz1nG4x6M6aFXIwO1IkFI+d
 EW3+SIhcxLkbWr4t4vBkdzA/DzY3z4kfgyC/b3d8uoe23A2xX/YFW/c5JXj1lryhQGCi
 BZh0YIGbEpUT7T3mAus6gA4zNPMFz8FzYZ/tt8YsqHo25cHhTs3j8mhMYWPv5W9MniAh
 T4/5MfIblhVftUnhy7G6InJ73XZXtv+71BpMMtUfxNfNr1J3a8iNP9GXPS0rueEIHdKq
 GdOw==
X-Gm-Message-State: AOAM530ST4fsNDXdktUZIJNDNsvrA+AHc3GFwNYMeXxjvjbSAypBBOln
 YWKoFJS5VPTdpTn66d7GGQ==
X-Google-Smtp-Source: ABdhPJzphk21dy/YCX22bdYV/EH905rUn6N8gXiVvt/Cuqkog6YVo+L/OTaYXvqCKmAFtSwWgyVHbg==
X-Received: by 2002:a05:6830:3109:: with SMTP id
 b9mr5346254ots.41.1594921744325; 
 Thu, 16 Jul 2020 10:49:04 -0700 (PDT)
Received: from serve.minyard.net ([47.184.146.204])
 by smtp.gmail.com with ESMTPSA id n17sm1299784ota.37.2020.07.16.10.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 10:49:03 -0700 (PDT)
Received: from minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:ac62:d225:13b5:8855])
 by serve.minyard.net (Postfix) with ESMTPSA id DD5CD1800CC;
 Thu, 16 Jul 2020 17:49:01 +0000 (UTC)
Date: Thu, 16 Jul 2020 12:49:00 -0500
From: Corey Minyard <minyard@acm.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [GIT PULL] I2C updates
Message-ID: <20200716174900.GL3235@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=tcminyard@gmail.com; helo=mail-ot1-x335.google.com
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
Reply-To: minyard@acm.org
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 45db94cc90c286a9965a285ba19450f448760a09:

  Merge remote-tracking branch 'remotes/mcayland/tags/qemu-openbios-20200707' into staging (2020-07-10 16:43:40 +0100)

are available in the Git repository at:

  https://github.com/cminyard/qemu.git tags/for-qemu-i2c-5

for you to fetch changes up to 73d5f22ecbb76dfc785876779d47787084ff0f42:

  hw/i2c: Document the I2C qdev helpers (2020-07-16 12:30:54 -0500)

----------------------------------------------------------------
Minor changes to:

Add an SMBus config entry

Cleanup/simplify/document some I2C interfaces

----------------------------------------------------------------
Philippe Mathieu-Daudé (6):
      hw/i2c/Kconfig: Add an entry for the SMBus
      hw/i2c/aspeed_i2c: Simplify aspeed_i2c_get_bus()
      hw/i2c: Rename i2c_try_create_slave() as i2c_slave_new()
      hw/i2c: Rename i2c_realize_and_unref() as i2c_slave_realize_and_unref()
      hw/i2c: Rename i2c_create_slave() as i2c_slave_create_simple()
      hw/i2c: Document the I2C qdev helpers

 hw/arm/aspeed.c             | 82 +++++++++++++++++++++++----------------------
 hw/arm/musicpal.c           |  4 +--
 hw/arm/nseries.c            |  8 ++---
 hw/arm/pxa2xx.c             |  5 +--
 hw/arm/realview.c           |  2 +-
 hw/arm/spitz.c              |  4 +--
 hw/arm/stellaris.c          |  2 +-
 hw/arm/tosa.c               |  2 +-
 hw/arm/versatilepb.c        |  2 +-
 hw/arm/vexpress.c           |  2 +-
 hw/arm/z2.c                 |  4 +--
 hw/display/sii9022.c        |  2 +-
 hw/i2c/Kconfig              |  8 +++--
 hw/i2c/Makefile.objs        |  3 +-
 hw/i2c/aspeed_i2c.c         |  3 +-
 hw/i2c/core.c               | 15 ++++-----
 hw/ppc/e500.c               |  2 +-
 hw/ppc/sam460ex.c           |  2 +-
 include/hw/i2c/aspeed_i2c.h |  2 +-
 include/hw/i2c/i2c.h        | 54 +++++++++++++++++++++++++++--
 20 files changed, 131 insertions(+), 77 deletions(-)


