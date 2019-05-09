Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E56C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:00:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60A6020656
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DzbI1zvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A6020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57993 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOmPg-0007xF-FZ
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:00:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOmNw-0006sT-VZ
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOmNw-0004nF-1A
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:08 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:34393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOmNv-0004mk-PR
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:07 -0400
Received: by mail-pg1-x544.google.com with SMTP id c13so1528340pgt.1
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 09:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=7RuyQx//oo2EMwy5keSM46lL/6qbPwtXookn1XI1hcQ=;
	b=DzbI1zvvwFFDr3j6gnuf0QauCmv1tIL+xE/PM3ITa1QPhhZyBT/ZMHGv/vnZoNjSXF
	y81wUWroBaddYI/DegKTNXtapV+gzXI3vxGk7uee/NJ8/hgxciTj3Fcua82JJz5z6AtN
	35gSv9RIwaOk3+WKTf42xy92iCpvhPxHtBvG4KtdeEfkAt0efmzvPMGQs02BJClpnFDA
	I70fVstxpyQDBOwLaDadTr5tqemZ6ycnhEtW0zeTtaq8JUZS5X5WIhcdvAmbuQY9QYgy
	aBaQXocDWUCr3zw5qAtB+kAo1mOG4wbiQckDSNVb/tyqYXRnNp9/V2P+Z2o2jlWaEZBV
	umGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=7RuyQx//oo2EMwy5keSM46lL/6qbPwtXookn1XI1hcQ=;
	b=azaTLhzTLGPQy/it4qUO5cPhkfNllCuUDwArC60IRgGzGDOg3wt7VOE98Ek1pD+dA/
	ew0Sk15P887zUkWyDajWgBfgxWUec3374gROEA4Ul8x9ZXHUXrnWl8yxdtfIi8rRKvE2
	pIW/sY03Q6uJ4igXO9D1Zej+Jawgp/UUm7yVzxM2jV91WPsed4ByO8m1dc/BTs0cwR6l
	nWo6a4gKh1d6K3PzOSFK7UBoy6SgKD1tDxdemld9Cp8tJEmMjBHsT2TmA0Qo89imprLX
	pvw7Ic92x6TWWKLkXy6ye3bA58GERNNhhzFFUp426nqPM2LA8pOHNQnye+9cVlpONk/G
	/Hwg==
X-Gm-Message-State: APjAAAXwSJiQyI1RUCgpIZQG37EOZTrjoDhz3JEFzVIoL3DtTE9Auw4m
	ra6cNqOjZFKkSItkUaopA3b3yQ==
X-Google-Smtp-Source: APXvYqzIv1Sn1yQJyVEEaf5iyqirAL3+SDH4uj3bBN7OzNu+s/NrOSvAulLOWE3Q4avkWzITVAqSOQ==
X-Received: by 2002:a63:5f42:: with SMTP id t63mr6802560pgb.275.1557421146613; 
	Thu, 09 May 2019 09:59:06 -0700 (PDT)
Received: from [172.31.99.192] (50-248-210-99-static.hfc.comcastbusiness.net.
	[50.248.210.99]) by smtp.gmail.com with ESMTPSA id
	n64sm4422879pfb.38.2019.05.09.09.59.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 09:59:05 -0700 (PDT)
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20190509142342.6132-1-lvivier@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1a0649e8-b283-2cb5-9621-4eacf086d300@linaro.org>
Date: Thu, 9 May 2019 09:59:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509142342.6132-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [RFC] rng-builtin: add an RNG backend that uses
 qemu_guest_getrandom()
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
Cc: Markus Armbruster <armbru@redhat.com>, Amit Shah <amit@kernel.org>,
	"Richard W . M . Jones" <rjones@redhat.com>,
	Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/9/19 7:23 AM, Laurent Vivier wrote:
> Add a new RNG backend using QEMU builtin getrandom function.
> 
> It can be created with "-object rng-builtin".
> 
> This patch applies on top of
> "[PATCH v4 00/24] Add qemu_getrandom and ARMv8.5-RNG etc"
> Based-on: <20190506173353.32206-1-richard.henderson@linaro.org>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  backends/Makefile.objs |  2 +-
>  backends/rng-builtin.c | 56 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+), 1 deletion(-)
>  create mode 100644 backends/rng-builtin.c

Looks good.  Thanks for picking this up.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +static void rng_builtin_request_entropy(RngBackend *b, RngRequest *req)
> +{
> +    RngBuiltin *s = RNG_BUILTIN(b);
> +
> +    while (!QSIMPLEQ_EMPTY(&s->parent.requests)) {
> +        RngRequest *req = QSIMPLEQ_FIRST(&s->parent.requests);
> +
> +        qemu_guest_getrandom_nofail(req->data, req->size);
> +
> +        req->receive_entropy(req->opaque, req->data, req->size);
> +
> +        rng_backend_finalize_request(&s->parent, req);
> +    }
> +}

As an aside, with all of the callbacks involved, does anyone know if this gets
processed on the same thread as issued the cpu that issued the i/o operation?

The question is only relevant to debugging mode (w/ -seed), in that if we're
processing this from an i/o worker thread we won't have completely
deterministic results, as we may compete with other cpus for the same RNG.

There's probably not much that can reasonably be done if this does cross
threads, and certainly it would not affect normal usage, but I just wondered.


r~

