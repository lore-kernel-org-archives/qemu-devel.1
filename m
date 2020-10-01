Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C8DC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:20:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB703206B5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BwFm6bG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB703206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNyVk-00024C-39
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 09:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kNyQp-0007ev-FT
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 09:15:37 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35022)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kNyQg-000706-Jf
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 09:15:32 -0400
Received: by mail-wr1-x443.google.com with SMTP id e16so5706555wrm.2
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 06:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=KzCf8cF1SCHnL9xCP/g2L94NP+Xi/+PLEWfVZzifuN8=;
 b=BwFm6bG7KpWIehglmyBRSfpMbuemLFZqc5UESUJ6y4altG3BGkPqrvr4kE805QQbfn
 Z+eCEF2MAastO8SFyo/1NMJ7FwR3vyZPSpfc5HHx/VYovJ8WR9VkRClWkVC/hrvhb1lX
 VjOg+wJOOU6qrTailR2jU+A+X1TFMCxmtBkeL0zIeVqqsGgoMKU2aNUhPBfnQZ7N2RSP
 hYxLlWCJQHwmqAzV8reVqTCXIUdw3lt5ajeRmxgJsUtI44m6WJA2mdMoRcS/+6FRy88n
 AhBDm+kGTC5NaZs4YKg7tr2Dwk6rftxByHosjmPkpx4ob28kWb1NTXqePH3x47pLISTx
 ctpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=KzCf8cF1SCHnL9xCP/g2L94NP+Xi/+PLEWfVZzifuN8=;
 b=LWoWf3+dunPmDixiqg1Bf3INOerw4VxBhTtjvaLB69OuDftFOtRcohqcCru7B9iCMv
 9fa/BFrBQ6gWdbE/y/Efu7q5moa48SFN/USIZ+7sBUZiJkPv4f0hryARatbdoMo8rBC0
 6wz+B4F11Dz1+rI0VjpkraWew5KgBkleuAJ9ZcfjUio1Dq8lFBmLTGD66ReLU6aZVowZ
 Yyul1WFWrHxlBowU8JwFJD97bBey0UyPaeAxRd0KUBg/g8KG4DjmjjDWLmLkvHHD28z6
 MZPa5/tdUt1cjZDa2OvuoGopjSZ2vwIbA6s1yCD2hh8aZDDGTv4seksQrr5N1F/joxXj
 Vrgw==
X-Gm-Message-State: AOAM5321MDsvF0/JQ0Pf4ytJm7WZafa8Wnjgkdf6RwKb7vB4c1K2jUHT
 NaXpIK0xJee7TdR97SgNXz5rRQ==
X-Google-Smtp-Source: ABdhPJwEMKgkEprAuJsHmI2ufniIa6cU2qTvSFeTkMIPhLM6u9Ak/4Tv6fnOB5STSHopox4bZ8zszg==
X-Received: by 2002:adf:f4c6:: with SMTP id h6mr8861242wrp.310.1601558123604; 
 Thu, 01 Oct 2020 06:15:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g14sm9048622wrv.25.2020.10.01.06.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 06:15:21 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0A0361FF7E;
 Thu,  1 Oct 2020 14:15:21 +0100 (BST)
References: <20200930145523.71087-1-david@redhat.com>
 <20200930145523.71087-2-david@redhat.com> <87o8lnnt3m.fsf@linaro.org>
 <1294d810-64a7-7e4d-fb73-238378e2197c@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 01/20] softfloat: Implement
 float128_(min|minnum|minnummag|max|maxnum|maxnummag)
In-reply-to: <1294d810-64a7-7e4d-fb73-238378e2197c@redhat.com>
Date: Thu, 01 Oct 2020 14:15:21 +0100
Message-ID: <87a6x6nl3q.fsf@linaro.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


David Hildenbrand <david@redhat.com> writes:

> On 30.09.20 18:10, Alex Benn=C3=A9e wrote:
>>=20
>> David Hildenbrand <david@redhat.com> writes:
>>=20
>>> Implementation inspired by minmax_floats(). Unfortuantely, we don't have
>>> any tests we can simply adjust/unlock.
>>>
>>> Cc: Aurelien Jarno <aurelien@aurel32.net>
>>> Cc: Peter Maydell <peter.maydell@linaro.org>
>>> Cc: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  fpu/softfloat.c         | 100 ++++++++++++++++++++++++++++++++++++++++
>>>  include/fpu/softfloat.h |   6 +++
>>>  2 files changed, 106 insertions(+)
>>>
>>> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
>>> index 9af75b9146..9463c5ea56 100644
>>> --- a/fpu/softfloat.c
>>> +++ b/fpu/softfloat.c
>>> @@ -621,6 +621,8 @@ static inline FloatParts float64_unpack_raw(float64=
 f)
>>>      return unpack_raw(float64_params, f);
>>>  }
>>>=20=20
>>> +static void float128_unpack(FloatParts128 *p, float128 a, float_status=
 *status);
>>> +
>>>  /* Pack a float from parts, but do not canonicalize.  */
>>>  static inline uint64_t pack_raw(FloatFmt fmt, FloatParts p)
>>>  {
>>> @@ -3180,6 +3182,89 @@ static FloatParts minmax_floats(FloatParts a, Fl=
oatParts b, bool ismin,
>>>      }
>>>  }
>>=20
>> It would be desirable to share as much logic for this as possible with
>> the existing minmax_floats code. I appreciate at some point we end up
>> having to deal with fractions and we haven't found a good way to
>> efficiently handle dealing with FloatParts and FloatParts128 in the same
>> unrolled code, however:
>>=20
>>>=20=20
>>> +static float128 float128_minmax(float128 a, float128 b, bool ismin, bo=
ol ieee,
>>> +                                bool ismag, float_status *s)
>>> +{
>>> +    FloatParts128 pa, pb;
>>> +    int a_exp, b_exp;
>>> +    bool a_less;
>>> +
>>> +    float128_unpack(&pa, a, s);
>>> +    float128_unpack(&pb, b, s);
>>> +
>>=20
>> From here:
>>> +    if (unlikely(is_nan(pa.cls) || is_nan(pb.cls))) {
>>> +        /* See comment in minmax_floats() */
>>> +        if (ieee && !is_snan(pa.cls) && !is_snan(pb.cls)) {
>>> +            if (is_nan(pa.cls) && !is_nan(pb.cls)) {
>>> +                return b;
>>> +            } else if (is_nan(pb.cls) && !is_nan(pa.cls)) {
>>> +                return a;
>>> +            }
>>> +        }
>>> +
>>> +        /* Similar logic to pick_nan(), avoiding re-packing. */
>>> +        if (is_snan(pa.cls) || is_snan(pb.cls)) {
>>> +            s->float_exception_flags |=3D float_flag_invalid;
>>> +        }
>>> +        if (s->default_nan_mode) {
>>> +            return float128_default_nan(s);
>>> +        }
>>=20
>> to here is common logic - is there anyway we could share it?
>
> I can try to factor it out, similar to pickNaN() - passing weird boolean
> flags and such. It most certainly won't win in a beauty contest, that's
> for sure.
>>=20
>> Likewise I wonder if there is scope for a float_minmax_exp helper that
>> could be shared here?
>
> I'll try, but I have the feeling that it might make the code harder to
> read than actually help. Will give it a try.

Give it a try - if it really does become harder to follow then we'll
stick with the duplication however if we can have common code you'll
know at least the nan handling and minmax behaviour for float128 will be
partially tested by the 16/32/64 float code.

>
> Thanks!


--=20
Alex Benn=C3=A9e

