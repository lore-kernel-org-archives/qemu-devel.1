Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A7FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 09:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5CE206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 09:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4pNFKcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5CE206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfgLv-0005Tj-4Y
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 05:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jfgKK-00030L-IR
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 05:01:50 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:40307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jfgKI-0000Fi-BM
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 05:01:48 -0400
Received: by mail-ed1-x541.google.com with SMTP id p18so6688460eds.7
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 02:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IkslquaLe6ADB7TyKln+DFvg9EeEItb7zuUvVnN6ga4=;
 b=g4pNFKcWr9eWjXcrvNhcsMiEi7nqUhLC5IzERy2VGqAYLa8ameQaMiMtrhuDuTNH3o
 npiQdTkiggQ9jFEKWsAA++B585z/8J260kAnjoG17pkw082AJKcvxLl/sMnHN93e/X2v
 iP3Mrc4TvqfDCEWqQ52M1zqoWDi1SMmeowtrcCbYMmRWO/GOihKUWpmswebHEzF7FyxH
 4HbPADamiXLolu9i2kp+Sy70+OyJ3D2DO/affFISlCJob/DRKJGb24uRL1/Oqn+5QLhR
 blPmqYW2jr1RiDvsu+uliu2WgJ8+XCMxkpOy0nHk3wreo6QfkNhC2fnVmDZk0oT1Mc83
 kztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IkslquaLe6ADB7TyKln+DFvg9EeEItb7zuUvVnN6ga4=;
 b=g31w93NQlJ7ulfpRmoc4hg9YWQU0fsNARC2D9zHwOZqLRSEyrqnwqYzlR5GQwsyxT9
 Z8p4mv1h6t5TskYj5I0ZhSQTFULLUz/1XkoWzoG3rUlwIY+ZoboSmm5nQSpob0Mw/53m
 GkMKQMZEYI+Uw/M1JvakZNguCitQyVCmEgliBUywwxxZOqkcC6idOtEFkD5QrQQboVmd
 37euNAa6LpzH2XJD3A2QYb9tkz2FoK2CL0lXsxRpliuTxQZ24bwcBd9vRpsJX/ARcfBu
 wmbyFkERSScu3WO6XXobbSngnCL+5cSyH8tGDAPnzziL05VepM8gog28lMZLtiKHtyE8
 Xg3w==
X-Gm-Message-State: AOAM533bgLnF8xf0kJN6w2oupr1RH5Tfrr7y1ZIND7Hg6kITCGTiQ5U/
 oOklNSWrLA1qZPFlfRVVR17PHQw/lxtYQcz+mh0=
X-Google-Smtp-Source: ABdhPJxhy0D68T+BQAFihC/0cCgf8S7N7dLTbkn/zjjkmKT6SA34YeilLHUpUjeIV2dQ01vkykXXK8YOgSDN85E8oIs=
X-Received: by 2002:a05:6402:549:: with SMTP id
 i9mr13887839edx.159.1591002104860; 
 Mon, 01 Jun 2020 02:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <1588501221-1205-1-git-send-email-chenhc@lemote.com>
 <1588501221-1205-3-git-send-email-chenhc@lemote.com>
In-Reply-To: <1588501221-1205-3-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 1 Jun 2020 11:01:34 +0200
Message-ID: <CAL1e-=hVq4eSoh8pr5sOykJe9kP0-xjEybwFWPb7m5nWh34RVw@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V3 2/7] hw/mips: Implement the kvm_type() hook in
 MachineClass
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=aleksandar.m.mail@gmail.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 3, 2020 at 12:24 PM Huacai Chen <zltjiangshi@gmail.com> wrote:
>
> MIPS has two types of KVM: TE & VZ, and TE is the default type. Now we
> can't create a VZ guest in QEMU because it lacks the kvm_type() hook in
> MachineClass. Besides, libvirt uses a null-machine to detect the kvm
> capability, so by default it will return "KVM not supported" on a VZ
> platform. Thus, null-machine also need the kvm_type() hook.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---

Applied to MIPS queue.

Best Regards,
Aleksandar

>  hw/core/Makefile.objs  |  2 +-
>  hw/core/null-machine.c |  4 ++++
>  hw/mips/Makefile.objs  |  2 +-
>  hw/mips/common.c       | 31 +++++++++++++++++++++++++++++++
>  include/hw/mips/mips.h |  3 +++
>  5 files changed, 40 insertions(+), 2 deletions(-)
>  create mode 100644 hw/mips/common.c
>
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index 1d540ed..b5672f4 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -17,11 +17,11 @@ common-obj-$(CONFIG_SOFTMMU) += vm-change-state-handler.o
>  common-obj-$(CONFIG_SOFTMMU) += qdev-properties-system.o
>  common-obj-$(CONFIG_SOFTMMU) += sysbus.o
>  common-obj-$(CONFIG_SOFTMMU) += machine.o
> -common-obj-$(CONFIG_SOFTMMU) += null-machine.o
>  common-obj-$(CONFIG_SOFTMMU) += loader.o
>  common-obj-$(CONFIG_SOFTMMU) += machine-hmp-cmds.o
>  common-obj-$(CONFIG_SOFTMMU) += numa.o
>  common-obj-$(CONFIG_SOFTMMU) += clock-vmstate.o
> +obj-$(CONFIG_SOFTMMU) += null-machine.o
>  obj-$(CONFIG_SOFTMMU) += machine-qmp-cmds.o
>
>  common-obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o
> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
> index cb47d9d..94a36f9 100644
> --- a/hw/core/null-machine.c
> +++ b/hw/core/null-machine.c
> @@ -17,6 +17,7 @@
>  #include "sysemu/sysemu.h"
>  #include "exec/address-spaces.h"
>  #include "hw/core/cpu.h"
> +#include "hw/mips/mips.h"
>
>  static void machine_none_init(MachineState *mch)
>  {
> @@ -50,6 +51,9 @@ static void machine_none_machine_init(MachineClass *mc)
>      mc->max_cpus = 1;
>      mc->default_ram_size = 0;
>      mc->default_ram_id = "ram";
> +#ifdef TARGET_MIPS
> +    mc->kvm_type = mips_kvm_type;
> +#endif
>  }
>
>  DEFINE_MACHINE("none", machine_none_machine_init)
> diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
> index 525809a..2f7795b 100644
> --- a/hw/mips/Makefile.objs
> +++ b/hw/mips/Makefile.objs
> @@ -1,4 +1,4 @@
> -obj-y += addr.o mips_int.o
> +obj-y += addr.o common.o mips_int.o
>  obj-$(CONFIG_R4K) += mips_r4k.o
>  obj-$(CONFIG_MALTA) += gt64xxx_pci.o mips_malta.o
>  obj-$(CONFIG_MIPSSIM) += mips_mipssim.o
> diff --git a/hw/mips/common.c b/hw/mips/common.c
> new file mode 100644
> index 0000000..0e33bd0
> --- /dev/null
> +++ b/hw/mips/common.c
> @@ -0,0 +1,31 @@
> +/*
> + * Common MIPS routines
> + *
> + * Copyright (c) 2020 Huacai Chen (chenhc@lemote.com)
> + * This code is licensed under the GNU GPL v2.
> + */
> +
> +#include <linux/kvm.h>
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "hw/boards.h"
> +#include "hw/mips/mips.h"
> +#include "sysemu/kvm_int.h"
> +
> +int mips_kvm_type(MachineState *machine, const char *vm_type)
> +{
> +    int r;
> +    KVMState *s = KVM_STATE(machine->accelerator);
> +
> +    r = kvm_check_extension(s, KVM_CAP_MIPS_VZ);
> +    if (r > 0) {
> +        return KVM_VM_MIPS_VZ;
> +    }
> +
> +    r = kvm_check_extension(s, KVM_CAP_MIPS_TE);
> +    if (r > 0) {
> +        return KVM_VM_MIPS_TE;
> +    }
> +
> +    return -1;
> +}
> diff --git a/include/hw/mips/mips.h b/include/hw/mips/mips.h
> index 0af4c3d..2ac0580 100644
> --- a/include/hw/mips/mips.h
> +++ b/include/hw/mips/mips.h
> @@ -20,4 +20,7 @@ void rc4030_dma_write(void *dma, uint8_t *buf, int len);
>
>  DeviceState *rc4030_init(rc4030_dma **dmas, IOMMUMemoryRegion **dma_mr);
>
> +/* common.c */
> +int mips_kvm_type(MachineState *machine, const char *vm_type);
> +
>  #endif
> --
> 2.7.0
>
>

