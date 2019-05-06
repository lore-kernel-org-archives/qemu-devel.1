Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0265C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:03:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68FEC206A3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ygf9CuHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68FEC206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59474 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNh12-0000fZ-LV
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:03:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNgzo-0008Ur-Ap
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:01:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNgzm-0001L6-9j
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:01:44 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNgzk-0001CQ-9A
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:01:40 -0400
Received: by mail-pg1-x541.google.com with SMTP id h17so774289pgv.0
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 10:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=SgdUitKC2b2+JMr0kV/7R6x43dHiLymfdt3JRDsxb70=;
	b=Ygf9CuHXCl80AbAitj+2wtGvrLHJ8nRV6dkxZO07apPkWp0y/sO4+eaj1ygqJjlULy
	sBm9SgG3XqHe0j8Q09eisMm6UIZA+QPLfQ2n3TI3nLhyrjzWZjEFvR2FQW2ATeWxe1tl
	KI5WVKxHExjPKhU27PPKfxi4QDFI3mPd1YXrm0XzUK0RWsBQhns2fk51bwaEJCjtGNX1
	1ICl8WqyPOhMdJNB0ZJhuAkvRcGBqURYGhEpIfDIaDoBCrkFzR7+YwUZOxsxxuNTQvLH
	nnlSwVofEY8v3N0j4Do8GHMd4BWUSK7TdMaNrH9YxvM6w7OQJmdl/yS8n4tWOehg1+nD
	YYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=SgdUitKC2b2+JMr0kV/7R6x43dHiLymfdt3JRDsxb70=;
	b=a1YP3iV2qXmM5pTe1m1Xmw5aPByiQend2OfMAPdVFaMlDXyY4w++jlIZ+psiB7+V+P
	6yYUTemQ7+YjC3LKju63ig8qPVVVpIxydSJtcUdDsCol15GUeskriiyArTC7OZigDERT
	jOBaJQjuKdiVhPpiZoKN1/pENq2c4f301MXqbG+BqQS9dil0msRjDmFbvae8K4GP8VDY
	wv8VhY19zfpBAx/tiygwVk7mb9PPT7N42TULFoRGZNrz0N8AUy1TRUCFSfp2Wn6uW0e0
	mZDz4uYUS6tSGerdg+epB4oblvTBxULiD+wyRROVDg+3APrAk+2D4OGWCZUcFHhb16vO
	iDnA==
X-Gm-Message-State: APjAAAVOzVDWLHwJDLDacLAVesZjyMupQtRm7Q7U+WhQR66KWt+VMhiw
	FKsA6aq02Mg8ChGAV1jmrBBifQKryg8=
X-Google-Smtp-Source: APXvYqwYPKEdgk9Ayqrz13dcljAPX4IBM32DFyuY8MqYMwOrbST/rdT9/fd2lo1b2sLltOpysf6Gmg==
X-Received: by 2002:a63:570d:: with SMTP id l13mr33393814pgb.55.1557162095342; 
	Mon, 06 May 2019 10:01:35 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	a18sm9391348pfr.22.2019.05.06.10.01.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 10:01:34 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-2-richard.henderson@linaro.org>
	<CAFEAcA_zP=KXXtiRn3AbpT6Dcjcjh3RNS1k+AB3TYZYBLOpiSw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <fa56dc1e-f3f6-4f82-2dc7-6ee8c51e7f12@linaro.org>
Date: Mon, 6 May 2019 10:01:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_zP=KXXtiRn3AbpT6Dcjcjh3RNS1k+AB3TYZYBLOpiSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v3 01/23] crypto: Merge crypto-obj-y into
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/29/19 5:57 AM, Peter Maydell wrote:
> gcc: error: /usr/lib/x86_64-linux-gnu/libunistring.so: No such file or directory
> 
> which is almost certainly because we're now including
> a bunch of extra libraries in the link for the static
> linux-user binaries which don't work statically linked.
> (In particular one of them looks to have a bogus
> pkg-config which puts a .so file in the link line for
> a static link...)

This comes from gnutls.  Thankfully, we can do without it,
so a quick configure-time link test is all that is needed
to disable it.


r~

