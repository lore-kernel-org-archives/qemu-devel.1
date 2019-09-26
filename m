Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26916C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:49:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3E0D2146E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sN6RTguG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E0D2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDSHO-000353-KV
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 07:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iDSGU-0002dJ-Ev
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:48:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iDSGS-0007b3-4F
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:48:53 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:43209)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1iDSGR-0007Xr-Uo
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:48:52 -0400
Received: by mail-oi1-f170.google.com with SMTP id t84so1776592oih.10
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 04:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RsrkdZhPuAaqBy7FSuSti29kPA6koBqyIfNg4zbTpq0=;
 b=sN6RTguGfM5x6RsyqY49rQTd/YeIYnYpggm8Y0Mka9S+0jkJbQxRnpCflYFBcVtwFQ
 aRxTAIJitYafkFNefsKkezxSUqHIYOGxy97RSuStlUSytIxgwhZKJhzWo6dWLZ3JF8Kn
 SvDf9ZqHR1swk7Qh8E9uTlnU1QB1tUFG9hhKcmYhScBlEOclXiFslY4La7nyBbeCEJZX
 YrB4l7gy94zFPngUTo4NmwOvTSRz1uQi1g1gkP0tc0IJpBlq2E2tCvg3ImNZC4J9uQ7t
 qzMa0ppRxATPshHCL5DoKX/TIUIYby+r91rAWVmFGppoE4cUenaILbX2utrXZggwXjaV
 YxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RsrkdZhPuAaqBy7FSuSti29kPA6koBqyIfNg4zbTpq0=;
 b=Sy+f2x9BoyE+QpGMDDFM4RqJjFTu/7rRKk4WHAsC5Zzi/kCq7z30VLktl7QqTmrzQN
 jDKlAUCjYze+7YseqBdQsHPjHM05lcLR5jmBwxKGKYfGFOloYSFYH9Mu6D6yvggRECCd
 8SBN11MogkNPZ7YbI4ZhWet+y5/8tCJoEhCgIMgjX7LPlmVJESGIB+gU0wVG2zq+5iQ2
 O0nTVVaWhPaWSXR3//xKKDr5X7ivDIJ75uDo4j7XN9PuEDmZ+yPr3wFY4gd86nyj1PH6
 BoSaLIQ25aQdPRJQI2AkghoKnBfVw8CV52oKcVT4yT/Taz0TrIh4uz6BIs82gPhBnyG3
 HppQ==
X-Gm-Message-State: APjAAAX+y3Wr1NbLvYC0g+6cwbgXy0VSiNZA1zhPtZr94C92RGUQOGDd
 1QXOrxnS7NkoqN7CotHtzeuBiXObnwf1eedSiZw=
X-Google-Smtp-Source: APXvYqwrUeNwItykD+qGsF7Qp1vdl1pyEvzJ/kBu7OBUS1feBxb6eI3+Dn2ojh9PtUchhq0IdrMsIJ3Z19LlNhU+ZMQ=
X-Received: by 2002:aca:180b:: with SMTP id h11mr2311298oih.97.1569498470474; 
 Thu, 26 Sep 2019 04:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAKXe6SJfZt8WcA43Vsh0=GT=jBedcAOUx9DNGZ4Bsvi10oCkog@mail.gmail.com>
 <b24f9938-d0a7-2680-0078-c02e1abebc59@redhat.com>
 <CAKXe6SJaNju-O8mECU18n-3W3OnYnjnOUCKfAmTK32LAXj0nng@mail.gmail.com>
 <a7687447-5df8-bb08-b78b-bef0321b40a9@redhat.com>
In-Reply-To: <a7687447-5df8-bb08-b78b-bef0321b40a9@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 26 Sep 2019 19:47:14 +0800
Message-ID: <CAKXe6SLf7S+qAhm7n1N-jL-OrTnGfWooxLMhqznrvJTt43L9Qw@mail.gmail.com>
Subject: Re: Questions about the real mode in kvm/qemu
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000cee86b059373565d"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.170
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

--000000000000cee86b059373565d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paolo Bonzini <pbonzini@redhat.com> =E4=BA=8E2019=E5=B9=B49=E6=9C=8826=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:53=E5=86=99=E9=81=93=EF=BC=9A

> On 26/09/19 11:35, Li Qiang wrote:
> > So without unrestrict guest the mainline is this: KVM set guest's
> > rflag bit X86_EFLAGS_VM, so when the guest enter guest mode, it is in
> > vm86 mode. In this mode, the CPU will access the address like in
> > real mode(seg*4+offset), this address is linear address. And in fact,
> > the vm86 is still in protected, so the linear address will be
> > translated to gpa by the identity mapping table. Then goes to EPT
> > table?
>
> Yes.
>
> >     ... as soon as the guest tries to enter protected mode, it will get
> into
> >     a situation which is not real mode but doesn't have the segment
> >     registers properly loaded with selectors.
> >
> >     Therefore, it will either
> >     hack things together (enter_pmode) or emulate instructions until th=
e
> >     state is accepted even without unrestricted guest support.
> >
> > Could you please explain this situation more detailed? Why this happen?
>
> Protected mode entry looks like this:
>
>         mov %cr0, %eax
>         or $1, %al
>         mov %eax, %cr0
>         # [1] now in 16-bit protected mode
>         lgdtl gdt32
>         ljmpl $8, 2f
>         # [2] now in 32-bit protected mode
> 2:
>         .code32
>         mov $16, %ax
>         mov %ax, %ds
>         mov %ax, %es
>         mov %ax, %fs
>         mov %ax, %gs
>         mov %ax, %ss
>         # [3] now everything is okay
>
> Between [1] and [3] the vmentry could fail if not in unrestricted mode.
>  For example (see checks on guest segment registers in the SDM):
>
> - "CS. Type must be 9, 11, 13, or 15 (accessed code segment)."  CS in
> real-mode is a RW data segment, not a code segment.  This applies
> between [1] and [2].
>
> - "SS. If the guest will not be virtual-8086 and the =E2=80=9Cunrestricte=
d
> guest=E2=80=9D VM-execution control is 0, the RPL (bits 1:0) must equal t=
he RPL
> of the selector field for CS."  This may not be the case if the segment
> register still holds real-mode values (which are not selectors, just
> base >> 4).  This applies between [1] and [3].
>
> - "DS, ES, FS, GS. The DPL cannot be less than the RPL in the selector
> field"   Again, the real-mode DPL is zero but the RPL makes no sense if
> the segment registers hold a real-mode value.
>
> You can find more about these checks in guest_state_valid(); look at the
> "else" branch of that function, the "then" branch is for pmode->rmode
> transitions.  When any of the checks fail, KVM emulates instructions
> instead of using VMX non-root mode (usually it's just a handful of them,
> as in the case above).
>
>
Thanks so much for your explanation. I will read the code more to
strengthen my understanding.

Thanks,
Li Qiang



> Paolo
>
>

--000000000000cee86b059373565d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Paolo Bonzini &lt;<a href=3D"mailto:p=
bonzini@redhat.com">pbonzini@redhat.com</a>&gt; =E4=BA=8E2019=E5=B9=B49=E6=
=9C=8826=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:53=E5=86=99=E9=81=
=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
26/09/19 11:35, Li Qiang wrote:<br>
&gt; So without unrestrict guest the mainline is this: KVM set guest&#39;s<=
br>
&gt; rflag bit X86_EFLAGS_VM, so when the guest enter guest mode, it is in<=
br>
&gt; vm86 mode. In this mode, the CPU will access the address like in<br>
&gt; real mode(seg*4+offset), this address is linear address. And in fact,<=
br>
&gt; the vm86 is still in protected, so the linear address will be<br>
&gt; translated to gpa by the identity mapping table. Then goes to EPT<br>
&gt; table?<br>
<br>
Yes.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0... as soon as the guest tries to enter protected m=
ode, it will get into<br>
&gt;=C2=A0 =C2=A0 =C2=A0a situation which is not real mode but doesn&#39;t =
have the segment<br>
&gt;=C2=A0 =C2=A0 =C2=A0registers properly loaded with selectors.=C2=A0=C2=
=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Therefore, it will either<br>
&gt;=C2=A0 =C2=A0 =C2=A0hack things together (enter_pmode) or emulate instr=
uctions until the<br>
&gt;=C2=A0 =C2=A0 =C2=A0state is accepted even without unrestricted guest s=
upport.<br>
&gt; <br>
&gt; Could you please explain this situation more detailed? Why this happen=
?<br>
<br>
Protected mode entry looks like this:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mov %cr0, %eax<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 or $1, %al<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mov %eax, %cr0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # [1] now in 16-bit protected mode<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 lgdtl gdt32<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ljmpl $8, 2f<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # [2] now in 32-bit protected mode<br>
2:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .code32<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mov $16, %ax<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mov %ax, %ds<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mov %ax, %es<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mov %ax, %fs<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mov %ax, %gs<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mov %ax, %ss<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # [3] now everything is okay<br>
<br>
Between [1] and [3] the vmentry could fail if not in unrestricted mode.<br>
=C2=A0For example (see checks on guest segment registers in the SDM):<br>
<br>
- &quot;CS. Type must be 9, 11, 13, or 15 (accessed code segment).&quot;=C2=
=A0 CS in<br>
real-mode is a RW data segment, not a code segment.=C2=A0 This applies<br>
between [1] and [2].<br>
<br>
- &quot;SS. If the guest will not be virtual-8086 and the =E2=80=9Cunrestri=
cted<br>
guest=E2=80=9D VM-execution control is 0, the RPL (bits 1:0) must equal the=
 RPL<br>
of the selector field for CS.&quot;=C2=A0 This may not be the case if the s=
egment<br>
register still holds real-mode values (which are not selectors, just<br>
base &gt;&gt; 4).=C2=A0 This applies between [1] and [3].<br>
<br>
- &quot;DS, ES, FS, GS. The DPL cannot be less than the RPL in the selector=
<br>
field&quot;=C2=A0 =C2=A0Again, the real-mode DPL is zero but the RPL makes =
no sense if<br>
the segment registers hold a real-mode value.<br>
<br>
You can find more about these checks in guest_state_valid(); look at the<br=
>
&quot;else&quot; branch of that function, the &quot;then&quot; branch is fo=
r pmode-&gt;rmode<br>
transitions.=C2=A0 When any of the checks fail, KVM emulates instructions<b=
r>
instead of using VMX non-root mode (usually it&#39;s just a handful of them=
,<br>
as in the case above).<br>
<br></blockquote><div><br></div><div>Thanks so much for your explanation. I=
 will read the code more to strengthen my understanding.</div><div><br></di=
v><div>Thanks,</div><div>Li Qiang</div><div><br></div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
Paolo<br>
<br>
</blockquote></div></div>

--000000000000cee86b059373565d--

