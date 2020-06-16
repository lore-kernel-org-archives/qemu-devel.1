Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA12CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 21:18:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AF1F208B3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 21:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaK0UFy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF1F208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlIyl-0003l7-Qv
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 17:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jlIxc-000352-4U
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 17:17:36 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:51298)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jlIxZ-0006PD-Fh
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 17:17:35 -0400
Received: by mail-wm1-x32c.google.com with SMTP id b82so4215922wmb.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 14:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=wP5jEK/lh5XGtbDBsKo3/g0COuOCG749buYnRFSYjqU=;
 b=DaK0UFy7x5sKfXEeJOUHghpSULe5dEHxj08VMji5VjkZTvts3QhOI/cmtJmnaFPn3e
 c8vDpQWY4PijbiKl9IfOFMUg4HSlPxVcx5jG74iLlHdEm8JPIlMnWJimgfw5hNjb1NiW
 puanygu2jXhCiK8oT2Kr2fQlBLneRLd+YmiVJg//6VvU1JZ/kdZlnUe5kIVnMCM6wEG8
 ebq06MWyfbOYqFghCMn2/vGj3+reDM4e/exKfjU8Hb2fpSEOCUzUvQx+lzmbDUJB0v8+
 XH8XT0tTmZkvCus29l++F7dzvxVoMIMVTLJw7+d3LWohbvBVyWx3mHm/tCY2/It+VzVR
 irRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=wP5jEK/lh5XGtbDBsKo3/g0COuOCG749buYnRFSYjqU=;
 b=pkj/UzTqWlPXBRp2B/xwfnF0mJYiYGCk0kGs/hjAQyfcj4rgpTM38WjEg4In4PRP4e
 mjSUxb1upu0Fl8Qg7hTR8IOQw5JL9nruJIihYueoGvtNGa8Lkeanl1f1YsmHk1y+fNF/
 OcDPMbmoWFEEa/IJro0Xd3hLTQixMUr92LPaZpmqsFOl6MAQXjHA+HFA+dVcR890szrb
 +T8qVBY3zOb2//+7Zok6zQmOZWUrkPZdZmwQNYyr5ySEKTKFSxxxNuCpGqHDTi6SF68n
 KzjfSJ5PJ4ZvvEEKDmczZkIHsTk7qwnXODZYvkqR7eCIWrB9rSQjZ3iQGDYvbnPABfNi
 1QSw==
X-Gm-Message-State: AOAM533v7rkSprpQff+OY3pninrk5kfeUrFGbSc6n6FJhzGL8g7hBqoe
 moBYgGzD6Wa2wP9/JlQyYpGb8CyqYiposbXe91Q=
X-Google-Smtp-Source: ABdhPJyMbvukCI6NWM+yGSUEGy5rc8JKHJHkOL5ksEKzW9YrRFN2LyECQu06OY8NHOu90M+6yOYCX1wHhw4WyFzwyGg=
X-Received: by 2002:a1c:46c3:: with SMTP id t186mr4936460wma.36.1592342251750; 
 Tue, 16 Jun 2020 14:17:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:451:0:0:0:0:0 with HTTP;
 Tue, 16 Jun 2020 14:17:31 -0700 (PDT)
In-Reply-To: <CAAhV-H4oTR=LATQmZ0xNmnu+_O4XXa84SGzHSZ83HWq9VhKKDA@mail.gmail.com>
References: <1591065557-9174-1-git-send-email-chenhc@lemote.com>
 <1591065557-9174-2-git-send-email-chenhc@lemote.com>
 <CAHiYmc5o3GdzEeCm5KGM0kDJcGXbJ=syd9sFEg1AqLOirFNg-Q@mail.gmail.com>
 <CAAhV-H6KHOLDstUQvOV+8T872R_mLH-ZYHG1YaA6FSqd5meovw@mail.gmail.com>
 <653db100-34fb-6cbd-215b-e4d931cc5e07@redhat.com>
 <CAL1e-=iuAbE+TF1kCZokX75uALZDTndugZVq-mGebJ0F10TLsA@mail.gmail.com>
 <CAAhV-H4oTR=LATQmZ0xNmnu+_O4XXa84SGzHSZ83HWq9VhKKDA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 16 Jun 2020 23:17:31 +0200
Message-ID: <CAHiYmc4kqAFE=DsR74W8Y6HPPXUCqopTt2D-OCxuN9jYQY8m_A@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V4 1/4] hw/mips: Implement the kvm_type() hook in
 MachineClass
To: Huacai Chen <chenhuacai@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000046ca0c05a83a1223"
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x32c.google.com
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
Cc: Huacai Chen <zltjiangshi@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000046ca0c05a83a1223
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 16. =D1=98=D1=83=D0=BD 2020., Huacai =
Chen <chenhuacai@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BE/=D0=BB=D0=B0:

> Hi, Thomas and Aleksandar,
>
> On Tue, Jun 16, 2020 at 3:45 AM Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
> >
> > On Mon, Jun 15, 2020 at 10:55 AM Thomas Huth <thuth@redhat.com> wrote:
> > >
> > > On 15/06/2020 02.52, Huacai Chen wrote:
> > > > Hi, Aleksandar,
> > > >
> > > > On Sun, Jun 14, 2020 at 4:07 PM Aleksandar Markovic
> > > > <aleksandar.qemu.devel@gmail.com> wrote:
> > > >>
> > > >>
> > > >>
> > > >> =D1=83=D1=82=D0=BE, 2. =D1=98=D1=83=D0=BD 2020. =D1=83 04:38 Huaca=
i Chen <zltjiangshi@gmail.com> =D1=98=D0=B5
> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> > > >>>
> > > >>> MIPS has two types of KVM: TE & VZ, and TE is the default type.
> Now we
> > > >>> can't create a VZ guest in QEMU because it lacks the kvm_type()
> hook in
> > > >>> MachineClass. Besides, libvirt uses a null-machine to detect the
> kvm
> > > >>> capability, so by default it will return "KVM not supported" on a
> VZ
> > > >>> platform. Thus, null-machine also need the kvm_type() hook.
> > > >>>
> > > >>> Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com=
>
> > > >>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > > >>> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > >>> ---
> > > >>
> > > >> Huacai,
> > > >>
> > > >> Please take a look at Peter's remarks at:
> > > >>
> > > >> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg01878.htm=
l
> > > >>
> > > >> ...and refactor this patch for v5. My general advice: The simpler,
> the batter.
> > > >>
> > > > OK, I will rework this patch.
> > >
> > >  Hi,
> > >
> > > is there maybe also a way to do this without moving null-machine.o fr=
om
> > > common-obj-y to obj-y, and to avoid the target-specific hacks in this
> > > file ? We just moved the null-machine from obj-y to common-obj-y two
> > > years ago (see commit 3858ff763985fb9e), since it's more desirable to
> > > have as much code in common-obj to save compilation time and maybe to
> be
> > > able to link a qemu with more than one target CPU in one binary one
> day...
> > >
> > > ppc64 has also more than one kvm_type (kvm-hv and kvm-pr), and
> > > apparently it also works without hacks to the null-machine code there
> > > ... so maybe you can peek into the ppc64 code to see how it is solved
> there?
> > >
> >
> > Hi, Huacai,
> >
> > I think the optimal outcome for this release of QEMU would be if you
> > drop support for VZ. I think your scenario could work without VZ,
> > couldn't it?
> >
> > This is a fairly complex thing, and, as you see, it is a little
> > intrusive, it could negatively impact other targets. With enough
> > development time, you can easily provide that support in 5.2. - but
> > now we are close to 5.1 softfreeze.
> >
> > Even without VZ support, I would consider your contribution the most
> > significant for MIPS target in last two years, at least - a giant step
> > ahead!
> There are two problems: 1, qemu need kvm_type() to create a normal KVM
> guest. 2, libvirt use the null-machine to detect the KVM capability.
> For the first problem, just provide a kvm_type() hook for MIPS is
> enough, which is similar to ppc64. For the second problem, I think
> libvirt is also unable to detect the KVM capabilty on ppc64, unless
> ppc64 do the same hack on null-machine.
>
> V5 of this patch will only provide kvm_type() for MIPS (not hack
> null-machine.c), but all of us should think how to solve the second
> problem.
>
>
I think this is a good approach, Huacai. Looking forward to v5.

May health be with you,

Aleksandar




> Huacai
> >
> > Best Regards,
> > Aleksandar
> >
> > >  Thomas
> > >
> > >
> > > >>>  hw/core/Makefile.objs  |  2 +-
> > > >>>  hw/core/null-machine.c |  4 ++++
> > > >>>  hw/mips/Makefile.objs  |  2 +-
> > > >>>  hw/mips/common.c       | 42 ++++++++++++++++++++++++++++++
> ++++++++++++
> > > >>>  include/hw/mips/mips.h |  3 +++
> > > >>>  5 files changed, 51 insertions(+), 2 deletions(-)
> > > >>>  create mode 100644 hw/mips/common.c
> > > >>>
> > > >>> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> > > >>> index 1d540ed..b5672f4 100644
> > > >>> --- a/hw/core/Makefile.objs
> > > >>> +++ b/hw/core/Makefile.objs
> > > >>> @@ -17,11 +17,11 @@ common-obj-$(CONFIG_SOFTMMU) +=3D
> vm-change-state-handler.o
> > > >>>  common-obj-$(CONFIG_SOFTMMU) +=3D qdev-properties-system.o
> > > >>>  common-obj-$(CONFIG_SOFTMMU) +=3D sysbus.o
> > > >>>  common-obj-$(CONFIG_SOFTMMU) +=3D machine.o
> > > >>> -common-obj-$(CONFIG_SOFTMMU) +=3D null-machine.o
> > > >>>  common-obj-$(CONFIG_SOFTMMU) +=3D loader.o
> > > >>>  common-obj-$(CONFIG_SOFTMMU) +=3D machine-hmp-cmds.o
> > > >>>  common-obj-$(CONFIG_SOFTMMU) +=3D numa.o
> > > >>>  common-obj-$(CONFIG_SOFTMMU) +=3D clock-vmstate.o
> > > >>> +obj-$(CONFIG_SOFTMMU) +=3D null-machine.o
> > > >>>  obj-$(CONFIG_SOFTMMU) +=3D machine-qmp-cmds.o
> > > >>>
> > > >>>  common-obj-$(CONFIG_EMPTY_SLOT) +=3D empty_slot.o
> > > >>> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
> > > >>> index cb47d9d..94a36f9 100644
> > > >>> --- a/hw/core/null-machine.c
> > > >>> +++ b/hw/core/null-machine.c
> > > >>> @@ -17,6 +17,7 @@
> > > >>>  #include "sysemu/sysemu.h"
> > > >>>  #include "exec/address-spaces.h"
> > > >>>  #include "hw/core/cpu.h"
> > > >>> +#include "hw/mips/mips.h"
> > > >>>
> > > >>>  static void machine_none_init(MachineState *mch)
> > > >>>  {
> > > >>> @@ -50,6 +51,9 @@ static void machine_none_machine_init(MachineCl=
ass
> *mc)
> > > >>>      mc->max_cpus =3D 1;
> > > >>>      mc->default_ram_size =3D 0;
> > > >>>      mc->default_ram_id =3D "ram";
> > > >>> +#ifdef TARGET_MIPS
> > > >>> +    mc->kvm_type =3D mips_kvm_type;
> > > >>> +#endif
> > > >>>  }
> > > >>>
> > > >>>  DEFINE_MACHINE("none", machine_none_machine_init)
> > > >>> diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
> > > >>> index 739e2b7..3b3e6ea 100644
> > > >>> --- a/hw/mips/Makefile.objs
> > > >>> +++ b/hw/mips/Makefile.objs
> > > >>> @@ -1,4 +1,4 @@
> > > >>> -obj-y +=3D addr.o mips_int.o
> > > >>> +obj-y +=3D addr.o common.o mips_int.o
> > > >>>  obj-$(CONFIG_R4K) +=3D r4k.o
> > > >>>  obj-$(CONFIG_MALTA) +=3D gt64xxx_pci.o malta.o
> > > >>>  obj-$(CONFIG_MIPSSIM) +=3D mipssim.o
> > > >>> diff --git a/hw/mips/common.c b/hw/mips/common.c
> > > >>> new file mode 100644
> > > >>> index 0000000..4d8e141
> > > >>> --- /dev/null
> > > >>> +++ b/hw/mips/common.c
> > > >>> @@ -0,0 +1,42 @@
> > > >>> +/*
> > > >>> + * Common MIPS routines
> > > >>> + *
> > > >>> + * Copyright (c) 2020 Huacai Chen (chenhc@lemote.com)
> > > >>> + * This code is licensed under the GNU GPL v2.
> > > >>> + */
> > > >>> +
> > > >>> +#include <linux/kvm.h>
> > > >>> +#include "qemu/osdep.h"
> > > >>> +#include "qemu-common.h"
> > > >>> +#include "hw/boards.h"
> > > >>> +#include "hw/mips/mips.h"
> > > >>> +#include "sysemu/kvm_int.h"
> > > >>> +
> > > >>> +#ifndef CONFIG_KVM
> > > >>> +
> > > >>> +int mips_kvm_type(MachineState *machine, const char *vm_type)
> > > >>> +{
> > > >>> +    return 0;
> > > >>> +}
> > > >>> +
> > > >>> +#else
> > > >>> +
> > > >>> +int mips_kvm_type(MachineState *machine, const char *vm_type)
> > > >>> +{
> > > >>> +    int r;
> > > >>> +    KVMState *s =3D KVM_STATE(machine->accelerator);
> > > >>> +
> > > >>> +    r =3D kvm_check_extension(s, KVM_CAP_MIPS_VZ);
> > > >>> +    if (r > 0) {
> > > >>> +        return KVM_VM_MIPS_VZ;
> > > >>> +    }
> > > >>> +
> > > >>> +    r =3D kvm_check_extension(s, KVM_CAP_MIPS_TE);
> > > >>> +    if (r > 0) {
> > > >>> +        return KVM_VM_MIPS_TE;
> > > >>> +    }
> > > >>> +
> > > >>> +    return -1;
> > > >>> +}
> > > >>> +
> > > >>> +#endif
> > > >>> diff --git a/include/hw/mips/mips.h b/include/hw/mips/mips.h
> > > >>> index 0af4c3d..2ac0580 100644
> > > >>> --- a/include/hw/mips/mips.h
> > > >>> +++ b/include/hw/mips/mips.h
> > > >>> @@ -20,4 +20,7 @@ void rc4030_dma_write(void *dma, uint8_t *buf,
> int len);
> > > >>>
> > > >>>  DeviceState *rc4030_init(rc4030_dma **dmas, IOMMUMemoryRegion
> **dma_mr);
> > > >>>
> > > >>> +/* common.c */
> > > >>> +int mips_kvm_type(MachineState *machine, const char *vm_type);
> > > >>> +
> > > >>>  #endif
> > > >>> --
> > > >>> 2.7.0
> > > >>>
> > > >
> > >
> > >
>

--00000000000046ca0c05a83a1223
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 16. =D1=98=D1=83=D0=BD 2020.,=
 Huacai Chen &lt;<a href=3D"mailto:chenhuacai@gmail.com">chenhuacai@gmail.c=
om</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=
=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">Hi, Thomas and Aleksandar,<br>
<br>
On Tue, Jun 16, 2020 at 3:45 AM Aleksandar Markovic<br>
&lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@gmail.=
com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Mon, Jun 15, 2020 at 10:55 AM Thomas Huth &lt;<a href=3D"mailto:thu=
th@redhat.com">thuth@redhat.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; On 15/06/2020 02.52, Huacai Chen wrote:<br>
&gt; &gt; &gt; Hi, Aleksandar,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Sun, Jun 14, 2020 at 4:07 PM Aleksandar Markovic<br>
&gt; &gt; &gt; &lt;<a href=3D"mailto:aleksandar.qemu.devel@gmail.com">aleks=
andar.qemu.devel@gmail.<wbr>com</a>&gt; wrote:<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; =D1=83=D1=82=D0=BE, 2. =D1=98=D1=83=D0=BD 2020. =D1=83 0=
4:38 Huacai Chen &lt;<a href=3D"mailto:zltjiangshi@gmail.com">zltjiangshi@g=
mail.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; MIPS has two types of KVM: TE &amp; VZ, and TE is th=
e default type. Now we<br>
&gt; &gt; &gt;&gt;&gt; can&#39;t create a VZ guest in QEMU because it lacks=
 the kvm_type() hook in<br>
&gt; &gt; &gt;&gt;&gt; MachineClass. Besides, libvirt uses a null-machine t=
o detect the kvm<br>
&gt; &gt; &gt;&gt;&gt; capability, so by default it will return &quot;KVM n=
ot supported&quot; on a VZ<br>
&gt; &gt; &gt;&gt;&gt; platform. Thus, null-machine also need the kvm_type(=
) hook.<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mail=
to:aleksandar.qemu.devel@gmail.com">aleksandar.qemu.devel@gmail.<wbr>com</a=
>&gt;<br>
&gt; &gt; &gt;&gt;&gt; Signed-off-by: Huacai Chen &lt;<a href=3D"mailto:che=
nhc@lemote.com">chenhc@lemote.com</a>&gt;<br>
&gt; &gt; &gt;&gt;&gt; Co-developed-by: Jiaxun Yang &lt;<a href=3D"mailto:j=
iaxun.yang@flygoat.com">jiaxun.yang@flygoat.com</a>&gt;<br>
&gt; &gt; &gt;&gt;&gt; ---<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; Huacai,<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; Please take a look at Peter&#39;s remarks at:<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel=
/2020-06/msg01878.html" target=3D"_blank">https://lists.gnu.org/archive/<wb=
r>html/qemu-devel/2020-06/<wbr>msg01878.html</a><br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; ...and refactor this patch for v5. My general advice: Th=
e simpler, the batter.<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt; OK, I will rework this patch.<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 Hi,<br>
&gt; &gt;<br>
&gt; &gt; is there maybe also a way to do this without moving null-machine.=
o from<br>
&gt; &gt; common-obj-y to obj-y, and to avoid the target-specific hacks in =
this<br>
&gt; &gt; file ? We just moved the null-machine from obj-y to common-obj-y =
two<br>
&gt; &gt; years ago (see commit 3858ff763985fb9e), since it&#39;s more desi=
rable to<br>
&gt; &gt; have as much code in common-obj to save compilation time and mayb=
e to be<br>
&gt; &gt; able to link a qemu with more than one target CPU in one binary o=
ne day...<br>
&gt; &gt;<br>
&gt; &gt; ppc64 has also more than one kvm_type (kvm-hv and kvm-pr), and<br=
>
&gt; &gt; apparently it also works without hacks to the null-machine code t=
here<br>
&gt; &gt; ... so maybe you can peek into the ppc64 code to see how it is so=
lved there?<br>
&gt; &gt;<br>
&gt;<br>
&gt; Hi, Huacai,<br>
&gt;<br>
&gt; I think the optimal outcome for this release of QEMU would be if you<b=
r>
&gt; drop support for VZ. I think your scenario could work without VZ,<br>
&gt; couldn&#39;t it?<br>
&gt;<br>
&gt; This is a fairly complex thing, and, as you see, it is a little<br>
&gt; intrusive, it could negatively impact other targets. With enough<br>
&gt; development time, you can easily provide that support in 5.2. - but<br=
>
&gt; now we are close to 5.1 softfreeze.<br>
&gt;<br>
&gt; Even without VZ support, I would consider your contribution the most<b=
r>
&gt; significant for MIPS target in last two years, at least - a giant step=
<br>
&gt; ahead!<br>
There are two problems: 1, qemu need kvm_type() to create a normal KVM<br>
guest. 2, libvirt use the null-machine to detect the KVM capability.<br>
For the first problem, just provide a kvm_type() hook for MIPS is<br>
enough, which is similar to ppc64. For the second problem, I think<br>
libvirt is also unable to detect the KVM capabilty on ppc64, unless<br>
ppc64 do the same hack on null-machine.<br>
<br>
V5 of this patch will only provide kvm_type() for MIPS (not hack<br>
null-machine.c), but all of us should think how to solve the second<br>
problem.<br>
<br></blockquote><div><br></div><div>I think this is a good approach, Huaca=
i. Looking forward to v5.</div><div><br></div><div>May health be with you,<=
/div><div><br></div><div>Aleksandar</div><div><br></div><div><br></div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
Huacai<br>
&gt;<br>
&gt; Best Regards,<br>
&gt; Aleksandar<br>
&gt;<br>
&gt; &gt;=C2=A0 Thomas<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 hw/core/Makefile.objs=C2=A0 |=C2=A0 2 +-<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 hw/core/null-machine.c |=C2=A0 4 ++++<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 hw/mips/Makefile.objs=C2=A0 |=C2=A0 2 +-<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 hw/mips/common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 4=
2 ++++++++++++++++++++++++++++++<wbr>++++++++++++<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 include/hw/mips/mips.h |=C2=A0 3 +++<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 5 files changed, 51 insertions(+), 2 deletions=
(-)<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 create mode 100644 hw/mips/common.c<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; diff --git a/hw/core/Makefile.objs b/hw/core/Makefil=
e.objs<br>
&gt; &gt; &gt;&gt;&gt; index 1d540ed..b5672f4 100644<br>
&gt; &gt; &gt;&gt;&gt; --- a/hw/core/Makefile.objs<br>
&gt; &gt; &gt;&gt;&gt; +++ b/hw/core/Makefile.objs<br>
&gt; &gt; &gt;&gt;&gt; @@ -17,11 +17,11 @@ common-obj-$(CONFIG_SOFTMMU) +=
=3D vm-change-state-handler.o<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 common-obj-$(CONFIG_SOFTMMU) +=3D qdev-propert=
ies-system.o<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 common-obj-$(CONFIG_SOFTMMU) +=3D sysbus.o<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 common-obj-$(CONFIG_SOFTMMU) +=3D machine.o<br=
>
&gt; &gt; &gt;&gt;&gt; -common-obj-$(CONFIG_SOFTMMU) +=3D null-machine.o<br=
>
&gt; &gt; &gt;&gt;&gt;=C2=A0 common-obj-$(CONFIG_SOFTMMU) +=3D loader.o<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 common-obj-$(CONFIG_SOFTMMU) +=3D machine-hmp-=
cmds.o<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 common-obj-$(CONFIG_SOFTMMU) +=3D numa.o<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 common-obj-$(CONFIG_SOFTMMU) +=3D clock-vmstat=
e.o<br>
&gt; &gt; &gt;&gt;&gt; +obj-$(CONFIG_SOFTMMU) +=3D null-machine.o<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 obj-$(CONFIG_SOFTMMU) +=3D machine-qmp-cmds.o<=
br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 common-obj-$(CONFIG_EMPTY_<wbr>SLOT) +=3D empt=
y_slot.o<br>
&gt; &gt; &gt;&gt;&gt; diff --git a/hw/core/null-machine.c b/hw/core/null-m=
achine.c<br>
&gt; &gt; &gt;&gt;&gt; index cb47d9d..94a36f9 100644<br>
&gt; &gt; &gt;&gt;&gt; --- a/hw/core/null-machine.c<br>
&gt; &gt; &gt;&gt;&gt; +++ b/hw/core/null-machine.c<br>
&gt; &gt; &gt;&gt;&gt; @@ -17,6 +17,7 @@<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 #include &quot;sysemu/sysemu.h&quot;<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 #include &quot;exec/address-spaces.h&quot;<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 #include &quot;hw/core/cpu.h&quot;<br>
&gt; &gt; &gt;&gt;&gt; +#include &quot;hw/mips/mips.h&quot;<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 static void machine_none_init(MachineState *mc=
h)<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 {<br>
&gt; &gt; &gt;&gt;&gt; @@ -50,6 +51,9 @@ static void machine_none_machine_i=
nit(<wbr>MachineClass *mc)<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 mc-&gt;max_cpus =3D 1;<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 mc-&gt;default_ram_size =3D 0;<b=
r>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 mc-&gt;default_ram_id =3D &quot;=
ram&quot;;<br>
&gt; &gt; &gt;&gt;&gt; +#ifdef TARGET_MIPS<br>
&gt; &gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 mc-&gt;kvm_type =3D mips_kvm_type;<br=
>
&gt; &gt; &gt;&gt;&gt; +#endif<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 }<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 DEFINE_MACHINE(&quot;none&quot;, machine_none_=
machine_init)<br>
&gt; &gt; &gt;&gt;&gt; diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefil=
e.objs<br>
&gt; &gt; &gt;&gt;&gt; index 739e2b7..3b3e6ea 100644<br>
&gt; &gt; &gt;&gt;&gt; --- a/hw/mips/Makefile.objs<br>
&gt; &gt; &gt;&gt;&gt; +++ b/hw/mips/Makefile.objs<br>
&gt; &gt; &gt;&gt;&gt; @@ -1,4 +1,4 @@<br>
&gt; &gt; &gt;&gt;&gt; -obj-y +=3D addr.o mips_int.o<br>
&gt; &gt; &gt;&gt;&gt; +obj-y +=3D addr.o common.o mips_int.o<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 obj-$(CONFIG_R4K) +=3D r4k.o<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 obj-$(CONFIG_MALTA) +=3D gt64xxx_pci.o malta.o=
<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 obj-$(CONFIG_MIPSSIM) +=3D mipssim.o<br>
&gt; &gt; &gt;&gt;&gt; diff --git a/hw/mips/common.c b/hw/mips/common.c<br>
&gt; &gt; &gt;&gt;&gt; new file mode 100644<br>
&gt; &gt; &gt;&gt;&gt; index 0000000..4d8e141<br>
&gt; &gt; &gt;&gt;&gt; --- /dev/null<br>
&gt; &gt; &gt;&gt;&gt; +++ b/hw/mips/common.c<br>
&gt; &gt; &gt;&gt;&gt; @@ -0,0 +1,42 @@<br>
&gt; &gt; &gt;&gt;&gt; +/*<br>
&gt; &gt; &gt;&gt;&gt; + * Common MIPS routines<br>
&gt; &gt; &gt;&gt;&gt; + *<br>
&gt; &gt; &gt;&gt;&gt; + * Copyright (c) 2020 Huacai Chen (<a href=3D"mailt=
o:chenhc@lemote.com">chenhc@lemote.com</a>)<br>
&gt; &gt; &gt;&gt;&gt; + * This code is licensed under the GNU GPL v2.<br>
&gt; &gt; &gt;&gt;&gt; + */<br>
&gt; &gt; &gt;&gt;&gt; +<br>
&gt; &gt; &gt;&gt;&gt; +#include &lt;linux/kvm.h&gt;<br>
&gt; &gt; &gt;&gt;&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; &gt; &gt;&gt;&gt; +#include &quot;qemu-common.h&quot;<br>
&gt; &gt; &gt;&gt;&gt; +#include &quot;hw/boards.h&quot;<br>
&gt; &gt; &gt;&gt;&gt; +#include &quot;hw/mips/mips.h&quot;<br>
&gt; &gt; &gt;&gt;&gt; +#include &quot;sysemu/kvm_int.h&quot;<br>
&gt; &gt; &gt;&gt;&gt; +<br>
&gt; &gt; &gt;&gt;&gt; +#ifndef CONFIG_KVM<br>
&gt; &gt; &gt;&gt;&gt; +<br>
&gt; &gt; &gt;&gt;&gt; +int mips_kvm_type(MachineState *machine, const char=
 *vm_type)<br>
&gt; &gt; &gt;&gt;&gt; +{<br>
&gt; &gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; &gt; &gt;&gt;&gt; +}<br>
&gt; &gt; &gt;&gt;&gt; +<br>
&gt; &gt; &gt;&gt;&gt; +#else<br>
&gt; &gt; &gt;&gt;&gt; +<br>
&gt; &gt; &gt;&gt;&gt; +int mips_kvm_type(MachineState *machine, const char=
 *vm_type)<br>
&gt; &gt; &gt;&gt;&gt; +{<br>
&gt; &gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 int r;<br>
&gt; &gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 KVMState *s =3D KVM_STATE(machine-&gt=
;<wbr>accelerator);<br>
&gt; &gt; &gt;&gt;&gt; +<br>
&gt; &gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 r =3D kvm_check_extension(s, KVM_CAP_=
MIPS_VZ);<br>
&gt; &gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 if (r &gt; 0) {<br>
&gt; &gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return KVM_VM_MIPS_VZ;<=
br>
&gt; &gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;&gt;&gt; +<br>
&gt; &gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 r =3D kvm_check_extension(s, KVM_CAP_=
MIPS_TE);<br>
&gt; &gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 if (r &gt; 0) {<br>
&gt; &gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return KVM_VM_MIPS_TE;<=
br>
&gt; &gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;&gt;&gt; +<br>
&gt; &gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 return -1;<br>
&gt; &gt; &gt;&gt;&gt; +}<br>
&gt; &gt; &gt;&gt;&gt; +<br>
&gt; &gt; &gt;&gt;&gt; +#endif<br>
&gt; &gt; &gt;&gt;&gt; diff --git a/include/hw/mips/mips.h b/include/hw/mip=
s/mips.h<br>
&gt; &gt; &gt;&gt;&gt; index 0af4c3d..2ac0580 100644<br>
&gt; &gt; &gt;&gt;&gt; --- a/include/hw/mips/mips.h<br>
&gt; &gt; &gt;&gt;&gt; +++ b/include/hw/mips/mips.h<br>
&gt; &gt; &gt;&gt;&gt; @@ -20,4 +20,7 @@ void rc4030_dma_write(void *dma, u=
int8_t *buf, int len);<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 DeviceState *rc4030_init(rc4030_dma **dmas, IO=
MMUMemoryRegion **dma_mr);<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; +/* common.c */<br>
&gt; &gt; &gt;&gt;&gt; +int mips_kvm_type(MachineState *machine, const char=
 *vm_type);<br>
&gt; &gt; &gt;&gt;&gt; +<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 #endif<br>
&gt; &gt; &gt;&gt;&gt; --<br>
&gt; &gt; &gt;&gt;&gt; 2.7.0<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
</blockquote>

--00000000000046ca0c05a83a1223--

