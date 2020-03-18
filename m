Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A800C10F29
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 19:49:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE94420754
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 19:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uzr0X4Wt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE94420754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEehL-000549-33
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 15:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mansourweb@gmail.com>) id 1jEege-0004ey-JE
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 15:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mansourweb@gmail.com>) id 1jEegd-0004t5-Ag
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 15:49:08 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f]:35968)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mansourweb@gmail.com>)
 id 1jEegd-0004gd-1q; Wed, 18 Mar 2020 15:49:07 -0400
Received: by mail-lf1-x12f.google.com with SMTP id s1so21443183lfd.3;
 Wed, 18 Mar 2020 12:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Wu1Tqlp/vrYpkdSh+0C+5PUz+gJp4nipILXZnHhEuTU=;
 b=Uzr0X4Wt14IIY96IcajP5bBydxHCOAylLsT8MFBG+AlF6jDdTJMTai9m7fOgadLcGU
 TSmjzeErrrmxnrylPgM04+BUai6mi8uPUyJ9ZwIVjkhs7+7WzR2JMar1kV5HMcUIUu1X
 o+ssWTGhRNcl5ybdH9WMdYnRbUGiYr3T3hXtEp5bSpP0Lqr3casP4XM+t+vtYn4n3QeN
 U2dHkEwVovWRMW0+PXs7aycwtiCHuZmjZ6tqWvi5lgt49MJuA3zU6M7GfncDoXR/sPHQ
 NsE430K9YTdM/tK2EPt2JnePxcVHn8Prrqt1f/YETLfJH744y2FuisASLXzRvgWuVOXH
 zb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Wu1Tqlp/vrYpkdSh+0C+5PUz+gJp4nipILXZnHhEuTU=;
 b=nmC/X/h/Dc0oz8nk29BWKUBXIDnwyfGwzNCyDESxbgWLtXYcCbrXued7gwS6F3c9g9
 2Uqvl8Dccn4AbR0I1sl7wkFirojuq10lmqPEAUuqSNXQDtZGB0NpKbUcLVJRkuNzQRDJ
 pQWgbepVinaH3EkdMXUbFahC9E0NMSe7OQNgW35h8HxnGK4yYLRfiGinqbtQWRao9Vzz
 s4R3emfwK1wieY4sHhvlGruEAuizg87mlax9Jl97X870P5D+rxneBN4GeQhzrthqbckD
 qxQVbgqwWXn28OaqMo5mPAl5tmw0Js/CMsU03jFXZbTj+pIVVlA2GEpYnonHg86xd1iB
 c1Xw==
X-Gm-Message-State: ANhLgQ3W+xJzLtGhEFB95z/s/LFZCoNWXjnyTJ3qrks9mU/TJHD/F9Yz
 kMPhcqz4nVjgt4joj6moxzofr59dTAraDl2xaqZnWJ9V
X-Google-Smtp-Source: ADFU+vug6PXICVYauLtCuayUF6LLdrfqwyj6TIDDCxzoNzzNgSeZz3cKzVPCD5bELk7kPGV/KcgHC+ZnkI9Pb5lLq9I=
X-Received: by 2002:a19:fc12:: with SMTP id a18mr3908696lfi.117.1584560945461; 
 Wed, 18 Mar 2020 12:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAGT9xrB039Q7_fG1NpKv7w3t1N0OH93U9HPNawtpq9TsNr5hfA@mail.gmail.com>
 <2c4e58b3-fb9c-c172-1b2e-5a1e25d02c6d@redhat.com>
In-Reply-To: <2c4e58b3-fb9c-c172-1b2e-5a1e25d02c6d@redhat.com>
From: Mansour Ahmadi <ManSoSec@gmail.com>
Date: Wed, 18 Mar 2020 15:48:54 -0400
Message-ID: <CAGT9xrBvLyQACy0rUU4DdnJ84xVjxjtmRN9Yu8XttDrJ56KzUw@mail.gmail.com>
Subject: Re: Missing Null check
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000477d9b05a12658c1"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::12f
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
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000477d9b05a12658c1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the fix!

Best,
Mansour


On Wed, Mar 18, 2020 at 4:14 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 3/17/20 9:40 PM, Mansour Ahmadi wrote:
> > Is a NULL check on 'drv1->format_name' missing here?
> >
> https://github.com/qemu/qemu/blob/cc818a2148c5f321bdeb8e5564bdb2914e82460=
0/block.c#L400-L403
> >
> > if(!strcmp(drv1->format_name, format_name)) {
>
> This could be NULL indeed. I'd rather assertions in the entry function,
> bdrv_register():
>
> -- >8 --
> diff --git a/block.c b/block.c
> index a2542c977b..6b984dc883 100644
> --- a/block.c
> +++ b/block.c
> @@ -363,6 +363,7 @@ char
> *bdrv_get_full_backing_filename(BlockDriverState *bs, Error **errp)
>
>   void bdrv_register(BlockDriver *bdrv)
>   {
> +    assert(bdrv->format_name);
>       QLIST_INSERT_HEAD(&bdrv_drivers, bdrv, list);
>   }
>
> ---
>
> > While it is checked in similar case:
> >
> https://github.com/qemu/qemu/blob/cc818a2148c5f321bdeb8e5564bdb2914e82460=
0/block.c#L797-L800
> >
> > if(drv1->protocol_name&& !strcmp(drv1->protocol_name, protocol)) {
>
> Because 'protocol_name' is optional.
>
> Regards,
>
> Phil.
>
>

--000000000000477d9b05a12658c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:garamond=
,serif;font-size:large">Thanks for the fix!</div><div class=3D"gmail_defaul=
t" style=3D"font-family:garamond,serif;font-size:large"><br></div><div clas=
s=3D"gmail_default" style=3D"font-family:garamond,serif;font-size:large">Be=
st,</div><div class=3D"gmail_default" style=3D"font-family:garamond,serif;f=
ont-size:large">Mansour</div><br></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 18, 2020 at 4:14 AM Philippe M=
athieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com" target=3D"_blank=
">philmd@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On 3/17/20 9:40 PM, Mansour Ahmadi wrote:<br>
&gt; Is a NULL check on &#39;drv1-&gt;format_name&#39; missing here?<br>
&gt; <a href=3D"https://github.com/qemu/qemu/blob/cc818a2148c5f321bdeb8e556=
4bdb2914e824600/block.c#L400-L403" rel=3D"noreferrer" target=3D"_blank">htt=
ps://github.com/qemu/qemu/blob/cc818a2148c5f321bdeb8e5564bdb2914e824600/blo=
ck.c#L400-L403</a><br>
&gt; <br>
&gt; if(!strcmp(drv1-&gt;format_name, format_name)) {<br>
<br>
This could be NULL indeed. I&#39;d rather assertions in the entry function,=
 <br>
bdrv_register():<br>
<br>
-- &gt;8 --<br>
diff --git a/block.c b/block.c<br>
index a2542c977b..6b984dc883 100644<br>
--- a/block.c<br>
+++ b/block.c<br>
@@ -363,6 +363,7 @@ char <br>
*bdrv_get_full_backing_filename(BlockDriverState *bs, Error **errp)<br>
<br>
=C2=A0 void bdrv_register(BlockDriver *bdrv)<br>
=C2=A0 {<br>
+=C2=A0 =C2=A0 assert(bdrv-&gt;format_name);<br>
=C2=A0 =C2=A0 =C2=A0 QLIST_INSERT_HEAD(&amp;bdrv_drivers, bdrv, list);<br>
=C2=A0 }<br>
<br>
---<br>
<br>
&gt; While it is checked in similar case:<br>
&gt; <a href=3D"https://github.com/qemu/qemu/blob/cc818a2148c5f321bdeb8e556=
4bdb2914e824600/block.c#L797-L800" rel=3D"noreferrer" target=3D"_blank">htt=
ps://github.com/qemu/qemu/blob/cc818a2148c5f321bdeb8e5564bdb2914e824600/blo=
ck.c#L797-L800</a><br>
&gt; <br>
&gt; if(drv1-&gt;protocol_name&amp;&amp; !strcmp(drv1-&gt;protocol_name, pr=
otocol)) {<br>
<br>
Because &#39;protocol_name&#39; is optional.<br>
<br>
Regards,<br>
<br>
Phil.<br>
<br>
</blockquote></div>

--000000000000477d9b05a12658c1--

