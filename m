Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3B0C433FB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 16:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F97A2077D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 16:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OT2sWL7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F97A2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxumd-0001il-9A
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 12:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jxujA-0006pk-Mz
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 12:02:50 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46394)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jxuj5-0003V4-Hk
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 12:02:48 -0400
Received: by mail-wr1-x443.google.com with SMTP id r12so21634628wrj.13
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 09:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=c5WSna24NYXlpTR8ZC4MX1SjLp4KK09QM1iOPtr7AE4=;
 b=OT2sWL7mHWyYOUPi68ct/KO56zdyA9TWNXq77sfrrJAy6ke/D87Fbcru6COj05+Jx/
 Ip41nr+3hf15oWWRW7XOKC3ypDSS53dgvkuldF6Jfh6cPHGo1QtQh6mATeFp1HDW+Kg3
 Perhv64OtRzFg3g5c02D6pU9sXxHfB3Qr+xVfhdbDB1C+mB9uMODV5eIQexfyybSIcnf
 E5GF679bEn/mJ4JXHuU40uzMapAjIt4hvJSWluY/jGGGa6HLuOv1TdrvvqV82HicdJcc
 SvB1Ce9Ze199hP5yNEy6tdxlcrUYRpKSTwunst5xMnFQPzFhNfSg8xXaTxRVsTc8QL6P
 AQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=c5WSna24NYXlpTR8ZC4MX1SjLp4KK09QM1iOPtr7AE4=;
 b=VbyDTtY8Ff4I9XjsniNMp1jhSODSIy1WKCHofQJqCB6BwGDem0ilm0jgqHKb17l/qv
 8y1xLtUraqHIn5p+AHRGPrvR5N3cD6Sp9/9rMlzN8Rv+VB0or/r5LWIYF1FYlBB+Y6jv
 R8yKn2LEEQ+2pMA68xr5y3tqw6yjMJp/XG50swBpMSFVyUJKtyU0saLv/56gLFkgevvM
 6lfzM1+e3XkJJ9WbuO78QtCZO06Tj4xoZSA7P8A3AV7oef1kzn5aVpgd+nZhsEozAtsR
 ASe8oRO9xaduQTEPwhAuNLKfdqrYvi1ZWVSiyRogKBI8qzlkB7/6LgNLExcimxP2kLIA
 1Mqg==
X-Gm-Message-State: AOAM530Bwt9lXNzWrN/wBBmMOVA4ZAod8zMoaMeYv5eTFD8fBuvWOgvl
 iFcHG28YqYHbnyQgl5PP80h4kQ==
X-Google-Smtp-Source: ABdhPJz9pMbgoA7dVb8jrwm3AcKywtSB6qD1FJdS6fPnB4f5+sM79kQlV3KRlC1m1uZ4HiDZx/H+5g==
X-Received: by 2002:a5d:414e:: with SMTP id c14mr1047547wrq.57.1595347361785; 
 Tue, 21 Jul 2020 09:02:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o9sm38021909wrs.1.2020.07.21.09.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 09:02:40 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3631D1FF7E;
 Tue, 21 Jul 2020 17:02:34 +0100 (BST)
References: <20200716144251.23004-1-lersek@redhat.com>
 <a38a3da3-7406-0ba3-ca32-e96a99915c97@redhat.com>
 <af008780-5207-c156-56f3-dcda95367a5a@redhat.com>
 <cc685d76-db4c-74bf-34dc-744fdd28add3@redhat.com>
 <d3686a7e-c949-8111-80d9-45aa506fcf58@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] target/i386: floatx80: avoid compound literals in
 static initializers
In-reply-to: <d3686a7e-c949-8111-80d9-45aa506fcf58@redhat.com>
Date: Tue, 21 Jul 2020 17:02:34 +0100
Message-ID: <87eep4voth.fsf@linaro.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Joseph Myers <joseph@codesourcery.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 7/17/20 6:46 PM, Laszlo Ersek wrote:
>> On 07/17/20 11:26, Laszlo Ersek wrote:
>>> On 07/16/20 17:09, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 7/16/20 4:42 PM, Laszlo Ersek wrote:
>>>>> Quoting ISO C99 6.7.8p4, "All the expressions in an initializer for an
>>>>> object that has static storage duration shall be constant expressions=
 or
>>>>> string literals".
>>>>>
>>>>> The compound literal produced by the make_floatx80() macro is not suc=
h a
>>>>> constant expression, per 6.6p7-9. (An implementation may accept it,
>>>>> according to 6.6p10, but is not required to.)
>>>>>
>>>>> Therefore using "floatx80_zero" and make_floatx80() for initializing
>>>>> "f2xm1_table" and "fpatan_table" is not portable. And gcc-4.8 in RHEL=
-7.6
>>>>> actually chokes on them:
>>>>>
>>>>>> target/i386/fpu_helper.c:871:5: error: initializer element is not co=
nstant
>>>>>>      { make_floatx80(0xbfff, 0x8000000000000000ULL),
>>>>>>      ^
>>>>
>>>> This reminds me of:
>>>>
>>>> commit 6fa9ba09dbf4eb8b52bcb47d6820957f1b77ee0b
>>>> Author: Kamil Rytarowski <n54@gmx.com>
>>>> Date:   Mon Sep 4 23:23:06 2017 +0200
>>>>
>>>>     target/m68k: Switch fpu_rom from make_floatx80() to make_floatx80_=
init()
>>>>
>>>>     GCC 4.7.2 on SunOS reports that the values assigned to array membe=
rs
>>>> are not
>>>>     real constants:
>>>>
>>>>     target/m68k/fpu_helper.c:32:5: error: initializer element is not
>>>> constant
>>>>     target/m68k/fpu_helper.c:32:5: error: (near initialization for
>>>> 'fpu_rom[0]')
>>>>     rules.mak:66: recipe for target 'target/m68k/fpu_helper.o' failed
>>>>
>>>>     Convert the array to make_floatx80_init() to fix it.
>>>>     Replace floatx80_pi-like constants with make_floatx80_init() as th=
ey are
>>>>     defined as make_floatx80().
>>>>
>>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>>
>>>>>
>>>>> We've had the make_floatx80_init() macro for this purpose since commit
>>>>> 3bf7e40ab914 ("softfloat: fix for C99", 2012-03-17), so let's use that
>>>>> macro again.
>>>>>
>>>>> Fixes: eca30647fc07
>>>>> Fixes: ff57bb7b6326
>>>>> Link: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg06566.=
html
>>>>> Link: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg04714.=
html
>>>>> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>>> Cc: Aurelien Jarno <aurelien@aurel32.net>
>>>>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>>>>> Cc: Joseph Myers <joseph@codesourcery.com>
>>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>>> Cc: Peter Maydell <peter.maydell@linaro.org>
>>>>> Cc: Richard Henderson <rth@twiddle.net>
>>>>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>>>>> ---
>>>>>
>>>>> Notes:
>>>>>     I can see that there are test cases under "tests/tcg/i386", but I=
 don't
>>>>>     know how to run them.
>>>>
>>>> Yeah it is not easy to figure...
>>>>
>>>> Try 'make run-tcg-tests-i386-softmmu'
>>>> but you need docker :^)
>>>
>>> That worked, thanks! Even without Docker: I just had to add
>>>
>>>   --cross-cc-i386=3Dgcc
>>>
>>> to my ./configure flags.
>>>
>>=20
>> Also -- I meant to, but I forgot to put "for-5.1" in the subject prefix;
>> sorry about that.
>
> Alex, as Paolo is not available, can this go via your tree?

Ok queued to for-5.1/fixes-for-rc1-v2, thanks.

>
>>=20
>> Laszlo
>>=20


--=20
Alex Benn=C3=A9e

