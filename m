Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93CDC2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 21:12:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 874F621582
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 21:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U45X2Fby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 874F621582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in7lO-0001x9-Co
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 16:12:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1in7kc-0001De-AI
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 16:11:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1in7kY-0004mX-IK
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 16:11:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25738
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1in7kT-0004hm-TF
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 16:11:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577999477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S/0Dz23NZsNkH9ZtXW9XOGgGAJBFtD2/MzWmDDvHfz4=;
 b=U45X2Fby3938faKc2M5zgMSouCJxHVTfGT7XHqBxr0yoQcLwWtbEpUNhF54Dujk37/Q0jk
 ykzrG1A2jNS0y0958UPC4OkgDd/nTbNGy1C3hffUr3jK7IKhiQZsXsxCNLjbflA7di8ke7
 0NW4S7q/J6SGCm7RxeG1v8gKnMign9E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-DmVaQh04OCWVKjVN955xTw-1; Thu, 02 Jan 2020 16:11:12 -0500
Received: by mail-wr1-f70.google.com with SMTP id h30so13372088wrh.5
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 13:11:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jSa6P/zZIAKVc64uPwDWbr46HoPv12sfM0C3MANRI8U=;
 b=gDSJMOUXUpTmO9Pcza/9OmVANNW628pFYcgdCG54V19mmF/LpLSWIGwsWcFiX6ewPA
 nJJ6RUr0wdhFw4uZfxTEsTC7UsWKjOyuHI5ZLJvSq6/IdgkK8GYi/noK7PUb5GNBO9d/
 pvfGFEussmw1ojA25wiv2s1n+B0taK+aT/PWmUNcy3kIyA/iwtrB5thMoMZtj/zRKqqe
 +SGaVXiw9xRQzOUWlsId3VoCRxOnrwatJnnGMlstiEub2tpObJayunr07WvETaKh+Zck
 TF2kzJ0Nd6kmMhygDXcZGT73ncf10NM9C+yEaKYQ2uxxwulZKB+PteltASKR7oouk3/4
 Amaw==
X-Gm-Message-State: APjAAAXrdF5mybl18dHCho/6l8Dm6YS7hRUk+Y0rV1KIWYiGXBojME9g
 uwSrcMT4H6FNaHwzIfhTQFUSa3Fme5jfX9wC48oQguPWtSQ8/MBAsBYbQs0t1s14GYt8evm38pK
 Ruhe72KBOQh4w84g=
X-Received: by 2002:adf:a746:: with SMTP id e6mr87815150wrd.329.1577999471503; 
 Thu, 02 Jan 2020 13:11:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqx4F/o/H/UDLBa2/z4HQ4g3MQcWKA4wHy5a0dvrmKlcO6bPsv+QyNOotfgdoDuT7f2KzEk1jA==
X-Received: by 2002:adf:a746:: with SMTP id e6mr87815138wrd.329.1577999471269; 
 Thu, 02 Jan 2020 13:11:11 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id z83sm9761562wmg.2.2020.01.02.13.11.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2020 13:11:10 -0800 (PST)
Subject: Re: [PATCH v2 00/10] Add Allwinner H3 SoC and Orange Pi PC Machine
To: Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20191216233519.29030-1-nieklinnenbank@gmail.com>
 <CAPan3WpDbWb_cBMJPgokSLKAJndMQLvRdOav6CPpDbFv+ChN0g@mail.gmail.com>
 <9756419b-55bf-23a9-556a-d5bc5fb29331@redhat.com>
 <CAPan3WrYAK+PFtFM7ZDCVsKLc_ksGxZeHEcwB9_FK=4v5p8h=w@mail.gmail.com>
 <CAPan3WoP8MYubKaArOuWVCo65iOYNc2TpQ8KA0f_wRZwLATMAA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f331fe6e-87ce-4f04-cdc0-981281e53c9b@redhat.com>
Date: Thu, 2 Jan 2020 22:11:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAPan3WoP8MYubKaArOuWVCo65iOYNc2TpQ8KA0f_wRZwLATMAA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: DmVaQh04OCWVKjVN955xTw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Niek,

On 1/2/20 8:52 PM, Niek Linnenbank wrote:
> Hi Philippe,
>=20
> I'm almost ready to send out v3 here.
>=20
> Now for documentation I'm not sure yet what to do:
>=20
> 1) Where should I place board documentation?
>  =C2=A0=C2=A0=C2=A0 For example, the information that I wrote on the cove=
r letter with=20
> instructions on how to get the board up and running,
>  =C2=A0=C2=A0=C2=A0 some description of the design, where to find more in=
forformation,=20
> datasheet sources, etc. I don't yet see any documentation

We usually refer the datasheet in the implementation header, see:

$ git grep -F .pdf hw/ | wc -l
62

You can cite the datasheet globally in hw/arm/allwinner-h3.c, and then=20
the particular chapters or source files in the other hw/*/allwinner-* files=
.

>  =C2=A0=C2=A0 for the other boards in the source. In my opinion, it is im=
portant=20
> to keep that information somewhere, such that also in the future
>  =C2=A0=C2=A0 the boards can still be properly maintained. Can I / shall =
I place a=20
> new file like ./docs/hw/arm/orangepi.txt for that?

See docs/microvm.rst which is a recent example of machine documentation,
the obvious name is docs/orangepi.rst.

Maybe refer to this file in hw/arm/orangepi.c header for completeness.

>  =C2=A02) Is is allowed / encouraged to provide Doxygen-style comments in=
 the=20
> header files in include/hw/*?
>  =C2=A0=C2=A0 I see that some of the API's have that, but the boards and =
devices=20
> mostly are free of Doxygen-style comments.
>  =C2=A0=C2=A0 It takes some work, but I think it can really help to give =
more=20
> insight / background info on how things are working
>  =C2=A0=C2=A0 for the devices and boards. But if it's not preferred for Q=
EMU, I'm=20
> fine with that as well.

Documentation is certainly welcome!

There are 2 different schools over the codebase, one that document the=20
declarations, and another that documents the implementation/definition.

I personally prefer to document the headers, which is where I look when=20
I want to consume an API.
The implementation school says this can lead to documentation getting=20
outdated.

So if you are willing to document, I'd suggest to document your=20
include/hw/ files.

Happy new year!

Phil.

> On Mon, Dec 30, 2019 at 9:10 PM Niek Linnenbank=20
> <nieklinnenbank@gmail.com <mailto:nieklinnenbank@gmail.com>> wrote:
>=20
>=20
>=20
>     On Mon, Dec 30, 2019 at 3:56 PM Philippe Mathieu-Daud=C3=A9
>     <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
>=20
>         On 12/30/19 12:28 PM, Niek Linnenbank wrote:
>          > Hi,
>          >
>          > Here a short status report of this patch series.
>=20
>         Good idea!
>=20
>          >
>          > For V3 update I already prepared the following:
>          >=C2=A0 =C2=A0- reworked all review comments from Philippe, exce=
pt:
>          >=C2=A0 =C2=A0=C2=A0 - patch#8: question for the SID, whether co=
mmand-line
>         override is
>          > required (and how is the best way for machine-specific cli
>         arg?) [1]
>=20
>         Answered recently.
>=20
>     Thanks!
>=20
>=20
>          > - added BootROM support, allows booting with only specifying
>         -sd <IMG>
>          > - added SDRAM controller driver, for U-Boot SPL
>          > - added Allwinner generic RTC driver (for both Cubieboard and
>         OrangePi
>          > PC, supports sun4i, sun6i, sun7i)
>          > - small fixes for EMAC
>          >
>          > My current TODO:
>          >=C2=A0 =C2=A0- integrate Philips acceptance tests in the series
>=20
>         You can queue them in your series, adding your Signed-off-by tag
>         after
>         mine. See:
>         https://www.kernel.org/doc/html/latest/process/submitting-patches=
.html#sign-your-work-the-developer-s-certificate-of-origin
>=20
>          =C2=A0 =C2=A0The sign-off is a simple line at the end of the exp=
lanation
>         for the
>         patch, which certifies that you wrote it or otherwise have the
>         right to
>         pass it on as an open-source patch.
>=20
>         See point (c).
>=20
>     Ah that certainly helps. I'll read that page.
>=20
>          >=C2=A0 =C2=A0- integrate Philips work for generalizing the Allw=
inner
>         timer, and
>          > finish it
>=20
>         We can also do that later, and get your work merged first.
>=20
>=20
>     Ok that sounds very good! Agreed, lets do the timer work later.
>=20
>=20
>          >=C2=A0 =C2=A0- test and fix BSD targets (NetBSD, FreeBSD) [2, 3=
]
>          >=C2=A0 =C2=A0- further generalize the series to cover very simi=
lar SoCs:
>         H2+, H5
>          >
>          > Does anyone have more comments/requests for the V3 update?
>          >
>          > [1]
>         https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg04049.ht=
ml
>          > [2] https://wiki.netbsd.org/ports/evbarm/allwinner/
>          > [3]
>          >
>         https://wiki.freebsd.org/action/show/arm/Allwinner?action=3Dshow&=
redirect=3DFreeBSD%2Farm%2FAllwinner
>=20
>=20
>=20
>     --=20
>     Niek Linnenbank
>=20
>=20
>=20
> --=20
> Niek Linnenbank
>=20


