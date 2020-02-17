Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931E3C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 12:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BF4620725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 12:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEbYiSiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF4620725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3fds-0001gf-IQ
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 07:36:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j3fd5-0000nG-J2
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 07:36:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j3fd4-00012V-BX
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 07:36:03 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46208)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j3fd4-00011t-4c; Mon, 17 Feb 2020 07:36:02 -0500
Received: by mail-oi1-x242.google.com with SMTP id a22so16486358oid.13;
 Mon, 17 Feb 2020 04:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6ghKLtGsRz7m25WuINep8mrAhMPyA48fvCj1PGFz9mY=;
 b=GEbYiSiXrs2KuW4HmzQ8zZnw2Srr/eb1XkEo4dT+BPO0NmNDAahIIwpn/FBVmaeRLk
 nD7tXnX5DmakaCbtPEdIkfuGTSwcyFWPJO53zLqwMFQqrvjyZXLMagySxJ5+KVjfaH90
 jYFGuWylpByJgWu/jSla0YYRSwZfrAYbfbomBNicxKaXYF+r1+i35Ni6RN3vbRYMFu+0
 NdmNQY+no99DkoTLftFJv35uRmqxI9qwhU4M5dm+HRLkCRSdtX4YZvSgCYCMftQmgzxS
 QKh4wckOn+aq8M72QshkS8yRzlUYnjbZAM9YlRVu7hHOmxgl5gVACwUglVQG5UEuhueP
 SI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6ghKLtGsRz7m25WuINep8mrAhMPyA48fvCj1PGFz9mY=;
 b=Fr+XA0VJHf53l9nelUJmk8LIo716ovhMZ6dvrLyE4gzMR9uRaQ6q3ws/jhekFb7+5d
 LgD1TcnuJFbBXfaO8lwmVgrGNmz/1zKK1F7JVJF/qkT0cEl35KrLzsx0XYrwg61ldUSj
 qjUqR/NkSvNliA2gK9PeqPwU7gT/ORyUf5vlV23pZ46OJ2ieeU3N2ty7A23kJSCsDeBB
 6BOY3mzmSMlZu6DBeJmTeCKCyzI6Wipq6oxvtkB6bMl3++QfqUgBNrxpmMrO9NgVtMPB
 kAI8P+ZsT+FrmBX4Oq6Xiz0VF43tKEkC+MsNC9PNLu0csJ46xFxVhJNM8b5GQsyEldpz
 hYcw==
X-Gm-Message-State: APjAAAXxmcjNLIdPTmY40p7CX6kajdGppL5Knjl5tB44KuhzmJrsxDso
 hTJo0hFZ4AcOBeUzn05jvuiaAkpp8OMDKjRJUIo=
X-Google-Smtp-Source: APXvYqyT4nDiEYtol5JsODVgraoGgMEzjp5/HegHRmHG6nkWePpbrshShXb/W630G14DxE4+TlBWsFBaY/s9rPIhoMw=
X-Received: by 2002:a05:6808:64e:: with SMTP id
 z14mr9348622oih.79.1581942960680; 
 Mon, 17 Feb 2020 04:36:00 -0800 (PST)
MIME-Version: 1.0
References: <20200217095955.11140-1-philmd@redhat.com>
In-Reply-To: <20200217095955.11140-1-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 17 Feb 2020 13:35:41 +0100
Message-ID: <CAL1e-=jkpXbOLsF1dXD0hieWGo6CUd8yXkS_nyTuuqrs-pDs2A@mail.gmail.com>
Subject: Re: [PATCH v2] configure: Avoid compiling system tools on user build
 by default
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000039f540059ec4ccdb"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: "open list:bochs" <qemu-block@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000039f540059ec4ccdb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

11:00 AM Pon, 17.02.2020. Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =
=D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> User-mode does not need the sytem tools.

system

> Do not build them by
> default if user specified --disable-system.

specifies

>
> This disables building the following binary on a user-only build:

binaries

>
> - elf2dmp
> - qemu-edid
> - qemu-ga
> - qemu-img
> - qemu-io
> - qemu-nbd
> - ivshmem-client
> - ivshmem-server
>
> The qemu-user binary is not affected by this change.

binaries are

>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> v2:
> - use simpler if/else statement (therefore not adding Richard R-b)
> - improved description (Aleksandar)
> ---
>  configure | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index 16f94cd96b..d1877a60f5 100755
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
> @@ -2199,6 +2199,16 @@ else
>      echo big/little test failed
>  fi
>
> +##########################################
> +# system tools
> +if test -z "$want_tools"; then
> +    if test "$softmmu" =3D "no"; then
> +        want_tools=3Dno
> +    else
> +        want_tools=3Dyes
> +    fi
> +fi
> +
>  ##########################################
>  # cocoa implies not SDL or GTK
>  # (the cocoa UI code currently assumes it is always the active UI
> --
> 2.21.1
>

--00000000000039f540059ec4ccdb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">11:00 AM Pon, 17.02.2020. Philippe Mathieu-Daud=C3=A9 &lt;<a=
 href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; From: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.or=
g">f4bug@amsat.org</a>&gt;<br>
&gt;<br>
&gt; User-mode does not need the sytem tools.</p>
<p dir=3D"ltr">system</p>
<p dir=3D"ltr">&gt; Do not build them by<br>
&gt; default if user specified --disable-system.</p>
<p dir=3D"ltr">specifies</p>
<p dir=3D"ltr">&gt;<br>
&gt; This disables building the following binary on a user-only build:</p>
<p dir=3D"ltr">binaries</p>
<p dir=3D"ltr">&gt;<br>
&gt; - elf2dmp<br>
&gt; - qemu-edid<br>
&gt; - qemu-ga<br>
&gt; - qemu-img<br>
&gt; - qemu-io<br>
&gt; - qemu-nbd<br>
&gt; - ivshmem-client<br>
&gt; - ivshmem-server<br>
&gt;<br>
&gt; The qemu-user binary is not affected by this change.</p>
<p dir=3D"ltr">binaries are</p>
<p dir=3D"ltr">&gt;<br>
&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug=
@amsat.org">f4bug@amsat.org</a>&gt;<br>
&gt; ---<br>
&gt; v2:<br>
&gt; - use simpler if/else statement (therefore not adding Richard R-b)<br>
&gt; - improved description (Aleksandar)<br>
&gt; ---<br>
&gt; =C2=A0configure | 12 +++++++++++-<br>
&gt; =C2=A01 file changed, 11 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/configure b/configure<br>
&gt; index 16f94cd96b..d1877a60f5 100755<br>
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
&gt; @@ -2199,6 +2199,16 @@ else<br>
&gt; =C2=A0 =C2=A0 =C2=A0echo big/little test failed<br>
&gt; =C2=A0fi<br>
&gt;<br>
&gt; +##########################################<br>
&gt; +# system tools<br>
&gt; +if test -z &quot;$want_tools&quot;; then<br>
&gt; +=C2=A0 =C2=A0 if test &quot;$softmmu&quot; =3D &quot;no&quot;; then<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 want_tools=3Dno<br>
&gt; +=C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 want_tools=3Dyes<br>
&gt; +=C2=A0 =C2=A0 fi<br>
&gt; +fi<br>
&gt; +<br>
&gt; =C2=A0##########################################<br>
&gt; =C2=A0# cocoa implies not SDL or GTK<br>
&gt; =C2=A0# (the cocoa UI code currently assumes it is always the active U=
I<br>
&gt; -- <br>
&gt; 2.21.1<br>
&gt;<br>
</p>

--00000000000039f540059ec4ccdb--

