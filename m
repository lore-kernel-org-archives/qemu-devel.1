Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E25C38A29
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F6D20775
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zVwx0s8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F6D20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOfVx-0003m6-DO
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 06:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jOfUm-000265-PZ
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jOfUl-00036A-DV
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:42:16 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:36616)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jOfUl-00035l-7L
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:42:15 -0400
Received: by mail-wm1-x336.google.com with SMTP id a201so18015221wme.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 03:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HmmBVP9lJhtIH13EX9i16VWrS1EnJ/4YNTP37UUhzHw=;
 b=zVwx0s8dSoQu3BKLEChh/J+ds59m/SAovAJZjrCzLgTi6gl88g2PxMRUe3TXO5QP8F
 6HUI+BB1L5DZ6rIH9E2mkYH3/OedvET/Fv24CT7pgbUXGGysAaWQyUjDBhUMy5Z2Elcv
 yPyQ3mZ/+OEkuu4w8l+KhgfzJqx6d9yeQQBZ/bRUQUR/R9ZHv2C7csgY4GWR3Zdlzgu8
 P9x+1eWeWJSQjDO29TkjKP8sFLmIQHUvIbyD2ZqR+LEj7xxtpNZd1zRddhyTc7xDldfr
 Z8kbQef6x1Kmf/kWfUkyuL7wVy5nvvJIic+OZCKrVWAW2joUbe9mBBipo5rKwEkEGKD2
 adiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HmmBVP9lJhtIH13EX9i16VWrS1EnJ/4YNTP37UUhzHw=;
 b=pCumwopCbaChGGqg7cUAj8WBEx1sswr0D3XmDBzhQIGvqLsTmnV3u0k7OVmjV7wP09
 MPnqPqSsu4Ii7CqwOK2sJ2ahUHNapUwva+cWXBSnei8rEpa1pmf+q15jES+b78ZUbw3l
 BN8WboRXNDAqRVV3RxSYiBSJSs7NuVUAXwDNdBBW8WHBU/bY/WM7F1pGzVFud+mond/D
 ysoLm1TnhLqbmZFF4uTR9FSZGBWfdNqzjx5CW3BKclIh85B4DuYNjv+WlAeWQkjICt4J
 3HK2eXieHsxOffP/gDOvgPC84HZmDOqeg4Bj69ocBhUdgG9lhqwhYAvkb6XKRlF6oAi7
 6ILA==
X-Gm-Message-State: AGi0Pua9mS2yHYITNHzMGN3jZUfuILF9V6XcaTyZ2ER790zkQvzSMebq
 vrkDUR+nOq1m7hx7soLFSKmPvQ==
X-Google-Smtp-Source: APiQypJDHm/7+MovHg7b/EJXjo3Dm+D2JvfhbZQd5P3OuG5TAmXvPnNPyDggst4ICmdiwFQcgoA+kA==
X-Received: by 2002:a1c:ac44:: with SMTP id v65mr4653629wme.33.1586947333746; 
 Wed, 15 Apr 2020 03:42:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c1sm22434135wrc.4.2020.04.15.03.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2020 03:42:12 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EC2B11FF7E;
 Wed, 15 Apr 2020 11:42:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL for 5.0-rc3 0/8] a few small fixes (docker, user,
 pie and gdbstub)
Date: Wed, 15 Apr 2020 11:42:03 +0100
Message-Id: <20200415104211.9388-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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

The following changes since commit 2f7cc1fbd6f6655d900ca7f45973b9bd5330c6dd:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2020-04-14 20:09:52 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-more-fixes-150420-1

for you to fetch changes up to 377f8f08bebea7cd44617b0ac0a2baf307f5f055:

  gdbstub: Introduce gdb_get_float32() to get 32-bit float registers (2020-04-15 11:38:23 +0100)

----------------------------------------------------------------
More small fixes for rc3

  - tweak docker FEATURE flags for document building
  - include sphinx configure check in config.log
  - disable PIE for Windows builds
  - fix /proc/self/stat handling
  - a number of gdbstub fixups following GByteArray conversion

----------------------------------------------------------------
Alex Bennée (4):
      tests/docker: add docs FEATURE flag and use for test-misc
      configure: redirect sphinx-build check to config.log
      configure: disable PIE for Windows builds
      linux-user: fix /proc/self/stat handling

Peter Xu (1):
      gdbstub: i386: Fix gdb_get_reg16() parameter to unbreak gdb

Philippe Mathieu-Daudé (3):
      target/m68k/helper: Fix m68k_fpu_gdb_get_reg() use of GByteArray
      gdbstub: Do not use memset() on GByteArray
      gdbstub: Introduce gdb_get_float32() to get 32-bit float registers

 configure                                  |  5 +++-
 include/exec/gdbstub.h                     | 18 +++++++++++++
 linux-user/syscall.c                       | 43 +++++++++++++-----------------
 target/arm/gdbstub.c                       |  3 +--
 target/i386/gdbstub.c                      |  2 +-
 target/m68k/helper.c                       |  4 +--
 target/sh4/gdbstub.c                       |  6 ++---
 target/xtensa/gdbstub.c                    |  6 ++---
 tests/docker/dockerfiles/debian10.docker   |  2 ++
 tests/docker/dockerfiles/debian9.docker    |  2 --
 tests/docker/dockerfiles/fedora.docker     |  2 +-
 tests/docker/dockerfiles/travis.docker     |  2 +-
 tests/docker/dockerfiles/ubuntu.docker     |  2 +-
 tests/docker/dockerfiles/ubuntu1804.docker |  2 +-
 tests/docker/test-misc                     |  2 ++
 15 files changed, 57 insertions(+), 44 deletions(-)

-- 
2.20.1


