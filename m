Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B34C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:43:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC01426D4D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T49PllMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC01426D4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47078 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWlYk-0003en-13
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 13:43:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWlXp-0003EO-KS
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWlXo-0007qL-NU
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:42:21 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:32865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWlXo-0007pG-FN
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:42:20 -0400
Received: by mail-oi1-x242.google.com with SMTP id q186so8370261oia.0
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 10:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=gV+RmAZcw2oDeHbVLbdWqzWRkZ9dUoo/89zzC57XKJw=;
	b=T49PllMJVlxPplpuKOBxTETtJOCtNMjjwyeTtSN2x+Vi+46K272EluTl2qc+MaDKQT
	HCVoEbJESawnSp3c0IvV66rDrhVMUuxQlUZyHGH+p+oTX5ojtn/zRvyUiXEPs07WUAb5
	dnDvv+yFfWhOQS9U3SVdenAP1SqEGkGoPOk0UfyLSRXlNQavtyGs4TgsxrId7HPhpY4H
	/vnLUDEyr6eVKEqio1ll5pTH4dEaIsP9za+b6SCOj1CIY0CHocQvUApGmxCY7w++I+AM
	bZxhtQKHZQl4QOBACztNzGKHnY6cIM/t1dgQufNFFEa8fd7m0uJFQiY1s2CD7ucmUQq2
	Z1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=gV+RmAZcw2oDeHbVLbdWqzWRkZ9dUoo/89zzC57XKJw=;
	b=SQo5DsKbe/TGaRabPrt5UDp00WFDPCIkuU6EFCRrw6OoY2WL0ul2+Z1FQdxHkSzF8d
	wX5lLfF1sZ29LcrFZLKQz3djJyOOnZj5lHFJmBgVmnKh73sr3QesRi0IL08zqI7BhUtc
	YrDoJw10d85jWxdnCTkZta8xgY2fk3Tsc5dsUGuqRFv/2OZbGp/No4Gq+DQDz701p5Gr
	oIb+cQLJSgrrZJMG5XXuH+qJhm3RJalo1DG4/NsL3zvgvpeD9Dro+IGA1+l2awsxZtIw
	VmwijYxSRPbWIPwjBdR24drgtBd4BWLBaeU4K7YrahbTaqCjrt/5pPsFtF5FUnthXY1y
	ra+w==
X-Gm-Message-State: APjAAAX2NqZhj3tR4ko0cVmyp9ZhnogUe4VJbLKSsm5bZRwIK4dv0lrv
	g+KLdTlVxiWQ7aRJE3eI6XTaDw==
X-Google-Smtp-Source: APXvYqyi9MB2urcxVyEVZSnl81hvx7JycedWoWcQhKAZ93MHEinrE4eYZzdGhr555etBqBwfU/e9Ww==
X-Received: by 2002:aca:1014:: with SMTP id 20mr6616914oiq.105.1559324539107; 
	Fri, 31 May 2019 10:42:19 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	b24sm2261748oib.57.2019.05.31.10.42.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 10:42:18 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190531104432.29379-1-david@redhat.com>
	<20190531104432.29379-17-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <91a1c09a-63b4-8d57-3065-b8cad49b89c7@linaro.org>
Date: Fri, 31 May 2019 12:42:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531104432.29379-17-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v1 16/23] s390x/tcg: Implement VECTOR FP
 MULTIPLY AND (ADD|SUBTRACT)
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
	Denys Vlasenko <dvlasenk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/19 5:44 AM, David Hildenbrand wrote:
> +typedef uint64_t (*vop64_4_fn)(uint64_t a, uint64_t b, uint64_t c,
> +                               float_status *s);
> +static void vop64_4(S390Vector *v1, const S390Vector *v2, const S390Vector *v3,
> +                    const S390Vector *v4, CPUS390XState *env, bool s,
> +                    vop64_4_fn fn, uintptr_t retaddr)
> +{

Surely this is only going to be used for FMA/FMS.
Why not just pass in the float_muladd_* constant
to pass on to float64_muladd?


r~

