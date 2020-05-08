Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45171C47247
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1234C2184D
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p5myEHgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1234C2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX6Jj-00059J-9U
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 12:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX6J9-0004OL-G5
 for qemu-devel@nongnu.org; Fri, 08 May 2020 12:57:07 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34785)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX6J8-0000oX-AQ
 for qemu-devel@nongnu.org; Fri, 08 May 2020 12:57:06 -0400
Received: by mail-pf1-x442.google.com with SMTP id x15so668167pfa.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 09:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fe7KfmaG0NGarcrIZ/p83lG7wLhXQPuh/EAsiaozjiw=;
 b=p5myEHgIDdYLtInWTseIV5VQ1jkVS/mWjHZNqC5xH9myUBqVSyv4xTuouGImfrof7N
 oL4Fr4JRyUAzu90jVjcGI298qMMDSTqq9tsm7mr37QHTJhPHrP2cHwPnkrB/M7it5kwO
 NHSFdOqIGqenCC1cLXwF5bT7bi5aJAaDnyh36bzqdo5DYiFVdHN0BEt86nwIlJzhK8+U
 ByTTMCLoHxspaZlbJ2qNQEth+bMgT6ZU7fMzre3x4Bbv0S3D8/ZHIFqiF5upkTU3qm8y
 X6vhWo4wFxtTxPRIMDTByr1TyGveIVbfnNC9yy4W7gonu4UYU18mdzRY2E9+KDyVa109
 jIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fe7KfmaG0NGarcrIZ/p83lG7wLhXQPuh/EAsiaozjiw=;
 b=avshadTNEBJJSPgQfdyiDaeAYjd/uBzReRCEX1WWzPYFfjcik2EXNHAEX5N6HgKFTO
 I4jk4TNg6ZSsNHMflXmmLuq89VOGxbQsN5pciORABqkfFKzmOSMSjERu7Ykf6r2lMFli
 LiYNsvsgZaonkWPOF2ChHdQmvoisu7Yq4mtkosnjoMqK6xRwZqoQNnxVZrhbJ+GDaGGK
 KbXKrfZg7zzRg+MPKW0Hbq9oz+W3tndCu2Q0lqMxUdJ5Ldl+bqOnkn66q0o764KiT08g
 dY/5VR4N3GsWuiWmi8Q3c0Vbc9Lo4Ysrx9qMWAi82A4xgelZb7wWdzwVzwjD+aGoZSU3
 4Szw==
X-Gm-Message-State: AGi0PuYJSg4IHrvp3ivPG45FDstzyG7aKuugdT7Srfx2309El5T1hbd1
 y+TsSASqyJOiaAVQvmlnNPGE8A==
X-Google-Smtp-Source: APiQypIRGikFYfjVuW5TSR8/Ug24v8F32iBCI0G15l/BsQacAMLpXVBTdSCu+QLept6qHC9mcQ4ctg==
X-Received: by 2002:a63:3603:: with SMTP id d3mr3031786pga.101.1588957024586; 
 Fri, 08 May 2020 09:57:04 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id fy21sm2752245pjb.25.2020.05.08.09.57.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2020 09:57:03 -0700 (PDT)
Subject: Re: [PATCH v5 04/19] accel/tcg: Adjust probe_access call to
 page_check_range
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200508154359.7494-1-richard.henderson@linaro.org>
 <20200508154359.7494-5-richard.henderson@linaro.org>
 <CAFEAcA-9bd11QTUGYdta+pDRFvd-9qtiBiBCGUCCX7Mi+swQbA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <62eca244-78dd-0359-d82b-30089d893d39@linaro.org>
Date: Fri, 8 May 2020 09:57:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-9bd11QTUGYdta+pDRFvd-9qtiBiBCGUCCX7Mi+swQbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/8/20 9:13 AM, Peter Maydell wrote:
> On Fri, 8 May 2020 at 16:44, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> We have validated that addr+size does not cross a page boundary.
>> Therefore we need to validate exactly one page.  We can achieve
>> that passing any value 1 <= x <= size to page_check_range.
>>
>> Passing 1 will simplify the next patch.
> 
> It's not clear to me how it simplifies the next patch, though --
> we have the size right there in the new function which
> calls page_check_range(), don't we? So I still don't
> understand why we're using '1' -- it isn't allowing
> us to avoid passing the size into probe_access_internal(),
> because we need to pass it anyway.
> 
> We've gone round this multiple times now so I feel like
> I must be missing something here.

While probe_access() has a size parameter, probe_access_flags() does not.

For probe_access_internal(), I currently have a "fault_size" parameter that
gets passed to tlb_fill, which is "size" for probe_access() and 0 for
probe_access_flags().

I *could* add another "check_size" parameter to probe_access_internal, to be
passed on to page_check_range(). It would be "size" for probe_access() and 1
for probe_access_flags().  But what's the point?  Always passing 1 to
page_check_range() has the same effect.

I feel like I'm missing something with your objection.


r~

