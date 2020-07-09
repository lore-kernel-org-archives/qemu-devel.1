Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7297C433E3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 17:58:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9423220775
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 17:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaeAC+bu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9423220775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtao8-00030T-Ty
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 13:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jtanH-00025R-B3; Thu, 09 Jul 2020 13:57:11 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34]:44207)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jtanF-0000yG-JT; Thu, 09 Jul 2020 13:57:11 -0400
Received: by mail-io1-xd34.google.com with SMTP id i4so3226633iov.11;
 Thu, 09 Jul 2020 10:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aR5izSzOEUPX3YFVw2MH19qHu1IzGHNevuGv3j+Fhnc=;
 b=AaeAC+buwaRMteN3AyeJWezMAiOyD31SpX7rw1nhL8zD5KmbTVCU/xydvuM+yP53pS
 U+kwfVT4uxftmyiYQsKrbr1iN4hEOAZfGES5QGsD9hGRMnS75gpVaHROXLWVKgEWD86q
 VcSgRsLmeKx7dQISHkvGfobfIrwnG6u5Uxp+SjetOCkWmk4asLBZ5O+lQT+aM3TiG+2e
 CRYSANWte/OmUTAIkg/v8S/B9FK8woMBMkve7bqOXWpmj58xMrhCB5GHgV/vJ5RUbSJQ
 jJVmjuiB/FAMApV7lK/pJZGA6hhbqWhAwqVGhor/iH+XQQwLlTNNdF3Z3W971rL5WEwO
 l/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aR5izSzOEUPX3YFVw2MH19qHu1IzGHNevuGv3j+Fhnc=;
 b=qHeL1PX2xja6EJqtJRqQEJn2r3MDupnuH5OM6U3dWSrxuV0Vs2yNAhmSGZXR6TJcqN
 AIZhynRx5a22FTQBIv6fCTrV+ABqEMhQVJI4EmNODXSEU2D2ONpqhlDC7LoGkdPOyXvB
 756kHfHRmx8WNzHQBGQOgKTVcXA37cJXIkzZvtG5G+6t2JM/F5uSktwUdO6WXG9BV57T
 ctEf8msrzK2Sn2/LcVVlNmcZny9lZIppLuXAwPRHbAsrrpDm1p1Dqug3gI6uUyvRYD1a
 OrsEYwt6sH7VjrqI5tJaRDwLcTeJp1F6eRplZwnjhr+rgU1b9hHFVZ5n/yOKndqW+xMv
 1TUQ==
X-Gm-Message-State: AOAM532o1MyxofLx0fwSJ2v9Lv/Je+csSxaCeYC+n+IBD9zuAFkh95mO
 xJ+R8ffM6juKIZiG1MmKrdtqwryJqdHLzLDUqUM=
X-Google-Smtp-Source: ABdhPJzO3vyFFr9FpY+yEO1p7vDBZ9A4nL7LbhcyovLb8FgpHWvdEiUNu8H4TF0tZ5pjaGRFSbiJ8mUqgCiTPHoVZhQ=
X-Received: by 2002:a05:6638:2195:: with SMTP id
 s21mr58184906jaj.73.1594317427926; 
 Thu, 09 Jul 2020 10:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200707132116.26207-1-f4bug@amsat.org>
 <20200707132116.26207-3-f4bug@amsat.org>
 <CAKmqyKNY+7tE9tcZm7_Th9qapo1CH0AwNwBf7vaf+7vSqBNtVA@mail.gmail.com>
 <CAFEAcA_ZXgNHMAhBVmjvstyG=PpaHOtcmo=VgvfBQ3Z9VJTk_g@mail.gmail.com>
 <3f1bf3ba-d6c3-a148-9850-076b2caa64d0@amsat.org>
 <CAPan3Wr09ZbbHWO-dhGeK3zhZQv3smrzLpUGMj71NWh0hToZDg@mail.gmail.com>
 <e87550d9-e1cc-cc15-2674-755249e9a965@amsat.org>
 <CAFEAcA8em-bgU2xd8OG+bPLDCSZCF8Y2ay9U57D8p9m1SWO=9g@mail.gmail.com>
In-Reply-To: <CAFEAcA8em-bgU2xd8OG+bPLDCSZCF8Y2ay9U57D8p9m1SWO=9g@mail.gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Thu, 9 Jul 2020 19:56:56 +0200
Message-ID: <CAPan3Wp2KBj9i3k4jVj2hQvVBQyKP42KysBj0h_0VQbRMnWBOA@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/sd/sdcard: Do not allow invalid SD card sizes
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000f36b9005aa05f318"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d34;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-io1-xd34.google.com
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
Cc: Qemu-block <qemu-block@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f36b9005aa05f318
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2020 at 4:15 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Thu, 9 Jul 2020 at 14:56, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
> wrote:
> >
> > On 7/7/20 10:29 PM, Niek Linnenbank wrote:
> > > So I manually copy & pasted the change into hw/sd/sd.c to test it.
> > > It looks like the check works, but my concern is that with this chang=
e,
> > > we will be getting this error on 'off-the-shelf' images as well.
> > > For example, the latest Raspbian image size also isn't a power of two=
:
> > >
> > > $ ./arm-softmmu/qemu-system-arm -M raspi2 -sd
> > > ~/Downloads/2020-05-27-raspios-buster-lite-armhf.img -nographic
> > > WARNING: Image format was not specified for
> > > '/home/me/Downloads/2020-05-27-raspios-buster-lite-armhf.img' and
> > > probing guessed raw.
> > >          Automatically detecting the format is dangerous for raw
> images,
> > > write operations on block 0 will be restricted.
> > >          Specify the 'raw' format explicitly to remove the
> restrictions.
> > > qemu-system-arm: Invalid SD card size: 1.73 GiB (expecting at least 2
> GiB)
> > >
> > > If we do decide that the change is needed, I would like to propose th=
at
> > > we also give the user some instructions
> > > on how to fix it, maybe some 'dd' command?
> >
> > On POSIX we can suggest to use 'truncate -s 2G' from coreutils.
> > This is not in the default Darwin packages.
> > On Windows I have no clue.
>
> dd/truncate etc won't work if the image file is not raw (eg if
> it's qcow2). The only chance you have of something that's actually
> generic would probably involve "qemu-img resize". But I'm a bit
> wary of having an error message that recommends that, because
> what if we got it wrong?
>

Yeah good point Peter, I see what you mean. As I wrote to Philippe,
i'll try to make a small patch with some instructions in the OrangePi board
documentation,
so then we'll at least have something there to help the user.

Regards,
Niek


>
> thanks
> -- PMM
>


--=20
Niek Linnenbank

--000000000000f36b9005aa05f318
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 9, 2020 at 4:15 PM Peter =
Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linar=
o.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On Thu, 9 Jul 2020 at 14:56, Philippe Mathieu-Daud=C3=A9 &lt;<a href=
=3D"mailto:f4bug@amsat.org" target=3D"_blank">f4bug@amsat.org</a>&gt; wrote=
:<br>
&gt;<br>
&gt; On 7/7/20 10:29 PM, Niek Linnenbank wrote:<br>
&gt; &gt; So I manually copy &amp; pasted the change into hw/sd/sd.c to tes=
t it.<br>
&gt; &gt; It looks like the check works, but my concern is that with this c=
hange,<br>
&gt; &gt; we will be getting this error on &#39;off-the-shelf&#39; images a=
s well.<br>
&gt; &gt; For example, the latest Raspbian image size also isn&#39;t a powe=
r of two:<br>
&gt; &gt;<br>
&gt; &gt; $ ./arm-softmmu/qemu-system-arm -M raspi2 -sd<br>
&gt; &gt; ~/Downloads/2020-05-27-raspios-buster-lite-armhf.img -nographic<b=
r>
&gt; &gt; WARNING: Image format was not specified for<br>
&gt; &gt; &#39;/home/me/Downloads/2020-05-27-raspios-buster-lite-armhf.img&=
#39; and<br>
&gt; &gt; probing guessed raw.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Automatically detecting the for=
mat is dangerous for raw images,<br>
&gt; &gt; write operations on block 0 will be restricted.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Specify the &#39;raw&#39; forma=
t explicitly to remove the restrictions.<br>
&gt; &gt; qemu-system-arm: Invalid SD card size: 1.73 GiB (expecting at lea=
st 2 GiB)<br>
&gt; &gt;<br>
&gt; &gt; If we do decide that the change is needed, I would like to propos=
e that<br>
&gt; &gt; we also give the user some instructions<br>
&gt; &gt; on how to fix it, maybe some &#39;dd&#39; command?<br>
&gt;<br>
&gt; On POSIX we can suggest to use &#39;truncate -s 2G&#39; from coreutils=
.<br>
&gt; This is not in the default Darwin packages.<br>
&gt; On Windows I have no clue.<br>
<br>
dd/truncate etc won&#39;t work if the image file is not raw (eg if<br>
it&#39;s qcow2). The only chance you have of something that&#39;s actually<=
br>
generic would probably involve &quot;qemu-img resize&quot;. But I&#39;m a b=
it<br>
wary of having an error message that recommends that, because<br>
what if we got it wrong?<br></blockquote><div><br></div><div>Yeah good poin=
t Peter, I see what you mean. As I wrote to Philippe,</div><div>i&#39;ll tr=
y to make a small patch with some instructions in the OrangePi board docume=
ntation,</div><div>so then we&#39;ll at least have something there to help =
the user.</div><div><br></div><div>Regards,</div><div>Niek<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000f36b9005aa05f318--

