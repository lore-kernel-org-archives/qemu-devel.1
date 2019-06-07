Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF37C46476
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:12:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A9A920B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SsrXm3Kp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9A920B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47148 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZAuy-0000xN-NS
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 05:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39331)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAoz-00047L-R0
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAox-0004GN-8M
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:01 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:32778)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZAov-0003rN-OE
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:05:58 -0400
Received: by mail-wr1-x429.google.com with SMTP id n9so1377508wru.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DbNqj0r2bAfwFlR25KVQZjxbggWeTpP31ghmGKBlEbw=;
 b=SsrXm3Kp2mr9lvF/6Luvc4iTOkdtQT2JtB6qL7TsYbGKTK7NhDHsh7gL8PbkhM3ikI
 p6IuMNu5zSz/4NFiREZWuFimSPrara4rR3Kc+l7m+7LlMRZxCKonCorWRtSMYWTaEYMB
 jVkTXDUGG3zIEBBJKsMyUyJetbDxTCUjl+BZGG44jZ8UySTHM0h/VMUKaTQKmTJ3RIEO
 7ijNx+9GHHKe2tqiYrjCSgJ3qX8vUWhQVLUnB5IeSJh+26W00oZaEtoUzXii9O5Ag8DB
 B8r2BY2xPJtD9ZYmCI2FDRazz43yrzAXVTOP3YKh109q0XrvvcSI3okNDXEWtsEOn/Qg
 Wo7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DbNqj0r2bAfwFlR25KVQZjxbggWeTpP31ghmGKBlEbw=;
 b=nrYUbtubrleov5XX2Zsakk9dkrHQ6b6WZo87jKlOJZ4M4KJLooZZq21gzjsFG/4hc+
 UPKsxmbfECfFsUGIum/j8MOUioL8J87zbpnDBCBWXQda46EZYxHyeJ2zd9Sdiqg9TQLO
 chmBQb31nunlB5gbUyHc4JKAHABisQDSyIkeT6BKFKoXZPLFC+oi3EMO+kqBn3xE4fVE
 3QEaTu/EEaIMtLj9d7Bx36mWO7xBj1bqV7Inpqwsswmo0Nn8qiCTZY2O6SCUWTEQ664q
 6r4DHbXBeCwLvNr5YSlOSIhHJfCjrmiqyySYo8jXqgoWeoCap7O3lr3VgjAunP4cuEUX
 YBww==
X-Gm-Message-State: APjAAAUVChZVq4fQRwdp7+Rdb5TvYCgdAEosmtHPWcChCW++cG3ZfTwQ
 HBtt4f4S/AH25iYfaVBAJTcr0w==
X-Google-Smtp-Source: APXvYqy5YrKu1LAF2lp1eP0aM6ipQTfeC+WRYXVYBnDhqYpWyvI8dqKX5BIFsVIYZz+NWP4HJw9zDQ==
X-Received: by 2002:adf:9ed3:: with SMTP id b19mr9823910wrf.292.1559898352996; 
 Fri, 07 Jun 2019 02:05:52 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id c17sm1161191wrv.82.2019.06.07.02.05.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:05:52 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0AF971FF87;
 Fri,  7 Jun 2019 10:05:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:04:59 +0100
Message-Id: <20190607090552.12434-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
Subject: [Qemu-devel] [PULL 00/52] testing, gdbstub and cputlb fixes
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

The following changes since commit 0d74f3b4277a7ecb0ccb80c865797d11f8e466f5:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-request' into staging (2019-06-06 14:09:14 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-gdbstub-cputlb-070619-1

for you to fetch changes up to 611a3db380ef9f670c5c82837c4889f7e19ded10:

  gdbstub: Implement qemu physical memory mode (2019-06-07 08:39:03 +0100)

----------------------------------------------------------------
Various fixes and updates:

  - editor config tweak for shell scripts
  - iotest updates (still not default for make check)
  - various docker updates
  - gcc/ubsan updates for travis
  - clean-ups for tests/vm including autoinstall
  - semihosting fix for Coverity
  - fixes for cputlb in 64-on-32 cases
  - gdbstub re-factor + maintainership update

----------------------------------------------------------------
Alex Bennée (13):
      editorconfig: add setting for shell scripts
      qemu-io-cmds: use clock_gettime for benchmarking
      tests/docker: Update the Fedora cross compile images to 30
      tests/docker: Update the Ubuntu image to 19.04
      .travis.yml: bump gcc sanitiser job to gcc-9
      .travis.yml: add clang ubsan job
      semihosting: split console_out into string and char versions
      cputlb: use uint64_t for interim values for unaligned load
      tests/tcg: better detect truncated reads
      tests/tcg: clean-up VPATH/TESTS for i386
      tests/tcg/x86_64: add a PVH crt.o for x86_64 system tests
      MAINTAINERS: put myself forward for gdbstub
      cputlb: cast size_t to target_ulong before using for address masks

Gerd Hoffmann (14):
      scripts: use git archive in archive-source
      tests/vm: python3 fixes
      tests/vm: send proxy environment variables over ssh
      tests/vm: use ssh with pty unconditionally
      tests/vm: run test builds on snapshot
      tests/vm: proper guest shutdown
      tests/vm: add vm-boot-{ssh,serial}-<guest> targets
      tests/vm: add DEBUG=1 to help text
      tests/vm: serial console support helpers
      tests/vm: openbsd autoinstall, using serial console
      tests/vm: freebsd autoinstall, using serial console
      tests/vm: netbsd autoinstall, using serial console
      tests/vm: fedora autoinstall, using serial console
      tests/vm: ubuntu.i386: apt proxy setup

Jon Doron (20):
      gdbstub: Add infrastructure to parse cmd packets
      gdbstub: Implement deatch (D pkt) with new infra
      gdbstub: Implement thread_alive (T pkt) with new infra
      gdbstub: Implement continue (c pkt) with new infra
      gdbstub: Implement continue with signal (C pkt) with new infra
      gdbstub: Implement set_thread (H pkt) with new infra
      gdbstub: Implement breakpoint commands (Z/z pkt) with new infra
      gdbstub: Implement set register (P pkt) with new infra
      gdbstub: Implement get register (p pkt) with new infra
      gdbstub: Implement write memory (M pkt) with new infra
      gdbstub: Implement read memory (m pkt) with new infra
      gdbstub: Implement write all registers (G pkt) with new infra
      gdbstub: Implement read all registers (g pkt) with new infra
      gdbstub: Implement file io (F pkt) with new infra
      gdbstub: Implement step (s pkt) with new infra
      gdbstub: Implement v commands with new infra
      gdbstub: Implement generic set/query (Q/q pkt) with new infra
      gdbstub: Implement target halted (? pkt) with new infra
      gdbstub: Clear unused variables in gdb_handle_packet
      gdbstub: Implement qemu physical memory mode

Philippe Mathieu-Daudé (1):
      tests/docker: Update the Fedora image to Fedora 30

Wainer dos Santos Moschetta (4):
      tests/vm: Use python configured on build
      tests/vm: Port basevm to Python 3
      tests/vm: Fix build-centos docker-based tests run
      tests/vm: Add missing variables on help

 .editorconfig                                     |    4 +
 .travis.yml                                       |   17 +-
 MAINTAINERS                                       |    4 +-
 accel/tcg/cputlb.c                                |    4 +-
 gdbstub.c                                         | 1761 +++++++++++++++------
 hw/semihosting/console.c                          |   34 +-
 include/hw/semihosting/console.h                  |   25 +-
 linux-user/arm/semihost.c                         |   31 +-
 qemu-io-cmds.c                                    |   77 +-
 scripts/archive-source.sh                         |   72 +-
 target/arm/arm-semi.c                             |    4 +-
 tests/docker/dockerfiles/fedora-cris-cross.docker |    2 +-
 tests/docker/dockerfiles/fedora-i386-cross.docker |    2 +-
 tests/docker/dockerfiles/fedora.docker            |    2 +-
 tests/docker/dockerfiles/ubuntu.docker            |   19 +-
 tests/tcg/i386/Makefile.softmmu-target            |   10 +-
 tests/tcg/multiarch/system/memory.c               |   36 +-
 tests/tcg/x86_64/system/boot.S                    |  277 ++++
 tests/tcg/x86_64/system/kernel.ld                 |   33 +
 tests/vm/Makefile.include                         |   37 +-
 tests/vm/basevm.py                                |  147 +-
 tests/vm/centos                                   |    6 +-
 tests/vm/fedora                                   |  187 +++
 tests/vm/freebsd                                  |  179 ++-
 tests/vm/netbsd                                   |  187 ++-
 tests/vm/openbsd                                  |  158 +-
 tests/vm/ubuntu.i386                              |    4 +
 27 files changed, 2635 insertions(+), 684 deletions(-)
 create mode 100644 tests/tcg/x86_64/system/boot.S
 create mode 100644 tests/tcg/x86_64/system/kernel.ld
 create mode 100755 tests/vm/fedora

-- 
2.20.1


