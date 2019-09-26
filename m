Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C265C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:38:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD4DB222BE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFLoQjZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4DB222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33033 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDQEh-00006o-T5
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 05:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iDQDS-0007ZC-48
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iDQDQ-0005wD-Ba
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:37:37 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44231)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1iDQDQ-0005vQ-68
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:37:36 -0400
Received: by mail-oi1-f193.google.com with SMTP id w6so1482555oie.11
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 02:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AtP8W/L73P1eu8H5IGH8UsNkXxVxq9c3NORH1TqwJJE=;
 b=SFLoQjZAZZ7nH2RNrD6cvBOJ1sfyd6MVL/MeH+lJejpPSn7vwYWPXSoSM+da6MBPH5
 FHREJYlN/tn2wLJhLqc3Rwqr0bOlOjwOW4PhRRnOauVIJUXYM2VGf/8Tf+lOHLe6wIBY
 56TKJhnDKI/jkEwMSXyU3F/jAoY6KQIItEoSZOX3QJ9eLZjZvpXwahp1sKxn8pnHcG7+
 1EdrqA4qHi3ofH40NgH8y+eAzE5tAkuinQJ5KxsMfFA0jyCOYpJyOLEzoWmfvTjMtGYN
 RyX4ViYbIACR/tqXNlFFwrhYszTncdGj91aVAQwG+GpMfsGMFnOe0eEzV60Wy6NJykOk
 HQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AtP8W/L73P1eu8H5IGH8UsNkXxVxq9c3NORH1TqwJJE=;
 b=dIGEpDQFm4vJ/t4nqAum+ZwN0s9fMJIdX82YqAaps0n8nnAnQvRr/HI3bY7+684Z9V
 lIz1SfwHBr22yRzg7CRK7a1ISCsUXr2KDrP/aplnOeNvUXazj8eT6OZEZVIpSAEqRnum
 jXvf4V4x28/r4rxf4r/bNOAS+UnLuKHsmN8wFVUWlBlJnGJNIzppKMbcjnW4RuwTxTb8
 kBH2xKNFZdkV8ruwcSOCs4oU5YvV0cMOjpZz/qGZxJ7HRt1RqGJGfCMISaDUVqcgAKqp
 quv7Xuuc//Y1na4MvXuaZyn+kmuwtJr3MvG4AYe0bZPw0WRhVC1zAR8AgwZtXl/gWDOY
 yImw==
X-Gm-Message-State: APjAAAUvjl8h9TKCXKD6nhwFtoOWXd4maUYWLjoln/oMkt1sI33+608L
 1EKKf+OV34jdgXi823DJ9OjYnKvNiOrUJxw/zjI=
X-Google-Smtp-Source: APXvYqzcYjWEqL71Euac13F2ceFSOhE8XOHWxxJ4oqa0R1uyj8nHyYiS8+LysR+dL+4IG/wL+Zpp7qyzi8pQfFkHBhM=
X-Received: by 2002:aca:db03:: with SMTP id s3mr2022025oig.56.1569490594543;
 Thu, 26 Sep 2019 02:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAKXe6SJfZt8WcA43Vsh0=GT=jBedcAOUx9DNGZ4Bsvi10oCkog@mail.gmail.com>
 <b24f9938-d0a7-2680-0078-c02e1abebc59@redhat.com>
In-Reply-To: <b24f9938-d0a7-2680-0078-c02e1abebc59@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 26 Sep 2019 17:35:58 +0800
Message-ID: <CAKXe6SJaNju-O8mECU18n-3W3OnYnjnOUCKfAmTK32LAXj0nng@mail.gmail.com>
Subject: Re: Questions about the real mode in kvm/qemu
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005dbe73059371812d"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.193
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
Cc: Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005dbe73059371812d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paolo Bonzini <pbonzini@redhat.com> =E4=BA=8E2019=E5=B9=B49=E6=9C=8826=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:15=E5=86=99=E9=81=93=EF=BC=9A

> On 26/09/19 09:52, Li Qiang wrote:
> > Hi Paolo and all,
> >
> > There are some question about the emulation for real mode in kvm/qemu.
> > For all the
> > question I suppose the 'unstrict guest' is not enabled.
> >
> > 1. how the protected mode CPU emulate the real mode? It seems it uses
> > vm86, however, vm86 is not available in x86_64 CPU? So what's the
> > 'to_vmx(vcpu)->rmode.vm86_active' here vm86 means?
>
> vm86 mode is available in 64-bit CPUs; it is not available in 64-bit
> mode (EFER.LMA=3D1).
>
> Once KVM places the processor in VMX non-root mode (VMLAUNCH/VMRESUME),
> the processor can leave 64-bit mode and run in vm86 mode.  And that's
> exactly what KVM does on processors without unrestricted guest support.
>
> In that mode, KVM will start trapping all exceptions and send them to
> handle_rmode_exception.  This in turn will either emulate privileged
> instructions (for #GP or #SS) or inject them as realmode exceptions.
>
>

So without unrestrict guest the mainline is this:
KVM set guest's rflag bit X86_EFLAGS_VM, so when the guest enter guest
mode, it is in vm86 mode.
In this mode, the CPU will access the address like in real
mode(seg*4+offset), this address is linear address. And in fact, the vm86
is still
in protected, so the linear address will be translated to gpa by the
identity mapping table. Then goes to EPT table?

Is this understanding right?



> However...
>
> > 2. Does the guest's real mode code run directly in native CPU? It seems
> > 'vmx->emulation_required' is also be false, it the vmx_vcpu_run will do
> > a switch to guest.
>
> ... as soon as the guest tries to enter protected mode, it will get into
> a situation which is not real mode but doesn't have the segment
> registers properly loaded with selectors.

Therefore, it will either
> hack things together (enter_pmode) or emulate instructions until the
> state is accepted even without unrestricted guest support.
>

Could you please explain this situation more detailed? Why this happen?

Thanks,
Li Qiang



>
> The "hacking things together" part however does not work for big real
> mode (where you enter 32-bit mode, load segment registers with a flat 4G
> segment, and go back to real mode with the 4G segments).  In big real
> mode, therefore, KVM cannot use vm86 and will keep emulating (slowly -
> up to 1000x slower than unrestricted guest).
>
> > 3. How the EPT work in guest real mode? The EPT is for GVA->GPA->HPA,
> > however there is no GVA, seems the identity mapping does something. But
> > there also some confusion for me. For example the real mode uses CS*4 +
> > IP to address the code.  Who does this calculation? In the kernel
> emulator?
>
> Right, and in fact the CR0.PG and CR0.PE bits must be 1 when running in
> VMX non-root mode with unrestricted guest disabled.
>
> Therefore, KVM places a 4 KiB identity map at an address provided by
> userspace (with KVM_SET_IDENTITY_MAP_ADDR).  When 1) EPT is enabled 2)
> unrestricted guest isn't 3) CR0.PG=3D0, KVM points CR3 to it and runs the
> guest with CR0.PG=3D1, CR4.PAE=3D0, CR4.PSE=3D1.  This CR4 setup enables =
4 MiB
> huge pages so that a 4 GiB identity map fits in 4 KiB.  This is the only
> case where EPT is enabled but CR3 loads and stores will trap to the
> hypervisor.  This way, the guest CR3 value is faked in the vmexit
> handler, but the processor always uses the identity GVA->GPA mapping.
>
> Paolo
>
>

--0000000000005dbe73059371812d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Paolo Bonzini &lt;<a href=3D"mailto:p=
bonzini@redhat.com">pbonzini@redhat.com</a>&gt; =E4=BA=8E2019=E5=B9=B49=E6=
=9C=8826=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:15=E5=86=99=E9=81=
=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
26/09/19 09:52, Li Qiang wrote:<br>
&gt; Hi Paolo and all,<br>
&gt; <br>
&gt; There are some question about the emulation for real mode in kvm/qemu.=
<br>
&gt; For all the=C2=A0<br>
&gt; question I suppose the &#39;unstrict guest&#39; is not enabled.=C2=A0<=
br>
&gt; <br>
&gt; 1. how the protected mode CPU emulate the real mode? It seems it uses<=
br>
&gt; vm86, however, vm86 is not available in x86_64 CPU? So what&#39;s the<=
br>
&gt; &#39;to_vmx(vcpu)-&gt;rmode.vm86_active&#39; here vm86 means?<br>
<br>
vm86 mode is available in 64-bit CPUs; it is not available in 64-bit<br>
mode (EFER.LMA=3D1).<br>
<br>
Once KVM places the processor in VMX non-root mode (VMLAUNCH/VMRESUME),<br>
the processor can leave 64-bit mode and run in vm86 mode.=C2=A0 And that&#3=
9;s<br>
exactly what KVM does on processors without unrestricted guest support.<br>
<br>
In that mode, KVM will start trapping all exceptions and send them to<br>
handle_rmode_exception.=C2=A0 This in turn will either emulate privileged<b=
r>
instructions (for #GP or #SS) or inject them as realmode exceptions.<br>
<br></blockquote><div><br></div><div><br></div><div>So without unrestrict g=
uest the mainline is this:</div><div>KVM set guest&#39;s rflag bit X86_EFLA=
GS_VM, so when the guest enter guest mode, it is in vm86 mode.</div><div>In=
 this mode, the CPU will access the address like in real mode(seg*4+offset)=
, this address is linear address. And in fact, the vm86 is still=C2=A0</div=
><div>in protected, so the linear address will be translated to gpa by the =
identity mapping table. Then goes to EPT table?</div><div><br></div><div>Is=
 this understanding right?</div><div><br></div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
However...<br>
<br>
&gt; 2. Does the guest&#39;s real mode code run directly in native CPU? It =
seems<br>
&gt; &#39;vmx-&gt;emulation_required&#39; is also be false, it the vmx_vcpu=
_run will do<br>
&gt; a switch to guest.<br>
<br>
... as soon as the guest tries to enter protected mode, it will get into<br=
>
a situation which is not real mode but doesn&#39;t have the segment<br>
registers properly loaded with selectors.=C2=A0=C2=A0</blockquote><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">Therefore, it will either<br>
hack things together (enter_pmode) or emulate instructions until the<br>
state is accepted even without unrestricted guest support.<br></blockquote>=
<div><br></div><div>Could you please explain this situation more detailed? =
Why this happen?<br></div><div><br></div><div>Thanks,</div><div>Li Qiang</d=
iv><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
The &quot;hacking things together&quot; part however does not work for big =
real<br>
mode (where you enter 32-bit mode, load segment registers with a flat 4G<br=
>
segment, and go back to real mode with the 4G segments).=C2=A0 In big real<=
br>
mode, therefore, KVM cannot use vm86 and will keep emulating (slowly -<br>
up to 1000x slower than unrestricted guest).<br>
<br>
&gt; 3. How the EPT work in guest real mode? The EPT is for GVA-&gt;GPA-&gt=
;HPA,<br>
&gt; however there is no GVA, seems the identity mapping does something. Bu=
t<br>
&gt; there also some confusion for me. For example the real mode uses CS*4=
=C2=A0+<br>
&gt; IP to address the code.=C2=A0 Who does this calculation? In the kernel=
 emulator?=C2=A0<br>
<br>
Right, and in fact the <a href=3D"http://CR0.PG" rel=3D"noreferrer" target=
=3D"_blank">CR0.PG</a> and <a href=3D"http://CR0.PE" rel=3D"noreferrer" tar=
get=3D"_blank">CR0.PE</a> bits must be 1 when running in<br>
VMX non-root mode with unrestricted guest disabled.<br>
<br>
Therefore, KVM places a 4 KiB identity map at an address provided by<br>
userspace (with KVM_SET_IDENTITY_MAP_ADDR).=C2=A0 When 1) EPT is enabled 2)=
<br>
unrestricted guest isn&#39;t 3) <a href=3D"http://CR0.PG" rel=3D"noreferrer=
" target=3D"_blank">CR0.PG</a>=3D0, KVM points CR3 to it and runs the<br>
guest with <a href=3D"http://CR0.PG" rel=3D"noreferrer" target=3D"_blank">C=
R0.PG</a>=3D1, CR4.PAE=3D0, CR4.PSE=3D1.=C2=A0 This CR4 setup enables 4 MiB=
<br>
huge pages so that a 4 GiB identity map fits in 4 KiB.=C2=A0 This is the on=
ly<br>
case where EPT is enabled but CR3 loads and stores will trap to the<br>
hypervisor.=C2=A0 This way, the guest CR3 value is faked in the vmexit<br>
handler, but the processor always uses the identity GVA-&gt;GPA mapping.<br=
>
<br>
Paolo<br>
<br>
</blockquote></div></div>

--0000000000005dbe73059371812d--

