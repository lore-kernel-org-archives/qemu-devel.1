Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B32FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:53:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF0E020780
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qj3sHF8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0E020780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr5HB-0003rh-5O
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 15:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jr5Gb-0003Ab-2x
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 15:53:05 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:37216)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jr5GZ-0003jC-Bt
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 15:53:04 -0400
Received: by mail-pl1-x644.google.com with SMTP id p1so2440338pls.4
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 12:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rOKKa7aCMMhz8ioS6wm1/nU52Yfx62eaw+kbiU8ypKg=;
 b=Qj3sHF8L7xFovTyTB415P8bI+AgTy/4JXLMmDp+ecCsXNNuZITjfHRQp3GDxCphrF5
 4VOpMm/BMUieHzeEcxA9x3LU9Zkh4Q3rBrb2Q2iZQgpIWjA/HMhFQS3MR/ZQXk9r2tr5
 IWrATEijwFmV5VEnn4akdb+TLBaj1uaKU4MS0aJw8yKYXgkL8RKz7AwDibkesZn8hCbk
 AM/DDfEYg5orlfBcWUOb5ICzPTAJunWUkPr81axE7stsuW5MwxH8DC5HcUWvF6oZUfzn
 Cs4VuIPEI8+QREWmRkue/AIxyo9u4CPvywSgX3CfWaJgvMRO1b38fskklRRX2mS0vOst
 E3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rOKKa7aCMMhz8ioS6wm1/nU52Yfx62eaw+kbiU8ypKg=;
 b=ch/9Y5lXeiEA6zLZegFS8KK8al9PK3sNozR12HH6Jo61DbcA/cBVNVacgsYfR8LD0z
 V0f4imwsRHu/aNDm5ngnFawH4rLthrxFsoUinn/k/zcCpmOQdPNLqidJmfRRYFH0bH7R
 xJZQ3urrdLXbpLqhg+ZmKPEd8krdbjcrCnO+UTb0CDdSeboOnnRZE48q6hfCLDF/+Gzz
 kOThwmZcMMl5r7pQpcT5GNlV6T64UZeF5ptLywJLrA5FEmkIAimeJl+aa3GrAPofXClj
 F8Gk2AKVwHOb5ND13XaQXWP3GGMqaJ/cuvqmyXcepdlrfUBxSBDEs0O4jLjjuJXBeSly
 otPA==
X-Gm-Message-State: AOAM5306sO9W6hPQEBIywob5RTBo5sup0qUNHp2YaubfE50jXePBUXN8
 vDdEKWasAO3xYbik/xS5slnIxA==
X-Google-Smtp-Source: ABdhPJzusbbycFLyk1SKckwOgJaSEpmO2zdTt+NQOQqSAdZLYaxRWywDBFaCAwiYk2tgLn2LfLUMDw==
X-Received: by 2002:a17:902:a410:: with SMTP id
 p16mr27129185plq.283.1593719581750; 
 Thu, 02 Jul 2020 12:53:01 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id w4sm9563840pfd.39.2020.07.02.12.53.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 12:53:00 -0700 (PDT)
Subject: Re: [PATCH] linux-user/elfload: use MAP_FIXED in pgb_reserved_va
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200630103448.22742-1-alex.bennee@linaro.org>
 <CAFEAcA_vmcPq=LhEd2d5Kxyg-3q-VjYVa906EUempkXZ0cRXUg@mail.gmail.com>
 <87y2o4r4zc.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <09e88ba9-25ff-6f03-c216-2ce9e52abf04@linaro.org>
Date: Thu, 2 Jul 2020 12:52:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87y2o4r4zc.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 7:41 AM, Alex Bennée wrote:
> 
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On Tue, 30 Jun 2020 at 11:36, Alex Bennée <alex.bennee@linaro.org> wrote:
>>>
>>> Given we assert the requested address matches what we asked we should
>>> also make that clear in the mmap flags. Otherwise we see failures in
>>> the GitLab environment for some currently unknown but allowable
>>> reason.
>>
>> Adding MAP_FIXED will mean that instead of failing if there's
>> something else already at that address, the kernel will now
>> silently blow that away in favour of the new mapping. Is
>> that definitely what we want here ?
> 
> Hmm maybe not.

Definitely not.

> But hey I just noticed that we have MAP_FIXED_NOREPLACE
> (since Linux 4.17) which says:
> 
>    This flag provides behavior that is similar  to  MAP_FIXED  with
>    respect   to   the   addr   enforcement,  but  differs  in  that
>    MAP_FIXED_NOREPLACE never clobbers a preexisting  mapped  range.
>    If  the  requested range would collide with an existing mapping,
>    then this call fails with  the  error  EEXIST.   This  flag  can
>    therefore  be used as a way to atomically (with respect to other
>    threads) attempt to map an address range: one thread  will  suc‐
>    ceed; all others will report failure.
> 
>    Note   that   older   kernels   which   do   not  recognize  the
>    MAP_FIXED_NOREPLACE flag will typically (upon detecting a colli‐
>    sion  with a preexisting mapping) fall back to a "non-MAP_FIXED"
>    type of behavior: they will return an address that is  different
>    from  the  requested  address.   Therefore,  backward-compatible
>    software should check the returned address against the requested
>    address.
> 
> So maybe that is what we should do?

Yes, that would be better, because those are the exact semantics that we want.
 Though it would be Really Nice to know what's up with gitlab...

> Now you've pointed that out I wonder if we need to fix
> pgd_find_hole_fallback as well?

Yes, that could benefit from MAP_FIXED_NOREPLACE.

I do think there's a way we could streamline the 32-on-64 case.  At present we
are groveling through /proc/self/maps, or mmaping+unmaping, and then mmaping.
Whereas we could just mmap once and be done -- it's the 32-on-32 case that
requires the song and dance.


r~

