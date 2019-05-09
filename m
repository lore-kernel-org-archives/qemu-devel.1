Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278C1C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 05:25:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E389B20850
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 05:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t06gJ4iq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E389B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48154 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hObYU-0005ng-4Z
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 01:25:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hObXe-0005UZ-8z
	for qemu-devel@nongnu.org; Thu, 09 May 2019 01:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hObXc-0006de-Al
	for qemu-devel@nongnu.org; Thu, 09 May 2019 01:24:26 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hObXa-0006c2-KA
	for qemu-devel@nongnu.org; Thu, 09 May 2019 01:24:24 -0400
Received: by mail-pf1-x442.google.com with SMTP id z26so669587pfg.6
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 22:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=TwO1XdjLu0cPckJWg6jjFMvI8tBS6KkF+sYzzQQNuZc=;
	b=t06gJ4iq8uaSYAkI6x5WpMYGVG815QKHRid/sQD6nQPZ7RXPgRtdBxTQMx+J3TouO+
	w37YWQjPQBK1BlAyegA4sral0EKBfOWqYWisR/Gte/w2BrTRUj/OgMqQaVLM/Dx6gFje
	ULG7ayTlcC8bwhoggesnsshc6+Ropz6l/p0iUKMS2nN3uYe/V+WM42ApIvw+6AkHSlOx
	tKUqCsPlCdfeayqL4cXTGAcRjObFOP2FfIbDirlS0Cu2yhg7PCu38AjhuIf9bXBWXJbY
	bLEYAsN29M6nwh3sUycIyM3sMlWnH+finqC8lCw9k6bKsvwI7uzQVGGuDbdR8Z7nwaiQ
	GI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=TwO1XdjLu0cPckJWg6jjFMvI8tBS6KkF+sYzzQQNuZc=;
	b=USn2CPXSMJMdzYTdxuSaoLB6Ql4PvptjxLbgwtj+Zb6oKZENcUzpiW+JuFSv3ZTBgD
	OmVyxIqLjvRqAD+x1A+fll/xV3CQcumnS6CsUL7/p09URJ5vshzkjr53qSAFan2JuyIX
	4/18XWWD5vMw7tFr2De6Wf64acm4lbeRTZpqWP1GJwHP11bTpFxOhw52yh5e7Wkhbq1E
	xwadieFPa082ZJl8arH3eM9//upIvggoLeD/3gzochLaz+yRw4TpnCuWp1YGHD0IAsh8
	oDtlUcd8GGdnk3DbL7UE98C5K3tNTrV2b5EKfdsd8fjB3vGzk2w1qI/q9BRfnRQky6pA
	OV8g==
X-Gm-Message-State: APjAAAXjtBMswFWq6Q5GM33JQK9TpiqdfsqqNLM7SHW/0EoJSEmhUdYK
	VqwaXqt1TftL0yrYdKAgfO5ZlfF2meU=
X-Google-Smtp-Source: APXvYqzeLT32NUu9NhfvhypZIycwQh2kYlRTdW8yX5Y7atH0+K2nON4qbbY+OBv1/WRfgpXs0q8VOg==
X-Received: by 2002:a63:fd52:: with SMTP id m18mr3010733pgj.267.1557379460733; 
	Wed, 08 May 2019 22:24:20 -0700 (PDT)
Received: from [192.168.1.11] (97-113-27-95.tukw.qwest.net. [97.113.27.95])
	by smtp.gmail.com with ESMTPSA id
	q20sm1376547pfi.166.2019.05.08.22.24.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 22:24:19 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-27-richard.henderson@linaro.org>
	<CAFEAcA_TJJ7V3apxmGvhoiRk2dxzT77SapcyMuopGwqmeQoosw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b6518e96-e77f-8ae7-0890-091e42334a12@linaro.org>
Date: Wed, 8 May 2019 22:24:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_TJJ7V3apxmGvhoiRk2dxzT77SapcyMuopGwqmeQoosw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 26/26] tcg: Use tlb_fill probe from
 tlb_vaddr_to_host
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/29/19 10:41 AM, Peter Maydell wrote:
> On Wed, 3 Apr 2019 at 05:05, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Most of the existing users would continue around a loop which
>> would fault the tlb entry in via a normal load/store.  But for
>> SVE we have a true non-faulting case which requires the new
>> probing form of tlb_fill.
> 
> So am I right in thinking that this fixes a bug where we
> previously would mark a load as faulted if the memory happened
> not to be in the TLB, whereas now we will correctly pull in the
> TLB entry and do the load ?

Yes.

> (Since guest code ought to be handling the "non-first-load
> faulted" case by looping round or otherwise arranging to
> retry, nothing in practice would have noticed this bug, right?)

Yes.

The only case with changed behaviour is (expected to be) SVE no-fault, where
the loop you mention would have produced different incorrect results.


r~

