Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A47C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CCD22076B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LB/Xogki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CCD22076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQEyH-0006Oa-01
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 15:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQEta-0002W5-3N; Wed, 07 Oct 2020 15:14:38 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:36729)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQEtY-00061f-6t; Wed, 07 Oct 2020 15:14:37 -0400
Received: by mail-lj1-x243.google.com with SMTP id r24so3128997ljm.3;
 Wed, 07 Oct 2020 12:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=7d+aViir+vQO8ekOBot7fdQ+hRvsIh0oDMVBv+ckovc=;
 b=LB/XogkiiKGHKysidKZm5000Pk4ejLkyCFaLMikQAto9hNQfvIMfeawO3lbusvLW3J
 9C9jaKXegyraBLX5Jn7muglIJIcYwtghBrD/m97t5U7l4S6nFrA91hc1OJvGycBVQj9c
 0DA7dvH66Iw+oSi48vxfBmp+MqyWQrX+KpI1ChrTAwFylTyF0TyXHvkrzLwOx1j0xEVO
 xwQwg9jNxxcqkQbx+pIReaCM44IUyft3QmnW0jXOaNovJcLrcMnBH0ESpIwVAGBgtrQg
 M/n3FDZJB5x0jyYIzbFMYuLyQM/t/vblfXtX06DZ6S5Ko0t5338NW2gwYdL0NHdXOVI7
 qT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=7d+aViir+vQO8ekOBot7fdQ+hRvsIh0oDMVBv+ckovc=;
 b=ArQw01v7BYb7840KcWhXJXALslCE4rFM5hlG8fb5VwJEiwn5SZjxec0oH132wiPM1P
 bQPjulH1VQnQTz2Qr6C37g9Wmx80ZVS1z8SwtXUg0OezmZ7dA9rgpySYU1mL2NHJnnBw
 yulLJRqofGLvUTsaMUOAk5Gt+bfYOkly/SrF+JbZJk5fJPTMsYmXBM8Kw1ktXaTa1Acz
 IPOwGnc14b2aVwhwFW3D92NDmXZenrH9EQoHU06XWtsk4Vz8fEEWZO8xSUYvL0IUni1v
 djAcWBjSex0gitRee7IcQbwrY0yWlJZP9wcZPHmB7UIGjSWRTlT72fWetK6W21EmOzGN
 LcKw==
X-Gm-Message-State: AOAM531RPPIOtazNm3mBwWU8tMWS8iqfNj7ENn5tMw+xh76ObvDrEmyf
 YzAGosMRXLSRXVmIWTDXL0k6WlcOnXLwwdOzde8=
X-Google-Smtp-Source: ABdhPJwWlQw5E8FM9l3rZlHoXuofsM15Iq+eWULpUxMtG9/fgTLV/xuKeO9z4N6xNwgULO5N9LHo7/CflzFmYTR4LAY=
X-Received: by 2002:a2e:9dc7:: with SMTP id x7mr1969728ljj.447.1602098073717; 
 Wed, 07 Oct 2020 12:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201007162138.425-1-luoyonggang@gmail.com>
 <CAE2XoE9sf0p5QuG=dSqbOvmGvbzDaEBN8qSG1ejM=RH+D+zq1g@mail.gmail.com>
 <798fb17d-fcf5-3234-1e17-37b3c0a18b8e@redhat.com>
In-Reply-To: <798fb17d-fcf5-3234-1e17-37b3c0a18b8e@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 8 Oct 2020 03:14:21 +0800
Message-ID: <CAE2XoE9eSkEiAynPy2b5zworFT23SEdS_yO0Tb-aeUdp=Ox3xw@mail.gmail.com>
Subject: Re: [PATCH v6] scripts: Convert qemu-version.sh to qemu-version.py
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009451ad05b11986f9"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009451ad05b11986f9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2020 at 12:43 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 07/10/20 18:23, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> >> +    if not pkgversion and os.path.exists('.git'):
> >> +        # The quote of v* should preserve, otherwise git command
> > would fail
> >> +        pc =3D subprocess.run(['git', 'describe', '--match', "'v*'",
> > '--dirty', '--always'],
> >> +                            stdout=3Dsubprocess.PIPE,
> > stderr=3Dsubprocess.DEVNULL, encoding=3D'utf8')
>
> It's a total mess.
>
> On Linux, if you use 'v*' git is invoked with an argument that looks
> like 'v*', that is as if you used \'v\*\' on bash.
>
> On Windows, wildcard expansion is done by the program so you need to
> pass a quoted value to stop the wildcard expansion.
>
> I have no idea how to fix it.  Probably it can be made to work using a
> string argument and "shell=3DTrue", but at this point it makes more sense
> to keep the shell script version.
Even though the shell script version are work, but it's not working in good
shape, when I running
the shell script, it's executed very slow, and so with python shell=3DTrue,=
 I
guess it's because
the v* character cause the program doing a lot IO operation. So i still
think
'--match=3Dv*' is a better solution, filename with --match=3Dv123 are rare,
even sart with -- are rare.
so this is acceptable, and also I've creating a pull request on python to
resolve this issue completely
https://github.com/python/cpython/pull/22590
>
> Paolo
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000009451ad05b11986f9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Thu, Oct 8, 2020 at 12:43 AM Paolo Bonzini &lt;=
<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<b=
r>&gt;<br>&gt; On 07/10/20 18:23, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo)=
 wrote:<br>&gt; &gt;&gt; + =C2=A0 =C2=A0if not pkgversion and os.path.exist=
s(&#39;.git&#39;):<br>&gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0# The quot=
e of v* should preserve, otherwise git command<br>&gt; &gt; would fail<br>&=
gt; &gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0pc =3D subprocess.run([&#39;git&#=
39;, &#39;describe&#39;, &#39;--match&#39;, &quot;&#39;v*&#39;&quot;,<br>&g=
t; &gt; &#39;--dirty&#39;, &#39;--always&#39;],<br>&gt; &gt;&gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0stdout=3Dsubprocess.PIPE,<br>&gt; &gt; stderr=3Dsubprocess=
.DEVNULL, encoding=3D&#39;utf8&#39;)<br>&gt;<br>&gt; It&#39;s a total mess.=
<br>&gt;<br>&gt; On Linux, if you use &#39;v*&#39; git is invoked with an a=
rgument that looks<br>&gt; like &#39;v*&#39;, that is as if you used \&#39;=
v\*\&#39; on bash.<br>&gt;<br>&gt; On Windows, wildcard expansion is done b=
y the program so you need to<br>&gt; pass a quoted value to stop the wildca=
rd expansion.<br>&gt;<br>&gt; I have no idea how to fix it.=C2=A0 Probably =
it can be made to work using a<br>&gt; string argument and &quot;shell=3DTr=
ue&quot;, but at this point it makes more sense<br>&gt; to keep the shell s=
cript version.<div>Even though the shell script version are work, but it&#3=
9;s not working in good shape, when I running</div><div>the shell script, i=
t&#39;s executed very slow, and so with python shell=3DTrue, I guess it&#39=
;s because</div><div>the v* character cause the program doing a lot IO oper=
ation. So i still think=C2=A0</div><div>&#39;--match=3Dv*&#39; is a better =
solution, filename with --match=3Dv123 are rare, even sart with -- are rare=
.</div><div>so this is acceptable, and also I&#39;ve creating a pull reques=
t on python to resolve this issue completely</div><div><a href=3D"https://g=
ithub.com/python/cpython/pull/22590">https://github.com/python/cpython/pull=
/22590</a><br>&gt;<br>&gt; Paolo<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=
=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--0000000000009451ad05b11986f9--

