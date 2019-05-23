Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15686C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0D6220851
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RI5P7NQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D6220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35873 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTnWG-0001Dh-SO
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:12:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTnH7-0004CZ-IU
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:56:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTn2v-00082K-Ah
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:42:10 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33]:46794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTn2v-00081i-6W
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:42:09 -0400
Received: by mail-yb1-xb33.google.com with SMTP id z22so2186771ybi.13
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 05:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=4tzaZe6740sC9VyGw+sR5MurSVwwCuOaEHnaoiytpns=;
	b=RI5P7NQuyEdFvsNczDruBjwGO0oHOy7oBhKxuJm5uHB5hLw74m++Gwsi9CumIx8kix
	qiuga8yao23HauVAJ6xcQqhh0VEalk74H7LsYhVhs36W2uujahpMxhXFyZF3ePKVLw39
	3Vi2YMmL1jfFH/RWWgzFmUUHH68rBvs5oUyW7dZVijBTdYe9xAQiv1jWPZ7VHRafwF4I
	lMFz7UyyqVTAOZgEBXBYIAPIMzmkBwBR3P3rMGNzD8642Y0btfhQUmOD3VWSEuGpJsNj
	qDB8+7DALTcAzl/W0blhG5gDTICkVzaHxTUe9qeU0GuZHAInJmDbFcIP5kA/6CooPgrx
	cOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=4tzaZe6740sC9VyGw+sR5MurSVwwCuOaEHnaoiytpns=;
	b=jCNNCvazeU6OSQ3ncTjYnTjlXqMD4WUMYo4+yGDWi8bOmVYyEC3mkg+4ffYQZFq8yn
	GFAg8Kh+Hgx4AqlePSUn6G3aQhyyTwxvH8rAX5XCfM1MwI8bX97Z4mkrW+eH6VIYWbr7
	FIqhfoiwgJbb2+X5o3+DYI3APFT2arDV8mPqBPpXS79Ba0RmyOYxtDpkI21wQRFZ9Ejw
	pjZxVf+QXCSTypu8JRzOis/q4LpoU6HS/pX3+Vh8MQ7Ve3apzozrTgPY7H+TEuY/t/cH
	97BVn+ewCQyQsoGDPmFqFUkW3GXJzBnFV4g61/JwB5YxyUhNzv3NVIQty+QqQI8kvrq/
	o8xA==
X-Gm-Message-State: APjAAAWzeSTmPlo3hbpq3uKmcXstvtE04znjC94V4pAAA7kHiphRVqyH
	Ep+2LMB9iQuZFnQcIBZH06mXkA==
X-Google-Smtp-Source: APXvYqxIXbAB8K2xvwpR+kZROAUnZDtC09Jagjfe0M4w4JO+gyW7mVARaUr+za/sTTJ1t85hUo8jMA==
X-Received: by 2002:a25:2d42:: with SMTP id s2mr18339391ybe.476.1558615327915; 
	Thu, 23 May 2019 05:42:07 -0700 (PDT)
Received: from [10.240.8.143] ([71.46.56.63]) by smtp.gmail.com with ESMTPSA id
	196sm5738285ywg.103.2019.05.23.05.42.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 05:42:07 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190522222821.23850-1-richard.henderson@linaro.org>
	<CAL1e-=jzbtrbu6OnoAJ2Z7QyTGXfek4wFN-pzhQn9GJpXxLaMw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <aa495dcd-bd02-63ff-3db0-b3276e6f00b6@linaro.org>
Date: Thu, 23 May 2019 08:42:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=jzbtrbu6OnoAJ2Z7QyTGXfek4wFN-pzhQn9GJpXxLaMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b33
Subject: Re: [Qemu-devel] [PULL 00/16] tcg queued patches
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 4:17 AM, Aleksandar Markovic wrote:
> Why are “Reviewed-by:” lines missing from all patches of this pull request?
> 

Because it's hard to get people to review code under tcg/.
I post patches and wait a few days to a week and then give a pull.

This has been true since forever, when I was the only one giving
reviews to Aurelien, and thus wound up with this job when he left.


r~

