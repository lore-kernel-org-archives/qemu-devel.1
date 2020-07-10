Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4545FC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:31:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1037020748
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HzHh/k0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1037020748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtt7a-0008EI-9O
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtsqY-0007Qp-7f
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 09:13:46 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35972)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtsqW-0001um-CU
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 09:13:45 -0400
Received: by mail-oi1-x242.google.com with SMTP id h17so4753191oie.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dPpXu5hhqBSw0jqYkzOtP3zgembeKl4BAbJvbizG22k=;
 b=HzHh/k0QiUSpbFEu1M0O1exce/VWl6hBmWd4AiifWgW8SZbcEdk3tWXWs7fDyjp2jh
 25PIYwCSy6RGCXcU0dJeVKE5UEzlrKx2JpRXuHAONu1kxDkdWQ3fjrFO/Skrf6EYiUrn
 h5Z3YGOVy01OP/WFehsErwka9ZPiZWQt1YhWLrNnpLw6+7uWtQ5C5AZTJekkfTQwDG4t
 ucFbxRGXzrFlCo1s5W3XaDJ2fT600M9bZoUuRDds6obIA78KPTha/ndIMauEpwVejaJS
 w2LCtTYu5Qu6xfWHT8HW/zHruPXL7RNpGzmWQ6ksT0XW14X4p+CQ6SpVeH+HpTfaDmwK
 8dpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dPpXu5hhqBSw0jqYkzOtP3zgembeKl4BAbJvbizG22k=;
 b=FMIFQL/o29WV49VXmF7BijNKIYWn01iGKNKr5ewCNb6baJ3Y4FgRMm+QdTNPPVFJqc
 VwylBdBdjL6BNtdqNSXV7QoKejodwdsL/FUzBGaNiGFm3Vh+HR5b0yZu1zz/CxDYCXjz
 VP1N7tBnRGK6qmSTg++RLCC7cTVcmVjMKxFo9eLeD7DJiNLcoXF17Ej2pWhQQH/u7zwa
 vyhBhuAK6IIce5T3GKz/8kvcl5jv+OWItuSevZ8+k0+bm79g3R1L28tHLbx1NC2VsFlb
 c1IwiNsCkhzqGCxzxSsTTIg44OGroNzDh0kFsTFxTgDFFr6XsY7Ep1t+IKe9noNO/zoB
 ENZg==
X-Gm-Message-State: AOAM533JSTAAcohbjbBt1JvPQmvWWTsOLkWiJU5jb3QOkdiRbr49mxvv
 rku6Y1QvhDDtzObE+rINhku/1bCysvFLDbE2glgPyg==
X-Google-Smtp-Source: ABdhPJy9841wcG5nFt/SkyrbE0TAbOJN58sq7D+yWvRTppLkKxk01PxRGSgXTvj/9NiiPvbLlQhzMG+HmQVHX8bifYQ=
X-Received: by 2002:aca:6289:: with SMTP id w131mr3782881oib.122.1594386822925; 
 Fri, 10 Jul 2020 06:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-61-frank.chang@sifive.com> <87k0zblgjx.fsf@linaro.org>
 <CAE_xrPhKg1FeRwW0zS-jpfo8XL7WvSFywif27X0kAYgh044N6w@mail.gmail.com>
 <878sfrleq9.fsf@linaro.org>
In-Reply-To: <878sfrleq9.fsf@linaro.org>
From: Frank Chang <frank.chang@sifive.com>
Date: Fri, 10 Jul 2020 21:13:32 +0800
Message-ID: <CAE_xrPht7BytoFxLdkGk+CRr+kEyT50woe_UE5mRVHjk6=pORA@mail.gmail.com>
Subject: Re: [RFC 60/65] softfloat: add fp16 and uint8/int8 interconvert
 functions
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000003725ab05aa161ce0"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=frank.chang@sifive.com; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003725ab05aa161ce0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 8:46 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> Frank Chang <frank.chang@sifive.com> writes:
>
> > On Fri, Jul 10, 2020 at 8:07 PM Alex Benn=C3=A9e <alex.bennee@linaro.or=
g>
> wrote:
> >
> >>
> >> frank.chang@sifive.com writes:
> >>
> >> > From: Frank Chang <frank.chang@sifive.com>
> >> >
> >> > Signed-off-by: Frank Chang <frank.chang@sifive.com>
> >>
> >> Did I miss the rest of the series somewhere?
> >>
> >> Otherwise this looks fine to me:
> >>
> >> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >>
> >> If you mean float16 to uint8 and int8 conversion functions, this commi=
t
> is
> > everything.
> > I think I just cc the mail based on *scripts/get_maintainer.pl
> > <http://get_maintainer.pl>*, so probably didn't send the whole series t=
o
> > everyone.
>
> Usually I see the rest of the thread from the mailing list. I can't see:
>
>   In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
>   References: <20200710104920.13550-1-frank.chang@sifive.com>
>
> on any of the qemu mailing lists.
>
> --
> Alex Benn=C3=A9e
>

The rest of the patches are coming out:
https://patchew.org/QEMU/20200710104920.13550-1-frank.chang@sifive.com/
Not sure what caused the delay...
--
Frank Chang

--0000000000003725ab05aa161ce0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, Jul 10, 2020 at 8:46 PM Alex Benn=
=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.or=
g</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"><br>
Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" target=3D"_blank"=
>frank.chang@sifive.com</a>&gt; writes:<br>
<br>
&gt; On Fri, Jul 10, 2020 at 8:07 PM Alex Benn=C3=A9e &lt;<a href=3D"mailto=
:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt; w=
rote:<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"mailto:frank.chang@sifive.com" target=3D"_blank">frank.=
chang@sifive.com</a> writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; From: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.co=
m" target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@=
sifive.com" target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; Did I miss the rest of the series somewhere?<br>
&gt;&gt;<br>
&gt;&gt; Otherwise this looks fine to me:<br>
&gt;&gt;<br>
&gt;&gt; Reviewed-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@li=
naro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; If you mean float16 to uint8 and int8 conversion functions, this c=
ommit is<br>
&gt; everything.<br>
&gt; I think I just cc the mail based on *scripts/<a href=3D"http://get_mai=
ntainer.pl" rel=3D"noreferrer" target=3D"_blank">get_maintainer.pl</a><br>
&gt; &lt;<a href=3D"http://get_maintainer.pl" rel=3D"noreferrer" target=3D"=
_blank">http://get_maintainer.pl</a>&gt;*, so probably didn&#39;t send the =
whole series to<br>
&gt; everyone.<br>
<br>
Usually I see the rest of the thread from the mailing list. I can&#39;t see=
:<br>
<br>
=C2=A0 In-Reply-To: &lt;<a href=3D"mailto:20200710104920.13550-1-frank.chan=
g@sifive.com" target=3D"_blank">20200710104920.13550-1-frank.chang@sifive.c=
om</a>&gt;<br>
=C2=A0 References: &lt;<a href=3D"mailto:20200710104920.13550-1-frank.chang=
@sifive.com" target=3D"_blank">20200710104920.13550-1-frank.chang@sifive.co=
m</a>&gt;<br>
<br>
on any of the qemu mailing lists.<br>
<br>
-- <br>
Alex Benn=C3=A9e<br></blockquote><div>=C2=A0</div><div>The rest of the patc=
hes are coming out:=C2=A0<a href=3D"https://patchew.org/QEMU/20200710104920=
.13550-1-frank.chang@sifive.com/">https://patchew.org/QEMU/20200710104920.1=
3550-1-frank.chang@sifive.com/</a></div><div>Not sure what caused the delay=
...</div><div>--</div><div>Frank Chang</div></div></div>

--0000000000003725ab05aa161ce0--

