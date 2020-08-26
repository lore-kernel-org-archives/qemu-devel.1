Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388D7C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:03:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2F722074A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrw9AVpQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F722074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAwxL-0005ED-6R
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1kAwvK-0002kG-FW
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:01:15 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:39490)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1kAwvI-0001La-CC
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:01:14 -0400
Received: by mail-pl1-x631.google.com with SMTP id p15so1016287pli.6
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 08:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=E02HWjZWHfQwIiD055x81zhbBKRE6HZYqAgqxnfXohk=;
 b=qrw9AVpQ4QvxntyY6ie4WQ1Xu1hlgOYU41McgjyqoVL5kVV+us71TK9teC06MPOZBR
 kZ7fMpBt36o3EkP35KCXgBK/vqaZy9q+EJgyaoC5SKqY4KkAFQbe3uDR78oS0HadhV4W
 cJkDbXEnd8Kvi1gcwAKYYfaM4wB4pc6/0nMDQqADdI6GB4B4yX7W15xyjYo/csJEeMQE
 vMRgGkApyFTpjptFyGwDDAU0iGzVE0kD50G7tTH4mBdRREt4+p3zvWENrF3rgCoLPM1g
 LFDA5O8EvlZTgLaTo980mvov1D/7HxrRXSVUWd/o8Mahgv0gizjsvOfLES4CFvl5gMK2
 W8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E02HWjZWHfQwIiD055x81zhbBKRE6HZYqAgqxnfXohk=;
 b=dVYttE6bH3b9SmAKxVqHNnEpHz5o2TLsyqMYDUHjsNIYLUy2JTDHsAZMFnhPKVH94B
 JnKOHKsX86MDMtYIsAKcQGpN+rDcK6gJGW5juEdIqSrvAViesHVs7bK3XbHqvmeqJrlP
 hLUF5biJ0c48OtiXmpBPSoFnKBDYBWSZB8g30NJ3zYP99gYzZdtPw4BUE85f1+9b3ttl
 lp4r89vFqc7XdMfDfbLZcbaylKGObOifLL/2OjOxa+N/e9aIDoUnb8DYKECRsPWhwmPG
 yc8n8mmspiCCdK40MJZ01qcTH6Jf59fYz4bmMTXGQvRpF8O6Fj4uHuc4QLPl8ga9d2f2
 ZhhQ==
X-Gm-Message-State: AOAM530CxyUw+1LmfG4Sz/+o7xci5EpWQtqiuaG06KlZ7GlslavyqDak
 jVTaMUZGv6Msl45E6R2Sl/jXQOKfQZkCiUgFvsk=
X-Google-Smtp-Source: ABdhPJyGvl2OhHRMwO8dLy4JY74Qb8XKDLiQ/rlcmPHkv5LQXglsQJoTtM0tOYeDgXFDR7d1SyZvhm6fuOsG1f1CTCI=
X-Received: by 2002:a17:90a:9c3:: with SMTP id
 61mr6748090pjo.191.1598454068516; 
 Wed, 26 Aug 2020 08:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <CA+Ai=tAypbso9yMy0jtyzbeHCweQ1FPgDaJ8=bXxFvBA6pZyLA@mail.gmail.com>
 <CA+Ai=tBJqLB7yDbd-kqzDhr+d+65K9r3DQsZrB2kGi9wF8BaiA@mail.gmail.com>
 <2d69f1ac-df97-9d70-d2e2-e9cf27cf9b0c@redhat.com>
In-Reply-To: <2d69f1ac-df97-9d70-d2e2-e9cf27cf9b0c@redhat.com>
From: Rohit Shinde <rohit.shinde12194@gmail.com>
Date: Wed, 26 Aug 2020 11:00:57 -0400
Message-ID: <CA+Ai=tCk-XX7yogRu=zoKxDv7okRHXibbnT9OoMs8XpHs9yDkA@mail.gmail.com>
Subject: Re: Contributor wanting to get started with simple contributions
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f19d6305adc916fb"
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=rohit.shinde12194@gmail.com; helo=mail-pl1-x631.google.com
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
Cc: crosa@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f19d6305adc916fb
Content-Type: text/plain; charset="UTF-8"

Hey Thomas,

I didn't really have any specific questions. I wanted to know if there was
any part of qemu that I could contribute to. Qemu is overwhelmingly vast
and without some pointers, I felt very lost.



On Tue, Aug 25, 2020 at 1:51 AM Thomas Huth <thuth@redhat.com> wrote:

> On 25/08/2020 04.26, Rohit Shinde wrote:
> > Hey John,
> >
> > I sent this email a couple of weeks ago to the qemu mailing list since I
> > didn't really know who to approach.
>
>   Hi Rohit,
>
> The qemu-devel mailing list is very high traffic. So I'm sorry, but you
> might need to be a little bit more specific with your questions if you
> expect an answer...
>
> >     I have built qemu from source and I have my machine setup for
> >     git-publish via email.
> >
> >     I would like to start contributing with one of the bite sized tasks
> >     mentioned in the wiki page. The one that interests me and which I
> >     think is the easiest are the sections on "Compiler Driven Cleanup"
> >     and "Dead Code Removal". I think this is a good way to get
> >     introduced to the codebase.
>
> Sure, just go ahead and have a try! Once you've successfully wrote a
> patch, please have a look at
> https://wiki.qemu.org/Contribute/SubmitAPatch how to submit it.
>
> >     I plan to stay and become a long term contributor. Is there any CS
>
> What does "CS" stand for?
>
Computer Science :)

>
> >     theory that I would need to know other than what I mentioned above?
> >     Is it possible to "learn on the go"?
>
> You certainly have to "learn on the go", since it is likely quite
> impossible to grasp a huge project like QEMU at once.
>
> I am interested in contributing to something like device emulation. There
might be lots of devices which Qemu might want to emulate but which haven't
yet been emulated. If possible, I would like to give that a shot. However,
there was work related to python packaging as well, which I had commented
on in Launchpad. John told me quite a bit about that as well. I am
interested in that as well. I have already submitted a trivial patch for
handling compiler warnings and I am trying to get it accepted.

  Cheers,
>    Thomas
>
>
Thanks,
Rohit.

--000000000000f19d6305adc916fb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hey Thomas,<div><br></div><div>I didn&#39=
;t really have any specific questions. I wanted to know if there was any pa=
rt of qemu that I could contribute to. Qemu is overwhelmingly vast and with=
out some pointers, I felt very lost.</div><div><br></div><div><br></div></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On =
Tue, Aug 25, 2020 at 1:51 AM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat=
.com">thuth@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On 25/08/2020 04.26, Rohit Shinde wrote:<br>
&gt; Hey John,<br>
&gt; <br>
&gt; I sent this email a couple of weeks ago to the qemu mailing list since=
 I <br>
&gt; didn&#39;t really know who to approach.<br>
<br>
=C2=A0 Hi Rohit,<br>
<br>
The qemu-devel mailing list is very high traffic. So I&#39;m sorry, but you=
 <br>
might need to be a little bit more specific with your questions if you <br>
expect an answer...<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0I have built qemu from source and I have my machine=
 setup for<br>
&gt;=C2=A0 =C2=A0 =C2=A0git-publish via email.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I would like to start contributing with one of the =
bite sized tasks<br>
&gt;=C2=A0 =C2=A0 =C2=A0mentioned in the wiki page. The one that interests =
me and which I<br>
&gt;=C2=A0 =C2=A0 =C2=A0think is the easiest are the sections on &quot;Comp=
iler Driven Cleanup&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0and &quot;Dead Code Removal&quot;. I think this is =
a good way to get<br>
&gt;=C2=A0 =C2=A0 =C2=A0introduced to the codebase.<br>
<br>
Sure, just go ahead and have a try! Once you&#39;ve successfully wrote a <b=
r>
patch, please have a look at <br>
<a href=3D"https://wiki.qemu.org/Contribute/SubmitAPatch" rel=3D"noreferrer=
" target=3D"_blank">https://wiki.qemu.org/Contribute/SubmitAPatch</a> how t=
o submit it.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0I plan to stay and become a long term contributor. =
Is there any CS<br>
<br>
What does &quot;CS&quot; stand for?<br></blockquote><div>Computer Science :=
)=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0theory that I would need to know other than what I =
mentioned above?<br>
&gt;=C2=A0 =C2=A0 =C2=A0Is it possible to &quot;learn on the go&quot;?<br>
<br>
You certainly have to &quot;learn on the go&quot;, since it is likely quite=
 <br>
impossible to grasp a huge project like QEMU at once.<br>
<br></blockquote><div>I am interested in contributing to something like dev=
ice emulation. There might be lots of devices which Qemu might want to emul=
ate but which haven&#39;t yet been emulated. If possible, I would like to g=
ive that a shot. However, there was work related to python packaging as wel=
l, which I had commented on in Launchpad. John told me quite a bit about th=
at as well. I am interested in that as well. I have already submitted a tri=
vial patch for handling compiler warnings and I am trying to get it accepte=
d.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 Cheers,<br>
=C2=A0 =C2=A0Thomas<br>
<br></blockquote><div><br></div><div>Thanks,</div><div>Rohit.=C2=A0</div></=
div></div>

--000000000000f19d6305adc916fb--

