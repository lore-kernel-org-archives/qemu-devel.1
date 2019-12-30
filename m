Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CDCC2D0C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 10:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF18E206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 10:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RE2Tvwwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF18E206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilsNc-0008EP-Vi
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 05:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ilsMm-0007X0-O2
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 05:33:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ilsMk-0002Cl-U1
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 05:33:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43455
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ilsMk-0002C9-Qg
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 05:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577702018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=osz1+gLyr114GefbdMEHHWsIMT6EPaU/DWBMxBOMOeQ=;
 b=RE2TvwwdhpBUua6EMr2t/AOYMF1f9rTYGZdEyyDDY3mBTk4uhkGqqOHLwiaRyLBC/juJLY
 3osUysJ9ujtRE3Lwr052ewS/2Pu6Z1JaClKGz2kz6x52qzeiDFX0SQi4oMZjwW4MGm38mq
 q5t0rvS4Ts8myTmf1riVDWDkQDrvA5I=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-q1Bn7L6lMSe6VT9Gb44AfA-1; Mon, 30 Dec 2019 05:33:34 -0500
Received: by mail-ed1-f70.google.com with SMTP id cy24so18427102edb.12
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2019 02:33:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=osz1+gLyr114GefbdMEHHWsIMT6EPaU/DWBMxBOMOeQ=;
 b=CqUZsaGk5RO4UvqDZMflJmkufmEIvF36oNddAsxibEWzssPrm0tFzxxeupzp2no2NG
 a63cV77IWDl1LpmokcnI4eVHtkTOBaGxXo3KyT/5Mdz479AUl8GwWbtQcI4mlfUuF1E8
 ykQLbDc3/HttpoabHjmXgK/MD8CRuqRdYqujjmoMJwgnPrYWptlcLhbg1UIr9WNuNzG9
 UrUTmqMRe1S0TsNc2BgolwgIeoSfEEwRmQ1AopK4n/0DAnr2FJ6Eqqwy51ZsJqTddlzz
 sok2su99pLGOskFnMk78GOjASGPNdtNFnRToAIdNfGWYPZR8c3OgDtmmoKcKqVOzrAvU
 wfDQ==
X-Gm-Message-State: APjAAAUyLU3xKgatu7CAqMNCj3X2PHTlVd6w8k0pb9/Ze2+BVaavc7FK
 ZW8b28PuqOpXcgy+Q7udLoN7V5hzEuCbCm+E+UpwTSFFw/GdLz5sg7bOhgPoP60humYAmJ2Oxgy
 /c/8wfb/padPvIexjUbonrd94Izs+4eQ=
X-Received: by 2002:a17:906:7fd0:: with SMTP id
 r16mr67457058ejs.319.1577702013540; 
 Mon, 30 Dec 2019 02:33:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqw1w2ArI0LpE0GqHdw+xKfIcqSZqxPDmQ0Rqbq3Ub7H8CXU01ZbI2JJ/85FUZ9NjgX/OwTJ+TiYi3EVqCnrUxc=
X-Received: by 2002:a17:906:7fd0:: with SMTP id
 r16mr67457016ejs.319.1577702013308; 
 Mon, 30 Dec 2019 02:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20191230090900.446-1-philmd@redhat.com>
 <20191230090900.446-2-philmd@redhat.com>
 <273bf2e5-1223-3d01-f930-394195c037e4@weilnetz.de>
 <64c2434d-3b2b-1a3e-5358-e4b5acfbe8e8@redhat.com>
In-Reply-To: <64c2434d-3b2b-1a3e-5358-e4b5acfbe8e8@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 30 Dec 2019 10:33:21 +0000
Message-ID: <CABgObfYahQbbteCAsMfKAYjPLDUpGJExO9mWyRw15mm=VWHsbQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] tcg: Search includes from the project root source
 directory
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-MC-Unique: q1Bn7L6lMSe6VT9Gb44AfA-1
X-Mimecast-Spam-Score: 0
Content-Type: multipart/alternative; boundary="00000000000010b1de059ae96084"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Markus Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>,
 Richard Henderson <rth@twiddle.net>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Claudio Fontana <claudio.fontana@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000010b1de059ae96084
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 30 dic 2019, 09:59 Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> h=
a
scritto:

> > I'd prefer not changing those files.
>
> OK, I'll wait to see what Richard/Markus prefer.
>

I think it's best if you keep the include directives as-is for files only
needed from tcg/, and move the other headers (those that are needed from
other directories only) to include/tcg.

Thanks and happy new year!

Paolo

>
> > Regards and best wished for 2020
>
> Thanks ;)
>
>

--00000000000010b1de059ae96084
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 30 dic 2019, 09:59 Philippe Mathieu-Daud=C3=A9 =
&lt;<a href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; ha scrit=
to:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">&gt; I&#39;d prefer not changin=
g those files.<br>
<br>
OK, I&#39;ll wait to see what Richard/Markus prefer.<br></blockquote></div>=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">I think it&#39;s best i=
f you keep the include directives as-is for files only needed from tcg/, an=
d move the other headers (those that are needed from other directories only=
) to include/tcg.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks=
 and happy new year!</div><div dir=3D"auto"><br></div><div dir=3D"auto">Pao=
lo</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">
<br>
&gt; Regards and best wished for 2020<br>
<br>
Thanks ;)<br>
<br>
</blockquote></div></div></div>

--00000000000010b1de059ae96084--


