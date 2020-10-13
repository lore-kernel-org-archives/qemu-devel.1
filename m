Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,PLING_QUERY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAB0C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 05:34:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90571208FE
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 05:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uUOPMILP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90571208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSCxP-0003bX-79
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 01:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hiharryharryharry@gmail.com>)
 id 1kSCwY-0002w3-Ls
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 01:33:50 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e]:46869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hiharryharryharry@gmail.com>)
 id 1kSCwW-00060H-MZ
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 01:33:50 -0400
Received: by mail-lf1-x12e.google.com with SMTP id v6so5064363lfa.13
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 22:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dx0F+vI8R+pvBoZ0xnOmUSlAROeKrp9ZQnZ43g7HXCA=;
 b=uUOPMILP+ssp72TPM6e1fh8Hv16B4l0jx92kpV1qM4gt78udymbVB6Oj3nMCFT/pAi
 f2QfnKErYUKfe/WTgjdBQQ4HhCZcMyvw8ar7WDtc5CT5zlui0aA3YRY9opMz7+Km7Nvr
 MknBadsxClZw75QdzMRSghE8NToVzZ/sLA8gW4Uj2rRt+rHzDXrKJtSj6KxXchAFY4vH
 YldnWuwgOCXL5olWgauJIbTpov/Vy82vzpLqGx4dJcrx9xmtD6hzF2ZPZneZlnpR65B8
 DRi/NwfYtXoYmNc31VOKnrZDHSJrDPTt7+Bu6znjuQ3G/h5IUGk15UylgxYwU5L2Fyvk
 29yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dx0F+vI8R+pvBoZ0xnOmUSlAROeKrp9ZQnZ43g7HXCA=;
 b=rrwMICgALEnugj5cSPHxR8XEze5l4054I8mUpAN32CuCJ39Ax6BJMWWcuE4cU3fcau
 Bsj6rMtFn05y2DXU2d+6uve6jLumnrX9fV4yf54C7WVjIRgDuFieYIOhoT0ebSeO4pLY
 b21kOLJrOJNGCfrrdx7jm/rlh5BujVZ1SteRb/r+SKDggeXnzzS+2zayExFZALGcvFvG
 eDIDYBgZEbmsgyrOOpJIgcfCgNZM3J3wMpWVohOBUzd1/y7VeJ4zUTOw55qvDdaDoSN3
 s4yo79VPetyrEFfJ5zOcuWXD5spnelcCl9TmU1Qkyj4O7kbmvEZljFYNUIvngeMY7zvf
 hvKA==
X-Gm-Message-State: AOAM530DDgXX058qYPDWI/eeCqCS2fLDOpiow14u79Ez+oOdtiQW018X
 0/lZtSuuCKWNka4rgnph6Ww6mJ8YByd7okFtmKM=
X-Google-Smtp-Source: ABdhPJxVlGQ3vF8bEauHbl+KNjUDKmbEo2VZiHXU0VsmUxxovLxXYiY+7IwSJgUavM9FzxA8o3hxHDrEU8rHkdhLOJc=
X-Received: by 2002:a19:4bd4:: with SMTP id y203mr3573780lfa.539.1602567226141; 
 Mon, 12 Oct 2020 22:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <CA+-xGqMd4_58_+QKetjOsubBqrDnaYF+YWE3TC3kEcNGxPiPfg@mail.gmail.com>
 <47ead258320536d00f9f32891da3810040875aff.camel@redhat.com>
 <CA+-xGqOm2sWbxR=3W1pWrZNLOt7EE5qiNWxMz=9=gmga15vD2w@mail.gmail.com>
 <20201012165428.GD26135@linux.intel.com>
 <CA+-xGqPkkiws0bxrzud_qKs3ZmKN9=AfN=JGephfGc+2rn6ybw@mail.gmail.com>
 <20201013045245.GA11344@linux.intel.com>
In-Reply-To: <20201013045245.GA11344@linux.intel.com>
From: harry harry <hiharryharryharry@gmail.com>
Date: Tue, 13 Oct 2020 01:33:28 -0400
Message-ID: <CA+-xGqO4DtUs3-jH+QMPEze2GrXwtNX0z=vVUVak5HOpPKaDxQ@mail.gmail.com>
Subject: Re: Why guest physical addresses are not the same as the
 corresponding host virtual addresses in QEMU/KVM? Thanks!
To: Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: multipart/alternative; boundary="0000000000003e2fc205b186c214"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=hiharryharryharry@gmail.com; helo=mail-lf1-x12e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, PLING_QUERY=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kvm@vger.kernel.org, libvir-list@redhat.com, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, mathieu.tarral@protonmail.com,
 stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003e2fc205b186c214
Content-Type: text/plain; charset="UTF-8"

Hi Sean,

Thanks for the prompt reply. Please see my following reply. Thanks.

On Tue, Oct 13, 2020 at 12:52 AM Sean Christopherson <
sean.j.christopherson@intel.com> wrote:
>
> On Tue, Oct 13, 2020 at 12:30:39AM -0400, harry harry wrote:
> > Hi Sean,
> >
> > Thank you very much for your thorough explanations. Please see my
> > inline replies as follows. Thanks!
> >
> > On Mon, Oct 12, 2020 at 12:54 PM Sean Christopherson
> > <sean.j.christopherson@intel.com> wrote:
> > >
> > > No, the guest physical address spaces is not intrinsically tied to
the host
> > > virtual address spaces.  The fact that GPAs and HVAs are related in
KVM is a
> > > property KVM's architecture.  EPT/NPT has absolutely nothing to do
with HVAs.
> > >
> > > As Maxim pointed out, KVM links a guest's physical address space,
i.e. GPAs, to
> > > the host's virtual address space, i.e. HVAs, via memslots.  For all
intents and
> > > purposes, this is an extra layer of address translation that is
purely software
> > > defined.  The memslots allow KVM to retrieve the HPA for a given GPA
when
> > > servicing a shadow page fault (a.k.a. EPT violation).
> > >
> > > When EPT is enabled, a shadow page fault due to an unmapped GPA will
look like:
> > >
> > >  GVA -> [guest page tables] -> GPA -> EPT Violation VM-Exit
> > >
> > > The above walk of the guest page tables is done in hardware.  KVM
then does the
> > > following walks in software to retrieve the desired HPA:
> > >
> > >  GPA -> [memslots] -> HVA -> [host page tables] -> HPA
> >
> > Do you mean that GPAs are different from their corresponding HVAs when
> > KVM does the walks (as you said above) in software?
>
> What do you mean by "different"?  GPAs and HVAs are two completely
different
> address spaces.

Let me give you one concrete example as follows to explain the meaning of
``different''.

Suppose a program is running in a single-vCPU VM. The program allocates and
references one page (e.g., array[1024*4]). Assume that allocating and
referencing the page in the guest OS triggers a page fault and host OS
allocates a machine page to back it.

Assume that GVA of array[0] is 0x000000000021 and its corresponding GPA is
0x0000000000000081. I think array[0]'s corresponding HVA should also be
0x0000000000000081, which is the same as array[0]'s GPA. If array[0]'s HVA
is not 0x0000000000000081, array[0]'s GPA is* different* from its
corresponding HVA.

Now, let's assume array[0]'s GPA is different from its corresponding HVA. I
think there might be one issue like this: I think MMU's hardware logic to
translate ``GPA ->[extended/nested page tables] -> HPA''[1] should be the
same as ``VA-> [page tables] -> PA"[2]; if true, how does KVM find the
correct HPA with the different HVA (e.g., array[0]'s HVA is not
0x0000000000000081) when there are EPT violations?

[1] Please note that this hardware walk is the last step, which only
translates the guest physical address to the host physical address through
the four-level nested page table.
[2] Please note that this hardware walk assumes translating the VA to the
PA without virtualization involvement.

Please note that the above addresses are not real and just use for
explanations.

Thanks,
Harry

--0000000000003e2fc205b186c214
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Sean,<br><br>Thanks for the prompt reply. Please see my=
 following reply. Thanks.<br><br>On Tue, Oct 13, 2020 at 12:52 AM Sean Chri=
stopherson &lt;<a href=3D"mailto:sean.j.christopherson@intel.com" target=3D=
"_blank">sean.j.christopherson@intel.com</a>&gt; wrote:<br>&gt;<br>&gt; On =
Tue, Oct 13, 2020 at 12:30:39AM -0400, harry harry wrote:<br>&gt; &gt; Hi S=
ean,<br>&gt; &gt;<br>&gt; &gt; Thank you very much for your thorough explan=
ations. Please see my<br>&gt; &gt; inline replies as follows. Thanks!<br>&g=
t; &gt;<br>&gt; &gt; On Mon, Oct 12, 2020 at 12:54 PM Sean Christopherson<b=
r>&gt; &gt; &lt;<a href=3D"mailto:sean.j.christopherson@intel.com" target=
=3D"_blank">sean.j.christopherson@intel.com</a>&gt; wrote:<br>&gt; &gt; &gt=
;<br>&gt; &gt; &gt; No, the guest physical address spaces is not intrinsica=
lly tied to the host<br>&gt; &gt; &gt; virtual address spaces.=C2=A0 The fa=
ct that GPAs and HVAs are related in KVM is a<br>&gt; &gt; &gt; property KV=
M&#39;s architecture.=C2=A0 EPT/NPT has absolutely nothing to do with HVAs.=
<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; As Maxim pointed out, KVM links a gues=
t&#39;s physical address space, i.e. GPAs, to<br>&gt; &gt; &gt; the host&#3=
9;s virtual address space, i.e. HVAs, via memslots.=C2=A0 For all intents a=
nd<br>&gt; &gt; &gt; purposes, this is an extra layer of address translatio=
n that is purely software<br>&gt; &gt; &gt; defined.=C2=A0 The memslots all=
ow KVM to retrieve the HPA for a given GPA when<br>&gt; &gt; &gt; servicing=
 a shadow page fault (a.k.a. EPT violation).<br>&gt; &gt; &gt;<br>&gt; &gt;=
 &gt; When EPT is enabled, a shadow page fault due to an unmapped GPA will =
look like:<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; =C2=A0GVA -&gt; [guest page =
tables] -&gt; GPA -&gt; EPT Violation VM-Exit<br>&gt; &gt; &gt;<br>&gt; &gt=
; &gt; The above walk of the guest page tables is done in hardware.=C2=A0 K=
VM then does the<br>&gt; &gt; &gt; following walks in software to retrieve =
the desired HPA:<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; =C2=A0GPA -&gt; [memsl=
ots] -&gt; HVA -&gt; [host page tables] -&gt; HPA<br>&gt; &gt;<br>&gt; &gt;=
 Do you mean that GPAs are different from their corresponding HVAs when<br>=
&gt; &gt; KVM does the walks (as you said above) in software?<br>&gt;<br>&g=
t; What do you mean by &quot;different&quot;?=C2=A0 GPAs and HVAs are two c=
ompletely different<br>&gt; address spaces.<br><br>Let me give you one conc=
rete example as follows to explain the meaning of ``different&#39;&#39;.<br=
><br>Suppose a program is running in a single-vCPU VM. The program allocate=
s and references one page (e.g., array[1024*4]). Assume that allocating and=
 referencing the page in the guest OS triggers a page fault and host OS all=
ocates a machine page to back it.<br><br>Assume that GVA of array[0] is 0x0=
00000000021 and its corresponding GPA is 0x0000000000000081. I think array[=
0]&#39;s corresponding HVA should also be 0x0000000000000081, which is the =
same as array[0]&#39;s GPA. If array[0]&#39;s HVA is not 0x0000000000000081=
, array[0]&#39;s GPA is<b><font color=3D"#ff0000"> different</font></b> fro=
m its corresponding HVA.<div><br></div><div>Now, let&#39;s assume array[0]&=
#39;s GPA is different from its corresponding HVA. I think there might be o=
ne issue like this: I think MMU&#39;s=C2=A0hardware logic to translate ``GP=
A -&gt;[extended/nested page tables] -&gt; HPA&#39;&#39;[1] should be the s=
ame as ``VA-&gt; [page tables] -&gt; PA&quot;[2]; if=C2=A0true, how does KV=
M find the correct HPA with the different HVA (e.g., array[0]&#39;s HVA is =
not=C2=A0

0x0000000000000081) when there are EPT violations?<br><br>[1] Please note t=
hat this hardware walk is the last step, which only translates the guest ph=
ysical address to the host physical address through the four-level nested p=
age table.<br>[2] Please note that this hardware walk assumes translating t=
he VA to the PA without virtualization involvement.<br><div><br></div><div>=
Please note that the above addresses are not real and just use for explanat=
ions.</div></div><div><br></div><div>Thanks,</div><div>Harry</div></div>

--0000000000003e2fc205b186c214--

