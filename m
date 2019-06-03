Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65251C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:26:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 145E4273FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RmMMNNyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145E4273FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39215 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXrf3-0007Mt-7e
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 14:26:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hXrV5-00082j-9N
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hXrV4-0005j2-Dm
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:16:03 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hXrV4-0005gf-6E
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:16:02 -0400
Received: by mail-oi1-x244.google.com with SMTP id q186so13599037oia.0
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 11:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=OVQKzPP3Dh0R+sR938iDr/HtlZw38Ct8+TwxZDTndLQ=;
	b=RmMMNNypM+X9S7yxNaM8i67Mexv6U0ulQAQz1AN9kxlq5rM4R/oNdj3PCzHFkEfYWH
	Agbc/blmfeujiUYVwLf6JVmWevbF7oZep0a8Nqtua7Q2v/b+TdMwBn8JlczU/RtevWVn
	awcYaTnwm9C7HnzQT69tPZYJGffXe0MsLxELJK5Wu4qm9VjRufdtD53G1DZ7AJsxeRp4
	KTchlpViGUGZhVSLxGo4tdVFRTxKJmMHLUcH4w8hUQhGUIb3yqJSoORunHH8a5z+lq7J
	zg4sGAe28lHqW5UlvfECYNQ8IvZKs4qQaA1lLCRtZpwm+Hs3Icywk83wFXucRJRsHNMd
	YSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=OVQKzPP3Dh0R+sR938iDr/HtlZw38Ct8+TwxZDTndLQ=;
	b=SaCkPCuLeuCtdUDOL0pGy+SxQy0pB7WcgqHtmcqSIecXtOHYeyTmB7yLTM6UQHDE0r
	CWQ/v8UjspPVrRR9SUPce7m9uSTe1hTKDNQ1XwNhvtQYInlhxb9d/X+COrq0lNNgV6+p
	UIDXXTlY2j0g4jTDQ2/zppjcPoaCqbbxGDsHR7QGSmJEe6WMVEC23i/OfsslA5EOpi0R
	ufhMytygEMi7t7coPCmQoLcOxjMpjMbC8mLp6E/Xg4ORT1XbQ2loEdpI1GEx7KbAGQLI
	C4xmCuFwXqFnnNLE6POZcLo3LQHaaPuEbW77thHXfw493wF3EGM5pbS2ylktmGW20KFp
	+Fpw==
X-Gm-Message-State: APjAAAXuFLFRK+2WwwwaOAf94I+5uas/L4Az3aOygCrPKVoDaLxaLRvk
	pQ8waDBpBhbIFleWwlGvwOXJIA==
X-Google-Smtp-Source: APXvYqwyQpHPH73O8OZsGDlEzGc3mrdZrErg4SFKxfE3+RioeJNFLUpiwtooMV3lEwGl5ErXFFRqJQ==
X-Received: by 2002:aca:fc8d:: with SMTP id a135mr1861429oii.145.1559585760708;
	Mon, 03 Jun 2019 11:16:00 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86]) by smtp.gmail.com with ESMTPSA id
	c125sm5535852oif.17.2019.06.03.11.15.59
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 11:15:59 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190518191934.21887-1-richard.henderson@linaro.org>
	<20190518191934.21887-3-richard.henderson@linaro.org>
	<CAFEAcA88nA_2u1Yc-9ZPAy2w6LVk5f9Rrss0e53E11W4Xb4YpA@mail.gmail.com>
	<e177b43a-2abc-3aee-461c-2cfd9a8a0a20@linaro.org>
	<CAFEAcA_1XuWqVu9gonn5_Y9x1V=UcWNHEXtwop2s0qyUbwiZpg@mail.gmail.com>
	<13d9e22b-4ac5-fb87-622c-a99b5494d06c@linaro.org>
	<CAFEAcA--wutvPH5xSRm7yNCQ9+TpjJ84qbSLTUa7YFgKnLmi=Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <56471d19-7c58-3790-84d6-e7b60f8a3b8e@linaro.org>
Date: Mon, 3 Jun 2019 13:15:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA--wutvPH5xSRm7yNCQ9+TpjJ84qbSLTUa7YFgKnLmi=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH 2/2] target/arm: Use tcg_gen_gvec_bitsel
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 8:30 AM, Peter Maydell wrote:
> On Thu, 23 May 2019 at 14:16, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 5/23/19 9:08 AM, Peter Maydell wrote:
>>>> Because the three different instructions perform the same operation with
>>>> reshuffled register arguments.
>>>
>>> Ah, so they do. Next question, how do I find out what the
>>> order of arguments in the above code means so I can compare
>>> it against the pseudocode expression we're implementing?
>>
>> >From tcg/README:
>>
>> * bitsel_vec v0, v1, v2, v3
>>
>>   Bitwise select, v0 = (v2 & v1) | (v3 & ~v1), across the entire vector.
>>
>> The "selector" is second, the first input operand.
> 
> Oh, this series is based on another patchset.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

The prerequisite for this patch is now in master.


r~


