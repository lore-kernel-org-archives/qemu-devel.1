Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5A5C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 13:51:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7B982077B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 13:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLaaKvwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B982077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVFXH-0005BE-PU
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 08:51:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iVFWQ-0004G4-M1
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:50:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iVFWN-0000EK-3G
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:50:52 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48470
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iVFWM-0000Do-J0
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573739449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mYVb3L/LNMEtvgozawpC1rD5HN5eAXZ92totcON8QQ4=;
 b=CLaaKvwmxWAcocFDDmANyl/dxO2LrxmA2M3oj92wkgageY44VQ9PfpZwChYkAecb7438zj
 9041jk89/xJHJok5eXQdnLaQtO3NYhYlRfI3M6bItdQ2lxdheTbvq1M57/MhCCN1hxNAC1
 zHRopXUBqy7gV6etFwl8hx4s48K0mWY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-RzW3JwRQPeunwbjLJk8AkQ-1; Thu, 14 Nov 2019 08:50:46 -0500
Received: by mail-wm1-f69.google.com with SMTP id 2so3978952wmd.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 05:50:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aTDZEWntx4CF9QTP/Is31EyF4orvy4PIdCELlKhV4Vw=;
 b=F/QhT6XcKHilCgmCMGqMGWkxCuwnA1uAbkvhrXr/ecPpSSixwnCvGSUb2TIITTUb3b
 9RFlirPE96/2kxjqlq5rdHhfdnZhWbXOXn2d2jEIu4zz9lIUfwzOybBEjYK7yjXx2XRv
 kMcq4IUFS47auSnSQzhtdajAJyjLv3UQHKu6MJsq6EY9Wz1Jw5uPix7Eh1XCgvDAPYNf
 EyZPfQIsSpGVhXsbwoSjB/mQgCjVVDuaROxvWl87R18w25/FnXW1kP15AKw757iDKiye
 rLy3qbihLfOD+LE4jNTVea9WV21MvOeFRH9xM9OJ0/9DmIpnwX0BlwA2rzuFVCroGnna
 KIhg==
X-Gm-Message-State: APjAAAVzyTy3QoTbUO9wfBce7ZJ/lnOuKxm7ZEly8a2HgjYz3Lmwq//N
 Rn2CyYadyMVYB7XyNDlOTlkhyJfHF4YZLJNQFXksfVZonI5qI8XLuRXCXoILJebYtR2rSR65NcO
 /doYLV+ahzhWx1xA=
X-Received: by 2002:adf:b746:: with SMTP id n6mr8155737wre.65.1573739445078;
 Thu, 14 Nov 2019 05:50:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqxfuOaXXj8PesPyk9Mo7VcHTFoXIN1sqBV/TuQNh+u0dGEv6LjOeyBLy3y+QZ61PqJxYnQyVw==
X-Received: by 2002:adf:b746:: with SMTP id n6mr8155705wre.65.1573739444719;
 Thu, 14 Nov 2019 05:50:44 -0800 (PST)
Received: from [192.168.1.35] (170.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.170])
 by smtp.gmail.com with ESMTPSA id o16sm7252845wra.89.2019.11.14.05.50.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2019 05:50:44 -0800 (PST)
Subject: Re: [EXTERNAL]Re: [PATCH v2 2/5] MAINTAINERS: Adjust maintainership
 for Fulong 2E board
To: chen huacai <zltjiangshi@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
References: <1573652826-23987-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1573652826-23987-3-git-send-email-aleksandar.markovic@rt-rk.com>
 <c053c16c-c6f4-4f73-7383-7b66e54ad696@redhat.com>
 <BN6PR2201MB12512B977314BCFCA202449DC6710@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <CABDp7VoVpZsQpDc7U4uJ1B7ZVCc8A2KO5qNaOucHQH6xUdX8tQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4a94a570-301b-e2db-6090-929e63f907cd@redhat.com>
Date: Thu, 14 Nov 2019 14:50:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CABDp7VoVpZsQpDc7U4uJ1B7ZVCc8A2KO5qNaOucHQH6xUdX8tQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: RzW3JwRQPeunwbjLJk8AkQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 11/14/19 2:08 PM, chen huacai wrote:
> Hi, all,
>=20
> On Thu, Nov 14, 2019 at 8:34 PM Aleksandar Markovic
> <amarkovic@wavecomp.com> wrote:
>>
>> Hi, Philippe,
>>
>>> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>
>>> Hi Aleksandar,
>>>
>>> On 11/13/19 2:47 PM, Aleksandar Markovic wrote:
>>>> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>>>>
>>>> Change the maintainership for Fulong 2E board to improve its quality.
>>>
>>> IIRC you told me once this board is named Fuloong, and its CPU is a
>> =E2=80=8E> Loongson, both with 2x 'o' :) I have a patch renaming the var=
ious
>>> occurrences.
>>>
>>
>> I still think that the oficial name is "Fuloong 2E", however, it is
>> shortened to "Fulong 2E" quite often in communication, and, it seems,
>> sometimes even in various docs/app notes etc.
>>
>> Can perhaps Huacai Chen enlighten us regarding the right spelling?
> The right spelling is Fuloong.
>=20
[...]>>> The original author is active on the Linux kernel, let ask him=20
if he'd
>>> be OK to keep an eye on his work.
>>>
>>> Huacai, would you agree to be listed as a reviewer on the Fuloong
>>> related QEMU files? You don't have to worry about the generic QEMU code
>>> plate (like keeping API up to date) I'll manage that, but I'd like to
>>> have you listed to assert the hardware is properly modeled.
>>>
>>> You would appear as:
>>> R: Huacai Chen <chenhc@lemote.com>
>>>
>>
>> That is a great idea!
>>
>> Please, Chen, get involved, you would be very welcomed, there is a place
>> for you in QEMU community!
> I'm sorry that I'm busy now, but I think I will do something in QEMU
> in the next year.

No problem, we'll keep in touch.

>>>> +R: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>>>
>>> I don't think Herv=C3=A9 is interested by this board, he has not modifi=
ed the
>>> code.
>>>
>>>> +R: Aleksandar Markovic <amarkovic@wavecomp.com>
>>>> +S: Maintained
>>>
>>> Let keep it as "Odd Fixes" :)
>>>
>>
>> OK.
>>
>>>     Odd Fixes:   It has a maintainer but they don't have
>>>                  time to do much other than throw the odd
>>>                  patch in.
>>>
>>>>    F: hw/mips/mips_fulong2e.c
>>>>    F: hw/isa/vt82c686.c
>>>>    F: hw/pci-host/bonito.c
>>>>
>>>
>>> So the patch would be:
>>>
>>> -- 8< --
>>>    Fulong 2E
>>> -M: Aleksandar Markovic <amarkovic@wavecomp.com>
>>> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>>> +M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> +R: Aleksandar Markovic <amarkovic@wavecomp.com>
>>> +R: Huacai Chen <chenhc@lemote.com>
>>>    S: Odd Fixes
>>>    F: hw/mips/mips_fulong2e.c
>>>    F: hw/isa/vt82c686.c
>>
>> Plus possible s/Fulong 2E/Fuloong 2E/

I'd prefer to keep this change for later, with the patch cleaning its=20
use in the codebase (not that trivial because we need to alias the=20
machine name to keep backward compatibility).

>>
>>> ---
>>>
>>> But let's wait to see what Huacai Chen thinks of it, before posting it.

Aleksandar, can you stay as co-maintainer?

The patch would be:

-- 8< --
    Fulong 2E
+M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
  M: Aleksandar Markovic <amarkovic@wavecomp.com>
-R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
    S: Odd Fixes
    F: hw/mips/mips_fulong2e.c
    F: hw/isa/vt82c686.c
---

Either this way, or if you prefer to be listed with a R-tag:
Acked-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>


