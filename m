Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390D3C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 06:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2F292081C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 06:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M2lHAsnh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F292081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35182 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMRNb-0000jX-A7
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 02:09:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMRB4-0007aT-QR
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMRB2-0004Xr-AB
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:56:10 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36079)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMRB1-0004Wb-Iy
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:56:07 -0400
Received: by mail-pf1-x442.google.com with SMTP id v80so2355799pfa.3
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 22:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=4YrkDVKmxHtFqA60VIn/PG0c8fg2cbdOpv1OMwRi+A4=;
	b=M2lHAsnhE2CTYfc3BkDkHIQLwBbf9E/6otet5W18Af8WJWSHKTSlnpg6aPYHMUc53h
	1qyQj8CsmBp8CsxcumcM1IaEVgKXhX/Wq5ZNp2rjQth8f/xFLr+TR2GdXbzLMqEbdGdv
	ECHyEsPgAk8xFf8M4GPrhJJfdsfnbWuI5/YpfNDV1A8XYcfPSWx01/BDC8fSbt5ce/9+
	KPVmip49mIWXvapCtEmkIJzHLKt6iBhfuoyI07T+I5Ce5MFi3R3Ed4V+vnChI0ZMabQq
	6c3+PTFX5EYccDJGddOFWlxEg3hz0oZsQHTQHLF9dz/lzV2jM0Mo3t/CW6q15ktAheSG
	Li9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=4YrkDVKmxHtFqA60VIn/PG0c8fg2cbdOpv1OMwRi+A4=;
	b=MYyG5Ze5KMLoOJrbbE0FroNKWqVjb79igAXy08WnWWmbFABQjhYEi5fxmgb9NWUmdD
	W1a8HoWEs9WhKFix1L2NR4cFol0p8Cyf64lJ8ZAvskQYNYc2wBawV9bgsqtYDyioTctP
	qWG9l9pOxTmQwfjfwVEQEeGaDa2YMlnWUTqvD3Elxl5bj0DXSzKMjtFJW6hXnEa0DVH7
	JR5kiWftKQqJozNk1zVGzKzwE4rLoy3x40oUCZ2QO/r9i2rr1xImRlRhaeLBF7LPMSHt
	b+BN9bD2dPGzeJSitOMqC4CPbMLo5rEgcIhDfm0ni6Sz9mCMFaIZp3L0L1dROKUh4FxQ
	8DHA==
X-Gm-Message-State: APjAAAUOo0REW3eIxdLKrveXiz737E0vkwDrVTkc6dSu+oysWKAQUvCO
	uhfWB/1qJY7UYg2eNjjydVT4tw==
X-Google-Smtp-Source: APXvYqwskCII5oV+dR5Fama6bxpt/5e3/m38csr7Elb5VvwQ7b4iRjglSeaNoxNXN2SDls5kIrHnjw==
X-Received: by 2002:a63:6cc7:: with SMTP id h190mr7968606pgc.350.1556862966278;
	Thu, 02 May 2019 22:56:06 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	b20sm1463889pff.118.2019.05.02.22.56.04
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 02 May 2019 22:56:05 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190502141019.6385-1-david@redhat.com>
	<20190502141019.6385-31-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <2d2fd239-092c-1ad3-4ff3-eca138ca3ba8@linaro.org>
Date: Thu, 2 May 2019 22:56:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502141019.6385-31-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v3 30/40] s390x/tcg: Implement VECTOR SHIFT
 LEFT DOUBLE BY BYTE
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
Message-ID: <20190503055602.bOZnq0UNyKZr3dh2TulAlZnLzWGjy3bLYBXlbHV0f6g@z>

On 5/2/19 7:10 AM, David Hildenbrand wrote:
> Inline expansion courtesy of Richard H.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 29 +++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


