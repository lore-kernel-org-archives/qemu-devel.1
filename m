Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A7DC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 11:37:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 741CE20866
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 11:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HizlvHtE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741CE20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59126 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb1Z1-0007B7-Fj
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 07:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39960)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hb1Vy-0004Wv-Uh
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 07:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hb1IG-0007gZ-N2
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 07:19:54 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:39708)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hb1IG-0007g8-EF
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 07:19:52 -0400
Received: by mail-wm1-x32b.google.com with SMTP id z23so6106939wma.4
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 04:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dBpxhXqeIOsaqUksoTl0c7WL4LW94d2a0rDTC4MnPmA=;
 b=HizlvHtEuwhbHtHY/+nW+VAhzmdm/kqIc9cfWr+40x23sFlVtTCzW/IP32ekN7qMES
 2BRzM4Im/IZgDLAoaJej+Rci+bacWMmAah6RAQn/RTfhCXh1aLuXKaJCxHQcW/So6aLl
 CdASLVnkH7Cyry58Q1bgFBZVKcaJEnmaRPyOCX1mPl6sMGAS96aGoD7peQ5HeBNdfhNd
 /mJzUOeEwdAvy5uoh/OwvbL6sHRwE9gSAx2CKmoa3FTSN0WHuCnzOsOJIlgc00h1klGr
 wUnNYHlZqhE6to16EFOENrcnqEDN9u2Ljuu3L7LmYHvfQRqGa/vvSnPDt+nUzC97X7tr
 F8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dBpxhXqeIOsaqUksoTl0c7WL4LW94d2a0rDTC4MnPmA=;
 b=uXyptQW2jDVEwmPtfaU109M1L8iB682EVIlvc5F5HivdsWWU/9jXRQmCM47z/F5RB9
 z22rE6zS7OZHpA7AzmtE5XkIj4NQT4qWiKq5vZfn708UW69MwRg3GUqpGi9hF8YPD0bK
 iprLlismkxcS/0gFtN+n02j+xOYwG3V+MyKBgcpfKSMQ/sAcCILiyDnZPbmoc/bSsadH
 tCVmWV/MuLFQHgFtXCHRtIsTX2yjgbiJlLKiZkiPrwoTkGXsgcx0f7DUy/xvmNgq6h+I
 1fxe797t3SZ/F/kqDibTWtIksLHjGZmnA4GsxLc/Ny9Q6BmL86I6e1wDOxqphQy7IjGy
 b6og==
X-Gm-Message-State: APjAAAWQmFEPNiMcuf1pAh+bnrav3qdLSSe6XOjfHh90h+GlWR7MUtjq
 J+nFlDGecfmLLR+rjcUp1sU1Mg==
X-Google-Smtp-Source: APXvYqzhO0G46fWWdY91H70MMXovQ23t2W4Du9lYMRaq56UYFBTQE4LWH6DbqtRqvNGrf0CKg6rKQQ==
X-Received: by 2002:a1c:be0a:: with SMTP id o10mr20496836wmf.91.1560338390666; 
 Wed, 12 Jun 2019 04:19:50 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id s8sm28135209wra.55.2019.06.12.04.19.50
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 12 Jun 2019 04:19:50 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B6EF11FF87;
 Wed, 12 Jun 2019 12:19:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Wed, 12 Jun 2019 12:19:49 +0100
Message-Id: <20190612111949.25117-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
Subject: [Qemu-devel] [PULL v2 00/52] testing, gdbstub and cputlb fixes
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

The following changes since commit 219dca61ebf41625831d4f96a720852baf44b762:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2019-06-11 16:02:07 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-gdbstub-cputlb-120619-2

for you to fetch changes up to dfffdccbf6984ad7042b3123cba9e29c4f3c9a2b:

  gdbstub: Implement qemu physical memory mode (2019-06-12 11:23:08 +0100)

----------------------------------------------------------------
Various fixes and updates:

  - editor config tweak for shell scripts
  - iotest updates (still not default for make check)
  - various docker updates
  - gcc/ubsan updates for travis
  - clean-ups for tests/vm including autoinstall (-netbsd)
  - semihosting fix for Coverity
  - fixes for cputlb in 64-on-32 cases
  - gdbstub re-factor + maintainership update

----------------------------------------------------------------
Alex Bennée (14):
      editorconfig: add setting for shell scripts
      qemu-io-cmds: use clock_gettime for benchmarking
      tests/docker: Update the Fedora cross compile images to 30
      tests/docker: Update the Ubuntu image to 19.04
      .travis.yml: bump gcc sanitiser job to gcc-9
      .travis.yml: add clang ubsan job
      tests/vm: favour the locally built QEMU for bootstrapping
      semihosting: split console_out into string and char versions
      cputlb: use uint64_t for interim values for unaligned load
      tests/tcg: better detect truncated reads
      tests/tcg: clean-up VPATH/TESTS for i386
      tests/tcg/x86_64: add a PVH crt.o for x86_64 system tests
      MAINTAINERS: put myself forward for gdbstub
      cputlb: cast size_t to target_ulong before using for address masks

Gerd Hoffmann (13):
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
 tests/vm/Makefile.include                         |   38 +-
 tests/vm/basevm.py                                |  168 +-
 tests/vm/centos                                   |    6 +-
 tests/vm/fedora                                   |  187 +++
 tests/vm/freebsd                                  |  179 ++-
 tests/vm/openbsd                                  |  158 +-
 tests/vm/ubuntu.i386                              |    4 +
 26 files changed, 2479 insertions(+), 675 deletions(-)
 create mode 100644 tests/tcg/x86_64/system/boot.S
 create mode 100644 tests/tcg/x86_64/system/kernel.ld
 create mode 100755 tests/vm/fedora

--
2.20.1


