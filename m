Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA27C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 08:32:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3537C2075F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 08:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b0u0IWHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3537C2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeDy3-0000hQ-B0
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 04:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jeDxK-0000Ft-0T
 for qemu-devel@nongnu.org; Thu, 28 May 2020 04:32:02 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43785)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jeDxI-0005Ut-Oz
 for qemu-devel@nongnu.org; Thu, 28 May 2020 04:32:01 -0400
Received: by mail-wr1-x442.google.com with SMTP id l10so4199328wrr.10
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 01:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=yi+9k0hg5cfK6DtGVXjY8rz1iBH+cs9n77/rueNp8Cs=;
 b=b0u0IWHiIg6n4rMKKuHhyu2e357mc4s1HTDB1SwhnFDcKKIM6OuiW8aM2Ev2l7GDKq
 Ys+PrMJOb5fXfkRXPYso1K0IrR28FF63eQBibWzMBUVcPf2d4xqI3MIWzKzvPO8GjBio
 /HAkZQc6pcbr9/QCf50DOOjap5rd4FICLNBIzTM++lTWN7OX6oRTlEW3MwcuXOfBkoZO
 iMnJnc8J4CxN026soTXPlkomwvm4pja482ruq9D0Sea4H5CtNATWeuPeWSgjWP9lGLHk
 QLPiujOO0kYBtXe0lJ+NMdOE8xbX+JxIwzebyWlzW/n2R+uP7+JY3pzD+/RLwzPuUGKq
 omYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=yi+9k0hg5cfK6DtGVXjY8rz1iBH+cs9n77/rueNp8Cs=;
 b=AS+SlcIrMh9dXPk3l3nDu2D+du53EM48xk/IWYaAfsrSwmG1OzZxu61uPKbowsTd8A
 jcyiPhWiOLW61QCxlC3IO+tc+voeewZLAXbjR+GioXHCwO2dNy2uL0Sk3z/vSOcJrP5W
 JDDrz3XqImPOlxm+e+MAledGsy3yYpjHTSK07dgU6zYblFZZRk0P1/KwjqI1mMaO+Vv2
 4TC4RC/cl1J2MaZcmYp8MUiKPaGRw6shfVmWgQLb3Y8pkFDvcVqqktlJPvLSQG8MP6K6
 GlGmaUyoNx7xhrVR33CHeCteGwskXQkWWfjrbQaqzQv+zGW8BNrHPpKYM0XTcpvHyZnN
 ATug==
X-Gm-Message-State: AOAM530QDAbkcyAk+kTsv04pzKIsQIR4Zj3sLbEoiV5FFSuG+p6esFiI
 Jq7wb+efX05+wCuR2DFz5KXq6Vyn4f8=
X-Google-Smtp-Source: ABdhPJwjvA1uAYuqD+8nLYROIjcjkX8bpkt/o/6so+l0bZBXb1AvFkXhlLONG9KTHQGWhAOoXa52rQ==
X-Received: by 2002:a5d:62c2:: with SMTP id o2mr2335623wrv.51.1590654717529;
 Thu, 28 May 2020 01:31:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o15sm5724641wmm.31.2020.05.28.01.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 01:31:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 17C041FF7E;
 Thu, 28 May 2020 09:31:55 +0100 (BST)
References: <20200525131823.715-1-thuth@redhat.com>
 <20200525131823.715-8-thuth@redhat.com>
 <1b050c61-0cd3-bc91-7610-856a28a27175@vivier.eu>
 <ab17e3cd-5117-b54b-6460-60c595d97033@redhat.com>
 <87imgh5o82.fsf@linaro.org>
 <037520b7-e17d-b516-a2da-a41ee8a1624a@redhat.com>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 7/7] linux-user: limit check to HOST_LONG_BITS <
 TARGET_ABI_BITS
In-reply-to: <037520b7-e17d-b516-a2da-a41ee8a1624a@redhat.com>
Date: Thu, 28 May 2020 09:31:55 +0100
Message-ID: <87y2pc4g04.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 27/05/2020 18.36, Alex Benn=C3=A9e wrote:
>>=20
>> Thomas Huth <thuth@redhat.com> writes:
>>=20
>>> On 27/05/2020 16.44, Laurent Vivier wrote:
>>>> Le 25/05/2020 =C3=A0 15:18, Thomas Huth a =C3=A9crit :
>>>>> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>>>
>>>>> Newer clangs rightly spot that you can never exceed the full address
>>>>> space of 64 bit hosts with:
>>>>>
>>>>>   linux-user/elfload.c:2076:41: error: result of comparison 'unsigned
>>>>>   long' > 18446744073709551615 is always false
>>>>>   [-Werror,-Wtautological-type-limit-compare]
>>>>>   4685         if ((guest_hiaddr - guest_base) > ~(uintptr_t)0) {
>>>>>   4686             ~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
>>>>>   4687 1 error generated.
>>>>>
>>>>> So lets limit the check to 32 bit hosts only.
>>>>>
>>>>> Fixes: ee94743034bf
>>>>> Reported-by: Thomas Huth <thuth@redhat.com>
>>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>>> [thuth: Use HOST_LONG_BITS < TARGET_ABI_BITS instead of HOST_LONG_BIT=
S =3D=3D 32]
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>  linux-user/elfload.c | 2 ++
>>>>>  1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>>>>> index 01a9323a63..ebc663ea0b 100644
>>>>> --- a/linux-user/elfload.c
>>>>> +++ b/linux-user/elfload.c
>>>>> @@ -2073,12 +2073,14 @@ static void pgb_have_guest_base(const char *i=
mage_name, abi_ulong guest_loaddr,
>>>>>              exit(EXIT_FAILURE);
>>>>>          }
>>>>>      } else {
>>>>> +#if HOST_LONG_BITS < TARGET_ABI_BITS
>>>>>          if ((guest_hiaddr - guest_base) > ~(uintptr_t)0) {
>>>>>              error_report("%s: requires more virtual address space "
>>>>>                           "than the host can provide (0x%" PRIx64 ")",
>>>>>                           image_name, (uint64_t)guest_hiaddr - guest_=
base);
>>>>>              exit(EXIT_FAILURE);
>>>>>          }
>>>>> +#endif
>>>>>      }
>>>>>=20=20
>>>>>      /*
>>>>>
>>>>
>>>> Philippe sent the same patch:
>>>>
>>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg699796.html
>>>
>>> Indeed, but looking more closely, he's using slightly different
>>> locations for the #if and #endif ... not sure what's better though...?
>>=20
>> Richard was more inclined to suppress the warning:
>>=20
>>   Subject: Re: [PATCH v2] linux-user: limit check to HOST_LONG_BITS =3D=
=3D 32
>>   From: Richard Henderson <richard.henderson@linaro.org>
>>   Message-ID: <3069bc1b-115d-f361-8271-c775bf6957ea@linaro.org>
>>   Date: Thu, 21 May 2020 20:15:51 -0700
>>=20
>> One reason I dropped the f32 patch from my last PR was because this
>> wasn't the only warning the latest clang picks up.
>
> ... but this is currently the only spot that is required to get the
> gitlab CI going again, so I think we should include this patch until we
> have a final decision whether to disable the warning or not (and we can
> still revert this patch after we disabled the warning). Ok?

I'm certainly happy with that if it gets gitlab working.

My experience with make docker-test-vlang@fedora (with 32) was there
where more things to fix. I guess gitlab didn't trigger them.

--=20
Alex Benn=C3=A9e

