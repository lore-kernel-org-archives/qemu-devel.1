Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70782C47409
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 18:03:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D97F218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 18:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ykCY5eBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D97F218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihdf4-0006XW-M3
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 13:03:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihdcg-0004q0-UU
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:00:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihdcf-0002Lj-Lr
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:00:34 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36534)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihdcf-0002Hj-9L
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:00:33 -0500
Received: by mail-wm1-x344.google.com with SMTP id p17so2946897wma.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 10:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dEJElyVqy6KQVYSRgad8NqQZOp0Lzh3BaRgS4yZ5EiY=;
 b=ykCY5eBzZ6vsSkanHnBx6PL3MrUuRsH/WNQWnsJtMwlvae1cFTZu4G2yVUzWT25B3a
 XmY7gNrux8TZJqLWnzDCnZcVna3wtclve85UG4BD4Eltd30+DeaQnP/G0BpPMaqfpY6D
 ZD9NfzFhVgu6P1B4l7HiHecvQdC9sl7ZeJSyNcFzHKp9zGGPrt2zocoZ20YCFg6WC3g5
 5gA2QcEujxsqwAbpD/keCNPFDu+b4uNm7q0PxMWvCFnURvphvp3BqQj+auO7v2WkEeso
 /3d6yXE4yHT+Pg6MeTgXKph2wjEv0GQ+A7Niq3mrT5eYLXxGjoxmaPxOoLWZgxl/+s8F
 uWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dEJElyVqy6KQVYSRgad8NqQZOp0Lzh3BaRgS4yZ5EiY=;
 b=f6IMsl1DjCh14WYz2+iWP3wUiXOcuo9ofPzm7fKv6aTwUcQgPENbEcg0IJq12Ss3Eu
 zfcw6VK0qmB/yzAvUNuG3CJCeAnCafMBeMYbZrkAGmTlwtKL/HxnA0llGciLMiKHmk2O
 /kCXOCeTqTeL/N0t1FhZ96N+9n9xA7O1+EeveH5hzngpfyDmPhorCKt+DtPaqamnqSb4
 GoJ/BC3s0f2+4mk6rRknXMxJ2C8dDIaYZsKfwjXlDS7GDfzazLRoIy8m/PVU9j/MB+G7
 0kLkbc/x0gotgZxn2GAzQhDq64a26Q8iZVmW8RCqzTWi0H1tgohXHZbuEfNTCdKJdm9P
 /IFw==
X-Gm-Message-State: APjAAAWbrM6/9dtR2s5KdelV74zKM6y0i/XEWoXuIO0//Xm97hx5VgqQ
 Y4ssJCaAjvt1Eqy1uWEJqOAK/A==
X-Google-Smtp-Source: APXvYqzRdvxdmp3jqIcJU/ECM+qZXo9IOuaEQUx/SXb9WuqqWLEJDig09Iuhea6+NMRirqNdIu5dfA==
X-Received: by 2002:a1c:3d07:: with SMTP id k7mr4989988wma.79.1576692031987;
 Wed, 18 Dec 2019 10:00:31 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p15sm3217610wma.40.2019.12.18.10.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 10:00:30 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DAFD41FF87;
 Wed, 18 Dec 2019 18:00:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 0/4] semihosting read console support
Date: Wed, 18 Dec 2019 18:00:25 +0000
Message-Id: <20191218180029.6744-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: pbonzini@redhat.com, keithp@keithp.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series introduces a new "blocking" console read function for
semihosting and plumbs it in to the ARM semihosting code. The main bit
of work is Keith's patch (with a few tweaks by me). The other
preparatory patches make sure the PC is updated after semihosting
succeeds and a little bit of clean-up.

The following patches need review
   01 - target arm remove unused EXCP_SEMIHOST leg
   02 - target arm only update pc after semihosting compl
   04 - tests tcg add a dumb as bricks semihosting consol

Alex Bennée (3):
  target/arm: remove unused EXCP_SEMIHOST leg
  target/arm: only update pc after semihosting completes
  tests/tcg: add a dumb-as-bricks semihosting console test

Keith Packard (1):
  semihosting: add qemu_semihosting_console_inc for SYS_READC

 include/hw/semihosting/console.h          | 16 +++++
 include/hw/semihosting/semihost.h         |  4 ++
 hw/semihosting/console.c                  | 78 +++++++++++++++++++++++
 linux-user/aarch64/cpu_loop.c             |  1 +
 linux-user/arm/cpu_loop.c                 |  1 +
 linux-user/arm/semihost.c                 | 23 +++++++
 stubs/semihost.c                          |  4 ++
 target/arm/arm-semi.c                     |  3 +-
 target/arm/helper.c                       |  8 +--
 target/arm/m_helper.c                     |  1 +
 target/arm/translate-a64.c                |  2 +-
 target/arm/translate.c                    |  6 +-
 tests/tcg/aarch64/system/semiconsole.c    | 36 +++++++++++
 vl.c                                      |  3 +
 tests/tcg/aarch64/Makefile.softmmu-target |  9 ++-
 15 files changed, 182 insertions(+), 13 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/semiconsole.c

-- 
2.20.1


