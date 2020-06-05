Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5255C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:46:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F4A5207D0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UYrnobY+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F4A5207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh8vp-0000hN-VZ
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 05:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jh8v9-0000En-Ir
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:45:51 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jh8v8-0006Jq-99
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:45:51 -0400
Received: by mail-wr1-x444.google.com with SMTP id l10so9038736wrr.10
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 02:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=tJ2hqGRt4BtUwBC6N6/GqWpWY4AGSYXXpkol+CxETf4=;
 b=UYrnobY+D6gNyI9SGZK0SjJKBucGpm4/REt98w+WUHxHz6Att33W+2d4BXWjIXY0Lk
 H5krBQtlXpTtRnYJ761LPc4uZIVfG7N5X+Ys2i2OjToAx4p0qm7b/Is3MyYMGhKU04uk
 IxvLoCkSvpfhLWEhFYRJTY31jgIHqeQ9NQqSgddrKiXjiAnzdz/0UXSPdWzrcu1Ka4XH
 uQr1t7jNkqfFQFi3Fdl99U9OvnesloW6X07b4RxiLF2OMA9O2Az5ZmBe8GGJ1jyMV23r
 YVvz62ulBcDgzsFyBsoKqpFt9j2dwLhcTMGeFS41d9GiQapyyzHHhLz44hFLSZRB3vRO
 x9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=tJ2hqGRt4BtUwBC6N6/GqWpWY4AGSYXXpkol+CxETf4=;
 b=ZIZSfbeHvX7ch9JVwkNOEFJYBcnviKxezcJaxL0V6Es448MtvaNTCTkvfrOVeL9Q7r
 cnc2gH8GTWQjPrzmie2Uc0XczGl1MeyO6y+rMwllf4z8C5qGzRmKV1fJswn5xLiII+rr
 bjBYdNOmnyLPb0O9LDYC2FaeeCnZ6Xbu9XoZiLDqCyeJe0xmEiW6EnfexcAit2OOgXWS
 BC7ssT3doItL2r7xF3pCWQlPx/TAZf0PiOXhVUzHhKtvrJa3/J0X2Bdbx9D4zKQCqUxJ
 RIqDvgLf+auaN00PDr8lv2+OLVJvE6NmEY86P2keJmIgoRdKs9bPEIq2YWnn+7TwDg2k
 Xq6Q==
X-Gm-Message-State: AOAM531QkTZv4tgkds6RRpA3duGnIyMu7eRfjkAfvz56oDS1Q/Y7OEmM
 wY8Yq7EQvAdZXrWrhLCyDMcorw==
X-Google-Smtp-Source: ABdhPJyaK+ZW7JQCGI8LIgG5agQMpVP0yMJsY9EPn2RtGOJ+sU5d1g+kbtadd6D7pm6jGYY6FpAjBg==
X-Received: by 2002:adf:ecc2:: with SMTP id s2mr9650644wro.60.1591350347873;
 Fri, 05 Jun 2020 02:45:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s7sm11792383wrr.60.2020.06.05.02.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 02:45:46 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0BF941FF7E;
 Fri,  5 Jun 2020 10:45:46 +0100 (BST)
References: <20200527100546.29297-1-alex.bennee@linaro.org>
 <20200527100546.29297-3-alex.bennee@linaro.org>
 <355ff6ba-ed8a-bc1e-4b74-c87a532e47bd@linaro.org>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v1 2/3] linux-user: deal with address wrap for
 ARM_COMMPAGE on 32 bit
In-reply-to: <355ff6ba-ed8a-bc1e-4b74-c87a532e47bd@linaro.org>
Date: Fri, 05 Jun 2020 10:45:46 +0100
Message-ID: <87tuzp4zhx.fsf@linaro.org>
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


Richard Henderson <richard.henderson@linaro.org> writes:

> On 5/27/20 3:05 AM, Alex Benn=C3=A9e wrote:
>> @@ -2145,7 +2145,7 @@ static uintptr_t pgd_find_hole_fallback(uintptr_t =
guest_size, uintptr_t brk, lon
>>=20=20
>>  /* Return value for guest_base, or -1 if no hole found. */
>>  static uintptr_t pgb_find_hole(uintptr_t guest_loaddr, uintptr_t guest_=
size,
>> -                               long align)
>> +                               long align, uintptr_t offset)
>>  {
>>      GSList *maps, *iter;
>>      uintptr_t this_start, this_end, next_start, brk;
>> @@ -2171,7 +2171,7 @@ static uintptr_t pgb_find_hole(uintptr_t guest_loa=
ddr, uintptr_t guest_size,
>>=20=20
>>          this_end =3D ((MapInfo *)iter->data)->start;
>>          next_start =3D ((MapInfo *)iter->data)->end;
>> -        align_start =3D ROUND_UP(this_start, align);
>> +        align_start =3D ROUND_UP(this_start + offset, align);
>>=20=20
>>          /* Skip holes that are too small. */
>
> I suppose offset is supposed to mean we start from -offset?

Well guest_base will start higher meaning we have space for the
commpage beneath it.

> You didn't update
> pgb_find_hole_fallback.

Fixed.

>
>> -            loaddr =3D ARM_COMMPAGE & -align;
>> +            offset =3D (128 * KiB);
>
> Why 128K?  Surely this should be an expression against ARM_COMMPAGE.

In theory:

            offset =3D -(ARM_COMMPAGE & -align);

should do the trick but I found it failed every now and again.
Frustratingly putting printfs in made it go away so in frustration I
just upped the offset until it stopped happening.

I do kinda wish rr worked on i386 :-/


>
>
> r~


--=20
Alex Benn=C3=A9e

