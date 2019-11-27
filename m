Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1FCC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 21:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC052154A
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 21:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbJP4bzj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC052154A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia4ct-0001t5-7n
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 16:13:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ia4bs-0001GU-M1
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 16:12:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ia4bo-0004ie-UP
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 16:12:26 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47617
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ia4bl-0004fN-D1
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 16:12:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574889140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bwbbs4ZUMLN/1qvmYrol7/KBkDtDz01plHiS8YSikNs=;
 b=KbJP4bzj9duBxwtFAati7SX500f/beQFpuL+S3zGMvnLT7M/wuQf3y3argFwBuEOCq06rq
 F97Eik/qUjIlgHnpJI7/lR5TJ02Wna5/UeUuNzEn0VrtB4TI0HoIe31bPJ9HKmV+x3Mypc
 lrb8LIAt0w6bjftxxwDXzLJUpr2xCZc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-ruYnRboJPz-O5MjNXW8ptA-1; Wed, 27 Nov 2019 16:12:17 -0500
Received: by mail-wr1-f71.google.com with SMTP id u12so2651392wrt.15
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 13:12:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MqEGFFijv+REavj4qe40GQOiEk9xbVCBnG6C7HvmxnI=;
 b=OPoOlFA5pfRD1DgHHR8428VtNm+/PKrFrFxkPXdSswUTo2HYoDIBRyqvTJg3+GhUB3
 90PVTaessE6XHvU+1xQXzMlcZ06vMPsCQG0t7EKCCdLDYEExKiKMOsosxLPmwP2hQt3S
 ROxI2aTEEPBvZVQMUoShzCnr3Fb62GrJbeDOWYWeqLtgk+bLdOllyVJZDBWHXwzzxwPJ
 JAKUDvh+O+N7kRfgzW1z2Eu54YE8A1icOB5UnxBW+Ej+ayn3n49+z7v76wr/A/82Yst7
 4gMbeFGhm3u8SqoPzkqp1w69qocs0YlobkXNRYgFQGK6bOiJc101AxhaRKCk7f1gIEcx
 0vGA==
X-Gm-Message-State: APjAAAXMCriCvM7PxTgyJfYYu6Rqsl5HC53Ti3jwjPfh0VtASLFzOkXs
 wU41+cMeGepvgH9xKPWVdEg1IYqMChJodahGXRHPAJ/wkfzuczQ16tHJmYBE8YtZLcuLJwjg252
 mWeHOxzBLM3aByn0=
X-Received: by 2002:a1c:96c4:: with SMTP id y187mr5983905wmd.112.1574889135980; 
 Wed, 27 Nov 2019 13:12:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqw/x1B5PhVK5U+MNVAEx+ogN81URpNQPSSszFuNQlG2ydHuy4ccPxF7mrMlX2vLgTXTMli/mw==
X-Received: by 2002:a1c:96c4:: with SMTP id y187mr5983887wmd.112.1574889135755; 
 Wed, 27 Nov 2019 13:12:15 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id z26sm6139546wmk.33.2019.11.27.13.12.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2019 13:12:15 -0800 (PST)
Subject: Re: [libvirt] [PATCH-for-4.2] hw/mips: Deprecate the r4k machine
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20191125104103.28962-1-philmd@redhat.com>
 <CAL1e-=hktyuAzESyZMz3P4a9aq17dsrrzWpyXYfFYn=cWP3e4A@mail.gmail.com>
 <20191125154021.GI4157473@redhat.com>
 <CAL1e-=h8b5FZ2tGXB62skK8Ub8diKCjL++Ss6EGQnoQ5TkOmnw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <51894598-2502-6f1e-b59a-6e344c70cf54@redhat.com>
Date: Wed, 27 Nov 2019 22:12:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=h8b5FZ2tGXB62skK8Ub8diKCjL++Ss6EGQnoQ5TkOmnw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: ruYnRboJPz-O5MjNXW8ptA-1
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
Cc: Thomas Huth <thuth@redhat.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/27/19 8:40 PM, Aleksandar Markovic wrote:
> On Mon, Nov 25, 2019 at 4:40 PM Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
>>
>> On Mon, Nov 25, 2019 at 03:45:35PM +0100, Aleksandar Markovic wrote:
>>> On Monday, November 25, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com>
>>> wrote:
>>>
>>>> The r4k machine was introduced in 2005 (6af0bf9c7) and its last
>>>> logical change was in 2005 (9542611a6). After we can count 164
>>>> maintenance commits (QEMU API changes) with the exception of
>>>> 1 fix in 2015 (memory leak, commit 3ad9fd5a).
>>>>
>>>>
>>> Please don't start any deprecation process. This requires certain
>>> consultation within my company. Rest assured that everyone's opinion wi=
ll
>>> be taken into account while doing consiltation.
>>
>> The idea of having a deprecation process is precisely to
>> allow time for people like to provide feedback before any
>> deletion takes place. So this is not a reason to delay
>> starting of deprecation.
>>
>=20
> What you said is fine, Daniel, I understand the idea, and it should be
> that way. But I didn't ask for some lengthy negotiation, or waiting
> for someone for months, but I just wanted to check within company if
> all relevant people (that do not read QEMU devel list very often)
> agree - since we, naturally, do various in-house setups with QEMU for
> MIPS, that's all. This could count as the discussion on the patch, not
> as a part of that loooooong "deprecated" state...

Thank you Aleksandar for clearing that with MIPS so quickly!

>> The process lasts for 2 releases before we delete anything:
>>
>>    https://qemu.weilnetz.de/doc/qemu-doc.html#Deprecated-features
>>
>> When we start the clock now, it is deprecated when 5.0 releases
>> in April 2020, and still deprecated with 5.1 in August 2020.
>>
>> The code won't be deleted until Sep 2020 when 5.2 dev cycle opens,
>> and there's still time to undelete it right up until the 5.2 feature
>> freeze in late Oct 2020. That's 11 months away, which is plenty of
>> time for feedback IMHO.
>>
>> Regards,
>> Daniel
>> --
>> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberra=
nge :|
>> |: https://libvirt.org         -o-            https://fstop138.berrange.=
com :|
>> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberra=
nge :|
>>
>=20


