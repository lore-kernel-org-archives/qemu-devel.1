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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BD0C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:58:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74F9922249
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGADzQb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F9922249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVb7F-0007od-Dr
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 09:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1kVb3v-0004fJ-Vn
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 09:55:28 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:33578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1kVb3r-0007g2-Ml
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 09:55:25 -0400
Received: by mail-il1-x143.google.com with SMTP id j8so1811281ilk.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 06:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rsQE9mGTtLLqOBRx2J0ZWQOWAWuInwkOiR8hb+gl3e4=;
 b=XGADzQb8ZHWKHkbcmJg6KNt0HrOnEuKUUwfvUiWuoQVd6t180Wv0xQRtSLfnJnl1ta
 G2opNFwdycYav1eAhiVh2ioCIPVmtHhIksmbdNBGt8n2EPH8ZS49Ai8Lp8x/3DMd0oNw
 vrU8QBGu1xzQFgiMQ3pAARuF2fJdN81nA9+98w5iwh6I2jpV8V/h3Gr6i1y8t8NapCpa
 n+ef45NxQMdlAURkwsEwny3YVpgs/YglDR6HpFFrT4WTe7MgnjT+j9hgV94/PGurj5iP
 CUi1aoT6X+/17Oyh4CjIPp1NV+bfBOQyrmMx/7fPPeQLckeCzmkKHI7Ruq9a2OaAUDaA
 5IJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rsQE9mGTtLLqOBRx2J0ZWQOWAWuInwkOiR8hb+gl3e4=;
 b=iDGO7TQ/bBveE4O6Ey3cCSYxbeKFNhkjPMhU/l6cWLPk+SzPNV8b+S9ct0jKAtcSzF
 At1FLcgUadFs8PmnaSevARX/fr4tO9V2XkhI8hCR67FmpQQSIf1P4KR8SFtoRGvZVfDG
 /TcFHdnTj+W0bXAumvebMjeQDWnaqDcICOR5+TbF/5H68s9/dvKJjMP3Jx9hrYOIeLrz
 zA5p5Sw8/0soB1JqmAdOiUC2fufd5sF0z4WzUTS75TJbWEsTOfGylsMt/oG/EGfrtIBQ
 wbz/PuZKQkPim29AXcepdUpJxshbnMqLC0rkC2FE1xsyYxUPkcNY4atKgeTmImWem17m
 q4wg==
X-Gm-Message-State: AOAM530sHESD274mkBduA/g7l+HDcx3i7AUgRw2yQtR4jwGy2pOhcFJp
 0HBq5ZtCKrP3GxWYefZi+XJhhjbQQZFjJOHStL0=
X-Google-Smtp-Source: ABdhPJwwFUbCmIevaf5jJv104jI333iLJB1bzd2e8Ij8+qPhbc02e5pl8oso/AwXfnsHhEJBwacgeQ2Hh8IgnY4wFfY=
X-Received: by 2002:a92:c94b:: with SMTP id i11mr1800375ilq.149.1603374920966; 
 Thu, 22 Oct 2020 06:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201022114026.31968-1-marcel.apfelbaum@gmail.com>
 <20201022080354-mutt-send-email-mst@kernel.org>
 <20201022235632.7f69ddc9@yekko.fritz.box>
In-Reply-To: <20201022235632.7f69ddc9@yekko.fritz.box>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Thu, 22 Oct 2020 16:55:10 +0300
Message-ID: <CAC_L=vVi6ngD6j0sZ2uLZ-NHF2WGzKfiOvmsHxOZaBRv6FuBug@mail.gmail.com>
Subject: Re: [PATCH] pci: Refuse to hotplug PCI Devices when the Guest OS is
 not ready
To: David Gibson <dgibson@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009b26fa05b242d029"
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
Cc: Julia Suvorova <jusual@redhat.com>, qemu devel list <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009b26fa05b242d029
Content-Type: text/plain; charset="UTF-8"

Hi David, Michael,

On Thu, Oct 22, 2020 at 3:56 PM David Gibson <dgibson@redhat.com> wrote:

> On Thu, 22 Oct 2020 08:06:55 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
> > On Thu, Oct 22, 2020 at 02:40:26PM +0300, Marcel Apfelbaum wrote:
> > > From: Marcel Apfelbaum <marcel@redhat.com>
> > >
> > > During PCIe Root Port's transition from Power-Off to Power-ON (or
> vice-versa)
> > > the "Slot Control Register" has the "Power Indicator Control"
> > > set to "Blinking" expressing a "power transition" mode.
> > >
> > > Any hotplug operation during the "power transition" mode is not
> permitted
> > > or at least not expected by the Guest OS leading to strange failures.
> > >
> > > Detect and refuse hotplug operations in such case.
> > >
> > > Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > > ---
> > >  hw/pci/pcie.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > > index 5b48bae0f6..2fe5c1473f 100644
> > > --- a/hw/pci/pcie.c
> > > +++ b/hw/pci/pcie.c
> > > @@ -410,6 +410,7 @@ void pcie_cap_slot_pre_plug_cb(HotplugHandler
> *hotplug_dev, DeviceState *dev,
> > >      PCIDevice *hotplug_pdev = PCI_DEVICE(hotplug_dev);
> > >      uint8_t *exp_cap = hotplug_pdev->config +
> hotplug_pdev->exp.exp_cap;
> > >      uint32_t sltcap = pci_get_word(exp_cap + PCI_EXP_SLTCAP);
> > > +    uint32_t sltctl = pci_get_word(exp_cap + PCI_EXP_SLTCTL);
> > >
> > >      /* Check if hot-plug is disabled on the slot */
> > >      if (dev->hotplugged && (sltcap & PCI_EXP_SLTCAP_HPC) == 0) {
> > > @@ -418,6 +419,12 @@ void pcie_cap_slot_pre_plug_cb(HotplugHandler
> *hotplug_dev, DeviceState *dev,
> > >          return;
> > >      }
> > >
> > > +    if ((sltctl & PCI_EXP_SLTCTL_PIC) ==
> PCI_EXP_SLTCTL_PWR_IND_BLINK) {
> > > +        error_setg(errp, "Hot-plug failed: %s is in Power Transition",
> > > +                   DEVICE(hotplug_pdev)->id);
> > > +        return;
> > > +    }
> > > +
> > >      pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, errp);
> > >  }
> >
> > Probably the only way to handle for existing machine types.
>

I agree


> > For new ones, can't we queue it in host memory somewhere?
>
>
I am not sure I understand what will be the flow.
  - The user asks for a hotplug operation.
  -  QEMU deferred operation.
After that the operation may still fail, how would the user know if the
operation
succeeded or not?



> I'm not actually convinced we can't do that even for existing machine
> types.


Is a Guest visible change, I don't think we can do it.


> So I'm a bit hesitant to suggest going ahead with this without
> looking a bit closer at whether we can implement a wait-for-ready in
> qemu, rather than forcing every user of qemu (human or machine) to do
> so.
>

While I agree it is a pain from the usability point of view, hotplug
operations
are allowed to fail. This is not more than a corner case, ensuring the right
response (gracefully erroring out) may be enough.

Thanks,
Marcel



>
>
> --
> David Gibson <dgibson@redhat.com>
> Principal Software Engineer, Virtualization, Red Hat
>

--0000000000009b26fa05b242d029
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi David, Michael,</div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 22, 2020 at=
 3:56 PM David Gibson &lt;<a href=3D"mailto:dgibson@redhat.com">dgibson@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">On Thu, 22 Oct 2020 08:06:55 -0400<br>
&quot;Michael S. Tsirkin&quot; &lt;<a href=3D"mailto:mst@redhat.com" target=
=3D"_blank">mst@redhat.com</a>&gt; wrote:<br>
<br>
&gt; On Thu, Oct 22, 2020 at 02:40:26PM +0300, Marcel Apfelbaum wrote:<br>
&gt; &gt; From: Marcel Apfelbaum &lt;<a href=3D"mailto:marcel@redhat.com" t=
arget=3D"_blank">marcel@redhat.com</a>&gt;<br>
&gt; &gt; <br>
&gt; &gt; During PCIe Root Port&#39;s transition from Power-Off to Power-ON=
 (or vice-versa)<br>
&gt; &gt; the &quot;Slot Control Register&quot; has the &quot;Power Indicat=
or Control&quot;<br>
&gt; &gt; set to &quot;Blinking&quot; expressing a &quot;power transition&q=
uot; mode.<br>
&gt; &gt; <br>
&gt; &gt; Any hotplug operation during the &quot;power transition&quot; mod=
e is not permitted<br>
&gt; &gt; or at least not expected by the Guest OS leading to strange failu=
res.<br>
&gt; &gt; <br>
&gt; &gt; Detect and refuse hotplug operations in such case.<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Marcel Apfelbaum &lt;<a href=3D"mailto:marcel.apfe=
lbaum@gmail.com" target=3D"_blank">marcel.apfelbaum@gmail.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 hw/pci/pcie.c | 7 +++++++<br>
&gt; &gt;=C2=A0 1 file changed, 7 insertions(+)<br>
&gt; &gt; <br>
&gt; &gt; diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c<br>
&gt; &gt; index 5b48bae0f6..2fe5c1473f 100644<br>
&gt; &gt; --- a/hw/pci/pcie.c<br>
&gt; &gt; +++ b/hw/pci/pcie.c<br>
&gt; &gt; @@ -410,6 +410,7 @@ void pcie_cap_slot_pre_plug_cb(HotplugHandler=
 *hotplug_dev, DeviceState *dev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 PCIDevice *hotplug_pdev =3D PCI_DEVICE(hotplu=
g_dev);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 uint8_t *exp_cap =3D hotplug_pdev-&gt;config =
+ hotplug_pdev-&gt;exp.exp_cap;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 uint32_t sltcap =3D pci_get_word(exp_cap + PC=
I_EXP_SLTCAP);<br>
&gt; &gt; +=C2=A0 =C2=A0 uint32_t sltctl =3D pci_get_word(exp_cap + PCI_EXP=
_SLTCTL);<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* Check if hot-plug is disabled on the slot =
*/<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (dev-&gt;hotplugged &amp;&amp; (sltcap &am=
p; PCI_EXP_SLTCAP_HPC) =3D=3D 0) {<br>
&gt; &gt; @@ -418,6 +419,12 @@ void pcie_cap_slot_pre_plug_cb(HotplugHandle=
r *hotplug_dev, DeviceState *dev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt; +=C2=A0 =C2=A0 if ((sltctl &amp; PCI_EXP_SLTCTL_PIC) =3D=3D PCI_E=
XP_SLTCTL_PWR_IND_BLINK) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Hot-plug fail=
ed: %s is in Power Transition&quot;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0DEVICE(hotplug_pdev)-&gt;id);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_=
dev), dev, errp);<br>
&gt; &gt;=C2=A0 }=C2=A0 <br>
&gt; <br>
&gt; Probably the only way to handle for existing machine types.<br></block=
quote><div><br></div><div>I agree</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
&gt; For new ones, can&#39;t we queue it in host memory somewhere?<br>
<br></blockquote><div><br></div><div>I am not sure I understand what will b=
e the flow.</div><div>=C2=A0 - The user asks for a hotplug operation.</div>=
<div>=C2=A0 -=C2=A0 QEMU deferred operation.</div><div>After that the opera=
tion may still fail, how would the user know if the operation</div><div>suc=
ceeded or not?</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
I&#39;m not actually convinced we can&#39;t do that even for existing machi=
ne<br>
types.=C2=A0</blockquote><div><br></div><div>Is a Guest visible change, I d=
on&#39;t think we can do it.</div><div>=C2=A0<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex"> So I&#39;m a bit hesitant to suggest going a=
head with this without<br>
looking a bit closer at whether we can implement a wait-for-ready in<br>
qemu, rather than forcing every user of qemu (human or machine) to do<br>
so.<br></blockquote><div><br></div><div>While I agree it is a pain from the=
 usability point of view, hotplug operations</div><div>are allowed to fail.=
 This is not more than a corner case, ensuring the right</div><div>response=
 (gracefully erroring out) may be enough.</div><div><br></div><div>Thanks,<=
/div><div>Marcel</div><div><br></div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
<br>
<br>
-- <br>
David Gibson &lt;<a href=3D"mailto:dgibson@redhat.com" target=3D"_blank">dg=
ibson@redhat.com</a>&gt;<br>
Principal Software Engineer, Virtualization, Red Hat<br>
</blockquote></div></div>

--0000000000009b26fa05b242d029--

