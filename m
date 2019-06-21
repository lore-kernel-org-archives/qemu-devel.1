Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C497C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:34:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 267552084E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/vny7j8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267552084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59862 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heHoe-0003Ui-CI
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 07:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48966)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1heHkT-0000aw-H9
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1heHkQ-0005FM-DP
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:29 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45186)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1heHkQ-0005AQ-6o
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:26 -0400
Received: by mail-wr1-x443.google.com with SMTP id f9so6189498wre.12
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 04:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nGHMwhO1fbzwJ6Oe64D70SxZeN/4yeCZohb+lxoxTV8=;
 b=B/vny7j8DCO0vx+Tecsjt37JqT1aXO2rJiyGRjygcCq8D9i+tSJP4cdWmStsYG82d+
 k3APJXV7AEtdxgeueWgU7xU1V7rBabI1H5UpWBpfXc8mrF39WU/gZH89toBzoPwUoRGi
 nFpp6ts54YylILNAbmDLtY4bsQJb+Eav5sb3pD8szyQO5JwrOpED/VvPJ0ka7DyHBkfV
 yIh9nZvV/lnLVOBrXnnCeq0VoI8l1CChdN8bNbv8KZV79+ZGhWO/G7DZOK+BbthySXK8
 x9zHztxdQ7wAQAQWnUDV+Z0w+8uq1s1y0XplVHRGPsYB6Y1VM3LKsyn3uHoQG+ewa7Wv
 ooiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=nGHMwhO1fbzwJ6Oe64D70SxZeN/4yeCZohb+lxoxTV8=;
 b=TouVltsVbF4mEkwvzV+wXCWWD9xa/fn/8jKFthFU0peePgpNwdnZlE6a0IxsmyGHHv
 oZSxaqVRFcaeN+Yzgg2l9HqCAFvIgoI4jlJYVbImCKiPYtDfl+hR9m1/3up6ACGJwpK/
 wz/XPi8hOoZCbAHUUDkiif7En7yJZtXikEaRAgpdJsGWCrBLbpL29eDizA/VtsTRfXr2
 ki5bN0f8x8oUWU51ZbmzBWxxU2+7BY/XVeKWDwW1cKKUUGEi0YaZRZgKK4ohfdwhN+/w
 uFV/HKscY8GyFf2/7ZhmimYyeCt0zW4s+PI//JRSGpnuqn9O24Gbm/aFaWx8XWDD8eX2
 LYgw==
X-Gm-Message-State: APjAAAUiIbJwAuS8oujLPgTpLlReVQ8NE6N83eTB3bTWxvv9IGzGwstE
 CnOgCAYgVPaoEtV5hDdQ/3wSlcRU
X-Google-Smtp-Source: APXvYqxVCKkfz8rJetOlT1A4LX06vnn3qvVM8LK8ONeuE3Xm+ViAh9hnLIhx0BU9pfq5YRl4gJBeLw==
X-Received: by 2002:adf:f1d1:: with SMTP id z17mr40870503wro.190.1561116622325; 
 Fri, 21 Jun 2019 04:30:22 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id r3sm2712851wrr.61.2019.06.21.04.30.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 04:30:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 13:29:55 +0200
Message-Id: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PULL v2 00/25] Misc (mostly x86) patches for
 2019-06-21
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

The following changes since commit 33d609990621dea6c7d056c86f707b8811320ac1:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-06-18 17:00:52 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 8e8cbed09ad9d577955691b4c061b61b602406d1:

  hw: Nuke hw_compat_4_0_1 and pc_compat_4_0_1 (2019-06-21 13:25:29 +0200)

----------------------------------------------------------------
* Nuke hw_compat_4_0_1 and pc_compat_4_0_1 (Greg)
* Static analysis fixes (Igor, Lidong)
* X86 Hyper-V CPUID improvements (Vitaly)
* X86 nested virt migration (Liran)
* New MSR-based features (Xiaoyao)

----------------------------------------------------------------
Colin Xu (1):
      hax: Honor CPUState::halted

Greg Kurz (1):
      hw: Nuke hw_compat_4_0_1 and pc_compat_4_0_1

Lidong Chen (2):
      sd: Fix out-of-bounds assertions
      util/main-loop: Fix incorrect assertion

Liran Alon (10):
      target/i386: kvm: Delete VMX migration blocker on vCPU init failure
      KVM: Introduce kvm_arch_destroy_vcpu()
      target/i386: kvm: Use symbolic constant for #DB/#BP exception constants
      target/i386: kvm: Re-inject #DB to guest with updated DR6
      target/i386: kvm: Block migration for vCPUs exposed with nested virtualization
      linux-headers: sync with latest KVM headers from Linux 5.2
      vmstate: Add support for kernel integer types
      target/i386: kvm: Add support for save and restore nested state
      target/i386: kvm: Add support for KVM_CAP_EXCEPTION_PAYLOAD
      target/i386: kvm: Add nested migration blocker only when kernel lacks required capabilities

Vitaly Kuznetsov (9):
      i386/kvm: convert hyperv enlightenments properties from bools to bits
      i386/kvm: add support for KVM_GET_SUPPORTED_HV_CPUID
      i386/kvm: move Hyper-V CPUID filling to hyperv_handle_properties()
      i386/kvm: document existing Hyper-V enlightenments
      i386/kvm: implement 'hv-passthrough' mode
      i386/kvm: hv-stimer requires hv-time and hv-synic
      i386/kvm: hv-tlbflush/ipi require hv-vpindex
      i386/kvm: hv-evmcs requires hv-vapic
      i386/kvm: add support for Direct Mode for Hyper-V synthetic timers

Xiaoyao Li (1):
      target/i386: define a new MSR based feature word - FEAT_CORE_CAPABILITY

Yury Kotov (1):
      kvm-all: Add/update fprintf's for kvm_*_ioeventfd_del

 accel/kvm/kvm-all.c         |  25 +-
 cpus.c                      |   1 -
 docs/hyperv.txt             | 201 +++++++++
 hw/core/machine.c           |   5 +-
 hw/i386/pc.c                |   6 +-
 hw/i386/pc_q35.c            |  12 +-
 hw/sd/sd.c                  |   4 +-
 include/hw/boards.h         |   3 -
 include/hw/i386/pc.h        |   3 -
 include/migration/vmstate.h |  26 ++
 include/sysemu/kvm.h        |   2 +
 linux-headers/asm-x86/kvm.h |  33 +-
 target/arm/kvm32.c          |   5 +
 target/arm/kvm64.c          |   5 +
 target/i386/cpu.c           |  81 +++-
 target/i386/cpu.h           |  65 ++-
 target/i386/hax-all.c       |  36 +-
 target/i386/hvf/hvf.c       |  10 +-
 target/i386/hvf/x86hvf.c    |   4 +-
 target/i386/hyperv-proto.h  |   1 +
 target/i386/hyperv.c        |   2 +-
 target/i386/kvm.c           | 999 +++++++++++++++++++++++++++++++++-----------
 target/i386/machine.c       | 284 ++++++++++++-
 target/mips/kvm.c           |   5 +
 target/ppc/kvm.c            |   5 +
 target/s390x/kvm.c          |  10 +
 util/main-loop.c            |   2 +-
 27 files changed, 1506 insertions(+), 329 deletions(-)
 create mode 100644 docs/hyperv.txt
-- 
1.8.3.1


