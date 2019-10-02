Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3C0C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 16:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAE9821920
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 16:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phI6wvFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE9821920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFhsx-0006ng-FU
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 12:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhr4-000570-Hf
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhr3-00033x-7b
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:51:58 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51951)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFhr2-00032S-VW
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:51:57 -0400
Received: by mail-wm1-x342.google.com with SMTP id 7so7979681wme.1
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RlGVGBCtzPQHiyhlqLIjunehNFoE63BJ9stQ7pnTfeY=;
 b=phI6wvFGa8EQydfPi38xegiWea9Db6PykbR638HkAm0mht25LN0ijCFmpFEor7TAa1
 QpKL98jydGxRpw18ck97nfb84he+rSj6NiEzPUXqAYiH8f16JM3YIsNiYqa5Xs1CwsC/
 6zPs7NmCQwMv1CWCsAGYODZU638+avRBQjS0AznrJanC19rqE5RZZ6+PySKNai5JAt8b
 sTnDx2P6ik9SUG/josWpX7V46qMaY4utPzShKOtb9Vt7rj7Lh7xqpIuGF9hbod5pWPl7
 uon9ZTbodupQTM7tDyz8H0ROBcy0EA0ES5IIF7y/BT+hrlfFmfvaPFXEYFzrSXUCj262
 4uuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=RlGVGBCtzPQHiyhlqLIjunehNFoE63BJ9stQ7pnTfeY=;
 b=cOBHliL/y3Vsnj++QcTvMJjywb0O/KE14xRKTSdqysq1okaHqJzmL+yTBYZIgm4tVT
 wbjJ3DwZIcM7Vr7ZbECrcx9yjXdxV57oiHHjpbJ9GG1HHsWOWbKKCVTpGDHu3kb3ryGw
 aX0Nh8syUFC2VFdIDF/cek2M8PdxGaD3JzolvdD9vbF/HMEYBR/y894CF6TOt3cdYxq4
 hvzmZb5X2XR366M/GhQK9P2lXMVioHUTaQhJUboKe19SlYyBtcvXGIHJcd7LdLP0x+oq
 8+IHYvli+wobLlk9hdRUVQfibxDRWWGZZpcEkCmxtfoIW5mHU6KLor3sYSpjFR7JeZ6d
 3GzQ==
X-Gm-Message-State: APjAAAWHzJlx/kW8XeSzL2M9i/FMPtP5yQTlJur1SmSzQs6/74FCQMgw
 cP7an9szd/M+GUaEXaP57Rqj/LnV
X-Google-Smtp-Source: APXvYqwhaNaXBY7JscFOI3MRTFXfSg9P/xwuUkGSEQt2fWkyH7vwRfDfswDV1r31XcrNNI7Ke8Lw+g==
X-Received: by 2002:a1c:1981:: with SMTP id 123mr3567013wmz.88.1570035115142; 
 Wed, 02 Oct 2019 09:51:55 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g4sm27303990wrw.9.2019.10.02.09.51.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:51:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/30] Misc patches for 2010-10-02
Date: Wed,  2 Oct 2019 18:51:23 +0200
Message-Id: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

for you to fetch changes up to 52c8850d80c5bf34afd3b203b912217f45327a9e:

  accel/kvm: ensure ret always set (2019-10-02 18:37:27 +0200)

----------------------------------------------------------------
* Compilation fix for KVM (Alex)
* SMM fix (Dmitry)
* VFIO error reporting (Eric)
* win32 fixes and workarounds (Marc-André)
* qemu-pr-helper crash bugfix (Maxim)
* VMX feature flags (myself)
* Memory leak fixes (myself)
* Record-replay deadlock (Pavel)
* i386 CPUID bits (Sebastian)
* kconfig tweak (Thomas)
* Valgrind fix (Thomas)
* distclean improvement (Thomas)
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
      target/i386: handle filtered_features in a new function mark_unavailable_features
      target/i386: introduce generic feature dependency mechanism
      target/i386: expand feature words to 64 bits
      target/i386: add VMX definitions
      vmxcap: correct the name of the variables
      target/i386: add VMX features
      target/i386: work around KVM_GET_MSRS bug for secondary execution controls
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

Thomas Huth (3):
      target/i386/kvm: Silence warning from Valgrind about uninitialized bytes
      Makefile: Remove generated files when doing 'distclean'
      hw/isa: Introduce a CONFIG_ISA_SUPERIO switch for isa-superio.c

Yury Kotov (1):
      tests/migration: Add a test for auto converge

 Makefile                      |   6 +-
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
 target/i386/kvm.c             | 183 ++++++++++++++++-
 tests/Makefile.include        |  12 +-
 tests/docker/test-clang       |   4 +-
 tests/docker/test-debug       |   1 +
 tests/migration-test.c        | 157 +++++++++++++--
 tests/test-char.c             |   4 +-
 util/async.c                  |   6 +-
 util/oslib-win32.c            |   6 +-
 40 files changed, 1050 insertions(+), 248 deletions(-)
-- 
1.8.3.1


