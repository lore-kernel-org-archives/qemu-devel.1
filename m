Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FC1C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 10:17:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CBF52086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 10:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BrNoBz1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CBF52086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBFyQ-0003TG-Uy
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 06:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iBFwf-0002qm-GU
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 06:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iBFwd-0002uZ-CZ
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 06:15:20 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51244)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iBFwc-0002th-Vx
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 06:15:19 -0400
Received: by mail-wm1-x343.google.com with SMTP id 7so1839747wme.1
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 03:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=M1oxhbM9d9zbnSRaXRT9Li0Tm666coHFO6az+3kAhBw=;
 b=BrNoBz1TDdSC9ej8ZhpmEXuXDHHwbHXYRqC1j61b+UG1i/8Z4hRWjPHntCRliY9wnX
 1bhudc54n1eRZbWzeZyxME/Nf3ZccBdXs871iv1cP6TlOslAfVZA/8NXWqRD5KgKyewU
 pHZwEfwmwN4vT3XcCdHKc2wkTJ5Iv94O/0PNdIYPrXwQHtg0yPQNrv2JuY3JYAEv7iEj
 Lh9+lfoi1ToZwLYpULy32AVJwzgDBJptk6g2X/X73kflHU1e31Ga2jOmXj+nFf/214bb
 sswlrfcXJviVvJRYd4G1Q793yA5cmYrFd5XQGnjJq+truT/DUIywiubNL6Lz3qUJ8DTi
 PG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=M1oxhbM9d9zbnSRaXRT9Li0Tm666coHFO6az+3kAhBw=;
 b=By/1n8l53Gc/uIVRNO5JavPFpNynitWQM2uOg384bmclWxNwl46m6yKBYHRSRDQY3U
 wP+cXOCm5Dwx7zHJJoQB7MdgN0Vjaj22otCndpIoTaRe+UDbT2DiR3LkAbYPk8y/fCeU
 70inziueZmfOt74TybnPGBBqEmVqnrPQVnvc6AXd1oviihSnERNjmju8/Vvcpo7nk1wK
 titAFHaow3yyOenHIWPwdq7J97Ai+WZR4iHc1f/xxfn0pkmcsBoKXDI5eNUblz0Ar4Xs
 +C2qaNpHzu6d4TdMU6SZcBmF2mZOie4hgFqEYSZCtczBI2QM4Eg29NVU3TaoPJrzQQen
 1LGQ==
X-Gm-Message-State: APjAAAWXmgss0G+Jnbak1SLyR6rihbwKP+D2AxmaDNdiySIqWnCxpb+n
 YDK0embRyVevXqaEl3nyHyUKaQ==
X-Google-Smtp-Source: APXvYqwlejyJdN8YbrGgcg22XJSfqVjXUu2Vxtdx3MFN5GrkuYqlU6YNAFIgzqX6B0KCgWn5eMdGBg==
X-Received: by 2002:a7b:c7c5:: with SMTP id z5mr2738318wmk.37.1568974517355;
 Fri, 20 Sep 2019 03:15:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v64sm1609001wmf.12.2019.09.20.03.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 03:15:16 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 24AE51FF87;
 Fri, 20 Sep 2019 11:15:16 +0100 (BST)
References: <20190919171015.12681-1-alex.bennee@linaro.org>
 <20190919171015.12681-11-alex.bennee@linaro.org>
 <c6cd971c-e84c-c5c9-b313-2e454e02a1da@linaro.org>
 <87impnz568.fsf@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 10/16] tests/tcg: add generic version of float_convs
In-reply-to: <87impnz568.fsf@linaro.org>
Date: Fri, 20 Sep 2019 11:15:16 +0100
Message-ID: <87h857z32j.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Richard Henderson <richard.henderson@linaro.org> writes:
>
>> On 9/19/19 10:10 AM, Alex Benn=C3=A9e wrote:
>>> This is broadly similar to the existing fcvt test for ARM but using
>>> the generic float testing framework. We should be able to pare down
>>> the ARM fcvt test case to purely half-precision with or without the
>>> Alt HP provision.
>>>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> ---
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> This test seems to be tripping up alpha-linux-user be generating FPU
> exceptions. AFAICT we are meant to start with software exceptions
> disabled but:
>
>   cpu_alpha_store_fpcr: enabled exceptions: 2000000
>
> from the get go is what causes the eventual trip up.

I can't figure out what is meant to be going on with CONVERT_BITS. It
seems to be implying there is a direct relationship between status flags
and the exception disable bits. But that is confusing because integer
overflow (IOV) and float overflow (OVF) are different flags bit I assume
both suppressed by Overflow Disable (OVFD).

Why are we doing this magic 32 bit shuffling anyway? Is it purely to
save 32 bits of a mostly empty lower half of the FPCR register?

>
>>
>>
>> r~


--
Alex Benn=C3=A9e

