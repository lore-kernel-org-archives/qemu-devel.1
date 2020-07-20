Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EF9C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:57:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2DEB21775
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=slowstart.org header.i=@slowstart.org header.b="PdrPY+lB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2DEB21775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=slowstart.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxSYL-0001PC-4e
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 05:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kentaishiguro@slowstart.org>)
 id 1jxSWY-0000O3-6T
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 05:55:54 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:42573)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kentaishiguro@slowstart.org>)
 id 1jxSWV-0006tN-QV
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 05:55:53 -0400
Received: by mail-ed1-x541.google.com with SMTP id z17so12318156edr.9
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 02:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=slowstart.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CBsRogeTVsD+m7KY518ZU+uhSGjnicS2PsCpzi1bVtk=;
 b=PdrPY+lBjDwlvV44l+IXARiUfZL0coS+cNEo1tfAS77AQtvmlyUG5EWxJ/LKYLAUpk
 U98IR2miDBHdSsZtGlTVED8LOaEMSPm0VHHMOBKk7Lcv0IRH7ArXYYS93/Ilca2UEAIs
 9chlNJuoQUILXT7Wp2uIHviGUmewqQqT787xN/HLYNkBPuwtV3EECtLfEuo9QqsJ38YK
 7uOLSlrHIMfYFyR7fQuvVk6Dq0qNE5V6uSKt5LtFdlhC+1fO1fBT6cx78BDmLpRCIkGL
 pUKXRj+A1kxkZlmL8xzuuieG4mSKaNf69bYR+Aa4WitpMMxvbk62CJdRLznDwe5HbwJr
 Tp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CBsRogeTVsD+m7KY518ZU+uhSGjnicS2PsCpzi1bVtk=;
 b=MdpqMLd2bKRhbYlWnpX1eYxA+RYR1Q93YmyXMLdlIxeAvG9kFtUYLz8H9kTmH729mE
 XaXekUsqg8geOYnd2/lxU6kG0moZ92ptaXvbWI33SXl679aW0qUAO1ViZ/gGq3PoGaGi
 uOAZYw2v8fQaMkePXMPqR+ZP48NFc89bJCfBK99PUXPkkj2/q1XUB9QEN69sm396rS+X
 aG3Wg7CgMM/q32jzQrITbWjRUEsqGcdVedSe8je1T5oH7rOg3glG3uehLBe9EUiEibX+
 OFiqu68KPeXia6etJEcbPF0M04ZYUYDWLN6gIRXZ9PId8Q8Cd6r8zrymlmLFxyUuYZN5
 7e6w==
X-Gm-Message-State: AOAM5334zdXUimvhUM/Fonyk1lLr8czu0hq8L+nCTBRTgTVRj7GHIkXN
 F7YRQeV4E9cFon1BfoPKww1BbluAvX7r7YB+Buzb5A==
X-Google-Smtp-Source: ABdhPJywNgW+eYEmv6MQrn/PYwoRIHfhObB/yJ5XbTRi4y64ELT2iSE3ibRdJVws/DyIOctmTjBLo6LZt8scHZ80ni8=
X-Received: by 2002:aa7:c2d7:: with SMTP id m23mr20888236edp.216.1595238949524; 
 Mon, 20 Jul 2020 02:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200717123514.15406-1-kentaishiguro@slowstart.org>
 <8df96035-ee99-85b2-0d98-65f4996e4aae@redhat.com>
In-Reply-To: <8df96035-ee99-85b2-0d98-65f4996e4aae@redhat.com>
From: Kenta Ishiguro <kentaishiguro@slowstart.org>
Date: Mon, 20 Jul 2020 18:55:38 +0900
Message-ID: <CAORMuQ4-CSP1sdzutdCvLNLo=_jUjBmw6NLZvr21yW44vKT0Lw@mail.gmail.com>
Subject: Re: [PATCH] hw/i386/kvm/ioapic.c: fix typo in error message
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000eb2eb105aadc8285"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=kentaishiguro@slowstart.org; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000eb2eb105aadc8285
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

No, it didn't.
I just checked the usage of this API and I found this inconsistent error
message.

On Mon, Jul 20, 2020 at 6:31 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 7/17/20 2:35 PM, Kenta Ishiguro wrote:
> > Fix a typo in an error message for KVM_SET_IRQCHIP ioctl:
> > "KVM_GET_IRQCHIP" should be "KVM_SET_IRQCHIP".
> >
> > Signed-off-by: Kenta Ishiguro <kentaishiguro@slowstart.org>
> > ---
> >  hw/i386/kvm/ioapic.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
> > index 4ba8e47251..c5528df942 100644
> > --- a/hw/i386/kvm/ioapic.c
> > +++ b/hw/i386/kvm/ioapic.c
> > @@ -97,7 +97,7 @@ static void kvm_ioapic_put(IOAPICCommonState *s)
> >
> >      ret =3D kvm_vm_ioctl(kvm_state, KVM_SET_IRQCHIP, &chip);
> >      if (ret < 0) {
> > -        fprintf(stderr, "KVM_GET_IRQCHIP failed: %s\n", strerror(ret))=
;
> > +        fprintf(stderr, "KVM_SET_IRQCHIP failed: %s\n", strerror(ret))=
;
> >          abort();
>
> 9 years later this abort seems violent. Kenta, did it fired for you?
>
> >      }
> >  }
> >
>
> Fixes: a39c1d47ac ("kvm: x86: Add user space part for in-kernel IOAPIC")
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
>

--000000000000eb2eb105aadc8285
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">No, it didn&#39;t.<br>I just checked the =
usage of this API and I found this inconsistent error message.<br></div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, J=
ul 20, 2020 at 6:31 PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:ph=
ilmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">On 7/17/20 2:35 PM, Kenta Ishiguro wrote:=
<br>
&gt; Fix a typo in an error message for KVM_SET_IRQCHIP ioctl:<br>
&gt; &quot;KVM_GET_IRQCHIP&quot; should be &quot;KVM_SET_IRQCHIP&quot;.<br>
&gt; <br>
&gt; Signed-off-by: Kenta Ishiguro &lt;<a href=3D"mailto:kentaishiguro@slow=
start.org" target=3D"_blank">kentaishiguro@slowstart.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/i386/kvm/ioapic.c | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c<br>
&gt; index 4ba8e47251..c5528df942 100644<br>
&gt; --- a/hw/i386/kvm/ioapic.c<br>
&gt; +++ b/hw/i386/kvm/ioapic.c<br>
&gt; @@ -97,7 +97,7 @@ static void kvm_ioapic_put(IOAPICCommonState *s)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 ret =3D kvm_vm_ioctl(kvm_state, KVM_SET_IRQCHIP, &=
amp;chip);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;KVM_GET_IRQCHIP fai=
led: %s\n&quot;, strerror(ret));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;KVM_SET_IRQCHIP fai=
led: %s\n&quot;, strerror(ret));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 abort();<br>
<br>
9 years later this abort seems violent. Kenta, did it fired for you?<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt; <br>
<br>
Fixes: a39c1d47ac (&quot;kvm: x86: Add user space part for in-kernel IOAPIC=
&quot;)<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redha=
t.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
<br>
</blockquote></div></div>

--000000000000eb2eb105aadc8285--

