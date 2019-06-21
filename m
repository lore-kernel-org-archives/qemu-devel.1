Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F4FC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 01:54:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BEE12084E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 01:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m83rH5Jz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BEE12084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54064 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he8ko-0004h4-2n
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 21:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40642)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8Za-0006Mx-Aj
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8ZY-00067Z-On
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:42:38 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46109)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1he8ZY-00061Z-FL
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:42:36 -0400
Received: by mail-wr1-x444.google.com with SMTP id n4so4829629wrw.13
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 18:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=w+7TSfA05al3vMslcz/SOoRJBM36JJMcPLAo6eroszE=;
 b=m83rH5JzmClRQcxviYxQqQSExIoxbvRpDWMTslm1bGZluWJl24p7mU2Q48T4ANJVQu
 vMveleM8ovplH4IZTbT2bATxY9oYBlJXZrCfncUwjDBF6DseVdnjqr6omxtEgYlAxW/t
 eB0NMKMoeea88LF00p86gmNCm8Bakr2g7DCw278V20f9MIHTrhYds4YP4G0Sbr3oIKpb
 C9zJUc1NzHlCDVcmceF8tzHEAxs8HgVc+2D7KKFcx2REcARWgmxrJ0gMoVR7Aczg3IGK
 SxOJ7+3mMgUM5goJq4KkORxHZTY0lsyNLN2HAzcz2KMiJ/RvUCV9ofx1N03ZABv8ByHh
 2i9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=w+7TSfA05al3vMslcz/SOoRJBM36JJMcPLAo6eroszE=;
 b=Oqx4tn8vF9WViqOyxRyo9KLi94+msz+TUOkpq1WgC0o7vjdSGeGuRPvjEU+4utaFgh
 RXrJQPPGKKdkc3dNOKsWV1oauB1DgP2oxy9YOhVVd/rV03GJCR4bm9+Qy8FjTmliafwA
 J1R+PSw0BmpyhnneaScDlerJW7X/WvwAQz3zCb06Rrx981eIfphqrTSjEfDEkNkhabEh
 qQIlu39jmAPMsq6wdYFwt8wXd7aZT9SwH1j23Bgofv3KDQMlqYhQvANP8xb5XK/Pmv6u
 37N3ue36rmRwTDhyLl6bGh3XurSmv1qih9qfa1l30kLWFs+gATRyByLTFPteGLBJGVjt
 c+vg==
X-Gm-Message-State: APjAAAXYbOBokruxjbnizKkrWBMCr2VhpvHnZZlxBV0m5mDZS2tRskHC
 w6OAPFL6Qf2ujUiqul/lswhfSplV
X-Google-Smtp-Source: APXvYqzcL+W9RHHl9XT4iNd8YFG/KTiBMK4KrLimZLiRByB8I83h+WDd9OgH9/3QFlkMqC3PW1pdOw==
X-Received: by 2002:adf:f04d:: with SMTP id t13mr12675015wro.36.1561081352238; 
 Thu, 20 Jun 2019 18:42:32 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id d1sm1123125wru.41.2019.06.20.18.42.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 18:42:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 03:42:05 +0200
Message-Id: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PULL 00/25] Misc (mostly x86) patches for 2019-06-21
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

for you to fetch changes up to 15e7ea4a8e0ed97361fefabb04c6a9aaebe321df:

  hw: Nuke hw_compat_4_0_1 and pc_compat_4_0_1 (2019-06-21 02:29:40 +0200)

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
 target/i386/cpu.h           |  75 +++-
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
 27 files changed, 1516 insertions(+), 329 deletions(-)
 create mode 100644 docs/hyperv.txt
-- 
1.8.3.1


