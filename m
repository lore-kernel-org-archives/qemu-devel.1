Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012AEC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 20:15:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EC7B22317
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 20:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="UPiuUTbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC7B22317
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX9uN-0003na-4e
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 15:15:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1iX9pz-0001rf-Mu
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 15:11:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1iX9py-0001S2-KG
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 15:10:59 -0500
Received: from mout.gmx.net ([212.227.17.22]:57931)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1iX9py-0001Rg-BA
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 15:10:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1574194252;
 bh=QPCpCV2P5sSVUJcZNj8fAFPWf03tG1h3qNuMNwsxywQ=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
 b=UPiuUTbMZHJiCrhQe7svxFJN7FoUZxYz2pljBkPZl2yeUKyPj0IaRORXcclRmFJFD
 KR9JiXOOzHe4Ji2c+3zhzv1heaxv2YgXaRRU7tDUzXmCbGr7e6PV+UwamZJxBmN4+S
 gwqGEaF6LiH5xav4QhzI07rDvYkm0jI7eB+a0QZk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.148.64]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFsUp-1idWZH1mxz-00HPKM; Tue, 19
 Nov 2019 21:10:52 +0100
Subject: Re: [PATCH] linux-user/strace: Add missing signal strings
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191119185153.GA23003@ls3530.fritz.box>
 <48097cb5-bc47-e532-fcde-67ca65a2039e@linaro.org>
 <06aaa584-fc97-8097-ca52-00d97982e5be@gmx.de>
Message-ID: <ee03462e-74e2-8d87-22a7-1b786bb669e4@gmx.de>
Date: Tue, 19 Nov 2019 21:10:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <06aaa584-fc97-8097-ca52-00d97982e5be@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dfKdEx/LAbxJ6XYVgZmJKK3WcAhGdv4zkbCO57Dj1PgUg/+v0We
 dN2OkVg2RMM+Rgie17A5Gb0kXWL1z43o1fgOL2BStv0SOFdJww5NIoTW79MPfdV3b2IjlrB
 A61QCYK46elLAsgGXZdlIAmCtVsBIww62ZBroxzsa4kb1xezAM+S9S7HsxJfPhUZp8eSgV9
 7IU+oWHDtp7Xs5zvacHJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4HKBIxSHREM=:zEyNVf+STzA4b9ig+M6wHi
 DYvX4+bd6GU6bggF6gJljyhvHqDoY4VGoSozi9MsQW/6W4p6P+l/j/7Bik/9zEeWit0WvabLE
 N3efQo8FpQ6W56kQ+sC5OypPm7fOZufeYnPFrfKnFz/rZw0E1LT+wMOVWiQzJSH8Vh2eLLVkd
 MdGbHWMNk4GmJZCHDF38+B498hq2SrvZPiujLeWEQN8SqkOlRy/E6mPaqne018TEvWxKkEJBR
 +XcJNS1T1GonC61tkM5ayONx9EF7SAEuKI5/hllR0jVRc8hXt2ESQD6wg1UWehHfu1gRmSWSb
 5KcSjPuGomUKhgWOgzOsPi6kMGnz3NaNkLjh+m6EsoJW2ogWV64KUuhv0Kcjn6+dh7m1gVLgG
 U8ACNUZGl4IX0xUyGBNTShaDfp2lZolb5EOii5JTzH/CTZoitIiOV88NnEagC0jA1R9SB9Vsd
 zB6v9w2yVuHv/QSn/WksIzNjfntqMRioWPindW6zMrTXf9z/9/KK1N/ZTISslr99n7EjTLFlc
 LW/PZAtgzrgGITB8JzaOERhZ/rzYIpmCe62BUGHSMUd1NZfXWkyYPxwKIGP2qCzn54klcGvNI
 bxdbewk9e45bpee383strdajXujRZ8C4UCgocmR9Br6Iv4IgrztrzoiK8f8w6W7vITgJFHK78
 k8cWHIk1ayQtFdFMHWOu9ex+qJUdsUK8mFtOtNnKyU5ZWn3/eqUL+LYemqTe2aiRz0YvyH/1p
 glKT4/gqqXUOqZdlBf1kPK4xZEYIfhQt5tJZAqbLp6SglzU1CaDwg/TnHQzfiFNdLLkTTaChU
 5J4+d4ezi3Qq6wc03lbAyVW1DcPjiuJkE6neay/NBRWiUw70Y8UOvXCNGNaxQtDM5GDDsi57S
 HYSZCR0DmQfptrdDoXTAt/ltbAdoYvgfLgCcN9LCT7z8y6PaMJO+7hsK0gD/rDUgGOshq1kCt
 5i+5jD8pb8BwstTnDDVkWGAamx7TVgfJS7gTQjUJB+wft2t5jkq33EDM3aGmhIMmqfTAsFz0E
 lrjDjSCGFMLDyAmzZLgO01nBhSrl4/aHDkojImt2auzQb8pVhgRXP5RrSHL3Pj047ADtM1a2x
 2sMwJTfaU0IVtUWX/Vsdl9AmUe97g/mn7pMiraJJ0i45q7sz6ibGhhnkiS8b9elDkg0CoQVOt
 8MQ+RdLG8jxEx6j1XyOwztPh/dxWuB15B4kKANoL4Md5L34OOE3c9/pCwLjAoD8uN7J+2ZRfL
 F+tN+Q26OxGZcAbfVK7KwDqD8GOH+dDk6CKHP5Q==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.22
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19.11.19 21:06, Helge Deller wrote:
> On 19.11.19 20:56, Richard Henderson wrote:
>> On 11/19/19 7:51 PM, Helge Deller wrote:
>>> Add the textual representations of some missing target signals.
>>>
>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>
>>> diff --git a/linux-user/strace.c b/linux-user/strace.c
>>> index 3d4d684450..18b57a9ef9 100644
>>> --- a/linux-user/strace.c
>>> +++ b/linux-user/strace.c
>>> @@ -146,6 +146,22 @@ print_signal(abi_ulong arg, int last)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case TARGET_SIGSTOP: signal_name =3D "S=
IGSTOP"; break;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case TARGET_SIGTTIN: signal_name =3D "S=
IGTTIN"; break;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case TARGET_SIGTTOU: signal_name =3D "S=
IGTTOU"; break;
>>> +=C2=A0=C2=A0=C2=A0 case TARGET_SIGIO: signal_name =3D "SIGIO"; break;
>>> +=C2=A0=C2=A0=C2=A0 case TARGET_SIGTRAP: signal_name =3D "SIGTRAP"; br=
eak;
>>> +=C2=A0=C2=A0=C2=A0 /* case TARGET_SIGIOT: signal_name =3D "SIGIOT"; b=
reak; */
>>
>> Unused commented code.
>
> True, but I kept it intentionally the same as it's currently in
> linux-user/signal.c (line 40) so it's not forgotten if that changes:
> /*=C2=A0=C2=A0=C2=A0 [SIGIOT] =3D TARGET_SIGIOT,*/
>
>>> +#ifdef SIGSTKFLT
>>> +=C2=A0=C2=A0=C2=A0 case TARGET_SIGSTKFLT: signal_name =3D "SIGSTKFLT"=
; break;
>>> +#endif
>>
>> Wrong ifdef.
>
> Same here, see in linux-user/signal.c (line 50):
> #ifdef SIGSTKFLT
>  =C2=A0=C2=A0=C2=A0 [SIGSTKFLT] =3D TARGET_SIGSTKFLT,
> #endif

OIC!
My code should to be:
#ifdef TARGET_SIGSTKFLT

Will resubmit after getting suggestions for the unused commented code.

Helge

