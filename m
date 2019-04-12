Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5680EC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 23:24:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14C832084D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 23:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WT1KOQwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C832084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43979 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF5Wz-0000dJ-4X
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 19:24:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5Vz-0000Bb-PA
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5Vz-0004lx-1T
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:23:23 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:43558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF5Vy-0004ld-MB
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:23:22 -0400
Received: by mail-pl1-x62b.google.com with SMTP id n8so5802377plp.10
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 16:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=THr+t9qDMsbajnAaRcB+I4/dYxVHLso1zigBC/e7ekY=;
	b=WT1KOQwUzLspGbqXyRu01q2EIR2mirqRyiO+Z7g66tgx0dWcLOqyW79yk9JU/U+SP3
	eD/V8df6n0vSq1otoX9m7fGTzZnp99jlgkF1VWQ5TI9N0pQjt4EYroOEdVYi3FfJll9O
	VX1o3cpNrp5t8Dj+VWDVQKq14XUIRCZCfsGnK1ch5Bs7tnXHq4cvL4uAl/3fZnnLzgkx
	uOwigR5/bOII1PouRS6FbMuZzn33Hj0TIQCLj4VJ6eGWHob3hYR0T0p7TNpw5IJXocyv
	sA6VnK9Xw/xu09guAo6eZy8VIJ+gBWj48zFWpkvMkXTU7lrdiwduj8gvpnYZ9/T5GABo
	QRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=THr+t9qDMsbajnAaRcB+I4/dYxVHLso1zigBC/e7ekY=;
	b=tRlDuFR6QPQzYYK8kwiMiRbnnZhSOVipgzPvSEPOCCueO8Ru4gfK8gWpLmIxTg9aVV
	VdIogPxS8/VT3Cz01yk5f0dto3USIygBil6uRt25cethv90zw2FzMTyabFkv1eWJa88J
	XAm8b9Ya8SNli0o0RUbG+1dOfW9V3UILn8SiMn+KsLrIgpPw1B7E9PWAzaGDIP8E6Z5U
	59e0elQhTkChdT4uG0psy0+B71zWyrCbBHHYSz81rbH+3r0kyGsqUXr9LQ/huMWI0wcu
	oCmh1X1Sp2Rgs7MUcVhrIkgJYyd/rOvi9wALMyLe9niMr6Hqh26bMj8De+KhMakviBPh
	Cj6w==
X-Gm-Message-State: APjAAAVYOPs0XLndCOeqCIC9cxAAJidLVnsytmlQmwaEJe7iRWfXvyjP
	IMdujETZUF1GoWytVguK2h8dWQ==
X-Google-Smtp-Source: APXvYqwLKDRNlX6upp4hdaTbyduaRDHplSJZmg0yusQ4J8T6MEANJG9rYdqAlkRRhL/QOsZ6wbW4+Q==
X-Received: by 2002:a17:902:f08a:: with SMTP id
	go10mr58290563plb.121.1555111401668; 
	Fri, 12 Apr 2019 16:23:21 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	r76sm48065603pfa.39.2019.04.12.16.23.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 16:23:21 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-14-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <fb483994-1809-d628-df9b-983736c66315@linaro.org>
Date: Fri, 12 Apr 2019 13:23:17 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-14-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::62b
Subject: Re: [Qemu-devel] [PATCH v1 13/41] s390x/tcg: Implement VECTOR COUNT
 TRAILING ZEROS
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
Message-ID: <20190412232317.YTnH-SDMjWtTaScfhYh2Je5T_67q3IBdaLRDD0jQ_U8@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> +        s390_vec_write_element##BITS(v1, i, ctz32(a));                         

Wrong result for a == 0.  You need a ? ctz32(a) : BITS.


r~


