Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717A9CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:26:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB8521783
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dqMi7J8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB8521783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP6v2-0004LV-KQ
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 11:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iP6qk-0008Ad-9Y
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:22:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iP6jY-0004Vw-NT
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:15:06 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:51565)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iP6jY-0004VV-FS
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:15:04 -0400
Received: by mail-wm1-x32d.google.com with SMTP id q70so9896706wme.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 08:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3LPbqGPe+NHsZrKIpi4pxSYNeRejia0TnSX3ibel3Ro=;
 b=dqMi7J8gC9lV1FqRztQWr9sO4eYkTgt+QSD5BvRMmZCFK4vohdUpRzLXagw+6beLTg
 OsWCLRirxUpBngkJku1ub6dj9zQIDQVOFImUR+IVtQPtnfxOHco3fLrykQhQUl+5ksYr
 FdTMfAU2S/aAsajTKJakedjGAdW2JVynLLNsjBhj9pMANArtX5lTgrainGBvBXbXVgW0
 GrKPlLJag/U3PA3jHt+3tusJkCW4GXsiq/KnFknbAIZuq+mEJZXDpvxgcMBe3y+Omc/t
 SYWQyRuoySzS9WX7vEgjHO6B2ul9E1iwE1qhJgzWIKvnIJD3s1aDRkj5/xuZamGBsSer
 VMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3LPbqGPe+NHsZrKIpi4pxSYNeRejia0TnSX3ibel3Ro=;
 b=PAdmN8wxpanhtWtbz+xn7mib1JmTKVu85aaDqyP+rozktrhqzPRZJU2FBKPtRU1IFt
 p/fUMQXiJtm0JepSbFyk5WYJXFt1LsQd9KX2CoMA2iH0uxbmYGemNBUENlvj5ITr3mIN
 VkRyI/wXQBip1svZ0B7ddz1S4AfObedBxQ2M6sXQjF4Png3OEfMormHQLGyAeurEiA34
 pMW9FO1MeaYmsMgRH1CgWfB6NMqe5/D2PlvFYYt7vzMnyV41JrLbCP/cwtAE3FIOX921
 0aZtwTGEC6eGXINtHlzFcMUBsFqdxH19bmHuLcTUq/s4qY9pxP+x3oD9whlgbtvkpIN1
 9RSA==
X-Gm-Message-State: APjAAAVqwbCeadrVGp4VqOMaXp8TnIGRrO/TY4mqS+qM/bTcBCZNAM38
 50clyl2aSbjbO4QnRVIUpaIzKgw6IKs=
X-Google-Smtp-Source: APXvYqzGxsCXoXtwdwnPOZWwX+dqjQbx73ksV3udjP43ZZYNgDP9TeDcePnBzv9KNDQnANiS2pYMkQ==
X-Received: by 2002:a7b:c3c4:: with SMTP id t4mr432703wmj.105.1572275703059;
 Mon, 28 Oct 2019 08:15:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 26sm11333409wmi.17.2019.10.28.08.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 08:15:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C5E9D1FF87;
 Mon, 28 Oct 2019 15:15:01 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v4 for 4.2 00/57] TCG plugins
Date: Mon, 28 Oct 2019 15:15:01 +0000
Message-Id: <20191028151501.1920-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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

The following changes since commit 9bb73502321d46f4d320fa17aa38201445783fc4:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2019-10-28 13:32:40 +0000)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-tcg-plugins-281019-4

for you to fetch changes up to 19633df89bfc609569bb693e2e33eb1a68d35e0e:

  travis.yml: enable linux-gcc-debug-tcg cache (2019-10-28 15:12:38 +0000)

----------------------------------------------------------------
TCG Plugins initial implementation

  - use --enable-plugins @ configure
  - low impact introspection (-plugin empty.so to measure overhead)
  - plugins cannot alter guest state
  - example plugins included in source tree (tests/plugins)
  - -d plugin to enable plugin output in logs
  - check-tcg runs extra tests when plugins enabled
  - documentation in docs/devel/plugins.rst

----------------------------------------------------------------
Alex Bennée (23):
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

Lluís Vilanova (2):
      vl: support -plugin option
      linux-user: support -plugin option

 .travis.yml                               |  21 +-
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
 trace-events                              |   8 +-
 trace/mem-internal.h                      |  39 +-
 trace/mem.h                               |   7 +-
 util/log.c                                |   3 +
 vl.c                                      |  11 +
 93 files changed, 5206 insertions(+), 178 deletions(-)
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


