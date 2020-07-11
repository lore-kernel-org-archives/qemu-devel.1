Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13862C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 14:25:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC7D420720
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 14:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HuO9224c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7D420720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juGRW-0001l3-1J
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 10:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juGQa-0000bh-VH
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 10:24:32 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:52081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juGQY-0003uh-WA
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 10:24:32 -0400
Received: by mail-wm1-x332.google.com with SMTP id 22so8933465wmg.1
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 07:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=U/Oph6SmnWBvGF9fJeRVDOZRNTOLPbEqlwXqKuB7Iqo=;
 b=HuO9224cyYF4Vhbng/WGxlFyvK9DsfNY8wNk6sYQYuZotdGOBIo/nKdvfDi82+h4SR
 zqHT6Kx+dKup8TQnLlSlkLg8wcGzA0m76C3udSuZ/bEK7Dbt5KFc6TG6pqwJr5SZTCMN
 i8oatzTxwsnJGooTN1LJhhghu/a0mYaHuR2Bm7hZuaZIGLD+h4sFFOvKrwCLATVC7sA8
 ZYwPt3dxGZUQB8v8DR38K2cIs+z7LQ1pvHxXvh6P4y5eBQryHYHiFpOoiwcrfPRBX5bT
 CTNRSi6t0P6TwLKi83Uw2e9uMvyn38ai+lWsvblvwD9iq//intgl9kH8enNISpPtKrXi
 bdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=U/Oph6SmnWBvGF9fJeRVDOZRNTOLPbEqlwXqKuB7Iqo=;
 b=UotR8QgzYlZ0gEEIh4dmk2hA6nCRKtU9cQA+McubflYJYfYN3JkUmAWezTkTAKODG/
 KZTkgdqwGMxwl7eJjQvpEZQtJ6Tx7RWtMT9PuL0IypgPhcE+l9T1CBMkrOIifGgcTBOv
 lBKO592XsRmci9AL9mvzFjq3eyU3CzyHBzdK3JSgROrQDlyEopcOzwQXWXl11bTgn7Xs
 8cTWqZjy1LzeW3L4cTGyGfwUkz9YMbamkzIQ1xbov3If1+dwwF7JI5tsANz59xa9Owb+
 e1FxqNGdYuzf9yE9dVNzjaGvgxWGBKtKXkAo6tU5Y9r0uUNJiWdp8jURGgC063I2aPFT
 n0YQ==
X-Gm-Message-State: AOAM532QxjTDaoRHOkJUVjomYFjb++WHzWuVxQAsrMi513hwqmQiKzaT
 a0U5u0KQ/gKmEuO2L3bXyq5pgl9/x7vgSw==
X-Google-Smtp-Source: ABdhPJyJ/R3orizeK9cspsYyEzaVRtG0aKi36WCDDniemPW47uiXCJuj21ZUI3Ziigs1hp4om7Ydrg==
X-Received: by 2002:a7b:c956:: with SMTP id i22mr10729130wml.95.1594477468431; 
 Sat, 11 Jul 2020 07:24:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id u10sm13448525wml.29.2020.07.11.07.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 07:24:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 0/3] Move and improve qdev API doc comments
Date: Sat, 11 Jul 2020 15:24:22 +0100
Message-Id: <20200711142425.16283-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset adds documentation comments to qdev-core.h (and in a few
cases qdev-properties.h) to functions (but not all functions!) which
were missing them.

The prompt for this was Markus' recent welcome cleanup and correction
of the qdev realize functions to get reference count and bus parenting
handling right. Markus put doc comments for new/changed functions in
the qdev.c file. This is something where I have a fairly strong opinion:
 * the right place for doc comments for functions which expose API
   to the rest of QEMU is in the header file, not the .c file
 * we should be consistent about this, especially within a single
   header file but more generally as a project

So patch 1 moves doc comments from qdev.c to qdev-core.h (or
for a few functions qdev-properties.h) to join the doc comments
that were already in those header files. I have expanded on the
comments in some places where I thought that summaries of the
intended use case for the API was helpful.

Because I didn't want to send out a patch that was moving doc
comments around to fit my asserted preferred style and nothing else,
I have attempted to sweeten the pot a bit with patches 2 and 3, which
provide new doc comments for previously undocumented functions:
qdev_unrealize(), and also all the GPIO creation/connection APIs.

thanks
-- PMM

Peter Maydell (3):
  qdev: Move doc comments from qdev.c to qdev-core.h
  qdev: Document qdev_unrealize()
  qdev: Document GPIO related functions

 include/hw/qdev-core.h       | 267 ++++++++++++++++++++++++++++++++++-
 include/hw/qdev-properties.h |  13 ++
 hw/core/qdev.c               |  33 -----
 3 files changed, 278 insertions(+), 35 deletions(-)

-- 
2.20.1

