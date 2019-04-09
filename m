Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D573C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 19:04:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E26E020652
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 19:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DqF2zQIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26E020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47831 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDw2O-0002DP-7k
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 15:04:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDw0u-0001Pk-Rl
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:02:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDw0t-00030n-TX
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:02:32 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hDw0t-00030F-Dq
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:02:31 -0400
Received: by mail-pg1-x544.google.com with SMTP id e6so9846764pgc.4
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 12:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=8YPl59FO21z3qWLs3+gN+4LhT5EMXF1dhnwBUjHUAJQ=;
	b=DqF2zQITLEprALA8fcGyrhASUImY9oSq0E4vXsLQV66eaRtX/0xs1DwOq3SvSZmXIT
	M3y4qq6IK2hU4UjziF93RTmoOx7Nillmo/Hd4L/jZ9T08kxnVrkoKIGZtBuh90F7GHyc
	MsM2aFm5z+dCxaGrQ+JtUUo2cUmNTV/aHxwy7Pzcxb4UQV5r3I5o8LbMAMmR3mL4l8AD
	3pX2aZICV7wA99Swb9xX+ED+sJYor+eEGZVDPG9zGup6oXgvKorvp1ynzIU4aOLwUIu5
	BhLMRwzvdy9APakNwbpXMqIdbbebKZek0WEr2cZtAfgateAW9nG5St2hST2nNM8TbX85
	fOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=8YPl59FO21z3qWLs3+gN+4LhT5EMXF1dhnwBUjHUAJQ=;
	b=ev5u9tD5FEccay1AVsy5c+dMMYs+RvOXqtTzNmRugeSZUsbEX+9OKu9msf+sZbU1E8
	/xKv1smpGVgE3dFCUNcqHERES8G7MrM9SkMBBnORfyvaSz72ihBEXvNuvyfHJJK+s1oa
	Ytruxyknv03153s3d3vz+KGyETQOtn05FDzR6JNdiNm2FcTlxoYxqUOlAMv4srsq7TuV
	M/V8dYYSgKtLPDrT6k8zXPhMQAeixw3Yb8tHkyGVhQoeg+boLuJceQWb4th2xGw2Nwm3
	tW4LYGtlkletu1u/Ev6IaEPWv42skyNc7Ahj/6xKyo1FsZQxSZj3a5paL2dLcdk3Zoo4
	r+LA==
X-Gm-Message-State: APjAAAWQOcDmPx3QRRZGskq9VmV7fNf3j8yYKHsUoJGABmpUWQ/R9pQw
	04IeJeYTj0f8qPbv+SyvY0ZFrgLxlxw=
X-Google-Smtp-Source: APXvYqySfWNNPlHOuXXRqzUzGPCUQQeJztVD7c9LHyjZGSlCXxqjc/t4bvbbPXVzWNJil2FnPIKqUw==
X-Received: by 2002:a63:dc50:: with SMTP id f16mr36104714pgj.396.1554836548329;
	Tue, 09 Apr 2019 12:02:28 -0700 (PDT)
Received: from [192.168.3.43] (rrcs-173-198-79-114.west.biz.rr.com.
	[173.198.79.114]) by smtp.gmail.com with ESMTPSA id
	x5sm18532799pfi.91.2019.04.09.12.02.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 12:02:27 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190307144126.31847-1-richard.henderson@linaro.org>
	<be62e92e-de46-b3a5-9945-a410049d25d5@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d4fc4ba0-bbad-b64a-ad5d-1d964717b749@linaro.org>
Date: Tue, 9 Apr 2019 09:02:24 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <be62e92e-de46-b3a5-9945-a410049d25d5@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH 0/9] tcg: Add tcg_gen_extract2_{i32,i64}
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
Message-ID: <20190409190224.6XcKq4Tp7MXQm9xIhv6wZZ7tE3AETEW7UgMSRn-rZ04@z>

On 4/9/19 8:53 AM, David Hildenbrand wrote:
> On 07.03.19 15:41, Richard Henderson wrote:
>> The primary motivator here is usage within s390x,
>> but (as with any good primitive) the opcode has
>> applications outside that.
> 
> I am planning to send the next big part of vector instruction support
> (Vector Integer Instructions) soon, that would make use of these patches.

I'll be sure to get them into the first pull after 4.1 opens.


r~

