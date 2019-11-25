Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94007C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 23:16:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D42320659
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 23:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BlfQLmcU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D42320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZNaN-0001G5-Br
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 18:16:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZNYS-00087w-9n
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 18:14:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZNJo-0005pa-Pj
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 17:58:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51500
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZNJo-0005p7-M3
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 17:58:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574722735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0UKnSsYStnsFscai7T5yUT6EQXCsmR9aRmU8AE3GsBA=;
 b=BlfQLmcUZgOe7fE5TelGObaHdT6H3UCoKepkrh9fF7KrLTgrgCEOMajIEtt/aoIzL/+ONo
 C0XSg6fTrMRG78DJIYX7/xXgq80DRdxeNrk9QJpApR94YmLLCLB5G9xLZe14qocD4ptqIE
 2/cizNFDlaXbCWSfSfwwIaOm0Vi1AMo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-HmUROV1BNU2xm6utGUfq0g-1; Mon, 25 Nov 2019 17:58:52 -0500
Received: by mail-wr1-f70.google.com with SMTP id d8so5629191wrq.12
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 14:58:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NpXhVvMGh0MKJHmPhQtvc16wZPx18TO9OgQ/Cw3ghic=;
 b=gJpkwatoCcDN3Pz+1RH3EgUyT/98zIf6R8LeUQojZGBFR5iu4XSDUOnL18M6TXpVXM
 bf0XnP7eLtSpiPcBlJBVHKawOO2TEDw++i5kIbPKJao2xBYGNq2z+ufWX0mPCKkGrSfP
 rkNiuX4s36R1ZdBK2vsqUdGm1MuaHfkRCuTIOAWz1mh2tVAOoZhIa1IaFgTTN7N+RnV9
 nrad5RCnu4eJh+ysb7wyYw+NE4E48x1SCl0S6Zvg05zUCboBmZ9ujCSneO16lrUZA3o2
 R0A6oYznOXjQ5q111sz79TZW9XPoeof9cAlli1WmydW9VTcjTshuJsJnzwfCyprdmvJV
 Az7Q==
X-Gm-Message-State: APjAAAU9apGANfiX9OOG3fuGnYacy+0/XEUW4Nai2a86F+UqGQVCo7oP
 vAAg/NDYz/3U6uGzdT5qg7theX65MrPXaeOF3cGQQkLYw0EDJU2sOg50Xm2gi175UGWY2MWLopN
 twL9qjXGdVIEZx0M=
X-Received: by 2002:adf:9f43:: with SMTP id f3mr34108763wrg.76.1574722731596; 
 Mon, 25 Nov 2019 14:58:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqydJhRGuhL+XmGR0w7ajKA26c8Sr/c/5HiskZknAlJf6ck2pMmDODmiaRgQLJ+58RsfUT8xbA==
X-Received: by 2002:adf:9f43:: with SMTP id f3mr34108753wrg.76.1574722731345; 
 Mon, 25 Nov 2019 14:58:51 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id w12sm892941wmi.17.2019.11.25.14.58.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2019 14:58:50 -0800 (PST)
Subject: Re: [EXTERNAL]Re: [PATCH v2 2/5] MAINTAINERS: Adjust maintainership
 for Fulong 2E board
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: chen huacai <zltjiangshi@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
References: <1573652826-23987-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1573652826-23987-3-git-send-email-aleksandar.markovic@rt-rk.com>
 <c053c16c-c6f4-4f73-7383-7b66e54ad696@redhat.com>
 <BN6PR2201MB12512B977314BCFCA202449DC6710@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <CABDp7VoVpZsQpDc7U4uJ1B7ZVCc8A2KO5qNaOucHQH6xUdX8tQ@mail.gmail.com>
 <4a94a570-301b-e2db-6090-929e63f907cd@redhat.com>
Message-ID: <c6779bb7-7353-7c4a-e458-b0d60ca662de@redhat.com>
Date: Mon, 25 Nov 2019 23:58:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <4a94a570-301b-e2db-6090-929e63f907cd@redhat.com>
Content-Language: en-US
X-MC-Unique: HmUROV1BNU2xm6utGUfq0g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "hpoussin@reactos.org" <hpoussin@reactos.org>, Huacai Chen <chenhc@lemote.com>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Zoltan,

On 11/14/19 2:50 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 11/14/19 2:08 PM, chen huacai wrote:
>> Hi, all,
>>
>> On Thu, Nov 14, 2019 at 8:34 PM Aleksandar Markovic
>> <amarkovic@wavecomp.com> wrote:
>>>
>>> Hi, Philippe,
>>>
>>>> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>>
>>>> Hi Aleksandar,
>>>>
>>>> On 11/13/19 2:47 PM, Aleksandar Markovic wrote:
>>>>> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>>>>>
>>>>> Change the maintainership for Fulong 2E board to improve its quality.
>>>>
>>>> IIRC you told me once this board is named Fuloong, and its CPU is a
>>> =E2=80=8E> Loongson, both with 2x 'o' :) I have a patch renaming the va=
rious
>>>> occurrences.
>>>>
>>>
>>> I still think that the oficial name is "Fuloong 2E", however, it is
>>> shortened to "Fulong 2E" quite often in communication, and, it seems,
>>> sometimes even in various docs/app notes etc.
>>>
>>> Can perhaps Huacai Chen enlighten us regarding the right spelling?
>> The right spelling is Fuloong.
>>
> [...]>>> The original author is active on the Linux kernel, let ask him=
=20
> if he'd
>>>> be OK to keep an eye on his work.
>>>>
>>>> Huacai, would you agree to be listed as a reviewer on the Fuloong
>>>> related QEMU files? You don't have to worry about the generic QEMU cod=
e
>>>> plate (like keeping API up to date) I'll manage that, but I'd like to
>>>> have you listed to assert the hardware is properly modeled.
>>>>
>>>> You would appear as:
>>>> R: Huacai Chen <chenhc@lemote.com>
>>>>
>>>
>>> That is a great idea!
>>>
>>> Please, Chen, get involved, you would be very welcomed, there is a plac=
e
>>> for you in QEMU community!
>> I'm sorry that I'm busy now, but I think I will do something in QEMU
>> in the next year.
>=20
> No problem, we'll keep in touch.
>=20
>>>>> +R: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>>>>
>>>> I don't think Herv=C3=A9 is interested by this board, he has not modif=
ied=20
>>>> the
>>>> code.
>>>>
>>>>> +R: Aleksandar Markovic <amarkovic@wavecomp.com>
>>>>> +S: Maintained
>>>>
>>>> Let keep it as "Odd Fixes" :)
>>>>
>>>
>>> OK.
>>>
>>>> =C2=A0=C2=A0=C2=A0 Odd Fixes:=C2=A0=C2=A0 It has a maintainer but they=
 don't have
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 time to do much other than throw the odd
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 patch in.
>>>>
>>>>> =C2=A0=C2=A0 F: hw/mips/mips_fulong2e.c
>>>>> =C2=A0=C2=A0 F: hw/isa/vt82c686.c
>>>>> =C2=A0=C2=A0 F: hw/pci-host/bonito.c
>>>>>
>>>>
>>>> So the patch would be:
>>>>
>>>> -- 8< --
>>>> =C2=A0=C2=A0 Fulong 2E
>>>> -M: Aleksandar Markovic <amarkovic@wavecomp.com>
>>>> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>>>> +M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>> +R: Aleksandar Markovic <amarkovic@wavecomp.com>
>>>> +R: Huacai Chen <chenhc@lemote.com>
>>>> =C2=A0=C2=A0 S: Odd Fixes
>>>> =C2=A0=C2=A0 F: hw/mips/mips_fulong2e.c
>>>> =C2=A0=C2=A0 F: hw/isa/vt82c686.c
>>>
>>> Plus possible s/Fulong 2E/Fuloong 2E/
>=20
> I'd prefer to keep this change for later, with the patch cleaning its=20
> use in the codebase (not that trivial because we need to alias the=20
> machine name to keep backward compatibility).
>=20
>>>
>>>> ---
>>>>
>>>> But let's wait to see what Huacai Chen thinks of it, before posting it=
.
>=20
> Aleksandar, can you stay as co-maintainer?
>=20
> The patch would be:
>=20
> -- 8< --
>  =C2=A0=C2=A0 Fulong 2E
> +M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>  =C2=A0M: Aleksandar Markovic <amarkovic@wavecomp.com>
> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>

You are a prolific contributor of the Fuloong, are you OK to be listed=20
as reviewer in this section?

>  =C2=A0=C2=A0 S: Odd Fixes
>  =C2=A0=C2=A0 F: hw/mips/mips_fulong2e.c
>  =C2=A0=C2=A0 F: hw/isa/vt82c686.c
> ---
>=20
> Either this way, or if you prefer to be listed with a R-tag:
> Acked-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>


