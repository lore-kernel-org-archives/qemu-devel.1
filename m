Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7DDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 14:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1E09204FD
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 14:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E09204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5s4k-0002iW-PB
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 10:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k5s47-0002JT-K0
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 10:49:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:45802)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k5s45-0006Tz-OC
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 10:49:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 1DB1EAD12;
 Wed, 12 Aug 2020 14:49:36 +0000 (UTC)
Subject: Re: [RFC v4 11/14] hvf: remove hvf specific functions from global
 includes
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200811210326.4425-1-cfontana@suse.de>
 <20200811210326.4425-12-cfontana@suse.de>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <a729d3f4-3560-fc4f-aa57-ec02d23f16c2@suse.de>
Date: Wed, 12 Aug 2020 16:49:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200811210326.4425-12-cfontana@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 23:47:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Wenchao Wang <wenchao.wang@intel.com>,
 haxm-team@intel.com, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <rth@twiddle.net>, Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/11/20 11:03 PM, Claudio Fontana wrote:
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>  accel/stubs/Makefile.objs  |  1 -
>  accel/stubs/hvf-stub.c     | 30 ------------------------------
>  include/sysemu/hvf.h       |  8 --------
>  target/i386/hvf/hvf-cpus.c |  1 +
>  target/i386/hvf/hvf-int.h  | 24 ++++++++++++++++++++++++
>  target/i386/hvf/hvf.c      |  1 +
>  target/i386/hvf/x86hvf.c   |  2 ++
>  target/i386/hvf/x86hvf.h   |  1 -
>  8 files changed, 28 insertions(+), 40 deletions(-)
>  delete mode 100644 accel/stubs/hvf-stub.c
>  create mode 100644 target/i386/hvf/hvf-int.h
> 
> diff --git a/accel/stubs/Makefile.objs b/accel/stubs/Makefile.objs
> index bbd14e71fb..6630954f30 100644
> --- a/accel/stubs/Makefile.objs
> +++ b/accel/stubs/Makefile.objs
> @@ -1,5 +1,4 @@
>  obj-$(call lnot,$(CONFIG_HAX))  += hax-stub.o
> -obj-$(call lnot,$(CONFIG_HVF))  += hvf-stub.o
>  obj-$(call lnot,$(CONFIG_WHPX)) += whpx-stub.o
>  obj-$(call lnot,$(CONFIG_KVM))  += kvm-stub.o
>  obj-$(call lnot,$(CONFIG_TCG))  += tcg-stub.o
> diff --git a/accel/stubs/hvf-stub.c b/accel/stubs/hvf-stub.c
> deleted file mode 100644
> index e81dfe888c..0000000000
> --- a/accel/stubs/hvf-stub.c
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -/*
> - * QEMU HVF support
> - *
> - * Copyright 2017 Red Hat, Inc.
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2 or later, as published by the Free Software Foundation,
> - * and may be copied, distributed, and modified under those terms.
> - *
> - * See the COPYING file in the top-level directory.
> - *
> - */
> -
> -#include "qemu/osdep.h"
> -#include "cpu.h"
> -#include "sysemu/hvf.h"
> -
> -int hvf_init_vcpu(CPUState *cpu)
> -{
> -    return -ENOSYS;
> -}
> -
> -int hvf_vcpu_exec(CPUState *cpu)
> -{
> -    return -ENOSYS;
> -}
> -
> -void hvf_vcpu_destroy(CPUState *cpu)
> -{
> -}
> diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
> index 6d3ee4fdb7..b4f7191dd9 100644
> --- a/include/sysemu/hvf.h
> +++ b/include/sysemu/hvf.h
> @@ -23,14 +23,6 @@ extern bool hvf_allowed;
>  #define hvf_get_supported_cpuid(func, idx, reg) 0
>  #endif /* !CONFIG_HVF */
>  
> -int hvf_init_vcpu(CPUState *);
> -int hvf_vcpu_exec(CPUState *);
> -void hvf_cpu_synchronize_state(CPUState *);
> -void hvf_cpu_synchronize_post_reset(CPUState *);
> -void hvf_cpu_synchronize_post_init(CPUState *);
> -void hvf_cpu_synchronize_pre_loadvm(CPUState *);
> -void hvf_vcpu_destroy(CPUState *);
> -
>  #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
>  
>  #define HVF_STATE(obj) \
> diff --git a/target/i386/hvf/hvf-cpus.c b/target/i386/hvf/hvf-cpus.c
> index 9540157f1e..3e5cd75dc9 100644
> --- a/target/i386/hvf/hvf-cpus.c
> +++ b/target/i386/hvf/hvf-cpus.c
> @@ -55,6 +55,7 @@
>  #include "target/i386/cpu.h"
>  #include "qemu/guest-random.h"
>  
> +#include "hvf-int.h"
>  #include "hvf-cpus.h"
>  
>  /*
> diff --git a/target/i386/hvf/hvf-int.h b/target/i386/hvf/hvf-int.h
> new file mode 100644
> index 0000000000..50d108ca08
> --- /dev/null
> +++ b/target/i386/hvf/hvf-int.h


Hmm maybe I could avoid creating a new header file,
and just cram these functions in hvf-cpus.h ?

Any thoughts?

Thanks,

Claudio


> @@ -0,0 +1,24 @@
> +/*
> + * QEMU Hypervisor.framework (HVF) support
> + *
> + * Copyright Google Inc., 2017
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +/* header to be included in HVF-specific internal code */
> +
> +#ifndef HVF_INT_H
> +#define HVF_INT_H
> +
> +int hvf_init_vcpu(CPUState *);
> +int hvf_vcpu_exec(CPUState *);
> +void hvf_cpu_synchronize_state(CPUState *);
> +void hvf_cpu_synchronize_post_reset(CPUState *);
> +void hvf_cpu_synchronize_post_init(CPUState *);
> +void hvf_cpu_synchronize_pre_loadvm(CPUState *);
> +void hvf_vcpu_destroy(CPUState *);
> +
> +#endif /* HVF_INT_H */
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index ed9356565c..728b4695e6 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -72,6 +72,7 @@
>  #include "sysemu/accel.h"
>  #include "target/i386/cpu.h"
>  
> +#include "hvf-int.h"
>  #include "hvf-cpus.h"
>  
>  HVFState *hvf_state;
> diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
> index 5cbcb32ab6..17e0280be0 100644
> --- a/target/i386/hvf/x86hvf.c
> +++ b/target/i386/hvf/x86hvf.c
> @@ -32,6 +32,8 @@
>  #include <Hypervisor/hv.h>
>  #include <Hypervisor/hv_vmx.h>
>  
> +#include "hvf-int.h"
> +
>  void hvf_set_segment(struct CPUState *cpu, struct vmx_segment *vmx_seg,
>                       SegmentCache *qseg, bool is_tr)
>  {
> diff --git a/target/i386/hvf/x86hvf.h b/target/i386/hvf/x86hvf.h
> index 79539f7282..4fabc6d582 100644
> --- a/target/i386/hvf/x86hvf.h
> +++ b/target/i386/hvf/x86hvf.h
> @@ -35,5 +35,4 @@ void hvf_get_msrs(CPUState *cpu_state);
>  void vmx_clear_int_window_exiting(CPUState *cpu);
>  void hvf_get_segments(CPUState *cpu_state);
>  void vmx_update_tpr(CPUState *cpu);
> -void hvf_cpu_synchronize_state(CPUState *cpu_state);
>  #endif
> 


