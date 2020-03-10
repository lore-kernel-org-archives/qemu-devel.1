Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32734C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:46:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2AA12467F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQP27/LP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2AA12467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBaWX-0002J7-7w
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 04:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jBaVE-0001Za-6j
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jBaVC-00089R-Kx
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:44:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31264
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jBaVC-00088F-HV
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583829878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HIfAQubbXj361NTk4KLXeq9AoXc/azvX5UjfGDSifLk=;
 b=NQP27/LPIXCwY8vWoD6Y5X7B0OsB8Ip3hg7Gmbu9F7D5HVOykfe9klS76aYUk93YOnS5cF
 daa7nYfIJnUK6LXCYZfEzywM2NU7bD+fXAVdI59TSaezbeJWM8Xk2LT7yf1zofJy37R5OM
 cUM4wRkTsAEw5MIrFO3fht7B2p8rXWs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-fWNIg4tsPWmuL4o98R4Ntw-1; Tue, 10 Mar 2020 04:44:31 -0400
X-MC-Unique: fWNIg4tsPWmuL4o98R4Ntw-1
Received: by mail-wm1-f69.google.com with SMTP id a13so89285wme.7
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 01:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nQp2Vswp1FgE90k74VLbwbB3lN6fqR0uKChLDHMGPhE=;
 b=gERATzL2GSeHQfj7Vrs2pVvJoHjqyQ2vV3ErNjODzKVWh6TD30IxAAWWS/C01C1vqF
 XS1H1V9JihZ1gkSW+NsVjjYf2NyDVjTfD2g8yIVL89+PO8mqJMaRG6HcqVW4gYv/LXpi
 QjtKi/xIS1Ju32drTmx3IQsLZLz4gRdllpzvuqL6GwqAhGUwtek/pGDoRK8pqTkc6ZeA
 GCL9V4r817p9LBV6hK6XYCKfcIyJ6tg2aoJ0erkQ1SJLxRRfncW2cHlsEt7QnnuHz0Nz
 VeODnLcuaBl0OcdCE06BKJsbotn13xrPpT6Ik/w8TtBNRfvfzOigroyZoSzxqNwtfY0w
 dnEw==
X-Gm-Message-State: ANhLgQ1pCj+vm96yPvs91z884ewSXL+2kp64cQukYscg7CC6Bi9Ay5GL
 Gtear/2ncu29/oUgtLQ/LqFXlFcXgPrFv15/OE5gmB8NQB5RBjleBRMe6fL3M9GVNOysNLFDZeN
 9SpVSyN3aPIJTjzI=
X-Received: by 2002:a7b:c318:: with SMTP id k24mr1032001wmj.54.1583829870234; 
 Tue, 10 Mar 2020 01:44:30 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuMaLXW33miZn6TN4vuVPGZOS47FCSwFyzxBIHqtG6HsbRs/iPHVaNpjWGhX/hAU168VAfCew==
X-Received: by 2002:a7b:c318:: with SMTP id k24mr1031960wmj.54.1583829869875; 
 Tue, 10 Mar 2020 01:44:29 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id q2sm5983863wrv.65.2020.03.10.01.44.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2020 01:44:29 -0700 (PDT)
Subject: Re: [PATCH] tests/acceptance/ppc_prep_40p: Use cdn.netbsd.org hostname
To: Cleber Rosa <crosa@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
References: <20200211134504.9156-1-philmd@redhat.com>
 <87eeuewv4k.fsf@linaro.org> <20200310014116.GF660117@umbus.fritz.box>
 <517418432.204149.1583807554368.JavaMail.zimbra@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <910181c0-b15f-a5d2-bc45-a4fd5d9736de@redhat.com>
Date: Tue, 10 Mar 2020 09:44:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <517418432.204149.1583807554368.JavaMail.zimbra@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/10/20 3:32 AM, Cleber Rosa wrote:
> ----- Original Message -----
>> From: "David Gibson" <david@gibson.dropbear.id.au>
>> To: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
>> Cc: qemu-devel@nongnu.org, "Wainer dos Santos Moschetta" <wainersm@redha=
t.com>, "Kamil Rytarowski"
>> <kamil@netbsd.org>, "Herv=C3=A9 Poussineau" <hpoussin@reactos.org>, "Cle=
ber Rosa" <crosa@redhat.com>,
>> qemu-ppc@nongnu.org, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
>> Sent: Monday, March 9, 2020 9:41:16 PM
>> Subject: Re: [PATCH] tests/acceptance/ppc_prep_40p: Use cdn.netbsd.org h=
ostname
>>
>> On Fri, Feb 28, 2020 at 04:10:19PM +0000, Alex Benn=C3=A9e wrote:
>>>
>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>>
>>>> Use NetBSD content delivery network to get faster downloads.
>>>
>>> Even with this patch I get failures on my big dev box:
>>>
>>>   (48/67)
>>>   tests/acceptance/ppc_prep_40p.py:IbmPrep40pMachine.test_openbios_and_=
netbsd:
>>>   INTERRUPTED: Failed to fetch NetBSD-7.1.2-prep.iso.\nRunner error
>>>   occurred: Timeout reached\nOriginal status: ERROR\n{'name':
>>>   '48-tests/acceptance/ppc_prep_40p.py:IbmPrep40pMachine.test_openbios_=
and_netbsd',
>>>   'logdir': '/home/alex/lsrc/qemu.git/builds/all/tests/results/jo... (6=
0.31
>>>   s)
>>>
>>> I think ultimately a whole ISO download is just too much for an
>>> acceptance test.
>>
>> I tend to agree.  Here in a network-remote part of the world, these
>> always seem to cause timeouts and other problems, in a bunch of the
>> testcases.
>>
>> Those are testing useful things though, so I'd really like to see the
>> downloads split out into some sort of preparation step that can be
>> done just once, rather than part of the test proper.
>>
>=20
> We have added functionality in the latest Avocado that will let us
> easily set a "cancel this test if the ISO has not being previously
> downloaded", or "cancel if it fails to be downloaded during the test".
>=20
> +Willian can explain how it works, and if found to be suitable, and work
> on a patch.

I suppose this is the relevant Avocado patch:

'Extends fetch_asset core method to find assets and cancel the test'
https://github.com/avocado-framework/avocado/commit/c345569fd

>=20
> -Cleber.
>=20
>>>> Suggested-by: Kamil Rytarowski <kamil@netbsd.org>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>> ---
>>>>   tests/acceptance/ppc_prep_40p.py | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tests/acceptance/ppc_prep_40p.py
>>>> b/tests/acceptance/ppc_prep_40p.py
>>>> index efe06037ba..6729d96f5e 100644
>>>> --- a/tests/acceptance/ppc_prep_40p.py
>>>> +++ b/tests/acceptance/ppc_prep_40p.py
>>>> @@ -34,7 +34,7 @@ def test_factory_firmware_and_netbsd(self):
>>>>                       '7020-40p/P12H0456.IMG')
>>>>           bios_hash =3D '1775face4e6dc27f3a6ed955ef6eb331bf817f03'
>>>>           bios_path =3D self.fetch_asset(bios_url, asset_hash=3Dbios_h=
ash)
>>>> -        drive_url =3D ('https://ftp.netbsd.org/pub/NetBSD/NetBSD-arch=
ive/'
>>>> +        drive_url =3D ('https://cdn.netbsd.org/pub/NetBSD/NetBSD-arch=
ive/'
>>>>                        'NetBSD-4.0/prep/installation/floppy/generic_co=
m0.fs')
>>>>           drive_hash =3D 'dbcfc09912e71bd5f0d82c7c1ee43082fb596ceb'
>>>>           drive_path =3D self.fetch_asset(drive_url, asset_hash=3Ddriv=
e_hash)
>>>> @@ -67,7 +67,7 @@ def test_openbios_and_netbsd(self):
>>>>           :avocado: tags=3Darch:ppc
>>>>           :avocado: tags=3Dmachine:40p
>>>>           """
>>>> -        drive_url =3D ('https://ftp.netbsd.org/pub/NetBSD/iso/7.1.2/'
>>>> +        drive_url =3D ('https://cdn.netbsd.org/pub/NetBSD/iso/7.1.2/'
>>>>                        'NetBSD-7.1.2-prep.iso')
>>>>           drive_hash =3D 'ac6fa2707d888b36d6fa64de6e7fe48e'
>>>>           drive_path =3D self.fetch_asset(drive_url, asset_hash=3Ddriv=
e_hash,
>>>
>>>
>>
>> --
>> David Gibson=09=09=09| I'll have my music baroque, and my code
>> david AT gibson.dropbear.id.au=09| minimalist, thank you.  NOT _the_ _ot=
her_
>> =09=09=09=09| _way_ _around_!
>> http://www.ozlabs.org/~dgibson
>>
>=20


