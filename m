Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92981C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 20:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 604EB2231D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 20:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Juutc0uA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604EB2231D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWnIB-0004Dk-G0
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 15:06:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iWnGo-00037E-6t
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 15:05:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iWnGm-0005T2-QM
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 15:05:09 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37937)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iWnGm-0005Sk-In
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 15:05:08 -0500
Received: by mail-wm1-x344.google.com with SMTP id z19so704677wmk.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 12:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=04ci24EeRYTWH7l+QmBmuamObYeLeSO4tTq/kd8kSDs=;
 b=Juutc0uA2MATY3pl+UmG1kZ0IcIO1JSoZZ7QWztUJrLg+yn2pXTIl3jR7yLWhRfPuK
 3awv4TgjAKekPhaaGSI/pRrANfCfN+dmzSTz3UBR4z9zDTF5W7vy9l2Pt8p1XGNLXFBi
 Es6fh0aCXKALYqHx8CZPkfEUW3Eu9nIi3zmtGf1EHfE5ZKOnUTLv6ar49iP+ycX/2DlL
 gmPxlGFmWJMKPYiR3d0iGdEPq1FbEUTiw2zxxONkG5OcohaViYco+UN1tOagkiSjwJQV
 CPUBwkiUY9TmCw/ln4SZWcBW0ZGqedHSIBWMp+NO0E81ro6cFKp6fRZAxKKE2QH4AfBW
 oRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=04ci24EeRYTWH7l+QmBmuamObYeLeSO4tTq/kd8kSDs=;
 b=fUzPjG648B8Oz2bAo2svgNkStzMYBicDGaM7mXu1Te+Z9TqihBfCEQRyxkx5IcW0If
 s/vaR78FSrVWDrRAzAzAYdZ2wardMN5N79xFLmr/pcg17hvIZv+rxlVjgWum9s1XPddr
 xf1983GXjz1cKJUFBF3MZ2HE/a63Z12FVk1xmzo216J/85309SQGFgFUUU80mvgkNKsY
 PWp3+wUV3uUmSVHVnOvl3TiLy6OwCRMC3yKeANBKLeNac+rf1n8RS2EfWI1Nuj1Y9mKZ
 2SIUZ8ApLasjxaTEy2GbYfX0AsOVDG5l+z0BityB3Ivg8atWVnBoreqLOJnFzHI0kObM
 T+kg==
X-Gm-Message-State: APjAAAXKH0l4wVZECc41xJb7swIbatptYrmvW3g+PJOdSyVmgp5JMQTS
 xwCGLpeM42rEVvJg4w7N1B3YbA==
X-Google-Smtp-Source: APXvYqyIw08W2X2A4VGEmlaLo088ihUG1dFiZutCeBP1CYfOo6bmaZCvgdJEPNdohQD4WxJOmijMkw==
X-Received: by 2002:a1c:113:: with SMTP id 19mr1220652wmb.42.1574107507276;
 Mon, 18 Nov 2019 12:05:07 -0800 (PST)
Received: from [192.168.8.102] (65.red-79-149-41.dynamicip.rima-tde.net.
 [79.149.41.65])
 by smtp.gmail.com with ESMTPSA id t185sm500610wmf.45.2019.11.18.12.05.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Nov 2019 12:05:06 -0800 (PST)
Subject: Re: [PATCH 0/4] target/arm vector improvements
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191017044232.27601-1-richard.henderson@linaro.org>
 <CAFEAcA-36SCWn+FNgNiB_JbOJvYxpHa9S-gOVFH__xgGm2+cXQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9c88496e-ab0f-b0d4-d6e8-3380fb083f80@linaro.org>
Date: Mon, 18 Nov 2019 21:05:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-36SCWn+FNgNiB_JbOJvYxpHa9S-gOVFH__xgGm2+cXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/18/19 5:26 PM, Peter Maydell wrote:
> On Thu, 17 Oct 2019 at 05:42, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> The first patch has been seen before.
>>
>>   https://patchwork.ozlabs.org/patch/1115039/
>>
>> It had a bug and I didn't fix it right away and then forgot.
>> Fixed now; I had mixed up the operand ordering for aarch32.
> 
> Since Alex had a nit on patch 1 I'm going to assume you'll
> respin this series once we're reopen for 5.0 development.

Oops, I forgot about it.  Yes, we can postpone to 5.0.

> I think we have two plausible choices for DIT:
>  (1) don't implement it, since we can't make the timing
>      guarantees it suggests
>  (2) implement it but not actually change our behaviour:
>      this is technically a lie to the guest, but it means
>      that guest OS handling of the PSTATE.DIT bit etc can
>      be tested
> 
> At the moment we by default do (1). I think we should
> probably postpone doing (2) until somebody actually
> asks us for it.

Fair enough.


r~

