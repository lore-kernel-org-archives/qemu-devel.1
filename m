Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5221C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7939320678
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffh3jVFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7939320678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgUUK-0006ek-E0
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 10:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jgUTO-0005ko-7q
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:34:30 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41937)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jgUTM-0004rH-FV
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:34:29 -0400
Received: by mail-wr1-x444.google.com with SMTP id j10so2617122wrw.8
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 07:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iEk/VCyMATr9VzdvnTLjbD4xHhfC2aR23vezvXZc7ME=;
 b=ffh3jVFeUP59EO1K0IkQdkDeDF1F2S9PwVtM0Ct/8WWzLz/n9g5Potww96gLepnVRf
 O64yvjXHel7O3V47S0YoZ0wDEjE5LAD2Is8s2dnWYQi0UWK44wxigmkxWY5EVSO/m6ID
 1I9sTOyR1VafDvvN99GdS/fUAVYdH610K/yhjXzVDWg0pbb6AvkvXwTgYfsc1geJy5jN
 gx2NZf3qO/mcxppz+zr+2VtbwlPszGYdie31edZvtp4c4CEpjTt55aeQ7PF1Seg2PJ6n
 xH68ffmwk7Rn8jjJ49WeUcgwQTylepkIOHESMT41Yj8lUWzSLy8bBzmCcls9YhBqg068
 1NIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iEk/VCyMATr9VzdvnTLjbD4xHhfC2aR23vezvXZc7ME=;
 b=IwDc4BQXh5GIt/p2k1uOdsL6vUi/Rmu9xGgI0LhboNHnRgrd9m+Jh6p/HBiXXgfb3V
 DLSzux8d+9CZPabtP4pJSjQNptnTzafTmQHviRC+s7seAa03Z7JM8oMacs/8/AqtZABV
 wQZVsUn7z5bZe6zApQXs78L2sPQ8sRhtxcEXIvhdiyyIa/uRsxkveZmiyTZn2911HNnx
 G+QbAX3yZ1sHV8Z4EZLg/+pbmNaIIsJQKlJj+2oZGsfnJlRoZZUwrJ+OgaPjZJD/9OIK
 BDhfgeNs591Pizeewg8K7HPhh09ajQzlhGBJHI14hKZNKdy98pYKqNV0+vPox9zcDoiB
 Egjw==
X-Gm-Message-State: AOAM532RFi/Q33DtA7b+EFQYpMxt7lz3D1vLDEwTMDuT3xupImGdQgNh
 Q4QbIL9HFHn3OoIWY4zWoChGWYNovngGnQ0nX78=
X-Google-Smtp-Source: ABdhPJy5SaIjWNiWO+NqHFeLml1pf6gCNuMSxqdSCQ0RQrkUxe3gC8XHztEpEOr2JxPMoi5JrYI32xmf8Vu4FRID0J8=
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr27755619wrv.162.1591194865176; 
 Wed, 03 Jun 2020 07:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <1591065557-9174-1-git-send-email-chenhc@lemote.com>
 <1591065557-9174-2-git-send-email-chenhc@lemote.com>
In-Reply-To: <1591065557-9174-2-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 3 Jun 2020 16:34:09 +0200
Message-ID: <CAHiYmc7_yKHR4XMNyzYbERe7cqhyBYRt-sRwf=wtLuT=QoyRZA@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V4 1/4] hw/mips: Implement the kvm_type() hook in
 MachineClass
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000b512dd05a72eec71"
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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

--000000000000b512dd05a72eec71
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=83=D1=82=D0=BE, 2. =D1=98=D1=83=D0=BD 2020. =D1=83 04:38 Huacai Chen <z=
ltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:

> MIPS has two types of KVM: TE & VZ, and TE is the default type. Now we
> can't create a VZ guest in QEMU because it lacks the kvm_type() hook in
> MachineClass. Besides, libvirt uses a null-machine to detect the kvm
> capability, so by default it will return "KVM not supported" on a VZ
> platform. Thus, null-machine also need the kvm_type() hook.
>
> Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>


Hi, Huacai,

For MIPS parts of QEMU, we prefer the following licence preamble:

 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <https://www.gnu.org/licenses/>.

Do you agree with such preamble in hw/mips/common.c?

(of course you name and email will stay intact)

Regards,
Aleksandar

 hw/core/Makefile.objs  |  2 +-
>  hw/core/null-machine.c |  4 ++++
>  hw/mips/Makefile.objs  |  2 +-
>  hw/mips/common.c       | 42 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/mips/mips.h |  3 +++
>  5 files changed, 51 insertions(+), 2 deletions(-)
>  create mode 100644 hw/mips/common.c
>
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index 1d540ed..b5672f4 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -17,11 +17,11 @@ common-obj-$(CONFIG_SOFTMMU) +=3D
> vm-change-state-handler.o
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
> index 739e2b7..3b3e6ea 100644
> --- a/hw/mips/Makefile.objs
> +++ b/hw/mips/Makefile.objs
> @@ -1,4 +1,4 @@
> -obj-y +=3D addr.o mips_int.o
> +obj-y +=3D addr.o common.o mips_int.o
>  obj-$(CONFIG_R4K) +=3D r4k.o
>  obj-$(CONFIG_MALTA) +=3D gt64xxx_pci.o malta.o
>  obj-$(CONFIG_MIPSSIM) +=3D mipssim.o
> diff --git a/hw/mips/common.c b/hw/mips/common.c
> new file mode 100644
> index 0000000..4d8e141
> --- /dev/null
> +++ b/hw/mips/common.c
> @@ -0,0 +1,42 @@
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
> +#ifndef CONFIG_KVM
> +
> +int mips_kvm_type(MachineState *machine, const char *vm_type)
> +{
> +    return 0;
> +}
> +
> +#else
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
> +
> +#endif
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
>

--000000000000b512dd05a72eec71
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">=D1=83=D1=82=D0=BE, 2. =D1=98=D1=83=
=D0=BD 2020. =D1=83 04:38 Huacai Chen &lt;<a href=3D"mailto:zltjiangshi@gma=
il.com">zltjiangshi@gmail.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">MIPS has two types of KVM: TE &amp; VZ, and TE is the defa=
ult type. Now we<br>
can&#39;t create a VZ guest in QEMU because it lacks the kvm_type() hook in=
<br>
MachineClass. Besides, libvirt uses a null-machine to detect the kvm<br>
capability, so by default it will return &quot;KVM not supported&quot; on a=
 VZ<br>
platform. Thus, null-machine also need the kvm_type() hook.<br>
<br>
Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.deve=
l@gmail.com" target=3D"_blank">aleksandar.qemu.devel@gmail.com</a>&gt;<br>
Signed-off-by: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com" target=
=3D"_blank">chenhc@lemote.com</a>&gt;<br>
Co-developed-by: Jiaxun Yang &lt;<a href=3D"mailto:jiaxun.yang@flygoat.com"=
 target=3D"_blank">jiaxun.yang@flygoat.com</a>&gt;<br>
---<br></blockquote><div><br></div><div><br></div><div>Hi, Huacai,</div><di=
v><br></div><div>For MIPS parts of QEMU, we prefer the following licence pr=
eamble:</div><div><br></div><div>=C2=A0* =C2=A0This program is free softwar=
e: you can redistribute it and/or modify<br>=C2=A0* =C2=A0it under the term=
s of the GNU General Public License as published by<br>=C2=A0* =C2=A0the Fr=
ee Software Foundation, either version 2 of the License, or<br>=C2=A0* =C2=
=A0(at your option) any later version.<br>=C2=A0*<br>=C2=A0* =C2=A0This pro=
gram is distributed in the hope that it will be useful,<br>=C2=A0* =C2=A0bu=
t WITHOUT ANY WARRANTY; without even the implied warranty of<br>=C2=A0* =C2=
=A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the<br>=
=C2=A0* =C2=A0GNU General Public License for more details.<br>=C2=A0*<br>=
=C2=A0* =C2=A0You should have received a copy of the GNU General Public Lic=
ense<br>=C2=A0* =C2=A0along with this program.=C2=A0 If not, see &lt;<a hre=
f=3D"https://www.gnu.org/licenses/">https://www.gnu.org/licenses/</a>&gt;.<=
/div><div><br></div><div>Do you agree with such preamble in hw/mips/common.=
c?</div><div><br></div><div>(of course you name and email will stay intact)=
</div><div><br></div><div>Regards,</div><div>Aleksandar<br></div><div> <br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0hw/core/Makefile.objs=C2=A0 |=C2=A0 2 +-<br>
=C2=A0hw/core/null-machine.c |=C2=A0 4 ++++<br>
=C2=A0hw/mips/Makefile.objs=C2=A0 |=C2=A0 2 +-<br>
=C2=A0hw/mips/common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 42 +++++++++++++++++++++=
+++++++++++++++++++++<br>
=C2=A0include/hw/mips/mips.h |=C2=A0 3 +++<br>
=C2=A05 files changed, 51 insertions(+), 2 deletions(-)<br>
=C2=A0create mode 100644 hw/mips/common.c<br>
<br>
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs<br>
index 1d540ed..b5672f4 100644<br>
--- a/hw/core/Makefile.objs<br>
+++ b/hw/core/Makefile.objs<br>
@@ -17,11 +17,11 @@ common-obj-$(CONFIG_SOFTMMU) +=3D vm-change-state-handl=
er.o<br>
=C2=A0common-obj-$(CONFIG_SOFTMMU) +=3D qdev-properties-system.o<br>
=C2=A0common-obj-$(CONFIG_SOFTMMU) +=3D sysbus.o<br>
=C2=A0common-obj-$(CONFIG_SOFTMMU) +=3D machine.o<br>
-common-obj-$(CONFIG_SOFTMMU) +=3D null-machine.o<br>
=C2=A0common-obj-$(CONFIG_SOFTMMU) +=3D loader.o<br>
=C2=A0common-obj-$(CONFIG_SOFTMMU) +=3D machine-hmp-cmds.o<br>
=C2=A0common-obj-$(CONFIG_SOFTMMU) +=3D numa.o<br>
=C2=A0common-obj-$(CONFIG_SOFTMMU) +=3D clock-vmstate.o<br>
+obj-$(CONFIG_SOFTMMU) +=3D null-machine.o<br>
=C2=A0obj-$(CONFIG_SOFTMMU) +=3D machine-qmp-cmds.o<br>
<br>
=C2=A0common-obj-$(CONFIG_EMPTY_SLOT) +=3D empty_slot.o<br>
diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c<br>
index cb47d9d..94a36f9 100644<br>
--- a/hw/core/null-machine.c<br>
+++ b/hw/core/null-machine.c<br>
@@ -17,6 +17,7 @@<br>
=C2=A0#include &quot;sysemu/sysemu.h&quot;<br>
=C2=A0#include &quot;exec/address-spaces.h&quot;<br>
=C2=A0#include &quot;hw/core/cpu.h&quot;<br>
+#include &quot;hw/mips/mips.h&quot;<br>
<br>
=C2=A0static void machine_none_init(MachineState *mch)<br>
=C2=A0{<br>
@@ -50,6 +51,9 @@ static void machine_none_machine_init(MachineClass *mc)<b=
r>
=C2=A0 =C2=A0 =C2=A0mc-&gt;max_cpus =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;default_ram_size =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;default_ram_id =3D &quot;ram&quot;;<br>
+#ifdef TARGET_MIPS<br>
+=C2=A0 =C2=A0 mc-&gt;kvm_type =3D mips_kvm_type;<br>
+#endif<br>
=C2=A0}<br>
<br>
=C2=A0DEFINE_MACHINE(&quot;none&quot;, machine_none_machine_init)<br>
diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs<br>
index 739e2b7..3b3e6ea 100644<br>
--- a/hw/mips/Makefile.objs<br>
+++ b/hw/mips/Makefile.objs<br>
@@ -1,4 +1,4 @@<br>
-obj-y +=3D addr.o mips_int.o<br>
+obj-y +=3D addr.o common.o mips_int.o<br>
=C2=A0obj-$(CONFIG_R4K) +=3D r4k.o<br>
=C2=A0obj-$(CONFIG_MALTA) +=3D gt64xxx_pci.o malta.o<br>
=C2=A0obj-$(CONFIG_MIPSSIM) +=3D mipssim.o<br>
diff --git a/hw/mips/common.c b/hw/mips/common.c<br>
new file mode 100644<br>
index 0000000..4d8e141<br>
--- /dev/null<br>
+++ b/hw/mips/common.c<br>
@@ -0,0 +1,42 @@<br>
+/*<br>
+ * Common MIPS routines<br>
+ *<br>
+ * Copyright (c) 2020 Huacai Chen (<a href=3D"mailto:chenhc@lemote.com" ta=
rget=3D"_blank">chenhc@lemote.com</a>)<br>
+ * This code is licensed under the GNU GPL v2.<br>
+ */<br>
+<br>
+#include &lt;linux/kvm.h&gt;<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu-common.h&quot;<br>
+#include &quot;hw/boards.h&quot;<br>
+#include &quot;hw/mips/mips.h&quot;<br>
+#include &quot;sysemu/kvm_int.h&quot;<br>
+<br>
+#ifndef CONFIG_KVM<br>
+<br>
+int mips_kvm_type(MachineState *machine, const char *vm_type)<br>
+{<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+#else<br>
+<br>
+int mips_kvm_type(MachineState *machine, const char *vm_type)<br>
+{<br>
+=C2=A0 =C2=A0 int r;<br>
+=C2=A0 =C2=A0 KVMState *s =3D KVM_STATE(machine-&gt;accelerator);<br>
+<br>
+=C2=A0 =C2=A0 r =3D kvm_check_extension(s, KVM_CAP_MIPS_VZ);<br>
+=C2=A0 =C2=A0 if (r &gt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return KVM_VM_MIPS_VZ;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 r =3D kvm_check_extension(s, KVM_CAP_MIPS_TE);<br>
+=C2=A0 =C2=A0 if (r &gt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return KVM_VM_MIPS_TE;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return -1;<br>
+}<br>
+<br>
+#endif<br>
diff --git a/include/hw/mips/mips.h b/include/hw/mips/mips.h<br>
index 0af4c3d..2ac0580 100644<br>
--- a/include/hw/mips/mips.h<br>
+++ b/include/hw/mips/mips.h<br>
@@ -20,4 +20,7 @@ void rc4030_dma_write(void *dma, uint8_t *buf, int len);<=
br>
<br>
=C2=A0DeviceState *rc4030_init(rc4030_dma **dmas, IOMMUMemoryRegion **dma_m=
r);<br>
<br>
+/* common.c */<br>
+int mips_kvm_type(MachineState *machine, const char *vm_type);<br>
+<br>
=C2=A0#endif<br>
-- <br>
2.7.0<br>
<br>
</blockquote></div></div>

--000000000000b512dd05a72eec71--

