Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D013C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 11:02:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 584DF218DE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 11:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrdbP2cK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584DF218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFysA-0003aD-1W
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 07:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFypU-0002O5-VD
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:59:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFypP-0003uS-LU
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:59:28 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33077)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFypP-0003rD-7l
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:59:23 -0400
Received: by mail-wr1-x444.google.com with SMTP id b9so2484432wrs.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 03:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mj08ruo+mSzrmNeE9C3Au4yHvuIS25YuGCkEgbFLHmU=;
 b=lrdbP2cKnQGLRL4tF0JFoPKEYNL8BOCFButZ41O1sU5JUnLLrbgIXJmgDDsf9n/8ie
 9OtbCbV8r+Rm1CCJ/gqufzepsS9j/T1m/W+gfdWfCnRKu9ZYpJO2jxVUXRC6B0vhKnGS
 IZb1DfKnZsf43JMU11fEgFv5NFdr4rkqaKBX3qDLVTmv+lsSQ58WRxIkHgh0J8tsjz/r
 ML2h5m54r1Thi1aoYY9/JOdVhNECCPyTb1DTb7rfDG9ikeTN9sqdyYTjAJFwaaC7VMcE
 R1xa4HtNxXqrg4kZDzBfjv/YaKoZPnky6z336P9eVUBxUH/IzHVnQzbAxc78rHZJsHHo
 hq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=mj08ruo+mSzrmNeE9C3Au4yHvuIS25YuGCkEgbFLHmU=;
 b=PNJ+lsWxtwxJinmqjAW9tgMxMl3h2HsxTSzXmU4vGjnMGKHaIYDRNw6YXM0aPHJ8AJ
 ar+kuOFoM41eZa0+64yCI5Qq2T1bqPbNyD5vptxlZRXpfvBW1x8L6Z9RzLL4UA+bWaRm
 Ot1xBz594bksWiXcOPB6IBPoOfCjflBEWTSWzHMzJILVGh5LMMKmp9w7mFAcm7CCCV9u
 skSEoiEyESOp1x0EoIhdzZLqRu8aoXAZzTbLle0QLx0GucQ6ejeJ55YNv8fANsr37sTq
 RnHz/55nqcwjHtjb3LYGCa9vo7BgfqOX7NUTH6v0SLbL8uOOh4+oeUs4s1OtUNMkpFU0
 JpSg==
X-Gm-Message-State: APjAAAUtZ732FVVapp2N4HJLIj7prWZbezd106+AzOUks4GJF3j8O15i
 TQGIHXPAtI9Iy0M36QG4djjswsR9
X-Google-Smtp-Source: APXvYqzs2+CZaVI5ph10mibUGkFXNUNKn79nRqu2kPPJrUCfwOVgm9CMMpFQsBawt3EXufnqZL0BFw==
X-Received: by 2002:a5d:6701:: with SMTP id o1mr7097273wru.6.1570100361201;
 Thu, 03 Oct 2019 03:59:21 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id l10sm3391485wrh.20.2019.10.03.03.59.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Oct 2019 03:59:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/22] Misc patches for 2010-10-02
Date: Thu,  3 Oct 2019 12:59:18 +0200
Message-Id: <1570100358-22344-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570100358-22344-1-git-send-email-pbonzini@redhat.com>
References: <1570100358-22344-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

for you to fetch changes up to 8cd5aa6899689e6f9f3e72bf43474a436148a341:

  tests/docker: only enable ubsan for test-clang (2019-10-03 12:58:05 +0200)

----------------------------------------------------------------
* Compilation fix for KVM (Alex)
* SMM fix (Dmitry)
* VFIO error reporting (Eric)
* win32 fixes and workarounds (Marc-André)
* qemu-pr-helper crash bugfix (Maxim)
* Memory leak fixes (myself)
* Record-replay deadlock (Pavel)
* i386 CPUID bits (Sebastian)
* kconfig tweak (Thomas)
* Valgrind fix (Thomas)
* distclean improvement (Thomas)
* Autoconverge test (Yury)

----------------------------------------------------------------

v1->v2: dropped the VMX patches

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

Paolo Bonzini (9):
      ide: fix leak from qemu_allocate_irqs
      microblaze: fix leak of fdevice tree blob
      mcf5208: fix leak from qemu_allocate_irqs
      hppa: fix leak from g_strdup_printf
      mips: fix memory leaks in board initialization
      cris: do not leak struct cris_disasm_data
      lm32: do not leak memory on object_new/object_unref
      docker: test-debug: disable LeakSanitizer
      tests/docker: only enable ubsan for test-clang

Pavel Dovgaluk (1):
      replay: don't synchronize memory operations in replay mode

Sebastian Andrzej Siewior (1):
      i386: Add CPUID bit for CLZERO and XSAVEERPTR

Thomas Huth (2):
      Makefile: Remove generated files when doing 'distclean'
      hw/isa: Introduce a CONFIG_ISA_SUPERIO switch for isa-superio.c

Yury Kotov (1):
      tests/migration: Add a test for auto converge

 Makefile                      |   6 +-
 accel/kvm/kvm-all.c           |   6 +-
 disas/cris.c                  |  59 ++++++++--------
 exec.c                        |  23 +++++--
 hw/arm/smmuv3.c               |  18 ++---
 hw/hppa/dino.c                |   1 +
 hw/hppa/machine.c             |   4 +-
 hw/i386/amd_iommu.c           |  17 +++--
 hw/i386/intel_iommu.c         |   8 ++-
 hw/ide/cmd646.c               |   1 +
 hw/isa/Kconfig                |  10 ++-
 hw/isa/Makefile.objs          |   2 +-
 hw/m68k/mcf5208.c             |   2 +
 hw/microblaze/boot.c          |   1 +
 hw/mips/Kconfig               |   1 +
 hw/mips/mips_int.c            |   1 +
 hw/mips/mips_jazz.c           |   2 +
 hw/ppc/spapr_iommu.c          |   8 ++-
 hw/timer/lm32_timer.c         |   6 +-
 hw/timer/milkymist-sysctl.c   |  10 +--
 hw/vfio/common.c              |  52 +++++++++-----
 hw/vfio/spapr.c               |   4 +-
 hw/virtio/vhost.c             |   9 ++-
 include/exec/memory.h         |  21 ++++--
 include/hw/vfio/vfio-common.h |   2 +-
 memory.c                      |  31 ++++++---
 scsi/qemu-pr-helper.c         |   6 +-
 target/i386/cpu.c             |   4 +-
 target/i386/cpu.h             |   5 +-
 target/i386/helper.c          |   5 +-
 tests/Makefile.include        |  12 +++-
 tests/docker/test-clang       |   4 +-
 tests/docker/test-debug       |   1 +
 tests/migration-test.c        | 157 +++++++++++++++++++++++++++++++++++++-----
 tests/test-char.c             |   4 +-
 util/async.c                  |   6 +-
 util/oslib-win32.c            |   6 +-
 37 files changed, 372 insertions(+), 143 deletions(-)
-- 
1.8.3.1

