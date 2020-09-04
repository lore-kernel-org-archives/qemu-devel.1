Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DFDC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 23:33:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 893362078E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 23:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893362078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netbsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kELDN-0000Pu-5T
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 19:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@netbsd.org>) id 1kELAb-0008GQ-BQ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 19:31:01 -0400
Received: from mail.netbsd.org ([2001:470:a085:999::25]:59546)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@netbsd.org>) id 1kELAY-00069F-W8
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 19:31:00 -0400
Received: from [IPv6:::1] (localhost [127.0.0.1])
 by mail.netbsd.org (Postfix) with ESMTP id 17C8884D24;
 Fri,  4 Sep 2020 23:30:51 +0000 (UTC)
Subject: Re: [PATCH v5 1/4] Add the NVMM vcpu API
To: rth@twiddle.net, ehabkost@redhat.com, slp@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, philmd@redhat.com,
 max@m00nbsd.net, jmcneill@invisible.ca
References: <20200206213232.1918-2-n54@gmx.com>
 <20200811130153.4948-1-n54@gmx.com>
From: Kamil Rytarowski <kamil@netbsd.org>
Autocrypt: addr=kamil@netbsd.org; keydata=
 mQINBFVwUF8BEADHmOg7PFLIcSDdMx5HNDYr8MY2ExGfUTrKwPndbt3peaa5lHsK+UGoPG48
 KiWkhEaMmjaXHFa7XgVpJHhFmNoJXfPgjI/sOKTMCPQ5DEHEHTibC4mta7IBAk+rmnaOF0k8
 bxHfP8Qbls66wvicrAfTRXn/1ReeNc3NP4Sq39PoVHkfQTlnQiD4eAqBdq61B7DhzjhbKAZ4
 RsNtLfB6eOv9qvmblUzs50ChYewM9hvn+c7MdDH+x2UXoSDhkBDkKcJGkX91evos8s9AuoEd
 D32X5e+bmdUGe8Cr3cAZJ8IEXR6F9828/kxzPliMsCWVRx1Fr28baCJOUGgFPNr3ips78m9+
 Iw8PdQ101jU0dvucDFxw/1SCGYEZzV+O/237oRPuLCiDX5nhQoxf6dn9ukQleLBMNy2BLI4H
 g342NhF21HLA+KlyLOHaMKQCKzlal+zVNZTRTCh/ikMhsxWQjBfnqTDbMj85DnWwtump27SI
 qhPjUnS0a6MKoS/A+hbi64k5zztkvloELfCSrX7NyBTT0jgF2IGFIxZMrKCtQ9StcGMCV9MX
 tjcBy6fj7QMontEaIDRJEMjg8UIGw1B687OhalOv1ISia4xOWvpYAM6ipgqh6tBQmFzasL9P
 h1RtcVdFpFbhwVlr1Bly8c25gBNQHL5GUjLMn45LlQz50OzrkwARAQABtCNLYW1pbCBSeXRh
 cm93c2tpIDxrYW1pbEBOZXRCU0Qub3JnPokCOQQTAQgAIwUCVbKF6wIbIwcLCQgHAwIBBhUI
 AgkKCwQWAgMBAh4BAheAAAoJEEuzCOmwLnZsrgwQAMdXTXDWkxtUciFgBnioE6hvZYOBV7Xa
 Gh3dwgVvS5rLwwq5ob1R9qdtCGMYxdaCAQCzo2hhUfe9ts11/Q4Pg0aDAb5CfdVVTmyvLMu+
 gtK99t/sG4SfCdn8Bb8rCfRRDpkTq1cAGy6pp7rxyMrFBITTbdBWVcWdEdlMhEZtV8Z1BNDI
 kwEwZkYnM1UxOGW4rJNjNU+hBjNAscCTwBSbpG6NV1oBbgmgJ1PfaPCeAmGTLZyI57VLuFJy
 kR0Jlj8Ui7dAaJgO1WYdmvL+48s0N2QGEoHnrf50xoO34LlrIBUsCLmhtjWhZiuj0meCxNTr
 5YpdBP13b2i64OCruH8/M4IO85GAIWxIMMv510rge9qSe38NHCzSmn9zcjFwVXIh9flZi7PK
 eqOP3yah6r1ZIBY68If/2FtvwDptUi1NHoSpN+dt0kRg26hDqMFOg+Jc6o7Wtm+3vFNDhU4I
 8HkjDr62VlbHBxe6gDgVELcecWgXOydKgdrQhOPwCBJkPJigifsIz4EZQnyI3CchFja3qR9J
 Vo4iXwqAi6xN4RD0PS775JYDh56qUaaUsEctQ/D6Xm7Bbdv1VPlsYs/9uXxc/jWVhkd1sDn2
 KZ3kv7uo04DoejVGWK9B4XEZ1ufRPzmlV0SYohX34ouLBq5Q6wbyw6+hUM+yM9RcvgkOCVgB
 laejuQINBFVwUF8BEAC61vNvzAAcYvkU89YoStDcGyun1ENNWpHOnuQEw613/Xgys6xZbKKa
 Xhee8Fiwm6FlaiYWh66Vw5cA+hMna9PDp6tZi106JnKZ9DcYxanHOCQ5V42OwUX0BDfwUIwq
 YgOz12Cf4pdIheVkDfiSEot3XrdI3lT8od9iWeehx5zfW77utVrWGUXkMFJKmiKzxyzjV+gF
 gLk2wH+L7KoYiV/MfLukLa7mTJAK4mi0sfjLStPlf5gELvPtyooKG0gs0MbDSG2qmzb1/A4Y
 ET8Vaa7wJulIePym+Du5TJBwptls0KEF9a04kp2Oc2zlUd/Z5z3lLBiZaXpfProbz3Ydjg4O
 2+XTn+SHSq10l3agjiAkGwHH83Xnzn/clg3iTvwYgdOcwvfEnJ1FGz3DAzcBd/+IMaszJjuo
 dBVckt07mc97sseDjy+vIIyQGdMzDmI0U9UK7nDUFpnIfG5LYe+myBS1CgFrZAQ/WNg0j7aq
 CiIgbhVAOFi2sPRYlph2L8LZRUPFHLTt23vdJXdFDuKM6JSvPiDf914UpjXr/WSwT43lJzlO
 O3zgKGM7eclFsetDF3p0I4SVHvR7dHbIC5IHibssmk7bQgH0K1aGUX/QC18v3VY7wYYaotYH
 RnTiGbBGz+XxPhZYiXKQuyFu6dY3qOw/VjbsV6KVNn49z2Zg4RQV8QARAQABiQIfBBgBCAAJ
 BQJVcFBfAhsMAAoJEEuzCOmwLnZs9rIP/2MTyZ0252u51LFsMHa9/ylTyvl+UKq8iR852lkZ
 X9bH9nH4cUcen5vZo0EZI3IVOemHUq71u+DTq8PSj5vtJ0DW+sGBEbjW3Q4IjJ+96PPrlemK
 fYS0KWVwEzzNQLEejjduU43x83DvQ/URzSWgGnhMBqXUyJdsHyTFFNFwQ9U71gX00+wXHJyh
 aXRlK+7gRKtCWuNFtW/5bQXL9epxDAS0POIVAdBc1FtPLwg08Pj0KwHsGQpEr5/W8ybDtLF+
 zISHIKCj1lZ8dv/7D1PmH5SEXzsv+bbzvPtb6zhoIA8HONshaG2eAYknAiCJZ0gj0npgktwc
 u9VkvDvHMD9+VyNzRV/M6Ak4nDeEG6QecTPv8IqCcAHDI27nY/49BvFVOJOMwqbTp5Xvfa71
 ksP1mARrN+bIYMfOy7OhfCxGeZydvBhgCLKdL698aXmgy0xrmrOw+GXO69GVcebOvxWMXxz1
 FOG/JnLIe1ZgCo2YF5wy8zTCGKCMx6gAwnku2nJmDGNsePVedV00FmB8mQ7Oxz+3B9+LtFim
 FHHR33PlRnViXlG+XTm9NontiGE0LvG4TzIY5CYNSw8PBao795dQMSsmMI4FHlvTIgupE9g1
 PQWP+2H2C0RtnLUanRNUGRkze1+MNG7jc+fqJIo5s7+PSs26rUvA38QzEOJ95k7hdJty
Message-ID: <81b20849-20c7-00d6-08fd-6b6cfe3fd190@netbsd.org>
Date: Sat, 5 Sep 2020 01:28:04 +0200
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200811130153.4948-1-n54@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:470:a085:999::25;
 envelope-from=kamil@netbsd.org; helo=mail.netbsd.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping?

On 11.08.2020 15:01, Kamil Rytarowski wrote:
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
> Tested-by: Jared McNeill <jmcneill@invisible.ca>
> ---
>  accel/stubs/Makefile.objs |  1 +
>  accel/stubs/nvmm-stub.c   | 43 +++++++++++++++++++++++++++++++++++++++
>  include/sysemu/nvmm.h     | 35 +++++++++++++++++++++++++++++++
>  3 files changed, 79 insertions(+)
>  create mode 100644 accel/stubs/nvmm-stub.c
>  create mode 100644 include/sysemu/nvmm.h
> 
> diff --git a/accel/stubs/Makefile.objs b/accel/stubs/Makefile.objs
> index bbd14e71fb..38660a0b9b 100644
> --- a/accel/stubs/Makefile.objs
> +++ b/accel/stubs/Makefile.objs
> @@ -1,6 +1,7 @@
>  obj-$(call lnot,$(CONFIG_HAX))  += hax-stub.o
>  obj-$(call lnot,$(CONFIG_HVF))  += hvf-stub.o
>  obj-$(call lnot,$(CONFIG_WHPX)) += whpx-stub.o
> +obj-$(call lnot,$(CONFIG_NVMM)) += nvmm-stub.o
>  obj-$(call lnot,$(CONFIG_KVM))  += kvm-stub.o
>  obj-$(call lnot,$(CONFIG_TCG))  += tcg-stub.o
>  obj-$(call lnot,$(CONFIG_XEN))  += xen-stub.o
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
> 2.28.0
> 


