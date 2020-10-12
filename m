Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AEBC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 14:58:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74B1520838
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 14:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="0pt3m7j2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B1520838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRzHQ-0006Sq-IY
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 10:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kRzGc-0005N0-Oj
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 10:57:38 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kRzGa-0002Tk-Lt
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 10:57:38 -0400
Received: by mail-wr1-x442.google.com with SMTP id s9so7446768wro.8
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 07:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=syD2ZN3COAIys7wG+iAm/OcO2dYMdcIcOGhowuXW9sI=;
 b=0pt3m7j2L0UHmTPrY+NGiet4PkEMnGnWwoTcBL6623CHNepgwsFs7KEBvO+wdU/Rch
 Torzb1kssOLH90+KvHWAbiVBZeSZxbDyfeJcnIMhZdH/K/Ot0OsEp1tViw0L0j71wcsQ
 gScY7dS9S+owO9luunwyOZJt5plJ3E/Y7pTmQiPLhW7FEV63GsTOsDF3vusV2mEvX6J1
 g4MciiIqrQffueK93nnouVNH942X+1PdozIqHbEoHhTRXWNSL7HakIvVP+3Dk3LpGXlx
 c8cYWR5EkcmcdmQRon7lGzhMi0tuokC/4zdx1odENxd6MkRXHppIpwg7OKxGuFtUw3cf
 d9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=syD2ZN3COAIys7wG+iAm/OcO2dYMdcIcOGhowuXW9sI=;
 b=kJRBo2jY+l0xjpivQx+J10xaWa5LOiwWylZG+YZUtqI/c0AHIsB8RnM4USyXIDxS96
 rQTSyfgiSFihpanTes2Oc4eNbtYPbnn30U5Sc4ZgKeo57gEhGE7u8s7PiaafrXxIH5b3
 bERWvgbJ8fsPCuN4P/On+kcSjOecC5klTic6DaV7FSMgIur8GM+QZn6MyeRZdBQodsKD
 k9O+XZ3TAJLiSHa5T0+PQmJqOH4q9k81qJscfTCYOH99EKt/Y+c4mQpc8BsRWk0BTRwW
 2O1OxN/+QXKoPovdpFwRHKFyuvBEhYvhfL3ISxotf349slacPkpvaHlE3nPGdeb2tzOx
 rnTQ==
X-Gm-Message-State: AOAM530ftflHm2RGo8+Mit+Et5pckowB4kwBi7dw8wkLioYzCMKCw4M8
 JADJmjoAZIUqO/wpCN5CiuogFHnKM4S3A0q/yn77mw==
X-Google-Smtp-Source: ABdhPJw+vGCnihLG9QY4q6CXKQwQwGA/GGyGniWTRUGJHUTVJmUMiYP8WA9JwMnkOEIy82V2hUU2xoI5fcdDJkmAgK8=
X-Received: by 2002:a5d:4f09:: with SMTP id c9mr29182661wru.427.1602514654823; 
 Mon, 12 Oct 2020 07:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20201007161940.1478-1-ani@anisinha.ca>
 <0250c54c-ea93-335b-7d37-cbfe79e4086f@amsat.org>
In-Reply-To: <0250c54c-ea93-335b-7d37-cbfe79e4086f@amsat.org>
From: Ani Sinha <ani@anisinha.ca>
Date: Mon, 12 Oct 2020 20:27:22 +0530
Message-ID: <CAARzgwxfPKRT0+rr3oBDqUMY2PK-abHH+3oxgG6YLkE1ayzudQ@mail.gmail.com>
Subject: Re: [PATCH v2] Adding ani's email as an individual contributor
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000bf9ca805b17a841b"
Received-SPF: none client-ip=2a00:1450:4864:20::442;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x442.google.com
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000bf9ca805b17a841b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Request to queue this patch for the next pull.

On Wed, Oct 7, 2020 at 23:25 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:

> On 10/7/20 6:19 PM, Ani Sinha wrote:
> > Ani is an individual contributor into qemu project. Adding my email int=
o
> the
> > correct file to reflect so.
> >
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Thanks!
>
> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > ---
> >  contrib/gitdm/group-map-individuals | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > changelog:
> > v2: removed accidentally added submodule update into this commit
> > v1: initial patch
> >
> > diff --git a/contrib/gitdm/group-map-individuals
> b/contrib/gitdm/group-map-individuals
> > index cf8a2ce367..64cb859193 100644
> > --- a/contrib/gitdm/group-map-individuals
> > +++ b/contrib/gitdm/group-map-individuals
> > @@ -16,3 +16,4 @@ aurelien@aurel32.net
> >  balaton@eik.bme.hu
> >  e.emanuelegiuseppe@gmail.com
> >  andrew.smirnov@gmail.com
> > +ani@anisinha.ca
> >
>

--000000000000bf9ca805b17a841b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Request to queue this patch for the next pull.</div><div>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed=
, Oct 7, 2020 at 23:25 Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4=
bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;borde=
r-left-style:solid;padding-left:1ex;border-left-color:rgb(204,204,204)">On =
10/7/20 6:19 PM, Ani Sinha wrote:<br>
&gt; Ani is an individual contributor into qemu project. Adding my email in=
to the<br>
&gt; correct file to reflect so.<br>
&gt; <br>
<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.=
org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
Thanks!<br>
<br>
&gt; Signed-off-by: Ani Sinha &lt;<a href=3D"mailto:ani@anisinha.ca" target=
=3D"_blank">ani@anisinha.ca</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 contrib/gitdm/group-map-individuals | 1 +<br>
&gt;=C2=A0 1 file changed, 1 insertion(+)<br>
&gt; <br>
&gt; changelog:<br>
&gt; v2: removed accidentally added submodule update into this commit<br>
&gt; v1: initial patch<br>
&gt; <br>
&gt; diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group=
-map-individuals<br>
&gt; index cf8a2ce367..64cb859193 100644<br>
&gt; --- a/contrib/gitdm/group-map-individuals<br>
&gt; +++ b/contrib/gitdm/group-map-individuals<br>
&gt; @@ -16,3 +16,4 @@ <a href=3D"mailto:aurelien@aurel32.net" target=3D"_b=
lank">aurelien@aurel32.net</a><br>
&gt;=C2=A0 <a href=3D"mailto:balaton@eik.bme.hu" target=3D"_blank">balaton@=
eik.bme.hu</a><br>
&gt;=C2=A0 <a href=3D"mailto:e.emanuelegiuseppe@gmail.com" target=3D"_blank=
">e.emanuelegiuseppe@gmail.com</a><br>
&gt;=C2=A0 <a href=3D"mailto:andrew.smirnov@gmail.com" target=3D"_blank">an=
drew.smirnov@gmail.com</a><br>
&gt; +<a href=3D"mailto:ani@anisinha.ca" target=3D"_blank">ani@anisinha.ca<=
/a><br>
&gt; <br>
</blockquote></div></div>

--000000000000bf9ca805b17a841b--

