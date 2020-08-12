Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693CBC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 00:44:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34C602080C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 00:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jbDF9Jg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C602080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5esK-0000pL-GH
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 20:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1k5erC-00009r-9G
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 20:43:06 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:37120)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1k5erA-0007HL-F0
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 20:43:05 -0400
Received: by mail-io1-xd43.google.com with SMTP id b16so873576ioj.4
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 17:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NuTTPPJBQ3xJpwH5vwuv4FBS8TOags08FVpUP7oJeVM=;
 b=jbDF9Jg8LOghiVmy9EJ0/SZyHRALJHNVu7G9+8k45ps9CO3VVGUbi8Ci96I4cXRVYP
 Df11XEn2pYHz6BpIF4Tw64hofwa2tRCI7zVDGmbyTZw3IK7QaI9cc3FZLo5nyju8rBHi
 t/p1vXzry8PIzuxQtFRzre83JfMYO5aeYm/UbbHYcxqdO+bsFzjLeRRhLuQR5NX9QVhV
 OJY6TStb6BboizX3JqqNsRTOyRtT/xsDMXSPBjb0f/KfRsAsxDVMMbR/8d2PoEW+L+rU
 OeO4nbEzzVTy2LKSR5UuJozPEAWhKn1iyfeqR9T6MfBfgmZnU0cJoEq3fBeJ7Q6i8v5t
 5zrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NuTTPPJBQ3xJpwH5vwuv4FBS8TOags08FVpUP7oJeVM=;
 b=sk1e3sMTsbEsuthIs3wMrGCCPILvSMS6+7om+ouvKTUELoCJdm3tLhae/ZkLTkhPjw
 OBV3Ul70AmVFF24VzZGVM3Pj6YxBQK24EE1AKosPFp7Pz36heOZsW1PIzuOTJC2SGGa9
 5wWJgtRgMm5P+1oWwEjx2ZlM315oXlN2qPC5UNa2V/RyuUWrXNoR2fW3bofehMzZYUmZ
 bvBeUNCRI3MnN7brARjzSbFK1tLuAsu0Pe4fFsdFF0DA2cAwbzysSgrBVKgLZGJPt27+
 twB9QOzECBz9zdqO3JDl/2Ziu7AdhlZkf902VDBmBLaw0CT15RStBNQX1kXoWmUjmbUW
 SWeA==
X-Gm-Message-State: AOAM531wH4J43v6idgg9kAl9+znfhP5wB/9WbEWq9G7Xe9WK/L2o3MEl
 MvPl7ZlVaZ/ltaw8rogsA6PcWIy/fZRvipwsmCTc
X-Google-Smtp-Source: ABdhPJyg8uv9ige6JeokyZ0ofvj3WNohEpkar8/BFyLi2Q7YZywiBtR7FcX09TyoBe/d+Q5hKpcpg5CEqIWosWcL4pY=
X-Received: by 2002:a6b:6508:: with SMTP id z8mr25607551iob.0.1597192983013;
 Tue, 11 Aug 2020 17:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1596768588.git.haibo.xu@linaro.org>
 <1663d06172cffa723e00893837ba04634f061fc8.1596768588.git.haibo.xu@linaro.org>
 <20200810110521.4hodliv4tl64v463@kamzik.brq.redhat.com>
 <CAJc+Z1HDokOuTA4=hzS5KHPU9w3Hm0UV=nJbjnvHEbtTpDY0Ag@mail.gmail.com>
 <20200811163832.roxay4uafcyp3sed@kamzik.brq.redhat.com>
In-Reply-To: <20200811163832.roxay4uafcyp3sed@kamzik.brq.redhat.com>
From: Haibo Xu <haibo.xu@linaro.org>
Date: Wed, 12 Aug 2020 08:42:51 +0800
Message-ID: <CAJc+Z1Ev8TfzKBqG1-GGeaEepLQVay0LzwJv3vFKg_Ws653qRg@mail.gmail.com>
Subject: Re: [PATCH 6/7] hw/arm/virt: spe: Add SPE fdt binding for virt machine
To: Andrew Jones <drjones@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000064061505aca37879"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=haibo.xu@linaro.org; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000064061505aca37879
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Aug 2020 at 00:40, Andrew Jones <drjones@redhat.com> wrote:

> On Tue, Aug 11, 2020 at 10:38:02AM +0800, Haibo Xu wrote:
> > On Mon, 10 Aug 2020 at 19:05, Andrew Jones <drjones@redhat.com> wrote:
> > >
> > > On Fri, Aug 07, 2020 at 08:10:36AM +0000, Haibo Xu wrote:
> > > > Add a virtual SPE device for virt machine while using PPI
> > > > 5 for SPE overflow interrupt number.
> > >
> > > Any reason PPI 5 was selected?
> > >
> >
> > No special reason to choose PPI 5. Just re-use the setting in kvmtool.
>
> Please write in the commit message that kvmtool has already selected PPI 5
> for this purpose.
>

Ok, will fix it.


> > > > +    fdt_add_spe_nodes(vms);
> > > > +
> > >
> > > You didn't add any compat code, which means all virt machine types are
> now
> > > getting an SPE FDT node, ACPI table change, and, most importantly, PPI
> 5
> > > has gone from unallocated to allocated. We definitely need compat code.
> > >
> >
> > So the 'compat code' here means to only add the SPE node in KVM mode?
>
> No, it means only add it for the 5.2 and later machine types. You'll see
> what I mean when you study the patchset I pointed out, which is also only
> for 5.2 and later machine types.
>

Ok, thanks for the clarification!


> > > > +        if (switched_level & KVM_ARM_DEV_SPE) {
> > > > +            qemu_set_irq(cpu->spe_interrupt,
> > > > +                         !!(run->s.regs.device_irq_level &
> KVM_ARM_DEV_SPE));
> > > > +            switched_level &= ~KVM_ARM_DEV_SPE;
> > > > +        }
> > > > +
> > >
> > > Did you test with a userspace irqchip?
> >
> > No, I just tested with an in-kernel irqchip.
> > Actually, the current kernel vSPE patch doesn't support a userspace
> irqchip.
> > AFAIK, the userspace irqchip support should be ready in the next
> > kernel patch series
> > which will be sent out for review in the middle of September.
>
> It probably doesn't hurt to do the above hunk already, hoping it will just
> work when it's possible to test, but I generally prefer only adding tested
> code. Maybe this hunk should be a separate patch with a commit message
> explaining that it's untested?
>

Good idea! I will drop the hunk in this series, and send out a separate
patch to enable it
once the kernel support is ready!


> Thanks,
> drew
>
>

--00000000000064061505aca37879
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Wed, 12 Aug 2020 at 00:40, Andrew Jone=
s &lt;<a href=3D"mailto:drjones@redhat.com">drjones@redhat.com</a>&gt; wrot=
e:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Tue, Aug 11, 2020 at 10:38:02AM +0800, Haibo Xu wrote:<br>
&gt; On Mon, 10 Aug 2020 at 19:05, Andrew Jones &lt;<a href=3D"mailto:drjon=
es@redhat.com" target=3D"_blank">drjones@redhat.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; On Fri, Aug 07, 2020 at 08:10:36AM +0000, Haibo Xu wrote:<br>
&gt; &gt; &gt; Add a virtual SPE device for virt machine while using PPI<br=
>
&gt; &gt; &gt; 5 for SPE overflow interrupt number.<br>
&gt; &gt;<br>
&gt; &gt; Any reason PPI 5 was selected?<br>
&gt; &gt;<br>
&gt; <br>
&gt; No special reason to choose PPI 5. Just re-use the setting in kvmtool.=
<br>
<br>
Please write in the commit message that kvmtool has already selected PPI 5<=
br>
for this purpose.<br></blockquote><div><br></div><div>Ok, will fix it.</div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; &gt; &gt; +=C2=A0 =C2=A0 fdt_add_spe_nodes(vms);<br>
&gt; &gt; &gt; +<br>
&gt; &gt;<br>
&gt; &gt; You didn&#39;t add any compat code, which means all virt machine =
types are now<br>
&gt; &gt; getting an SPE FDT node, ACPI table change, and, most importantly=
, PPI 5<br>
&gt; &gt; has gone from unallocated to allocated. We definitely need compat=
 code.<br>
&gt; &gt;<br>
&gt; <br>
&gt; So the &#39;compat code&#39; here means to only add the SPE node in KV=
M mode?<br>
<br>
No, it means only add it for the 5.2 and later machine types. You&#39;ll se=
e<br>
what I mean when you study the patchset I pointed out, which is also only<b=
r>
for 5.2 and later machine types.<br></blockquote><div><br></div><div>Ok, th=
anks for the clarification!</div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (switched_level &amp; KVM_AR=
M_DEV_SPE) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(cpu-=
&gt;spe_interrupt,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!!(run-&gt;s.regs.device_irq_level &amp; KVM=
_ARM_DEV_SPE));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switched_level &a=
mp;=3D ~KVM_ARM_DEV_SPE;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +<br>
&gt; &gt;<br>
&gt; &gt; Did you test with a userspace irqchip?<br>
&gt; <br>
&gt; No, I just tested with an in-kernel irqchip.<br>
&gt; Actually, the current kernel vSPE patch doesn&#39;t support a userspac=
e irqchip.<br>
&gt; AFAIK, the userspace irqchip support should be ready in the next<br>
&gt; kernel patch series<br>
&gt; which will be sent out for review in the middle of September.<br>
<br>
It probably doesn&#39;t hurt to do the above hunk already, hoping it will j=
ust<br>
work when it&#39;s possible to test, but I generally prefer only adding tes=
ted<br>
code. Maybe this hunk should be a separate patch with a commit message<br>
explaining that it&#39;s untested?<br></blockquote><div><br></div><div>Good=
 idea! I will drop the hunk in this series, and send out a separate patch t=
o enable it</div><div>once the kernel support is ready!</div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
Thanks,<br>
drew<br>
<br>
</blockquote></div></div>

--00000000000064061505aca37879--

