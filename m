Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5DACA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 10:12:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 492CE2086D
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 10:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ysV1oR8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492CE2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ7RD-0005Nz-4p
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 06:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iQ7Hw-0002BE-JH
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 06:02:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iQ7Hu-0008JT-8I
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 06:02:44 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:38069)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iQ7Ht-00087m-Kv
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 06:02:42 -0400
Received: by mail-wr1-x435.google.com with SMTP id v9so5520948wrq.5
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 03:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CO7li4ggAqrNpqkhJDIu80PgBe3r0FMAXs4/XO9uCqk=;
 b=ysV1oR8itJGNgHtTJ0rikvkKwhuY6HXT5l9jDkZY1rRU37tG8U9VveEVVhi8HDXWbb
 wPg6iz5bGyX4k3AvZtnbTxg6dRP08mZpMXahCxvO5FlOjXGiarP846prbDxJWRXFPVmT
 T0nFWhBM4MLYrcPeLiDmg+rC1pOFhurWGpvpttMr0M5mPzBIArN0efybOwyp8F20LCv9
 l1LwDerhp9nH3UMvjSzGZXa0to/1VdC+JvOikekPMaJUrek1qcE3ggNH94ueJ8E73k/8
 uVAC5MDLIfKkz92wxuq//XFBuZbb8MpUyc7c+GyevBalJgmGYW5PGgOh6aba2Q7iESgi
 vzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CO7li4ggAqrNpqkhJDIu80PgBe3r0FMAXs4/XO9uCqk=;
 b=BKcos1v7n2fphnTnM/xx9FxctgI7RMQbZPaKvXolalyTjkZIrw62xGFtkhfGL34o0t
 UiKUuC+wH4z5QbGK9Z2ao5mVyvmOitu480F9fUgN20FBNmsQk1I/xhvap23YVEs4WZ2G
 snVx3dYu1Jt34ugdEGbsskmgw2IzNUtIdNwDiU0ve2NHeoI8xwfcQJbAuUeMSGfegRCL
 MeIuCC8pwf5KggZDfI1f/t2HbTocDTyZ0gAS4CKRJVG1LEgG6BHX5kz/uBZTe8xYwAuN
 i7MH3qdfBkAFiG0PBf6N8N7dBEkM38bz6QM2wpTFn3tYgRwv6eNSihbK/u27ZcIP4Frv
 okKw==
X-Gm-Message-State: APjAAAWbe6gYSyK8vkUtMIfnIwR//OLUIvMLfklVR0JkwwNcMsyI1nKa
 Tp4xoynYeec6AjBm20RqN+lQFg==
X-Google-Smtp-Source: APXvYqzYUDauY8ghiSUJYvytP13egXcgxpqZJO6yPcNTxo8hH/e6QPD09v03liyRwFJMvbpqmt/Jhg==
X-Received: by 2002:a5d:424a:: with SMTP id s10mr4520137wrr.108.1572516155989; 
 Thu, 31 Oct 2019 03:02:35 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g5sm3669077wmg.12.2019.10.31.03.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2019 03:02:33 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DAB0A1FF87;
 Thu, 31 Oct 2019 10:02:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 0/3] a couple of CI fixes
Date: Thu, 31 Oct 2019 10:02:29 +0000
Message-Id: <20191031100232.21992-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 68d8ef4ec540682c3538d4963e836e43a211dd17:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-tcg-plugins-281019-4' into staging (2019-10-30 14:10:32 +0000)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-next-311019-1

for you to fetch changes up to 2ecde8b2fb046516a0f2f53fb56b86db92d6fc13:

  Acceptance test: update kernel for m68k/q800 test (2019-10-31 09:58:20 +0000)

----------------------------------------------------------------
Fixes to get CI green again

  - fix m68k acceptance tests (Cleber)
  - stop build breakage (Daniel)

----------------------------------------------------------------
Cleber Rosa (2):
      Acceptance test: cancel test if m68k kernel packages goes missing
      Acceptance test: update kernel for m68k/q800 test

Daniel P. Berrangé (1):
      tests: fix conditional for disabling XTS test

 tests/Makefile.include                 |  2 +-
 tests/acceptance/boot_linux_console.py | 11 +++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)


-- 
2.20.1


