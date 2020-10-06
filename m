Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68572C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:25:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCAC420796
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r7h3Fxcy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCAC420796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPqiI-0001iD-Qt
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 13:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kPqhJ-0000p5-Fm
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 13:24:21 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:34552)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kPqhG-0006C1-GE
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 13:24:21 -0400
Received: by mail-ej1-x641.google.com with SMTP id u8so18815377ejg.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 10:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6EoYhQEwepyJOet9GdIdyEvpKJ7MIJ8V+HlUJhfVcb8=;
 b=r7h3FxcyPANqlR9lbRX5DMqsDbiKZzS81YxNP1lvpKa2qeWgN0Y4LXWIobAgJSpM28
 TfOhtwBg3TOs0r50fheI8PyLLG775iTjjWEDnbdYVd/JLGYS8bvYXl6LFKOUZ//nSz29
 OnbIvc2ClB8DFZLYqpfUB7mlDtexmO8MvitC6Xo03gVi8FYAWB5bBa8isBP2+JjQ0T9K
 5rHqnepfU7K8VECvpUVAX7sTNpOYb/v+oaRReDzMZiEb2H5Z1/721Ad+wKYd3/idXq6a
 Oqdat+xB6tblQuPguqrBAMyhDm+PCSZOW4xJcsu7E1EW7DfHBidmg90/XePeCszB4vK3
 su4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6EoYhQEwepyJOet9GdIdyEvpKJ7MIJ8V+HlUJhfVcb8=;
 b=skdYEsfALDzMRQmWJVO4ANl5cVqobVplGwHgM0WQImw6yzCnNF2E68SAvvMwcV3ui6
 7ZRFgezaOAbzpurY+MP6qCruuq6fmdX2AkkzAnK1BO0aIrqMzeJwOXOGod59EiCLp9H3
 y4iKzvv/4Snzc1DU8I7ItKQZtVNCOe/zU/a8lFNryMh6uOvETEGUFYZOzng1xKUyUSfq
 EYjXQ0IlnT6xM9TFpwH4hGdGtv2apBmIXD9UQjw6q9o2R/5+boWZqhHy983E67yRNS7d
 clMpl+64rGRwxheR/NsvjZyvBTP3wyC8slDWisvCiXJkX32O8w1p11kHXXy2mC7de0s1
 9Kjw==
X-Gm-Message-State: AOAM532M+kkX2WzuiK/yGzu6NjEqovBYjG43sN5oTQPn36UeOxTE8R0L
 SeI4daIOuDqe4vIeZnU/GxNMHjrCUhoN65Vb
X-Google-Smtp-Source: ABdhPJz+HxAmmnwP7e+6m3IVDRfiGdqhxXy6sPOPsM47kxiVccGeHhcAmMB3hRWQmyUurnYiMIbz2g==
X-Received: by 2002:a17:906:3ad0:: with SMTP id
 z16mr625735ejd.193.1602005056569; 
 Tue, 06 Oct 2020 10:24:16 -0700 (PDT)
Received: from localhost.localdomain ([185.81.136.21])
 by smtp.gmail.com with ESMTPSA id a22sm2536968ejs.25.2020.10.06.10.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 10:24:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10.5 0/1] tests/tcg/aarch64: Add bti mmap smoke test
Date: Tue,  6 Oct 2020 12:23:58 -0500
Message-Id: <20201006172359.2998-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x641.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: 20201002215955.254866-1-richard.henderson@linaro.org
(linux-user: User support for AArch64 BTI)

Adding a second smoke test, which both tests PROT_BTI via the
syscall, as opposed to the ELF NOTE.


r~


Richard Henderson (1):
  tests/tcg/aarch64: Add bti mmap smoke test

 tests/tcg/aarch64/bti-2.c         | 108 ++++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |   7 +-
 2 files changed, 113 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/aarch64/bti-2.c

-- 
2.25.1

