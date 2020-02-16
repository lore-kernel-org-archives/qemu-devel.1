Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52072C2BA83
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 19:28:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B6AE2072C
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 19:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l68oyw4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6AE2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Pb7-0006sw-B3
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 14:28:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j3Pa7-0006Qj-58
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 14:27:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j3Pa6-0005HW-2Q
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 14:27:55 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37069)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j3Pa5-0005G6-Ti; Sun, 16 Feb 2020 14:27:54 -0500
Received: by mail-oi1-x244.google.com with SMTP id q84so14719933oic.4;
 Sun, 16 Feb 2020 11:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=szCwuS6r+2ZwKMWT/LRiz5bufdDkilCnV+TJPuuN3uQ=;
 b=l68oyw4QYV2lkhb6mKdCAh6sViAihtZJ0AOxcAr+79PzgJbeYDsXsm+D7xJ+217B1d
 rCjZFQATqzLf9+Xv0/2hfThtONFWy+ec7L1maqTBqKKLpUDSP4L849Wrh6ng9qL6r1X/
 vGnxI7uen8FV4FU/i8YS+yrkZ5+N8SW0NGYNLokgD4pVarc3mOHqCpFBMw54H4YuI5Ob
 3Q7GglqAD5omKeq9VrtX9KudqCv0PIrWlaIGCnPSS1TXoP6V0Fyygsr/yj8GkZDqpRKC
 N9P204dz+6Y8NrhjPjMaUcN+jo3zFiROxjVPnc91o1JIunPsfbAhVU+52HAXwvX/B+kg
 C0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=szCwuS6r+2ZwKMWT/LRiz5bufdDkilCnV+TJPuuN3uQ=;
 b=pPWH1DQENlSDlcOcn6R8OFcVhs3XpbQ91HBJaXjU5vCABsJk8EYfUShBCR/Nhupqhy
 PtxjYczh+6DkO5VJOwA3eZhMaDWq5xjrpOI1eKKrWizIfjYPPMJ3nu7LczHE8S4Z1CcA
 yrg4p9c17uRAHhd/8znKfLSaIOKYFEUnqe7UB88HFKFPcVTN5Q1DhKkh3a6D738KwRCN
 hv1p8oDtFvBMgHl2+aFu+/7+FK6v/HAynGgUlSxjXl2PhfxaUc147efFkWmQ1TKUgzSo
 M31vllx1P904lQBYwCQOZJNwdEJTBj+jCi2E3i+P+ULTz5cTwa0THFpe8wP8oSPXgHBt
 CQRw==
X-Gm-Message-State: APjAAAWTFyRhSz4q4z6Y/0CPvhLMXmMto7D0L1mdPxfx5d05V9Hi5U5a
 A726ziY+v4NluPTbNTTFDJkRRa3w9cxT9hgkVP4=
X-Google-Smtp-Source: APXvYqzvUucoPkJa6B0hjSnGCd12Uy5WR8zAwN1Af4ND2SrVimL44qVTRG8SgqHbeZe0IMAIUfCTy46Xs8uBFsoRMzQ=
X-Received: by 2002:aca:4ece:: with SMTP id c197mr8094153oib.53.1581881272545; 
 Sun, 16 Feb 2020 11:27:52 -0800 (PST)
MIME-Version: 1.0
References: <20200215162337.5809-1-f4bug@amsat.org>
In-Reply-To: <20200215162337.5809-1-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 16 Feb 2020 20:27:33 +0100
Message-ID: <CAL1e-=ij-KpK-O2e44C8_No-H7eshV-tz3iJ9cx0Q74xCLtyAQ@mail.gmail.com>
Subject: Re: [PATCH] configure: Avoid compiling system tools on user build by
 default
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="00000000000053b441059eb66fb6"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "open list:bochs" <qemu-block@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000053b441059eb66fb6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

5:23 PM Sub, 15.02.2020. Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =D1=
=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> User-mode does not need the sytem tools. Do not build them by
> default if user specified --disable-system.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  configure | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>

It would be nice if somebody comes up with more detailed analysis on what
is built for --disable-system, but in fact not needed at all.

How does your change affect the size of the executable?

> diff --git a/configure b/configure
> index 16f94cd96b..557ca4bd04 100755
> --- a/configure
> +++ b/configure
> @@ -455,7 +455,7 @@ guest_agent_ntddscsi=3D"no"
>  guest_agent_msi=3D""
>  vss_win32_sdk=3D""
>  win_sdk=3D"no"
> -want_tools=3D"yes"
> +want_tools=3D""
>  libiscsi=3D""
>  libnfs=3D""
>  coroutine=3D""
> @@ -2199,6 +2199,15 @@ else
>      echo big/little test failed
>  fi
>
> +##########################################
> +# system tools
> +if test "$want_tools" !=3D "yes" && test "$softmmu" =3D "no"; then
> +    want_tools=3Dno
> +fi
> +if test -z "$want_tools"; then
> +    want_tools=3Dyes
> +fi
> +
>  ##########################################
>  # cocoa implies not SDL or GTK
>  # (the cocoa UI code currently assumes it is always the active UI
> --
> 2.21.1
>
>

--00000000000053b441059eb66fb6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">5:23 PM Sub, 15.02.2020. Philippe Mathieu-Daud=C3=A9 &lt;<a =
href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; =D1=98=D0=B5 =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; User-mode does not need the sytem tools. Do not build them by<br>
&gt; default if user specified --disable-system.<br>
&gt;<br>
&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug=
@amsat.org">f4bug@amsat.org</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0configure | 11 ++++++++++-<br>
&gt; =C2=A01 file changed, 10 insertions(+), 1 deletion(-)<br>
&gt;</p>
<p dir=3D"ltr">It would be nice if somebody comes up with more detailed ana=
lysis on what is built for --disable-system, but in fact not needed at all.=
</p>
<p dir=3D"ltr">How does your change affect the size of the executable?<br><=
/p>
<p dir=3D"ltr">&gt; diff --git a/configure b/configure<br>
&gt; index 16f94cd96b..557ca4bd04 100755<br>
&gt; --- a/configure<br>
&gt; +++ b/configure<br>
&gt; @@ -455,7 +455,7 @@ guest_agent_ntddscsi=3D&quot;no&quot;<br>
&gt; =C2=A0guest_agent_msi=3D&quot;&quot;<br>
&gt; =C2=A0vss_win32_sdk=3D&quot;&quot;<br>
&gt; =C2=A0win_sdk=3D&quot;no&quot;<br>
&gt; -want_tools=3D&quot;yes&quot;<br>
&gt; +want_tools=3D&quot;&quot;<br>
&gt; =C2=A0libiscsi=3D&quot;&quot;<br>
&gt; =C2=A0libnfs=3D&quot;&quot;<br>
&gt; =C2=A0coroutine=3D&quot;&quot;<br>
&gt; @@ -2199,6 +2199,15 @@ else<br>
&gt; =C2=A0 =C2=A0 =C2=A0echo big/little test failed<br>
&gt; =C2=A0fi<br>
&gt;<br>
&gt; +##########################################<br>
&gt; +# system tools<br>
&gt; +if test &quot;$want_tools&quot; !=3D &quot;yes&quot; &amp;&amp; test =
&quot;$softmmu&quot; =3D &quot;no&quot;; then<br>
&gt; +=C2=A0 =C2=A0 want_tools=3Dno<br>
&gt; +fi<br>
&gt; +if test -z &quot;$want_tools&quot;; then<br>
&gt; +=C2=A0 =C2=A0 want_tools=3Dyes<br>
&gt; +fi<br>
&gt; +<br>
&gt; =C2=A0##########################################<br>
&gt; =C2=A0# cocoa implies not SDL or GTK<br>
&gt; =C2=A0# (the cocoa UI code currently assumes it is always the active U=
I<br>
&gt; -- <br>
&gt; 2.21.1<br>
&gt;<br>
&gt;<br>
</p>

--00000000000053b441059eb66fb6--

