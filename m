Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18B0C433E4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A88532077D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AKWbbfel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88532077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyAY4-0005il-18
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 04:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyAXW-0005Jl-1x
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:55:50 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36091)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyAXU-0002Ev-2i
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:55:49 -0400
Received: by mail-wr1-x443.google.com with SMTP id 88so1102951wrh.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 01:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=e1py8a2Eo/s+ZXdrHpUPNiGmK9f4wgfUGO7n8wX6KtY=;
 b=AKWbbfel7NQkX/1YWHQmadfO18mfE5BRJjd8GXFECcdYWORoHxXE8vYTCyPwVyHn2o
 wAuqKG4r22Lyc1LwvnydXdQ3nk8jObP51v32c15zTpsHNirySjEgNg7Xmmh7De3oA7mt
 HrXvNR8SwmQyaQk1+6LhiEZ+5v/XOeU+aS6G+vH2VciYBeJfnFXdKWzrlfNfEbMAp/b9
 gAP9lt0N/zMC7ED8m3p+y0m+e4LEXRG7xJmNzEQn9EBJjYUeJphb8ObrAhF8LZSBLDYB
 F5y9trnCcjr4gvseI+LZJgN7zO0W/nI4bUOg7byZDPd8+R/j8NgXzX/UlZkEvrSlEFN3
 oI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=e1py8a2Eo/s+ZXdrHpUPNiGmK9f4wgfUGO7n8wX6KtY=;
 b=thHno9YEvzD0XZQltGKlJ+pG5p6f0/qW2Li6UfbcYnPtMtd1vdqmYltpoX5WovjfSD
 05MNvwOq7m1Ba5lv5w+St9BNNAz7qztjErLh64jPsTTWaiR+5hPumZV/jskJp0Izsy44
 3lp/zcQo+z3JLmz6zC1E2BIiMylsvHUuswmHXi4hkkSeQt/n5YgQraxaxLhn0BSjmJbS
 /NJu9keMh/FzRpLOeKS4m0p7GFTwXTZFdTOR9b7MWPUXEYt9uesWWLxSYJ6VlrFpxtsf
 jLYaQWyQsg2NSvd4DXewUtXlse9f8ftCyEO7F2msci27UIgqxi5ytmV6OFpFdO5SpquX
 PHow==
X-Gm-Message-State: AOAM530G0DQolEprOwHjhwd2qbksdzJk1NUwMJG5tTloz5pgYx2pEw/O
 Kpp2Yr+BwH8A8JZ00i4JNAxrqg==
X-Google-Smtp-Source: ABdhPJxLX7Me1stAOCSIiiu1oLlOd6GnVTht60D919qgyEW7F0YFLFrMtoaT8nds3QkjxK8T0mSjUw==
X-Received: by 2002:adf:9526:: with SMTP id 35mr5953858wrs.326.1595408146325; 
 Wed, 22 Jul 2020 01:55:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w12sm43756126wrm.79.2020.07.22.01.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 01:55:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2C15C1FF7E;
 Wed, 22 Jul 2020 09:55:44 +0100 (BST)
References: <20200722062902.24509-1-alex.bennee@linaro.org>
 <20200722062902.24509-13-alex.bennee@linaro.org>
 <2c1c17a6-9bae-322b-9e28-722d11074405@vivier.eu>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v2 12/12] linux-user: fix clock_nanosleep()
In-reply-to: <2c1c17a6-9bae-322b-9e28-722d11074405@vivier.eu>
Date: Wed, 22 Jul 2020 09:55:44 +0100
Message-ID: <87365kudwv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: fam@euphon.net, berrange@redhat.com, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, f4bug@amsat.org, cota@braap.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Laurent Vivier <laurent@vivier.eu> writes:

> Le 22/07/2020 =C3=A0 08:29, Alex Benn=C3=A9e a =C3=A9crit :
>> From: Laurent Vivier <laurent@vivier.eu>
>>=20
>> If clock_nanosleep() encounters an error, it returns one of the positive
>> error number.
>>=20
>> If the call is interrupted by a signal handler, it fails with error EINTR
>> and if "remain" is not NULL and "flags" is not TIMER_ABSTIME, it returns
>> the remaining unslept time in "remain".
>>=20
>> Update linux-user to not overwrite the "remain" structure if there is no
>> error.
>>=20
>> Found with "make check-tcg", linux-test fails on nanosleep test:
>>=20
>>   TEST    linux-test on x86_64
>> .../tests/tcg/multiarch/linux-test.c:242: nanosleep
>> make[2]: *** [../Makefile.target:153: run-linux-test] Error 1
>> make[1]: *** [.../tests/tcg/Makefile.qemu:76: run-guest-tests] Error 2
>> make: *** [.../tests/Makefile.include:857: run-tcg-tests-x86_64-linux-us=
er] Error 2
>>=20
>> Reported-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> Message-Id: <20200721201754.2731479-1-laurent@vivier.eu>
>> ---
>>  linux-user/syscall.c | 15 ++++++++++++---
>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 1211e759c26..caa7cd3cab9 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -11829,10 +11829,19 @@ static abi_long do_syscall1(void *cpu_env, int=
 num, abi_long arg1,
>>      {
>>          struct timespec ts;
>>          target_to_host_timespec(&ts, arg3);
>> -        ret =3D get_errno(safe_clock_nanosleep(arg1, arg2,
>> -                                             &ts, arg4 ? &ts : NULL));
>> -        if (arg4)
>> +        /*
>> +         * clock_nanosleep() returns 0 or one of the *positive* error n=
umber.
>> +         */
>> +        ret =3D host_to_target_errno(safe_clock_nanosleep(arg1, arg2, &=
ts,
>> +                                                        arg4 ? &ts : NU=
LL));
>> +        /*
>> +         * if the call is interrupted by a signal handler, it fails
>> +         * with error TARGET_EINTR and if arg4 is not NULL and arg2 is =
not
>> +         * TIMER_ABSTIME, it returns the remaining unslept time in arg4.
>> +         */
>> +        if (ret =3D=3D TARGET_EINTR && arg4 && arg2 !=3D TIMER_ABSTIME)=
 {
>>              host_to_target_timespec(arg4, &ts);
>> +        }
>>=20=20
>>  #if defined(TARGET_PPC)
>>          /* clock_nanosleep is odd in that it returns positive errno val=
ues.
>>=20
>
> Wait a little before pushing that: I've made more tests and it seems to
> break something in LTP. I have to analyze.

OK - which LTP test does it break?

I can drop from the PR if we don't have a clean-up by then (Fri?).

>
> Thanks,
> Laurent


--=20
Alex Benn=C3=A9e

