Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C04C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 04:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B120720850
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 04:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jfU4JmDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B120720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58776 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOER2-0004ht-MA
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 00:44:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOEQE-0004P4-Fa
	for qemu-devel@nongnu.org; Wed, 08 May 2019 00:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOEQD-0001Kh-Ha
	for qemu-devel@nongnu.org; Wed, 08 May 2019 00:43:14 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:46631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOEQD-0001Jg-Ao
	for qemu-devel@nongnu.org; Wed, 08 May 2019 00:43:13 -0400
Received: by mail-pl1-x643.google.com with SMTP id bi2so9273523plb.13
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 21:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:from:to:references:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=XGxQckPcguvPhvG16CMg92ycJMTyNIdamLdFKJKKK6Y=;
	b=jfU4JmDITOZrjp3nv9iUCFT7dxclfzWrZs8f7GXUy7rtKz7UcyyrK6FF4eJFAwvGUr
	PdNrqDkYKBSJRMIKmdTzhTK94Nutb46WOkeNaCo2nCbfvM3fJd+UGm638joxaB7WGcVt
	VBmWWeqnTLfjBrZvqTWHOIm1/NHwTcL9XIikGgi5MwFJP2JgHlEP06lmeRis0lRaYNSg
	8GgOqvefU6qZ6pxSfxh5clj70PNPJyGnsCxHw5qePFxM3y/8uH4tjJNf/uL55J9NkMsu
	s2aFDoFIzfYzngT3wikn1VUdkuUh3EpR+Ew/Vv3Y9c/TaAJyBHzQYmUYUU2DVg71HdeU
	r7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:references:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=XGxQckPcguvPhvG16CMg92ycJMTyNIdamLdFKJKKK6Y=;
	b=piEHCb2I81YgiT8qYEUO1GJasTuGjaEOQsBf+VdsRjV8DkVfMykvzpZ0ws3OTiPh2H
	6jxtOV9IqyG9Sp+wpWfoRnfPsoB9kxwTVmg2Xe+nJG2eoXcYmLGfdHzABNjfy3XojaYj
	Gy57Qei5mJZUYE8b7jFEdNqFBUUN41FRWFvBFTtgGwsom1rsZMn07zthMTWKO72RYN1g
	EmMd4yM1USg/v5B+IAhctFjvZGm5eLvY8upssQOFmejaPuG9XLbMNcwj/lpefdfEKleM
	idbojWZNjfsPikjt946qsxxSrqaI0J7BAnGQuxZTdxDjKHpro+ikt9ykz2n/n2EjMbq5
	71wg==
X-Gm-Message-State: APjAAAUZlfd7WPnp4mvzpsTGVUfxv/DH9PQ3eK8kWhgvmV70lXYTeA0L
	giz9ZwHwL7S7OeVL73uWPeBBCOy+wCI=
X-Google-Smtp-Source: APXvYqxYykfzy809h1XGGB0ck9wlg0f3AMiAWNVcBSudUqyXojq/JmAx/7FSKNKB00QZAmEDxEO07g==
X-Received: by 2002:a17:902:5995:: with SMTP id
	p21mr45012224pli.216.1557290591306; 
	Tue, 07 May 2019 21:43:11 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	f22sm20902694pgv.45.2019.05.07.21.43.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 21:43:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20190506173353.32206-1-richard.henderson@linaro.org>
	<20190506173353.32206-3-richard.henderson@linaro.org>
	<5f6eaa15-4a36-37c2-3199-0084178e9cfb@redhat.com>
	<c692a451-15a0-43b5-4255-37f4bce5cfe3@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9dfb52f7-af21-1a98-7ced-3494368f5668@linaro.org>
Date: Tue, 7 May 2019 21:43:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c692a451-15a0-43b5-4255-37f4bce5cfe3@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH v4 02/24] crypto: Merge crypto-obj-y into
 libqemuutil.a
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/19 8:58 PM, Richard Henderson wrote:
> On 5/7/19 2:03 AM, Laurent Vivier wrote:
>> This patch breaks linux-user statically linked build on Fedora.
>>
>> Fedora doesn't provide static version of nettle and gcrypt, so the configure
>> fails.
>>
>> You should update the configure for them like you did for gnutls in PATCH 1.
> 
> Which fedora?  I just tried fedora30 and it worked for me...

Nevermind, I see it now.


r~

