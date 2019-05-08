Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B0EC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 04:12:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B96D214AE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 04:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MU63An3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B96D214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58554 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hODw8-0006mk-Oh
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 00:12:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hODvO-0006Ti-Rg
	for qemu-devel@nongnu.org; Wed, 08 May 2019 00:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hODvO-0005VD-2Y
	for qemu-devel@nongnu.org; Wed, 08 May 2019 00:11:22 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hODvN-0005Sl-Sy
	for qemu-devel@nongnu.org; Wed, 08 May 2019 00:11:22 -0400
Received: by mail-pf1-x443.google.com with SMTP id e24so9766476pfi.12
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 21:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=EsvgpjsCuDLdHRvorBD5pbGKEopjanR0m9I/vibjsB4=;
	b=MU63An3aV+9mkpl6OzOtOMwsuTDm9nXrWmgh3zXnxpm997XXvUVmbvjBOjF1zDv9ox
	k2+jdASvSpP5OW3c/W6uUgvEeWsNCXWMSeBA4lsBtP+9jypHJ11GMQTnq3+JiSofGqfU
	NZP2jcfAbGRMoTArY8+3QFcJU6D1pTg8sh7Nj2bFTMFHSUGWsM98x9IqQvXQGwI0xrqz
	FylGd+rM4tXC7XnjHnRJ7AJUFzVAkYogbM2Cti8FGk/Y0t6A9KzzGN5ogVJRdoE1K6Da
	SXMdib+FGP80aZIB4gGwLFSpZJbMr0Q/JgOgJzgg0W/hxcYPSNKBk4jXbcdGGpQFeg5d
	UsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=EsvgpjsCuDLdHRvorBD5pbGKEopjanR0m9I/vibjsB4=;
	b=YAEm1TAVd3F5t99R4ykt1xHWRuGlugRncHAmCeXlgUifviepUFxHl9Z5iTZy5KDomt
	MYZEqFUw2fAWvamV+3OHZhKrGsqX8l8yrXr2NxtqLlAWI1mzoxAMAAh1WSugz7uxs0Es
	3OANUL5kWBcUNqsV73ycisydEAoNtP++XWOp82KNDnZau3/qe2HXJDnmsnRj64QyZhW6
	NHmooi8zkBuAnPc+SoPqFZzAVD3s0HbncNsidNHUxPHDaokeV00gDLuGS+HeHhT9JGEG
	3Zp3Iw/Ty2Kxr9vNgBZqp4AYB+ZYOJPBkTCGS7bL20jXSAC8MfOWcllOIroiiOS696or
	NACg==
X-Gm-Message-State: APjAAAX3Jjv9gj/ulylapxwb49uG9so4lkpcVjDbax3mv81Ny1UpYo1x
	uyGC6nM7l/L6YtJqoutucGPvbw==
X-Google-Smtp-Source: APXvYqzGo7uXIlOqdHt9zKD+NwKNHyWuyD+jwhOw34//btHCDJ8FS1xLjLYmk8DlvvUCdMV8yoi4yw==
X-Received: by 2002:a63:5c5b:: with SMTP id n27mr34310840pgm.52.1557288680432; 
	Tue, 07 May 2019 21:11:20 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	n18sm30937698pfi.48.2019.05.07.21.11.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 21:11:19 -0700 (PDT)
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20190506173353.32206-1-richard.henderson@linaro.org>
	<20190506173353.32206-14-richard.henderson@linaro.org>
	<c9f9ca4f-d6b5-0225-96d5-ebbb78c10c4b@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <7e900a3b-303d-8271-2f6b-199b09d75551@linaro.org>
Date: Tue, 7 May 2019 21:11:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c9f9ca4f-d6b5-0225-96d5-ebbb78c10c4b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v4 13/24] linux-user: Call qcrypto_init if
 not using -seed
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/19 7:13 AM, Laurent Vivier wrote:
>> -    if (seed_optarg != NULL) {
>> -        qemu_guest_random_seed_main(seed_optarg, &error_fatal);
>> +    {
>> +        Error *err = NULL;
>> +        if (seed_optarg != NULL) {
>> +            qemu_guest_random_seed_main(seed_optarg, &err);
>> +        } else {
>> +            /* ??? Assumes qcrypto is only used by qemu_guest_getrandom.  */
> 
> perhaps you can add a qemu_guest_random_init() function close to this
> assumption to call qcrypto_init()? So we will not forget to change this if we
> use something else in the future.

I'm not sure what you're suggesting.

Why would putting qcrypto_init within qemu_guest_random_init make it more
likely that, if something else within linux-user required qcrypto routines, we
would remember to remove qemu_guest_random_init and call qcrypto_init exactly once?


r~

