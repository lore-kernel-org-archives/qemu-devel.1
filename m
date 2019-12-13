Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BCBC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 809A221655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lx2m4Cmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 809A221655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifpop-0001N5-T1
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 13:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <waynli329@gmail.com>) id 1ifpno-0000qw-27
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 13:36:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <waynli329@gmail.com>) id 1ifpnk-0008FX-Pm
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 13:36:35 -0500
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132]:41647)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <waynli329@gmail.com>) id 1ifpnk-0008AE-E3
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 13:36:32 -0500
Received: by mail-il1-x132.google.com with SMTP id f10so226682ils.8
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 10:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jfQMfbcxt/GN7F55THyaQZwB2FdUzJvz8k7hQ1CU7+M=;
 b=lx2m4CmiqXA3an6TXzafYZcgzuCIpOKF3b2+4x7//NyyP62PF8YrR14bH/D3YkKjE+
 8ZMiIZ58wlyEbJUAMvx7vhp3kRZGnfUJ/JMkMZfbW9yKPDIewUVQNH7KWrc/bNu8lixT
 7DFmb+far/0r/pqY9JENOwsrJiwRYdRy6LIKYg8yrqiLJkGVmP2Veov4+UO94jzlJqPC
 BZ/gyVibhcYoaAtYUOxJO6ujfRoP49n5tQX2WN/gjo9WCzdUKYsfe/G9yz63PvJkTUxy
 n0yUY4YnE7PGzy5bL4x6h2EPTIXBxjsCP21qsaq9ij0brXWRiezwbcFouT050MnGg/1p
 KmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jfQMfbcxt/GN7F55THyaQZwB2FdUzJvz8k7hQ1CU7+M=;
 b=p1LBFL+fIybVnFCM/IKawvCnQmOnYlGY85xN2mp6jYXNUsxc4x4CTYZJTjj2jGy067
 Sb2Nnm/fH1xF6SVtxt3OZ2Nr3Px4xzHN4qIvSaGsXT1RUomWTb4k0c0XrJFsMSmDhUkV
 XL4ipop8NjKmw8unDMMSYjP0zNk5hrKss2a7sDnexJ8Ng98vUdb7TAMt4o+2KVZezwFZ
 LfqH4MY53DcdAntBpfihrdoIHZ/oIW3RMxNl6M21jBAPEjaSsF4hGqQVb6zqhICVlbOo
 zih+H/0Ehn0ry02Ufb8BHjEW+k98llXJHcMAMHpeOj92pyXaIuCRN4gb2HoEd9gxZDbK
 ycxA==
X-Gm-Message-State: APjAAAXwwIFHvV45TMh50B9j2qBHiCx6mu8XFUD1vHBZaYdzW/yMclvA
 tL/oQ3EsK2pZiw7WBHOi1/Z3BcPLiy7ghDOXAjg=
X-Google-Smtp-Source: APXvYqyBEeAHKEVyGMulbmYfNPAHuuqedFCkCmvQmN+qeSE320MC17XkeJn6BM5TKoqNv8vEXhd/d9/QKx1PANfDm1U=
X-Received: by 2002:a92:465c:: with SMTP id t89mr686411ila.263.1576262189848; 
 Fri, 13 Dec 2019 10:36:29 -0800 (PST)
MIME-Version: 1.0
References: <CAM2K0nrhkOhiJDxnANGmAu2140-TP0a9pY58i_PN1k9xAWGz9A@mail.gmail.com>
 <76b207cd-09ce-b3df-e288-a515df40677e@redhat.com>
 <CAM2K0nph2GZQkAv3tCgoP+ciPMWSzVJp0rHDXJJ2Gtqeq2Bgug@mail.gmail.com>
 <c4e14191-efe5-7713-1eac-55a6bafb027a@redhat.com>
 <CAM2K0no9-M9WRm-QKFBMRofUaNkfmMtDvop3KxrOQrU80YWSTA@mail.gmail.com>
 <20191213034937.GB207300@umbus.fritz.box>
In-Reply-To: <20191213034937.GB207300@umbus.fritz.box>
From: Wayne Li <waynli329@gmail.com>
Date: Fri, 13 Dec 2019 12:36:18 -0600
Message-ID: <CAM2K0noRK2LqV9JfWd8jezm-bZM=Qqk1rY6a+cDoHAqSafiZcQ@mail.gmail.com>
Subject: Re: QEMU VM crashes when enabling KVM
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: multipart/alternative; boundary="000000000000e61e8905999a2311"
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Received-From: 2607:f8b0:4864:20::132
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 David Gibson <dgibson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e61e8905999a2311
Content-Type: text/plain; charset="UTF-8"

Thanks David and Zalton for the awesome explanations.  They're very helpful
to us!

-Thanks, Wayne Li

On Thu, Dec 12, 2019 at 9:49 PM David Gibson <david@gibson.dropbear.id.au>
wrote:

> On Thu, Dec 12, 2019 at 10:40:44AM -0600, Wayne Li wrote:
> > Dear David Gibson,
> >
> > I know you are under no obligation to respond, but if it's possible for
> you
> > to find the time to respond to my question, I would be extremely
> grateful.
> > My team at Boeing has been stuck trying to get KVM working for our
> project
> > for the last few months.  A good explanation of why this isn't possible
> > would be absolutely critical.
>
> As you can see from that diagram, the history ppc CPUs is quite a bit
> more diverse than x86.  Although they're all very similar from the
> point of view of userspace code, they're quite different for
> privileged kernel code: they have different MMUs, different privileged
> registers amongst other things.
>
> Because of this there are several different KVM implementations.
>
> 1) KVM HV
>
> This one uses the virtualization facilities of BookS CPUs (present
> since POWER4 / 970, but only well supported from POWER7 onwards).
> Those don't allow much to virtualize the guest cpu model, so it
> assumes the guest cpu is the same as the host.
>
> So, both your guest and host CPUs rule this one out.
>
> 2) Book3E KVM
>
> Uses the virtualization features of recent enough Freescale Book E
> CPUs.  I don't know a lot about this or its limitations.  The e6500
> might well have these features, but I'm pretty sure it can only
> emulate BookE cpus for the guest.
>
> So, your guest rules this one out.
>
> 3) KVM PR
>
> This one operates by running the entire guest in user mode, and
> emulating all privileged instructions.  It's slow (relative to
> hardware assisted KVM models), but it's flexible.
>
> In theory, this one can do what you want, but there are a bunch of
> caveats:
>
>   * Emulating all the privileged instructions for a whole bunch of cpu
>   variants is a huge task, and KVM PR is now barely maintained.  There
>   are lots of gaps in coverage.
>
>   * I'm not sure if it was ever really implemented for BookE hosts.
>
>   * Although there aren't many, there are a few differences between
>   userland instructions between cpu variants, mostly because of new
>   additions.  I think 7457 is an old enough design that this probably
>   won't cause you troube, but I'm not certain.
>
>
>
> >
> > -Thanks, Wayne Li
> >
> > On Thu, Dec 12, 2019 at 1:17 AM Paolo Bonzini <pbonzini@redhat.com>
> wrote:
> >
> > > On 12/12/19 02:59, Wayne Li wrote:
> > > > We wrote a project that is created on top of the QEMU source code; it
> > > > calls functions from the QEMU code.  I run the executable created by
> > > > compiling that project/QEMU code.  Anyway, looking at the following
> 0> > > documentation:
> > > >
> > > > https://www.kernel.org/doc/Documentation/powerpc/cpu_families.txt
> > > >
> > > > It looks like the PowerPC 7457 is Book3S and the PowerPC e6500 is
> > > > BookE.  Is that why you think I require a Book3S KVM?  Exactly why do
> > > > you feel this way?  Also would that mean my team would need to go and
> > > > buy a board with a Book3S processor?
> > >
> > > CCing the PPC maintainer.  There are aspects of BookE and Book3S that
> > > are different and not really interchangeable in the privileged
> interface.
> > >
> > > Paolo
> > >
> > > > -Thanks!, Wayne Li
> > > >
> > > > From my understanding
> > > >
> > > > On Wed, Dec 11, 2019 at 7:16 PM Paolo Bonzini <pbonzini@redhat.com
> > > > <mailto:pbonzini@redhat.com>> wrote:
> > > >
> > > >     On 11/12/19 22:23, Wayne Li wrote:
> > > >     >
> > > >     > Now I am fairly sure KVM is actually enabled on the system.
> > > Finding
> > > >     > that out was another story that spanned a couple of months.
> But
> > > long
> > > >     > story short, lsmod doesn't show that the KVM kernel module is
> > > >     running.
> > > >     > But that's because KVM is built-in and it can't actually be
> built
> > > as a
> > > >     > loadable kernel module in this particular system.
> > > >     >
> > > >     > So I'm not really sure what could be the problem.  Though I was
> > > >     thinking
> > > >     > if I understood the error better that might help?  Following
> the
> > > >     code I
> > > >     > see that the "Missing PVR setting capability." is called when a
> > > >     variable
> > > >     > called "cap_segstate" is 0:
> > > >     >
> > > >     > if (!cap_segstate) {
> > > >     >             fprintf(stderr, "kvm error: missing PVR setting
> > > >     capability\n");
> > > >     >             return -ENOSYS;
> > > >     > }
> > > >     >
> > > >     > And the cap_segstate variable is set by the following function:
> > > >     >
> > > >     > cap_segstate = kvm_check_extension(s, KVM_CAP_PPC_SEGSTATE);
> > > >
> > > >     You are not saying how you are running QEMU.  I think you are
> using a
> > > >     CPU model that requires a Book3S KVM.
> > > >
> > > >     Paolo
> > > >
> > >
> > >
>
> --
> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_
> _other_
>                                 | _way_ _around_!
> http://www.ozlabs.org/~dgibson
>

--000000000000e61e8905999a2311
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks David and Zalton for the awesome explanations.=
=C2=A0 They&#39;re very helpful to us!</div><div><br></div><div>-Thanks, Wa=
yne Li<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Dec 12, 2019 at 9:49 PM David Gibson &lt;<a href=3D=
"mailto:david@gibson.dropbear.id.au">david@gibson.dropbear.id.au</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, Dec=
 12, 2019 at 10:40:44AM -0600, Wayne Li wrote:<br>
&gt; Dear David Gibson,<br>
&gt; <br>
&gt; I know you are under no obligation to respond, but if it&#39;s possibl=
e for you<br>
&gt; to find the time to respond to my question, I would be extremely grate=
ful.<br>
&gt; My team at Boeing has been stuck trying to get KVM working for our pro=
ject<br>
&gt; for the last few months.=C2=A0 A good explanation of why this isn&#39;=
t possible<br>
&gt; would be absolutely critical.<br>
<br>
As you can see from that diagram, the history ppc CPUs is quite a bit<br>
more diverse than x86.=C2=A0 Although they&#39;re all very similar from the=
<br>
point of view of userspace code, they&#39;re quite different for<br>
privileged kernel code: they have different MMUs, different privileged<br>
registers amongst other things.<br>
<br>
Because of this there are several different KVM implementations.<br>
<br>
1) KVM HV<br>
<br>
This one uses the virtualization facilities of BookS CPUs (present<br>
since POWER4 / 970, but only well supported from POWER7 onwards).<br>
Those don&#39;t allow much to virtualize the guest cpu model, so it<br>
assumes the guest cpu is the same as the host.<br>
<br>
So, both your guest and host CPUs rule this one out.<br>
<br>
2) Book3E KVM<br>
<br>
Uses the virtualization features of recent enough Freescale Book E<br>
CPUs.=C2=A0 I don&#39;t know a lot about this or its limitations.=C2=A0 The=
 e6500<br>
might well have these features, but I&#39;m pretty sure it can only<br>
emulate BookE cpus for the guest.<br>
<br>
So, your guest rules this one out.<br>
<br>
3) KVM PR<br>
<br>
This one operates by running the entire guest in user mode, and<br>
emulating all privileged instructions.=C2=A0 It&#39;s slow (relative to<br>
hardware assisted KVM models), but it&#39;s flexible.<br>
<br>
In theory, this one can do what you want, but there are a bunch of<br>
caveats:<br>
<br>
=C2=A0 * Emulating all the privileged instructions for a whole bunch of cpu=
<br>
=C2=A0 variants is a huge task, and KVM PR is now barely maintained.=C2=A0 =
There<br>
=C2=A0 are lots of gaps in coverage.<br>
<br>
=C2=A0 * I&#39;m not sure if it was ever really implemented for BookE hosts=
.<br>
<br>
=C2=A0 * Although there aren&#39;t many, there are a few differences betwee=
n<br>
=C2=A0 userland instructions between cpu variants, mostly because of new<br=
>
=C2=A0 additions.=C2=A0 I think 7457 is an old enough design that this prob=
ably<br>
=C2=A0 won&#39;t cause you troube, but I&#39;m not certain.<br>
<br>
<br>
<br>
&gt; <br>
&gt; -Thanks, Wayne Li<br>
&gt; <br>
&gt; On Thu, Dec 12, 2019 at 1:17 AM Paolo Bonzini &lt;<a href=3D"mailto:pb=
onzini@redhat.com" target=3D"_blank">pbonzini@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; On 12/12/19 02:59, Wayne Li wrote:<br>
&gt; &gt; &gt; We wrote a project that is created on top of the QEMU source=
 code; it<br>
&gt; &gt; &gt; calls functions from the QEMU code.=C2=A0 I run the executab=
le created by<br>
&gt; &gt; &gt; compiling that project/QEMU code.=C2=A0 Anyway, looking at t=
he following<br>
0&gt; &gt; &gt; documentation:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; <a href=3D"https://www.kernel.org/doc/Documentation/powerpc/=
cpu_families.txt" rel=3D"noreferrer" target=3D"_blank">https://www.kernel.o=
rg/doc/Documentation/powerpc/cpu_families.txt</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; It looks like the PowerPC 7457 is Book3S and the PowerPC e65=
00 is<br>
&gt; &gt; &gt; BookE.=C2=A0 Is that why you think I require a Book3S KVM?=
=C2=A0 Exactly why do<br>
&gt; &gt; &gt; you feel this way?=C2=A0 Also would that mean my team would =
need to go and<br>
&gt; &gt; &gt; buy a board with a Book3S processor?<br>
&gt; &gt;<br>
&gt; &gt; CCing the PPC maintainer.=C2=A0 There are aspects of BookE and Bo=
ok3S that<br>
&gt; &gt; are different and not really interchangeable in the privileged in=
terface.<br>
&gt; &gt;<br>
&gt; &gt; Paolo<br>
&gt; &gt;<br>
&gt; &gt; &gt; -Thanks!, Wayne Li<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; From my understanding<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Wed, Dec 11, 2019 at 7:16 PM Paolo Bonzini &lt;<a href=3D=
"mailto:pbonzini@redhat.com" target=3D"_blank">pbonzini@redhat.com</a><br>
&gt; &gt; &gt; &lt;mailto:<a href=3D"mailto:pbonzini@redhat.com" target=3D"=
_blank">pbonzini@redhat.com</a>&gt;&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0On 11/12/19 22:23, Wayne Li wrote:<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; Now I am fairly sure KVM is actually=
 enabled on the system.<br>
&gt; &gt; Finding<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; that out was another story that span=
ned a couple of months.=C2=A0 But<br>
&gt; &gt; long<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; story short, lsmod doesn&#39;t show =
that the KVM kernel module is<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0running.<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; But that&#39;s because KVM is built-=
in and it can&#39;t actually be built<br>
&gt; &gt; as a<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; loadable kernel module in this parti=
cular system.<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; So I&#39;m not really sure what coul=
d be the problem.=C2=A0 Though I was<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0thinking<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; if I understood the error better tha=
t might help?=C2=A0 Following the<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0code I<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; see that the &quot;Missing PVR setti=
ng capability.&quot; is called when a<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0variable<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; called &quot;cap_segstate&quot; is 0=
:<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; if (!cap_segstate) {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0fprintf(stderr, &quot;kvm error: missing PVR setting<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0capability\n&quot;);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -ENOSYS;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; }<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; And the cap_segstate variable is set=
 by the following function:<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; cap_segstate =3D kvm_check_extension=
(s, KVM_CAP_PPC_SEGSTATE);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0You are not saying how you are running QE=
MU.=C2=A0 I think you are using a<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0CPU model that requires a Book3S KVM.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0Paolo<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
<br>
-- <br>
David Gibson=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | I&#39;ll have my music baroque, and my code<br>
david AT <a href=3D"http://gibson.dropbear.id.au" rel=3D"noreferrer" target=
=3D"_blank">gibson.dropbear.id.au</a>=C2=A0 | minimalist, thank you.=C2=A0 =
NOT _the_ _other_<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | _way_ _around_!<br>
<a href=3D"http://www.ozlabs.org/~dgibson" rel=3D"noreferrer" target=3D"_bl=
ank">http://www.ozlabs.org/~dgibson</a><br>
</blockquote></div>

--000000000000e61e8905999a2311--

