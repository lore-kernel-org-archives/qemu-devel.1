Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53108C10F0E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 00:16:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF528218AF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 00:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YPcWtdQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF528218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44475 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF6Lj-00029v-NN
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 20:16:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6Ko-0001sS-F3
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6Km-0000WV-8P
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:15:53 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:46033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF6Kl-0000VY-Sy
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:15:52 -0400
Received: by mail-pl1-x643.google.com with SMTP id bf11so5839551plb.12
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 17:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=lfEIwY2INSg/GPC9+ZaBataOFpi7zHZRa8v8MlbOm9Q=;
	b=YPcWtdQWnbOs1WUDxr7mZzgJ1BbtMVwViNq5Uu5cjFKvGNVmo2e3WYL2238SmMmUSn
	5A8Vm9tuweE2p7qGjqGu3pADJKJtxlhHq8gQ8KwocVEdVbFvj3g7KNj+1cbw28QpfU5i
	31IHfdgAwO0jQNZI9WNtQMgDowAUff2nSyKPT1dRk+pZ8Va2ZZ2YZ9RaD85K8/tLH1K3
	nI1R+LQtryi8m5ROzg64lvCdJ9tOzd2qprhIVia/Sb5pqldlEzfAPNTx5VJZMJy2ozHF
	y4bbmLok2DT/OTtCqnzCwT0H+COrOQRtoZ1VhXFYCrZ4m66CXEDFAoYABjWAqSRwODU3
	TuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=lfEIwY2INSg/GPC9+ZaBataOFpi7zHZRa8v8MlbOm9Q=;
	b=PALylvjZitJjYNyHQJr5jcLqfiODGPmI9AkvfZYPCqjjYoDqN9gLTvV5jCJs0DDTNx
	ATBUAwfh4EVfd2jie6WRrVVTys4NNAcSOL60UvZ5tZ+XkqioFR/aKCT1SqNQvX1zXKdi
	oyx5uzO/pQJQfM2KsvgrxM7ohNp/41KCkIdHrhkcHmHKBhX/IllEuXDImNiuXbgpx/UI
	a9th9mhscPvyVGYO5/1cWgRWIiXJ0NxyR3tnIqzjYQ5sU8eW0gjoD0JzAjNlVlDMXFLp
	GfTUcMFVsMI1Jc5sbL0j7ao1PRkmCWdLECPYi4HmPyZNbw+vE+9yoOSZ+bakeKodsCFu
	cehA==
X-Gm-Message-State: APjAAAUcKEJt/pXkC+qjFeliceunibnprjwJlDw4XrdhC4ucAYQLUdCJ
	usyzAPNdEmA/HxcrUQ8zFlIf+g==
X-Google-Smtp-Source: APXvYqzPvJFBxDpJdSMuqROf1d/WJMGo0irUafY9ckOU+tcgY82FNd5gZjoD0JUa7DYMqcsIjiLZWg==
X-Received: by 2002:a17:902:9884:: with SMTP id
	s4mr60742613plp.179.1555114550635; 
	Fri, 12 Apr 2019 17:15:50 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	w23sm53425260pgj.72.2019.04.12.17.15.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 17:15:49 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-28-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0f53d073-92ba-87e3-2dd4-4e4629ead801@linaro.org>
Date: Fri, 12 Apr 2019 14:15:45 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-28-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH v1 27/41] s390x/tcg: Implement VECTOR
 ELEMENT ROTATE LEFT LOGICAL
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
Message-ID: <20190413001545.Gy0rC-IUmJ-nTRrekQOGQUM4QxAw0tkV6lNyhNc5aUw@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> +#define DEF_ROTL(BITS)                                                         \
> +static uint##BITS##_t rotl##BITS(uint##BITS##_t a, uint8_t count)            \
> +{                                                                            \
> +    count &= BITS - 1;                                                       \
> +    return (a << count) | (a >> (BITS - count));                             \
> +}
> +DEF_ROTL(8)
> +DEF_ROTL(16)

We already have rol8 and rol16 in <qemu/bitops.h> for this.
Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

This does point out that I should go ahead and fill out the
variable shift and rotate patterns in gvec...


r~

