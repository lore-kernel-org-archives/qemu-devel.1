Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C5AC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 23:36:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C30620838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 23:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C30620838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=invisible.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47929 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izqgt-0001x5-Fp
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 18:36:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jmcneill@invisible.ca>) id 1izoME-0002aD-OA
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:06:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jmcneill@invisible.ca>) id 1izoMD-0000Bc-3h
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:06:42 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:32807)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jmcneill@invisible.ca>)
 id 1izoMC-0008Nf-Qp
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:06:41 -0500
X-Originating-IP: 159.2.138.7
Received: from performa.invisible.ca
 (stjhnbsu6iw-159-2-138-7.dhcp-dynamic.fibreop.nb.bellaliant.net
 [159.2.138.7]) (Authenticated sender: jmcneill@invisible.ca)
 by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 6049DE0007;
 Thu,  6 Feb 2020 21:06:34 +0000 (UTC)
Date: Thu, 6 Feb 2020 17:06:32 -0400 (AST)
From: Jared McNeill <jmcneill@invisible.ca>
To: Kamil Rytarowski <n54@gmx.com>
Subject: Re: [PATCH v3 1/4] Add the NVMM vcpu API
In-Reply-To: <20200206115731.13552-2-n54@gmx.com>
Message-ID: <alpine.NEB.2.21.2002061706060.671@performa.invisible.ca>
References: <20200128140945.929-1-n54@gmx.com>
 <20200206115731.13552-1-n54@gmx.com> <20200206115731.13552-2-n54@gmx.com>
User-Agent: Alpine 2.21 (NEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1672256239-1581023197=:671"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.70.183.196
X-Mailman-Approved-At: Thu, 06 Feb 2020 18:31:30 -0500
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, slp@redhat.com,
 Kamil Rytarowski <krytarowski@gmail.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, philmd@redhat.com, max@m00nbsd.net, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1672256239-1581023197=:671
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

Tested-by: Jared McNeill <jmcneill@invisible.ca>

On Thu, 6 Feb 2020, Kamil Rytarowski wrote:

> From: Maxime Villard <max@m00nbsd.net>
>
> Adds support for the NetBSD Virtual Machine Monitor (NVMM) stubs and
> introduces the nvmm.h sysemu API for managing the vcpu scheduling and
> management.
>
> Signed-off-by: Maxime Villard <max@m00nbsd.net>
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> Reviewed-by: Sergio Lopez <slp@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> accel/stubs/Makefile.objs |  1 +
> accel/stubs/nvmm-stub.c   | 43 +++++++++++++++++++++++++++++++++++++++
> include/sysemu/nvmm.h     | 35 +++++++++++++++++++++++++++++++
> 3 files changed, 79 insertions(+)
> create mode 100644 accel/stubs/nvmm-stub.c
> create mode 100644 include/sysemu/nvmm.h
>
> diff --git a/accel/stubs/Makefile.objs b/accel/stubs/Makefile.objs
> index 3894caf95d..09f2d3e1dd 100644
> --- a/accel/stubs/Makefile.objs
> +++ b/accel/stubs/Makefile.objs
> @@ -1,5 +1,6 @@
> obj-$(call lnot,$(CONFIG_HAX))  += hax-stub.o
> obj-$(call lnot,$(CONFIG_HVF))  += hvf-stub.o
> obj-$(call lnot,$(CONFIG_WHPX)) += whpx-stub.o
> +obj-$(call lnot,$(CONFIG_NVMM)) += nvmm-stub.o
> obj-$(call lnot,$(CONFIG_KVM))  += kvm-stub.o
> obj-$(call lnot,$(CONFIG_TCG))  += tcg-stub.o
> diff --git a/accel/stubs/nvmm-stub.c b/accel/stubs/nvmm-stub.c
> new file mode 100644
> index 0000000000..c2208b84a3
> --- /dev/null
> +++ b/accel/stubs/nvmm-stub.c
> @@ -0,0 +1,43 @@
> +/*
> + * Copyright (c) 2018-2019 Maxime Villard, All rights reserved.
> + *
> + * NetBSD Virtual Machine Monitor (NVMM) accelerator stub.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "cpu.h"
> +#include "sysemu/nvmm.h"
> +
> +int nvmm_init_vcpu(CPUState *cpu)
> +{
> +    return -1;
> +}
> +
> +int nvmm_vcpu_exec(CPUState *cpu)
> +{
> +    return -1;
> +}
> +
> +void nvmm_destroy_vcpu(CPUState *cpu)
> +{
> +}
> +
> +void nvmm_cpu_synchronize_state(CPUState *cpu)
> +{
> +}
> +
> +void nvmm_cpu_synchronize_post_reset(CPUState *cpu)
> +{
> +}
> +
> +void nvmm_cpu_synchronize_post_init(CPUState *cpu)
> +{
> +}
> +
> +void nvmm_cpu_synchronize_pre_loadvm(CPUState *cpu)
> +{
> +}
> diff --git a/include/sysemu/nvmm.h b/include/sysemu/nvmm.h
> new file mode 100644
> index 0000000000..10496f3980
> --- /dev/null
> +++ b/include/sysemu/nvmm.h
> @@ -0,0 +1,35 @@
> +/*
> + * Copyright (c) 2018-2019 Maxime Villard, All rights reserved.
> + *
> + * NetBSD Virtual Machine Monitor (NVMM) accelerator support.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef QEMU_NVMM_H
> +#define QEMU_NVMM_H
> +
> +#include "config-host.h"
> +#include "qemu-common.h"
> +
> +int nvmm_init_vcpu(CPUState *);
> +int nvmm_vcpu_exec(CPUState *);
> +void nvmm_destroy_vcpu(CPUState *);
> +
> +void nvmm_cpu_synchronize_state(CPUState *);
> +void nvmm_cpu_synchronize_post_reset(CPUState *);
> +void nvmm_cpu_synchronize_post_init(CPUState *);
> +void nvmm_cpu_synchronize_pre_loadvm(CPUState *);
> +
> +#ifdef CONFIG_NVMM
> +
> +int nvmm_enabled(void);
> +
> +#else /* CONFIG_NVMM */
> +
> +#define nvmm_enabled() (0)
> +
> +#endif /* CONFIG_NVMM */
> +
> +#endif /* CONFIG_NVMM */
> --
> 2.25.0
>
>
--0-1672256239-1581023197=:671--

