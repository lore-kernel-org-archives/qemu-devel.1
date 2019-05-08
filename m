Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B16CC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 17:46:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE1F021734
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 17:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dg0QMC/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1F021734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41016 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOQeE-0002g6-7z
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 13:46:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOQdC-0001Me-AF
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:45:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOQdB-0004DY-8V
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:45:26 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34081)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hOQdB-0004Cj-09
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:45:25 -0400
Received: by mail-wr1-x442.google.com with SMTP id f7so18003729wrq.1
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 10:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=97oI7gqhYp+YP7IWWdCZjm+XVFptkUlPZHDGSsQNLbo=;
	b=Dg0QMC/nRUVAV6IOioWA5i7qSdBjYukfgSN+xAbFUCC71oe6yQyhABykDOWWRRdLQ8
	ai0X9ahVm+IryJFnK/V3us7wzik9Or89QkpIXVINGyRljTeOh78DirFn17V0v1bkIWE4
	l4Afy0nea/oJ9/vb7wUCTI7Tikhuf7RMYywFdX8YjYrSwVhIFZ91KWBBvDovlp+gnaD4
	vYokSTGgFZmdGnHqvym7DPxBAexfZXKiLvd9b1Uxv3mk/ZNwNNL5xO5brwW+Pbs87+pP
	EaDTeNdDg6r84FQk3WcCAm28wAI5fHVaunHsLfwPlZZJu30uB3MOFLUEnUG44zkBaMtf
	KbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=97oI7gqhYp+YP7IWWdCZjm+XVFptkUlPZHDGSsQNLbo=;
	b=Qh+BNn8NsQ8xbeigsjj23gpP/GeASWKJQdA5wmZcgaLv/UIcqYEoCjxHPdU0WOaYJW
	ttb+Z6P+MmAa+8pJlMCfKgzV2EZWlgOFqAB09stjQmvroFCznN24IpRME9OrwlFu+6xr
	UgZTakSJ+P67wPemeZjU7PSNsRdI5Uyb6y2nOzs3A1SIgQLgAK6nkRmlU7IdIr+Pg333
	gwMWbt/7SMAwnKS6dsSWuDxDz549TIhG6zF+cCxMZIIc8fhKqpXdZzA3tfDuVOcOK1El
	8jukQZ8nlkDqXX64L5i0h85LKDsIqG7Hrevg9Sl6mDFBpwOvha8kb2+0WU95YdGww5bU
	rSog==
X-Gm-Message-State: APjAAAXnrvZhzZdJp23wKszZuq5ir/yduOlbEAxZIIGLgF8zDjQ4Ne3T
	DobImMOTDMa5jYU59YDZttfxEA==
X-Google-Smtp-Source: APXvYqx7VQjyUoYDglDqmvDNawkpXVxS+OqzkDmvkKb7eqPETAoB6iGLB3s0yTwHR8yXb+aW8yQgvg==
X-Received: by 2002:adf:dd12:: with SMTP id a18mr29249748wrm.188.1557337523660;
	Wed, 08 May 2019 10:45:23 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	u11sm33738623wrg.35.2019.05.08.10.45.22
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 08 May 2019 10:45:22 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 300701FF87;
	Wed,  8 May 2019 18:45:22 +0100 (BST)
References: <20190430165234.32272-1-alex.bennee@linaro.org>
	<20190430165234.32272-4-alex.bennee@linaro.org>
	<83e4f91b-a590-2a2a-bf5f-14b99c5aa0fc@linaro.org>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <83e4f91b-a590-2a2a-bf5f-14b99c5aa0fc@linaro.org>
Date: Wed, 08 May 2019 18:45:22 +0100
Message-ID: <87sgto4z7x.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v5 03/15] tests/tcg/aarch64: add system
 boot.S
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
	cota@braap.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 4/30/19 9:52 AM, Alex Benn=C3=A9e wrote:
>> +.error:
>> +	.string "Terminated by exception.\n"
>
> Put it in .rodata just because we can?
>
>> +        /* Page table setup (identity mapping).  */
>> +	adrp	x0, ttb
>> +	add	x0, x0, :lo12:ttb
>
> You are in control of the layout of the executable,
> and adr has a 1MB range.  Why use adrp+add?

Well I have to now as I've aligned .data with:

    /* align r/w section to next 2mb */
    . =3D ALIGN(1 << 21);

>
>> +        /* Create some (big) pages */
>> +	adr	x1, .				/* phys address */
>> +	bic	x1, x1, #(1 << 30) - 1		/* 1GB block alignment */
>
> Do you really want 1GB pages?  You'll pretty much only be able to test va=
lid
> memory operations with that.  Which is also true until there's something =
other
> than an exit for the exception vector... but ya know what I mean.

Not using it for testing but I'm trying to set-up a 2 stage translation
so we get:

  1gb->1gb+2mb =3D .text/.rodata
  1gb+2mb->1gb+4mb =3D .data/.bss

>
>> +        /* Setup some stack space and enter the test code.
>> +         * Assume everthing except the return value is garbage when we
>> +	 * return, we won't need it.
>> +         */
>> +	adrp	x0, stack
>> +	add	x0, x0, :lo12:stack
>> +        mov      sp, x0
>
> You need a pointer to the end of the stack, not the beginning.
> Again, I think this could be just
>
> 	adr	sp, stack_end
>
> Also, there's tab/space confusion all through this file.
> IMO, this is assembly, so it *should* be tabs.

I'm adding an entry to editorconfig and fixing up the damage.

>
>> @@ -0,0 +1,22 @@
>> +ENTRY(__start)
>> +
>> +SECTIONS
>> +{
>> +    /* virt machine, RAM starts at 1gb */
>> +    . =3D (1 << 30);
>> +    .text : {
>> +        *(.text)
>> +    }
>> +    .data : {
>> +        *(.data)
>> +    }
>> +    .rodata : {
>> +        *(.rodata)
>> +    }
>
> If you ever wanted to make this read-only, swap .rodata before .data, so =
that
> it's next to .text.

done.

>
>
> r~


--
Alex Benn=C3=A9e

