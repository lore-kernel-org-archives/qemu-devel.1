Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE14CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:48:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D6DD20867
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zaR67hXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6DD20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtOj-0001D1-C4
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 02:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtDt-0002zJ-6w
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtDq-0008MC-Uo
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:21 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:51256)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtDq-0008Lr-NR
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:18 -0400
Received: by mail-wm1-x334.google.com with SMTP id q70so768677wme.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QiLCw+HqjMKWNbo6OT6iKSPYUG2C5m+q67Dm4pPFqR0=;
 b=zaR67hXVhk60cEqu2B/9FbI9EhqldeISsWg9ygxkbIBzScIaefkfSI2cBBmmrGXaEG
 vfd/gJglCHGc8kc+xXQ+8/FEMQ2pdIZEmHBv35hHZgT3uCx14tLLvFK4LzqbCJhkpsbc
 N+IWYcHRv4Rt7c4RW9W5GKs2+jRVE/vU7Fh0Lh3lPcpTNKIzJbV6dtnRCm05hLCdYi3G
 EH+bNibUNOFzMZRDFSH7tpZRvdNcLIOrUDl7eh3irdBNrbSgrYpt1Ek3frU2FiN8J242
 AT8Re9NA7D/TYtN3Q8jbIBpoSXVg23nmCdJwWXRyVLF6EbtVLnTpnq5X7+IR+MykrgGm
 L+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QiLCw+HqjMKWNbo6OT6iKSPYUG2C5m+q67Dm4pPFqR0=;
 b=rscuAWpGhbx1zgvlKIIzfIC5WnInN9pACMGFHiNv2I4lNE10reTZApBl1Bk3zNlhnE
 vyom/FLbdcIaIHvrEARx/lXEHRDgkG72RRfQfh/mxJbncwL+tm2crP6HxBTFv3T9Jp/V
 uGHcb+D+XUGUxzTsRbdvdxfps7XV02KSOLaYXjT9Jzp5DE7jZ3kExkX8HrbM6eR1XsJ4
 yhHcxJen6Vj/0Qq/fig/b12FY+5RKZC5jxr+Y1HUxtg+zCk6VSiyAJoBZ1xRLbhBFYHX
 xM5p/lSf50BrgLB37u6jQWJQ4cepsKvNo9O6V4MIbDlc0LS+v0Aiu5sKvBBJmFYiGut/
 hNVg==
X-Gm-Message-State: APjAAAVHrHz3BXAxSV/unt6J+ZeWxBq00OYroR3g6Owi5Jkt8JGODK4p
 X0LBpcEn5nAEJ1S5ed2OpeeAFWKoRVo=
X-Google-Smtp-Source: APXvYqzbxkGO9y5HmC/Th8re2spmzGAiszI4n/bKvnlXEPaGfun+W8vmAhadVEV4T3U/E/vBTzBz/g==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr1931617wmb.89.1571985437343; 
 Thu, 24 Oct 2019 23:37:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n187sm1537065wmb.47.2019.10.24.23.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:37:14 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B46771FF87;
 Fri, 25 Oct 2019 07:37:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 00/73] tcg plugins and testing updates
Date: Fri, 25 Oct 2019 07:36:00 +0100
Message-Id: <20191025063713.23374-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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

The following changes since commit 81c1f71eeb874c4cbbb9c5c4d1a1dc0ba7391dff:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2019-10-24 10:43:20 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-and-plugins-241019-2

for you to fetch changes up to 18900c2d7901680457b51b3ad3f684ef9cba8b64:

  travis.yml: enable linux-gcc-debug-tcg cache (2019-10-24 22:31:29 +0100)

----------------------------------------------------------------
Core TCG plugin support and testing updates

  - TCG plugin support
  - netbsd VM autoinstall
  - various Travis dependency updates
  - enable tcg debug for check-tcg
  - additional Xcode build for Cirrus
  - dependency tweak for gitlab

----------------------------------------------------------------
Alex Bennée (30):
      travis.yml: reduce scope of the --enable-debug build
      travis.yml: bump Xcode 10 to latest dot release
      cirrus.yml: add latest Xcode build target
      travis.yml: cache the clang sanitizer build
      travis.yml: --enable-debug-tcg to check-tcg
      tests/docker: set HOST_ARCH if we don't have ARCH
      tests/docker: update Travis image to a more current version
      trace: add mmu_index to mem_info
      docs/devel: add plugins.rst design document
      plugin: add implementation of the api
      plugins: implement helpers for resolving hwaddr
      cputlb: ensure _cmmu helper functions follow the naming standard
      configure: add --enable-plugins
      plugin: expand the plugin_init function to include an info block
      plugin: add qemu_plugin_insn_disas helper
      plugin: add qemu_plugin_outs helper
      tests/tcg/Makefile.target: fix path to config-host.mak
      tests/tcg: set QEMU_OPTS for all cris runs
      tests/tcg: move "virtual" tests to EXTRA_TESTS
      tests/tcg: drop test-i386-fprem from TESTS when not SLOW
      tests/tcg: enable plugin testing
      tests/plugin: add a hotblocks plugin
      tests/plugin: add instruction execution breakdown
      tests/plugin: add hotpages to analyse memory access patterns
      accel/stubs: reduce headers from tcg-stub
      include/exec: wrap cpu_ldst.h in CONFIG_TCG
      .travis.yml: add --enable-plugins tests
      scripts/checkpatch.pl: don't complain about (foo, /* empty */)
      MAINTAINERS: add me for the TCG plugins code
      travis.yml: enable linux-gcc-debug-tcg cache

Eduardo Habkost (2):
      tests/vm: Let subclasses disable IPv6
      tests/vm/netbsd: Disable IPv6

Emilio G. Cota (32):
      trace: expand mem_info:size_shift to 4 bits
      cpu: introduce cpu_in_exclusive_context()
      translate-all: use cpu_in_exclusive_work_context() in tb_flush
      plugin: add user-facing API
      plugin: add core code
      queue: add QTAILQ_REMOVE_SEVERAL
      cputlb: document get_page_addr_code
      cputlb: introduce get_page_addr_code_hostp
      tcg: add tcg_gen_st_ptr
      plugin-gen: add module for TCG-related code
      atomic_template: add inline trace/plugin helpers
      tcg: let plugins instrument virtual memory accesses
      translate-all: notify plugin code of tb_flush
      *-user: notify plugin of exit
      *-user: plugin syscalls
      cpu: hook plugin vcpu events
      plugin-gen: add plugin_insn_append
      translator: add translator_ld{ub,sw,uw,l,q}
      target/arm: fetch code with translator_ld
      target/ppc: fetch code with translator_ld
      target/sh4: fetch code with translator_ld
      target/i386: fetch code with translator_ld
      target/hppa: fetch code with translator_ld
      target/m68k: fetch code with translator_ld
      target/alpha: fetch code with translator_ld
      target/riscv: fetch code with translator_ld
      target/sparc: fetch code with translator_ld
      target/xtensa: fetch code with translator_ld
      target/openrisc: fetch code with translator_ld
      translator: inject instrumentation from plugins
      plugin: add API symbols to qemu-plugins.symbols
      tests/plugin: add sample plugins

Gerd Hoffmann (1):
      tests/vm: netbsd autoinstall, using serial console

Lluís Vilanova (2):
      vl: support -plugin option
      linux-user: support -plugin option

Philippe Mathieu-Daudé (1):
      travis.yml: Test the release tarball

Thomas Huth (5):
      travis.yml: Add libvdeplug-dev to compile-test net/vde.c
      travis.yml: Use libsdl2 instead of libsdl1.2, and install libsdl2-image
      travis.yml: Use newer version of libgnutls and libpng
      travis.yml: Fix the ccache lines
      gitlab-ci.yml: Use libvdeplug-dev to compile-test the VDE network backend

 .cirrus.yml                               |  11 +
 .gitlab-ci.yml                            |   2 +-
 .shippable.yml                            |   2 -
 .travis.yml                               |  69 ++-
 MAINTAINERS                               |   6 +
 Makefile                                  |  16 +-
 Makefile.target                           |   2 +
 accel/stubs/tcg-stub.c                    |   1 -
 accel/tcg/Makefile.objs                   |   1 +
 accel/tcg/atomic_common.inc.c             |  54 ++
 accel/tcg/atomic_template.h               |  94 +--
 accel/tcg/cpu-exec.c                      |   8 +-
 accel/tcg/cputlb.c                        |  84 ++-
 accel/tcg/plugin-gen.c                    | 932 ++++++++++++++++++++++++++++++
 accel/tcg/plugin-helpers.h                |   5 +
 accel/tcg/translate-all.c                 |  15 +-
 accel/tcg/translator.c                    |  20 +
 accel/tcg/user-exec.c                     |   3 +
 bsd-user/syscall.c                        |  24 +-
 configure                                 |  89 +++
 cpus-common.c                             |   4 +
 cpus.c                                    |  10 +
 disas.c                                   | 110 ++++
 docs/devel/index.rst                      |   1 +
 docs/devel/plugins.rst                    | 112 ++++
 exec.c                                    |   2 +
 hw/core/cpu.c                             |   2 +
 include/disas/disas.h                     |   2 +
 include/exec/cpu-defs.h                   |   1 +
 include/exec/cpu_ldst.h                   |  11 +
 include/exec/cpu_ldst_template.h          |  41 +-
 include/exec/cpu_ldst_useronly_template.h |  32 +-
 include/exec/exec-all.h                   |  64 +-
 include/exec/helper-gen.h                 |   1 +
 include/exec/helper-proto.h               |   1 +
 include/exec/helper-tcg.h                 |   1 +
 include/exec/plugin-gen.h                 |  71 +++
 include/exec/translator.h                 |  62 +-
 include/hw/core/cpu.h                     |  19 +
 include/qemu/log.h                        |   1 +
 include/qemu/plugin-memory.h              |  40 ++
 include/qemu/plugin.h                     | 255 ++++++++
 include/qemu/qemu-plugin.h                | 393 +++++++++++++
 include/qemu/queue.h                      |  10 +
 include/user/syscall-trace.h              |  40 ++
 linux-user/exit.c                         |   1 +
 linux-user/main.c                         |  18 +
 linux-user/syscall.c                      |   7 +-
 plugins/.gitignore                        |   2 +
 plugins/Makefile.objs                     |  21 +
 plugins/api.c                             | 341 +++++++++++
 plugins/core.c                            | 502 ++++++++++++++++
 plugins/loader.c                          | 377 ++++++++++++
 plugins/plugin.h                          |  97 ++++
 plugins/qemu-plugins.symbols              |  40 ++
 qemu-options.hx                           |  17 +
 scripts/checkpatch.pl                     |   2 +-
 scripts/tracetool/transform.py            |   1 +
 target/alpha/translate.c                  |   2 +-
 target/arm/arm_ldst.h                     |  15 +-
 target/cris/translate_v10.inc.c           |   3 +-
 target/hppa/translate.c                   |   2 +-
 target/i386/translate.c                   |  10 +-
 target/m68k/translate.c                   |   2 +-
 target/openrisc/translate.c               |   2 +-
 target/ppc/translate.c                    |   8 +-
 target/riscv/translate.c                  |   2 +-
 target/sh4/translate.c                    |   4 +-
 target/sparc/translate.c                  |   2 +-
 target/xtensa/translate.c                 |   4 +-
 tcg/tcg-op.c                              |  40 +-
 tcg/tcg-op.h                              |  16 +
 tcg/tcg-opc.h                             |   3 +
 tcg/tcg.c                                 |  22 +
 tcg/tcg.h                                 |  41 +-
 tests/Makefile.include                    |  11 +-
 tests/docker/Makefile.include             |   6 +-
 tests/docker/dockerfiles/travis.docker    |   6 +-
 tests/plugin/Makefile                     |  31 +
 tests/plugin/bb.c                         |  64 ++
 tests/plugin/empty.c                      |  30 +
 tests/plugin/hotblocks.c                  | 143 +++++
 tests/plugin/hotpages.c                   | 191 ++++++
 tests/plugin/howvec.c                     | 352 +++++++++++
 tests/plugin/insn.c                       |  61 ++
 tests/plugin/mem.c                        |  97 ++++
 tests/tcg/Makefile.target                 |  43 +-
 tests/tcg/aarch64/Makefile.softmmu-target |   2 +-
 tests/tcg/aarch64/Makefile.target         |   6 +
 tests/tcg/arm/Makefile.softmmu-target     |   1 +
 tests/tcg/arm/Makefile.target             |   6 +
 tests/tcg/cris/Makefile.target            |   2 +-
 tests/tcg/i386/Makefile.target            |  11 +-
 tests/vm/basevm.py                        |  15 +-
 tests/vm/netbsd                           | 195 ++++++-
 trace-events                              |   8 +-
 trace/mem-internal.h                      |  39 +-
 trace/mem.h                               |   7 +-
 util/log.c                                |   3 +
 vl.c                                      |  11 +
 100 files changed, 5462 insertions(+), 207 deletions(-)
 create mode 100644 accel/tcg/atomic_common.inc.c
 create mode 100644 accel/tcg/plugin-gen.c
 create mode 100644 accel/tcg/plugin-helpers.h
 create mode 100644 docs/devel/plugins.rst
 create mode 100644 include/exec/plugin-gen.h
 create mode 100644 include/qemu/plugin-memory.h
 create mode 100644 include/qemu/plugin.h
 create mode 100644 include/qemu/qemu-plugin.h
 create mode 100644 include/user/syscall-trace.h
 create mode 100644 plugins/.gitignore
 create mode 100644 plugins/Makefile.objs
 create mode 100644 plugins/api.c
 create mode 100644 plugins/core.c
 create mode 100644 plugins/loader.c
 create mode 100644 plugins/plugin.h
 create mode 100644 plugins/qemu-plugins.symbols
 create mode 100644 tests/plugin/Makefile
 create mode 100644 tests/plugin/bb.c
 create mode 100644 tests/plugin/empty.c
 create mode 100644 tests/plugin/hotblocks.c
 create mode 100644 tests/plugin/hotpages.c
 create mode 100644 tests/plugin/howvec.c
 create mode 100644 tests/plugin/insn.c
 create mode 100644 tests/plugin/mem.c

--
2.20.1


