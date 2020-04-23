Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912BFC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB7120781
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jrc/QkjM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB7120781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRfLa-0008Tb-B6
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 13:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44580)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRfIc-0000wb-Ek
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRfIY-0005R0-9b
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:06 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37728)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRfIX-0005Og-QF
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:01 -0400
Received: by mail-wr1-x442.google.com with SMTP id k1so7728143wrx.4
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 10:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DDfY9Xjy0TwAD770BDjxfTfyEdrSWvZwRfkw1eCBjC4=;
 b=jrc/QkjMOtBeemA4rUQgSwWQqUoP5Evco06VRA+yl3DlIIRQSq7IuC2iX6pRLTQQD5
 qLczWXMaMX1kdwyYINRx8EaxCVM196KxGzxm5MvPyCksXsSKxBoByge0EqNnnLe0yXTJ
 XueYpqbb1CLg6XZVyVkoq02hzOR+7bmUQ7cuLxeLsopl3HhRriW3yWgeOfkXzvru8BUb
 V+tfMGiFfj/FEk5V4Wj7q8imz53DXR5WRNSU2Y31MkdeTZvUMIim1ezUmiS0+B7x6Jlh
 0/NS3rKpoiGqoF+4H2Cnie6/f/jLlFLa8RMX7YdUDJE2lak1bBadVbLRqVMSIEAgnqlq
 LzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DDfY9Xjy0TwAD770BDjxfTfyEdrSWvZwRfkw1eCBjC4=;
 b=IDf3S33nxEHeAKaZNKS0UfgWinWOWD/4ET1vjglvwY0JZTpnVaGmYuJPHaftc4uCz0
 +GAniR9c9A9tR8zBXb6j+Kg2jP3xygHWr71lJcIg1Fa+iAhaOFLO8XW1NI9dv8EyZc37
 KMjfiQdDJD0241gS8a9VMVJVeONwef1UZdoe89/dDaQmNE/9Bz7sJF3Rzykv/CM8A8nh
 JpsUw+7o1fGt1yzGdXl8597lOj8uOOjoC1xySVnz7rZ/ct7d9Txas4fBuk2mVt08Bsc0
 pzK6v6JQZFJzxYumacY+qzEILVO3tBjikUoVf9wMi607zxv0b5Jvzfx4qzoXPIT0nnGM
 yAtQ==
X-Gm-Message-State: AGi0PuZ+xEU1xkUyad9R3Ms6GXp0rx1D8zsqUhrnFR6Pa/KYKaH+YwVl
 SpsrcnNQR2Ia0APLGdv8q5zexg==
X-Google-Smtp-Source: APiQypLP3Qsm2+QU+aeEcwYVqReDsh82XwW+d2XZbObXi/V1ut/juOH56Ns+vlXxlwK/VJHEEAcUVQ==
X-Received: by 2002:a5d:658c:: with SMTP id q12mr6374363wru.128.1587661559790; 
 Thu, 23 Apr 2020 10:05:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e2sm4458556wrv.89.2020.04.23.10.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 10:05:58 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3A7FC1FF7E;
 Thu, 23 Apr 2020 18:05:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for 5.1 v1 00/14] guest_base, gdbstub and Travis
Date: Thu, 23 Apr 2020 18:05:43 +0100
Message-Id: <20200423170557.31106-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::442
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This is the current state of my random collection of fixes that didn't
make it into 5.0. The gdbstub related fixes will probably get queued
up separately (and possibly submitted for stable?) once the tree gets
re-opened. We have:

  - The linux-user guest_base rework (which enable more sanitisers)
  - A bunch of gdbstub related test fixes:
    - unix socket based debug for linux-user
    - a generic multiarch gdbstub test vase
    - some other clean-ups
  - some minor .travis updates
    - drop MacOSX from the build
    - add a diagnostic df -h to post build script

The following patches need review:

  - .travis.yml: drop MacOSX
  - .travis.yml: show free disk space at end of run
  - tests/tcg: add a multiarch linux-user gdb test
  - tests/guest-debug: use the unix socket for linux-user tests
  - gdbstub/linux-user: support debugging over a unix socket
  - gdbstub: eliminate gdbserver_fd global
  - tests/tcg: drop inferior.was_attached() test
  - tests/tcg: better trap gdb failures
  - configure: favour gdb-multiarch if we have it
  - linux-user: completely re-write init_guest_space

Alex Bennée (11):
  linux-user: completely re-write init_guest_space
  .gitignore: include common build sub-directories
  configure: favour gdb-multiarch if we have it
  tests/tcg: better trap gdb failures
  tests/tcg: drop inferior.was_attached() test
  gdbstub: eliminate gdbserver_fd global
  gdbstub/linux-user: support debugging over a unix socket
  tests/guest-debug: use the unix socket for linux-user tests
  tests/tcg: add a multiarch linux-user gdb test
  .travis.yml: show free disk space at end of run
  .travis.yml: drop MacOSX

Philippe Mathieu-Daudé (1):
  gdbstub: Introduce gdb_get_float64() to get 64-bit float registers

Richard Henderson (2):
  exec/cpu-all: Use bool for have_guest_base
  accel/tcg: Relax va restrictions on 64-bit guests

 configure                                   |   2 +-
 include/exec/cpu-all.h                      |  25 +-
 include/exec/gdbstub.h                      |  25 +-
 linux-user/qemu.h                           |  31 +-
 target/alpha/cpu-param.h                    |  15 +-
 accel/tcg/translate-all.c                   |  15 +-
 bsd-user/main.c                             |  12 +-
 gdbstub.c                                   | 120 ++++-
 linux-user/elfload.c                        | 503 ++++++++++----------
 linux-user/flatload.c                       |   6 +
 linux-user/main.c                           |  39 +-
 target/m68k/helper.c                        |   3 +-
 target/ppc/gdbstub.c                        |   4 +-
 target/ppc/translate_init.inc.c             |   2 +-
 .gitignore                                  |   1 +
 .travis.yml                                 |  29 +-
 tests/guest-debug/run-test.py               |  29 +-
 tests/tcg/aarch64/Makefile.target           |   5 +-
 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py |   4 -
 tests/tcg/aarch64/gdbstub/test-sve.py       |   4 -
 tests/tcg/cris/Makefile.target              |   1 +
 tests/tcg/multiarch/Makefile.target         |  14 +
 tests/tcg/multiarch/gdbstub/sha1.py         |  81 ++++
 23 files changed, 570 insertions(+), 400 deletions(-)
 create mode 100644 tests/tcg/multiarch/gdbstub/sha1.py

-- 
2.20.1


