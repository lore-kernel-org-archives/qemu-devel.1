Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11186C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE557235FC
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tphV7nWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE557235FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpr2M-0007ax-4W
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 06:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jpr1c-0006ja-C1
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:28:32 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:33231)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jpr1a-0000MG-CX
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:28:32 -0400
Received: by mail-wm1-x331.google.com with SMTP id a6so13427543wmm.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 03:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=VhPNHQLA4FSz28C+UAXTxdHDMqgg3LIYOwI0xjAr2Xo=;
 b=tphV7nWHrm4VL8abVY7x8amy/afQZQhOQ5ox/aV8H5ewI6Dyi7rYptvFBbXEiyW+vD
 im7Szip/wdIXdCuQQB3/4F7pp5KwR4rjpFRhAIBro+jFnx06EN3CQ4P5ezOHfs17bfrJ
 8neW3TEwJVxaLtwTtyI4UynMny6Jay9Ag526JmBbbEtufFmxBMIUM+Vk8jjsV6Y9Y+ce
 tqSFTIg9W7OfJF9w/SvGuFL/ltB8XVYZgzP0dEPYgY0wQpwVMoElMJjRiO7uGJhpvxK4
 O/FWoGEIL3L7kEO+qIR1tb2/4dlQ/rgF8KsNAZGQfzdSIhhGexKBOQbqb9j+rdRcZ6cE
 Zxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=VhPNHQLA4FSz28C+UAXTxdHDMqgg3LIYOwI0xjAr2Xo=;
 b=gbe9QgEJpLngmCRbNGL3ttU1IrDjwNHrMlPDaNMMlbOh3euXyBFPo1f8HiOm93LUff
 l5AUvOP7Bs5dEDr5bZKIutHSFf3l9wtiYLRrovz4sHsX6KTjTzQRUUTjq8DRtA4TW8Yv
 Rm+UfAnrRCQZu6Lwv+KZ8f4NBBqHAnhNNBoVFQZ6JAGvipq3rz144+pINVkHU1ARi+nr
 w424kuEJUQpjXv2ifpXx2bRgX+/qd31kcvp8k72gFAEw4/3kOXefX/iD9Vvsa7SejDZv
 SMIk1gd5ROH6P1eDDzZ62/WeP9025V5peSGrkobugQTXRdvAUBhL4nlS9YfJVwEgxCIu
 kXug==
X-Gm-Message-State: AOAM532ks41ItG489dOkSSVCTLe0zQTGRJrtO/mdIr+UfQntyK2N90Zj
 omYu88ExjOk/vUA+V1UGvCox6E0KCb3OOMkms5E=
X-Google-Smtp-Source: ABdhPJwfLa0W6cS6Gc2aH/ROxBFcDbeWhYQvVZdpfDdua+7vZyV14NIIPhve+CSzfM6SEMFrBlSXXiiP2/yijr00Gi0=
X-Received: by 2002:a1c:2602:: with SMTP id m2mr16789363wmm.50.1593426508956; 
 Mon, 29 Jun 2020 03:28:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b407:0:0:0:0:0 with HTTP; Mon, 29 Jun 2020 03:28:28
 -0700 (PDT)
In-Reply-To: <97eb7447-0453-2e2c-4003-a4de338ee11f@amsat.org>
References: <1593287503-25197-1-git-send-email-aleksandar.qemu.devel@gmail.com>
 <1593287503-25197-7-git-send-email-aleksandar.qemu.devel@gmail.com>
 <97eb7447-0453-2e2c-4003-a4de338ee11f@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Mon, 29 Jun 2020 12:28:28 +0200
Message-ID: <CAHiYmc5XoQyCqVxNnWJ70HQPsD=RzTEFZ_aNn4KR+u2nDENZkA@mail.gmail.com>
Subject: Re: [PULL 6/6] MAINTAINERS: Add 'Performance Tools and Tests'
 subsection
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000000ac6f605a9368583"
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000ac6f605a9368583
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D1=99=D0=B0=D0=BA, 29. =D1=98=D1=83=D0=
=BD 2020., Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:

> On 6/27/20 9:51 PM, Aleksandar Markovic wrote:
> > This commit creates a new 'Miscellaneous' section which hosts a new
> > 'Performance Tools and Tests' subsection. This subsection will contain
> > the the performance scripts and benchmarks written as a part of the
> > 'TCG Continuous Benchmarking' project. Also, it will be a placeholder
> > for follow-ups to this project, if any.
> >
> > Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> > Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > Message-Id: <20200626164546.22102-4-ahmedkhaledkaraman@gmail.com>
> > ---
> >  MAINTAINERS | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index fe925ea..dec252f 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1096,11 +1096,10 @@ F: hw/isa/vt82c686.c
> >  F: hw/pci-host/bonito.c
> >  F: include/hw/isa/vt82c686.h
> >
> > -Loongson-3 Virtual Platform
> > +Loongson-3 virtual platforms
> >  M: Huacai Chen <chenhc@lemote.com>
> >  R: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >  S: Maintained
> > -F: hw/mips/loongson3_virt.c
>
> Ah, now I see, here you unlist the uncommited file.
>
>
This file/machine, for multiple reasons, will not be accepted in 5.1. The
end user will not be able to see, let alone use the machine in question in
5.1. This is on purpose.

This will give enough development time to Huacai to implement missing bits
and pieces, and to possibly improve the whole idea during 5.2 development
cycle.

Even though the support that Huacai introduced in 5.1 is, for many reasons,
not completed, and even though Huacai and I had at times opposing views and
fierce discussions and disagreements - I salute and support his work, and
consider it, by far, the best and the most important contribution to QEMU
for MIPS in years.



> It might be easier to manage sending 2 different pull requests,
> on for MIPS and one for the performance tools.
>
> >  F: hw/intc/loongson_liointc.c
> >
> >  Boston
> > @@ -3026,3 +3025,10 @@ M: Peter Maydell <peter.maydell@linaro.org>
> >  S: Maintained
> >  F: docs/conf.py
> >  F: docs/*/conf.py
> > +
> > +Miscellaneous
> > +-------------
> > +Performance Tools and Tests
> > +M: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
>
> Aleksandar, don't you want to be listed here with Ahmed?
>
>
Of course not. The project is student's. The mentor just helps and leads
the student. The fruits of the project belong to the community and to the
student - and not to the mentor.

If you were the mentor, my impression is that you would leave your name in
MAINTAINERS whenever you see the slightest opportunity (I remember an
occasion where you were saying "I worked six hours on this" and then
proposing yourself as the maitainer for a particular segment (??)). I don't
have such approach, and I oppose your approach, and I appeal to you to
control your apetite for maintainership.

Regards,
Aleksandar



> > +S: Maintained
> > +F: scripts/performance/
> >
>
>

--0000000000000ac6f605a9368583
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D0=BF=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D1=99=D0=B0=D0=BA, 29. =D1=98=
=D1=83=D0=BD 2020., Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug=
@amsat.org">f4bug@amsat.org</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 6/27/=
20 9:51 PM, Aleksandar Markovic wrote:<br>
&gt; This commit creates a new &#39;Miscellaneous&#39; section which hosts =
a new<br>
&gt; &#39;Performance Tools and Tests&#39; subsection. This subsection will=
 contain<br>
&gt; the the performance scripts and benchmarks written as a part of the<br=
>
&gt; &#39;TCG Continuous Benchmarking&#39; project. Also, it will be a plac=
eholder<br>
&gt; for follow-ups to this project, if any.<br>
&gt; <br>
&gt; Signed-off-by: Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@=
gmail.com">ahmedkhaledkaraman@gmail.com</a>&gt;<br>
&gt; Reviewed-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro=
.org">alex.bennee@linaro.org</a>&gt;<br>
&gt; Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu=
.devel@gmail.com">aleksandar.qemu.devel@gmail.<wbr>com</a>&gt;<br>
&gt; Signed-off-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qe=
mu.devel@gmail.com">aleksandar.qemu.devel@gmail.<wbr>com</a>&gt;<br>
&gt; Message-Id: &lt;<a href=3D"mailto:20200626164546.22102-4-ahmedkhaledka=
raman@gmail.com">20200626164546.22102-4-<wbr>ahmedkhaledkaraman@gmail.com</=
a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 MAINTAINERS | 10 ++++++++--<br>
&gt;=C2=A0 1 file changed, 8 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index fe925ea..dec252f 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -1096,11 +1096,10 @@ F: hw/isa/vt82c686.c<br>
&gt;=C2=A0 F: hw/pci-host/bonito.c<br>
&gt;=C2=A0 F: include/hw/isa/vt82c686.h<br>
&gt;=C2=A0 <br>
&gt; -Loongson-3 Virtual Platform<br>
&gt; +Loongson-3 virtual platforms<br>
&gt;=C2=A0 M: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com">chenhc@l=
emote.com</a>&gt;<br>
&gt;=C2=A0 R: Jiaxun Yang &lt;<a href=3D"mailto:jiaxun.yang@flygoat.com">ji=
axun.yang@flygoat.com</a>&gt;<br>
&gt;=C2=A0 S: Maintained<br>
&gt; -F: hw/mips/loongson3_virt.c<br>
<br>
Ah, now I see, here you unlist the uncommited file.<br>
<br></blockquote><div><br></div><div>This file/machine, for multiple reason=
s, will not be accepted in 5.1. The end user will not be able to see, let a=
lone use the machine in question in 5.1. This is on purpose.</div><div><br>=
</div><div>This will give enough development time to Huacai to implement mi=
ssing bits and pieces, and to possibly improve the whole idea during 5.2 de=
velopment cycle.</div><div><br></div><div>Even though the support that Huac=
ai introduced in 5.1 is, for many reasons, not completed, and even though H=
uacai and I had at times opposing views and fierce discussions and disagree=
ments - I salute and support his work, and consider it, by far, the best an=
d the most important contribution to QEMU for MIPS in years.</div><div><br>=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
It might be easier to manage sending 2 different pull requests,<br>
on for MIPS and one for the performance tools.<br>
<br>
&gt;=C2=A0 F: hw/intc/loongson_liointc.c<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 Boston<br>
&gt; @@ -3026,3 +3025,10 @@ M: Peter Maydell &lt;<a href=3D"mailto:peter.ma=
ydell@linaro.org">peter.maydell@linaro.org</a>&gt;<br>
&gt;=C2=A0 S: Maintained<br>
&gt;=C2=A0 F: docs/conf.py<br>
&gt;=C2=A0 F: docs/*/conf.py<br>
&gt; +<br>
&gt; +Miscellaneous<br>
&gt; +-------------<br>
&gt; +Performance Tools and Tests<br>
&gt; +M: Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail.com">=
ahmedkhaledkaraman@gmail.com</a>&gt;<br>
<br>
Aleksandar, don&#39;t you want to be listed here with Ahmed?<br>
<br></blockquote><div><br></div><div>Of course not. The project is student&=
#39;s. The mentor just helps and leads the student. The fruits of the proje=
ct belong to the community and to the student - and not to the mentor.</div=
><div><br></div><div>If you were the mentor, my impression is that you woul=
d leave your name in MAINTAINERS whenever you see the slightest opportunity=
 (I remember an occasion where you were saying &quot;I worked six hours on =
this&quot; and then proposing yourself as the maitainer for a particular se=
gment (??)). I don&#39;t have such approach, and I oppose your approach, an=
d I appeal to you to control your apetite for maintainership.</div><div><br=
></div><div>Regards,</div><div>Aleksandar</div><div><br></div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">
&gt; +S: Maintained<br>
&gt; +F: scripts/performance/<br>
&gt; <br>
<br>
</blockquote>

--0000000000000ac6f605a9368583--

