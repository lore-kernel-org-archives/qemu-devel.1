Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D85C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 22:03:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35A21218A4
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 22:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ecK/Kbh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A21218A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41459 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXv2p-00065s-DI
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 18:03:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hXv1r-0005hl-St
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 18:02:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hXv1o-0002Va-Bo
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 18:02:05 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hXv1k-0002IY-DC
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 18:02:02 -0400
Received: by mail-ot1-x344.google.com with SMTP id t24so3877392otl.12
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 15:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=BD2K04R6ognMju0dvvODUd67OX7A0Y1WekCOyzlgEzs=;
	b=ecK/Kbh4j9mIB+dYWe6aDjjblUwMfn4hi8KCXkGsfC8rvgHYjtt7CSIXSnIDgrZfTc
	3jv4eEdP+L9vdJ0nAbQzaitHAcSPVY1rImczfZU3mo1gQzriUxegr0LCm8A1JvyVJUPE
	n6h01tZUAsbE8RIWj/8aUlzXhFY/Y6NZJMo/JcSdxNPcR1srjmEqXVuLkDjZSDGt9MYx
	mFAJ5QsAHipM7Vtmyty7SWnNdcpQ6V33Stz5MxL5l5avmWCbdlDWHwaDze//dhu1hsBC
	RfHkF31QUgfQ57AYvt8B5Av4tV32ShI9M9cPGseywz/VhGV9JPd2YSmI0mnqMVAFvWj9
	rM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=BD2K04R6ognMju0dvvODUd67OX7A0Y1WekCOyzlgEzs=;
	b=iJZrZC7qG96z14xuAJQQ4V7GB8Jh+YLmRwoQ4XrXqA/+xwwxOoI7LUk/sEVWM28Gis
	Qmc+6E+gVA+N8sg+6PWWMd/nQ/pGu6L/+xrNssNi5Xu5cqOR1znmeJI0S6x6FsdoKe4P
	QbSfSqnVpbLFp/7Z1hWnvKUPeNNI3JBRvxKMkCqvPeXHFPsap8Bp2FSnUqJEJp1zSYWd
	z13TMrX7DcIZHzBV7nKVdOPI1+gmJZ0rG7z1dAXheBPIypxAEZbcpeJA8NDVHPD2l/3t
	Y06PGoJKIKecWJHv8EE+vmAxbu0U6cvrhH5CJ6/bxUuj5YcUEUloz8aSlC0OKk4Fsq/a
	d54A==
X-Gm-Message-State: APjAAAVJtntEiKgjpsrW3A48LqIEWlXp75IePxKxtyNsastJSpKtaOWs
	DUXbkexWqWSmQSbZ0jve5klPSg==
X-Google-Smtp-Source: APXvYqz8GXKGRHJdDVxcbbdHuUafjmgjP2uj6Ue8yfkmHxtruS5mm+oyIltg0JJt9nY8Z/L7YJkQnw==
X-Received: by 2002:a05:6830:1d5:: with SMTP id
	r21mr2940595ota.155.1559599319215; 
	Mon, 03 Jun 2019 15:01:59 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86]) by smtp.gmail.com with ESMTPSA id
	j189sm5582841oia.2.2019.06.03.15.01.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 15:01:58 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190603150120.29255-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e27d836b-883e-4cfd-69be-8977cc71d809@linaro.org>
Date: Mon, 3 Jun 2019 17:01:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603150120.29255-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [RFC PATCH] cputlb: use uint64_t for interim
 values for unaligned load
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
Cc: 1830872@bugs.launchpad.net, Richard Henderson <rth@twiddle.net>,
	qemu-arm@nongnu.org, randrianasulu@gmail.com,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/19 10:01 AM, Alex Bennée wrote:
> When running on 32 bit TCG backends a wide unaligned load ends up
> truncating data before returning to the guest. We specifically have
> the return type as uint64_t to avoid any premature truncation so we
> should use the same for the interim types.
> 
> Hopefully fixes #1830872
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  accel/tcg/cputlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

