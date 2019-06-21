Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5101BC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BED321530
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BED321530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32774 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heIfi-00067d-C5
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 08:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51459)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1heHsY-0008Nz-M9
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:38:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1heHsS-0006yj-Iw
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:38:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35108)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1heHsQ-0006vK-RU
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:38:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id c6so6284096wml.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 04:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:cc:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=O8fnh++1Jxm6NrQHrqP2phcCwmABgizmm/acikDrvXg=;
 b=hr7kY9HUQ2dsmzGmHpw3dcY1nsMT6lWd/srD7RvXiuteY8cy0Vwpl52uJPvSIu8bg9
 BGkM4GWansOvrYRRTY/Xn/2P7fqKpSCtYd0uIfznfqGVnCs19aRYuBY6lYQL/NtEaBhn
 yjVXiYZGBKs20agea2qvQ5LJDw4u7uMloDKSDrX1CGHBM72pHjhlxAOSLYd1Und51Fs4
 JUVLihANmvzCNCMtGJ80Jtl8PL3lMa6G4GTpH5wAsHL876BufUYvVzfthAKVE0EuFC9V
 R7nJwrWscX+//wRbVIbvYBEugVRqNnootq9Tg7zByuOynUjNkLNGM5vBAJRah0vrQim1
 90MQ==
X-Gm-Message-State: APjAAAXBiFFFXJsyfGV6bjBsd9bZGIxwgqwVKQmnqcxAbXUh3lGldCad
 morAXgReN3FIE2m/xCSPHiphIG3Zuzk=
X-Google-Smtp-Source: APXvYqyugEoaOZ6wU57J1Yg5alzIHWhGhObpVd3MnkKX+REfG0kXS9JLjBOa4NjhQsuUlGwpqo6nyg==
X-Received: by 2002:a05:600c:2056:: with SMTP id
 p22mr3784826wmg.155.1561117114725; 
 Fri, 21 Jun 2019 04:38:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:45fb:a0de:928e:79e8?
 ([2001:b07:6468:f312:45fb:a0de:928e:79e8])
 by smtp.gmail.com with ESMTPSA id q10sm2472520wrf.32.2019.06.21.04.38.33
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 04:38:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
References: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
Message-ID: <52c7ce77-0f39-eb32-2248-2d6ab9a288f4@redhat.com>
Date: Fri, 21 Jun 2019 13:38:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PULL 00/25] Misc (mostly x86) patches for
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/06/19 03:42, Paolo Bonzini wrote:
> The following changes since commit 33d609990621dea6c7d056c86f707b8811320ac1:
> 
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-06-18 17:00:52 +0100)
> 
> are available in the git repository at:
> 
> 
>   git://github.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to 15e7ea4a8e0ed97361fefabb04c6a9aaebe321df:
> 
>   hw: Nuke hw_compat_4_0_1 and pc_compat_4_0_1 (2019-06-21 02:29:40 +0200)

The nested live migration series had failed to apply on Patchew, and
therefore it wasn't covered by CI.  Therefore^2 I missed some checkpatch
complaints, and I'm sending v2 of the pull request with those fixed.

Paolo

> ----------------------------------------------------------------
> * Nuke hw_compat_4_0_1 and pc_compat_4_0_1 (Greg)
> * Static analysis fixes (Igor, Lidong)
> * X86 Hyper-V CPUID improvements (Vitaly)
> * X86 nested virt migration (Liran)
> * New MSR-based features (Xiaoyao)
> 
> ----------------------------------------------------------------
> Colin Xu (1):
>       hax: Honor CPUState::halted
> 
> Greg Kurz (1):
>       hw: Nuke hw_compat_4_0_1 and pc_compat_4_0_1
> 
> Lidong Chen (2):
>       sd: Fix out-of-bounds assertions
>       util/main-loop: Fix incorrect assertion
> 
> Liran Alon (10):
>       target/i386: kvm: Delete VMX migration blocker on vCPU init failure
>       KVM: Introduce kvm_arch_destroy_vcpu()
>       target/i386: kvm: Use symbolic constant for #DB/#BP exception constants
>       target/i386: kvm: Re-inject #DB to guest with updated DR6
>       target/i386: kvm: Block migration for vCPUs exposed with nested virtualization
>       linux-headers: sync with latest KVM headers from Linux 5.2
>       vmstate: Add support for kernel integer types
>       target/i386: kvm: Add support for save and restore nested state
>       target/i386: kvm: Add support for KVM_CAP_EXCEPTION_PAYLOAD
>       target/i386: kvm: Add nested migration blocker only when kernel lacks required capabilities
> 
> Vitaly Kuznetsov (9):
>       i386/kvm: convert hyperv enlightenments properties from bools to bits
>       i386/kvm: add support for KVM_GET_SUPPORTED_HV_CPUID
>       i386/kvm: move Hyper-V CPUID filling to hyperv_handle_properties()
>       i386/kvm: document existing Hyper-V enlightenments
>       i386/kvm: implement 'hv-passthrough' mode
>       i386/kvm: hv-stimer requires hv-time and hv-synic
>       i386/kvm: hv-tlbflush/ipi require hv-vpindex
>       i386/kvm: hv-evmcs requires hv-vapic
>       i386/kvm: add support for Direct Mode for Hyper-V synthetic timers
> 
> Xiaoyao Li (1):
>       target/i386: define a new MSR based feature word - FEAT_CORE_CAPABILITY
> 
> Yury Kotov (1):
>       kvm-all: Add/update fprintf's for kvm_*_ioeventfd_del
> 
>  accel/kvm/kvm-all.c         |  25 +-
>  cpus.c                      |   1 -
>  docs/hyperv.txt             | 201 +++++++++
>  hw/core/machine.c           |   5 +-
>  hw/i386/pc.c                |   6 +-
>  hw/i386/pc_q35.c            |  12 +-
>  hw/sd/sd.c                  |   4 +-
>  include/hw/boards.h         |   3 -
>  include/hw/i386/pc.h        |   3 -
>  include/migration/vmstate.h |  26 ++
>  include/sysemu/kvm.h        |   2 +
>  linux-headers/asm-x86/kvm.h |  33 +-
>  target/arm/kvm32.c          |   5 +
>  target/arm/kvm64.c          |   5 +
>  target/i386/cpu.c           |  81 +++-
>  target/i386/cpu.h           |  75 +++-
>  target/i386/hax-all.c       |  36 +-
>  target/i386/hvf/hvf.c       |  10 +-
>  target/i386/hvf/x86hvf.c    |   4 +-
>  target/i386/hyperv-proto.h  |   1 +
>  target/i386/hyperv.c        |   2 +-
>  target/i386/kvm.c           | 999 +++++++++++++++++++++++++++++++++-----------
>  target/i386/machine.c       | 284 ++++++++++++-
>  target/mips/kvm.c           |   5 +
>  target/ppc/kvm.c            |   5 +
>  target/s390x/kvm.c          |  10 +
>  util/main-loop.c            |   2 +-
>  27 files changed, 1516 insertions(+), 329 deletions(-)
>  create mode 100644 docs/hyperv.txt
> 


