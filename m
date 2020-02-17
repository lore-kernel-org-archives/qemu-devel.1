Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75102C34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:20:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4106B20578
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uyg0of9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4106B20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3k4m-0004KO-Ge
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 12:20:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36318)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3k3w-0003iA-1W
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:20:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3k3t-0006L5-Tp
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:20:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38445
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3k3t-0006KR-QC
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:20:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581960000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ADGze6GYXb2Vr8BUlwlaDIGfigoiANn1Smsx6oynb5M=;
 b=Uyg0of9q3QssrlY1thd3IwqI+gQj0a7B+LKOKBnUoZxn/9bf/eJZb4zeB4LpMmKqjstQWl
 JAGhMiLL/74hwotcviBVLUSuLbgHSDs85nYjwWpsAz/ZX87gjBtfDcMKXyVbzfaHMb8tsf
 ulevYyeL7ADzonL0S7oUC2sr/nrlFDI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-WSjqUjMxPyG5X9aPN7saiQ-1; Mon, 17 Feb 2020 12:19:59 -0500
Received: by mail-wr1-f70.google.com with SMTP id s13so9215014wru.7
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 09:19:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=F8xK03mGWJyKu6vGcn18U5tPN+ghTKaqKVdJgiAs7J0=;
 b=ezWkTiel0tbS6dKE1vyjhxm4XWHm56XbWmX4M+FaQBsnoVATWBhvngPnKqRBMYqxFC
 o2TN9L8CVIusFjqHDplhNb9gZFJhAr6ONFJbPjBTXKu5y2QrAogMjP6oEMuUBQgH6LHA
 fbQwwn7PMuAp1PpUHwRKS4beTSRBj+fkYPC04piF08Ccb+T8LYvmaOsk4Q30kX0W/qZr
 rhm9cWEbhDrMCHmt46yrFKdnK334oi4MZCsKXDPxv11Zplt2X0lrzRhivS7jdI0tjWY1
 sWcbnpW7/W5coMMIGIW6YT5q9BnW7YBNED8B0kxYFRKtg78DeXeVfaOX07ED0gYJfbQ9
 W9BA==
X-Gm-Message-State: APjAAAUxJ+OWHZ/lEyiiLqdzJL+mVW/1O1lZ/Ctsxii/dB4TS/nsLeRO
 KnxAIp8CaFD75fQTtmpr2b0mt3KfLp4CiBUL5aKxQjJdawaqgIAOtI+i8kMD+m9vXni5CACMm4f
 4965QPvdPH4bR3O4=
X-Received: by 2002:a05:600c:2301:: with SMTP id 1mr36758wmo.147.1581959997924; 
 Mon, 17 Feb 2020 09:19:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqyQmh45FvmFEwZV3rTvlECBRJxVKnVrckfqQaQ8oErUIytsOO8y4DsIw3+NqakVb6RERLxriQ==
X-Received: by 2002:a05:600c:2301:: with SMTP id 1mr36739wmo.147.1581959997715; 
 Mon, 17 Feb 2020 09:19:57 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id p26sm108936wmc.24.2020.02.17.09.19.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 09:19:57 -0800 (PST)
Subject: Re: [PATCH 1/2] hw/ipmi/bmc: Delay timer_new_ns() from init to
 realize to avoid memleaks
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200215154706.19837-1-philmd@redhat.com>
 <20200215154706.19837-2-philmd@redhat.com>
 <CAFEAcA9cZHWziyk6VzfaxrqjCNNOmnmSkB=uuGJMp0TL521mAQ@mail.gmail.com>
 <8c4570e1-cd9b-9d33-2756-5c223df282ee@redhat.com>
 <CAFEAcA-hyEVPeT1wakaft6m3_WD9XG3eYFAwJJgoHRAZ1nntag@mail.gmail.com>
 <e530629d-c029-1d7c-b5b7-cdbbeb397a4d@redhat.com>
 <CAFEAcA-KzWv=_kZUPNE6yyUSA36XY+q91ihJ_xh4euJ9RsyaLA@mail.gmail.com>
 <c2ae28d4-3864-dfc6-2033-93bbd7aa865e@redhat.com>
Message-ID: <b9f520ba-d279-6a46-1142-e82f415f3e8a@redhat.com>
Date: Mon, 17 Feb 2020 18:19:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c2ae28d4-3864-dfc6-2033-93bbd7aa865e@redhat.com>
Content-Language: en-US
X-MC-Unique: WSjqUjMxPyG5X9aPN7saiQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>,
 David Hildenbrand <david@redhat.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 6:12 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/17/20 5:32 PM, Peter Maydell wrote:
>> On Mon, 17 Feb 2020 at 16:15, Philippe Mathieu-Daud=C3=A9=20
[...]
>>> - hotpluggable devices missing unrealize()
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a15mpcore_priv
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a9mpcore_priv
>>
>> Most of these are not really hotpluggable. What is
>> confusing your test code is that sysbus devices get
>> the default 'hotpluggable =3D true' setting, but other
>> conditions usually prevent hotplugging. (The reason
>> hotpluggable is true is the default is because of
>> handling of 'dynamic sysbus' devices which live on
>> the 'platform bus'.) In particular, I think that
>> anything with !dc->user_creatable can't be hotplugged
>> unless board code specifically tries it, which would
>> be a bug for most of these devices.
[...]
>> Also, if there isn't anything for a device's unrealize
>> method to do, it doesn't need to provide one.
>=20
> This point is hard to check with simply with qtest.
>=20
> Thanks for your comments, it helped sorting few things out.

Quick check with TYPE_BITBAND which is a SysBus device, we have:

static void bitband_realize(DeviceState *dev, Error **errp)
{
     BitBandState *s =3D BITBAND(dev);

     if (!s->source_memory) {
         error_setg(errp, "source-memory property not set");
         return;
     }

     address_space_init(&s->source_as, s->source_memory, "bitband-source");
}

Do we need the equivalent:

static void bitband_unrealize(DeviceState *dev, Error **errp)
{
     BitBandState *s =3D BITBAND(dev);

     address_space_destroy(&s->source_as);
}

Or instead mark the device user_creatable=3Dfalse because of the link to a=
=20
TYPE_MEMORY_REGION?

>=20
>>
>> thanks
>> -- PMM
>>


