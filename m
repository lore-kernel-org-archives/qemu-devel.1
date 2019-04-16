Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B968C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 08:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F2D320821
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 08:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SPlk9D5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2D320821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33128 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGJhq-0007Zb-9d
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 04:44:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGJh1-0007ET-7G
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGJgx-00037Z-0R
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:43:50 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGJgS-0002y5-Rv
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:43:46 -0400
Received: by mail-pf1-x442.google.com with SMTP id 9so10018914pfj.13
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 01:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=KwcRFRWlNptx/AcbICiNw9t44944wNNpIWaMRq6bpeg=;
	b=SPlk9D5e6TiueFJkqbKVzMrPTF0expS1pEgV5/lBJqZNPBZAjAK3TRbUpYT/ESw00G
	XyBEDIRUJEce75HJDmjYVP9fWVAV+QaDj7BioGPgnO/97mUAbPwHaMGGnRObWmHRfc3X
	GQ37koBMt4sKOuID6a1jCLluJ0Rn9d3i4wi9xqMwGjnBLrDNG0xXXDTeavF3b99g2lY+
	QCCuH/EgGK6UvRYB3YLyjh8CPnvviOIbBCoXml3yOsbgSTNBFn7cSNqQAJqCi+akGLa1
	oeX9VJWTmH0KHs1z5CrSqQZuGCfcxmCTQ2/bR8Tx5oHPwX/kUXF+hWL827tLqSWVb7/z
	ypWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=KwcRFRWlNptx/AcbICiNw9t44944wNNpIWaMRq6bpeg=;
	b=NlEuWbZ/ce2u03gzUfCR8zoj5HLzcVoGZAE1JqanDwbvCvTVHo20h9hdu+XxQ+3caz
	JGccOanRNsR0TswJiWKoc8qT9xYNYkMaeRcDB879RJwo1U3A2/QE0onuICeITbrijZB3
	l3rLBbsMIFNB1sCQcChj3julxWAKSJ3EwRFbCK/y03bTKF4dJFeb+3MqfA04+UJqMS8k
	1Hi7jGYikqTjAcO1CXxGSm0oaVJCjfOUVveytUlGNa2XtN18+YH5ow9Yr+Uo6hJtXtRM
	bo5rCXtgxgPIR6pBiQpSJVkm4V6TNhR6tWZiQ1qYmXzk8KgSgewdJ97OIxg899OlAGKQ
	lXFg==
X-Gm-Message-State: APjAAAW0734XXQI06Rdm5HpEOhYhuOdVLQNPbRJG6etAYPKiu/fgTepW
	9V43K6H2383e8BWCMnzFzx8Bsw==
X-Google-Smtp-Source: APXvYqzhKRVn4XvY57IoNr1D5VjwcUR+sjbpVByzCOTHcQ3PboGFd1NTp2ql7ezUY9yJy4CYW6YanA==
X-Received: by 2002:a63:31ce:: with SMTP id x197mr73882433pgx.69.1555404195570;
	Tue, 16 Apr 2019 01:43:15 -0700 (PDT)
Received: from [172.20.101.138] (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	n1sm57318760pgv.19.2019.04.16.01.43.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 01:43:14 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-4-david@redhat.com>
	<50db1745-397d-03e0-626a-12d1b2a2a554@linaro.org>
	<0fdae81c-eecb-90cd-26f8-b52964d375a3@redhat.com>
	<b0567193-e353-d391-b438-e5b580d699a4@linaro.org>
	<0d400fda-85a7-6c5d-a693-1d0bfec63ce3@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9f632efd-37b9-5aaf-fe81-7c332ad51d7a@linaro.org>
Date: Mon, 15 Apr 2019 22:43:11 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0d400fda-85a7-6c5d-a693-1d0bfec63ce3@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v1 03/41] s390x/tcg: Implement VECTOR ADD
 COMPUTE CARRY
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
Message-ID: <20190416084311.ItxgF6zInBiVq6FZc969FX3epFCgbJP-GJu7oJlOYiE@z>

On 4/15/19 10:33 PM, David Hildenbrand wrote:
>>>
>>> Indeed, I didn't really explore vector operations yet. This is more
>>> compact than I expected :)
>>
>> :-)
>>
>> That said, in implementing vector variable shifts today,
>> I've come up with a representational problem here.
>> You may want to hold off on these until I can address them.
> 
> I assume you mean vector helpers *in general* in this file. Yes, we can
> add them later.
> 
> What exact problem are you dealing with?

The .opc field lets you only specify one opcode which is optional in the
backend on which you depend.  In writing support for AArch64 USHL, I find that
I needed 3 optional opcodes.

I'm thinking of a mass change whereby .opc becomes a pointer to an array with
terminator.  But then, for debugging purposes, I think I need to validate that
array, so that it's not missing things that ought to be specified, but which
happen to be supported by the current host.


r~

