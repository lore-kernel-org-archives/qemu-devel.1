Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCF0C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:55:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AC4920854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jfVB6rRC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC4920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJy0L-0004F0-4w
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 06:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvH-0007JE-Cm
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvF-0005vo-9G
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:49:55 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:33825)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJxvF-0005uE-2T
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:49:53 -0400
Received: by mail-wm1-x32a.google.com with SMTP id y135so14213996wmc.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZMtGjt+4Q0aWuvREIqVBa6tJie7VG70qIFZCIuAzZRM=;
 b=jfVB6rRCR1kI5BT9YRGGOQMPmJfhgb10qRRvK2wRQepRLcOb4MulBKS5A03r/UquBF
 C5FtqE3qqkRDTO++aIz0FcFN+8dTkMLKtfM1el6O4l0mi9sG5Bf91Ikfo35ARJdAaPQ/
 fr90cVEwERpEUjzwOdVBNI4PGTgecgNB59C3uXyIDcuez3cOuH3xKThgwN99IP+NM7Vr
 sHAoxefAnp8uJIbTayW6EgFhnRSSBcqg1n8/fPZQ0EZ1mLMf8yv2oofJiRt4XCb3B+ej
 HZRIC3W8d8rDcW2pXBuln8WGOr3TN3HkPa1P4FS6+GRICV03I31vwfJdnkEdEBDgYsLw
 akTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZMtGjt+4Q0aWuvREIqVBa6tJie7VG70qIFZCIuAzZRM=;
 b=YwspqrLIVaSYuplCuOJYBJovNI3KzMWYrmfWl8fGujAzdsjwuFWEJUVgwDT1AUY8QE
 +S7rrIHpyc+T43vfREbP/+CV70UDsugOIvoWITdImNPPJ9Ru/T/gyg3f8dxiZ7zZHl3F
 6XkpyP4hSAGU6b037I51aJ/knv2G4YNCZgWZ2sbOg+UhieExVYNxB1zHlut1ovQAx4MO
 4WWgPkAjBcJV7lfQu3elfpQ8ikZdfNUD9L6u6RZHIxBTmiQwY4lbPsgozkLG42zemCWE
 bjVAPIWrW7zDztQ3pWXXb8rgHPSQMyH62aMVhbLcAdNVbz2+0xkYaLDKynIYAAmH5Q4m
 F98w==
X-Gm-Message-State: APjAAAUAmLvkflgHv3WPjn5KcXkv9eBNk0rK8v1CimzSWJ+jD99tDPIx
 dkzu+b5m4O6xzrxlsb+tDx8Bdw==
X-Google-Smtp-Source: APXvYqwN3VFRbYy6qs1hBIsLVoHkopNt03zXjNKAcuTV5+pnXTM486jpvLSyUDVxdev38Hhg8fJB0A==
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr15009113wmb.125.1571050190995; 
 Mon, 14 Oct 2019 03:49:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q10sm31662088wrd.39.2019.10.14.03.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:49:49 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E3C241FF87;
 Mon, 14 Oct 2019 11:49:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for 4.2 v5 00/55] Support for TCG plugins
Date: Mon, 14 Oct 2019 11:48:53 +0100
Message-Id: <20191014104948.4291-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
Cc: aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 robert.foley@futurewei.com, peter.puhov@futurewei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This is the latest iteration of the TCG plugins series. From the documentation:

  QEMU TCG plugins provide a way for users to run experiments taking
  advantage of the total system control emulation can have over a guest.
  It provides a mechanism for plugins to subscribe to events during
  translation and execution and optionally callback into the plugin
  during these events. TCG plugins are unable to change the system state
  only monitor it passively. However they can do this down to an
  individual instruction granularity including potentially subscribing
  to all load and store operations.

I think I've addressed most of the comments from the v4 posting. I've
made a couple of changes to API which I intend to keep as separate
patches in the series to aid review. They are:

  qemu_plugin_install - new info block
  qemu_plugin_outs - output a string via QEMU's log system

The first allows plugins to know about the guest architecture - in a
fairly simple way by exposing TARGET_NAME. Its enough that a plugin
could decide not to install anything if it is not what it is expecting
but not so much that it has detailed information about the target. For
that sort of subtly you will have to pass details down via the plugin
options. I did briefly look at exposing ElfMachine information but
that got too gnarly. The only user in the examples is the howvec
plugin which will now run on all architectures although it can only
classify aarch64 and sparc64 instructions into groups.

The ability of the plugins to be fully "multiarch" aware meant I could
enable check-tcg to run most tests with each available plugin. This
proved very effective at exposing some bugs in the code that didn't
show up on my main test architecture (ARM). I can still trigger
crashes in sparc64-linux-user but rth informs me it is currently quite
broken so I skip it for now in the CI config.

The qemu_plugin_outs patch is mostly mechanical but it does neaten up
the output of plugins and prevent them just spamming stdout. Currently
the output goes via the logging system but I can envisage future
tweaks for system emulation which could push the output via a chardev
and allow nicer integration with test harnesses.

One requested feature that didn't make it in was a way to introspect
the state of the registers. It's not a deal breaker as the plugin can
always decode the instruction itself and has access to all
loads/stores so could track the data itself. I didn't want to hold up
the merging of what we have given softfreeze is so close so I think
this is something to think about for the next cycle. I'm open to ideas
of the best way to do this. One idle thought I had was giving the
plugin the ability to trigger a debug exception which would then punt
the problem to the gdbstub. I'm not sure if triggering a non-guest
visible exception violates the passive monitoring contract of TCG
plugins.

I've added some more words to the documentation to hopefully ally
fears about TCG plugins being used to end-run around the GPL.

The only other change of note is fixing a bunch of races by using
__thread for per-CPU data structures. There are more details bellow
the --- comments in each patch.

I'm hoping to get it merged this cycle so please review:

  02 - trace add mmu_index to mem_info
  17 - plugins implement helpers for resolving hwaddr
  40 - tests tcg Makefile.target fix path to config host
  41 - tests tcg set QEMU_OPTS for all cris runs
  42 - tests tcg move virtual tests to EXTRA_TESTS
  43 - tests tcg drop test i386 fprem from TESTS when no
  44 - tests tcg enable plugin testing
  45 - tests plugin add a hotblocks plugin
  47 - tests plugin add instruction execution breakdown
  48 - tests plugin add hotpages plugin to breakdown mem
  51 - plugins expand the plugin_init function to includ
  52 - plugins make howvec plugin more generic
  53 - plugins add sparc64 instruction classification ta
  54 - plugins add qemu_plugin_outs and use it
  55 - .travis.yml add enable plugins tests

Alex Bennée (21):
  trace: add mmu_index to mem_info
  docs/devel: add plugins.rst design document
  configure: add --enable-plugins (MOVE TO END)
  plugin: add implementation of the api
  plugins: implement helpers for resolving hwaddr
  tests/tcg/Makefile.target: fix path to config-host.mak
  tests/tcg: set QEMU_OPTS for all cris runs
  tests/tcg: move "virtual" tests to EXTRA_TESTS
  tests/tcg: drop test-i386-fprem from TESTS when not SLOW
  tests/tcg: enable plugin testing
  tests/plugin: add a hotblocks plugin
  plugin: add qemu_plugin_insn_disas helper
  tests/plugin: add instruction execution breakdown
  tests/plugin: add hotpages plugin to breakdown memory access patterns
  accel/stubs: reduce headers from tcg-stub
  include/exec: wrap cpu_ldst.h in CONFIG_TCG
  plugins: expand the plugin_init function to include an info block
  plugins: make howvec plugin more generic
  plugins: add sparc64 instruction classification table
  plugins: add qemu_plugin_outs and use it
  .travis.yml: add --enable-plugins tests

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

 .travis.yml                               |  15 +
 Makefile                                  |  16 +-
 Makefile.target                           |   2 +
 accel/stubs/tcg-stub.c                    |   1 -
 accel/tcg/Makefile.objs                   |   1 +
 accel/tcg/atomic_common.inc.c             |  54 ++
 accel/tcg/atomic_template.h               |  94 ++-
 accel/tcg/cpu-exec.c                      |   8 +-
 accel/tcg/cputlb.c                        |  53 +-
 accel/tcg/plugin-gen.c                    | 932 ++++++++++++++++++++++
 accel/tcg/plugin-helpers.h                |   5 +
 accel/tcg/translate-all.c                 |  15 +-
 accel/tcg/translator.c                    |  20 +
 accel/tcg/user-exec.c                     |   3 +
 bsd-user/syscall.c                        |  24 +-
 configure                                 |  86 ++
 cpus-common.c                             |   4 +
 cpus.c                                    |  10 +
 disas.c                                   | 110 +++
 docs/devel/index.rst                      |   1 +
 docs/devel/plugins.rst                    | 112 +++
 exec.c                                    |   2 +
 hw/core/cpu.c                             |   2 +
 include/disas/disas.h                     |   2 +
 include/exec/cpu-defs.h                   |   1 +
 include/exec/cpu_ldst.h                   |  11 +
 include/exec/cpu_ldst_template.h          |  37 +-
 include/exec/cpu_ldst_useronly_template.h |  29 +-
 include/exec/exec-all.h                   |  84 +-
 include/exec/helper-gen.h                 |   1 +
 include/exec/helper-proto.h               |   1 +
 include/exec/helper-tcg.h                 |   1 +
 include/exec/plugin-gen.h                 |  71 ++
 include/exec/translator.h                 |  58 +-
 include/hw/core/cpu.h                     |  19 +
 include/qemu/bswap.h                      |   5 +
 include/qemu/log.h                        |   1 +
 include/qemu/plugin.h                     | 261 ++++++
 include/qemu/qemu-plugin.h                | 388 +++++++++
 include/qemu/queue.h                      |  10 +
 include/user/syscall-trace.h              |  40 +
 linux-user/exit.c                         |   1 +
 linux-user/main.c                         |  18 +
 linux-user/syscall.c                      |   7 +-
 plugins/.gitignore                        |   2 +
 plugins/Makefile.objs                     |  21 +
 plugins/api.c                             | 334 ++++++++
 plugins/core.c                            | 504 ++++++++++++
 plugins/loader.c                          | 384 +++++++++
 plugins/plugin.h                          |  95 +++
 plugins/qemu-plugins.symbols              |  40 +
 qemu-options.hx                           |  17 +
 scripts/tracetool/transform.py            |   1 +
 target/alpha/translate.c                  |   2 +-
 target/arm/arm_ldst.h                     |  15 +-
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
 tcg/tcg.h                                 |  23 +
 tests/Makefile.include                    |  11 +-
 tests/plugin/Makefile                     |  31 +
 tests/plugin/bb.c                         |  64 ++
 tests/plugin/empty.c                      |  30 +
 tests/plugin/hotblocks.c                  | 143 ++++
 tests/plugin/hotpages.c                   | 174 ++++
 tests/plugin/howvec.c                     | 351 ++++++++
 tests/plugin/insn.c                       |  61 ++
 tests/plugin/mem.c                        |  97 +++
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
 90 files changed, 5111 insertions(+), 161 deletions(-)
 create mode 100644 accel/tcg/atomic_common.inc.c
 create mode 100644 accel/tcg/plugin-gen.c
 create mode 100644 accel/tcg/plugin-helpers.h
 create mode 100644 docs/devel/plugins.rst
 create mode 100644 include/exec/plugin-gen.h
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


