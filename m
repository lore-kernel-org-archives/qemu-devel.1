Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E230C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 05:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04CF1206BE
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 05:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M07Y6fba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04CF1206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbHcK-0005ER-5M
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 01:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jbHbX-0004oo-6B
 for qemu-devel@nongnu.org; Wed, 20 May 2020 01:49:23 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:40976)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jbHbW-0007Od-Bf
 for qemu-devel@nongnu.org; Wed, 20 May 2020 01:49:22 -0400
Received: by mail-io1-xd43.google.com with SMTP id o5so1843843iow.8
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 22:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ONt1tGTTxZlfve9YEZknKqxeqMdzZWYDS2JKrf0/fLg=;
 b=M07Y6fbaRu43dQa0Ugrv82zD1DjDS1RjjboHZ44v1fztZuDySefoYzfzGZ1+rXKr+x
 /3TFjL/OwFXnwetjpTPPhhe9ZsZVQdWuCsNJ1VjrirvYnr+pJkXyNUchd0yNfo/38EEA
 4jpIAzPnuLx3BRB8GDfC/dh52q+kqhDus3CIQQALiPzUaNJOGui9+tFjvTRSeaPu6QMW
 x3y2mRI/yUkxZL1Q783+u/FcnGX8aaslPePsR0JrP6nk8wqCoH2caOxf8oVVp9QenRIN
 bIZRkYK8Mbl6gEMi4NaWumsQUHts2Lh2uUiZbIo3dgmjnjt4EuvDmXakDePbl9MfR7np
 Phzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ONt1tGTTxZlfve9YEZknKqxeqMdzZWYDS2JKrf0/fLg=;
 b=QmoTT/B+LwJpb0OIGmkb4zk8Pz00jA3UvKPo0Kouc+SHaUM8UXQ1KdSegUrYZE8fWi
 42qW3ESPgU3M/jwmdHxRs+VHVIm1bru/ypWm9xDHPvuWMqGIwqJik7HHMIHrvwrhRvEs
 R1w+1T1l0yq+WsA8M68NJro9drewPUhk23QN9OhD11iX35TieaaAZp8QwvwyBxFYrmat
 FjO6kqfaySU/9PjwJWz4Wo5gIFOhvrT71PFT36ZncId/F5dUxEvvlNTh7QBwteh4weGB
 dftO+jHzqf+ZFEsHZ8B4AgetGehbBbtKVWQSqqBR37GXJs+31sL87oBe08kKMMSRUTfx
 ZEjg==
X-Gm-Message-State: AOAM5330wBYeF3MrZU6Ojn7epIrqHrRcUUNYjdQh849k+Wdg4SjkTpHJ
 WH2bOrRrDCyt4HmXs2j4/D0Y6cV4LVyh5i9t4Rk=
X-Google-Smtp-Source: ABdhPJzHZxJAt8/V5LV+TjMnJ6pjjZseAITMpTS9QEvOvb4x9CTxHohMFI1CmgSAnLL+kgEjBD/NoNtLhmC0uziGFN8=
X-Received: by 2002:a6b:6803:: with SMTP id d3mr2158713ioc.126.1589953760687; 
 Tue, 19 May 2020 22:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200512064900.28554-1-pauldzim@gmail.com>
 <20200512064900.28554-5-pauldzim@gmail.com>
 <CAFEAcA8ru0DyVTvVcTjf0AH8wi+d64m=iP_qbHrsLnGt65Y0Kg@mail.gmail.com>
In-Reply-To: <CAFEAcA8ru0DyVTvVcTjf0AH8wi+d64m=iP_qbHrsLnGt65Y0Kg@mail.gmail.com>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Tue, 19 May 2020 22:48:54 -0700
Message-ID: <CADBGO79puzxx8dC2_kxe0eGJ34fn=DwwgNfL9xSBt=dQvEcOUw@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] dwc-hsotg (dwc2) USB host controller emulation
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000001d7aa505a60df5bb"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=pauldzim@gmail.com; helo=mail-io1-xd43.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001d7aa505a60df5bb
Content-Type: text/plain; charset="UTF-8"

On Mon, May 18, 2020 at 8:34 AM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Tue, 12 May 2020 at 07:50, Paul Zimmerman <pauldzim@gmail.com> wrote:
> >
>
> > +static void dwc2_reset(DeviceState *dev)
> > +{
> > +    DWC2State *s = DWC2_USB(dev);
> > +    int i;
> > +
> > +    trace_usb_dwc2_reset();
> > +    timer_del(s->frame_timer);
> > +    qemu_bh_cancel(s->async_bh);
> > +
> > +    if (s->uport.dev && s->uport.dev->attached) {
> > +        usb_detach(&s->uport);
> > +    }
> > +
> > +    dwc2_bus_stop(s);
>
>
> > +    dwc2_update_irq(s);
>
> A device that uses single-phase reset shouldn't try to change
> outbound IRQ lines from its reset function (because the device
> on the other end might have already reset before this device,
> or might reset after this device, and it doesn't necessarily
> handle the irq line change correctly). If you need to
> update IRQ lines in reset, you can use three-phase-reset
> (see docs/devel/reset.rst).
>

Hi Peter,

Is there a tree somewhere that has a working example of a
three-phase reset? I did a 'git grep' on the master branch and didn't
find any code that is actually using it. I tried to implement it from
the example in reset.rst, but I'm getting a segfault on the first line in
resettable_class_set_parent_phases() that I'm having trouble figuring
out.

Thanks,
Paul

thanks
> -- PMM
>

--0000000000001d7aa505a60df5bb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, May 18, 2020 at 8:34 AM Peter Maydell=
 &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 Tue, 12 May 2020 at 07:50, Paul Zimmerman &lt;<a href=3D"mailto:pauldzim@g=
mail.com" target=3D"_blank">pauldzim@gmail.com</a>&gt; wrote:<br>
&gt;<br><br>
&gt; +static void dwc2_reset(DeviceState *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DWC2State *s =3D DWC2_USB(dev);<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_usb_dwc2_reset();<br>
&gt; +=C2=A0 =C2=A0 timer_del(s-&gt;frame_timer);<br>
&gt; +=C2=A0 =C2=A0 qemu_bh_cancel(s-&gt;async_bh);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;<a href=3D"http://uport.dev" rel=3D"noreferre=
r" target=3D"_blank">uport.dev</a> &amp;&amp; s-&gt;uport.dev-&gt;attached)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 usb_detach(&amp;s-&gt;uport);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dwc2_bus_stop(s);<br>
<br>
<br>
&gt; +=C2=A0 =C2=A0 dwc2_update_irq(s);<br>
<br>
A device that uses single-phase reset shouldn&#39;t try to change<br>
outbound IRQ lines from its reset function (because the device<br>
on the other end might have already reset before this device,<br>
or might reset after this device, and it doesn&#39;t necessarily<br>
handle the irq line change correctly). If you need to<br>
update IRQ lines in reset, you can use three-phase-reset<br>
(see docs/devel/reset.rst).<br></blockquote><br></div><div class=3D"gmail_q=
uote">Hi Peter,<br><br>Is<span class=3D"gmail_default" style=3D"font-family=
:monospace"> </span>there a tree somewhere that has a working example of a<=
/div><div class=3D"gmail_quote">three-phase reset? I did a &#39;git grep&#3=
9; on the master branch and didn&#39;t<br>find any code that is actually us=
ing it. I tried to implement it<span class=3D"gmail_default" style=3D"font-=
family:monospace"> </span>from</div><div class=3D"gmail_quote">the example =
in reset.rst, but I&#39;m getting a segfault on the<span class=3D"gmail_def=
ault" style=3D"font-family:monospace"> </span>first line in</div><div class=
=3D"gmail_quote">resettable_class_set_parent_phases() that I&#39;m having<s=
pan class=3D"gmail_default" style=3D"font-family:monospace"> </span>trouble=
 figuring</div><div class=3D"gmail_quote">out.<br><br>Thanks,<br>Paul</div>=
<div class=3D"gmail_quote"><br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
thanks<br>
-- PMM<br>
</blockquote></div></div>

--0000000000001d7aa505a60df5bb--

