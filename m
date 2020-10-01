Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5AEC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 21:22:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FCCA20796
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 21:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dcomp-ufs-br.20150623.gappssmtp.com header.i=@dcomp-ufs-br.20150623.gappssmtp.com header.b="UZnVarzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FCCA20796
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dcomp.ufs.br
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO621-0002oE-Bi
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 17:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bruno.otavio@gmail.com>)
 id 1kO60k-0002H7-HM
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 17:21:10 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:43047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bruno.otavio@gmail.com>)
 id 1kO60g-0007gA-Ef
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 17:21:10 -0400
Received: by mail-oi1-x229.google.com with SMTP id l85so904209oih.10
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 14:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dcomp-ufs-br.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/MJfMNXJYfoT3jitO/YqwJOJvquknFuWypse8Ym81nU=;
 b=UZnVarzkKQxuZSkBLcaFS9/hl3648ZpN7+j3dBSoJQQiuPcS5PlTNJaZWawMf2LKSa
 5SoXYBc5lF91jA2PxPP7QihFGuU+3xmJOHl8UtIukWpaF8BAIAr+adQWbJ8ySKvHjT8Y
 CGyo0yY3zeOoUTDsGMyauWv0oKo2dn+lF6gZuNDdh5Cwl+OPy4/ydr0dst0ZHOyptgiL
 SxQlMcneUfEcIxQdGcS/Asi1teKOB7ub4kOpXMqcKGwIu6OOGZazZ3IkoTJ2nkzzmSiJ
 qEIcTDBHyBQlAIiMRkTqJuiLWipZx84SR/L4/jgAfoz+undLRKlsgf+kdGu3xecoPCGK
 SQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/MJfMNXJYfoT3jitO/YqwJOJvquknFuWypse8Ym81nU=;
 b=FbMEQzrW/ee0bS5NgRpcgz0UAd8Wfv6h6QOZicrVdFmW59xHpPXTXyVUc4yQGnTSkE
 TOtcss/wlpBifB3hoyjw5SC77A2P+pcIzS1S5iZiI1U/6xIiV6twjY3cevBJLz4sovJ9
 ogdLAZH+3qyaY//vUfuui/3h4bm3Vx88g0cZXzrQiXbQxxZYPsQXLkaekf9PUAVbpcmS
 MmwnN/7Du/aq7sjaZWFxYUKKut6sFoJVmkOoZAIsupUpKDSW4RRRTAckdNJrkjB0tR5+
 O5rAzohxL/xC/NHNbwP+aN0gT0VjWa2a1/HukEkUV/EDhd4dO7S+SsFqL+xEJfHvEmGA
 sHqQ==
X-Gm-Message-State: AOAM5314naPfmQQfncHzgneRkBl0LhkmeqCi53sIkH3Dq463lAzbLrYL
 Bd2kVmhKv/fApYx2kKYhhMu42VrWMMc47Nx7+5E=
X-Google-Smtp-Source: ABdhPJy1y6wX5mJe7G3RncwZv4+b7d4FtFMRByNYhC9IucybdVrTwMEmATVo0qmcdrsuvPjHoWZ+MFFt/KXUlVwh6jE=
X-Received: by 2002:a05:6808:494:: with SMTP id
 z20mr1241031oid.7.1601587265250; 
 Thu, 01 Oct 2020 14:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAD5Umjr6Nu6fddP2LgkfxtTTKduHEMs=C49C2r_ZcMkopsYidw@mail.gmail.com>
 <CAFEAcA_AjzNKzrHBU7QQzB=dxia9mYuw5oAsya3h42JEQAemaA@mail.gmail.com>
In-Reply-To: <CAFEAcA_AjzNKzrHBU7QQzB=dxia9mYuw5oAsya3h42JEQAemaA@mail.gmail.com>
From: Bruno Prado <bruno@dcomp.ufs.br>
Date: Thu, 1 Oct 2020 18:20:29 -0300
Message-ID: <CAD5UmjrjORJbP0sj-DnGQFaQ443-vYMBa-1qCBzJsnUG+gU=jw@mail.gmail.com>
Subject: Re: ARM semihosting issue
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000005aa8f05b0a298f7"
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=bruno.otavio@gmail.com; helo=mail-oi1-x229.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--00000000000005aa8f05b0a298f7
Content-Type: text/plain; charset="UTF-8"

Thanks for the reply... I am attaching some code and output:

#include <stdio.h>
int main() {
       char name[50] = "Nobody";
       FILE* file = fopen("name", "r");
       printf("What is your name?\n");
       fprintf(stdout, "Reading from file...\n");
       fscanf(file, "%s", name);
       fscanf(stdin, "%s", name);
       printf("My name is %s\n", name);
       fprintf(stderr, "I am alive!!!\n");
       fclose(file);
       return 0;
}

$ cat name
Turing
$ qemu-system-arm -M netduino2 -nographic -semihosting -kernel vp2.bin
What is your name?
Reading from file...
My name is Turing
I am alive!!!
$

Basically the scanf call has no effect. I was expecting a pause in
execution to input a string, but nothing happens.

Regards,
----
Bruno Prado


On Thu, Oct 1, 2020 at 5:38 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Thu, 1 Oct 2020 at 21:33, Bruno Prado <bruno@dcomp.ufs.br> wrote:
> > I was able to use stdout, stderr for output and files for
> > both input and output in qemu-system-arm, but stdin is not
> > working (always returns -1 from syscall). I found no
> > information and have already checked the code for possible hints.
>
> Rather hard to say what might be going on with this little
> information... what semihosting calls are you making, what
> do you expect them to do and what do they actually do?
> Do you have a minimal test case we can reproduce with?
>
> thanks
> -- PMM
>

--00000000000005aa8f05b0a298f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the reply... I am attaching some code and outpu=
t:<div><br></div><div><span style=3D"font-family:monospace"><span style=3D"=
color:rgb(0,0,0)">#include &lt;stdio.h&gt;
</span><br>int main() {
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char name[50] =3D &quot;Nobo=
dy&quot;;
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0FILE* file =3D fopen(&quot;n=
ame&quot;, &quot;r&quot;);
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0printf(&quot;What is your na=
me?\n&quot;);
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fprintf(stdout, &quot;Readin=
g from file...\n&quot;);
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fscanf(file, &quot;%s&quot;,=
 name);
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fscanf(stdin, &quot;%s&quot;=
, name);
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0printf(&quot;My name is %s\n=
&quot;, name);
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fprintf(stderr, &quot;I am a=
live!!!\n&quot;);
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fclose(file);
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
<br>}<br></span><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartm=
ail=3D"gmail_signature"><br></div><div dir=3D"ltr" class=3D"gmail_signature=
" data-smartmail=3D"gmail_signature"><span style=3D"font-family:monospace">=
<span style=3D"color:rgb(0,0,0)">$ cat name
</span><br>Turing<br></span></div><div class=3D"gmail_signature" data-smart=
mail=3D"gmail_signature">$ qemu-system-arm -M netduino2 -nographic -semihos=
ting -kernel vp2.bin<br>What is your name?<br>Reading from file...<br>My na=
me is Turing<br>I am alive!!!<br></div><div class=3D"gmail_signature" data-=
smartmail=3D"gmail_signature">$</div><div dir=3D"ltr" class=3D"gmail_signat=
ure" data-smartmail=3D"gmail_signature"><br></div><div class=3D"gmail_signa=
ture" data-smartmail=3D"gmail_signature">Basically the scanf call has no ef=
fect. I was expecting a pause in execution to input a string, but nothing h=
appens.</div><div class=3D"gmail_signature" data-smartmail=3D"gmail_signatu=
re"><br></div><div class=3D"gmail_signature" data-smartmail=3D"gmail_signat=
ure">Regards,</div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmai=
l=3D"gmail_signature">----<br>Bruno Prado</div></div><br></div></div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct =
1, 2020 at 5:38 PM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro=
.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On Thu, 1 Oct 2020 at 21:33, Bruno Prado &lt;=
<a href=3D"mailto:bruno@dcomp.ufs.br" target=3D"_blank">bruno@dcomp.ufs.br<=
/a>&gt; wrote:<br>
&gt; I was able to use stdout, stderr for output and files for<br>
&gt; both input and output in qemu-system-arm, but stdin is not<br>
&gt; working (always returns -1 from syscall). I found no<br>
&gt; information and have already checked the code for possible hints.<br>
<br>
Rather hard to say what might be going on with this little<br>
information... what semihosting calls are you making, what<br>
do you expect them to do and what do they actually do?<br>
Do you have a minimal test case we can reproduce with?<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--00000000000005aa8f05b0a298f7--

