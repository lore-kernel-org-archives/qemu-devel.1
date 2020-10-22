Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0262C388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:14:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C792225F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uxVoHyLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C792225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVbLw-0000oj-Ed
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 10:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1kVbIw-00073W-7E
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:10:58 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:38152)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1kVbIt-0001Ax-To
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:10:57 -0400
Received: by mail-il1-x143.google.com with SMTP id p16so1839982ilq.5
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 07:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MOBwWVavda0zEYipVeHQ0WdRx3hhrWSJEVcdxmE1a/U=;
 b=uxVoHyLlNVH1NxTBEwlJzGOusMQvcVeeAm7LURfSHjCT/lAUwCRKPrsnJw+ulhAc+w
 0XwyURO89BTK5DixL9n7fRBU90FctT4s9KimWVs0yBFvManKpvngXop8D8GOUb6Kcam2
 c+RMdV7ubmeA5CseAD4leF3Apu5he81+v7biagMy3PaqENzK2TaL+7YR3tSC7m+b0Ga0
 SZcf0YHiKtRz5dQxjP816Bd/I55WNBO37WvYORTj5IcLWO/SC2GNXS4hbhe6qbm/p/SO
 nCR2SzK8G8uUs65kqOsEwnAIS2+7FGGOnuSKmGYScZ9I5fGOavqpWM8vH0XB4AkH1wIU
 dRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MOBwWVavda0zEYipVeHQ0WdRx3hhrWSJEVcdxmE1a/U=;
 b=eLk72wBCza0D6V/jMoObEwFTcD4z9cfv+zFas6/oHpSG487MP+kKBuGMa2Ij/3lPDf
 speK45tr1C2ioaF5bqbW3/ntn1n1Q5gMIOk9N9MDe/bBjyC0tfpT2sX8FT+/dCWzayUX
 /fA0Yu13caMsO/7KSWsIypuRGxNUBW1D9rttiEvwO0K9H7fKho0XFsrtToTxhpMZadtO
 rNX7TEji1K5cSYDey5RypRmRnOtLh/d/EN1yE4r5EU/1+joVMdUgG0wEkAAG/MEJwfnX
 q/uxQCPxUfGH8Chbm+0678JQC0qKrPKRpakZBcAw8LD3h0p8anwUeR+BwVvZ8huNDpPJ
 VHTg==
X-Gm-Message-State: AOAM531sIBzD9r16n8cGT8CBgEwOxMTROA9hcrROhB5obdj5XTaKMeWJ
 fSyiMw2F2r5/wZw1PrbEy2hMAsBiSi/7xBQnujGC2U8/drA=
X-Google-Smtp-Source: ABdhPJwrfvv66ppwD2dF7W/iexNWrjcFC3jaF119fx7YiQ0aXobw/Z9Kr+WYTKcfvzsYpp2pMCknOa/sDoubhWZPw/E=
X-Received: by 2002:a92:858d:: with SMTP id f135mr2077840ilh.197.1603375854837; 
 Thu, 22 Oct 2020 07:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20201022114026.31968-1-marcel.apfelbaum@gmail.com>
 <20201022080354-mutt-send-email-mst@kernel.org>
 <20201022235632.7f69ddc9@yekko.fritz.box>
 <CAC_L=vVi6ngD6j0sZ2uLZ-NHF2WGzKfiOvmsHxOZaBRv6FuBug@mail.gmail.com>
 <20201022100028-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201022100028-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Thu, 22 Oct 2020 17:10:43 +0300
Message-ID: <CAC_L=vWctLK0Yjod_Vz=+xzFKFp4UoUdjSVa4jWeDm+g8en6wQ@mail.gmail.com>
Subject: Re: [PATCH] pci: Refuse to hotplug PCI Devices when the Guest OS is
 not ready
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000044e33405b2430871"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=marcel.apfelbaum@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: David Gibson <dgibson@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000044e33405b2430871
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 22, 2020 at 5:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Thu, Oct 22, 2020 at 04:55:10PM +0300, Marcel Apfelbaum wrote:
> > Hi David, Michael,
> >
> > On Thu, Oct 22, 2020 at 3:56 PM David Gibson <dgibson@redhat.com> wrote:
> >
> >     On Thu, 22 Oct 2020 08:06:55 -0400
> >     "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >
> >     > On Thu, Oct 22, 2020 at 02:40:26PM +0300, Marcel Apfelbaum wrote:
> >     > > From: Marcel Apfelbaum <marcel@redhat.com>
> >     > >
> >     > > During PCIe Root Port's transition from Power-Off to Power-ON (or
> >     vice-versa)
> >     > > the "Slot Control Register" has the "Power Indicator Control"
> >     > > set to "Blinking" expressing a "power transition" mode.
> >     > >
> >     > > Any hotplug operation during the "power transition" mode is not
> >     permitted
> >     > > or at least not expected by the Guest OS leading to strange
> failures.
> >     > >
> >     > > Detect and refuse hotplug operations in such case.
> >     > >
> >     > > Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> >     > > ---
> >     > >  hw/pci/pcie.c | 7 +++++++
> >     > >  1 file changed, 7 insertions(+)
> >     > >
> >     > > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> >     > > index 5b48bae0f6..2fe5c1473f 100644
> >     > > --- a/hw/pci/pcie.c
> >     > > +++ b/hw/pci/pcie.c
> >     > > @@ -410,6 +410,7 @@ void pcie_cap_slot_pre_plug_cb(HotplugHandler
> >     *hotplug_dev, DeviceState *dev,
> >     > >      PCIDevice *hotplug_pdev = PCI_DEVICE(hotplug_dev);
> >     > >      uint8_t *exp_cap = hotplug_pdev->config + hotplug_pdev->
> >     exp.exp_cap;
> >     > >      uint32_t sltcap = pci_get_word(exp_cap + PCI_EXP_SLTCAP);
> >     > > +    uint32_t sltctl = pci_get_word(exp_cap + PCI_EXP_SLTCTL);
> >     > >
> >     > >      /* Check if hot-plug is disabled on the slot */
> >     > >      if (dev->hotplugged && (sltcap & PCI_EXP_SLTCAP_HPC) == 0) {
> >     > > @@ -418,6 +419,12 @@ void
> pcie_cap_slot_pre_plug_cb(HotplugHandler
> >     *hotplug_dev, DeviceState *dev,
> >     > >          return;
> >     > >      }
> >     > >
> >     > > +    if ((sltctl & PCI_EXP_SLTCTL_PIC) ==
> PCI_EXP_SLTCTL_PWR_IND_BLINK)
> >     {
> >     > > +        error_setg(errp, "Hot-plug failed: %s is in Power
> Transition",
> >     > > +                   DEVICE(hotplug_pdev)->id);
> >     > > +        return;
> >     > > +    }
> >     > > +
> >     > >      pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev,
> errp);
> >     > >  }
> >     >
> >     > Probably the only way to handle for existing machine types.
> >
> >
> > I agree
> >
> >
> >     > For new ones, can't we queue it in host memory somewhere?
> >
> >
> >
> > I am not sure I understand what will be the flow.
> >   - The user asks for a hotplug operation.
> >   -  QEMU deferred operation.
> > After that the operation may still fail, how would the user know if the
> > operation
> > succeeded or not?
>
>
> How can it fail? It's just a button press ...
>
>
Currently we have "Hotplug unsupported."
With this change we have "Guest/System not ready"



> >
> >
> >     I'm not actually convinced we can't do that even for existing machine
> >     types.
> >
> >
> > Is a Guest visible change, I don't think we can do it.
> >
> >
> >     So I'm a bit hesitant to suggest going ahead with this without
> >     looking a bit closer at whether we can implement a wait-for-ready in
> >     qemu, rather than forcing every user of qemu (human or machine) to do
> >     so.
> >
> >
> > While I agree it is a pain from the usability point of view, hotplug
> operations
> > are allowed to fail. This is not more than a corner case, ensuring the
> right
> > response (gracefully erroring out) may be enough.
> >
> > Thanks,
> > Marcel
> >
>
>
> I don't think they ever failed in the past so management is unlikely
> to handle the failure by retrying ...
>

That would require some management handling, yes.
But even without a "retry", failing is better than strange OS behavior.

Trying a better alternative like deferring the operation for new machines
would make sense, however is out of the scope of this patch that simply
detects the error leaving us in a slightly better state than today.

Thanks,
Marcel


>
> >
> >
> >
> >     --
> >     David Gibson <dgibson@redhat.com>
> >     Principal Software Engineer, Virtualization, Red Hat
> >
>
>

--00000000000044e33405b2430871
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 22, 2020 at 5:01 PM Micha=
el S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, O=
ct 22, 2020 at 04:55:10PM +0300, Marcel Apfelbaum wrote:<br>
&gt; Hi David, Michael,<br>
&gt; <br>
&gt; On Thu, Oct 22, 2020 at 3:56 PM David Gibson &lt;<a href=3D"mailto:dgi=
bson@redhat.com" target=3D"_blank">dgibson@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Thu, 22 Oct 2020 08:06:55 -0400<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;Michael S. Tsirkin&quot; &lt;<a href=3D"mailt=
o:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; On Thu, Oct 22, 2020 at 02:40:26PM +0300, Marc=
el Apfelbaum wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; From: Marcel Apfelbaum &lt;<a href=3D"mai=
lto:marcel@redhat.com" target=3D"_blank">marcel@redhat.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; During PCIe Root Port&#39;s transition fr=
om Power-Off to Power-ON (or<br>
&gt;=C2=A0 =C2=A0 =C2=A0vice-versa)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; the &quot;Slot Control Register&quot; has=
 the &quot;Power Indicator Control&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; set to &quot;Blinking&quot; expressing a =
&quot;power transition&quot; mode.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; Any hotplug operation during the &quot;po=
wer transition&quot; mode is not<br>
&gt;=C2=A0 =C2=A0 =C2=A0permitted<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; or at least not expected by the Guest OS =
leading to strange failures.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; Detect and refuse hotplug operations in s=
uch case.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; Signed-off-by: Marcel Apfelbaum &lt;<a hr=
ef=3D"mailto:marcel.apfelbaum@gmail.com" target=3D"_blank">marcel.apfelbaum=
@gmail.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 hw/pci/pcie.c | 7 +++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 1 file changed, 7 insertions(+)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; diff --git a/hw/pci/pcie.c b/hw/pci/pcie.=
c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; index 5b48bae0f6..2fe5c1473f 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; --- a/hw/pci/pcie.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +++ b/hw/pci/pcie.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; @@ -410,6 +410,7 @@ void pcie_cap_slot_pr=
e_plug_cb(HotplugHandler<br>
&gt;=C2=A0 =C2=A0 =C2=A0*hotplug_dev, DeviceState *dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0 PCIDevice *hotplug_pd=
ev =3D PCI_DEVICE(hotplug_dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0 uint8_t *exp_cap =3D =
hotplug_pdev-&gt;config + hotplug_pdev-&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0exp.exp_cap;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0 uint32_t sltcap =3D p=
ci_get_word(exp_cap + PCI_EXP_SLTCAP);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +=C2=A0 =C2=A0 uint32_t sltctl =3D pci_ge=
t_word(exp_cap + PCI_EXP_SLTCTL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* Check if hot-plug =
is disabled on the slot */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (dev-&gt;hotplugge=
d &amp;&amp; (sltcap &amp; PCI_EXP_SLTCAP_HPC) =3D=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; @@ -418,6 +419,12 @@ void pcie_cap_slot_p=
re_plug_cb(HotplugHandler<br>
&gt;=C2=A0 =C2=A0 =C2=A0*hotplug_dev, DeviceState *dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +=C2=A0 =C2=A0 if ((sltctl &amp; PCI_EXP_=
SLTCTL_PIC) =3D=3D PCI_EXP_SLTCTL_PWR_IND_BLINK)<br>
&gt;=C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(e=
rrp, &quot;Hot-plug failed: %s is in Power Transition&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DEVICE(hotplug_pdev)-&gt;id);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0 pcie_cap_slot_plug_co=
mmon(PCI_DEVICE(hotplug_dev), dev, errp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 }=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Probably the only way to handle for existing m=
achine types.<br>
&gt; <br>
&gt; <br>
&gt; I agree<br>
&gt; =C2=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; For new ones, can&#39;t we queue it in host me=
mory somewhere?<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; I am not sure I understand what will be the flow.<br>
&gt; =C2=A0 - The user asks for a hotplug operation.<br>
&gt; =C2=A0 -=C2=A0 QEMU deferred operation.<br>
&gt; After that the operation may still fail, how would the user know if th=
e<br>
&gt; operation<br>
&gt; succeeded or not?<br>
<br>
<br>
How can it fail? It&#39;s just a button press ...<br>
<br></blockquote><div><br></div><div>Currently we have &quot;Hotplug unsupp=
orted.&quot;</div><div>With this change we have &quot;Guest/System not read=
y&quot;</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
&gt; =C2=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I&#39;m not actually convinced we can&#39;t do that=
 even for existing machine<br>
&gt;=C2=A0 =C2=A0 =C2=A0types.=C2=A0<br>
&gt; <br>
&gt; <br>
&gt; Is a Guest visible change, I don&#39;t think we can do it.<br>
&gt; =C2=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0So I&#39;m a bit hesitant to suggest going ahead wi=
th this without<br>
&gt;=C2=A0 =C2=A0 =C2=A0looking a bit closer at whether we can implement a =
wait-for-ready in<br>
&gt;=C2=A0 =C2=A0 =C2=A0qemu, rather than forcing every user of qemu (human=
 or machine) to do<br>
&gt;=C2=A0 =C2=A0 =C2=A0so.<br>
&gt; <br>
&gt; <br>
&gt; While I agree it is a pain from the usability point of view, hotplug o=
perations<br>
&gt; are allowed to fail. This is not more than a corner case, ensuring the=
 right<br>
&gt; response (gracefully erroring out) may be enough.<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Marcel<br>
&gt; <br>
<br>
<br>
I don&#39;t think they ever failed in the past so management is unlikely<br=
>
to handle the failure by retrying ...<br></blockquote><div><br></div><div>T=
hat would require some management handling, yes.</div><div>But even without=
 a &quot;retry&quot;, failing=C2=A0is better than strange OS behavior.</div=
><div><br></div><div>Trying a better alternative like deferring the operati=
on for new machines<br></div><div>would make sense, however is out of the s=
cope of this patch that simply</div><div>detects the error leaving us in a =
slightly better state than today.</div><div><br></div><div>Thanks,</div><di=
v>Marcel</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0--<br>
&gt;=C2=A0 =C2=A0 =C2=A0David Gibson &lt;<a href=3D"mailto:dgibson@redhat.c=
om" target=3D"_blank">dgibson@redhat.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Principal Software Engineer, Virtualization, Red Ha=
t<br>
&gt; <br>
<br>
</blockquote></div></div>

--00000000000044e33405b2430871--

