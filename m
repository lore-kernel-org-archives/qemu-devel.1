Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A866EC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:16:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E8B72065D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4/Gbpnc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E8B72065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOJ3L-0007AF-RN
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 07:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kOJ2K-0006ix-1j
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:15:40 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:44740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kOJ2H-00057k-JP
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:15:39 -0400
Received: by mail-lf1-x142.google.com with SMTP id 197so1356435lfo.11
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 04:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=hIFFm6e8RECI1FPLKy0AeDc2eD2qU9GGZgKv1lTxSm0=;
 b=N4/GbpncEz/iUWm3zGmged50XR9Sr46iZdezfz1lydv47NOvo2zumN1uBsmcx+A8ir
 ld5pPgsg4rgVFRXw+8eh9GpW5wgMvAhp1Ty3e5PpUAlhRaDA06soa+UARcr3RTExH8gK
 akY1OquJDjvy9ueJNKAaT63HbpEt7zf/nqNWq1vRI2YiFAH7hDjnH08ZQWutKrLeiDHf
 RooORgEpfG9/uJMFIOuMbnM6TYDGzxenlhyfIaP2Uc7iOT9WJNQy/aZAwjlzzc8e0eSZ
 kVRG+MBHwWySX0HzLzWkHnwnFWsqe0MWm/WPbzAHzyTu7jBoQHkgjmVdon+/wxFdDuVl
 2Uig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=hIFFm6e8RECI1FPLKy0AeDc2eD2qU9GGZgKv1lTxSm0=;
 b=cZBjtqtuVvzFG6NPV23ENpgnspPIn1MehMA8FspZ01GEi0vTaEAPsJtWGyrh/SbZQ1
 MRQ/uqtcrFXgtvXYSN5UBVAWEVZRJSFEBYwodEHP7Rb7UHdyPut9+0dEqYzK5W9G5ASh
 v7AKy7R7i4f3B/qNLBWYHJIJHUjdqO199JAi0uQqpCxV2WCzv3S2XI1JcouZpwlvhb8Q
 hfRsspadBazv3++lUNsH+uLUEOWklOrkZGU4GxVtzuDn6Ry/C6zvDHPNAI0DFiq5PK52
 6elowcbSpfT2fuZCQ7jjN8nf2lK24rsh5TPMwKar+xNtGfILH/rs9lBCACsnXBD1lQ7Y
 +w+w==
X-Gm-Message-State: AOAM531iYuvcemUFVSkzTkbmSlNLjmV+NZU530WdzsJbARfjWnLumGEg
 Xutz422t5IesVrufmmC6d4fC0piidTNpXNpkIT0=
X-Google-Smtp-Source: ABdhPJz3hUc08XDXfcc0IVEMKmJ1/VUUUYKvZ9ajtGdbf5s9/0fYoFbBFRlb7BM1MM01FlWi8AS+8Zjii7apZqcqCyg=
X-Received: by 2002:a19:a407:: with SMTP id q7mr645050lfc.377.1601637335238;
 Fri, 02 Oct 2020 04:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201002105239.2444-1-peter.maydell@linaro.org>
In-Reply-To: <20201002105239.2444-1-peter.maydell@linaro.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 2 Oct 2020 19:15:24 +0800
Message-ID: <CAE2XoE-v0w6Ck5BFfzGYtUZz2UUdUv=ycyveDsqjdjFFi59yAg@mail.gmail.com>
Subject: Re: [PATCH] meson.build: Don't look for libudev for static builds
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000006d10d005b0ae40ae"
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x142.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006d10d005b0ae40ae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So the better way is pkg-config handling sttaic properly=EF=BC=9F
On Fri, Oct 2, 2020 at 6:53 PM Peter Maydell <peter.maydell@linaro.org>
wrote:
>
> commit f01496a314d916 moved the logic for detecting libudev from
> configure to meson.build, but in the process it dropped the condition
> that meant we only ask pkg-config about libudev for a non-static
> build.
>
> This breaks static builds of the system emulators on at least Ubuntu
> 18.04.4, because on that host there is no static libudev but
> pkg-config still claims it exists.
>
> Reinstate the logic that we had in the configure check.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> We could certainly do something cleverer here, but basic "convert
> from configure to meson" should in general not also be changing the
> detection logic IMHO.  We can make the logic smarter as a follow-on
> patch if desired.
> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/meson.build b/meson.build
> index 3161c1f037a..07da66e1d81 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -271,7 +271,7 @@ if 'CONFIG_CURL' in config_host
>                              link_args: config_host['CURL_LIBS'].split())
>  endif
>  libudev =3D not_found
> -if targetos =3D=3D 'linux' and (have_system or have_tools)
> +if targetos =3D=3D 'linux' and (have_system or have_tools) and not
enable_static
>    libudev =3D dependency('libudev',
>                         required: get_option('mpath').enabled(),
>                         static: enable_static)
> --
> 2.20.1
>
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000006d10d005b0ae40ae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>So the better way is pkg-config handling sttaic proper=
ly=EF=BC=9F<br>On Fri, Oct 2, 2020 at 6:53 PM Peter Maydell &lt;<a href=3D"=
mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br=
>&gt;<br>&gt; commit f01496a314d916 moved the logic for detecting libudev f=
rom<br>&gt; configure to meson.build, but in the process it dropped the con=
dition<br>&gt; that meant we only ask pkg-config about libudev for a non-st=
atic<br>&gt; build.<br>&gt;<br>&gt; This breaks static builds of the system=
 emulators on at least Ubuntu<br>&gt; 18.04.4, because on that host there i=
s no static libudev but<br>&gt; pkg-config still claims it exists.<br>&gt;<=
br>&gt; Reinstate the logic that we had in the configure check.<br>&gt;<br>=
&gt; Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linar=
o.org">peter.maydell@linaro.org</a>&gt;<br>&gt; ---<br>&gt; We could certai=
nly do something cleverer here, but basic &quot;convert<br>&gt; from config=
ure to meson&quot; should in general not also be changing the<br>&gt; detec=
tion logic IMHO.=C2=A0 We can make the logic smarter as a follow-on<br>&gt;=
 patch if desired.<br>&gt; ---<br>&gt; =C2=A0meson.build | 2 +-<br>&gt; =C2=
=A01 file changed, 1 insertion(+), 1 deletion(-)<br>&gt;<br>&gt; diff --git=
 a/meson.build b/meson.build<br>&gt; index 3161c1f037a..07da66e1d81 100644<=
br>&gt; --- a/meson.build<br>&gt; +++ b/meson.build<br>&gt; @@ -271,7 +271,=
7 @@ if &#39;CONFIG_CURL&#39; in config_host<br>&gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0link_args: config_host[&#39;CURL_LIBS&#39;].split())<br>&gt; =C2=
=A0endif<br>&gt; =C2=A0libudev =3D not_found<br>&gt; -if targetos =3D=3D &#=
39;linux&#39; and (have_system or have_tools)<br>&gt; +if targetos =3D=3D &=
#39;linux&#39; and (have_system or have_tools) and not enable_static<br>&gt=
; =C2=A0 =C2=A0libudev =3D dependency(&#39;libudev&#39;,<br>&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
equired: get_option(&#39;mpath&#39;).enabled(),<br>&gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 static: =
enable_static)<br>&gt; --<br>&gt; 2.20.1<br>&gt;<br>&gt;<br><br><br>--<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=
=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<=
/div>

--0000000000006d10d005b0ae40ae--

