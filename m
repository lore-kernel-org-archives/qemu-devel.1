Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D65EC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 12:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC44258EC
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 12:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uE+HPIpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC44258EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53509 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWKII-0007D6-Jp
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 08:36:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWKHM-0006p9-Tg
	for qemu-devel@nongnu.org; Thu, 30 May 2019 08:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWKHI-00012F-4L
	for qemu-devel@nongnu.org; Thu, 30 May 2019 08:35:31 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:53986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWKHA-0007T3-MJ
	for qemu-devel@nongnu.org; Thu, 30 May 2019 08:35:25 -0400
Received: by mail-wm1-x32d.google.com with SMTP id d17so3877048wmb.3
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 05:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=ObFxiB3Co8vmM7dzXkn+yOqOqnwjv12Maeu86AiJn0U=;
	b=uE+HPIptMW8LW4IhDs4M45Ds5ue76HsrYAHr7Gky2EDZaD0L1Z1w1hAjENhBx6poBJ
	TGIe+2OzUVkzqMnaCqOAQOVERtsD9tWTbBZrH1liM+Mr2wA+DRH7LQ1FsksSfmJCZgfF
	ug784OCaIIlInRZVAtY7Me5IjWpBYahwNr16iGNKOo4yulas3HlYkI9mXir89QgjQemf
	oC/2873qajLXP8uO8W0Dz4uQVX0EUo2F3qo2zA3bRQALpxai6oIAAReTimVCRqXzWBXH
	72kccAEIgx3A7IecHuOMjTvWwH+pN5//tUJsqnMShqmL+G9qxVHSl5enRIoGMZXABZuN
	4WYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=ObFxiB3Co8vmM7dzXkn+yOqOqnwjv12Maeu86AiJn0U=;
	b=qUoNfhwJoqVQanMQo8X6HxYiXJqLY2eUXU2+0AzsQeC3yDksyoMyxOoLvZ9/unp5kg
	YYl1G8mf0HqNLskAHRxCqU/oGiIbSc3yYQr0CXAWYrq2MqfqQp5BF4RaIYj+LtfqS8dH
	cmKGYemfRUnI10SLpQu4YR7RtTJ9VBemF7troaCXex66BGYB0GCG2nRHu1/Qi4Di0Azl
	jSiWdrjE1lNYwcIQwYBq8NUqRCdk/4QAYUHbQo9UYv3I8Ai6VgjAWc/yvwO6ALCCngmG
	FBEZaTrpxquYUyP3DZh2kmZFkPiRmhafOQVbaB4aIACfR2pXej2V5Vu7HhMcid/qTjFI
	2MNw==
X-Gm-Message-State: APjAAAXDn3ewkLdBIncHVbKBwd9HhXNhO1mBlVt5Ztco7B1zW9zc3Xqq
	nVFI8l6cVDxImdcWsDIRj7ct8w==
X-Google-Smtp-Source: APXvYqx3bnXiKzyCUmqC47bcSeqxtsLVEqai6qWfxW0W5xo+1loz/TU/oPFnsjSy8O+Q5dNlhY3iow==
X-Received: by 2002:a1c:701a:: with SMTP id l26mr2125751wmc.32.1559219716933; 
	Thu, 30 May 2019 05:35:16 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	w185sm2230078wma.39.2019.05.30.05.35.15
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 05:35:16 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 5B2D11FF87;
	Thu, 30 May 2019 13:35:15 +0100 (BST)
References: <20190528094953.14898-1-alex.bennee@linaro.org>
	<20190528094953.14898-7-alex.bennee@linaro.org>
	<CAFEAcA8Azc9g7MfWE1_WbRQCMejHXpE62bYojRw+B9maAX=+hQ@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA8Azc9g7MfWE1_WbRQCMejHXpE62bYojRw+B9maAX=+hQ@mail.gmail.com>
Date: Thu, 30 May 2019 13:35:15 +0100
Message-ID: <87zhn43yt8.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::32d
Subject: Re: [Qemu-devel] [PULL 06/28] target/arm: use the common interface
 for WRITE0/WRITEC in arm-semi
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	"open list:ARM" <qemu-arm@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 28 May 2019 at 10:49, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Now we have a common semihosting console interface use that for our
>> string output. However ARM is currently unique in also supporting
>> semihosting for linux-user so we need to replicate the API in
>> linux-user. If other architectures gain this support we can move the
>> file later.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> Hi; Coverity points out an issue in this function (CID 1401700):
>
>
>> +int qemu_semihosting_console_out(CPUArchState *env, target_ulong addr, =
int len)
>> +{
>> +    void *s =3D lock_user_string(addr);
>> +    len =3D write(STDERR_FILENO, s, len ? len : strlen(s));
>> +    unlock_user(s, addr, 0);
>> +    return len;
>> +}
>
> We call lock_user_string(), which can fail and return NULL
> if the memory pointed to by addr isn't actually readable.
> But we don't check for the error, so we can pass a NULL
> pointer to write().

Mea culpa - I'd avoided the nastiness of the lock string stuff in the
softmmu case but reverted to a naive implementation for linux-user after
the fact. I'll send a fix for that.

> Also it looks a bit dodgy that we are passed in a
> specific length value but we then go and look at the length
> of the string, but we trust the specific length value over
> the length of the string. If len is larger than the real
> length of the string (including terminating NUL) then the
> write() will read off the end of the string.

It is an admittedly in-elegant hack to deal with the fact we call the
same function for outputting a character as well as a string. None of
the guests actually give us the length:

 * @len: length of string or 0 (string is null terminated)

We could formalise it by making s/len/is_char/ and making it a bool or
just add some more text to the description.

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

