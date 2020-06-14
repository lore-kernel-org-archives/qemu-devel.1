Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D335C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 08:08:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCD66206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 08:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iubXcnrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD66206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkNgy-0006yN-3j
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 04:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkNgI-0006BG-2v
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 04:07:54 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53762)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkNgF-0005Ss-HP
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 04:07:53 -0400
Received: by mail-wm1-x343.google.com with SMTP id l26so11654727wme.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2020 01:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=C/Bmw1BGuyqQxgNN8Ms3pL/9R54rw2XAZ9xRqqJEE1I=;
 b=iubXcnrl+lPdB6H7dH/4sODWFGacONPXk40OLLZQAUHu4WeztE5KpQgF9weVRp2oOp
 FBUkoxqZeQvsFJao9s9UaEfsbIDv7bYpa0UZLjj6m8eaMcApp+cUFlaX6DsONKrgIfem
 nG9gquvDwmprWZcCncZHq/CzYjTO+89PEqUNXHLjWVJoVbWQENTnT46S+TEx0NztkA6S
 GeAZ+ZLlQm0/UXxZUPE72wC/hG54fsY3t37ILCfz7cfwxcFpl9ss6aQ6/Ac2xX1eK+Lj
 Xr3tM9Bty3IGeLcXwalRHfhwPX2FA2EVKbAPptrYebOlFLBN/sKnG2eA1mAEYiF+GBXI
 p08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=C/Bmw1BGuyqQxgNN8Ms3pL/9R54rw2XAZ9xRqqJEE1I=;
 b=Onzo6Rj1xhGDu2n9uaBedmRirsP6EoxWRJb9ntw4Qcp3VaLq1Rmm9Zew5qrldv4G44
 broi/wRUM2iqZui0hcfhWoTv2OAXoK//0/oAULMt9GBIAui1HJ2jcCrco1lemhEX1YPx
 e6VRDWFTQQ0Rp8GJj0ASl3f1umlP7uK/Dwm9yUNT2E6ncY/NF8JR/JnlBSAyXG5lxKHH
 mKV+STVurQ9Jwzrd9tIoVG+eiDgKTWGbhnuGFM20J+uc5fAPrSYq3rOkGF+akFNESOJY
 PcBCMWApfXNlxCe8oJj98E760Zo8Q0zjUFoxyfAJTGtm6hDI/8qQ0MoQSsvtCaQ6oa2b
 1syw==
X-Gm-Message-State: AOAM533xW26pF3dv8stJcRYmIDCYa6Ts2UidTEa5e5BpQvS593m0NW0X
 04UK1PdPKG+HJEx56HW1tSoEujCzHl44rri2wwM=
X-Google-Smtp-Source: ABdhPJxWwzwlIAZN6dSqglKWSlEps+QW3BuuWe8GWVeJS4CFfbOX+ba0P6jvU+iJuALd11+NwU2CQubxu+tBTEOv08Q=
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr7845556wmb.168.1592122064491; 
 Sun, 14 Jun 2020 01:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <1591065557-9174-1-git-send-email-chenhc@lemote.com>
 <1591065557-9174-2-git-send-email-chenhc@lemote.com>
In-Reply-To: <1591065557-9174-2-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sun, 14 Jun 2020 10:07:31 +0200
Message-ID: <CAHiYmc5o3GdzEeCm5KGM0kDJcGXbJ=syd9sFEg1AqLOirFNg-Q@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V4 1/4] hw/mips: Implement the kvm_type() hook in
 MachineClass
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000017d87805a806ceda"
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

--00000000000017d87805a806ceda
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=83=D1=82=D0=BE, 2. =D1=98=D1=83=D0=BD 2020. =D1=83 04:38 Huacai Chen <z=
ltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:
>
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

Huacai,

Please take a look at Peter's remarks at:

https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg01878.html

...and refactor this patch for v5. My general advice: The simpler, the
batter.

Best wishes,
Aleksandar

>  hw/core/Makefile.objs  |  2 +-
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
vm-change-state-handler.o
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

--00000000000017d87805a806ceda
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>=D1=83=D1=82=D0=BE, 2. =D1=98=D1=83=D0=BD 2020. =
=D1=83 04:38 Huacai Chen &lt;<a href=3D"mailto:zltjiangshi@gmail.com">zltji=
angshi@gmail.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=BE/=D0=BB=D0=B0:<br>&gt;<br>&gt; MIPS has two types of KVM: TE &amp; VZ=
, and TE is the default type. Now we<br>&gt; can&#39;t create a VZ guest in=
 QEMU because it lacks the kvm_type() hook in<br>&gt; MachineClass. Besides=
, libvirt uses a null-machine to detect the kvm<br>&gt; capability, so by d=
efault it will return &quot;KVM not supported&quot; on a VZ<br>&gt; platfor=
m. Thus, null-machine also need the kvm_type() hook.<br>&gt;<br>&gt; Review=
ed-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.devel@gmai=
l.com">aleksandar.qemu.devel@gmail.com</a>&gt;<br>&gt; Signed-off-by: Huaca=
i Chen &lt;<a href=3D"mailto:chenhc@lemote.com">chenhc@lemote.com</a>&gt;<b=
r>&gt; Co-developed-by: Jiaxun Yang &lt;<a href=3D"mailto:jiaxun.yang@flygo=
at.com">jiaxun.yang@flygoat.com</a>&gt;<br><div>&gt; ---</div><div><br></di=
v><div>Huacai,</div><div><br></div><div>Please take a look at Peter&#39;s r=
emarks at:</div><div><br></div><div><a href=3D"https://lists.gnu.org/archiv=
e/html/qemu-devel/2020-06/msg01878.html">https://lists.gnu.org/archive/html=
/qemu-devel/2020-06/msg01878.html</a></div><div><br></div><div>...and refac=
tor this patch for v5. My general advice: The simpler, the batter.</div><di=
v><br></div><div>Best wishes,</div><div>Aleksandar<br></div><br>&gt; =C2=A0=
hw/core/Makefile.objs =C2=A0| =C2=A02 +-<br>&gt; =C2=A0hw/core/null-machine=
.c | =C2=A04 ++++<br>&gt; =C2=A0hw/mips/Makefile.objs =C2=A0| =C2=A02 +-<br=
>&gt; =C2=A0hw/mips/common.c =C2=A0 =C2=A0 =C2=A0 | 42 ++++++++++++++++++++=
++++++++++++++++++++++<br>&gt; =C2=A0include/hw/mips/mips.h | =C2=A03 +++<b=
r>&gt; =C2=A05 files changed, 51 insertions(+), 2 deletions(-)<br>&gt; =C2=
=A0create mode 100644 hw/mips/common.c<br>&gt;<br>&gt; diff --git a/hw/core=
/Makefile.objs b/hw/core/Makefile.objs<br>&gt; index 1d540ed..b5672f4 10064=
4<br>&gt; --- a/hw/core/Makefile.objs<br>&gt; +++ b/hw/core/Makefile.objs<b=
r>&gt; @@ -17,11 +17,11 @@ common-obj-$(CONFIG_SOFTMMU) +=3D vm-change-stat=
e-handler.o<br>&gt; =C2=A0common-obj-$(CONFIG_SOFTMMU) +=3D qdev-properties=
-system.o<br>&gt; =C2=A0common-obj-$(CONFIG_SOFTMMU) +=3D sysbus.o<br>&gt; =
=C2=A0common-obj-$(CONFIG_SOFTMMU) +=3D machine.o<br>&gt; -common-obj-$(CON=
FIG_SOFTMMU) +=3D null-machine.o<br>&gt; =C2=A0common-obj-$(CONFIG_SOFTMMU)=
 +=3D loader.o<br>&gt; =C2=A0common-obj-$(CONFIG_SOFTMMU) +=3D machine-hmp-=
cmds.o<br>&gt; =C2=A0common-obj-$(CONFIG_SOFTMMU) +=3D numa.o<br>&gt; =C2=
=A0common-obj-$(CONFIG_SOFTMMU) +=3D clock-vmstate.o<br>&gt; +obj-$(CONFIG_=
SOFTMMU) +=3D null-machine.o<br>&gt; =C2=A0obj-$(CONFIG_SOFTMMU) +=3D machi=
ne-qmp-cmds.o<br>&gt;<br>&gt; =C2=A0common-obj-$(CONFIG_EMPTY_SLOT) +=3D em=
pty_slot.o<br>&gt; diff --git a/hw/core/null-machine.c b/hw/core/null-machi=
ne.c<br>&gt; index cb47d9d..94a36f9 100644<br>&gt; --- a/hw/core/null-machi=
ne.c<br>&gt; +++ b/hw/core/null-machine.c<br>&gt; @@ -17,6 +17,7 @@<br>&gt;=
 =C2=A0#include &quot;sysemu/sysemu.h&quot;<br>&gt; =C2=A0#include &quot;ex=
ec/address-spaces.h&quot;<br>&gt; =C2=A0#include &quot;hw/core/cpu.h&quot;<=
br>&gt; +#include &quot;hw/mips/mips.h&quot;<br>&gt;<br>&gt; =C2=A0static v=
oid machine_none_init(MachineState *mch)<br>&gt; =C2=A0{<br>&gt; @@ -50,6 +=
51,9 @@ static void machine_none_machine_init(MachineClass *mc)<br>&gt; =C2=
=A0 =C2=A0 =C2=A0mc-&gt;max_cpus =3D 1;<br>&gt; =C2=A0 =C2=A0 =C2=A0mc-&gt;=
default_ram_size =3D 0;<br>&gt; =C2=A0 =C2=A0 =C2=A0mc-&gt;default_ram_id =
=3D &quot;ram&quot;;<br>&gt; +#ifdef TARGET_MIPS<br>&gt; + =C2=A0 =C2=A0mc-=
&gt;kvm_type =3D mips_kvm_type;<br>&gt; +#endif<br>&gt; =C2=A0}<br>&gt;<br>=
&gt; =C2=A0DEFINE_MACHINE(&quot;none&quot;, machine_none_machine_init)<br>&=
gt; diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs<br>&gt; inde=
x 739e2b7..3b3e6ea 100644<br>&gt; --- a/hw/mips/Makefile.objs<br>&gt; +++ b=
/hw/mips/Makefile.objs<br>&gt; @@ -1,4 +1,4 @@<br>&gt; -obj-y +=3D addr.o m=
ips_int.o<br>&gt; +obj-y +=3D addr.o common.o mips_int.o<br>&gt; =C2=A0obj-=
$(CONFIG_R4K) +=3D r4k.o<br>&gt; =C2=A0obj-$(CONFIG_MALTA) +=3D gt64xxx_pci=
.o malta.o<br>&gt; =C2=A0obj-$(CONFIG_MIPSSIM) +=3D mipssim.o<br>&gt; diff =
--git a/hw/mips/common.c b/hw/mips/common.c<br>&gt; new file mode 100644<br=
>&gt; index 0000000..4d8e141<br>&gt; --- /dev/null<br>&gt; +++ b/hw/mips/co=
mmon.c<br>&gt; @@ -0,0 +1,42 @@<br>&gt; +/*<br>&gt; + * Common MIPS routine=
s<br>&gt; + *<br>&gt; + * Copyright (c) 2020 Huacai Chen (<a href=3D"mailto=
:chenhc@lemote.com">chenhc@lemote.com</a>)<br>&gt; + * This code is license=
d under the GNU GPL v2.<br>&gt; + */<br>&gt; +<br>&gt; +#include &lt;linux/=
kvm.h&gt;<br>&gt; +#include &quot;qemu/osdep.h&quot;<br>&gt; +#include &quo=
t;qemu-common.h&quot;<br>&gt; +#include &quot;hw/boards.h&quot;<br>&gt; +#i=
nclude &quot;hw/mips/mips.h&quot;<br>&gt; +#include &quot;sysemu/kvm_int.h&=
quot;<br>&gt; +<br>&gt; +#ifndef CONFIG_KVM<br>&gt; +<br>&gt; +int mips_kvm=
_type(MachineState *machine, const char *vm_type)<br>&gt; +{<br>&gt; + =C2=
=A0 =C2=A0return 0;<br>&gt; +}<br>&gt; +<br>&gt; +#else<br>&gt; +<br>&gt; +=
int mips_kvm_type(MachineState *machine, const char *vm_type)<br>&gt; +{<br=
>&gt; + =C2=A0 =C2=A0int r;<br>&gt; + =C2=A0 =C2=A0KVMState *s =3D KVM_STAT=
E(machine-&gt;accelerator);<br>&gt; +<br>&gt; + =C2=A0 =C2=A0r =3D kvm_chec=
k_extension(s, KVM_CAP_MIPS_VZ);<br>&gt; + =C2=A0 =C2=A0if (r &gt; 0) {<br>=
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0return KVM_VM_MIPS_VZ;<br>&gt; + =C2=A0 =
=C2=A0}<br>&gt; +<br>&gt; + =C2=A0 =C2=A0r =3D kvm_check_extension(s, KVM_C=
AP_MIPS_TE);<br>&gt; + =C2=A0 =C2=A0if (r &gt; 0) {<br>&gt; + =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return KVM_VM_MIPS_TE;<br>&gt; + =C2=A0 =C2=A0}<br>&gt; +<br>=
&gt; + =C2=A0 =C2=A0return -1;<br>&gt; +}<br>&gt; +<br>&gt; +#endif<br>&gt;=
 diff --git a/include/hw/mips/mips.h b/include/hw/mips/mips.h<br>&gt; index=
 0af4c3d..2ac0580 100644<br>&gt; --- a/include/hw/mips/mips.h<br>&gt; +++ b=
/include/hw/mips/mips.h<br>&gt; @@ -20,4 +20,7 @@ void rc4030_dma_write(voi=
d *dma, uint8_t *buf, int len);<br>&gt;<br>&gt; =C2=A0DeviceState *rc4030_i=
nit(rc4030_dma **dmas, IOMMUMemoryRegion **dma_mr);<br>&gt;<br>&gt; +/* com=
mon.c */<br>&gt; +int mips_kvm_type(MachineState *machine, const char *vm_t=
ype);<br>&gt; +<br>&gt; =C2=A0#endif<br>&gt; --<br>&gt; 2.7.0<br>&gt;<br></=
div>

--00000000000017d87805a806ceda--

