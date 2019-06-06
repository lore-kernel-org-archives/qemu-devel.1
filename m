Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA157C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 16:09:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B312083D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 16:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+aYHCuj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B312083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34762 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYuxE-0007II-LP
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 12:09:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hYuvw-0006fz-3u
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hYuvv-0002Sy-1M
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:08:08 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1hYuvu-0002Oo-Sl
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:08:06 -0400
Received: by mail-oi1-x241.google.com with SMTP id w7so1976684oic.3
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 09:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=RCrQj0krm2kNPKkqyrPUmwmifE20EuBK4cG9t3ePcJ8=;
	b=B+aYHCujzYE8tNjRoxuOmoNZUJmP9oCAEGcER0wqTsOpzDGQMxKCS9QN97jc9VkDlk
	eqeycQUgonsRJCM1iHyFR65VeK5a7MCTZHiWomiRMy/mGAelREi20DAxL8OAouMBRYF/
	0xUNAvG2Xg4HL4bAOJzJsvMVH7O/0wygaGNw+sKBUoTg3g+3ODexd/AwQCO/Lbm/7r+S
	wn57Sx/NWZ+i5XWnn+RJXj+s5Hv0Y/cAq12aGwb8rizi3KETgEwQrcUdAgPGmqIjnfyA
	fnjuAiaWyY5h4wqwV+9uN9/B6xw7iOsd2dZWoAdkkZ21g06TU2SU/4T5aWz1PIcAH1n2
	/xjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
	:autocrypt:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=RCrQj0krm2kNPKkqyrPUmwmifE20EuBK4cG9t3ePcJ8=;
	b=m6tZR1qEJyJQkcRl9/pQcC0iPLJBaBOCR6TXrIKC5QsPw5+RtvpHxxg6cEOTOQ02M/
	tUDL5CLd+uVYnLGG/o+YSLMq3PHAQaB0jj9nyQV3qbzuzAfWeXdL6fgTs130SZSyyfBT
	FygeyaLVq6tNAAAUB9ppXs0SrAXqyFWWYspy9AOAk2Z+KxuUI49OQCuvYN4OC/JlFiV2
	RaeGJojsxDYVzvOsZcWNYmk0ibeXELFhQz+UBc6IhINU/GkbM+9kv2X6mFuhFjd0UL0p
	kYqV5naPNqP+v06l/JXHuYbBMZsv777S6sHNZT74GYPYfWZe0lVfVx3VMu5dkTsN1uik
	cMkA==
X-Gm-Message-State: APjAAAV/4YTidnBQnZgRbu9hOJiw1cTAzhkpjcE4RjJKRPemnVHrJHZa
	UKUgCFFKJ63g8Hp6ftF/ACw=
X-Google-Smtp-Source: APXvYqxltETSTCRYxvCnXfYudzGUxXRuI+h5VxMfhAB4bZUOnxwq0Q5j/H8qVn3X2uNn+OHU0nkOzA==
X-Received: by 2002:aca:62c2:: with SMTP id w185mr586882oib.110.1559837285388; 
	Thu, 06 Jun 2019 09:08:05 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86]) by smtp.googlemail.com with ESMTPSA id
	s110sm777367otb.34.2019.06.06.09.08.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 09:08:04 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190606154310.15830-1-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Openpgp: preference=signencrypt
Autocrypt: addr=rth@twiddle.net; prefer-encrypt=mutual; keydata=
	mQENBFGuLC8BCADcAoWcnW9lTsDMzbO3MBU+KbiGaj5JPatEUscRDkQYM2fyNjJp2tIWDK5a
	n4yngeXB3eX61WbYR3QraRK8mlYLGxyAdHMEQfPipbqf3TmN043fssT2bc82ApJcs1zvLYgI
	rhMht7Dck7A0wNC1jo+ZjVVFig5gDTN7gOzaAdBtV8tVNUddwkLzzaGpfihhSD6U46NdqKOG
	Wlnn6TrkMy0QGdQ5NaXHkRlUjnnUTSW/nKfoxD+EI+A9V4sYOd8mc/TL4aJh/i/AiU57eLbo
	n17uQI6/VTWDUWl8USiz4x9c8vmqlywLx00tAFxxoRWqk4KVJlj+Sh0up/D/sJ+vPpgBABEB
	AAG0I1JpY2hhcmQgSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+iQFBBBMBAgArAhsDBgsJ
	CAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUJC7UHogUCWaDNVgIZAQAKCRCtEnDMTdAnm9N5CADO
	cB8F/SudJ72IupxQf40hbJdBK176+gb3sHMsixyLtrU59lee+lIM1OZmlNjsnCYmiSnbA5ks
	Q7p0HfO7DgdmfLzcK6xsHZukqSZy5LByw348Y913ZyjOrJZFdPP7kDg1MnqRqH4+3ZdzxV4y
	eYBWFU9GYMIF06JbUubossOOO4ArNVZbnIPu8Vn2tDZVVqsCBqkoCSBMj519xrvyOu5z4mHS
	LkCglXmVDOXMbqLuNAC3rfNXSnyM4hYkLUyfALJlAAy1Ro+jUqYhu7XUFV/MiwRuFMh5GbtY
	Urkx7tqsWQXLT3GeDk/LqvpWJQwk4cHHckYjRih+70CHIenm81PVuQENBFGuLC8BCACyEx3x
	94HIkTX0CHu2sA0w75+h9wuoA8ggJ7+S4ri0y2YsijWad5TTt6z6MMiqxk9kSA5bppaj4HXh
	86hBF/dWCtMpNr3Rb8FNOKyeA/qkYHVD6HiAiw9c6D8Dr9hWmOk3/HSmGrNURxeUFOckDXsv
	I+yGGKBNshj59j7QZr7ZiuIi2rWlBL8dFN/OWa/o3x7HKsE4k6K8ngwvCKP/QbDLwLLBOWH+
	VEUtpyeyxTr3OJ47ECTxdYvXoAV2iJaKr+6doVQiiR5eVFiMYrUPUECJeolOCwqc/JlWE18L
	+PCAFaW1H+/mpPVfSpN4wnkJ5cQiQVB41IaCM4p20iRzx7ZJABEBAAGJASUEGAECAA8CGwwF
	AlmgzYEFCQu1CEoACgkQrRJwzE3QJ5s7rggAwABzDAGrZ6uWsMxg5PeiiAYPy6LBnCBJSpB5
	Tfy5jH8QTmLfXW+u4Ib4sWXG7PYNR7sIrtqUHjRqXLVXrSnBX9ASGcYw/Xil45khW6LsRpO1
	prHv9gkwQfa6fTiWXVfSfm2Nant6u02q+MaYtQpCVTiz/9ki4FfftUwUHFLU0MhIQogjd11y
	/E08RJsqBwaHQdt14PwU1HphDOzSkhOXRXQLSd3ysyeGUXvL+gqQoXl5XYdvk8IId4PoJRo4
	jcyJ4VbnldvXh5gdGhFA/f9JgkLk9tPW+C3wNtNWyRUq8azR9hF2fg2HJUf4IXQlIu8OOgh1
	VcROBqvtH3ecaIL9iw==
Message-ID: <60100f38-1094-733c-be68-751b9551a6e4@twiddle.net>
Date: Thu, 6 Jun 2019 11:08:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606154310.15830-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH] cputlb: cast size_t to target_ulong before
 using for address masks
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Randrianasulu <randrianasulu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/6/19 10:43 AM, Alex Bennée wrote:
> While size_t is defined to happily access the biggest host object this
> isn't the case when generating masks for 64 bit guests on 32 bit
> hosts. Otherwise we end up truncating the address when we fall back to
> our unaligned helper.
> 
> Cc: Andrew Randrianasulu <randrianasulu@gmail.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  accel/tcg/cputlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

