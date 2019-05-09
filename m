Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBF8C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F0C217D7
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze0YLmR0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F0C217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58177 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOmam-0001Wr-OU
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:12:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hOmS4-0002Mf-M7
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:03:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hOmS3-0006um-Q1
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:03:24 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>)
	id 1hOmS1-0006tm-Uf; Thu, 09 May 2019 13:03:22 -0400
Received: by mail-pf1-x444.google.com with SMTP id z26so1636711pfg.6;
	Thu, 09 May 2019 10:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=IIuO5kDuhc+1kljyLHIpwp4aYnt0QxoweXrTUyYLx0E=;
	b=Ze0YLmR0td2vHu0oL1PM56kdXJiChCcmAr9bKQzUXjxZSo6y2BmN60KKXsy6b6gdFM
	sNid6lrruXvFIR4q4DQamak1F+1Trc+fIQBdmHfZe7m1KQv5HTKBbpf/sDf4/H4TC8K4
	GljQvm40WkC/9+f75fT5C7oCD79dK4LSv/qSijvmgIlLYRztsc2rhqLLWniUeFbm7l3n
	mj2LHbTIGO64Y/joaswwZPNB7HNordRPMDwcVDEVSnlzOVzO/DBcraqV1yc539sMgbdv
	fZkofFVii272dxIs2/jGRDqnfIlBgEiPyygESv27TzcEbXCTKF7H/TIYwnrNd2JUj+U/
	TDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
	:autocrypt:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=IIuO5kDuhc+1kljyLHIpwp4aYnt0QxoweXrTUyYLx0E=;
	b=pneX6+951lgIOF5fAAoBPGd6SkqFLibHqpqpZ74clRhFcohJyiSg4Esmm6i8YoZFaB
	k3BTgQNC6Yv0CgvuIfHjDGXS8D3lo6bzI0E5Oc86reXxI4lQ4oKBnZVDMV3BWjlTGEch
	JYOPIgkjdoe0XAuP/kG2wB8BdN3OmfPH/yYS0FMzHQTxFWFn1zU3g/Nk+k5GP2uj09he
	ZJVVmEePkvyrfU+QZEkbAsqyU2T/SNcjYHqwSse//FoOZoQL4hZ6OTkEZVvy898vSM2u
	zf39TUGLNndaVDxL7BrEgYbNU3fjVXsxlKTm4/4iEHNw2NBtlQCL2QksbOn4FrQUMl2l
	vX2w==
X-Gm-Message-State: APjAAAWW1cRDMhNiYIk5wrotEraGy0U4ou3XL8W9GP7+/U3Uy/FYnx3v
	BV4SdSP53oHpVEr9uHvubzo=
X-Google-Smtp-Source: APXvYqylwXxRxLhEqHkAQ2znYIVqOrIGWyH/7aK/puSfE3RASjQK1Jkqm7HoXMdzVptvOnVcpLr0Zw==
X-Received: by 2002:a63:b1d:: with SMTP id 29mr6993073pgl.103.1557421399819;
	Thu, 09 May 2019 10:03:19 -0700 (PDT)
Received: from [172.31.99.192] (50-248-210-99-static.hfc.comcastbusiness.net.
	[50.248.210.99]) by smtp.googlemail.com with ESMTPSA id
	l9sm2886206pgq.48.2019.05.09.10.03.17
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 10:03:18 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190509165912.10512-1-alex.bennee@linaro.org>
	<20190509165912.10512-11-alex.bennee@linaro.org>
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
Message-ID: <fa94b57f-12e1-62c4-e67c-f83667adea59@twiddle.net>
Date: Thu, 9 May 2019 10:03:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509165912.10512-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v1 10/23] tests/tcg/multiarch: expand
 system memory test to cover more
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/9/19 9:58 AM, Alex Bennée wrote:
> +memory: CFLAGS+=-DCHECK_UNALIGNED

I suggest -DCHECK_UNALIGNED=1 here, and elsewhere -DCHECK_UNALIGNED=0, and then

#ifndef CHECK_UNALIGNED
# error "Target does not specify CHECK_UNALIGNED"
#endif

Then you don't need conditional compilation within the tests as well.


r~

