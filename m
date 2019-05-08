Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FE7C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 17:49:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2118821734
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 17:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UWdAicsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2118821734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41050 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOQhK-0004ah-BE
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 13:49:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOQfg-0003iK-S8
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOQfe-0005cG-Lg
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:48:00 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOQfd-0005bS-Dd
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:47:57 -0400
Received: by mail-pl1-x644.google.com with SMTP id y3so10282617plp.0
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 10:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=cjdS/iI/gWEaK9rWXHcGPI8xgjgbFsWcVpG9/iPIp2Q=;
	b=UWdAicsVFEab5M1waOBLO5bGjcSCSkAxQwwI5bVMkp5DJbn5pTV/8JQ7RHN5eqr4iG
	hC5EdJJ3JGD+aP0ypv9mJHJhMfmbZlJ63A9j2n1oCVR1Zid6zB4fakRH+kXBhlDIyWJQ
	EAFDb7Yin67TxUD+g1rm9WWZDBtZfpWbQ+YJ2TbXpqr7YtCqf1xBWVB+7p2O76b9Dcqs
	TpjttZTDMTCjXGiIDXFcWK0cXAUOI5qi0GngbdNkmxMsrQc7oWqBn2XIWSTMvo6GxgFP
	lz1AzGE9fCJOPvhktmwfEfmu66p8FI2wRPcDNRtRNUmQSPnUxOa3AWjW+hZckuMAiD5o
	OtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=cjdS/iI/gWEaK9rWXHcGPI8xgjgbFsWcVpG9/iPIp2Q=;
	b=NXz0Up+/O1ErwsA8F84LDeXr+TxsTGW/puHfk9Lsg5M6nfiKySGy6oxQuf4frI7hZj
	NuKRDcOBbNvniKhRcECnVzJTjw3OsGckNrP3zd9rTDBmvTvtdBXf8P1xL/c5ViLE2ntc
	p/1HAIuPkZITB0sx8rstEt8VxXZg/ESXQ31Kc3VHLrLPzK4IVbSQ17HuyJhezEu9Vr6D
	7L+5K0s85cOc6EXdGpHouFeUSVtrTdsMaPfsYqkFaUAPGO1xEfG6puJim+HbBq8k9Byi
	MnkyCsrbLBwvZqxoomzRqkP4nFrHCk87KATubaQK/H4WJI3UsefMgi08O2ilbkvzXO3H
	g2JA==
X-Gm-Message-State: APjAAAWbI9Pl9cuHsJ/TMNJPeCq7hWMf2/ONpUz1AzSSNTaET2N0MDkE
	vu/UZuXQZzoB/dT/0S/8UiD84A==
X-Google-Smtp-Source: APXvYqym5uIZGg+r5HpNcu8VIZYcZJwEdbZ2B2gf7B2+rFT2U3q4JEUj0L5zu6IvQciZ+59AE8ml/Q==
X-Received: by 2002:a17:902:f208:: with SMTP id
	gn8mr9960720plb.312.1557337675809; 
	Wed, 08 May 2019 10:47:55 -0700 (PDT)
Received: from [192.168.1.11] (97-113-27-95.tukw.qwest.net. [97.113.27.95])
	by smtp.gmail.com with ESMTPSA id
	e6sm26615975pfl.115.2019.05.08.10.47.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 10:47:55 -0700 (PDT)
To: Jonathan Behrens <jonathan@fintelia.io>, qemu-devel@nongnu.org
References: <20190508173835.14528-1-jonathan@fintelia.io>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c8e5df4d-f149-2f6a-8045-be2bf4de6e04@linaro.org>
Date: Wed, 8 May 2019 10:47:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508173835.14528-1-jonathan@fintelia.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH] target/riscv: Only flush TLB if SATP.ASID
 changes
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
Cc: Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
	Jonathan Behrens <fintelia@gmail.com>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/8/19 10:38 AM, Jonathan Behrens wrote:
> There is an analogous change for ARM here:
> https://patchwork.kernel.org/patch/10649857
> 
> Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>
> ---
>  target/riscv/csr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


