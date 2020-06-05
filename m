Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6240EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:28:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D3F2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z/kS8PMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D3F2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh9a8-0004MY-DV
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 06:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jh9X8-0008SO-B5
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:25:06 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45287)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jh9X5-0006ps-HJ
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:25:05 -0400
Received: by mail-wr1-x444.google.com with SMTP id c3so9159766wru.12
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 03:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=3FD/zOHKmvX65oEOsFJTgPzFn5yTKCVq+fGQN8ygRsg=;
 b=Z/kS8PMkvCWdTxTzDifIoFhCMN/oyRYjDFNlVgpWdjK+lKE4BoGsH2HmbqC3Z11dFa
 eqesTwmsUe8VBKMGsxbrzD0BbdGF+32VT2niKtKcCLDXcK8P5YpzWWBeQpACn1sdBEVK
 4mRck4z3pnC7Z+jnSR1iIopxDAdS4jrNRoUNl7v63mi2pfcn0Krvq1Ned8qCymMEdRRq
 35Cd+LBHRxIOtlJYb6+kd3gkYQ4k0W2411Ig7CaHob9kvDoLU/hTavMbJ4k0vQ1Z9sG1
 3UoyCGfqVcc+bL5kiKzxc08akDLpkTpDEtiUnAsIbNX59MXurLP4hKW/gZ8/Cnddrd18
 pHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=3FD/zOHKmvX65oEOsFJTgPzFn5yTKCVq+fGQN8ygRsg=;
 b=Q9UFkZCEgqtlXDbY75WWNQvc3NUmhdBNOYDaOuPAdZ5n8A1QFo1Zx5n8lE3P7zWvoV
 S6ZSK4mTPKqFcCfJJZTKUi5T3QDLo7WhYbybkMUeZWPeeidtnfXnenNAIfX70RiAeoo9
 AKgNMjiwbQmHNV9ExHwivUb7ievM39/gz8YS0UYDfh2Wwe3nolAHvPYjdujyQkjutdLu
 y0vUgsXvTkf9ZhjFWpdCxnec9BGljaFMHaRPYRD9zVLbezS/JX1Vk3ciawze09LSh9z6
 Rx2rVQbkFGqHnTIuhOm5Ks/aVccS3vspE5dqiYVRIOnfC26OOxFg7ZDz1iMsuOpxuBfq
 l4eA==
X-Gm-Message-State: AOAM531PQpALHdVCU3GMp7yEub9bLcGZlcCaacyO6cr4myWfXFolYRbc
 JBG/qT7rm9QxoNYhqOtALiKHTw==
X-Google-Smtp-Source: ABdhPJx4FseI/kyqICyRgpEW0CFGwUWGXbdFDFhZGsa+TovM4XuSvO0YwRkKc1svh7k8o0wb0pVRlw==
X-Received: by 2002:adf:bb4f:: with SMTP id x15mr8499930wrg.332.1591352701224; 
 Fri, 05 Jun 2020 03:25:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u4sm11422002wmb.48.2020.06.05.03.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 03:24:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 155BD1FF7E;
 Fri,  5 Jun 2020 11:24:59 +0100 (BST)
References: <20200527100546.29297-1-alex.bennee@linaro.org>
 <20200527100546.29297-3-alex.bennee@linaro.org>
 <355ff6ba-ed8a-bc1e-4b74-c87a532e47bd@linaro.org>
 <87tuzp4zhx.fsf@linaro.org>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v1 2/3] linux-user: deal with address wrap for
 ARM_COMMPAGE on 32 bit
In-reply-to: <87tuzp4zhx.fsf@linaro.org>
Date: Fri, 05 Jun 2020 11:24:59 +0100
Message-ID: <87k10l4xok.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bug 1880225 <1880225@bugs.launchpad.net>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Richard Henderson <richard.henderson@linaro.org> writes:
>
>> On 5/27/20 3:05 AM, Alex Benn=C3=A9e wrote:
>>> @@ -2145,7 +2145,7 @@ static uintptr_t pgd_find_hole_fallback(uintptr_t=
 guest_size, uintptr_t brk, lon
>>>=20=20
>>>  /* Return value for guest_base, or -1 if no hole found. */
>>>  static uintptr_t pgb_find_hole(uintptr_t guest_loaddr, uintptr_t guest=
_size,
>>> -                               long align)
>>> +                               long align, uintptr_t offset)
>>>  {
>>>      GSList *maps, *iter;
>>>      uintptr_t this_start, this_end, next_start, brk;
>>> @@ -2171,7 +2171,7 @@ static uintptr_t pgb_find_hole(uintptr_t guest_lo=
addr, uintptr_t guest_size,
>>>=20=20
>>>          this_end =3D ((MapInfo *)iter->data)->start;
>>>          next_start =3D ((MapInfo *)iter->data)->end;
>>> -        align_start =3D ROUND_UP(this_start, align);
>>> +        align_start =3D ROUND_UP(this_start + offset, align);
>>>=20=20
>>>          /* Skip holes that are too small. */
>>
>> I suppose offset is supposed to mean we start from -offset?
>
> Well guest_base will start higher meaning we have space for the
> commpage beneath it.
>
>> You didn't update
>> pgb_find_hole_fallback.
>
> Fixed.
>
>>
>>> -            loaddr =3D ARM_COMMPAGE & -align;
>>> +            offset =3D (128 * KiB);
>>
>> Why 128K?  Surely this should be an expression against ARM_COMMPAGE.
>
> In theory:
>
>             offset =3D -(ARM_COMMPAGE & -align);
>
> should do the trick but I found it failed every now and again.
> Frustratingly putting printfs in made it go away so in frustration I
> just upped the offset until it stopped happening.
>
> I do kinda wish rr worked on i386 :-/

Ahh all I needed was a MAP_FIXED for init_commpage

--=20
Alex Benn=C3=A9e

