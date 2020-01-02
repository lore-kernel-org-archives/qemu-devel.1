Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0886FC2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 11:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE71721655
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 11:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="THymOZ66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE71721655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imylw-0001gy-Le
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 06:36:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1imyi6-0000V8-7E
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:32:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1imyi4-0002uv-N3
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:32:13 -0500
Received: from mout.gmx.net ([212.227.17.21]:60671)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1imyi4-0002r2-9j
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:32:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1577964721;
 bh=pteBgBBZ3bFUetPm3gTlownSrXK+b55MuyW7Wrwfbjw=;
 h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
 b=THymOZ66z2UesSDSFXznigWx8oO/dMpP2JFKNd3fFb35r7pPlQivOikA2OUu2pgIy
 5/3aADHnSTdiCClwnkIIMlEMpiKuXNVUB8qmg0Oqm22tsTqJKYcyYHCaNLS4WTa7Js
 lzTK26xm+ZkEUd4q2DzFvmodfjpMf9df86Dzzhws=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.183.77]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXGr8-1jEyuF0quU-00YktI; Thu, 02
 Jan 2020 12:32:01 +0100
Subject: Re: [PATCH 43/86] hppa: drop RAM size fixup
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-44-git-send-email-imammedo@redhat.com>
 <bc7bac60-0d20-d0e3-b9ac-2c9ff62c2c15@redhat.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <8cb7bd0f-7841-7e60-8de6-708515b81b00@gmx.de>
Date: Thu, 2 Jan 2020 12:31:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <bc7bac60-0d20-d0e3-b9ac-2c9ff62c2c15@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8bONfpKY20tnlbwaRvVJrl30io1SDWWOiN2dT6FhfJ3cqooI4zY
 RSj4YqzIDqwEr62NEaKIDu3Q/fLTnGrA+4vYaXu2BkHrc/m/pYSYcGHOJSr3dTTA3OHBP9j
 7AKCTaNneD4bDVTv5uK2E2vLXtAgMZxLCh27cfnHsYhTHxVWwp5E0HKV4DxE0kX+HKtk4BC
 MRN8eOfiQ89gWbfgAh0Mw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d+PYNpcOd1g=:MueOFM1t0QXULnZekU7XZ2
 +dW9jUW6WsFG5F8kSZ+eu7QXWH8/JFJ4Go+F9s0Lh12XPWzPlE93qFqU3mBxUV2fA83HdRl/p
 sKspjtLzjZraod+lJY0oD+47ERC8IQZwdfqlBh9Vm3/cMxipWwR+TmwUBVdOBj+WKSwDoAAvt
 5yxCvkyedActp0mz3o/L/TjbBOBQaK4Bbq5sRZrQPHcR1mU7WfmjgiSb/faDe968Q06l603fV
 S96UZQctPq4zscXfFwhL8dHhHgy5s3+F4wDcU6uQL3H6nOoPywmJuGqaWiZb69GyXm3cfLGFh
 Tre3tTqdB/hNSh40dQ3bhbMZGV7TFyNuMWzbV4FtlsF5Hy43e8ZZR/367KJqgpZ25LBZWKXTk
 MsyEaMiTl0oUxA+EI6E9lELzx6pqorGE+99kuHeDAZ0hx9gC5hYEvu+3+azuzc4ZAkiSkcNIN
 rGIXTJF+LJBIHoqfudb+hHiAXDGEj61bIu1CmXmyYisB2MfrVXDBKIl+FrUjbTYCzpTmVFfkK
 al3U8SEeqb3eFOrduklJTOajKwQ/HUmuerIZ+L9NdMe57NmmP1QrmA49KSrSG8TpBarQEndoC
 bwzhSeGQC1g1Z3Ri0ciuq6aFlyZBDgRVK7aGqxxLbypDKOxcq04kZMdAA4SpDNxX8SF/C4zLE
 ccYKzTTDRyd7wpcpwcDi4zeiJuFJVZ9Ajb+Vl6/xnoglwQHq8yynFcgU1hEgL9GMZYByklR++
 ofWunFIKjVEUKl2HZc6F6bYxjBs77K99rTJOYDpLYX0X7a1kIaQWcMxQGWOtuEOan7RMeRvZH
 0uhT2hqK5bXr4YputUu7HKUuLrV2Quq2aUSkqNciLWTFlnX2CRclXPu3sNgZ0FDpsZkH56NDZ
 KLxOMGlRBWcX+sX72RQYuWVF79UVtlj+bKhEuozHTRAByPbsaJsLqFn0p5URUGSoSnWxM+93d
 ZLJMG2shINfT3vY/7T3cAo8/TPiVT+k+wq+Nty8KafUnQyHcONq7HEWXppqC8YAmyvyqqDB7S
 /dRvYIZYb4VwtIWbH2TccZo2ouWGuUrEPe48fq+Y6D9wLEwxdfAa7V1Ghg6sPuN+kp2OuQooN
 W9HTjy2qSpNCqHCjiK3FvtT30aF3HTHKPutK47MKoYotsOe6xOrMf2BEseoTSozDicxHQ3upR
 dtgZpphHJar6f9ih72z1ZRNJBVq8O4Xa7K5Dv3glsQ9hAmjkLEy9KkcejDicfX+PgQycvv5Qj
 H4ST4uDuNswKCABW3HRAzPDkWwFnl/M72E2OYLg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.21
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31.12.19 16:44, Philippe Mathieu-Daud=C3=A9 wrote:
> On 12/31/19 2:03 PM, Igor Mammedov wrote:
>> If user provided non-sense RAM size, board will complain and
>> continue running with max RAM size supported.
>> Also RAM is going to be allocated by generic code, so it won't be
>> possible for board to fix things up for user.
>>
>> Make it error message and exit to force user fix CLI,
>> instead of accepting non-sense CLI values.
>>
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> ---
>> =C2=A0 hw/hppa/machine.c | 3 ++-
>> =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>> index 5d0de26..25f5afc 100644
>> --- a/hw/hppa/machine.c
>> +++ b/hw/hppa/machine.c
>> @@ -92,7 +92,8 @@ static void machine_hppa_init(MachineState *machine)
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Limit main memory. */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ram_size > FIRMWARE_START) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 machine->ram_size =3D ram_s=
ize =3D FIRMWARE_START;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("RAM size more=
 than %d is not supported", FIRMWARE_START);
>> +        exit(EXIT_FAILURE);
>
> $ qemu-system-hppa -m 3841m
> qemu-system-hppa: invalid accelerator kvm
> qemu-system-hppa: falling back to tcg
> qemu-system-hppa: RAM size more than -268435456 is not supported
>
> Instead of using qemu_strtosz_MiB on FIRMWARE_START or unsigned format, =
we can simply use "RAM size more than 3840m is not supported". Is that OK =
with you?

I don't really like that change.

We currently only emulate a 32-bit system, and for those 4GB is the maximu=
m.
So, if I start my machine with "qemu-system-hppa -m 4G", the current code
then automatically uses the maximum possible of 3841MB (which is limited b=
y
firmware start address).
I don't expect users to know the excact 3841MB number.
Even on a phyiscal machine you can only add DIMMs of sizes 2GB, 3GB or 4GB=
,
but not "3841MB".

So, I think that patch is - although it's more correct - not a
benefit for the end user.

Helge

