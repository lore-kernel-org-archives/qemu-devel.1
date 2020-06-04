Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDD5C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 10:05:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C80E5206DC
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 10:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zr1A5edB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80E5206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgmkn-0001kd-4A
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 06:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jgmkC-0001KP-Et
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 06:05:04 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55071)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jgmkB-0000p1-Az
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 06:05:04 -0400
Received: by mail-wm1-x342.google.com with SMTP id g10so4628337wmh.4
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 03:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NG8i3yuNACdh2YQJFJ7masm1x9oXpYP3QjaNcQd7TmQ=;
 b=Zr1A5edBxl9LsRT4osumqQrGZm2RcLDOXrp8asjA2Qc32scM7IcNQ5Sc1g9/4sjEZa
 6zx5KG8HcOnxH03JvlPd/LxaexuuAlCKGVM1UmG3YzRZ+A/AIrKfdFckxTWK2rHXKsVo
 Z2PW0h2jlW5Ra78Pn1fsuFX0VwxWsjPMQnjE1YCzK2XLQaEbhtVhRbhCg5ZsRzLIRCJh
 eI1um+VSAbZZyB619Jlxn4VpGwRxN/YroP3yK72ungFO6IKh8kJ8UyXtY1RtpqyrqyB8
 5LSuLzvN5qPZa+W/nxfOiIZXeAzXFGLP9m2ZFoZCBbyCGveJvqbwM6eubV4gELYMpQYC
 Abkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NG8i3yuNACdh2YQJFJ7masm1x9oXpYP3QjaNcQd7TmQ=;
 b=cJpjRMeVK+ActHlQR+sC6a3N5ilC2GbMFNdndSiJOP7+JaOfxtVQAxyEQJNvIWdpHJ
 aDBZ7MMQ/2HiWvb9TRU/BuSUfms14XA6iD3xu9Zx4zxxp//rAQJSuvM8UrGwtByjdbj0
 0/87rOBAFcK+IIIt3s7BTcM68LCEbRaqg9mQ4NqFV4d9b7XKatcKJVGe3AJxPTLQMPnY
 QsOx1ZpmTLSVVkuNDGLW5DsKbpVsZsM8bVkgGsRCDJD49ODtoaQPEG/fic7P0TpL78n5
 3+jEF9gC1+zzJpnwuoARFwN4kDieGk4OyFAJlNlDXHmeYk5WWEUfngmFQoysBrqTay25
 R/lg==
X-Gm-Message-State: AOAM531yKq89yUR7k/GUVbd8XYuK+UCgvkMhQvRGXjhmUrL85JvWTmJ4
 tzMr3ZFn4D62Jwb+giuwfkxYseHljXqKZxSMj8o=
X-Google-Smtp-Source: ABdhPJw2WK20ZbaPzTg/eQfHcuUvbsFRcZDttI3BzoHHZeTJJ2jPMHjFhxrTnQDvUQCgjyBHvf9I0VDgFtIlPvtUMAU=
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr3540855wmb.168.1591265101766; 
 Thu, 04 Jun 2020 03:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <1591065557-9174-1-git-send-email-chenhc@lemote.com>
 <1591065557-9174-2-git-send-email-chenhc@lemote.com>
 <CAHiYmc7_yKHR4XMNyzYbERe7cqhyBYRt-sRwf=wtLuT=QoyRZA@mail.gmail.com>
 <CAAhV-H4==t7_QRopu8=HkPbceF4GCx5RrdcW7nw88B6kExA4sA@mail.gmail.com>
In-Reply-To: <CAAhV-H4==t7_QRopu8=HkPbceF4GCx5RrdcW7nw88B6kExA4sA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 4 Jun 2020 12:04:45 +0200
Message-ID: <CAHiYmc5bg-XN3p4f-41WeWebd276+zNAQ8Cp2FdUkCmRQY-=mw@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V4 1/4] hw/mips: Implement the kvm_type() hook in
 MachineClass
To: Huacai Chen <chenhuacai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=87=D0=B5=D1=82, 4. =D1=98=D1=83=D0=BD 2020. =D1=83 02:57 Huacai Chen <c=
henhuacai@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:
>
> Hi, Alexandar,
>
> On Wed, Jun 3, 2020 at 10:34 PM Aleksandar Markovic
> <aleksandar.qemu.devel@gmail.com> wrote:
> >
> >
> >
> > =D1=83=D1=82=D0=BE, 2. =D1=98=D1=83=D0=BD 2020. =D1=83 04:38 Huacai Che=
n <zltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=BE/=D0=BB=D0=B0:
> >>
> >> MIPS has two types of KVM: TE & VZ, and TE is the default type. Now we
> >> can't create a VZ guest in QEMU because it lacks the kvm_type() hook i=
n
> >> MachineClass. Besides, libvirt uses a null-machine to detect the kvm
> >> capability, so by default it will return "KVM not supported" on a VZ
> >> platform. Thus, null-machine also need the kvm_type() hook.
> >>
> >> Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> >> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> >> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >> ---
> >
> >
> >
> > Hi, Huacai,
> >
> > For MIPS parts of QEMU, we prefer the following licence preamble:
> >
> >  *  This program is free software: you can redistribute it and/or modif=
y
> >  *  it under the terms of the GNU General Public License as published b=
y
> >  *  the Free Software Foundation, either version 2 of the License, or
> >  *  (at your option) any later version.
> >  *
> >  *  This program is distributed in the hope that it will be useful,
> >  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> >  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >  *  GNU General Public License for more details.
> >  *
> >  *  You should have received a copy of the GNU General Public License
> >  *  along with this program.  If not, see <https://www.gnu.org/licenses=
/>.
> >
> > Do you agree with such preamble in hw/mips/common.c?
> Yes, I agree.
>

Thank you!

No further action is needed from your side, I can change the preamble
while applying to mips queue.

Aleksandar
> >
> > (of course you name and email will stay intact)
> >
> > Regards,
> > Aleksandar
> >
> >>  hw/core/Makefile.objs  |  2 +-
> >>  hw/core/null-machine.c |  4 ++++
> >>  hw/mips/Makefile.objs  |  2 +-
> >>  hw/mips/common.c       | 42 +++++++++++++++++++++++++++++++++++++++++=
+
> >>  include/hw/mips/mips.h |  3 +++
> >>  5 files changed, 51 insertions(+), 2 deletions(-)
> >>  create mode 100644 hw/mips/common.c
> >>
> >> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> >> index 1d540ed..b5672f4 100644
> >> --- a/hw/core/Makefile.objs
> >> +++ b/hw/core/Makefile.objs
> >> @@ -17,11 +17,11 @@ common-obj-$(CONFIG_SOFTMMU) +=3D vm-change-state-=
handler.o
> >>  common-obj-$(CONFIG_SOFTMMU) +=3D qdev-properties-system.o
> >>  common-obj-$(CONFIG_SOFTMMU) +=3D sysbus.o
> >>  common-obj-$(CONFIG_SOFTMMU) +=3D machine.o
> >> -common-obj-$(CONFIG_SOFTMMU) +=3D null-machine.o
> >>  common-obj-$(CONFIG_SOFTMMU) +=3D loader.o
> >>  common-obj-$(CONFIG_SOFTMMU) +=3D machine-hmp-cmds.o
> >>  common-obj-$(CONFIG_SOFTMMU) +=3D numa.o
> >>  common-obj-$(CONFIG_SOFTMMU) +=3D clock-vmstate.o
> >> +obj-$(CONFIG_SOFTMMU) +=3D null-machine.o
> >>  obj-$(CONFIG_SOFTMMU) +=3D machine-qmp-cmds.o
> >>
> >>  common-obj-$(CONFIG_EMPTY_SLOT) +=3D empty_slot.o
> >> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
> >> index cb47d9d..94a36f9 100644
> >> --- a/hw/core/null-machine.c
> >> +++ b/hw/core/null-machine.c
> >> @@ -17,6 +17,7 @@
> >>  #include "sysemu/sysemu.h"
> >>  #include "exec/address-spaces.h"
> >>  #include "hw/core/cpu.h"
> >> +#include "hw/mips/mips.h"
> >>
> >>  static void machine_none_init(MachineState *mch)
> >>  {
> >> @@ -50,6 +51,9 @@ static void machine_none_machine_init(MachineClass *=
mc)
> >>      mc->max_cpus =3D 1;
> >>      mc->default_ram_size =3D 0;
> >>      mc->default_ram_id =3D "ram";
> >> +#ifdef TARGET_MIPS
> >> +    mc->kvm_type =3D mips_kvm_type;
> >> +#endif
> >>  }
> >>
> >>  DEFINE_MACHINE("none", machine_none_machine_init)
> >> diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
> >> index 739e2b7..3b3e6ea 100644
> >> --- a/hw/mips/Makefile.objs
> >> +++ b/hw/mips/Makefile.objs
> >> @@ -1,4 +1,4 @@
> >> -obj-y +=3D addr.o mips_int.o
> >> +obj-y +=3D addr.o common.o mips_int.o
> >>  obj-$(CONFIG_R4K) +=3D r4k.o
> >>  obj-$(CONFIG_MALTA) +=3D gt64xxx_pci.o malta.o
> >>  obj-$(CONFIG_MIPSSIM) +=3D mipssim.o
> >> diff --git a/hw/mips/common.c b/hw/mips/common.c
> >> new file mode 100644
> >> index 0000000..4d8e141
> >> --- /dev/null
> >> +++ b/hw/mips/common.c
> >> @@ -0,0 +1,42 @@
> >> +/*
> >> + * Common MIPS routines
> >> + *
> >> + * Copyright (c) 2020 Huacai Chen (chenhc@lemote.com)
> >> + * This code is licensed under the GNU GPL v2.
> >> + */
> >> +
> >> +#include <linux/kvm.h>
> >> +#include "qemu/osdep.h"
> >> +#include "qemu-common.h"
> >> +#include "hw/boards.h"
> >> +#include "hw/mips/mips.h"
> >> +#include "sysemu/kvm_int.h"
> >> +
> >> +#ifndef CONFIG_KVM
> >> +
> >> +int mips_kvm_type(MachineState *machine, const char *vm_type)
> >> +{
> >> +    return 0;
> >> +}
> >> +
> >> +#else
> >> +
> >> +int mips_kvm_type(MachineState *machine, const char *vm_type)
> >> +{
> >> +    int r;
> >> +    KVMState *s =3D KVM_STATE(machine->accelerator);
> >> +
> >> +    r =3D kvm_check_extension(s, KVM_CAP_MIPS_VZ);
> >> +    if (r > 0) {
> >> +        return KVM_VM_MIPS_VZ;
> >> +    }
> >> +
> >> +    r =3D kvm_check_extension(s, KVM_CAP_MIPS_TE);
> >> +    if (r > 0) {
> >> +        return KVM_VM_MIPS_TE;
> >> +    }
> >> +
> >> +    return -1;
> >> +}
> >> +
> >> +#endif
> >> diff --git a/include/hw/mips/mips.h b/include/hw/mips/mips.h
> >> index 0af4c3d..2ac0580 100644
> >> --- a/include/hw/mips/mips.h
> >> +++ b/include/hw/mips/mips.h
> >> @@ -20,4 +20,7 @@ void rc4030_dma_write(void *dma, uint8_t *buf, int l=
en);
> >>
> >>  DeviceState *rc4030_init(rc4030_dma **dmas, IOMMUMemoryRegion **dma_m=
r);
> >>
> >> +/* common.c */
> >> +int mips_kvm_type(MachineState *machine, const char *vm_type);
> >> +
> >>  #endif
> >> --
> >> 2.7.0
> >>

