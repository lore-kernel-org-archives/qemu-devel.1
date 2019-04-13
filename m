Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85392C10F0E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 00:05:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43BD4218AF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 00:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ip1rzUH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BD4218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44332 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF6AZ-0003Rb-Pt
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 20:05:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF69j-00036G-C7
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF69i-0002LG-EE
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:04:27 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:41255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF69i-0002Ki-4P
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:04:26 -0400
Received: by mail-pl1-x62f.google.com with SMTP id d1so5847249plj.8
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 17:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=YgNLTeTgNz1O+uIzOet/75tJGYv9CrUJsf+h1bUZY4Q=;
	b=Ip1rzUH8MPTpIQgNdP8HXbwAeTez+AX0S4zF5CdJ1nSMySHswXLmKZ3aP/q/y/B3YN
	D0VgGk/OuKceR/T9ZpHy2T0iRv+3QiE80PQBX0ep1KTCBKepgvVyNdd1iZMwXi3PYD6f
	1k8cxEoUWOzYFnuy8O27N4eF9aWVCCWUqauP9i7UpGFBGG7KJ4wMWpciZ2DMSvxnRK+z
	jEBEZEcpWFnrOyWqgikUuYMK7NaKVVDCY+VRL28WkYgKvdDNcu5liOJ+0Y6pCRa6fYdJ
	RCwjTBUpXTJ8q2Cuo/e+8+wKLXNHYJfoc5gPCKUTyncS0RR7R9k2Ja+Q+p52eMKCds7b
	Ujjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=YgNLTeTgNz1O+uIzOet/75tJGYv9CrUJsf+h1bUZY4Q=;
	b=XTDTkGOZJSWcFWZJDZipT8kW0M9M/tr3wp2O00EU37JqKijaieCudMfyBD8PW4qWDi
	CU/EIiNtGc9Lm+Ipy6WgLOmwiDBMqWM4aVrmtsIz0zjqDRec6jaMv9cBbCgtPhovbTUS
	/fCcS+6lKcZK4Wku8dSVdegJ5dn/z56VGhP/1utJJaUmKLuu7lW1Ue+x4+UiK2Y0Qm4N
	zD20/K+aIjaN0OAE0JCYZ8ON58n8GX9T2o8i4KF900BWa+TUSiVhqxQELmeOsvSZRxC7
	7H/9Q6sQoRpxRsR8frXd1yZa/Rgl9eVvIxAZ6TIR2SRL9OpocyDViYMpVPuy3xwqPLeV
	qFCQ==
X-Gm-Message-State: APjAAAViUhI7SX7KFsxvb7/j5dw3owAh1K/9fBG9Xh7Ba2MpIHloLzk2
	wto3i/R/86PFHkjrMxIlyJnJlGVDn3o=
X-Google-Smtp-Source: APXvYqy5mfOZfbKX7q5XT9ZLJyi8pRV4oxhsAJMS7hytdFjy2dmfi4yobsUMK8lZ8mpktyEDyvk6Dg==
X-Received: by 2002:a17:902:ab91:: with SMTP id
	f17mr56510060plr.151.1555113865033; 
	Fri, 12 Apr 2019 17:04:25 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	j22sm57283271pfn.129.2019.04.12.17.04.22
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 17:04:24 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-21-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <940b3c42-5225-c8e0-41be-5ee0df498f39@linaro.org>
Date: Fri, 12 Apr 2019 14:04:20 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-21-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::62f
Subject: Re: [Qemu-devel] [PATCH v1 20/41] s390x/tcg: Implement VECTOR
 MULTIPLY *
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190413000420.-AKXPUJiMGAxPb9RuD_44_GPBXtPZw3W-dz4JAKDGCE@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> +static void gen_mh_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
> +{
> +    TCGv_i64 t0 = tcg_temp_new_i64();
> +    TCGv_i64 t1 = tcg_temp_new_i64();
> +
> +    tcg_gen_ext_i32_i64(t0, a);
> +    tcg_gen_ext_i32_i64(t1, b);
> +    tcg_gen_mul_i64(t0, t0, t1);
> +    tcg_gen_extrh_i64_i32(d, t0);

This is

  tcg_gen_muls2_i32(tmp, d, a, b);

Similarly for mlh w/ mulu2.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

