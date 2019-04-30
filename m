Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDE3C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 12:27:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5FA32054F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 12:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BBdpcezs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5FA32054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46501 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLRqf-00081a-2z
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 08:27:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLRpq-0007kn-Eb
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLRpp-0007eD-DL
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:26:10 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLRpp-0007c2-4c
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:26:09 -0400
Received: by mail-oi1-x242.google.com with SMTP id v23so10884158oif.8
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 05:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=1tQgIbNeIsSj9GiWjCyjRxvGTeDFvxwuwkuRMlSypvk=;
	b=BBdpcezsKoma0IppOXHWDpazI9+IlAB7kZTOmrOZCwbT/TAxx5XBys7DEthj0nChAB
	qOq/UXslX8spKeuekJtWnVeJpSRiSVymsAC6OznIEnzKFdvK5vbrn+MbyUn3z9AonAn/
	8M+4eAuRQbyPAek0g5JbNX3YfmHQ/jWS8FQSR6p0+RBiAFn1bkI6gMZg6VGzBA9HUZJ9
	NzraE2c+zmGs2w6Gok+eOGxsE2JMQ235YonyzMkjT47shcckW+WcF+Zt2v7ZJwkUxjBa
	q/yD5LwnY+x/jjnW3+CvpfAONvPdW3x9ycez0tyNhSRU6R9+lZP2BBsGtrTBO1GAULdx
	nyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=1tQgIbNeIsSj9GiWjCyjRxvGTeDFvxwuwkuRMlSypvk=;
	b=ZapgOS7760Y+aXbBykTfPud/knIm3T86PbVF63bS0+ld5I+z7PdUqBiOVdmTmgZYHe
	h7fDnwbhUgqQSvdeQxJkI44gr3ExSOJKdcKsq+kmqxzN/z4XlSD6+xtIbfaXkCsQjNLA
	Trdux7ImTzTayiSql2sLHN3Zfw0FgwTcsFQBN5R7ilb7/kuc6Xq41Lx3HXdNGECirr0r
	lPqRuevougKu6NTuW21FQxMIFNd/EEHUSb8Z4Jt+r8gBLzJavSzNd1SxX67tGNo9U0xO
	7AtL3e15AvgcnzyR/qUE+JDPrSN8bWwuMGV26hR5FazBbfb9D0eMMyeS5q/bkz4OVYGa
	esjg==
X-Gm-Message-State: APjAAAVA2tlzPQ0ZvYbfbfn+UhzKrZMT4c9qmS1x81NT4Cu/QEt9xa1k
	QrlUrlYFLHDt58AlLNBrTesftRwIDMAa63wRkQIDeBAndQk=
X-Google-Smtp-Source: APXvYqw8R2KaMlAUvoyHPYXMP0p7706UC6afqP1P61nfiXMX6IIqqsXr59tCKuYZMK9atO7gZWPTPEJSMTv6wdDua34=
X-Received: by 2002:aca:ab12:: with SMTP id u18mr2571472oie.48.1556627167877; 
	Tue, 30 Apr 2019 05:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190223023957.18865-1-richard.henderson@linaro.org>
	<20190223023957.18865-4-richard.henderson@linaro.org>
In-Reply-To: <20190223023957.18865-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 13:25:56 +0100
Message-ID:
 <CAFEAcA81yQTHD=n_g9u0uU+d6PU4yJ2S+sFKcF0whYehRdEpcQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH 3/6] target/arm: Implement ID_AA64MMFR2
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430122556.PfYv0PhHnX7QBOCrAXxyFdYP3SUkSqjQyc7T79UVMos@z>

On Sat, 23 Feb 2019 at 02:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This was res0 before ARMv8.2, but will shortly be used by
> new processor definitions.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h    | 15 +++++++++++++++
>  target/arm/helper.c |  4 ++--
>  target/arm/kvm64.c  |  2 ++
>  3 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index c2899f0bed..02642a7db3 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -855,6 +855,7 @@ struct ARMCPU {
>          uint64_t id_aa64pfr1;
>          uint64_t id_aa64mmfr0;
>          uint64_t id_aa64mmfr1;
> +        uint64_t id_aa64mmfr2;
>      } isar;
>      uint32_t midr;
>      uint32_t revidr;
> @@ -1724,6 +1725,20 @@ FIELD(ID_AA64MMFR1, PAN, 20, 4)
>  FIELD(ID_AA64MMFR1, SPECSEI, 24, 4)
>  FIELD(ID_AA64MMFR1, XNX, 28, 4)
>
> +FIELD(ID_AA64MMFR2, CNP, 0, 4)
> +FIELD(ID_AA64MMFR2, UAO, 4, 4)
> +FIELD(ID_AA64MMFR2, LSM, 8, 4)
> +FIELD(ID_AA64MMFR2, IESB, 12, 4)
> +FIELD(ID_AA64MMFR2, VARANGE, 16, 4)
> +FIELD(ID_AA64MMFR2, CCIDX, 20, 4)
> +FIELD(ID_AA64MMFR2, NV, 24, 4)
> +FIELD(ID_AA64MMFR2, ST, 28, 4)
> +FIELD(ID_AA64MMFR2, AT, 32, 4)
> +FIELD(ID_AA64MMFR2, IDS, 36, 4)
> +FIELD(ID_AA64MMFR2, FWB, 40, 4)
> +FIELD(ID_AA64MMFR2, TTL, 48, 4)
> +FIELD(ID_AA64MMFR2, BBM, 52, 4)

While we're here:
FIELD(ID_AA64MMFR2, EVT, 56, 4)
FIELD(ID_AA64MMFR2, E0PD, 60, 4)

(from arm v8.5, see
https://developer.arm.com/docs/ddi0595/b/aarch64-system-registers/id_aa64mmfr2_el1
)

otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

