Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D5BC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 17:02:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5262020862
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 17:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVzzCoQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5262020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGQyd-0000OX-Dj
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 13:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iGQvU-0007Mf-07
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 12:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iGQvS-0001tV-MV
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 12:59:31 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:37902)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iGQvS-0001sl-7N
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 12:59:30 -0400
Received: by mail-wr1-x42f.google.com with SMTP id w12so8092088wro.5
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 09:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RQPohqW7NZaVI6Th9jibedWRq2IrEVvfVqsxST0+z9U=;
 b=jVzzCoQ/IFERfABtjcDOGgdhkEGFWLaPjNFbwSAvSC+oZ3LR0ADkiOCaUzAaX8iJgJ
 upgN3wgefl1O7HQ0vHtSGPzvueOMJ1UjMuKgsqR5/FYUyTT2m+/7K91wSEcMZznelh1S
 M9/18fE6yBh7RmQJw0mL2NWZ2NvAkFzABqN80OT6S85FmxvDSBtiMebeRBHmcDa3dJEm
 OCZ5s7W5hjRkwqp25Tvt8GFeICTsiQhCMUOF+WMmKIpdn8BiRYJQAEvDxsaFR61P1t7t
 w/lIxi0Rsy1jRuPIwQ1+Rk9EzFFT/usahfvWKRxCfEQzsP8uprsf15KGnmX3Buhq31FV
 Fkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=RQPohqW7NZaVI6Th9jibedWRq2IrEVvfVqsxST0+z9U=;
 b=hRA1oYmcL2Ebrcf85YpJ8otDub7CAXeZbGGuBqkL23g0G41mjkf/Pw1AhkuC0hqPKL
 WzdYkzbS7nEVWWU2MDaSAnG39gG+uzCTU4zKPO6bHI7OX9juBhi/0GR+LtiOCrjzUFGB
 JWaEhm3nD/umzurR2mFjBaPlPTH2VD8vhsyVgv2mYYOJlR0LSBmGBn8uWERDU0DakgRy
 93xzGs2zW6vOUJMF0nk0xI/2LOCDg4W1I/9LXJ2DNLy53VxYgQzQa4xvYMHW49KuBRSr
 baSQSl/oFgBlcCEJ32BStmoyy20En6GoSNNtmUFkSuVJuaV1lTwbQQsX34x4x7ddzplH
 INCg==
X-Gm-Message-State: APjAAAWcVGXHuEx9qfhExYpnnM1Ml4thSzPWj1wuvfjbflnUCEGWU/W7
 0PB0HoiFS04jxauHKjGtsd5tQT8Q
X-Google-Smtp-Source: APXvYqzA1YZSLVkHfB3mlccwkiZzqd1KVrMGmL7xt6sUOMSAHeFja2dnWa4t3/2KsnZYqoXQO1GsdA==
X-Received: by 2002:adf:fa0e:: with SMTP id m14mr7778831wrr.11.1570208366653; 
 Fri, 04 Oct 2019 09:59:26 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id u7sm7041270wrp.19.2019.10.04.09.59.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 04 Oct 2019 09:59:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 00/29] Misc patches for 2019-10-02
Date: Fri,  4 Oct 2019 18:59:15 +0200
Message-Id: <1570208363-11948-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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

The following changes since commit 7f21573c822805a8e6be379d9bcf3ad9effef3dc:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-10-01' into staging (2019-10-01 13:13:38 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to a1834d975f7d329b128965dd69bc3aaa7195f5a2:

  target/i386/kvm: Silence warning from Valgrind about uninitialized bytes (2019-10-04 18:49:20 +0200)

----------------------------------------------------------------
* Compilation fix for KVM (Alex)
* SMM fix (Dmitry)
* VFIO error reporting (Eric)
* win32 fixes and workarounds (Marc-André)
* qemu-pr-helper crash bugfix (Maxim)
* Memory leak fixes (myself)
* VMX features (myself)
* Record-replay deadlock (Pavel)
* i386 CPUID bits (Sebastian)
* kconfig tweak (Thomas)
* Valgrind fix (Thomas)
* Autoconverge test (Yury)

----------------------------------------------------------------
Alex Bennée (1):
      accel/kvm: ensure ret always set

Dmitry Poletaev (1):
      Fix wrong behavior of cpu_memory_rw_debug() function in SMM

Eric Auger (2):
      vfio: Turn the container error into an Error handle
      memory: allow memory_region_register_iommu_notifier() to fail

Marc-André Lureau (3):
      util: WSAEWOULDBLOCK on connect should map to EINPROGRESS
      tests: skip serial test on windows
      win32: work around main-loop busy loop on socket/fd event

Maxim Levitsky (1):
      qemu-pr-helper: fix crash in mpath_reconstruct_sense

Paolo Bonzini (16):
      ide: fix leak from qemu_allocate_irqs
      microblaze: fix leak of fdevice tree blob
      mcf5208: fix leak from qemu_allocate_irqs
      hppa: fix leak from g_strdup_printf
      mips: fix memory leaks in board initialization
      cris: do not leak struct cris_disasm_data
      lm32: do not leak memory on object_new/object_unref
      docker: test-debug: disable LeakSanitizer
      tests/docker: only enable ubsan for test-clang
      target/i386: handle filtered_features in a new function mark_unavailable_features
      target/i386: introduce generic feature dependency mechanism
      target/i386: expand feature words to 64 bits
      target/i386: add VMX definitions
      vmxcap: correct the name of the variables
      target/i386: add VMX features
      target/i386: work around KVM_GET_MSRS bug for secondary execution controls

Pavel Dovgaluk (1):
      replay: don't synchronize memory operations in replay mode

Sebastian Andrzej Siewior (1):
      i386: Add CPUID bit for CLZERO and XSAVEERPTR

Thomas Huth (2):
      hw/isa: Introduce a CONFIG_ISA_SUPERIO switch for isa-superio.c
      target/i386/kvm: Silence warning from Valgrind about uninitialized bytes

Yury Kotov (1):
      tests/migration: Add a test for auto converge

 accel/kvm/kvm-all.c           |   6 +-
 disas/cris.c                  |  59 +++---
 exec.c                        |  23 ++-
 hw/arm/smmuv3.c               |  18 +-
 hw/hppa/dino.c                |   1 +
 hw/hppa/machine.c             |   4 +-
 hw/i386/amd_iommu.c           |  17 +-
 hw/i386/intel_iommu.c         |   8 +-
 hw/ide/cmd646.c               |   1 +
 hw/isa/Kconfig                |  10 +-
 hw/isa/Makefile.objs          |   2 +-
 hw/m68k/mcf5208.c             |   2 +
 hw/microblaze/boot.c          |   1 +
 hw/mips/Kconfig               |   1 +
 hw/mips/mips_int.c            |   1 +
 hw/mips/mips_jazz.c           |   2 +
 hw/ppc/spapr_iommu.c          |   8 +-
 hw/timer/lm32_timer.c         |   6 +-
 hw/timer/milkymist-sysctl.c   |  10 +-
 hw/vfio/common.c              |  52 +++--
 hw/vfio/spapr.c               |   4 +-
 hw/virtio/vhost.c             |   9 +-
 include/exec/memory.h         |  21 +-
 include/hw/vfio/vfio-common.h |   2 +-
 include/sysemu/kvm.h          |   2 +-
 memory.c                      |  31 +--
 scripts/kvm/vmxcap            |  14 +-
 scsi/qemu-pr-helper.c         |   6 +-
 target/i386/cpu.c             | 447 +++++++++++++++++++++++++++++++++---------
 target/i386/cpu.h             | 146 +++++++++++++-
 target/i386/helper.c          |   5 +-
 target/i386/kvm.c             | 185 ++++++++++++++++-
 tests/docker/test-clang       |   4 +-
 tests/docker/test-debug       |   1 +
 tests/migration-test.c        | 157 +++++++++++++--
 tests/test-char.c             |   4 +-
 util/async.c                  |   6 +-
 util/oslib-win32.c            |   6 +-
 38 files changed, 1038 insertions(+), 244 deletions(-)
-- 
1.8.3.1


