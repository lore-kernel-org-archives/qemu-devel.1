Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F81C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:05:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E50620678
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lvuemCdN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E50620678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipCtM-0006xZ-Jn
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 10:05:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipCrK-0004hQ-Rq
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:02:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipCrJ-0000rI-P6
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:02:58 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38532)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipCrJ-0000qU-Ie
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:02:57 -0500
Received: by mail-wm1-x341.google.com with SMTP id u2so2849261wmc.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 07:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZR+fSZ65G9mh9dWenUCDIdFjZP+YKTJKCn5ENAM0Yck=;
 b=lvuemCdNBwgcFWY3z67e9djxeT0mCluOdSmQvYhKtrKSiUNaMEp5CLuWmDh3RDnhjN
 zUjFIlwuRgPYq5zjtiMUaG6lkRU8y9fnVY/OrcCO/CvfDbLsSBqwfjdUusQYpJhJSLa6
 iUOscw4oq8dnR9EKVFDfXXlfa2FOGdHx472hIpZosuIE2y6/aLPI7kXpqCBtVbs8J4+5
 N4G00M5lNeFa531RzbpsI2sPRuwoUct0wqrXKp33UBOsYRbsTSTHAILuKGE//LfnrgkH
 jugl7Vb4XRAPGT6i4mYUZ+C1xrjkIP6iKrdvdW7NsqF5VWqpTRBf16/XOVmEUG8SVL22
 0v4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZR+fSZ65G9mh9dWenUCDIdFjZP+YKTJKCn5ENAM0Yck=;
 b=bY9APrYdWxIC1+soS8gVYlKi9FV/k6aZw+UM8/R2r0Zl9srY0Ip0AfXiw5rWJAvmue
 I0cGim5k0M2zorJJtAUmbRgFHOyTzUCDiaVYKCHZHii1zcQPJ/bqaeKZVjO9LKO0ppIa
 LcEbncUqh4g1UW9YeTLiA2v5bsUF6EbBhucSOb1sZOIo3YV1jCQj0oVtZiFzB02MFUrq
 KcPSMA9v+rEQReT2ADrqzUECfTGlc9rha+/3y9QlYR3mp43o4laNw5StzDVfwiKzSOwB
 F3IJXGrnlin38XaXY2+eFpABnNbemSIMblm5Mbt5bfTXQZ3jTitehEwlvub9LXSgcj5i
 P3lA==
X-Gm-Message-State: APjAAAU85ri4tIjd4Hm68EK2uxOnvYR+85A2m0L80o1TLOacPA9DTuQo
 E1Pi35/GdTGAZRkMC+D+gb9hrA==
X-Google-Smtp-Source: APXvYqxau346v9TJftgCyciiJsJD68g3lMo/CP7WimLQElcmd5g7PBt68lJB8wFQxVz3s5KB4n0psA==
X-Received: by 2002:a1c:6a07:: with SMTP id f7mr4496202wmc.171.1578495776354; 
 Wed, 08 Jan 2020 07:02:56 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m10sm4566150wrx.19.2020.01.08.07.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 07:02:53 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E5EA71FF87;
 Wed,  8 Jan 2020 15:02:52 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 0/6] semihosting read console support
Date: Wed,  8 Jan 2020 15:02:46 +0000
Message-Id: <20200108150252.6216-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: keithp@keithp.com, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

No major changes from the previous version except some tweaking of the
tests to exercise both thumb and arm modes. There is a minor
refactoring so the __semi_call helper can be re-used. I'm planning on
sending the PR in with my gdbstub fixes later this week.

The following patches need review
  05 - tests tcg extract __semi_call into a header and e
  06 - tests tcg add user version of dumb as bricks semi

Alex Bennée (5):
  target/arm: remove unused EXCP_SEMIHOST leg
  target/arm: only update pc after semihosting completes
  tests/tcg: add a dumb-as-bricks semihosting console test
  tests/tcg: extract __semi_call into a header and expand
  tests/tcg: add user version of dumb-as-bricks semiconsole test

Keith Packard (1):
  semihosting: add qemu_semihosting_console_inc for SYS_READC

 include/hw/semihosting/console.h          | 16 +++++
 include/hw/semihosting/semihost.h         |  4 ++
 tests/tcg/arm/semicall.h                  | 35 ++++++++++
 hw/semihosting/console.c                  | 79 +++++++++++++++++++++++
 linux-user/aarch64/cpu_loop.c             |  1 +
 linux-user/arm/cpu_loop.c                 |  1 +
 linux-user/arm/semihost.c                 | 27 ++++++++
 stubs/semihost.c                          |  4 ++
 target/arm/arm-semi.c                     |  3 +-
 target/arm/helper.c                       |  8 +--
 target/arm/m_helper.c                     |  1 +
 target/arm/translate-a64.c                |  2 +-
 target/arm/translate.c                    |  6 +-
 tests/tcg/aarch64/system/semiconsole.c    | 38 +++++++++++
 tests/tcg/arm/semiconsole.c               | 27 ++++++++
 tests/tcg/arm/semihosting.c               | 21 +-----
 vl.c                                      |  3 +
 tests/tcg/aarch64/Makefile.softmmu-target |  9 ++-
 tests/tcg/aarch64/Makefile.target         |  7 ++
 tests/tcg/arm/Makefile.target             | 28 ++++++++
 20 files changed, 287 insertions(+), 33 deletions(-)
 create mode 100644 tests/tcg/arm/semicall.h
 create mode 100644 tests/tcg/aarch64/system/semiconsole.c
 create mode 100644 tests/tcg/arm/semiconsole.c

-- 
2.20.1


