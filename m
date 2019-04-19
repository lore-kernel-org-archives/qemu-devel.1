Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F63C282E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 18:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F863222D2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 18:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeduNxOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F863222D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59843 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHYAH-0004LY-36
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 14:23:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hHY9Q-00042O-JN
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 14:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hHY9P-0002dT-PR
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 14:22:16 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:46470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1hHY9P-0002ck-Gu
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 14:22:15 -0400
Received: by mail-pg1-x52c.google.com with SMTP id v2so559649pge.13
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 11:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=/Tm501/g3SBXAd2rUTgHxex51H6wSOc5e63Dn2ZJ7vM=;
	b=NeduNxOboazOR4t/lwfdUExCyt4GD6gzpI1q3PAqqLPlb3zJJmYI0/cCxXukkn3f9R
	Dhqem53Qo0WSJcYRLLic4r6Zvs+JuO0Txjb5Fn5G8KSU02otJMFJrE0I1ww6aLQ9aJCr
	53peI1gIUhqhBizzvW5Ay4ZUBgN6moKadb8T66CJ5fIxi2KMxHgG0n52a4aAqibg9qHF
	JqAQJ5y6okQpkpIFPrYRtwP314jxBFSEAUc9arwR5WY10iGXVtytfSAg/ZhFFu37Isyt
	WaEo17RUCAtoT67bSw7hFTkF97AwfmiqkOIB7BZocfaBVem3WVOt6gJ0m17Z3JKvVq/N
	/OOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
	:autocrypt:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=/Tm501/g3SBXAd2rUTgHxex51H6wSOc5e63Dn2ZJ7vM=;
	b=TbMs9VrVzf5LgdAMB7FWAxJdzzk2pitIOyrbS4w3XDyZQefaolMXuBVocP3nQhop3x
	+ILt1vSFCPIPq5YLGmUH3Jsn/e2Mm61738MC8zsVWNt5VdRVZovaZwGT9gzlYlSHXXsN
	4TpQ2id0lG3asHPJbFISK/JgFPrIdQ2+sHGkWhqTvs0bFSsDWSy72VU83thGAqSqVuXf
	QNW2960VgdNjcVbOv/Jtp4K6xQGHDJ//CuXUWufSkhEg6J1S+tPnk7EkCBpX7A1imXlW
	ifjT9sT4Mj3F6xf7MAjAOa3w4Zf1quwqfS8I4MYkSMMmaWE5m2c5ZJZV8h7Gfnl6dp7r
	ui0Q==
X-Gm-Message-State: APjAAAXV9uHLFriCvOMWCiWeE8wUkWg7qZBJ3u88+aEFD6EylRQly1Nk
	fYhRBgVxi7lCMyQyGseSJyE=
X-Google-Smtp-Source: APXvYqz7Kx00FvckzFclS3oY03m81h9r0WKOMpd5CZILAn35EWMnNWP7h04lrtH5S/a1lMNkyA9ADg==
X-Received: by 2002:a62:12d0:: with SMTP id 77mr5494465pfs.15.1555698133244;
	Fri, 19 Apr 2019 11:22:13 -0700 (PDT)
Received: from [172.20.101.138] (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.googlemail.com with ESMTPSA id
	y19sm8110935pfn.164.2019.04.19.11.22.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 19 Apr 2019 11:22:11 -0700 (PDT)
To: G 3 <programmingkidx@gmail.com>, Thomas Huth <thuth@redhat.com>
References: <20190418224706.14014-1-programmingkidx@gmail.com>
	<723372ae-a37a-d7cd-098f-452c7513ce8a@redhat.com>
	<4B73E5E6-2129-43B8-A35E-0CF7DCAE163B@gmail.com>
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
Message-ID: <58c00451-f216-610d-4c9c-7437fc07c5bc@twiddle.net>
Date: Fri, 19 Apr 2019 08:22:08 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4B73E5E6-2129-43B8-A35E-0CF7DCAE163B@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52c
Subject: Re: [Qemu-devel] [PATCH] configure: Change capstone's default state
 to disabled
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419182208.AHRR1WaKV7E7KyBsqZueML79wKyTjya6b43EgxU-hBs@z>

On 4/19/19 3:44 AM, G 3 wrote:
> 
> Here is the error message I see when compiling QEMU:
> 
> CHK version_gen.h
> make[1]: *** No rule to make target
> `/Users/John/qemu-git/capstone/libcapstone.a'.  Stop.
> make: *** [subdir-capstone] Error 2

You are configuring with --static?

I've seen this before myself -- IMO it's broken distro packaging, in that the
shipped pkgconfig/capstone.pc claims static library support, but the static
library itself wasn't shipped.

We should probably work around this in configure, and report the packaging bug.


r~

