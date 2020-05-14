Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAFAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:42:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92DAC2065F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuwMJ960"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92DAC2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZJk8-0003Su-Q3
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 15:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZJgC-0007uk-Ch
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:38:04 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46128)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZJgB-0002ZC-8u
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:38:04 -0400
Received: by mail-wr1-x444.google.com with SMTP id w7so78613wre.13
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 12:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uIzpfsaMLCdcTdGvBBe7DnWUlBcHSwIaq6HpGg/y9lU=;
 b=PuwMJ960CnCUqyHQBXydI+Ps405H8vVXUK4HQQgwYcId7zJv+V2yGI35hPjrZD1VrN
 G6d+D8iFrEJSNx5r+/cIuJ8n6yOPq5bg0cwtz/x5/7VF/GP7mv0vegiXlerTYxWzBxDI
 4koyYBKJoSrwL6nkQkrpDD/tmy9Bq+FeIhjtWIR3jGnhJVFFAK0jMqJ1pjj7n1xQakOD
 9zw66jlCoclN5zgYh22+2BjlQp89WKBPSGfH2Pv5C9yDXmOycGhtuke3h8j5Pp7h2DF4
 6FP37DYrLetRZkc3EiSrcZeQoYd5aRVapOd4uQzjegyq6QgRqTzId5gEx5J7dETx/2Sl
 Ca+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uIzpfsaMLCdcTdGvBBe7DnWUlBcHSwIaq6HpGg/y9lU=;
 b=BgrRyq4tQtpwAjfogwq8dXUALDsAZmoj9x2wacpeTooJS4Sr+GC0SZSST2GfJvgMzT
 g0dLyieTG7Wvb6LHsgZibINNIvgW7lZI8QXdy0E3QitOVu6SV4B+8SImeZO5jgF4rJBh
 QB5CcGDxCvVBD25pWa+w9SNEr0Hg5IZWIjBhX9JvQjPaxcJPOzqcc2cMpxY5q3ZmueEX
 uD/lZvv4B8WJmSbpFAejzr0KLFL98c/mGgc+fjXK3836fffSCVevhouPLYDiN2VkqRsy
 xiEGEffP6Au6KpaNcYnMIpZ4luFlF06YFzM1kjerbIqlTI1xX6sCGkq9g8IlqXH9rk1l
 VT/g==
X-Gm-Message-State: AOAM533p5CVipCANotEwqWqMvUPqujKMWvvKcyfesqEE30LlFafZSVJF
 OpTZ6Ny3bgd5PhXf9jltnnRhAZcjZxADcIWHtrY=
X-Google-Smtp-Source: ABdhPJxmUmVP1hJTnKRo5rRG4vhcscYMxlg70la2bPD1e3p0fM5kvXEf3eN+jJyyM8fCBy9cipGTU1btFpGHNqKJmM8=
X-Received: by 2002:a5d:55c5:: with SMTP id i5mr27008wrw.402.1589485079966;
 Thu, 14 May 2020 12:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <1588501221-1205-1-git-send-email-chenhc@lemote.com>
 <1588501221-1205-3-git-send-email-chenhc@lemote.com>
In-Reply-To: <1588501221-1205-3-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 14 May 2020 21:37:46 +0200
Message-ID: <CAHiYmc5b-R50VOd+EnRCxrG=ih=R6C_4203rzpiVwh0Xr5aKsA@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V3 2/7] hw/mips: Implement the kvm_type() hook in
 MachineClass
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x444.google.com
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
 QEMU Developers <qemu-devel@nongnu.org>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BD=D0=B5=D0=B4, 3. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:24 Huacai Chen <z=
ltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:
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

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

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
> @@ -17,11 +17,11 @@ common-obj-$(CONFIG_SOFTMMU) +=3D vm-change-state-han=
dler.o
>  common-obj-$(CONFIG_SOFTMMU) +=3D qdev-properties-system.o
>  common-obj-$(CONFIG_SOFTMMU) +=3D sysbus.o
>  common-obj-$(CONFIG_SOFTMMU) +=3D machine.o
> -common-obj-$(CONFIG_SOFTMMU) +=3D null-machine.o
>  common-obj-$(CONFIG_SOFTMMU) +=3D loader.o
>  common-obj-$(CONFIG_SOFTMMU) +=3D machine-hmp-cmds.o
>  common-obj-$(CONFIG_SOFTMMU) +=3D numa.o
>  common-obj-$(CONFIG_SOFTMMU) +=3D clock-vmstate.o
> +obj-$(CONFIG_SOFTMMU) +=3D null-machine.o
>  obj-$(CONFIG_SOFTMMU) +=3D machine-qmp-cmds.o
>
>  common-obj-$(CONFIG_EMPTY_SLOT) +=3D empty_slot.o
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
>      mc->max_cpus =3D 1;
>      mc->default_ram_size =3D 0;
>      mc->default_ram_id =3D "ram";
> +#ifdef TARGET_MIPS
> +    mc->kvm_type =3D mips_kvm_type;
> +#endif
>  }
>
>  DEFINE_MACHINE("none", machine_none_machine_init)
> diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
> index 525809a..2f7795b 100644
> --- a/hw/mips/Makefile.objs
> +++ b/hw/mips/Makefile.objs
> @@ -1,4 +1,4 @@
> -obj-y +=3D addr.o mips_int.o
> +obj-y +=3D addr.o common.o mips_int.o
>  obj-$(CONFIG_R4K) +=3D mips_r4k.o
>  obj-$(CONFIG_MALTA) +=3D gt64xxx_pci.o mips_malta.o
>  obj-$(CONFIG_MIPSSIM) +=3D mips_mipssim.o
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
> +    KVMState *s =3D KVM_STATE(machine->accelerator);
> +
> +    r =3D kvm_check_extension(s, KVM_CAP_MIPS_VZ);
> +    if (r > 0) {
> +        return KVM_VM_MIPS_VZ;
> +    }
> +
> +    r =3D kvm_check_extension(s, KVM_CAP_MIPS_TE);
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
> @@ -20,4 +20,7 @@ void rc4030_dma_write(void *dma, uint8_t *buf, int len)=
;
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

