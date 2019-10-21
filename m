Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_BOUND_DIGITS_15,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC32CA9EAE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 01:07:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD43420679
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 01:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD43420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMMAh-0000M2-RH
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 21:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hhan@redhat.com>) id 1iMM9E-00082k-7o
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 21:06:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hhan@redhat.com>) id 1iMM9B-0000jZ-6B
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 21:06:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37444)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hhan@redhat.com>) id 1iMM99-0000dt-5H
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 21:06:09 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0FC35C04959E
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 01:06:03 +0000 (UTC)
Received: by mail-oi1-f199.google.com with SMTP id f80so6757008oig.8
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2019 18:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n9WichSB2x9qjHeFGEDl17oZygTE95Ex5x3JdCOL9Yc=;
 b=Ho2PB7j3pnElJNHLfb4X+o8WPs4DNKd84bqawWLXj0Y5ZqsMw2cM0mabUXDDf/Gshp
 X2lK6Yhb9HPZuVat442twfNNRAJ64sCpQqG7klOClsK0mLkux5KFhBfJ0bdF3Wck4Ran
 YpMZUDRkj54xZJKZ3T38Pj7ECXfghqM7xDsb+BbeXu94PTV1wwfktKajkgQ9Y25bkTWg
 tuXadaORxaKCk9tAjD5japCahGH6wAn7bm+1JdKLo3hg6oC4ShmAyvZBHwrBpFeqfy+6
 KdS2h2cs8h6P6V033Kv74qgFtcqT7iCD6224MBdJIiC2BALZSVCcPGduyyE2CqTHsaap
 GUhQ==
X-Gm-Message-State: APjAAAWJKIPMHfEYRbCp2/zC2p9fcipj2tC+Uc9fKhZBRHlWDmGSgWlh
 y0gRNiO6bslyaxctGb7Vafp2PbI2rYHGYQBXzQOB849p0lxM5UlGCE/OfpZ4r++J+tv/t/lu2Zv
 iVKpEO/gxMtBPEzH3DlTTf/Vha8Ioh5Q=
X-Received: by 2002:a9d:5f93:: with SMTP id g19mr17347541oti.260.1571619962418; 
 Sun, 20 Oct 2019 18:06:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxlFpedo1Cx0Ulthh322PQvg0wN+7guWiQcWHiryPbRsV+E7es3AA9CpQLg3VhHnALYkuPtVs3EG30UZo1NCzw=
X-Received: by 2002:a9d:5f93:: with SMTP id g19mr17347526oti.260.1571619962187; 
 Sun, 20 Oct 2019 18:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191018095924.4409-1-hhan@redhat.com>
 <39bde897-fd65-582d-7d2e-8aec27254898@redhat.com>
In-Reply-To: <39bde897-fd65-582d-7d2e-8aec27254898@redhat.com>
From: Han Han <hhan@redhat.com>
Date: Mon, 21 Oct 2019 09:06:15 +0800
Message-ID: <CAHjf+S9nvqz=rVSzp-5L9iKnbNA8aeOANhq5=Em4kafVQ2Cgaw@mail.gmail.com>
Subject: Re: [PATCH] qemu-img.texi: Describe data_file and data_file_raw
To: John Snow <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009191340595614940"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009191340595614940
Content-Type: text/plain; charset="UTF-8"

On Sat, Oct 19, 2019 at 4:58 AM John Snow <jsnow@redhat.com> wrote:

> CC qemu-block
>
> On 10/18/19 5:59 AM, Han Han wrote:
> > https://bugzilla.redhat.com/show_bug.cgi?id=1763105
> >
> > Signed-off-by: Han Han <hhan@redhat.com>
> > ---
> >  qemu-img.texi | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/qemu-img.texi b/qemu-img.texi
> > index b5156d6316..44596c2d93 100644
> > --- a/qemu-img.texi
> > +++ b/qemu-img.texi
> > @@ -763,6 +763,16 @@ file which is COW and has data blocks already, it
> couldn't be changed to NOCOW
> >  by setting @code{nocow=on}. One can issue @code{lsattr filename} to
> check if
> >  the NOCOW flag is set or not (Capital 'C' is NOCOW flag).
> >
> > +@item data_file
> > +File name of data file that is stored in the image and used as a
> default for
> > +opening the image. If the option is used, qcow2 file only stores the
> metadata
> > +of the image.
> > +
>
> This is a little unclear, and seems to imply the data file is stored
> *IN* the image.
>
> "Optional filename to be used as a data store for this qcow2 file. If
> this option is used, the qcow2 file only stores metadata for this image."
>
Thanks for your advice. I will update it in v2.

>
> > +@item data_file_raw
> > +This option requires @option{data_file}. If this option is set to
> @code{on},
> > +qemu will always keep the external data file consistent as a standalone
> > +read-only raw image. Default value is @code{off}.
> > +
> >  @end table
> >
> >  @item Other
> >
>
>

-- 
Best regards,
-----------------------------------
Han Han
Quality Engineer
Redhat.

Email: hhan@redhat.com
Phone: +861065339333

--0000000000009191340595614940
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Oct 19, 2019 at 4:58 AM John =
Snow &lt;<a href=3D"mailto:jsnow@redhat.com">jsnow@redhat.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">CC qemu-block<=
br>
<br>
On 10/18/19 5:59 AM, Han Han wrote:<br>
&gt; <a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1763105" rel=
=3D"noreferrer" target=3D"_blank">https://bugzilla.redhat.com/show_bug.cgi?=
id=3D1763105</a><br>
&gt; <br>
&gt; Signed-off-by: Han Han &lt;<a href=3D"mailto:hhan@redhat.com" target=
=3D"_blank">hhan@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qemu-img.texi | 10 ++++++++++<br>
&gt;=C2=A0 1 file changed, 10 insertions(+)<br>
&gt; <br>
&gt; diff --git a/qemu-img.texi b/qemu-img.texi<br>
&gt; index b5156d6316..44596c2d93 100644<br>
&gt; --- a/qemu-img.texi<br>
&gt; +++ b/qemu-img.texi<br>
&gt; @@ -763,6 +763,16 @@ file which is COW and has data blocks already, it=
 couldn&#39;t be changed to NOCOW<br>
&gt;=C2=A0 by setting @code{nocow=3Don}. One can issue @code{lsattr filenam=
e} to check if<br>
&gt;=C2=A0 the NOCOW flag is set or not (Capital &#39;C&#39; is NOCOW flag)=
.<br>
&gt;=C2=A0 <br>
&gt; +@item data_file<br>
&gt; +File name of data file that is stored in the image and used as a defa=
ult for<br>
&gt; +opening the image. If the option is used, qcow2 file only stores the =
metadata<br>
&gt; +of the image.<br>
&gt; +<br>
<br>
This is a little unclear, and seems to imply the data file is stored<br>
*IN* the image.<br>
<br>
&quot;Optional filename to be used as a data store for this qcow2 file. If<=
br>
this option is used, the qcow2 file only stores metadata for this image.&qu=
ot;<br></blockquote><div>Thanks for your advice. I will update it in v2. <b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +@item data_file_raw<br>
&gt; +This option requires @option{data_file}. If this option is set to @co=
de{on},<br>
&gt; +qemu will always keep the external data file consistent as a standalo=
ne<br>
&gt; +read-only raw image. Default value is @code{off}.<br>
&gt; +<br>
&gt;=C2=A0 @end table<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 @item Other<br>
&gt; <br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr=
">Best regards,</div><div dir=3D"ltr">-----------------------------------<b=
r></div><div dir=3D"ltr">Han Han<br>Quality Engineer<br>Redhat.<br><br>Emai=
l: <a href=3D"mailto:hhan@redhat.com" target=3D"_blank">hhan@redhat.com</a>=
<br>Phone: +861065339333<br></div></div></div></div></div></div></div>

--0000000000009191340595614940--

