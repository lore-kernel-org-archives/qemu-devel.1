Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A4DC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:42:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8296720684
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoDMgPaO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8296720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDVq9-0000Is-MD
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 12:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1kDVmr-0005OS-TU
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:39:05 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:53690)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1kDVmp-0005TV-Qe
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:39:05 -0400
Received: by mail-pj1-x1032.google.com with SMTP id k15so69116pji.3
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 09:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7QMiudE9lGXjVuhbRg0MEkhEN93KtJOdxJrgal7ZTTs=;
 b=ZoDMgPaOQi3Bl6sY55DkBYqQt8KahgBTTOELb25RMdo0oqaAGmGD3Hv9LyXFlgmjfl
 o5a5KzZvHMXC+l/EJiu+xHgGUbfv2OREklYathgID+Bt9TFwmgqAMFuZh68EI4BmtjrN
 gUexArCqa2El/woW8qk0Wx0lrF5pOP7Hi/EsImlxk+poeh4XDVjYMTSODYe3xqIEvCgm
 uBFwwMg6nvFxYs6ZBvfGN7d512G9PFNwZ/ccYWfFqeVNlWJF+gvxoeMFePr5LNUSE7AB
 qBiLv3aUoTNQkAjw/e8q700Dlcs/gfHdnY2WyM5jjlISVny9fmEz7iuUZxPebLKfIW3c
 RdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7QMiudE9lGXjVuhbRg0MEkhEN93KtJOdxJrgal7ZTTs=;
 b=hwMCJPWX/DriTCB/09BkR7jVeJrj428+ENeN49/vWR9Jcv8Z7iCbvTLeJe5LmX/UgI
 DgPyZZRSobsUJNixx81x2E7T+x4aFA+c6LQpXWQrtXSF16uTeg0quqXAE1L6WlYGE1+r
 JWzVVJnondb/UM3AeHjSt+MqiMxHg1j2G4CK1LLzJoxKC1zMnbzEvKBlIEq2qSOsDaTq
 I67EHikPF0MYxX3uRmsXmfwaEAAoQ7Jf3QUo+WlU4YRHziFjl4n6xyNoL8riOUElh/eX
 ZQrmIzM1bKXNJfRmByJ/NzAYO00oYUUG/KBS+QuSCl77A6EUSI3pBvRT/zqLZ/a/jB4R
 iYzA==
X-Gm-Message-State: AOAM532MZm64c59uM+ozzufvIYql+jhRS4k9o+Lqd0TLbY+lUH1X5deO
 fo4JZI/Mgmz3YxeegiDNvqLW8n0OBQ+kOkmsuqh7B9ATZh4=
X-Google-Smtp-Source: ABdhPJytCrz1npPQ4wSqIo2LJ67lA93InMiEWF2GkmyIqFKFMU2vMfs08igk23t1lC/tLPC9YKv/0Nu2/CzUMLEwzh8=
X-Received: by 2002:a17:90a:191a:: with SMTP id
 26mr3043623pjg.197.1599064741633; 
 Wed, 02 Sep 2020 09:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <CA+Ai=tAypbso9yMy0jtyzbeHCweQ1FPgDaJ8=bXxFvBA6pZyLA@mail.gmail.com>
 <CA+Ai=tBJqLB7yDbd-kqzDhr+d+65K9r3DQsZrB2kGi9wF8BaiA@mail.gmail.com>
 <2d69f1ac-df97-9d70-d2e2-e9cf27cf9b0c@redhat.com>
 <CA+Ai=tCk-XX7yogRu=zoKxDv7okRHXibbnT9OoMs8XpHs9yDkA@mail.gmail.com>
 <a50f47d2-f5c6-49c0-779f-dfcaf05df5f9@redhat.com>
 <CA+Ai=tCDHWBLNToQ2HqMVmJtXxKzP40AuDqfWc=YQV3mggcc4Q@mail.gmail.com>
 <CA+Ai=tAVxNRNN1EP8LorOsYBm01f0ekmKCnMfcNH_eSqk5pFzg@mail.gmail.com>
In-Reply-To: <CA+Ai=tAVxNRNN1EP8LorOsYBm01f0ekmKCnMfcNH_eSqk5pFzg@mail.gmail.com>
From: Rohit Shinde <rohit.shinde12194@gmail.com>
Date: Wed, 2 Sep 2020 12:38:50 -0400
Message-ID: <CA+Ai=tBtSqigWwB4HNeZ8CT4JMEMBU2eEd47BCs2-QCEeBEARw@mail.gmail.com>
Subject: Re: Contributor wanting to get started with simple contributions
To: John Snow <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e5e54805ae57457a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=rohit.shinde12194@gmail.com; helo=mail-pj1-x1032.google.com
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
Cc: crosa@redhat.com, QEMU Developers <qemu-devel@nongnu.org>,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e5e54805ae57457a
Content-Type: text/plain; charset="UTF-8"

Hey John,

I wanted to follow up on this, in case you missed my previous email :)

Thanks,
Rohit.

On Sat, Aug 29, 2020 at 1:14 AM Rohit Shinde <rohit.shinde12194@gmail.com>
wrote:

> Hey John,
>
> Sorry to bother you! I just wanted to know if you had any thoughts on the
> mail I sent.
>
> Is there anything I can pick up right now with regards to the Python
> package? You mentioned that linting is something that needs to be
> completed before we go ahead, so maybe I can start with that?
>
> Thanks,
> Rohit.
>
> On Wed, Aug 26, 2020 at 1:55 PM Rohit Shinde <rohit.shinde12194@gmail.com>
> wrote:
>
>> Hey John,
>>
>> I came across QEMU in 2015 when I was looking to participate in GSOC. I
>> did GSoC through another org. I kept following qemu because I was
>> interested in virtualization, systems level coding and device emulation.
>>
>> Currently, most of my professional dev work is done in Java and Python
>> (with some C++). I am interested in C/C++ development simply because of the
>> things you can accomplish with the tools that these languages give you. My
>> interests in programming as a hobby are very general. I would like to take
>> part in all kinds of development at least once (example: OS development,
>> virtualization, compilers, networking, etc). Professionally, I am a backend
>> developer who does SDK/API development along with writing general purpose
>> software that serves business needs. This is all at the application level.
>> So I have quite some experience in areas like CI/CD, deployment, build
>> systems and API dev. However, I don't know how much of that will translate
>> to QEMU development since the environment I work in is quite different.
>>
>> Out of the topic areas you mention, I am very interested in the following
>> (mentioned in order of interest):
>>
>>    1. Emulation
>>    2. KVM
>>    3. Storage optimization.
>>
>> I have been reading about KVM quite a bit because I wanted to know how
>> virtualization theory is actually implemented.
>>
>> And once again, thanks for the response! I really appreciate it!
>>
>> Thanks,
>> Rohit.
>>
>> On Wed, Aug 26, 2020 at 11:51 AM John Snow <jsnow@redhat.com> wrote:
>>
>>> On 8/26/20 11:00 AM, Rohit Shinde wrote:
>>> > Hey Thomas,
>>> >
>>> > I didn't really have any specific questions. I wanted to know if there
>>> > was any part of qemu that I could contribute to. Qemu is
>>> overwhelmingly
>>> > vast and without some pointers, I felt very lost.
>>>
>>> Yeah, it can be hard to get started.
>>>
>>> What are your interests in programming/development, any specific types
>>> of coding you like doing more than others? What draws you to the QEMU in
>>> particular? Is there something you'd like to see QEMU do that it doesn't
>>> today, or something you feel like you are particularly suited to doing?
>>>
>>> If I can figure out what brought you here, maybe I can direct you to
>>> some projects that might benefit from your attention. [Apart from the
>>> Python stuff, which we are discussing elsewhere in another thread.]
>>>
>>> Some topic areas:
>>>
>>> - Emulation (TCG)
>>> - Virtualization (KVM)
>>> - Esoteric/Legacy architecture/device emulation
>>> - Optimization (Network, Storage, CPU)
>>> - Regression/Acceptance Testing
>>> - Fuzzing
>>> - Configuration
>>> - Deployment
>>> - Continuous Integration
>>> - Accessibility, Ease-of-use
>>> - Build systems & tooling
>>> - Development process
>>> - SDK/API development
>>>
>>>
>>> If you have any specific knowledge in areas that aren't Linux on x86,
>>> there are likely areas of QEMU that could benefit from your knowledge.
>>> We are always looking for people to help maintain and develop code
>>> intended for other architectures on other platforms.
>>>
>>> --js
>>>
>>>

--000000000000e5e54805ae57457a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hey John,<div><br></div><div>I wanted to follow up on this=
, in case you missed my previous email :)</div><div><br></div><div>Thanks,<=
/div><div>Rohit.</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Sat, Aug 29, 2020 at 1:14 AM Rohit Shinde &lt;<a h=
ref=3D"mailto:rohit.shinde12194@gmail.com">rohit.shinde12194@gmail.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div =
dir=3D"ltr">Hey John,<div><br></div><div>Sorry to bother you! I just wanted=
 to know if you had any thoughts on the mail I sent.</div><div><br></div><d=
iv>Is there anything I can pick up right now with regards to the Python pac=
kage? You mentioned that linting is something that needs to be completed=C2=
=A0before we go ahead, so maybe I can start with that?</div><div><br></div>=
<div>Thanks,</div><div>Rohit.</div></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 26, 2020 at 1:55 PM Rohit Sh=
inde &lt;<a href=3D"mailto:rohit.shinde12194@gmail.com" target=3D"_blank">r=
ohit.shinde12194@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex"><div dir=3D"ltr">Hey John,<div><br></div><div>I c=
ame across QEMU in 2015 when I was looking to participate in GSOC. I did GS=
oC through another org. I kept following qemu because I was interested in v=
irtualization, systems level coding and device emulation.=C2=A0</div><div><=
br></div><div>Currently, most of my professional dev work is done in Java a=
nd Python (with some C++). I am interested in C/C++ development simply beca=
use of the things you can accomplish with the tools that these languages gi=
ve you. My interests in programming as a hobby are very=C2=A0general. I wou=
ld like to take part in all kinds of development at least once (example: OS=
 development, virtualization, compilers, networking, etc). Professionally, =
I am a backend developer who does SDK/API development along with writing ge=
neral purpose software that serves business needs. This is all at the appli=
cation level. So I have quite some experience in areas like CI/CD, deployme=
nt, build systems and API dev. However, I don&#39;t know how much of that w=
ill translate to QEMU development since the environment I work in is quite =
different.</div><div><br></div><div>Out of the topic areas you mention, I a=
m very interested in the following (mentioned in order of interest):</div><=
div><ol><li>Emulation</li><li>KVM</li><li>Storage optimization.</li></ol><d=
iv>I have been reading about KVM quite a bit because I wanted to know how v=
irtualization theory is actually implemented.</div></div><div><br></div><di=
v>And once again, thanks for the response! I really appreciate it!</div><di=
v><br></div><div>Thanks,</div><div>Rohit.</div></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 26, 2020 at 11:5=
1 AM John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">js=
now@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On 8/26/20 11:00 AM, Rohit Shinde wrote:<br>
&gt; Hey Thomas,<br>
&gt; <br>
&gt; I didn&#39;t really have any specific questions. I wanted to know if t=
here <br>
&gt; was any part of qemu that I could contribute to. Qemu is overwhelmingl=
y <br>
&gt; vast and without some pointers, I felt very lost.<br>
<br>
Yeah, it can be hard to get started.<br>
<br>
What are your interests in programming/development, any specific types <br>
of coding you like doing more than others? What draws you to the QEMU in <b=
r>
particular? Is there something you&#39;d like to see QEMU do that it doesn&=
#39;t <br>
today, or something you feel like you are particularly suited to doing?<br>
<br>
If I can figure out what brought you here, maybe I can direct you to <br>
some projects that might benefit from your attention. [Apart from the <br>
Python stuff, which we are discussing elsewhere in another thread.]<br>
<br>
Some topic areas:<br>
<br>
- Emulation (TCG)<br>
- Virtualization (KVM)<br>
- Esoteric/Legacy architecture/device emulation<br>
- Optimization (Network, Storage, CPU)<br>
- Regression/Acceptance Testing<br>
- Fuzzing<br>
- Configuration<br>
- Deployment<br>
- Continuous Integration<br>
- Accessibility, Ease-of-use<br>
- Build systems &amp; tooling<br>
- Development process<br>
- SDK/API development<br>
<br>
<br>
If you have any specific knowledge in areas that aren&#39;t Linux on x86, <=
br>
there are likely areas of QEMU that could benefit from your knowledge. <br>
We are always looking for people to help maintain and develop code <br>
intended for other architectures on other platforms.<br>
<br>
--js<br>
<br>
</blockquote></div>
</blockquote></div>
</blockquote></div>

--000000000000e5e54805ae57457a--

