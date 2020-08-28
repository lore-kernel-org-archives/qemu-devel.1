Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E308CC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 00:50:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B30B92071B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 00:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdqovSRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30B92071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBSb4-0000wW-Mq
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 20:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1kBSaM-0000U3-Rh
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 20:49:44 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d]:40375)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1kBSaK-0004kF-Oq
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 20:49:42 -0400
Received: by mail-pj1-x102d.google.com with SMTP id kx11so3472342pjb.5
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 17:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pKrumPrerWc7DalgYnPfYybOvhZKEtNcwG+RAuZfMAE=;
 b=RdqovSRc223knmJY/h4a2SmB+5GDXAFBFsvJM5MbS17H4f4ic9gHQm+AVgwXE40N0G
 May1a3xk9pUR8hA6hTBjSAK+8DMFO+YCEcsUiyAfJfY0iAuWBdnnmAwJQGpQvh2NRJgU
 AsyA/cUBcTMCVmOiOgLwLSJcbEAcZj6tMj1KXrNasEmvKLQQ3I5f8E3A8/3bi7M98bEr
 bhV6vh80o/PjgBqW7c+xfqK8ogpm0a9bpq6V+Q6tgJXTh4Hj12KEe4DaeSr+ltueDnhZ
 qiXcM0bK2i4OTHMm+xdKC6xB0+WweA6ILVl8jDYyr5WpTBJVEKd0rN7m5DHf6cSN4wX/
 7pAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pKrumPrerWc7DalgYnPfYybOvhZKEtNcwG+RAuZfMAE=;
 b=QoFyzoznQN+kN5NpINdFfeFWXqWHyIsQ8b7xrOQUj2C/SVNxNWZd/6ui67Vvyaj4NP
 XA71tqaONq/K77v986Gw9TKWP/OXoz9YH2kDHg1J5DVxq39gGU0TUM0H4hI6E3xtFHpD
 02EpcnH6E+p6ClmLhV4WSrLzLqh2VOKaPW+BHrhAlkYh/K7VZGXk7a/K8vMRkoz8PPVQ
 Wjj6jdOjbkEd0LuQnOF0pe8B0Rl+/qbCTmixyKGlfRWnpk1tBAnBdt61n4SnX60nCMcO
 sR2oKBRHI8cxiNtIzqn8S9IQTYRU8QgIrTKHmQ0sZCdrgfSDLbF85JSgKUHjdnAo2tkW
 VQTg==
X-Gm-Message-State: AOAM5303rJe/CIV/Lyh6/LktwBH7FkKEt7dDsouE0adojfd0YhKWm7Km
 n0vngf7ZWgsPcXmxLmljiEcBxhC/9chnho9p0J0=
X-Google-Smtp-Source: ABdhPJwjWx9NHHDo3MBADxvjKjTvP8hjl1hKvlbMwlDKYR01fxKxyvp7ixfbMjrYg8+jd2m2ruBdphmM+BAQ4qXqkMo=
X-Received: by 2002:a17:90a:9c3:: with SMTP id 61mr183947pjo.191.1598575779120; 
 Thu, 27 Aug 2020 17:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <CA+Ai=tAypbso9yMy0jtyzbeHCweQ1FPgDaJ8=bXxFvBA6pZyLA@mail.gmail.com>
 <CA+Ai=tBJqLB7yDbd-kqzDhr+d+65K9r3DQsZrB2kGi9wF8BaiA@mail.gmail.com>
 <2d69f1ac-df97-9d70-d2e2-e9cf27cf9b0c@redhat.com>
 <CA+Ai=tCk-XX7yogRu=zoKxDv7okRHXibbnT9OoMs8XpHs9yDkA@mail.gmail.com>
 <15d81509-81d4-d583-16c6-3407efd26f12@redhat.com>
In-Reply-To: <15d81509-81d4-d583-16c6-3407efd26f12@redhat.com>
From: Rohit Shinde <rohit.shinde12194@gmail.com>
Date: Thu, 27 Aug 2020 17:49:29 -0700
Message-ID: <CA+Ai=tBJ+Z9ETMLu4muhA40F6V7OAjWC7-SyB+k7GDsHvYj4WQ@mail.gmail.com>
Subject: Re: Contributor wanting to get started with simple contributions
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000760be105ade56d9b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=rohit.shinde12194@gmail.com; helo=mail-pj1-x102d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000760be105ade56d9b
Content-Type: text/plain; charset="UTF-8"

Hey Thomas,

Thanks for the in-depth response! I appreciate it a lot!



On Wed, Aug 26, 2020 at 9:38 PM Thomas Huth <thuth@redhat.com> wrote:

> On 26/08/2020 17.00, Rohit Shinde wrote:
> > Hey Thomas,
> >
> > I didn't really have any specific questions. I wanted to know if there
> > was any part of qemu that I could contribute to. Qemu is overwhelmingly
> > vast and without some pointers, I felt very lost.
>
> Ok, that's true - QEMU is really a huge project. I'd really recommend to
> pick some topics from https://wiki.qemu.org/Contribute/BiteSizedTasks
> first to get a feeling for contributing patches to QEMU. Since you're
> interested in emulation, maybe the topics from the "Device models"
> section would also be a good fit?
>
> >     >     I plan to stay and become a long term contributor. Is there
> any CS
> >
> >     What does "CS" stand for?
> >
> > Computer Science :)
>
> Oh, well, thanks, ok, that was too easy. I guess there are just too many
> abbreviations around ;-)
>
> >
> >     >     theory that I would need to know other than what I mentioned
> >     above?
>
> I'd recommend to browse the various KVM forum presentations on
> http://www.linux-kvm.org/page/Category:Conferences to see if there is
> something that catches your eye. You can find the recordings of most
> presentations on
> https://www.youtube.com/channel/UCRCSQmAOh7yzgheq-emy1xA , too.
>
> >     >     Is it possible to "learn on the go"?
> >
> >     You certainly have to "learn on the go", since it is likely quite
> >     impossible to grasp a huge project like QEMU at once.
> >
> > I am interested in contributing to something like device emulation.
> > There might be lots of devices which Qemu might want to emulate but
> > which haven't yet been emulated.
> Sure, but I think you first need a target you're interested in first.
> E.g. do you want to focus on x86, ARM, PPC, m68k, ... ? Depending on
> that, you can start looking around in the hw/ directory for "missing" or
> "TODO" items.
>
I am pretty familiar with the x86 architecture since I have worked with
processors right from 8086 to the Pentium line of processors. I have a nice
familiarity with x86_64. I have a passing familiarity with ARM and SPARC
architectures, but not much more. So I think I would like to focus on the
x86 architecture. I'll poke around the hw/ directory. Please feel free to
give me pointers in the meanwhile.

>
>  Thomas
>
>
Since I am new to the community, I wanted to make sure if it is fine if I
post general questions to the mailing list and copy you? I see that all the
posts in the mailing list are mostly patches and nothing else.

Thanks,
Rohit.

--000000000000760be105ade56d9b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hey Thomas,<div><br></div><div>Thanks for=
 the in-depth response! I appreciate it a lot!</div><div><br></div><div><br=
></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Wed, Aug 26, 2020 at 9:38 PM Thomas Huth &lt;<a href=3D"mailto:th=
uth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On 26/08/2020 17.00, Rohit Shinde wrote:<b=
r>
&gt; Hey Thomas,<br>
&gt; <br>
&gt; I didn&#39;t really have any specific questions. I wanted to know if t=
here<br>
&gt; was any part of qemu that I could contribute to. Qemu is overwhelmingl=
y<br>
&gt; vast and without some pointers, I felt very lost.<br>
<br>
Ok, that&#39;s true - QEMU is really a huge project. I&#39;d really recomme=
nd to<br>
pick some topics from <a href=3D"https://wiki.qemu.org/Contribute/BiteSized=
Tasks" rel=3D"noreferrer" target=3D"_blank">https://wiki.qemu.org/Contribut=
e/BiteSizedTasks</a><br>
first to get a feeling for contributing patches to QEMU. Since you&#39;re<b=
r>
interested in emulation, maybe the topics from the &quot;Device models&quot=
;<br>
section would also be a good fit?<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0I plan to stay and become a=
 long term contributor. Is there any CS<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0What does &quot;CS&quot; stand for?<br>
&gt; <br>
&gt; Computer Science :)=C2=A0<br>
<br>
Oh, well, thanks, ok, that was too easy. I guess there are just too many<br=
>
abbreviations around ;-)<br>
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0theory that I would need to=
 know other than what I mentioned<br>
&gt;=C2=A0 =C2=A0 =C2=A0above?<br>
<br>
I&#39;d recommend to browse the various KVM forum presentations on<br>
<a href=3D"http://www.linux-kvm.org/page/Category:Conferences" rel=3D"noref=
errer" target=3D"_blank">http://www.linux-kvm.org/page/Category:Conferences=
</a> to see if there is<br>
something that catches your eye. You can find the recordings of most<br>
presentations on<br>
<a href=3D"https://www.youtube.com/channel/UCRCSQmAOh7yzgheq-emy1xA" rel=3D=
"noreferrer" target=3D"_blank">https://www.youtube.com/channel/UCRCSQmAOh7y=
zgheq-emy1xA</a> , too.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Is it possible to &quot;lea=
rn on the go&quot;?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0You certainly have to &quot;learn on the go&quot;, =
since it is likely quite<br>
&gt;=C2=A0 =C2=A0 =C2=A0impossible to grasp a huge project like QEMU at onc=
e.<br>
&gt; <br>
&gt; I am interested in contributing to something like device emulation.<br=
>
&gt; There might be lots of devices which Qemu might want to emulate but<br=
>
&gt; which haven&#39;t yet been emulated.<br>
Sure, but I think you first need a target you&#39;re interested in first.<b=
r>
E.g. do you want to focus on x86, ARM, PPC, m68k, ... ? Depending on<br>
that, you can start looking around in the hw/ directory for &quot;missing&q=
uot; or<br>
&quot;TODO&quot; items.<br></blockquote><div>I am pretty familiar with the =
x86 architecture since I have worked with processors right from 8086 to the=
 Pentium line of processors. I have a nice familiarity with x86_64. I have =
a passing familiarity with ARM and SPARC architectures, but not much more. =
So I think I would like to focus on the x86 architecture. I&#39;ll poke aro=
und the hw/ directory. Please feel free to give me pointers in the meanwhil=
e.</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0Thomas<br>
<br></blockquote><div><br></div><div>Since I am new to the community, I wan=
ted to make sure if it is fine if I post general questions to the mailing l=
ist and copy you? I see that all the posts in the mailing list are mostly p=
atches and nothing else.=C2=A0</div><div><br></div><div>Thanks,</div><div>R=
ohit.</div></div></div>

--000000000000760be105ade56d9b--

