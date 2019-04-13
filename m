Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D58C10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 06:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0487620869
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 06:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JwD+daTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0487620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47407 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFC16-0008Eq-4W
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 02:19:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFC0N-0007wn-7B
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFC0M-0002eW-B1
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:19:11 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:33851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hFC0L-0002dw-Ug
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:19:10 -0400
Received: by mail-pf1-x42d.google.com with SMTP id b3so6155981pfd.1
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 23:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=yy7aZMW0adM15lyJcsTlNIVKSEAoL9V5eXEGBMw2k00=;
	b=JwD+daTcRWl/BwSveAWS4OzUdeR3fbwCSSZWOlQ02JkWyAZhbyw98Nb/BJQV81XhrA
	m+/LQZn6ggAd71Xs0zMQd07xkCy8upcBD7V2pULXz6lWij75bOsAU6siUbiWcf610wZw
	806ozNKi59LLDo4OxOsBrutMhAvrxYFSZZ4pYsevrQHFLMSjaMkmzAShL5aiYpBGEOA2
	fAC/1cGYqfSXqRurOWI4mbKDBk7LaGfE3B0IuGfNLQLKJTZddhRuhUo/gi8qFI7vfavD
	XTQ6fzF3K6n5r5G0wlQLfw6UYXHwDaW0xwW5n5oaxag1bO255eflm5i/7w2qw9q0VVTo
	er8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=yy7aZMW0adM15lyJcsTlNIVKSEAoL9V5eXEGBMw2k00=;
	b=al+T9jzn8meByoCELKfzpxUctg5rRtfmPhGreyWVRUNFEjo3jKWJguC8fj41/1U6Tn
	OkMWM0r2/pQaIaAZ83/VXiWMh5VCQYJWES2SVJznMVTn+Ff+H9xxFnQY11hwU21wTkkL
	hYvuxc4POxxjNZCJY723DAk9GRzJ7Pkngck/W//URexlN32Tgi6xcPyy2AQinWfGif0H
	e93WplMsgLuZbpdbHkq5YLJ8aITrPk64m0LA9gRuqWdXYl0dxvKvEKKuG8SlT2CejAU8
	Bf/riVtvC6rczEcz39Fnc0CFFeuEtkoqswlc5nHXLV7bVPLD1jR/Xhq6xKIQmypEVuXf
	4kjw==
X-Gm-Message-State: APjAAAWoi7MlJwMb4QQkwFPJ4js8ozzRSu3/HeSkrUl7/87lnX0bUvVu
	h0QJHgfa6K8XbllzgJXSlCtCnA==
X-Google-Smtp-Source: APXvYqxLRgvCGVjPkN+rL5CsuWEkkWsh500NYt7boyR7I8f/K+D2a6E05k9uZpZru896xCSL46e7pg==
X-Received: by 2002:a63:31ce:: with SMTP id x197mr56694653pgx.69.1555136348849;
	Fri, 12 Apr 2019 23:19:08 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	g4sm61959936pfo.38.2019.04.12.23.19.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 23:19:08 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-41-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d1a4039a-2bdf-8fdf-63db-80ba699523cf@linaro.org>
Date: Fri, 12 Apr 2019 20:19:04 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-41-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::42d
Subject: Re: [Qemu-devel] [PATCH v1 40/41] s390x/tcg: Implement VECTOR SUM
 ACROSS WORD
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
Message-ID: <20190413061904.e9-C9ztVJ1szcUor4kI_albyxtMoK7g2ueMBqLWbTQ0@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> Similar to VECTOR SUM ACROSS DOUBLEWORD.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 29 +++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


