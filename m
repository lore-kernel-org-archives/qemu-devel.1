Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D56C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 03:02:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08795223BF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 03:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="dUTVuj8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08795223BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUhua-0006sJ-3N
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 23:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kUhtU-0006Lz-LW
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 23:01:00 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kUhtQ-0001He-8K
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 23:01:00 -0400
Received: by mail-wm1-x341.google.com with SMTP id b127so232175wmb.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 20:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gyCibGHS0u0MLkxGESc4IB1y2MBHBnB3npasyqkvemA=;
 b=dUTVuj8L89yATlOOSuvs/i3ZcuPEL/LfOTAK9fUO5zzrXRt453GjgQi9OqgV+yEZ6M
 OZrnycAN1dvFPyxC4rbyFv0xBSJiHb/jla71ewkc7wICcsT0l7uaNoqXl6PzXfscgE3v
 9WOgdv12kbcHUBRXMA2KnCWmQ3t8ma+G7mNvqF7p424pfD/Zg8PuhOSfkx6meourvStB
 lfngxJcYrPYuDGzdRjQjkQV25QpZP5Tj1uES+MiscDSGIfL3p9qEufrpu1I/jcXN6MEv
 uNmukoZSda2yYeoS0rIj1Ew/fMfCRpKlegb+JMhd6AebVIReO54O3m5GanWaB4A752RT
 wmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gyCibGHS0u0MLkxGESc4IB1y2MBHBnB3npasyqkvemA=;
 b=dfHUJU3R1KKqAOwusWUpC+EKTrYXsfy9dc+70f4ZDGFF+/d9/lptPckc0IseWG9BhU
 p7JQCh69OggdIWnUeOelI/vQdx9sEgENnV4aaZyU0r1WzESZbVM2vDHw5eYfWpuDk7hH
 HKFLdyLKLCjS3XUD+WMfhLFeaH+m0JGpQ7z/sJMsNi54vYYEchW8XGUJ+eIDm91qahoS
 yEQz7raEFZmcrt0v75hqRc5p3LXuhXDDbNeeAeBwnPTsA/YcKAlm6CbKxXwNmiIQf3xx
 P0mG1ScvnO+jMqm4JUxPEoZu3KDC1Zz0h1h2V/2IAqfYZ817iA3o35xLAgLzv8jD5yid
 jvCA==
X-Gm-Message-State: AOAM533eUM9/M/06QGAAIynznr+eYtAlevRvJK9QZV648aQkV6De09Ib
 ejHJBZMlAhIRuFQLqvPYMT6bA+ZgeEDvyqqEKx4vbA==
X-Google-Smtp-Source: ABdhPJxMD/RqX6KtoemNuVAA8okrioM2ebw6cKj8qI0xgNTZMyrUHOCwNTot03K3sDwa32PdxYAOtO7X5qdlek1XkTw=
X-Received: by 2002:a7b:c01a:: with SMTP id c26mr453716wmb.35.1603162848779;
 Mon, 19 Oct 2020 20:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201007161940.1478-1-ani@anisinha.ca>
 <0250c54c-ea93-335b-7d37-cbfe79e4086f@amsat.org>
 <CAARzgwxfPKRT0+rr3oBDqUMY2PK-abHH+3oxgG6YLkE1ayzudQ@mail.gmail.com>
 <CAARzgwx=K6PDPngxQgdd3Z3aTfo=y5DSEw7WBy0CzKTRQbsBXg@mail.gmail.com>
In-Reply-To: <CAARzgwx=K6PDPngxQgdd3Z3aTfo=y5DSEw7WBy0CzKTRQbsBXg@mail.gmail.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Tue, 20 Oct 2020 08:30:38 +0530
Message-ID: <CAARzgwyTqpEDh5vJtv3F3FRRNFYzYb+M5F9QZB1PSKS8a6yNJg@mail.gmail.com>
Subject: Re: [PATCH v2] Adding ani's email as an individual contributor
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000001e795705b21170c0"
Received-SPF: none client-ip=2a00:1450:4864:20::341;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001e795705b21170c0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

more ping ...

On Thu, Oct 15, 2020 at 8:22 PM Ani Sinha <ani@anisinha.ca> wrote:

> Ping ...
>
> On Mon, Oct 12, 2020 at 8:27 PM Ani Sinha <ani@anisinha.ca> wrote:
> >
> > Request to queue this patch for the next pull.
> >
> > On Wed, Oct 7, 2020 at 23:25 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
> wrote:
> >>
> >> On 10/7/20 6:19 PM, Ani Sinha wrote:
> >> > Ani is an individual contributor into qemu project. Adding my email
> into the
> >> > correct file to reflect so.
> >> >
> >>
> >> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> Thanks!
> >>
> >> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> >> > ---
> >> >  contrib/gitdm/group-map-individuals | 1 +
> >> >  1 file changed, 1 insertion(+)
> >> >
> >> > changelog:
> >> > v2: removed accidentally added submodule update into this commit
> >> > v1: initial patch
> >> >
> >> > diff --git a/contrib/gitdm/group-map-individuals
> b/contrib/gitdm/group-map-individuals
> >> > index cf8a2ce367..64cb859193 100644
> >> > --- a/contrib/gitdm/group-map-individuals
> >> > +++ b/contrib/gitdm/group-map-individuals
> >> > @@ -16,3 +16,4 @@ aurelien@aurel32.net
> >> >  balaton@eik.bme.hu
> >> >  e.emanuelegiuseppe@gmail.com
> >> >  andrew.smirnov@gmail.com
> >> > +ani@anisinha.ca
> >> >
>

--0000000000001e795705b21170c0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">more ping ...</div><div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 15, 2020 at 8:22 PM Ani Sin=
ha &lt;<a href=3D"mailto:ani@anisinha.ca">ani@anisinha.ca</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left-width:1px;border-left-style:solid;padding-left:1ex;border-left-=
color:rgb(204,204,204)">Ping ...<br>
<br>
On Mon, Oct 12, 2020 at 8:27 PM Ani Sinha &lt;<a href=3D"mailto:ani@anisinh=
a.ca" target=3D"_blank">ani@anisinha.ca</a>&gt; wrote:<br>
&gt;<br>
&gt; Request to queue this patch for the next pull.<br>
&gt;<br>
&gt; On Wed, Oct 7, 2020 at 23:25 Philippe Mathieu-Daud=C3=A9 &lt;<a href=
=3D"mailto:f4bug@amsat.org" target=3D"_blank">f4bug@amsat.org</a>&gt; wrote=
:<br>
&gt;&gt;<br>
&gt;&gt; On 10/7/20 6:19 PM, Ani Sinha wrote:<br>
&gt;&gt; &gt; Ani is an individual contributor into qemu project. Adding my=
 email into the<br>
&gt;&gt; &gt; correct file to reflect so.<br>
&gt;&gt; &gt;<br>
&gt;&gt;<br>
&gt;&gt; Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4b=
ug@amsat.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
&gt;&gt; Thanks!<br>
&gt;&gt;<br>
&gt;&gt; &gt; Signed-off-by: Ani Sinha &lt;<a href=3D"mailto:ani@anisinha.c=
a" target=3D"_blank">ani@anisinha.ca</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 contrib/gitdm/group-map-individuals | 1 +<br>
&gt;&gt; &gt;=C2=A0 1 file changed, 1 insertion(+)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; changelog:<br>
&gt;&gt; &gt; v2: removed accidentally added submodule update into this com=
mit<br>
&gt;&gt; &gt; v1: initial patch<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/contrib/gitdm/group-map-individuals b/contrib/gi=
tdm/group-map-individuals<br>
&gt;&gt; &gt; index cf8a2ce367..64cb859193 100644<br>
&gt;&gt; &gt; --- a/contrib/gitdm/group-map-individuals<br>
&gt;&gt; &gt; +++ b/contrib/gitdm/group-map-individuals<br>
&gt;&gt; &gt; @@ -16,3 +16,4 @@ <a href=3D"mailto:aurelien@aurel32.net" tar=
get=3D"_blank">aurelien@aurel32.net</a><br>
&gt;&gt; &gt;=C2=A0 <a href=3D"mailto:balaton@eik.bme.hu" target=3D"_blank"=
>balaton@eik.bme.hu</a><br>
&gt;&gt; &gt;=C2=A0 <a href=3D"mailto:e.emanuelegiuseppe@gmail.com" target=
=3D"_blank">e.emanuelegiuseppe@gmail.com</a><br>
&gt;&gt; &gt;=C2=A0 <a href=3D"mailto:andrew.smirnov@gmail.com" target=3D"_=
blank">andrew.smirnov@gmail.com</a><br>
&gt;&gt; &gt; +<a href=3D"mailto:ani@anisinha.ca" target=3D"_blank">ani@ani=
sinha.ca</a><br>
&gt;&gt; &gt;<br>
</blockquote></div></div>

--0000000000001e795705b21170c0--

