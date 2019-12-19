Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08C8C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:07:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1B1C218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pe3vdkpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B1C218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvWC-0005O0-GG
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:07:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihvUL-0002zj-Bk
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihvUI-0002a2-Eo
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:05:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30652
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihvUI-0002TG-8V
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576760705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZgBCxUVb0Libd/JSUw7uTFBdCttTbaWw1zp84vhxh60=;
 b=Pe3vdkpvcVLg4ud/7kPwo15AZdXE2lsG5RDlmw9pR2hYBMOU0+ECsPj8tpONK0yyTTJ0yo
 FGJJdJ40Ia706n/Sz1PjC16pLVAI5y+DxUPVEGtDzFpLvc4xWy9K1KFNBE0yxRpvM+gcoU
 bxVRLC4TQb72Uv6CTGHFq3u62sR++PA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-KhIvQYykMQabm04tz9ccsQ-1; Thu, 19 Dec 2019 08:04:59 -0500
Received: by mail-ed1-f69.google.com with SMTP id cy24so1225824edb.12
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 05:04:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JSHBYqZNJp+jEmSTQKaaXlWnb6FSSnjROA/aDLpAI6Y=;
 b=bciKsCiPw/oiL51PapRPAQ7JR55xBXc0kWRzt5C6E5eRTS7orIpDDNBe9+syVXdfVL
 Sngno2YkhnE3hOfoZkrvjwsBxhMj7UGxJkgh+db37InWGHKolN5VW/kiJy7+Loume/XB
 x1P3ojKqQu8XFK6gRNosbRYELt0qhV94wNeT/IyJrAnl3NL4EWPCa8YdnuMr8khWufh1
 9nntsGJk18P4af4IzZ7aeY/pdzyoGlyxfW/vOUvgD+A1kmrirwamLIWNEtT4q8qFZISO
 AGHMO26XwC9Ee98upDo64N9/PU096ca1VXjB1Lnm8BlaQdgOblMVa6Aor9RpYY8gUP71
 KAzA==
X-Gm-Message-State: APjAAAWHsBgekx8IB84nN1yBqIqfuS1SFSj/h1YwAR6gGnCBUQo44cQ5
 G0vDrm7CNf5WWOHT5va1xbEa84ALwGU5OB7QMA26vIW+APIEmLMBtkkTxfC93R/c43bdhE9N2PT
 JNAJEbntrkGYFWhQ=
X-Received: by 2002:a17:906:bcf5:: with SMTP id
 op21mr9151065ejb.160.1576760697621; 
 Thu, 19 Dec 2019 05:04:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqzbqqm/wuRTCpiPRFG2W42OQ7zBnrwcJiefEA+USi8Tn8NMcbXHFzOwNx4YmzYWvtOlC7JYbQ==
X-Received: by 2002:a17:906:bcf5:: with SMTP id
 op21mr9151038ejb.160.1576760697384; 
 Thu, 19 Dec 2019 05:04:57 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id bs4sm475652ejb.39.2019.12.19.05.04.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2019 05:04:56 -0800 (PST)
Subject: Re: [EXTERNAL]Re: [PATCH v4 29/37] RFC: mips/cps: fix setting saar
 property
To: Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-30-marcandre.lureau@redhat.com>
 <41a2531e-b887-6f72-fd51-a7e1d5688670@redhat.com>
 <BN6PR2201MB1251016B3D5948ABEFAAC117C6510@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ed819b44-fd59-46c0-d6ea-4f162d564209@redhat.com>
Date: Thu, 19 Dec 2019 14:04:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB1251016B3D5948ABEFAAC117C6510@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Language: en-US
X-MC-Unique: KhIvQYykMQabm04tz9ccsQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/16/19 8:36 PM, Aleksandar Markovic wrote:
>> From: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>> Sent: Sunday, December 15, 2019 6:56 AM
>>> On 11/20/19 4:24 PM, Marc-Andr=E9 Lureau wrote:
>>> There is no "saar" property. Note: I haven't been able to test this
>>> code. Help welcome.
>>>
>>> May fix commit 043715d1e0fbb3e3411be3f898c5b77b7f90327a ("target/mips:
>>> Update ITU to utilize SAARI and SAAR CP0 registers")
>>>
>>> Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
>>> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>    hw/mips/cps.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/mips/cps.c b/hw/mips/cps.c
>>> index 1660f86908..c49868d5da 100644
>>> --- a/hw/mips/cps.c
>>> +++ b/hw/mips/cps.c
>>> @@ -106,7 +106,7 @@ static void mips_cps_realize(DeviceState *dev, Erro=
r **errp)
>>>            object_property_set_bool(OBJECT(&s->itu), saar_present, "saa=
r-present",
>>>                                     &err);
>>>            if (saar_present) {
>>> -            qdev_prop_set_ptr(DEVICE(&s->itu), "saar", (void *)&env->C=
P0_SAAR);
>>> +            s->itu.saar =3D &env->CP0_SAAR;
>>
>> Hmmm this could be what the author of 043715d1e wanted to do indeed.
>>
>> Since this feature is incomplete (see comments in previous versions of
>> this series:
>>     $ git grep saarp
>>     hw/mips/cps.c:98:    saar_present =3D (bool)env->saarp;
>>     target/mips/cpu.h:1103:    int saarp;
>> and I don't know how to test this, I'll defer to Aleksandar regarding
>> this patch.
>=20
> Hello, Philippe,
>=20
> Good that you brought this to my attention - but Marc-Andr=E9 and
> I already had a discussion about this in this series' cover letter
> responses (unfortunately not followed up by me as a response to
> this patch, sorry about that):
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg00056.html
>=20
> In essence, our conclusion was that the real fix would be certainly
> outside of the scope of this series, since it requires some really
> (non-straightforward) mips-specific code changes, so we agreed
> that Marc-Andr=E9 submit this patch as-is, and later on (certainly
> within timeframe of 5.0) I will submit the fix addressing the root
> cause (absence of "saar" property, and incomplete handling of
> SAAR and SAARI config registers).

OK, thanks for clarifying again!

> In other words, this patch is fine at this moment, and formally:
>=20
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>=20
> (Marc-Andr=E9, just please remove "RFC" from the title, and remove
> the sentence "Note: I haven't been able to test this code. Help
> welcome." from the commit message, since we have the deal on
> how and who will fix the underlining problem.)
>=20
> Thanks to both of you!
>=20
> Aleksandar
>=20


