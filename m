Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C2EC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 18:29:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E0C20818
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 18:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OWQeU9mD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E0C20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41063 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF0vq-0008OE-8s
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 14:29:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF0v1-00086b-9R
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF0uz-0007lO-Rq
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:28:55 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF0uy-0007jQ-8J
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:28:52 -0400
Received: by mail-pf1-x441.google.com with SMTP id i17so5536118pfo.6
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 11:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=u22TI8aGE201MHP/OXllpFEp709nPk7U1TNnoCoADKc=;
	b=OWQeU9mDrSJFyQqq6v756nVY5Cx6u9zSh3hLVxxJctxo1ceSg7qC9SlbVaBuTj/Ynz
	Nl7Na8Pkz+CO4Yr5F6RDv0loGBV0BgUZwo8KPgYM9FqbZbF+O75gT2+PuuvzxpDq8zul
	8ohN+8aQZpbMJnFppBFjuvR9G9fEbIewkXGdb9kWmnZe4x7YC2uhlLFhK0QX7hE158k9
	zflv3bdWmN7qXBEpj7tPHq/WMFsPS98D2m5cy8RCbFsN90xAAuvZt18D1kphdl5gBtkP
	z3Y4LNbF77Y6P9IUGsyt1Gw9mzejmH6ajcy+d9a8hYDrt4Bd+oGokxMJ0pqViJWteItQ
	g8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=u22TI8aGE201MHP/OXllpFEp709nPk7U1TNnoCoADKc=;
	b=KJLOl4fWFE6ISEQnGU0PE22Jo/b0fGdYWL1ZZ83em3pbxI7VTFrkYZmRh+5FStTGYq
	AmJEysJ5C1E1qMVF6159wiou0b/7C95CDY0PaOam4kD9b9etQL/KzH1Zk381t/sjS2Je
	/2az737sFUXUX0yMbTnonnwG+pnXTWMfQ8yZnRD36r+A8HwKHmrvN1NqLpw8SELP0qtA
	Y1vUaG/d5wxkqX2TfZk4kdup/Vn3Ip8xHy7jYy+Zudw4gt2frzuJSr4e8L5Uwnoz/TTD
	XTHg9stXDm47loTd94zbZvggj4NeFdMy/GCkEMLGxZCpaiAcFWIoz4+UBMvtOHSbAMVX
	tnAw==
X-Gm-Message-State: APjAAAWNSS1N9op6s9+OBMGHqvwhi2lxpiOAnSyXLdqyk3bHy+kH4MwN
	6ycz3HQKmd9a//bBDI1mzFzNpw==
X-Google-Smtp-Source: APXvYqywWud8DZHg5/saFB14ka+dSA0RhHm5aZSEAudQdGVtQlh0muVjwmPt9IxpAQ/Dlt7On7J/Qg==
X-Received: by 2002:a63:1a42:: with SMTP id a2mr52577290pgm.358.1555093730726; 
	Fri, 12 Apr 2019 11:28:50 -0700 (PDT)
Received: from [192.168.3.43] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	g64sm99069416pfg.13.2019.04.12.11.28.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 11:28:50 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-3-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5b6300d8-7a3b-7325-e79c-c2821a3b282c@linaro.org>
Date: Fri, 12 Apr 2019 08:28:45 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-3-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v1 02/41] s390x/tcg: Implement VECTOR ADD
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
	Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412182845.jhZAwBjNRTyZPO2TDPx7j7j8iWcB9hXbX5iJKvlDRzc@z>

On 4/11/19 12:07 AM, David Hildenbrand wrote:
> Introduce two types of fancy new helpers that will be reused a couple of
> times
> 
> 1. gen_gvec_fn_3: Call an existing tcg_gen_gvec_X function with 3
>    parameters, simplifying parameter passing
> 2. gen_gvec128_3_i64: Call a function that performs 128 bit calculations
>    using two 64 bit values per vector.
> 
> Luckily, for VECTOR ADD we already have everything we need.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  5 ++++
>  target/s390x/translate_vx.inc.c | 52 +++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

