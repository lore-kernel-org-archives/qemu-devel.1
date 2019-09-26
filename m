Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487F6C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 08:55:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13EAD222BE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 08:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFztCMDH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13EAD222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDPYv-0008CL-7M
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 04:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50633)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iDPXr-0007Be-0c
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iDPXp-00051y-Hj
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:54:38 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:40680)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1iDPXp-0004yr-CJ
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:54:37 -0400
Received: by mail-oi1-f180.google.com with SMTP id k9so1402856oib.7
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 01:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qfv/i+bCwppofdihLoTAQ+/SWH0U07D0r0CcVNuEpao=;
 b=GFztCMDHR3waKbC+dQKQdmvQ0ONOnJmKeATblmB9eIQntXh4V8+2LaV1sBZio9c+S9
 mACir6sdOQAAYLCjbUdlaEKuGVhqP/hOWgEPtvDnnacfzKpEZCwg8PHKVIF1aqGBMW1Q
 iCVGLH5Hyx+dAHVkTjXsAmU2yCnl2aCwhdV90TjdQ8/y/PMh0163TkY/dPVe7x79ADXD
 pMLogoM6VbkP8sHud3778511tjIsMYqiXgvTxASH13tgvbc+183mUB8sWM8oaUqxuxQ0
 rspp/9U1R4LH19814AvaqfYaCXnMJca2qckyOm2qrDqRlZjt7X/UASsvX+4zmmqBGxzH
 j7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qfv/i+bCwppofdihLoTAQ+/SWH0U07D0r0CcVNuEpao=;
 b=XBtjxi6boomXWjYNFlDKQC+dQ40qs5Y6Ux0XMF6XJTWRxxC/IY5NDIx2Z2eEPs1vhQ
 dvugv2YccumclmC9luWVl3Vz0ZdMzM5WLeUNO0ZMOjnMI1Xe6SOPVsgCj5JVEvck+qsV
 bx6z+5tvQ5uNnWIwafyR8zWVFtMl8NMuIFoGnmRuswfcSpfgLhOdEzootEAHiP/MYsMh
 CsNyWw4Ce/26jSnqIy+x/zEozpsIL1ZoLY4CFX3ppAq4X2yfv5tfYvHKzM7Xr6lGHOoD
 nsOSE/rcpfxXPfxtqPrc5mHH1idZh+0hD9ONNIPZrTJPKVIGBTxFnxmgOAz4ZXUyF5ac
 eXkQ==
X-Gm-Message-State: APjAAAV940ByyyZoGoF69wO9JL2nS6n4owW0GN8m+UUxqRF1GAZXtzuJ
 49FfTb4hJM2jdDE+kEZnf90OTDVZSmGHrnvFgn4=
X-Google-Smtp-Source: APXvYqwsMSswAOFR2dMfZYnJZNBx87UX2TC3D+ranPgrKYTVjFpB5P91KTWDda/WK8qPU2iNwOF2ooXBRXYXcbbnYSM=
X-Received: by 2002:aca:5e45:: with SMTP id s66mr1710855oib.150.1569488015638; 
 Thu, 26 Sep 2019 01:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAKXe6SJfZt8WcA43Vsh0=GT=jBedcAOUx9DNGZ4Bsvi10oCkog@mail.gmail.com>
 <644968ffb11c11fd580e96c1e67932501a633fe4.camel@redhat.com>
In-Reply-To: <644968ffb11c11fd580e96c1e67932501a633fe4.camel@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 26 Sep 2019 16:52:59 +0800
Message-ID: <CAKXe6SK+cEytTtgKHw8KXY=jY4xv=27GBu55hTbTmbRyTPsfxg@mail.gmail.com>
Subject: Re: Questions about the real mode in kvm/qemu
To: Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a6c499059370e780"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.180
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a6c499059370e780
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Maxim Levitsky <mlevitsk@redhat.com> =E4=BA=8E2019=E5=B9=B49=E6=9C=8826=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=884:31=E5=86=99=E9=81=93=EF=BC=9A

> On Thu, 2019-09-26 at 15:52 +0800, Li Qiang wrote:
> > Hi Paolo and all,
> >
> > There are some question about the emulation for real mode in kvm/qemu.
> For all the
> > question I suppose the 'unstrict guest' is not enabled.
> >
> > 1. how the protected mode CPU emulate the real mode? It seems it uses
> vm86, however, vm86 is not available in x86_64 CPU? So what's the
> 'to_vmx(vcpu)->rmode.vm86_active' here vm86 means?
> >
>
>
Hi Maxim,

Thanks for your kind reply.



> As far as I know it, modern intel's cpus support so called unrestricted
> guest mode, which allows guest to be basically in any mode,
>

Right, but I also want to know the secret when the 'unstrict guest' is
disabled. So I suppose the 'unstrict guest' is  not enabled for these
questions.


> as long as EPT paging is used (that is guest can be in real mode with
> no paging, but EPT has to be enabled).
> The 'vm86_active' is probably lefover support for cpus that don't support
> EPT and/or the unrestricted guest mode,
> where KVM tried to use the good old vm86 mode to
> for real mode virtualization.
>
>
> > 2. Does the guest's real mode code run directly in native CPU? It seems
> 'vmx->emulation_required' is also be false, it the vmx_vcpu_run will do a
> switch to guest.
>
> Same as above
>
> >
> > 3. How the EPT work in guest real mode? The EPT is for GVA->GPA->HPA,
> however there is no GVA, seems the identity mapping does something. But
> there also some confusion for me. For example the real
> > mode uses CS*4 + IP to address the code.  Who does this calculation? In
> the kernel emulator?
>
> EPT sits underneath the guest's paging mode, which in case of real mode i=
s
> 1:1 mapping.
>

It seems when the 'unstrict guest' is enabled, there is no identity mapping
table.

Thanks,
Li Qiang



> Thus CS<<4 + IP would be the guest physical address and it will be looked
> up in the EPT to translate to the real physical address.
>
>
>
> Best regards,
>         Maxim Levitsky
>
>

--000000000000a6c499059370e780
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Maxim Levitsky &lt;<a href=3D"mailto:=
mlevitsk@redhat.com">mlevitsk@redhat.com</a>&gt; =E4=BA=8E2019=E5=B9=B49=E6=
=9C=8826=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=884:31=E5=86=99=E9=81=
=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
Thu, 2019-09-26 at 15:52 +0800, Li Qiang wrote:<br>
&gt; Hi Paolo and all,<br>
&gt; <br>
&gt; There are some question about the emulation for real mode in kvm/qemu.=
 For all the <br>
&gt; question I suppose the &#39;unstrict guest&#39; is not enabled. <br>
&gt; <br>
&gt; 1. how the protected mode CPU emulate the real mode? It seems it uses =
vm86, however, vm86 is not available in x86_64 CPU? So what&#39;s the &#39;=
to_vmx(vcpu)-&gt;rmode.vm86_active&#39; here vm86 means?<br>
&gt; <br>
<br></blockquote><div><br></div><div>Hi Maxim,</div><div><br></div><div>Tha=
nks for your kind reply.</div><div><br></div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
As far as I know it, modern intel&#39;s cpus support so called unrestricted=
 guest mode, which allows guest to be basically in any mode,<br></blockquot=
e><div><br></div><div>Right, but I also want to know the secret when the &#=
39;unstrict guest&#39; is disabled. So I suppose the &#39;unstrict guest&#3=
9; is=C2=A0 not enabled for these questions.</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
as long as EPT paging is used (that is guest can be in real mode with<br>
no paging, but EPT has to be enabled).<br>
The &#39;vm86_active&#39; is probably lefover support for cpus that don&#39=
;t support EPT and/or the unrestricted guest mode,<br>
where KVM tried to use the good old vm86 mode to<br>
for real mode virtualization.<br>
<br>
<br>
&gt; 2. Does the guest&#39;s real mode code run directly in native CPU? It =
seems &#39;vmx-&gt;emulation_required&#39; is also be false, it the vmx_vcp=
u_run will do a switch to guest.<br>
<br>
Same as above<br>
<br>
&gt; <br>
&gt; 3. How the EPT work in guest real mode? The EPT is for GVA-&gt;GPA-&gt=
;HPA, however there is no GVA, seems the identity mapping does something. B=
ut there also some confusion for me. For example the real<br>
&gt; mode uses CS*4 + IP to address the code.=C2=A0 Who does this calculati=
on? In the kernel emulator? <br>
<br>
EPT sits underneath the guest&#39;s paging mode, which in case of real mode=
 is 1:1 mapping.<br></blockquote><div><br></div><div>It seems when the &#39=
;unstrict guest&#39; is enabled, there is no identity mapping table.</div><=
div><br></div><div>Thanks,</div><div>Li Qiang</div><div><br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Thus CS&lt;&lt;4 + IP would be the guest physical address and it will be lo=
oked up in the EPT to translate to the real physical address.<br>
<br>
<br>
<br>
Best regards,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Maxim Levitsky<br>
<br>
</blockquote></div></div>

--000000000000a6c499059370e780--

