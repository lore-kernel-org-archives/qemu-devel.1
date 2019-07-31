Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BB0C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FF04206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uuLz/OG3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF04206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrCj-0007sR-Nx
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40235)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsr8U-00022I-0D
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsr8N-0000bX-3l
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:29 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52404)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsr8M-0000a8-Lw
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:23 -0400
Received: by mail-wm1-x342.google.com with SMTP id s3so61395080wms.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hvj47/f9gulmptL2XutOtgU6C1ydAIYK5HKCS4yEHDs=;
 b=uuLz/OG3g6J8SfET/t73D8xmlgueH+CTraeE0VikK36QbEv/9K0Yp4X/FoSF1B+YiG
 o3NsE0ssRmo/hiYCSqF7cQtLDw52BrEZxfcMNblPd9DqM7V0k2HEcFuOK00Z7+UKqOc4
 dQidXcrjb+g+NPHNo0ZwuP4KAxOfh1kDolvErzHJ/2FA3JmgQIZBbbqB86w4lPtwcszi
 sX4DKzSQYlreFbX0oCluRWaAsoFwXhQq77tC6U+u+3WK6Fo6HM6OaHmhkx9yMi+1py6j
 ToiJHsXYUGkHu/4EP4Hst31uDfc/BC2x4httgpWu9HNmww86vsU7H0SxBdE7rOEamWcq
 Pp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hvj47/f9gulmptL2XutOtgU6C1ydAIYK5HKCS4yEHDs=;
 b=cWquouPHMM+Yj2JAbmH4JvI67CqoBrQrydNLP+y2lIHdYjpMkkLceOy+9qOHuDSqB1
 OXAAyDSUVVMDLpIFi4qinmKl6APtKJOnq6oX8kCya47JA2RgxlcxPpQ4pAeHYam/Idwd
 duE6cblkqUXza9CBLIo/PFREgbT6kWfpep4bfm59oxcf1lPLKfQMqwnVCsgpahiqM55x
 iy/VtH7JpYs5HvLdpzrvEzu3ftyKpXL/7IDfveJh+AsmSOE6YyMPmGPgTHMpZRCSuXrG
 mk7bzymKh6FlTeOKsowNJ5ZTCV8nmw/BAZ7v3QVaHlZ0KQxtrXKjn6hXbC4HZVw04RsI
 Ffcg==
X-Gm-Message-State: APjAAAWU/jBMp3yAt4/t3PiNBcDtfU8ZqYPLcdUq1safYjwALj28ajvL
 7p4pADuW1XsMtY77J25TPCkgcA==
X-Google-Smtp-Source: APXvYqyHJou9OvJKG4Kj8nNbNv2yMCSEeqbw8yGKFCh+LNqPRV5IE9DLDVge7IFuDmFHOxwebaaxFA==
X-Received: by 2002:a7b:c1da:: with SMTP id
 a26mr112048951wmj.128.1564589240375; 
 Wed, 31 Jul 2019 09:07:20 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id j33sm146091650wre.42.2019.07.31.09.07.19
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:07:19 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 75DA41FF87;
 Wed, 31 Jul 2019 17:07:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:06:25 +0100
Message-Id: <20190731160719.11396-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH  v4 00/54] plugins for TCG
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
Cc: bobby.prani@gmail.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 aaron@os.amperecomputing.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This is the latest iteration of the plugins series. The main changes
from the last version are:

  - dropped passing of haddr to plugins

This makes the code for handling the plugins less invasive in the
softmmu path at the cost of offloading processing to the plugin if it
wants the value. We rely on the fact that the TLB is per vCPU so a
helper can just trigger a re-query of the TLB to get the final
address.

Part of that change involved embedding the MMU index in the meminfo
field for tracing. I see there are some other patches on the list for
messing with TCGMemOp so there might be a clash coming up.

  - translator_ld goes direct to softmmu/user functions

I also mark the [SOFTMMU_]CODE_ACCESS helpers as deprecated. There is
more work to be done to clean up all the current uses of code access
helpers but ideally the only thing that should be peaking at code is
the translator loop itself. However a bunch of helpers have taken to
using code loading functions to peak at the instruction just executed
to figure out what to do. Once those have been fixed then we can
remove those helpers.

Other more minor fixes can be found documented bellow the --- in the
individual patches.

This series also includes the semihosting patches as they are a
pre-requisite for the translator_ld patches for ARM.

Once the tree opens up for development again I hope to get the
semihosting and trivial clean-up patches merged quickly so the patch
count for the plugins patches proper can be reduced a bit.

The following patches need review
  patch 0004/target arm remove run time semihosting checks.patch
  patch 0005/includes remove stale smp max _cpus externs.patch
  patch 0007/trace add mmu_index to mem_info.patch
  patch 0011/docs devel add plugins.rst design document.patch
  patch 0012/configure add enable plugins MOVE TO END.patch
  patch 0015/plugin add implementation of the api.patch
  patch 0024/plugins implement helpers for resolving hwaddr.patch
  patch 0047/tests tcg enable plugin testing.patch
  patch 0048/tests plugin add a hotblocks plugin.patch
  patch 0050/tests plugin add instruction execution breakdown.patch
  patch 0051/tests plugin add hotpages plugin to breakdown mem.patch
  patch 0053/include exec wrap cpu_ldst.h in CONFIG_TCG.patch

Alex Bennée (18):
  target/arm: handle M-profile semihosting at translate time
  target/arm: handle A-profile T32 semihosting at translate time
  target/arm: handle A-profile A32 semihosting at translate time
  target/arm: remove run time semihosting checks
  includes: remove stale [smp|max]_cpus externs
  trace: add mmu_index to mem_info
  docs/devel: add plugins.rst design document
  configure: add --enable-plugins (MOVE TO END)
  plugin: add implementation of the api
  plugins: implement helpers for resolving hwaddr
  tests/tcg: enable plugin testing
  tests/plugin: add a hotblocks plugin
  plugin: add qemu_plugin_insn_disas helper
  tests/plugin: add instruction execution breakdown
  tests/plugin: add hotpages plugin to breakdown memory access patterns
  accel/stubs: reduce headers from tcg-stub
  include/exec: wrap cpu_ldst.h in CONFIG_TCG
  include/exec/cpu-defs.h: fix typo

Emilio G. Cota (34):
  trace: expand mem_info:size_shift to 4 bits
  tcg/README: fix typo s/afterwise/afterwards/
  cpu: introduce cpu_in_exclusive_context()
  translate-all: use cpu_in_exclusive_work_context() in tb_flush
  plugin: add user-facing API
  plugin: add core code
  queue: add QTAILQ_REMOVE_SEVERAL
  cputlb: document get_page_addr_code
  cputlb: introduce get_page_addr_code_hostp
  tcg: add tcg_gen_st_ptr
  plugin-gen: add module for TCG-related code
  atomic_template: fix indentation in GEN_ATOMIC_HELPER
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

 Makefile                                  |  10 +-
 Makefile.target                           |   2 +
 accel/stubs/tcg-stub.c                    |   3 -
 accel/tcg/Makefile.objs                   |   1 +
 accel/tcg/atomic_common.inc.c             |  54 ++
 accel/tcg/atomic_template.h               |  96 ++-
 accel/tcg/cpu-exec.c                      |   8 +-
 accel/tcg/cputlb.c                        |  69 +-
 accel/tcg/plugin-gen.c                    | 977 ++++++++++++++++++++++
 accel/tcg/plugin-helpers.h                |   5 +
 accel/tcg/translate-all.c                 |  15 +-
 accel/tcg/translator.c                    |  20 +
 accel/tcg/user-exec.c                     |   3 +
 bsd-user/syscall.c                        |  24 +-
 configure                                 |  86 +-
 cpus-common.c                             |   4 +
 cpus.c                                    |  10 +
 disas.c                                   | 103 +++
 docs/devel/index.rst                      |   1 +
 docs/devel/plugins.rst                    | 107 +++
 exec.c                                    |   2 +
 include/disas/disas.h                     |   2 +
 include/exec/cpu-defs.h                   |   3 +-
 include/exec/cpu_ldst.h                   |  11 +
 include/exec/cpu_ldst_template.h          |  37 +-
 include/exec/cpu_ldst_useronly_template.h |  29 +-
 include/exec/exec-all.h                   |  81 +-
 include/exec/helper-gen.h                 |   1 +
 include/exec/helper-proto.h               |   1 +
 include/exec/helper-tcg.h                 |   1 +
 include/exec/plugin-gen.h                 |  71 ++
 include/exec/translator.h                 |  58 +-
 include/qemu/bswap.h                      |   5 +
 include/qemu/plugin.h                     | 261 ++++++
 include/qemu/qemu-plugin.h                | 360 ++++++++
 include/qemu/queue.h                      |  10 +
 include/qom/cpu.h                         |  19 +
 include/sysemu/sysemu.h                   |   2 -
 include/user/syscall-trace.h              |  40 +
 linux-user/exit.c                         |   1 +
 linux-user/main.c                         |  18 +
 linux-user/syscall.c                      |   7 +-
 plugins/.gitignore                        |   2 +
 plugins/Makefile.objs                     |  21 +
 plugins/api.c                             | 338 ++++++++
 plugins/core.c                            | 499 +++++++++++
 plugins/loader.c                          | 353 ++++++++
 plugins/plugin.h                          |  95 +++
 plugins/qemu-plugins.symbols              |  39 +
 qemu-options.hx                           |  17 +
 qom/cpu.c                                 |   2 +
 scripts/tracetool/transform.py            |   1 +
 target/alpha/translate.c                  |   2 +-
 target/arm/arm_ldst.h                     |  15 +-
 target/arm/helper.c                       |  90 +-
 target/arm/m_helper.c                     |  18 +-
 target/arm/translate.c                    |  64 +-
 target/hppa/translate.c                   |   2 +-
 target/i386/translate.c                   |  10 +-
 target/m68k/translate.c                   |   2 +-
 target/openrisc/translate.c               |   2 +-
 target/ppc/translate.c                    |   8 +-
 target/riscv/translate.c                  |   2 +-
 target/sh4/translate.c                    |   4 +-
 target/sparc/translate.c                  |   2 +-
 target/xtensa/translate.c                 |   4 +-
 tcg/README                                |   2 +-
 tcg/tcg-op.c                              |  40 +-
 tcg/tcg-op.h                              |  16 +
 tcg/tcg-opc.h                             |   3 +
 tcg/tcg.c                                 |  22 +
 tcg/tcg.h                                 |  23 +
 tests/Makefile.include                    |  10 +-
 tests/plugin/Makefile                     |  31 +
 tests/plugin/bb.c                         |  65 ++
 tests/plugin/empty.c                      |  29 +
 tests/plugin/hotblocks.c                  | 146 ++++
 tests/plugin/hotpages.c                   | 179 ++++
 tests/plugin/howvec.c                     | 301 +++++++
 tests/plugin/insn.c                       |  62 ++
 tests/plugin/mem.c                        |  96 +++
 tests/tcg/Makefile                        |  34 +
 tests/tcg/arm/Makefile.softmmu-target     |   1 +
 trace-events                              |   8 +-
 trace/mem-internal.h                      |  31 +-
 trace/mem.h                               |   7 +-
 vl.c                                      |  11 +
 87 files changed, 5067 insertions(+), 260 deletions(-)
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


