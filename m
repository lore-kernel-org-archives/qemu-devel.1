Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51590C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D31420776
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QhQ5hde1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D31420776
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmyE-0004nb-DJ
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 01:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jlmtm-0005mb-TO
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 01:15:38 -0400
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44]:46683)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jlmtk-0002NC-PS
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 01:15:38 -0400
Received: by mail-vs1-xe44.google.com with SMTP id k13so2772592vsm.13
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 22:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cRkXtAZzmD7NnofcJ9cEx2DKzDMxZP3NojzrQ5SZjF4=;
 b=QhQ5hde1wf/YZMVzWZLuY5da6qNVSu4et2a4KCRfXkEx3dIh5dw1oioSl+xO/1dAA1
 F57k4mheWusCAexCzcC/+QbwTpYgrmog6EX6OPnFJBEvkIhCtLUXa4tKUfxIlzdYHhuG
 wFS/rFMkJ4CaZZIt0XMYcsD5BjGXEdhVqg1+8LnpX/sDC1IeQspgZL7IlFz24bQVEISo
 yfOt7nbIWHyOZ8nROmf5JlTvsA45qYn4QUq/NJwcXuPh12uQQeKX3baHDnxjNxD6N4nl
 gHVPOkPwi9EOqJhhVk3z8fJkVs46kxI4A2So6X6seMNSTBekd8xgkHkAGiyI2ulh51Se
 w9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cRkXtAZzmD7NnofcJ9cEx2DKzDMxZP3NojzrQ5SZjF4=;
 b=NTM4JFk7PjOw3nlK60JcrY/ugB5cS2i8kjpDDNo/4nqlP98mKdkpKvIs7/e1sXP+68
 90+WwEmztc3mDSmzOw1/cJFRKmFS+gEVwzYGzQGmxGlABfRYG9s9l8Q5pLUCseLf5RJV
 BqOvYRzpEl2bHzfemJ42MMPLXp+9JUO6zqcUhz+YUoQ1jG9gIol63gNmaKQMowPPgVHe
 uUAdM94+ttNqIfC6cXtSjPChXLnKhA72Z6uq8fFdf4MRLoWms7CG5DPq7VyYnBdwGp/p
 8OlLR1TLdcnysTyFflUaF9vicSuSEcVyHfVClgar2mEWG8Hn91hYCnr16tchiHrBu6Aw
 03aw==
X-Gm-Message-State: AOAM532FonPwEssxk1UZs9VZnKnheSYB7VoYEXVhiCc3DfX+skLUc/B2
 k1kXz4V0XBTRGkyKQTmX2fKgUuveU09SkrObPQczBQ==
X-Google-Smtp-Source: ABdhPJxLFGDqZYcMX5N/oCteRNaVJEDMTNUZ4ovj+ux50RziH5wPtyhC+CcQZtT3OC5juj8P+vXyKU87JBMm+26ZkNY=
X-Received: by 2002:a67:ad16:: with SMTP id t22mr1960651vsl.152.1592457332343; 
 Wed, 17 Jun 2020 22:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200611223016.259837-1-hskinnemoen@google.com>
 <49cf918e-7c03-8e51-6080-a136ad25ba0e@kaod.org>
In-Reply-To: <49cf918e-7c03-8e51-6080-a136ad25ba0e@kaod.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Wed, 17 Jun 2020 22:15:20 -0700
Message-ID: <CAFQmdRbJsAT19QBMiS3BRpiDTWdUL5MocazsvH1FkkPo5eZ7tA@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] Add Nuvoton NPCM730/NPCM750 SoCs and two BMC
 machines
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, 
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>,
 CS20 KFTing <kfting@nuvoton.com>
Content-Type: multipart/alternative; boundary="0000000000009df81405a854dddd"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e44;
 envelope-from=hskinnemoen@google.com; helo=mail-vs1-xe44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001,
 USER_IN_DEF_DKIM_WL=-7.5, USER_IN_DEF_SPF_WL=-7.5 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009df81405a854dddd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2020 at 8:54 AM C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> Hello,
>
> On 6/12/20 12:30 AM, Havard Skinnemoen wrote:
> > This patch series models enough of the Nuvoton NPCM730 and NPCM750 SoCs
> to boot
> > an OpenBMC image built for quanta-gsj. This includes device models for:
> >
> >   - Global Configuration Registers
> >   - Clock Control
> >   - Timers
> >   - Fuses
> >   - Memory Controller
> >   - Flash Controller
>
> Do you have a git tree for this patchset ?
>

Yes, but nothing public. I can set up a github fork if you want.


> > These modules, along with the existing Cortex A9 CPU cores and built-in
> > peripherals, are integrated into a NPCM730 or NPCM750 SoC, which in tur=
n
> form
> > the foundation for the quanta-gsj and npcm750-evb machines,
> respectively. The
> > two SoCs are very similar; the only difference is that NPCM730 is
> missing some
> > peripherals that NPCM750 has, and which are not considered essential fo=
r
> > datacenter use (e.g. graphics controllers). For more information, see
> >
> > https://www.nuvoton.com/products/cloud-computing/ibmc/
> >
> > Both quanta-gsj and npcm750-evb correspond to real boards supported by
> OpenBMC.
> > While this initial series uses a stripped-down kernel for testing, futu=
re
> > series will be tested using OpenBMC images built from public sources. I=
'm
> > currently putting the finishing touches on flash controller support,
> which is
> > necessary to boot a full OpenBMC image, and will be enabled by the next
> series.
>
> ok.
>
> It would be nice to be able to download the images from some site
> like we do for Aspeed.
>

It looks like Joel got this covered for gsj. I'll look into
setting something up for npcm750-evb.


>
> > The patches in this series were developed by Google and reviewed by
> Nuvoton. We
> > will be maintaining the machine and peripheral support together.
> >
> > The data sheet for these SoCs is not generally available. Please let me
> know if
> > more comments are needed to understand the device behavior.
> >
> > Changes since v1 (requested by reviewers):
> >
> >   - Clarify the source of CLK reset values.
> >   - Made smpboot a constant byte array, eliinated byte swapping.
>
> I have revived a PPC64 host. We might want to add the swapping back.
>

OK.

Havard

--0000000000009df81405a854dddd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Wed, Jun 17, 2020 at 8:54 AM C=C3=A9dr=
ic Le Goater &lt;<a href=3D"mailto:clg@kaod.org">clg@kaod.org</a>&gt; wrote=
:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">Hello,<br>
<br>
On 6/12/20 12:30 AM, Havard Skinnemoen wrote:<br>
&gt; This patch series models enough of the Nuvoton NPCM730 and NPCM750 SoC=
s to boot<br>
&gt; an OpenBMC image built for quanta-gsj. This includes device models for=
:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0- Global Configuration Registers<br>
&gt;=C2=A0 =C2=A0- Clock Control<br>
&gt;=C2=A0 =C2=A0- Timers<br>
&gt;=C2=A0 =C2=A0- Fuses<br>
&gt;=C2=A0 =C2=A0- Memory Controller<br>
&gt;=C2=A0 =C2=A0- Flash Controller<br>
<br>
Do you have a git tree for this patchset ? <br></blockquote><div><br></div>=
<div>Yes, but nothing public. I can set up a github fork if you want.</div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; These modules, along with the existing Cortex A9 CPU cores and built-i=
n<br>
&gt; peripherals, are integrated into a NPCM730 or NPCM750 SoC, which in tu=
rn form<br>
&gt; the foundation for the quanta-gsj and npcm750-evb machines, respective=
ly. The<br>
&gt; two SoCs are very similar; the only difference is that NPCM730 is miss=
ing some<br>
&gt; peripherals that NPCM750 has, and which are not considered essential f=
or<br>
&gt; datacenter use (e.g. graphics controllers). For more information, see<=
br>
&gt; <br>
&gt; <a href=3D"https://www.nuvoton.com/products/cloud-computing/ibmc/" rel=
=3D"noreferrer" target=3D"_blank" class=3D"cremed">https://www.nuvoton.com/=
products/cloud-computing/ibmc/</a><br>
&gt; <br>
&gt; Both quanta-gsj and npcm750-evb correspond to real boards supported by=
 OpenBMC.<br>
&gt; While this initial series uses a stripped-down kernel for testing, fut=
ure<br>
&gt; series will be tested using OpenBMC images built from public sources. =
I&#39;m<br>
&gt; currently putting the finishing touches on flash controller support, w=
hich is<br>
&gt; necessary to boot a full OpenBMC image, and will be enabled by the nex=
t series.<br>
<br>
ok. <br>
<br>
It would be nice to be able to download the images from some site<br>
like we do for Aspeed.<br></blockquote><div><br></div><div>It looks like Jo=
el got this covered for gsj. I&#39;ll look into setting=C2=A0something up f=
or npcm750-evb.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
<br>
&gt; The patches in this series were developed by Google and reviewed by Nu=
voton. We<br>
&gt; will be maintaining the machine and peripheral support together.<br>
&gt; <br>
&gt; The data sheet for these SoCs is not generally available. Please let m=
e know if<br>
&gt; more comments are needed to understand the device behavior.<br>
&gt; <br>
&gt; Changes since v1 (requested by reviewers):<br>
&gt; <br>
&gt;=C2=A0 =C2=A0- Clarify the source of CLK reset values.<br>
&gt;=C2=A0 =C2=A0- Made smpboot a constant byte array, eliinated byte swapp=
ing.<br>
<br>
I have revived a PPC64 host. We might want to add the swapping back.<br></b=
lockquote><div><br></div><div>OK.</div><div><br></div><div>Havard</div></di=
v></div>

--0000000000009df81405a854dddd--

