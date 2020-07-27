Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435D5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:25:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C51E2074F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h65uI9zC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C51E2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k02Bm-0008Ob-5V
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 08:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02Al-0006q8-9p
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:24:03 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:36969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02Ai-0006PV-SB
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:24:02 -0400
Received: by mail-wr1-x433.google.com with SMTP id y3so14671620wrl.4
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 05:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GVtDULOIuW8nL+N2YSoRhKZF7lLOni/tdVhTFUUal1I=;
 b=h65uI9zCETHC5Q6HSsMaI3tqW6T3N4S0uPZA8uUq3IJu/woMDcQX2TRENcezytAZz3
 wHICD3MsGajblDUHGZuAWQwQ7qmyWvqayMgW/LpQqwuiyGTOT4/58rlmopIg4SfA8x2U
 2hJyEjqIbMm1fpMPBtZ9IDARRBmyHk9cvuQiwEjPPRcOxM04swIKELhHTvzt2DLlwRCz
 kYonCyUfCgtUX9tyrltS2jA3gcdsqEy+4ahhQw8YljhF4CbzSreaj8LYef0UcqlniflJ
 vwIuvg9CYn3AyfRjIlA6aKrjwA8I4IFj8vG24CuXJGcBSH9oLkXV+FEZ2gmvlZ6ZQdn+
 ItTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GVtDULOIuW8nL+N2YSoRhKZF7lLOni/tdVhTFUUal1I=;
 b=leZj5MZ3q4jcqAxT1KVrsZXhSqnvY50bjUqfsV5z7QYqg17jltmYGfihhiOB89j0+b
 +90w2pEjlBZS0i/UzVCrF+v1A17qRdSZ4Bf+B1ZSRsVq4qKpvwDiZizLvW/ikyOFaE8I
 H1UpHP8uzokZBY5krDaHdBntcsdGs4fG5qROOnRbqElgVhdgZqWaHeBPSALP5VSCoTzu
 6OT7uFTNS3KGvfr74jF0/wajL7ASzGLnHlbm83Iu22ByhaAmpddxAxgSZAxvXhHPwBSZ
 bRSV3HFvbIV6rz/z8RReLbjV1b9rUbBECAyxpmZGWLeH7llUjFMhbH0QovUW7lAvD2JV
 0rcQ==
X-Gm-Message-State: AOAM530T64gx3ZwqOi4IJG+SDFZNp65Ne1cVfCqd2Rqa3sZtjhFekda2
 d/pcm5e9PajfKbt9X62XwbtMIeSp0b8=
X-Google-Smtp-Source: ABdhPJy0myknULeno/xAhnW/BEvX5BI0FodxsdocB5KHhqcY7B9LklW0cVdySLq72vsZt1kwLUgY4A==
X-Received: by 2002:a5d:4a90:: with SMTP id o16mr19324735wrq.87.1595852639192; 
 Mon, 27 Jul 2020 05:23:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p8sm13199306wrq.9.2020.07.27.05.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 05:23:58 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 637C01FF7E;
 Mon, 27 Jul 2020 13:23:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 00/16] various fixes for rc2 (semihosting, tcg, docker,
 tests/vm)
Date: Mon, 27 Jul 2020 13:23:41 +0100
Message-Id: <20200727122357.31263-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 194f8ca825854abef3aceca1ed7eb5a53b08751f:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20200725' into staging (2020-07-26 17:17:58 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-fixes-for-rc2-270720-1

for you to fetch changes up to 4a70232b1d26b0d73e1bce60b2c3bdb7e4279d16:

  tests/vm: add shutdown timeout in basevm.py (2020-07-27 09:41:58 +0100)

----------------------------------------------------------------
Various fixes for rc2:

  - get shippable working again
  - semihosting bug fixes
  - tweak tb-size handling for low memory machines
  - i386 compound literal float fix
  - linux-user MAP_FIXED->MAP_NOREPLACE on fallback
  - docker binfmt_misc fixes
  - linux-user nanosleep fix
  - tests/vm drain console fixes

----------------------------------------------------------------
Alex Bennée (8):
      shippable: add one more qemu to registry url
      util: add qemu_get_host_physmem utility function
      util/oslib-win32: add qemu_get_host_physmem implementation
      accel/tcg: better handle memory constrained systems
      linux-user: don't use MAP_FIXED in pgd_find_hole_fallback
      tests/docker: fix update command due to python3 str/bytes distinction
      tests/docker: fix binfmt_misc image building
      tests/docker: add support for DEB_KEYRING

KONRAD Frederic (2):
      semihosting: defer connect_chardevs a little more to use serialx
      semihosting: don't send the trailing '\0'

Laszlo Ersek (1):
      target/i386: floatx80: avoid compound literals in static initializers

Laurent Vivier (2):
      linux-user: fix clock_nanosleep()
      linux-user, ppc: fix clock_nanosleep() for linux-user-ppc

Robert Foley (3):
      python/qemu: Cleanup changes to ConsoleSocket
      python/qemu: Change ConsoleSocket to optionally drain socket.
      tests/vm: add shutdown timeout in basevm.py

 include/fpu/softfloat.h                       |   1 +
 include/qemu/osdep.h                          |  15 +
 accel/tcg/translate-all.c                     |   7 +-
 hw/semihosting/console.c                      |   4 +-
 linux-user/elfload.c                          |  10 +-
 linux-user/syscall.c                          |  15 +-
 softmmu/vl.c                                  |   5 +-
 target/i386/fpu_helper.c                      | 426 +++++++++++++-------------
 util/oslib-posix.c                            |  15 +
 util/oslib-win32.c                            |  11 +
 .shippable.yml                                |   2 +-
 python/qemu/console_socket.py                 | 137 +++++----
 python/qemu/machine.py                        |  14 +-
 python/qemu/pylintrc                          |   2 +-
 tests/docker/Makefile.include                 |   2 +-
 tests/docker/docker.py                        |  13 +-
 tests/docker/dockerfiles/debian-bootstrap.pre |   7 +
 tests/vm/basevm.py                            |  15 +-
 18 files changed, 390 insertions(+), 311 deletions(-)

-- 
2.20.1


