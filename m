Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92877C10F12
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 04:31:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F1920835
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 04:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tMDsRBAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F1920835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46708 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGcEk-00040r-Fx
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 00:31:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGcDn-0003ff-Kq
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGcDm-00085P-Mu
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:30:55 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:33239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGcDm-00084v-A7
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:30:54 -0400
Received: by mail-pg1-x533.google.com with SMTP id k19so11400799pgh.0
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 21:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=WBhgcWdcSjB5K40xoT6RaN8PIHJdaMd7bKLbQFYgd3k=;
	b=tMDsRBAd+wn1sj6y9PM5QCp49jahXyGjnlre/XMvWMx+5FlQwrSsXMEUx2hDDfAj1D
	Bx2iL4XHa1WDqt3oM7wjRAQ206bXXoikHDWXTR6C+zWn3dsILND40Z5N3aCKMDjNMzSL
	Nl6UieyJKJro5EGo63ihirZjJzLYdR8uhO4VWMpSCxzjH9HbxGWQFlYls+/evKlZuMfJ
	oBWWTDJvkauP0xjP4FpEA28y4roQv2cis8deIJ5u6TXMaRW1tKUfYA6AFHoxK0yZRjKl
	3hmDK7wTw4F4gMR3O8WjJrO2MY2IKZVzaoElmD8FfqWlDO2W9ekoPsVAVXSjCJP23QcP
	3NZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=WBhgcWdcSjB5K40xoT6RaN8PIHJdaMd7bKLbQFYgd3k=;
	b=fBDaZjnOJMPUmQUm8PIYoplUU3MQzYLiP7Hu44I5ju+5vGpWTR8ig6ZHCjqRl0TKJz
	j3MVauhCs2g+pkPn3af/wrelIioTs5wyqQHFGJI9rbrP9Pw+348mZQa9NJ+PmEGjOU9R
	CyvGL29fnKEGfFza+yuKpZqKX/jkIyC3wrGMpZvmhVDJdNEZqMA4mSYt37TONOkTet5z
	hQxkC/3PSAOHiWVfkyRTWYIOfJ6xZxG24Py7oA6t/lU9srkWt0kR3o+XME8WwTX83mgs
	cL/Lxaqi8JXx0DxJCTjaJTLzoCR0iSdt+v8AYO92vUrcwP6LZID4OCgQgtnSnrWt8hZw
	ogVw==
X-Gm-Message-State: APjAAAVogH9ncRdj0oZU6tVZfNrOHbgUtfT0c/TZ5I+AD/HoXXq2rEPC
	kWxw1RkqOneJkX34gvzA6p3OhA==
X-Google-Smtp-Source: APXvYqzhxStFCBH3PHJaUfXaCr4GCwYIK9mE68NvLBjVg7IN59VgO4e96e4iD8e86eH4d668T2SJ8Q==
X-Received: by 2002:a63:e653:: with SMTP id p19mr79414302pgj.284.1555475453254;
	Tue, 16 Apr 2019 21:30:53 -0700 (PDT)
Received: from [172.20.101.138] (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	25sm32733838pfo.145.2019.04.16.21.30.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 21:30:52 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190416185301.25344-1-david@redhat.com>
	<20190416185301.25344-2-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <7ab7e798-1d68-99f8-acda-873ad94a5fae@linaro.org>
Date: Tue, 16 Apr 2019 18:30:48 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416185301.25344-2-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::533
Subject: Re: [Qemu-devel] [PATCH v2 01/41] tcg: Implement tcg_gen_gvec_3i()
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
Message-ID: <20190417043048.kACsRHTAYn8eiZ3cwxkSQQoLlEo1A5FJasZb0QrQvtM@z>

On 4/16/19 8:52 AM, David Hildenbrand wrote:
> Let's add tcg_gen_gvec_3i(), similar to tcg_gen_gvec_2i(), however
> without introducing "gen_helper_gvec_3i *fnoi", as it isn't needed
> for now.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  tcg/tcg-op-gvec.c | 139 ++++++++++++++++++++++++++++++++++++++++++++++
>  tcg/tcg-op-gvec.h |  24 ++++++++
>  2 files changed, 163 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

