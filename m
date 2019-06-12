Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91889C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 17:51:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5088D20896
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 17:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gGpA0EwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5088D20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34166 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb7Pi-0006YL-AF
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 13:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41222)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hb7Gc-0008H3-Ch
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 13:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hb75p-0006BZ-V0
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 13:31:27 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:38637)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hb75p-00069l-MR
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 13:31:25 -0400
Received: by mail-wr1-x42a.google.com with SMTP id d18so17806381wrs.5
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 10:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yyFpVFOtvboViTv5bDBHWCNIaSZDAA/CScmkWq5+EUI=;
 b=gGpA0EwP5GithX4Auwf1w+9AGtx3EhOe5UPzyU8ifT777p63GXW8Il+IUOyQbDiATT
 qHZNOo4O1x2aa1ExG8U4GOWSGbVRK17CvTIAldeIDDHS5mBGu4kLhm9x5gF5AmFCFniL
 enoc5TTCpezrPxHoLXDw2KXkwDpus7bnurbCwPapCCimppkSL4Fid9cVMZ/h0oXdzqta
 QZlOJj/2avPQkOH7Cmjnzdlu5qnzUVFPUMHTVWqah8TXa0YPo5kKCyjLI2qxTzCszPai
 xJJNKOGGCWxDrQhQg+5Nq2FBlXXHLr9/mBHKdyLmJ/8Hl+gU3H9YcGKHNo3ke7msNaot
 6+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yyFpVFOtvboViTv5bDBHWCNIaSZDAA/CScmkWq5+EUI=;
 b=tWDVJq/LDubr5UvPQ2bRHHdEDZGUm/YgiIVhQiicezsliPWF4H57MQ/gsmRn4ae+Aw
 9FVft4xljoMGFJ4n7XDiV9oP0PJA+dxjo7vTyQ8AdDE/OveVZCw+v6MXUCYNhetmBjkd
 SKyr7eeuziPhlzEMFVGWOBUEj9Jk2OlWfVwQSqDBS1f3iqhwmawq9epKH2SYvD/on8gb
 08nt11CjFsO7t+LKjSAQGDYVq9YeY7zbn/TWK04liJxRFFmYtdFmlHxUDNlt6GkO/gTe
 g7r7kM2SzBu8BO3SqSnm0EsfQgZ6EvJre1zcj3hft0lGzWj77vSpulZmGhjYfq18MzOj
 k2+A==
X-Gm-Message-State: APjAAAX9YVNYKQclshkoEaBIIx7e8PyMoNYr4rwZ2xAOOrOpzwY1b/pI
 Je8mIcMSk4Wcw7IVkIFfMiUyBQ==
X-Google-Smtp-Source: APXvYqyue7LRziHDFfgjuN6IhNqrT5Ac0Wjsp992msH9iSTyt2b8mg3fQEMk6AGhm+d+gZXVmyZGMw==
X-Received: by 2002:adf:ce8f:: with SMTP id r15mr44139575wrn.122.1560360682695; 
 Wed, 12 Jun 2019 10:31:22 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id r6sm105980wrp.85.2019.06.12.10.31.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 12 Jun 2019 10:31:22 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 985CA1FF87;
 Wed, 12 Jun 2019 18:31:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Wed, 12 Jun 2019 18:31:21 +0100
Message-Id: <20190612173121.21057-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
Subject: [Qemu-devel] [PULL v3 00/40] testing, gdbstub and cputlb fixes
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

The following changes since commit a050901d4b40092dc356b59912c6df39e389c7b9:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.1-20190612' into staging (2019-06-12 14:43:47 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-gdbstub-cputlb-120619-3

for you to fetch changes up to ab4752ec8d9b0b19ab80915016b739350418a078:

  gdbstub: Implement qemu physical memory mode (2019-06-12 17:53:23 +0100)

----------------------------------------------------------------
Various fixes and updates:

  - editor config tweak for shell scripts
  - iotest updates (still not default for make check)
  - various docker updates
  - gcc/ubsan updates for travis
  - some clean-ups for tests/vm (no serial autoinstall)
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

Gerd Hoffmann (2):
      scripts: use git archive in archive-source
      tests/vm: python3 fixes

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
 tests/vm/Makefile.include                         |   12 +-
 tests/vm/basevm.py                                |   13 +-
 tests/vm/centos                                   |    6 +-
 22 files changed, 1813 insertions(+), 632 deletions(-)
 create mode 100644 tests/tcg/x86_64/system/boot.S
 create mode 100644 tests/tcg/x86_64/system/kernel.ld

--
2.20.1


