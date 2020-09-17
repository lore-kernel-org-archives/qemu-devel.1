Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE422C2D0E3
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F571221E3
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AvSl34Q9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F571221E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIz10-0003LS-5m
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 14:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIyza-0002QC-G1
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 14:50:51 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:41191)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIyzY-0003sw-Bd
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 14:50:49 -0400
Received: by mail-lj1-x243.google.com with SMTP id y4so2931914ljk.8
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 11:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CAk6mV/9qvSg5WdVvPJL1WOIq9wZ6nb0JDNfKQourHk=;
 b=AvSl34Q9Upc6Q2t6aBJ+z3sK289YQjRQt5IPK27PazaZq8Z+775w3ksAsu3/PJ85CH
 ttHxybTs7qiBjDpLusXSVwEM5brYBEkzsl8wU0Sbg8ly3/JF1FTKvWqfotJktn80mVmV
 PMkIASwFnc9ZB0qOsdyUQEV4xBJWMwjT4FqVTlVNPEijOrXl+DhzLT6QOg1Z4uELKIi3
 eVcwhXPLA4QqAMfCyks4puVvVo5NrAePkIoncl8HO3bbNAGHXFbtGGKf5g0zw4f+Yuun
 4G8mN8XgK65NAn/R1TjrU6lgz62g+tW6mYz2CJ0gv1bq32yabgnyB4I+aCn8Ul+XiN6S
 Hvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CAk6mV/9qvSg5WdVvPJL1WOIq9wZ6nb0JDNfKQourHk=;
 b=TcfGBbG9b2EKbHp4wDt3yrg6qMOXi1IDO7SZrsP0fB/cmrgjqwtz8dKT7YGJRDl535
 RJfl/4at9jO2w5FI2CwBnXAEpXWWfO5jCzW3gWKi11juAgcEKriTu054VTgec2ql0QsP
 xALu9Nr2B4jptN3RAiv5dvlzUCev6JkBVbfhzyp7BysELtiwCT0jEl7BC9p0ECJab6s/
 PuKjP0Hzt3um/ODbceKWUh3fCYkmgqk2bW56kdNqX/Hv69x8/x2dFaVx5LiL2mj+jviC
 Edv09bgr0C+XTLRfGOUT7nQouK8HSy7vNY8hG1ab2IRPHHnsmRD/Sx8n+QHXLdJVhQ+V
 z7RA==
X-Gm-Message-State: AOAM532L47jDuG8pIsvGulhhRpGt7nQEasD493C9SS2jniOWDEiqzFTF
 Y/y/2S2LvJYwrjQS3RUy20zl/cdfMIGypTp8p58qbQ==
X-Google-Smtp-Source: ABdhPJxQ8IhoJZu6TzX5w0ttUvQ+IbECBadY+m0iJ90F7and7V6FVMIbpxM6xX9dNiY+gJR9F7jOMUJwt5FJdbGL5mQ=
X-Received: by 2002:a2e:9745:: with SMTP id f5mr11035508ljj.158.1600368645977; 
 Thu, 17 Sep 2020 11:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200917104441.31738-1-pbonzini@redhat.com>
 <faab2d69-4bd1-4878-d638-4c9414e56499@amsat.org>
 <87een0xs44.fsf@linaro.org>
 <CABgObfYby_HfevgJ2fP0EDemd4hXbWc24h3C7mZ4ar_N0mE7AQ@mail.gmail.com>
In-Reply-To: <CABgObfYby_HfevgJ2fP0EDemd4hXbWc24h3C7mZ4ar_N0mE7AQ@mail.gmail.com>
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Date: Thu, 17 Sep 2020 19:50:31 +0100
Message-ID: <CAHDbmO3_iUbta7ZK6RecMk8zFeMNUngLOuoJoFbH08452-YMzg@mail.gmail.com>
Subject: Re: [PATCH] docker.py: always use --rm
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a7538005af86dc3d"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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
Cc: berrange@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a7538005af86dc3d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Got it.

On Thu, 17 Sep 2020, 17:58 Paolo Bonzini, <pbonzini@redhat.com> wrote:

>
>
> Il gio 17 set 2020, 18:53 Alex Benn=C3=A9e <alex.bennee@linaro.org> ha sc=
ritto:
>
>>
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>>
>> > On 9/17/20 12:44 PM, Paolo Bonzini wrote:
>> >> Avoid that containers pile up.
>> >>
>> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> >> ---
>> >>  tests/docker/Makefile.include | 1 -
>> >>  tests/docker/docker.py        | 4 ++--
>> >>  2 files changed, 2 insertions(+), 3 deletions(-)
>> >>
>> >> diff --git a/tests/docker/Makefile.include
>> b/tests/docker/Makefile.include
>> >> index 3daabaa2fd..75704268ff 100644
>> >> --- a/tests/docker/Makefile.include
>> >> +++ b/tests/docker/Makefile.include
>> >> @@ -243,7 +243,6 @@ docker-run: docker-qemu-src
>> >>              $(DOCKER_SCRIPT) run                                    =
\
>> >>                      $(if $(NOUSER),,--run-as-current-user)          =
\
>> >>                      --security-opt seccomp=3Dunconfined             =
  \
>> >> -                    $(if $V,,--rm)                                  =
\
>> >>                      $(if $(DEBUG),-ti,)                             =
\
>> >
>> > Alternatively:
>> >
>> > -                       $(if $V,,--rm)
>> > -                       $(if $(DEBUG),-ti,)
>> > +                       $(if $(DEBUG),-ti,--rm)
>>
>> Surely that should b:
>>
>>   $(if $(DEBUG),-ti --rm,)
>>
>> I think being able to keep the container around is useful for debug, I
>> have no problem with changing the behaviour for V=3D1.
>>
>
> You probably mean  $(if $(DEBUG),-ti,--rm) but that would not work becaus=
e
> the patch adds --rm unconditionally in docker.py. But $(DEBUG) gives you =
a
> shell to run the test from, so I don't think skipping --rm is useful even
> in the $(DEBUG) case.
>
> Paolo
>
>>

--000000000000a7538005af86dc3d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Got it.=C2=A0</div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">On Thu, 17 Sep 2020, 17:58 Paolo Bonzini, &l=
t;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"><div dir=3D"auto"><div><br><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 17 set=
 2020, 18:53 Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org"=
 target=3D"_blank" rel=3D"noreferrer">alex.bennee@linaro.org</a>&gt; ha scr=
itto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex"><br>
Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">f4bug@amsat.org</a>&gt; writes:<br>
<br>
&gt; On 9/17/20 12:44 PM, Paolo Bonzini wrote:<br>
&gt;&gt; Avoid that containers pile up.<br>
&gt;&gt; <br>
&gt;&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat=
.com" rel=3D"noreferrer noreferrer" target=3D"_blank">pbonzini@redhat.com</=
a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 tests/docker/Makefile.include | 1 -<br>
&gt;&gt;=C2=A0 tests/docker/docker.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 4 ++--<b=
r>
&gt;&gt;=C2=A0 2 files changed, 2 insertions(+), 3 deletions(-)<br>
&gt;&gt; <br>
&gt;&gt; diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile=
.include<br>
&gt;&gt; index 3daabaa2fd..75704268ff 100644<br>
&gt;&gt; --- a/tests/docker/Makefile.include<br>
&gt;&gt; +++ b/tests/docker/Makefile.include<br>
&gt;&gt; @@ -243,7 +243,6 @@ docker-run: docker-qemu-src<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $(DOCKER_SCRIPT) r=
un=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 $(if $(NOUSER),,--run-as-current-user)=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 --security-opt seccomp=3Dunconfined=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 $(if $V,,--rm)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 $(if $(DEBUG),-ti,)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;<br>
&gt; Alternatively:<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0$(if $V,,--rm)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0$(if $(DEBUG),-ti,)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0$(if $(DEBUG),-ti,--rm)<br>
<br>
Surely that should b:<br>
<br>
=C2=A0 $(if $(DEBUG),-ti --rm,)<br>
<br>
I think being able to keep the container around is useful for debug, I<br>
have no problem with changing the behaviour for V=3D1.<br></blockquote></di=
v></div><div dir=3D"auto"><br></div><div dir=3D"auto">You probably mean=C2=
=A0 $(if $(DEBUG),-ti,--rm) but that would not work because the patch adds =
--rm unconditionally in docker.py. But $(DEBUG) gives you a shell to run th=
e test from, so I don&#39;t think skipping --rm is useful even in the $(DEB=
UG) case.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><di=
v dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>
</blockquote></div>

--000000000000a7538005af86dc3d--

