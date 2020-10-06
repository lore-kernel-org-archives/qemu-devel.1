Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1B3C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:31:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A517320760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsudZUGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A517320760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhRt-0003ws-Ew
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 03:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhPy-0002Gz-8L
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:29:50 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:45333)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhPw-0001M7-2c
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:29:49 -0400
Received: by mail-wr1-x429.google.com with SMTP id e17so3521782wru.12
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3SJen0Xx974o5ExDqqPraa3rarP1hJnPvaxANcvEtdk=;
 b=FsudZUGWyRhn68/bspOShBSNsNd4NWn6gYpLfrCHETXrCNAae2bIwwWNsq3iuZEA6g
 RugRtC2Tg1Bc2nQBFgVn8gv783CKKblHe6CYQuC3z2kwS5KiFaA1MIMuOsvzzs6sqqfb
 +J2cMRo4pXz6bJvqGlcPZQVw+GkfTfg8LyqErMNilUh/B2BNBGJ0h/nwQZXTQvrc2rVw
 U5cSwW25bd4NfCeHFlnFDytXmQ32jfZqZhDX033nTrpFs1Rlo1P4pop8PrvxpIfjQNws
 R853H82MYdLMsK/I6HY3TWYSHhLCCVtETTecN1yNkpru8GknWdEWyRJ/go1+al24Y0GE
 XOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=3SJen0Xx974o5ExDqqPraa3rarP1hJnPvaxANcvEtdk=;
 b=PJFur81AsQxs9DQWCSfceMGE38r9ipbcjEc8qNPkCMKTct0GKBWSJXmUEQU8/YeikQ
 8M48XM9axpSWRWIigE8251iyQeJj7j4xENT7rK9MnFVtsT6dxgejB7Rto0vkn0Wb2mM6
 yYByAOby44jQkoTxKnUsU0TZoIF92yhCtmwXw2f4RFuaf1qnmJx5ZZw2pagX5PpYkrhB
 7fgpD5QK/QN+7hRo/GG0ktVUCgjEklH5mu6bMICy/E3QwUnUQW6BNi66LW+iiVsDLzTx
 k8Yr5bWRgvtNeDtw7eSSCddivr4Lxp+QwJ3oh8fx10mFoqDOm8Va8Eye1iS5/vdpSxzS
 RIeA==
X-Gm-Message-State: AOAM532yY01VxD2tAgCwbH+PK0FaRLE5djVku2+mu4CO1tN++N8S3U97
 vzePTPZ2kItIxo+N/dqVhg0O1fks8/A=
X-Google-Smtp-Source: ABdhPJxlByPTrnjBVK5HvpPB5/53yrJnEmEkyVwFJCrRpd+bnM0yrIjr07BNu15Pj0g6jKb5VIgtVw==
X-Received: by 2002:adf:ce05:: with SMTP id p5mr3269632wrn.110.1601969385929; 
 Tue, 06 Oct 2020 00:29:45 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.29.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:29:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/37] Build system + accel + record/replay patches for
 2020-10-06
Date: Tue,  6 Oct 2020 09:29:10 +0200
Message-Id: <20201006072947.487729-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 0ac0b47c44b4be6cbce26777a1a5968cc8f025a5:

  Merge remote-tracking branch 'remotes/bonzini-gitlab/tags/for-upstream' into staging (2020-10-05 13:12:55 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to be52eca309788aa69dc10a8cae63e8a40de7a2f7:

  tests/acceptance: add reverse debugging test (2020-10-06 08:34:50 +0200)

----------------------------------------------------------------
* Reverse debugging (Pavel)
* CFLAGS cleanup (Paolo)
* ASLR fix (Mark)
* cpus.c refactoring (Claudio)

----------------------------------------------------------------
Claudio Fontana (17):
      cpu-timers, icount: new modules
      icount: rename functions to be consistent with the module name
      cpus: prepare new CpusAccel cpu accelerator interface
      cpus: extract out TCG-specific code to accel/tcg
      cpus: extract out qtest-specific code to accel/qtest
      cpus: extract out kvm-specific code to accel/kvm
      cpus: extract out hax-specific code to target/i386/
      cpus: extract out whpx-specific code to target/i386/
      cpus: extract out hvf-specific code to target/i386/hvf/
      cpus: cleanup now unneeded includes
      cpus: remove checks for non-NULL cpus_accel
      cpus: add handle_interrupt to the CpusAccel interface
      hvf: remove hvf specific functions from global includes
      whpx: remove whpx specific functions from global includes
      hax: remove hax specific functions from global includes
      kvm: remove kvm specific functions from global includes
      accel/tcg: use current_machine as it is always set for softmmu

Dr. David Alan Gilbert (1):
      kvm: kvm_init_vcpu take Error pointer

Mark Cave-Ayland (1):
      configure: don't enable ASLR for --enable-debug Windows builds

Paolo Bonzini (4):
      slirp: Convert Makefile bits to meson bits
      dtc: Convert Makefile bits to meson bits
      configure: do not clobber environment CFLAGS/CXXFLAGS/LDFLAGS
      configure: consistently pass CFLAGS/CXXFLAGS/LDFLAGS to meson

Pavel Dovgaluk (10):
      replay: provide an accessor for rr filename
      qapi: introduce replay.json for record/replay-related stuff
      replay: introduce info hmp/qmp command
      replay: introduce breakpoint at the specified step
      replay: implement replay-seek command
      replay: flush rr queue before loading the vmstate
      gdbstub: add reverse step support in replay mode
      gdbstub: add reverse continue support in replay mode
      replay: describe reverse debugging in docs/replay.txt
      tests/acceptance: add reverse debugging test

Pavel Dovgalyuk (4):
      replay: don't record interrupt poll
      qcow2: introduce icount field for snapshots
      migration: introduce icount field for snapshots
      replay: create temporary snapshot at debugger connection

 MAINTAINERS                                      |    7 +-
 Makefile                                         |   28 +-
 accel/kvm/kvm-all.c                              |   33 +-
 accel/kvm/kvm-cpus.c                             |   84 +
 accel/kvm/kvm-cpus.h                             |   24 +
 accel/kvm/meson.build                            |    5 +-
 accel/kvm/trace-events                           |    1 +
 accel/meson.build                                |    2 +-
 accel/qtest/meson.build                          |    7 +
 accel/qtest/qtest-cpus.c                         |   91 +
 accel/qtest/qtest-cpus.h                         |   17 +
 accel/{ => qtest}/qtest.c                        |   13 +-
 accel/stubs/hax-stub.c                           |   10 -
 accel/stubs/hvf-stub.c                           |   30 -
 accel/stubs/kvm-stub.c                           |   23 -
 accel/stubs/meson.build                          |    2 -
 accel/stubs/whpx-stub.c                          |   47 -
 accel/tcg/cpu-exec.c                             |   64 +-
 accel/tcg/meson.build                            |    2 +-
 accel/tcg/tcg-all.c                              |   42 +-
 accel/tcg/tcg-cpus.c                             |  570 +++++++
 accel/tcg/tcg-cpus.h                             |   17 +
 accel/tcg/translate-all.c                        |    3 +-
 accel/tcg/translator.c                           |    1 +
 block/qapi.c                                     |   18 +-
 block/qcow2-snapshot.c                           |    9 +
 block/qcow2.h                                    |    3 +
 blockdev.c                                       |   10 +
 configure                                        |  231 +--
 default-configs/targets/aarch64-softmmu.mak      |    1 +
 default-configs/targets/arm-softmmu.mak          |    1 +
 default-configs/targets/microblaze-softmmu.mak   |    1 +
 default-configs/targets/microblazeel-softmmu.mak |    1 +
 default-configs/targets/mips64el-softmmu.mak     |    1 +
 default-configs/targets/ppc-softmmu.mak          |    1 +
 default-configs/targets/ppc64-softmmu.mak        |    1 +
 default-configs/targets/riscv32-softmmu.mak      |    1 +
 default-configs/targets/riscv64-softmmu.mak      |    1 +
 default-configs/targets/rx-softmmu.mak           |    1 +
 dma-helpers.c                                    |    4 +-
 docs/interop/qcow2.txt                           |    5 +
 docs/replay.txt                                  |   52 +-
 exec.c                                           |   12 +-
 gdbstub.c                                        |   64 +-
 hmp-commands-info.hx                             |   11 +
 hmp-commands.hx                                  |   50 +
 hw/core/cpu.c                                    |   14 +-
 hw/core/ptimer.c                                 |    8 +-
 hw/i386/x86.c                                    |    3 +-
 include/block/snapshot.h                         |    1 +
 include/exec/cpu-all.h                           |    4 +
 include/exec/exec-all.h                          |    4 +-
 include/hw/core/cpu.h                            |   14 -
 include/monitor/hmp.h                            |    4 +
 include/qemu/timer.h                             |   24 +-
 include/sysemu/cpu-timers.h                      |   90 +
 include/sysemu/cpus.h                            |   50 +-
 include/sysemu/hax.h                             |   17 -
 include/sysemu/hvf.h                             |    8 -
 include/sysemu/hw_accel.h                        |   69 +-
 include/sysemu/kvm.h                             |    7 -
 include/sysemu/qtest.h                           |    2 +
 include/sysemu/replay.h                          |   30 +-
 include/sysemu/whpx.h                            |   19 -
 meson.build                                      |  164 +-
 meson_options.txt                                |    6 +
 migration/savevm.c                               |   17 +-
 net/meson.build                                  |    2 +-
 qapi/block-core.json                             |   11 +-
 qapi/meson.build                                 |    1 +
 qapi/misc.json                                   |   18 -
 qapi/qapi-schema.json                            |    1 +
 qapi/replay.json                                 |  121 ++
 replay/meson.build                               |    1 +
 replay/replay-debugging.c                        |  334 ++++
 replay/replay-events.c                           |    4 +
 replay/replay-internal.h                         |    6 +-
 replay/replay.c                                  |   28 +-
 softmmu/cpu-timers.c                             |  279 +++
 softmmu/cpus.c                                   | 1967 +++-------------------
 softmmu/icount.c                                 |  492 ++++++
 softmmu/meson.build                              |   10 +-
 softmmu/qtest.c                                  |   34 +-
 softmmu/timers-state.h                           |   69 +
 softmmu/vl.c                                     |    8 +-
 stubs/clock-warp.c                               |    7 -
 stubs/cpu-get-clock.c                            |    3 +-
 stubs/cpu-get-icount.c                           |   16 -
 stubs/cpu-synchronize-state.c                    |    9 +
 stubs/cpus-get-virtual-clock.c                   |    8 +
 stubs/icount.c                                   |   45 +
 stubs/meson.build                                |    6 +-
 stubs/qemu-timer-notify-cb.c                     |    2 +-
 stubs/qtest.c                                    |    5 +
 stubs/replay.c                                   |   15 +
 target/alpha/translate.c                         |    3 +-
 target/arm/helper.c                              |    7 +-
 target/i386/hax-all.c                            |   17 +-
 target/i386/hax-cpus.c                           |   84 +
 target/i386/hax-cpus.h                           |   33 +
 target/i386/hax-i386.h                           |    2 +
 target/i386/hax-mem.c                            |    2 +-
 target/i386/hax-posix.c                          |   13 +-
 target/i386/hax-windows.c                        |   22 +-
 target/i386/hax-windows.h                        |    2 +
 target/i386/hvf/hvf-cpus.c                       |  131 ++
 target/i386/hvf/hvf-cpus.h                       |   25 +
 target/i386/hvf/hvf.c                            |   12 +-
 target/i386/hvf/meson.build                      |    1 +
 target/i386/hvf/x86hvf.c                         |    2 +
 target/i386/hvf/x86hvf.h                         |    1 -
 target/i386/meson.build                          |   14 +-
 target/i386/whpx-all.c                           |   13 +-
 target/i386/whpx-cpus.c                          |   96 ++
 target/i386/whpx-cpus.h                          |   34 +
 target/riscv/csr.c                               |    8 +-
 tests/acceptance/reverse_debugging.py            |  208 +++
 tests/ptimer-test-stubs.c                        |    5 +-
 tests/qemu-iotests/261                           |   19 +-
 tests/qemu-iotests/261.out                       |   51 +-
 tests/qemu-iotests/267.out                       |   48 +-
 tests/qtest/meson.build                          |    6 +-
 tests/test-timed-average.c                       |    2 +-
 util/main-loop.c                                 |   12 +-
 util/qemu-timer.c                                |   14 +-
 125 files changed, 4081 insertions(+), 2465 deletions(-)
 create mode 100644 accel/kvm/kvm-cpus.c
 create mode 100644 accel/kvm/kvm-cpus.h
 create mode 100644 accel/qtest/meson.build
 create mode 100644 accel/qtest/qtest-cpus.c
 create mode 100644 accel/qtest/qtest-cpus.h
 rename accel/{ => qtest}/qtest.c (81%)
 delete mode 100644 accel/stubs/hvf-stub.c
 delete mode 100644 accel/stubs/whpx-stub.c
 create mode 100644 accel/tcg/tcg-cpus.c
 create mode 100644 accel/tcg/tcg-cpus.h
 create mode 100644 include/sysemu/cpu-timers.h
 create mode 100644 qapi/replay.json
 create mode 100644 replay/replay-debugging.c
 create mode 100644 softmmu/cpu-timers.c
 create mode 100644 softmmu/icount.c
 create mode 100644 softmmu/timers-state.h
 delete mode 100644 stubs/clock-warp.c
 delete mode 100644 stubs/cpu-get-icount.c
 create mode 100644 stubs/cpu-synchronize-state.c
 create mode 100644 stubs/cpus-get-virtual-clock.c
 create mode 100644 stubs/icount.c
 create mode 100644 target/i386/hax-cpus.c
 create mode 100644 target/i386/hax-cpus.h
 create mode 100644 target/i386/hvf/hvf-cpus.c
 create mode 100644 target/i386/hvf/hvf-cpus.h
 create mode 100644 target/i386/whpx-cpus.c
 create mode 100644 target/i386/whpx-cpus.h
 create mode 100644 tests/acceptance/reverse_debugging.py
-- 
2.26.2


