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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB134C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:57:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCBB324630
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDdth634"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBB324630
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVc1f-0000w2-VH
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 10:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1kVbvm-00049I-Fq
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:51:06 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1kVbvk-0006pt-5B
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:51:06 -0400
Received: by mail-oi1-x241.google.com with SMTP id w141so2000174oia.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 07:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qtFpCcyrObpa0+W1Wnx5I7KUPfo1k8EBMZzq9sSGg0s=;
 b=WDdth634EBI7fxdQwKNp+PMshxSBHQ5jq/eZLXimHnAZqHHzw8nE+XGPxadWQQt8C4
 HqjL49RUlLj/jP8C7ShmLPzPc8DPu5Uf04cow2s9jxZMMuIoJf4mIJicIEi46LuNGc7h
 FDSVvQzIH8gpbmmJ5awhPDg1KEkHtwBlvvol6AsvioiLUiDyx2H8IIZsVXnYt1Q/8efP
 zVsnpCo3sIwshmbCq5abyyvTLamC5aDSH1szv3PUPurOQnF+BrzoXZd5EwmVVHixMyZK
 sl/bZb2nSgKlqQwxtURPq/84c5rmw7zA3z+CXD5nXeaTQHTEvyhIwkGb+5nqy32ccCi2
 kvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qtFpCcyrObpa0+W1Wnx5I7KUPfo1k8EBMZzq9sSGg0s=;
 b=N7m/26D0q8rmwfOQC+9OojUV8s3+nyChBRS/f+SHZ+IParNWy1idFGJndsyZjolV6I
 As0uEXO+FKowRYy8nVhggMPc4NNBobkmzO75jpw2X7jNljxkrQeo0xQlQtt5863BAYAM
 0cXWZQIsIZSyaYzIrjIrA+aYUrCQKAMT1/6KWtD7ui3MhAcbp7G994otlRQSkHUgl+CZ
 Qmnt3UC5xK0txVf73Amtkzpl5Xs5fZEXze42t+K4JJOWaHVmf3O0M4q/ZtrL8JpT+iUe
 75JFoC9vA3475Da2HtTYTmS7I1K7P2LVIgG8D7Dfr8rXUL3lRUQfazoyaebyIoZOIPhs
 y3IA==
X-Gm-Message-State: AOAM530VQmUHkJ8MVZ2hh88RdxbsrW0C508n+DE9VfWETFb9CGAwMpjZ
 lM125XuURl1KNilBz4x+6XqAF5cSVV7dPm1CFsDK0bhVq6g=
X-Google-Smtp-Source: ABdhPJx5GNHrOVrb4cCVn6W+skUOhbeJw6aojBSoWAHkectuxEQo5mZKPYKpz8RqaWRu9OsFRXUrfcugzxJPqsrwCN0=
X-Received: by 2002:aca:2b05:: with SMTP id i5mr1883078oik.57.1603378262648;
 Thu, 22 Oct 2020 07:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201022114026.31968-1-marcel.apfelbaum@gmail.com>
 <20201022080354-mutt-send-email-mst@kernel.org>
 <20201022235632.7f69ddc9@yekko.fritz.box>
 <CAC_L=vVi6ngD6j0sZ2uLZ-NHF2WGzKfiOvmsHxOZaBRv6FuBug@mail.gmail.com>
 <20201022100028-mutt-send-email-mst@kernel.org>
 <CAC_L=vWctLK0Yjod_Vz=+xzFKFp4UoUdjSVa4jWeDm+g8en6wQ@mail.gmail.com>
 <20201022102857-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201022102857-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Thu, 22 Oct 2020 17:50:51 +0300
Message-ID: <CAC_L=vX0+H-SfQHneVPd-Mc3wFxHBSbkKHt3SpNOBOY_JsYDUA@mail.gmail.com>
Subject: Re: [PATCH] pci: Refuse to hotplug PCI Devices when the Guest OS is
 not ready
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c92a8d05b24397fc"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=marcel.apfelbaum@gmail.com; helo=mail-oi1-x241.google.com
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

--000000000000c92a8d05b24397fc
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 22, 2020 at 5:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Thu, Oct 22, 2020 at 05:10:43PM +0300, Marcel Apfelbaum wrote:
> >
> >
> > On Thu, Oct 22, 2020 at 5:01 PM Michael S. Tsirkin <mst@redhat.com>
> wrote:
> >
> >     On Thu, Oct 22, 2020 at 04:55:10PM +0300, Marcel Apfelbaum wrote:
> >     > Hi David, Michael,
> >     >
> >     > On Thu, Oct 22, 2020 at 3:56 PM David Gibson <dgibson@redhat.com>
> wrote:
> >     >
> >     >     On Thu, 22 Oct 2020 08:06:55 -0400
> >     >     "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >     >
> >     >     > On Thu, Oct 22, 2020 at 02:40:26PM +0300, Marcel Apfelbaum
> wrote:
> >     >     > > From: Marcel Apfelbaum <marcel@redhat.com>
> >     >     > >
> >     >     > > During PCIe Root Port's transition from Power-Off to
> Power-ON (or
> >     >     vice-versa)
> >     >     > > the "Slot Control Register" has the "Power Indicator
> Control"
> >     >     > > set to "Blinking" expressing a "power transition" mode.
> >     >     > >
> >     >     > > Any hotplug operation during the "power transition" mode
> is not
> >     >     permitted
> >     >     > > or at least not expected by the Guest OS leading to strange
> >     failures.
> >     >     > >
> >     >     > > Detect and refuse hotplug operations in such case.
> >     >     > >
> >     >     > > Signed-off-by: Marcel Apfelbaum <
> marcel.apfelbaum@gmail.com>
> >     >     > > ---
> >     >     > >  hw/pci/pcie.c | 7 +++++++
> >     >     > >  1 file changed, 7 insertions(+)
> >     >     > >
> >     >     > > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> >     >     > > index 5b48bae0f6..2fe5c1473f 100644
> >     >     > > --- a/hw/pci/pcie.c
> >     >     > > +++ b/hw/pci/pcie.c
> >     >     > > @@ -410,6 +410,7 @@ void
> pcie_cap_slot_pre_plug_cb(HotplugHandler
> >     >     *hotplug_dev, DeviceState *dev,
> >     >     > >      PCIDevice *hotplug_pdev = PCI_DEVICE(hotplug_dev);
> >     >     > >      uint8_t *exp_cap = hotplug_pdev->config +
> hotplug_pdev->
> >     >     exp.exp_cap;
> >     >     > >      uint32_t sltcap = pci_get_word(exp_cap +
> PCI_EXP_SLTCAP);
> >     >     > > +    uint32_t sltctl = pci_get_word(exp_cap +
> PCI_EXP_SLTCTL);
> >     >     > >
> >     >     > >      /* Check if hot-plug is disabled on the slot */
> >     >     > >      if (dev->hotplugged && (sltcap & PCI_EXP_SLTCAP_HPC)
> == 0) {
> >     >     > > @@ -418,6 +419,12 @@ void pcie_cap_slot_pre_plug_cb
> >     (HotplugHandler
> >     >     *hotplug_dev, DeviceState *dev,
> >     >     > >          return;
> >     >     > >      }
> >     >     > >
> >     >     > > +    if ((sltctl & PCI_EXP_SLTCTL_PIC) ==
> >     PCI_EXP_SLTCTL_PWR_IND_BLINK)
> >     >     {
> >     >     > > +        error_setg(errp, "Hot-plug failed: %s is in Power
> >     Transition",
> >     >     > > +                   DEVICE(hotplug_pdev)->id);
> >     >     > > +        return;
> >     >     > > +    }
> >     >     > > +
> >     >     > >      pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev),
> dev,
> >     errp);
> >     >     > >  }
> >     >     >
> >     >     > Probably the only way to handle for existing machine types.
> >     >
> >     >
> >     > I agree
> >     >
> >     >
> >     >     > For new ones, can't we queue it in host memory somewhere?
> >     >
> >     >
> >     >
> >     > I am not sure I understand what will be the flow.
> >     >   - The user asks for a hotplug operation.
> >     >   -  QEMU deferred operation.
> >     > After that the operation may still fail, how would the user know
> if the
> >     > operation
> >     > succeeded or not?
> >
> >
> >     How can it fail? It's just a button press ...
> >
> >
> >
> > Currently we have "Hotplug unsupported."
> > With this change we have "Guest/System not ready"
>
>
> Hotplug unsupported is not an error that can trigger with
> a well behaved management such as libvirt.
>
>
> >
> >
> >     >
> >     >
> >     >     I'm not actually convinced we can't do that even for existing
> machine
> >     >     types.
> >     >
> >     >
> >     > Is a Guest visible change, I don't think we can do it.
> >     >
> >     >
> >     >     So I'm a bit hesitant to suggest going ahead with this without
> >     >     looking a bit closer at whether we can implement a
> wait-for-ready in
> >     >     qemu, rather than forcing every user of qemu (human or
> machine) to do
> >     >     so.
> >     >
> >     >
> >     > While I agree it is a pain from the usability point of view,
> hotplug
> >     operations
> >     > are allowed to fail. This is not more than a corner case, ensuring
> the
> >     right
> >     > response (gracefully erroring out) may be enough.
> >     >
> >     > Thanks,
> >     > Marcel
> >     >
> >
> >
> >     I don't think they ever failed in the past so management is unlikely
> >     to handle the failure by retrying ...
> >
> >
> > That would require some management handling, yes.
> > But even without a "retry", failing is better than strange OS behavior.
> >
> > Trying a better alternative like deferring the operation for new machines
> > would make sense, however is out of the scope of this patch
>
> Expand the scope please. The scope should be "solve a problem xx" not
> "solve a problem xx by doing abc".
>
>
The scope is detecting a hotplug error early instead
passing to the Guest OS a hotplug operation that we know it will fail.



> > that simply
> > detects the error leaving us in a slightly better state than today.
> >
> > Thanks,
> > Marcel
>
> Not applying a patch is the only tool we maintainers have to influence
> people to solve the problem fully.

That's why I'm not inclined to apply
> "slightly better" patches generally.
>
>
The patch is a proposal following some offline discussions on this matter.
I personally see the value of it versus what we have today.

Thanks,
Marcel


>
> >
> >
> >     >
> >     >
> >     >
> >     >     --
> >     >     David Gibson <dgibson@redhat.com>
> >     >     Principal Software Engineer, Virtualization, Red Hat
> >     >
> >
> >
>
>

--000000000000c92a8d05b24397fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 22, 2020 at 5:33 PM Micha=
el S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, O=
ct 22, 2020 at 05:10:43PM +0300, Marcel Apfelbaum wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Thu, Oct 22, 2020 at 5:01 PM Michael S. Tsirkin &lt;<a href=3D"mail=
to:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Thu, Oct 22, 2020 at 04:55:10PM +0300, Marcel Ap=
felbaum wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Hi David, Michael,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; On Thu, Oct 22, 2020 at 3:56 PM David Gibson &=
lt;<a href=3D"mailto:dgibson@redhat.com" target=3D"_blank">dgibson@redhat.c=
om</a>&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0On Thu, 22 Oct 2020 08:06:5=
5 -0400<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&quot;Michael S. Tsirkin&qu=
ot; &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com<=
/a>&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; On Thu, Oct 22, 2020 a=
t 02:40:26PM +0300, Marcel Apfelbaum wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; From: Marcel Apfe=
lbaum &lt;<a href=3D"mailto:marcel@redhat.com" target=3D"_blank">marcel@red=
hat.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; During PCIe Root =
Port&#39;s transition from Power-Off to Power-ON (or<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0vice-versa)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; the &quot;Slot Co=
ntrol Register&quot; has the &quot;Power Indicator Control&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; set to &quot;Blin=
king&quot; expressing a &quot;power transition&quot; mode.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; Any hotplug opera=
tion during the &quot;power transition&quot; mode is not<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0permitted<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; or at least not e=
xpected by the Guest OS leading to strange<br>
&gt;=C2=A0 =C2=A0 =C2=A0failures.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; Detect and refuse=
 hotplug operations in such case.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; Signed-off-by: Ma=
rcel Apfelbaum &lt;<a href=3D"mailto:marcel.apfelbaum@gmail.com" target=3D"=
_blank">marcel.apfelbaum@gmail.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 hw/pci/pcie=
.c | 7 +++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 1 file chan=
ged, 7 insertions(+)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; diff --git a/hw/p=
ci/pcie.c b/hw/pci/pcie.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; index 5b48bae0f6.=
.2fe5c1473f 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; --- a/hw/pci/pcie=
.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +++ b/hw/pci/pcie=
.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; @@ -410,6 +410,7 =
@@ void pcie_cap_slot_pre_plug_cb(HotplugHandler<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0*hotplug_dev, DeviceState *=
dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=
=A0 PCIDevice *hotplug_pdev =3D PCI_DEVICE(hotplug_dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=
=A0 uint8_t *exp_cap =3D hotplug_pdev-&gt;config + hotplug_pdev-&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0exp.exp_cap;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=
=A0 uint32_t sltcap =3D pci_get_word(exp_cap + PCI_EXP_SLTCAP);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +=C2=A0 =C2=A0 ui=
nt32_t sltctl =3D pci_get_word(exp_cap + PCI_EXP_SLTCTL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=
=A0 /* Check if hot-plug is disabled on the slot */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=
=A0 if (dev-&gt;hotplugged &amp;&amp; (sltcap &amp; PCI_EXP_SLTCAP_HPC) =3D=
=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; @@ -418,6 +419,12=
 @@ void pcie_cap_slot_pre_plug_cb<br>
&gt;=C2=A0 =C2=A0 =C2=A0(HotplugHandler<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0*hotplug_dev, DeviceState *=
dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=
=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +=C2=A0 =C2=A0 if=
 ((sltctl &amp; PCI_EXP_SLTCTL_PIC) =3D=3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0PCI_EXP_SLTCTL_PWR_IND_BLINK)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 error_setg(errp, &quot;Hot-plug failed: %s is in Power<br>
&gt;=C2=A0 =C2=A0 =C2=A0Transition&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DEVICE(hotplug_pdev)=
-&gt;id);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +=C2=A0 =C2=A0 }<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=
=A0 pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0errp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 }=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; Probably the only way =
to handle for existing machine types.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I agree<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; For new ones, can&#39;=
t we queue it in host memory somewhere?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I am not sure I understand what will be the fl=
ow.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; =C2=A0 - The user asks for a hotplug operation=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; =C2=A0 -=C2=A0 QEMU deferred operation.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; After that the operation may still fail, how w=
ould the user know if the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; operation<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; succeeded or not?<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0How can it fail? It&#39;s just a button press ...<b=
r>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; Currently we have &quot;Hotplug unsupported.&quot;<br>
&gt; With this change we have &quot;Guest/System not ready&quot;<br>
<br>
<br>
Hotplug unsupported is not an error that can trigger with<br>
a well behaved management such as libvirt.<br>
<br>
<br>
&gt; =C2=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0I&#39;m not actually convin=
ced we can&#39;t do that even for existing machine<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0types.=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Is a Guest visible change, I don&#39;t think w=
e can do it.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0So I&#39;m a bit hesitant t=
o suggest going ahead with this without<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0looking a bit closer at whe=
ther we can implement a wait-for-ready in<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0qemu, rather than forcing e=
very user of qemu (human or machine) to do<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0so.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; While I agree it is a pain from the usability =
point of view, hotplug<br>
&gt;=C2=A0 =C2=A0 =C2=A0operations<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; are allowed to fail. This is not more than a c=
orner case, ensuring the<br>
&gt;=C2=A0 =C2=A0 =C2=A0right<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; response (gracefully erroring out) may be enou=
gh.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Thanks,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Marcel<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I don&#39;t think they ever failed in the past so m=
anagement is unlikely<br>
&gt;=C2=A0 =C2=A0 =C2=A0to handle the failure by retrying ...<br>
&gt; <br>
&gt; <br>
&gt; That would require some management handling, yes.<br>
&gt; But even without a &quot;retry&quot;, failing=C2=A0is better than stra=
nge OS behavior.<br>
&gt; <br>
&gt; Trying a better alternative like deferring the operation for new machi=
nes<br>
&gt; would make sense, however is out of the scope of this patch<br>
<br>
Expand the scope please. The scope should be &quot;solve a problem xx&quot;=
 not<br>
&quot;solve a problem xx by doing abc&quot;.<br>
<br></blockquote><div><br></div><div>The scope is detecting a hotplug error=
 early instead</div><div>passing to the Guest OS a hotplug operation that w=
e know it will fail.</div><div><br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
&gt; that simply<br>
&gt; detects the error leaving us in a slightly better state than today.<br=
>
&gt; <br>
&gt; Thanks,<br>
&gt; Marcel<br>
<br>
Not applying a patch is the only tool we maintainers have to influence<br>
people to solve the problem fully.=C2=A0</blockquote><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"> That&#39;s why I&#39;m not inclined to apply<b=
r>
&quot;slightly better&quot; patches generally.<br>
<br></blockquote><div><br></div><div>The patch is a proposal following some=
 offline discussions=C2=A0on this matter.</div><div>I personally see the va=
lue of it versus=C2=A0what we have today.</div><div><br></div><div>Thanks,<=
/div><div>Marcel</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0--<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0David Gibson &lt;<a href=3D=
"mailto:dgibson@redhat.com" target=3D"_blank">dgibson@redhat.com</a>&gt;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Principal Software Engineer=
, Virtualization, Red Hat<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; <br>
&gt; <br>
<br>
</blockquote></div></div>

--000000000000c92a8d05b24397fc--

