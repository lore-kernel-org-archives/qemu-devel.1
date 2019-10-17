Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6540DECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:30:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D1462054F
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gjOb/sqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1462054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5qw-0007Zf-Jp
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5dd-0007xP-O8
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5db-0005JP-PW
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:21 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50704)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5db-0005IJ-Da
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:19 -0400
Received: by mail-wm1-x343.google.com with SMTP id 5so2548996wmg.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=a4dWIW5LEOLBgiLOgrzeQr7rIOmAcI8X6J+me77emQI=;
 b=gjOb/sqv3dYr8RnLJvf1pQKbCZaF/5gWxD8qatwLLh2x4PRgygMGso0+9XaQPvLllr
 Zet0wEkj6Gl5Hm8gJgYwXd+jQAgSsonOV4Kakj5klTCMwPrjFowF5QzULqcLJ+Uf6Oiw
 ixxStmAkGsTVcMSskbdKJt45Uwba2qrxABo16qENOf5q7RFxU41gLWW+aB1ndoh2tBG6
 ItnVUHPAjYS+XdM5N5ZECM7RT4vm8IQDqsLrQ1jqjwdXTlRAF7mxJKai/uzmMkQMVXjR
 eUi+mxS0dkgiO2SaVd0CGVkh5wmPAZSmiwFk4CHCUvZuVcO+VqrzwKY6/lHTSy0CDWB7
 TSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=a4dWIW5LEOLBgiLOgrzeQr7rIOmAcI8X6J+me77emQI=;
 b=nIc+zWeq8aO1nK4jYU0eZFX6YM2EWDgnTgksAjb4nPuAYvQXYHY3CHc7keCrxJJarA
 7z5bCWJLwMheE71EJdlEVaSY9z3TTj4cVX+ukMC14Mbl94FNE070ePwF/aJsAlpNGE5/
 3F2UhXu+P48dbdK6VTm+74C3GZKwlmoMcZNwPpkxTQUktVrgt6HwxMkeu3drcajEeQh1
 0weGzhSZu0zpB82HSE6kR35Sm3mgQz41agGp29t4tN6/vSL9pNYpPtAy8sH5eRkIOP3V
 rDvZdIEPdp6GrkOkF2YefuyHkJo1HVTa4PTluFVMo+7lVllXokFv2aoCvVFbCXOMbhzC
 JE8g==
X-Gm-Message-State: APjAAAXMoVlpbOelkxza1++D8/ltuQbaucoQJq5fucGTy1gwYEIz7Mqa
 A3QhTW1+8nxxIn/9Y/kBQcrdEQ==
X-Google-Smtp-Source: APXvYqxUBb/efBlyN1DTrudgS5G2ig340QyWgeaOkVfDnG3z9sc0DD8UI78F/PtKPZstKtNCWZ9HXA==
X-Received: by 2002:a7b:cb8a:: with SMTP id m10mr2678295wmi.132.1571318177527; 
 Thu, 17 Oct 2019 06:16:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r65sm2215110wmr.9.2019.10.17.06.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:16:16 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BD0EF1FF87;
 Thu, 17 Oct 2019 14:16:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for 4.2 v6 00/54] Support for TCG plugins
Date: Thu, 17 Oct 2019 14:15:21 +0100
Message-Id: <20191017131615.19660-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

This is mostly a adding signoffs and some patch re-organisation and
splitting. For reference the longer notes about what API tweaks didn't
make it into this iteration can be found in the previous series:

  Subject: [PATCH for 4.2 v5 00/55] Support for TCG plugins
  Date: Mon, 14 Oct 2019 11:48:53 +0100
  Message-Id: <20191014104948.4291-1-alex.bennee@linaro.org>

Changes of note:

  - now use gmodule to load symbols instead of dlsym
  - re-jigged translator_ld to avoid creating more alias functions
  - moved configure change to final place
  - moved additional API bits to before examples
  - merged api changes to examples into final single commit versions
  - tweaked hwaddr API to talk of device_offset

Most of the checkpatch formatting complaints I think are overly picky
given the attempt to make table look nice or not wrap for the sake of
going one character over. I've included a checkpatch patch to stop
bothering me about (foo, /* empty */) comments. As ever there are more
details bellow the ---

Only a few more un-reviewed patches before I can send the PR:

   02 - trace add mmu_index to mem_info
   37 - plugin expand the plugin_init function to include
   39 - plugin add qemu_plugin_outs helper
   54 - scripts chec.pl don t complain about foo em


Alex Bennée (20):
  trace: add mmu_index to mem_info
  docs/devel: add plugins.rst design document
  plugin: add implementation of the api
  plugins: implement helpers for resolving hwaddr
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
 accel/tcg/cputlb.c                        |  60 +-
 accel/tcg/plugin-gen.c                    | 932 ++++++++++++++++++++++
 accel/tcg/plugin-helpers.h                |   5 +
 accel/tcg/translate-all.c                 |  15 +-
 accel/tcg/translator.c                    |  20 +
 accel/tcg/user-exec.c                     |   3 +
 bsd-user/syscall.c                        |  24 +-
 configure                                 |  89 +++
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
 include/exec/cpu_ldst_useronly_template.h |  32 +-
 include/exec/exec-all.h                   |  64 +-
 include/exec/helper-gen.h                 |   1 +
 include/exec/helper-proto.h               |   1 +
 include/exec/helper-tcg.h                 |   1 +
 include/exec/plugin-gen.h                 |  71 ++
 include/exec/translator.h                 |  62 +-
 include/hw/core/cpu.h                     |  19 +
 include/qemu/log.h                        |   1 +
 include/qemu/plugin-memory.h              |  40 +
 include/qemu/plugin.h                     | 255 ++++++
 include/qemu/qemu-plugin.h                | 393 +++++++++
 include/qemu/queue.h                      |  10 +
 include/user/syscall-trace.h              |  40 +
 linux-user/exit.c                         |   1 +
 linux-user/main.c                         |  18 +
 linux-user/syscall.c                      |   7 +-
 plugins/.gitignore                        |   2 +
 plugins/Makefile.objs                     |  21 +
 plugins/api.c                             | 341 ++++++++
 plugins/core.c                            | 502 ++++++++++++
 plugins/loader.c                          | 377 +++++++++
 plugins/plugin.h                          |  97 +++
 plugins/qemu-plugins.symbols              |  40 +
 qemu-options.hx                           |  17 +
 scripts/checkpatch.pl                     |   2 +-
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
 tcg/tcg.h                                 |  21 +
 tests/Makefile.include                    |  11 +-
 tests/plugin/Makefile                     |  31 +
 tests/plugin/bb.c                         |  64 ++
 tests/plugin/empty.c                      |  30 +
 tests/plugin/hotblocks.c                  | 143 ++++
 tests/plugin/hotpages.c                   | 191 +++++
 tests/plugin/howvec.c                     | 352 ++++++++
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
 91 files changed, 5159 insertions(+), 162 deletions(-)
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


