Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F420C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 05:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DCEB20786
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 05:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="vOkuBhhz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DCEB20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vayavyalabs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8cyw-0004iK-Br
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 01:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pratikp@vayavyalabs.com>)
 id 1k8cyO-0004HD-Mb
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 01:18:48 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:44686)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pratikp@vayavyalabs.com>)
 id 1k8cyM-0007pp-SW
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 01:18:48 -0400
Received: by mail-wr1-x431.google.com with SMTP id c15so792286wrs.11
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 22:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vayavyalabs.com; s=vayavyalabs;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=25tPtt/gVQ47Ga9gAtoJUMCZH2ldWNAc7vglM8q5qL0=;
 b=vOkuBhhzYOODKUqQmTYFWi4F3IFfm+7S5x09HbpDnf0YMF6mMyEr+/wETZlZy9I5Rz
 cLJPosmNeaZUgyJEV0zmakNEwQuDIC8A63ZllZ/szbplpVS9FIT4n3w9XVDfk67ZuTga
 0qxrgmM9IxVL5MCz6mFFTbJLIap78k1IBdDNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=25tPtt/gVQ47Ga9gAtoJUMCZH2ldWNAc7vglM8q5qL0=;
 b=LpdF4wiaWFrvgQd5kWxAHoqE5c9Ft9bp8J1ZTzXn4ApVbsCCiDKbc0PP3w3qa1jWF2
 nN4MF8agYvB97wnzx+b6KqMC6AR5HtjEOkER+uSL43nVFGy6RzMVsgvj10kWpXSBpec0
 j5OoVFBgqZ+NdAkM7vg2jJ8r8UDjHdnoHRJjyIyXO56r/iaoLGK/WoeUnyUHttDRc7Yf
 U2kxvSvfnl8mfSWW3RXQA9jhTHqwro8wYK6mgCedMMLFQO/A3a8WCU/Njped0OZfhaGx
 EQX2U+h6vE1Skjxj4TPXeFZSqZxOyhmNv3lYBhLmGZp1cKrfk1FG0DCTrVVqSddUW0dU
 JJBA==
X-Gm-Message-State: AOAM533AWD+7/H3CmitIt8C4qWbpAE7qSqnuwpwG2VkxUeok1r6LPcjk
 VTv4epXb2pO08g1s+snvy819oSfsL/VLWiltz//N6A==
X-Google-Smtp-Source: ABdhPJxlbkDUDRmYB49fU1nNm6YDk0Bib2TxczKX/n///BE/8kgEF89BcKRUrP3l3o2HsEy0zIuXwGxaiNZMK8WT0As=
X-Received: by 2002:a5d:4802:: with SMTP id l2mr1260360wrq.183.1597900724561; 
 Wed, 19 Aug 2020 22:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <CA+aXn+GrFDssmZWBCL0gh3QLX5BMhmgTQUywLSSQn=cpF2P1ZQ@mail.gmail.com>
 <87r1se3k7m.fsf@linaro.org>
In-Reply-To: <87r1se3k7m.fsf@linaro.org>
From: Pratik Parvati <pratikp@vayavyalabs.com>
Date: Thu, 20 Aug 2020 10:48:32 +0530
Message-ID: <CA+aXn+FMW=wo93_aQ1waPSAhdgeD8_gxCB0ti1x20JT3G-6ysw@mail.gmail.com>
Subject: Re: QEMU Library support
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000001303b005ad4841b4"
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=pratikp@vayavyalabs.com; helo=mail-wr1-x431.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001303b005ad4841b4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>> Hi team,
>>
>> Lately, I have been working on QEMU modeling and interfacing it into the
>> existing platform. What actually I wanted to check is; whether QEMU
>> supports library that gives developers a clean interface to develop and
>> integrate peripheral model in to QEMU. I know of the Greensocs SystemC
>> bridge - but that was quite difficult to work with in past.

> Not really - with a few exceptions like vhost-user and in KVM device
> emulation all devices are emulated in the QEMU code base. As a result
> the best way to maintain a device is to have it integrated upstream
> (along with some tests to ensure it is working).

> As you note there are various forks of QEMU that support device
> modelling but none of these features have been merged upstream and would
> likely need to assuage worries about such interfaces being used to avoid
> GPL compliance.

> What sort of devices are you looking to model? Are these existing
> devices or experimental/research things?

Alex, to answer your earlier question, this is only for experimental
purposes -
to learn Qemu device modeling API better. I am trying to understand QEMU
build hierarchy and proceed to see whether I can find any solution out of
it.

Also - wanted to set right one point. The Greensocs SystemC bridge is
definitely an option if one wants to integrate device models in SystemC -
but in my case, I wanted to better understand Qemu internals.

Regards,
Pratik


On Mon, Aug 10, 2020 at 3:18 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> Pratik Parvati <pratikp@vayavyalabs.com> writes:
>
> > Hi team,
> >
> > Lately, I have been working on QEMU modeling and interfacing it into th=
e
> > existing platform. What actually I wanted to check is; whether QEMU
> > supports library that gives developers a clean interface to develop and
> > integrate peripheral model in to QEMU. I know of the Greensocs SystemC
> > bridge - but that was quite difficult to work with in past.
>
> Not really - with a few exceptions like vhost-user and in KVM device
> emulation all devices are emulated in the QEMU code base. As a result
> the best way to maintain a device is to have it integrated upstream
> (along with some tests to ensure it is working).
>
> As you note there are various forks of QEMU that support device
> modelling but none of these features have been merged upstream and would
> likely need to assuage worries about such interfaces being used to avoid
> GPL compliance.
>
> What sort of devices are you looking to model? Are these existing
> devices or experimental/research things?
>
> --
> Alex Benn=C3=A9e
>

--0000000000001303b005ad4841b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span class=3D"gmail-im" style=3D"color:rgb(80,0,80)">&gt;=
&gt; Hi team,<br>&gt;&gt;<br>&gt;&gt; Lately, I have been working on QEMU m=
odeling and interfacing it into the<br>&gt;&gt; existing platform. What act=
ually I wanted to check is; whether QEMU<br>&gt;&gt; supports library that =
gives developers a clean interface to develop and<br>&gt;&gt; integrate per=
ipheral model in to QEMU. I know of the Greensocs SystemC<br>&gt;&gt; bridg=
e - but that was quite difficult to work with in past.<br><br></span>&gt; N=
ot really - with a few exceptions like vhost-user and in KVM device<br>&gt;=
 emulation all devices are emulated in the QEMU code base. As a result<br>&=
gt;=C2=A0the best way to maintain a device is to have it integrated upstrea=
m<br>&gt; (along with some tests to ensure it is working).<br><br>&gt; As y=
ou note there are various forks of QEMU that support device<br>&gt; modelli=
ng but none of these features have been merged upstream and would<br>&gt; l=
ikely need to assuage worries about such interfaces being used to avoid<br>=
&gt; GPL compliance.<br><br>&gt; What sort of devices are you looking to mo=
del? Are these existing<br>&gt; devices or experimental/research things?<di=
v><br></div><div>Alex, to answer your earlier question, this is only for ex=
perimental purposes -=C2=A0</div><div>to learn Qemu device modeling API bet=
ter. I am trying to understand QEMU</div><div>build hierarchy and proceed t=
o see whether I can find any solution out of it.<br><br>Also - wanted to se=
t right one point. The Greensocs SystemC bridge is=C2=A0</div><div>definite=
ly an option if one wants to integrate device models in SystemC -=C2=A0</di=
v><div>but in my case, I wanted to better understand Qemu internals.</div><=
div><br clear=3D"all"><div><div dir=3D"ltr" class=3D"gmail_signature" data-=
smartmail=3D"gmail_signature"><div dir=3D"ltr">Regards,<div>Pratik</div></d=
iv></div></div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Mon, Aug 10, 2020 at 3:18 PM Alex Benn=C3=A9e &=
lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
Pratik Parvati &lt;<a href=3D"mailto:pratikp@vayavyalabs.com" target=3D"_bl=
ank">pratikp@vayavyalabs.com</a>&gt; writes:<br>
<br>
&gt; Hi team,<br>
&gt;<br>
&gt; Lately, I have been working on QEMU modeling and interfacing it into t=
he<br>
&gt; existing platform. What actually I wanted to check is; whether QEMU<br=
>
&gt; supports library that gives developers a clean interface to develop an=
d<br>
&gt; integrate peripheral model in to QEMU. I know of the Greensocs SystemC=
<br>
&gt; bridge - but that was quite difficult to work with in past.<br>
<br>
Not really - with a few exceptions like vhost-user and in KVM device<br>
emulation all devices are emulated in the QEMU code base. As a result<br>
the best way to maintain a device is to have it integrated upstream<br>
(along with some tests to ensure it is working).<br>
<br>
As you note there are various forks of QEMU that support device<br>
modelling but none of these features have been merged upstream and would<br=
>
likely need to assuage worries about such interfaces being used to avoid<br=
>
GPL compliance.<br>
<br>
What sort of devices are you looking to model? Are these existing<br>
devices or experimental/research things?<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
</blockquote></div>

--0000000000001303b005ad4841b4--

