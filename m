Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0A2C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 17:58:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49333216FD
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 17:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yN1ogRDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49333216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51896 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRh7d-0007xy-Fq
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 13:58:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRh6I-0007G0-2G
	for qemu-devel@nongnu.org; Fri, 17 May 2019 13:56:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRh6H-00034d-5I
	for qemu-devel@nongnu.org; Fri, 17 May 2019 13:56:57 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRh6G-00033w-T3
	for qemu-devel@nongnu.org; Fri, 17 May 2019 13:56:57 -0400
Received: by mail-pf1-x442.google.com with SMTP id t87so4042617pfa.2
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 10:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=89p3MEjQyRXxQh+7i9jf5xPFsJ6tYQ4wIN+YB5No6Pw=;
	b=yN1ogRDVrp7lsVqEolc6uWJZx6v8s3gNuYQLS1dKkMYzkQNzJL2YD56F+JP0cs/7Qr
	zDE50sGKEefGGkRfi58conj3231wVZZAglKCGDyLGslWiBS/ygYfqtVXSnIurzT5Jdmk
	U3Qqle8l/2w0Gsj8Xf+W8Q3UJmYMbnYkZx5eIz0fD0gVACRG3T3561cgh9SESlmWHmHm
	MKjkZntDkFajKrJCCQTuettGcqirhG9ACm7LQf9Cxaq31xPuWK4E18TNJLRNNu2PPv/f
	/RfmiWgV+5pVAY8mIbPagywr5gk1HGA7N0hKOCGGoG2ob87NdOqVI7DGWd1HjILyAf5m
	hOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=89p3MEjQyRXxQh+7i9jf5xPFsJ6tYQ4wIN+YB5No6Pw=;
	b=nWt7zjed0KXL/c5YQcur48R57PEuLEzxeO3/YvvZg2gt6dWE88XBvAgMfcVUcO7+ho
	H3DPpgCsKBXm9g8chqEaRphzELXb9hkUMiM+FapJ8U8Mt3wu/qJ7dO1gKoVtRBDqr9cJ
	v+B4Tx081sW+34yIRezAXenofS7cmB+6CJE3p9Yn8H4tFdUfrIFn+peRiy/GSxyeS1NU
	7b3HCamPJvJMv2mgGCFF6bVIIpaWJQ1Pf+XhGUyateaKKlmZXFMqIKApY0E8R2/GjmKN
	r8wvZqVnho+fKY0lmUuOZs0KqL2pcaloLiQZxbgsPMxUv88VoUkL4mv1/raxnyW7M0kg
	m1GA==
X-Gm-Message-State: APjAAAWp7K5Hl0OegMkETyRo8cWm+ZRIr4YWXt9cBsf1kBtyHihTfE7g
	uJm0a8HPpny5MWeRT05L2Y/Mnw==
X-Google-Smtp-Source: APXvYqznboVUpCjwZdS5ogyOXImQOHUTZXorokDU+E7fNnSMp9HpUPvWb4qAwJ4qNyMLKUEDaoxzCg==
X-Received: by 2002:a63:7982:: with SMTP id
	u124mr57456111pgc.352.1558115815540; 
	Fri, 17 May 2019 10:56:55 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	d3sm11244514pfn.113.2019.05.17.10.56.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 10:56:54 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190515203112.506-1-david@redhat.com>
	<20190515203112.506-4-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <fd16fc6d-8fae-795f-2226-99138eb5fd2a@linaro.org>
Date: Fri, 17 May 2019 10:56:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515203112.506-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v1 3/5] s390x/tcg: Implement VECTOR FIND
 ELEMENT NOT EQUAL
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

On 5/15/19 1:31 PM, David Hildenbrand wrote:
> Similar to VECTOR FIND ELEMENT EQUAL, however the search also stops on
> any inequality. A match for inequality seems to have precedence over
> a match for zero, because both elements have to be zero.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h            |  6 ++++
>  target/s390x/insn-data.def       |  2 ++
>  target/s390x/translate_vx.inc.c  | 31 +++++++++++++++++++
>  target/s390x/vec_string_helper.c | 53 ++++++++++++++++++++++++++++++++
>  4 files changed, 92 insertions(+)

Like the previous, only with

static inline uint64_t nonzero_search(uint64_t a, uint64_t m)
{
    return (((a & m) + m) | a) & ~m;
}

for the inequality.


r~

