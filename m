Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD28C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 21:52:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B592521D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 21:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUdNcz1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B592521D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Ame-0006FM-Uv
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 16:52:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j4All-0005jh-Hp
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 16:51:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j4Alk-0006hH-Bo
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 16:51:05 -0500
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29]:44342)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1j4Alk-0006fx-6d; Tue, 18 Feb 2020 16:51:04 -0500
Received: by mail-io1-xd29.google.com with SMTP id z16so24034641iod.11;
 Tue, 18 Feb 2020 13:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sLeGUH5OxTikEsToDHR4WZF1TwQ6mWFhg6WtSprZEOs=;
 b=FUdNcz1U74pIM+a9s1p824eVm6jdT9t6q4mq5BThIcD8lCN3rW+bh+j4t3UOcaYD1n
 O6j9mkqV6nOfAufWEFrHl7Ba6HmA3dDGGM8y/FvKOngC0/9TvpivssKyY2T0Q2ASBSW/
 3z/oFkLeSzoE6pE0VedOakQ9TOPcd+xHpH2eUg+1wCjaelQDLVUkq21Bs+uyH0s/7o7m
 FBmNHGrQF3h+Lz8I4GWaPhLSxYlMsLwReqPQsgcD0rzbYUjPREAsSs5+SurLTx6RUzN4
 Smpr4/x0WYmObFhoIdJP7MG+cmvi/6JJTM5j5IdCdzr49zaj7UDb9/IbwE6UKPHMSYZd
 P21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sLeGUH5OxTikEsToDHR4WZF1TwQ6mWFhg6WtSprZEOs=;
 b=OE2gH7e9tgGgGqjgzeuzJr9C+ILpDSxorkMybqJsdyZYqykFktNdVzyRx+VZ8HuIbk
 RxNRgbC8owely0ODbFjdx2oDY23/8POqWeqS0gxzAYkRdJ6k9l1jJHNTxLCTsRCd28XN
 CYhGDWcwPGuydpobIhfj3sHPs5jhwr7ZGmDdbVBpu0aZaJrbn/f3kr2aH5TFo6ampMwe
 Gsdq0Etj+1UNxEGYK1clSzbKMmqsxnU5VnS4rUp986s3PXZUNhU/7nGvQT+9kwu3QFw3
 l+L2o0BbTfiloK0zyG5QGmeEHW6XF9YOXSQYHlsiRDb/1oYqhE7JeuXEVEBy+92jO9hb
 UXfg==
X-Gm-Message-State: APjAAAU1zmduYogCRPGe44FIQ6KcEfkdQqusEiTjI04LWhmXrU7J8Tug
 cj5E0U7q7atKDD7RFa9Jb9lzSjAVC+rz9hca2Ck=
X-Google-Smtp-Source: APXvYqx2A7Vp1eDnko0Yog2I4SnljG7i2qroy00gwc0P+43U2XutOdHCAKQMpxwGFU2Cd5Cv50FC14LTqFq7gt94IV4=
X-Received: by 2002:a5d:8856:: with SMTP id t22mr16716548ios.217.1582062663091; 
 Tue, 18 Feb 2020 13:51:03 -0800 (PST)
MIME-Version: 1.0
References: <20200119005102.3847-1-nieklinnenbank@gmail.com>
 <CAPan3WpV2m9HXLXZDopKUb2EfX2KE9y530m2pJG4-D96==ggCg@mail.gmail.com>
 <ee95179f-c15f-9615-e241-80199e6948b7@redhat.com>
 <CAPan3WpG0yPu5sbS=mpHk=xNVGaqwWFrBcDBcovLLRit==5dwg@mail.gmail.com>
 <3aa04b23-80a8-21d1-7481-d52b6d8f88c1@redhat.com>
 <CAFEAcA-kNNWgLc8NxWgVJQk29BVr28j-A_d4M+8=7nfpTzhzcQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-kNNWgLc8NxWgVJQk29BVr28j-A_d4M+8=7nfpTzhzcQ@mail.gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Tue, 18 Feb 2020 22:50:52 +0100
Message-ID: <CAPan3WpkFtEe-9TuaCNhW=Dz3VZHE=8qUVhJbhW9BrdiyoMkRQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/20] Add Allwinner H3 SoC and Orange Pi PC Machine
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000000bcb51059ee0ab20"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d29
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000bcb51059ee0ab20
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter & Philippe,

On Tue, Feb 18, 2020 at 11:05 AM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Tue, 18 Feb 2020 at 06:46, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
> wrote:
> > IIRC from the specs, cards are block devices and the only alignment
> > required is the size of a block (512KiB for your 4GiB card).
>
> Isn't there something related to erase blocks too, which impose
> a larger granularity than just a single block?
>
> Anyway, in general the backing image for an SD card device
> needs to be exactly the size of the SD card you're emulating,
> because QEMU needs somewhere it can write back the data
> if the guest decides to write to the last block on the card.
> So short-length images generally don't work (true for all
> block devices, not just SD cards, I think). This often bites users
> if they're using some distro "here's a disk/sd card image file"
> where the expected use with real hardware is "dd the image
> file onto the SD card".
>

Yes, the description you gave here is indeed the issue.
And unfortunately in this particular case, the distro did not give a very
understandable
diagnostic error message.

Kind regards,
Niek


>
> thanks
> -- PMM
>


--=20
Niek Linnenbank

--0000000000000bcb51059ee0ab20
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Peter &amp; Philippe,<br></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 18, 2020 at 1=
1:05 AM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter=
.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On Tue, 18 Feb 2020 at 06:46, Philippe Mathieu-Daud=C3=
=A9 &lt;<a href=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redha=
t.com</a>&gt; wrote:<br>
&gt; IIRC from the specs, cards are block devices and the only alignment<br=
>
&gt; required is the size of a block (512KiB for your 4GiB card).<br>
<br>
Isn&#39;t there something related to erase blocks too, which impose<br>
a larger granularity than just a single block?<br>
<br>
Anyway, in general the backing image for an SD card device<br>
needs to be exactly the size of the SD card you&#39;re emulating,<br>
because QEMU needs somewhere it can write back the data<br>
if the guest decides to write to the last block on the card.<br>
So short-length images generally don&#39;t work (true for all<br>
block devices, not just SD cards, I think). This often bites users<br>
if they&#39;re using some distro &quot;here&#39;s a disk/sd card image file=
&quot;<br>
where the expected use with real hardware is &quot;dd the image<br>
file onto the SD card&quot;.<br></blockquote><div><br></div><div>Yes, the d=
escription you gave here is indeed the issue.</div><div>And unfortunately i=
n this particular case, the distro did not give a very understandable</div>=
<div>diagnostic error message.</div><div><br></div><div>Kind regards,</div>=
<div>Niek<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
thanks<br>
-- PMM<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--0000000000000bcb51059ee0ab20--

