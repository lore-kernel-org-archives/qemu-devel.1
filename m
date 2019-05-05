Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F577C004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 16:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB1122082F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 16:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o1YfY50t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1122082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43661 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNKOQ-0004Ki-Go
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 12:53:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNKNW-0003om-0a
	for qemu-devel@nongnu.org; Sun, 05 May 2019 12:52:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNKNV-0007mp-1m
	for qemu-devel@nongnu.org; Sun, 05 May 2019 12:52:41 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNKNU-0007kw-Ps
	for qemu-devel@nongnu.org; Sun, 05 May 2019 12:52:40 -0400
Received: by mail-pf1-x442.google.com with SMTP id v80so5446103pfa.3
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 09:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=6eYpoFsFHw8DGpzzwiuXcttk57KGwJF6eYLdcRr5Hxg=;
	b=o1YfY50tdGSssJuIydIboaPUoZUo22MEgcDoige4H7T1AOdRedLLhjSM0kEdfOS+kk
	JWC0CDF/Zyp+Uiu/iaWwWGKRMP34BDkwEwy/SV/NC0mZcwXnKme4N+dTi3d+3vl4h8QK
	JtHXt+dvAynwZFn3qz+hrn1vZJPB4Nk4Ndz1mRXbwFrbjwRVV0oQji7E+4+X3hnIJLag
	ZEHj8AIFY+/1A3xWtl73QVqqlRIxTlA/6Nx9fmiv64uUaWp8yOk+9Yq36iSbalOFYsLQ
	HVVx7VJMkupbItbgZRih6lN6QTSu5WHeGJ1bFP46tG7otgfATAQmaPc8bWJ9owQh+fTi
	e3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=6eYpoFsFHw8DGpzzwiuXcttk57KGwJF6eYLdcRr5Hxg=;
	b=pIFNSYiMnsf7erC02GWo2mirHUUBnNxpeQhdZTiAAisYMR9PX6XZUHD6tIRZgWGgqf
	fXKJK7mgcyS/fXi+OGzW5D+0SWCeEDBnZ1ecI8jm07yiL1EoXh/GvjTVZW7D3Nvh4A9u
	aZFxGGxCrmerRgw6B29XqcT57c2C+lnvuoEmTB4X1QQvK07uKr5vl3ibxurHTBiYJP+h
	OHQTeTdtxWrcFhkDbAwJ3nZStiJLXowgZ1ZrEZaGE6jAraUOK4AWJlQwqp3TXsxgUctG
	PklAW+PhWt2EXpFrP+1hAa5xd71X5L0iLeIaix0yEckd7AiHItoetGEx5p2j/TDQyG2E
	+Y4w==
X-Gm-Message-State: APjAAAWyEkQEAjXNULZR3wYxvphV8fSlfAcoJdsLLGwNWD4pp8VwPanW
	zGTvZii4DHEZ9wlIVgd9Vkjtng==
X-Google-Smtp-Source: APXvYqyd3FUDUpIiHZAt+uAiOm/qZKpxxmftGDfNRxruop3HIwXrK94Jdauy3gd2InXZwX48R9kqAQ==
X-Received: by 2002:aa7:8e50:: with SMTP id d16mr26427756pfr.227.1557075159463;
	Sun, 05 May 2019 09:52:39 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	v19sm17633249pfa.138.2019.05.05.09.52.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 05 May 2019 09:52:38 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20190504120528.6389-1-pbonzini@redhat.com>
	<20190504120528.6389-4-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <71bb0c2e-5298-16de-0c15-eb6f2b4d2f11@linaro.org>
Date: Sun, 5 May 2019 09:52:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190504120528.6389-4-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 3/9] coroutine: add host specific coroutine
 backend for 64-bit x86
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
Cc: peter.maydell@linaro.org, cohuck@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505165236.FNO1P4B9nrakJf0uHx4AZ_gVGWLiIdj6dQFU0UyoF_E@z>

On 5/4/19 5:05 AM, Paolo Bonzini wrote:
> This backend is faster (100ns vs 150ns per switch on my laptop), but
> especially it will be possible to add CET support to it.  Most of the
> code is actually not architecture specific.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure                        |  10 ++
>  scripts/qemugdb/coroutine.py     |   5 +-
>  scripts/qemugdb/coroutine_asm.py |  20 +++
>  util/Makefile.objs               |   1 +
>  util/coroutine-asm.c             | 230 +++++++++++++++++++++++++++++++
>  5 files changed, 264 insertions(+), 2 deletions(-)
>  create mode 100644 scripts/qemugdb/coroutine_asm.py
>  create mode 100644 util/coroutine-asm.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

