Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD1FC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:26:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E23D2085A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E23D2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50952 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQaG6-0006T5-Gi
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 12:26:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQaFI-00065Y-2Q
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQaFC-0003Oz-Sg
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:25:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hQaF9-0002pm-7t
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:25:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so19940505wre.7
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 09:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=8XHAL2JLnOkpZ716PlK89EkbsNpb0w0W8ZqwLqzZDqE=;
	b=l2yrxxXxo35IuJS9WZJ41WLU/mR157z/X1z4kcAlTCkhx1xNMB0GF2r/HqkiQeS4mL
	FTm2JEVW3gxQ3gkZXMTPGv0Cbe1gkcNCz5Xd/4ML+1++EMY9v+PKOWi82MLC1aj9BQC8
	xpsQd08at8fVohzGD0pMIDm/O61FCGDPi8lTd/0Os5/D9Q/oTkeJLWiUcwGXjuWru0OS
	sA7Y+62tG+ngM5ehJnk2e8iCJlb9hJ29DWON5auMwrjsrMft5FFwaY23pfnYPeh3HkGz
	UZ8QERu61nVopTH4tS7ZPkVwyrGdQIe5IpCsnxJr6aljJmOSrRleP93g9D96dF0ZaN3z
	CJRg==
X-Gm-Message-State: APjAAAWgWXe7+LCttnT9V8yOCEAf7ubVUsynDonmS4xj9ABJqu0qJud5
	r5h4Ff6YAhqBFgxTx+B4X/2k9Q==
X-Google-Smtp-Source: APXvYqwYkDHCkEZBnHirHte3a042H8/y+Uka73u915qgUQjsKmKXdTcjJI1T2SvUv2uoLYZRy0Y5/w==
X-Received: by 2002:a5d:4411:: with SMTP id z17mr12482488wrq.168.1557851111805;
	Tue, 14 May 2019 09:25:11 -0700 (PDT)
Received: from [192.168.1.43] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id x22sm4384422wmi.4.2019.05.14.09.25.10
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 09:25:11 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190514155301.16123-1-alex.bennee@linaro.org>
	<20190514155301.16123-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <dfacf0dc-c74c-c508-5191-0f97da9f60b1@redhat.com>
Date: Tue, 14 May 2019 18:25:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514155301.16123-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [RFC PATCH 02/11] semihosting: introduce
 CONFIG_SEMIHOSTING
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Marek Vasut <marex@denx.de>, Aleksandar Rikalo <arikalo@wavecomp.com>,
	Chris Wulff <crwulff@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/19 5:52 PM, Alex Bennée wrote:
> There isn't much point building semihosting for platforms that don't
> support it. Introduce a new symbol and enable it only for the softmmu
> targets that need it.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  default-configs/arm-softmmu.mak         |  1 +
>  default-configs/lm32-softmmu.mak        |  2 +
>  default-configs/m68k-softmmu.mak        |  2 +
>  default-configs/mips-softmmu-common.mak |  1 +
>  default-configs/nios2-softmmu.mak       |  2 +
>  default-configs/xtensa-softmmu.mak      |  2 +
>  hw/Kconfig                              |  1 +
>  hw/semihosting/Kconfig                  |  3 ++
>  hw/semihosting/Makefile.objs            |  2 +-
>  stubs/Makefile.objs                     |  1 +
>  stubs/semihost.c                        | 66 +++++++++++++++++++++++++
>  11 files changed, 82 insertions(+), 1 deletion(-)
>  create mode 100644 hw/semihosting/Kconfig
>  create mode 100644 stubs/semihost.c
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index f23ecfd5c58..1f2e0e7fdeb 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -39,3 +39,4 @@ CONFIG_MICROBIT=y
>  CONFIG_FSL_IMX25=y
>  CONFIG_FSL_IMX7=y
>  CONFIG_FSL_IMX6UL=y
> +CONFIG_SEMIHOSTING=y
> diff --git a/default-configs/lm32-softmmu.mak b/default-configs/lm32-softmmu.mak
> index 6d259665d60..115b3e34c98 100644
> --- a/default-configs/lm32-softmmu.mak
> +++ b/default-configs/lm32-softmmu.mak
> @@ -4,6 +4,8 @@
>  #
>  #CONFIG_MILKYMIST_TMU2=n        # disabling it actually causes compile-time failures
>  
> +CONFIG_SEMIHOSTING=y
> +
>  # Boards:
>  #
>  CONFIG_LM32=y
> diff --git a/default-configs/m68k-softmmu.mak b/default-configs/m68k-softmmu.mak
> index e17495e2a0b..4049a8f2ba9 100644
> --- a/default-configs/m68k-softmmu.mak
> +++ b/default-configs/m68k-softmmu.mak
> @@ -1,5 +1,7 @@
>  # Default configuration for m68k-softmmu
>  
> +CONFIG_SEMIHOSTING=y
> +
>  # Boards:
>  #
>  CONFIG_AN5206=y
> diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
> index 8e54a74b7a5..e10ac4b20c0 100644
> --- a/default-configs/mips-softmmu-common.mak
> +++ b/default-configs/mips-softmmu-common.mak
> @@ -35,6 +35,7 @@ CONFIG_MIPS_CPS=y
>  CONFIG_MIPS_ITU=y
>  CONFIG_R4K=y
>  CONFIG_MALTA=y
> +CONFIG_SEMIHOSTING=y
>  CONFIG_PCNET_PCI=y
>  CONFIG_MIPSSIM=y
>  CONFIG_ACPI_SMBUS=y
> diff --git a/default-configs/nios2-softmmu.mak b/default-configs/nios2-softmmu.mak
> index e130d024e62..1bc4082ea99 100644
> --- a/default-configs/nios2-softmmu.mak
> +++ b/default-configs/nios2-softmmu.mak
> @@ -1,5 +1,7 @@
>  # Default configuration for nios2-softmmu
>  
> +CONFIG_SEMIHOSTING=y
> +
>  # Boards:
>  #
>  CONFIG_NIOS2_10M50=y
> diff --git a/default-configs/xtensa-softmmu.mak b/default-configs/xtensa-softmmu.mak
> index 7e4d1cc0979..3aa20a47a7f 100644
> --- a/default-configs/xtensa-softmmu.mak
> +++ b/default-configs/xtensa-softmmu.mak
> @@ -1,5 +1,7 @@
>  # Default configuration for Xtensa
>  
> +CONFIG_SEMIHOSTING=y
> +
>  # Boards:
>  #
>  CONFIG_XTENSA_SIM=y
> diff --git a/hw/Kconfig b/hw/Kconfig
> index 88b9f150070..195f541e50c 100644
> --- a/hw/Kconfig
> +++ b/hw/Kconfig
> @@ -29,6 +29,7 @@ source pci/Kconfig
>  source rdma/Kconfig
>  source scsi/Kconfig
>  source sd/Kconfig
> +source semihosting/Kconfig
>  source smbios/Kconfig
>  source ssi/Kconfig
>  source timer/Kconfig
> diff --git a/hw/semihosting/Kconfig b/hw/semihosting/Kconfig
> new file mode 100644
> index 00000000000..efe0a30734c
> --- /dev/null
> +++ b/hw/semihosting/Kconfig
> @@ -0,0 +1,3 @@
> +
> +config SEMIHOSTING
> +       bool
> diff --git a/hw/semihosting/Makefile.objs b/hw/semihosting/Makefile.objs
> index 546954f4ff4..09c19bf19ed 100644
> --- a/hw/semihosting/Makefile.objs
> +++ b/hw/semihosting/Makefile.objs
> @@ -1 +1 @@
> -common-obj-$(CONFIG_SOFTMMU) += config.o
> +obj-$(CONFIG_SEMIHOSTING) += config.o
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 269dfa58326..e0d4f11b348 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -39,3 +39,4 @@ stub-obj-y += xen-hvm.o
>  stub-obj-y += pci-host-piix.o
>  stub-obj-y += ram-block.o
>  stub-obj-y += ramfb.o
> +stub-obj-$(CONFIG_SOFTMMU) += semihost.o
> diff --git a/stubs/semihost.c b/stubs/semihost.c
> new file mode 100644
> index 00000000000..1a4e88e5326
> --- /dev/null
> +++ b/stubs/semihost.c
> @@ -0,0 +1,66 @@
> +/*
> + * Semihosting Stubs for SoftMMU
> + *
> + * Copyright (c) 2019 Linaro Ltd
> + *
> + * Stubs for SoftMMU targets that don't actually do semihosting.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/option.h"
> +#include "qemu/error-report.h"
> +#include "hw/semihosting/semihost.h"
> +
> +/* Empty config */
> +QemuOptsList qemu_semihosting_config_opts = {
> +    .name = "",
> +    .head = QTAILQ_HEAD_INITIALIZER(qemu_semihosting_config_opts.head),
> +    .desc = {
> +        { /* end of list */ }
> +    },
> +};
> +
> +/* Queries to config status default to off */
> +bool semihosting_enabled(void)
> +{
> +    return false;
> +}
> +
> +SemihostingTarget semihosting_get_target(void)
> +{
> +    return SEMIHOSTING_TARGET_AUTO;
> +}
> +
> +/*
> + * All the rest are empty subs. We could g_assert_not_reached() but
> + * that adds extra weight to the final binary. Waste not want not.
> + */
> +void qemu_semihosting_enable(void)
> +{
> +}
> +
> +int qemu_semihosting_config_options(const char *optarg)
> +{
> +    return 1;
> +}
> +
> +const char *semihosting_get_arg(int i)
> +{
> +    return NULL;
> +}
> +
> +int semihosting_get_argc(void)
> +{
> +    return 0;
> +}
> +
> +const char *semihosting_get_cmdline(void)
> +{
> +    return NULL;
> +}
> +
> +void semihosting_arg_fallback(const char *file, const char *cmd)
> +{
> +}
> 

