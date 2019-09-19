Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF94C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 16:22:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E842053B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 16:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NJyFMfUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E842053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAzBu-0002ma-Sa
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 12:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAz4d-00065m-Kv
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:14:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAyrv-0000sw-Fc
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:01:21 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:37236)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAyrt-0000sg-FA
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:01:19 -0400
Received: by mail-pl1-x644.google.com with SMTP id b10so1823288plr.4
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 09:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dcCr42E36MXZ7ye3RtoGSNXfWbVTNAJ/QE6W1jjDc6g=;
 b=NJyFMfUZWQ043hPi1tYvN58YAybQjNhhwvvtm8Lqwmw1ZrfLOdCMq0xWEl6znQ5bSa
 xOTFVO+viDzdXnzf/bzfnXo73lU0V8owBXX4NP4qf94I+ZLkjT+VCHe4tzy/OTAcWtAz
 QuFCbRzWBz3g5BBcy8aDjq+QeKmjh/xN1JYJJLOsSAX+xyEFZRDus5tCJHJJjyt4jY3E
 epYbatnqI0Y7wtg1p6ETp13acvPdruBMfW+9f8G1+QSWLusBUb87m19Bb0IXqbPZ7x6K
 BIOS+4+3IvEtOwMouIL87TXMBR6yqShshWQ5/mJRkU/TodXaCjYF9BW7NGwW7gmOxpSF
 PKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dcCr42E36MXZ7ye3RtoGSNXfWbVTNAJ/QE6W1jjDc6g=;
 b=eagLqlPyhFLjJQesjR3Ecj7HnROFMuphdOg5wniyvnFMsBZydAIH5AriQyJnyls8Ad
 dBFD0RTj7ho5t79vaijHm8RYhSMDjUgYk9rxpLC02qOhDZRvQ6zez04oQVO+87IRSbwN
 upK41mM+LlvJ/hhPIOyNp+i7M/H8cXzQko6WgITmDndE/iIZpioylGvsNSBXF5ULsZ7v
 lw2nIj3WSL9g8muiVNo4QoAYIZ0FxEuyv8Jh3udVxPE4oMFTb9NbGmae3GLkUO96Ld/w
 OGt18fPb/g1d1m4UbbabACAR9Lrmh0d07JuKe2sQLiTm1EkkEj0kSnJYgGRwGZv6cCLU
 atbw==
X-Gm-Message-State: APjAAAVzJmnyW9sUDFqM0EUcownFGvDFs31nLB+pGAfRs/fxLpZG9M3z
 VC8RvG2vw7RQ/K8o9FGxkHnW8A==
X-Google-Smtp-Source: APXvYqzO57Isq01PBeq5R0saz7qwG6+IzVFnGvUB2paBGmjqbE/jOpsPLvUsGGr09024smSStJ/zOQ==
X-Received: by 2002:a17:902:59da:: with SMTP id
 d26mr10756973plj.193.1568908876228; 
 Thu, 19 Sep 2019 09:01:16 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id m9sm6919687pjf.11.2019.09.19.09.01.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 19 Sep 2019 09:01:15 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v1] tests/tcg: target/s390x: Test MVC
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190919092829.15393-1-david@redhat.com>
 <7995a66a-b1c6-2332-dd12-28ff69efa612@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e22f6316-aa1f-b037-2501-ed71dee09282@linaro.org>
Date: Thu, 19 Sep 2019 09:01:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7995a66a-b1c6-2332-dd12-28ff69efa612@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/19/19 2:41 AM, David Hildenbrand wrote:
>> +    /* prepare the buffers - two consecutive pages */
>> +    src = valloc(ALLOC_SIZE);
>> +    dst = valloc(ALLOC_SIZE);
> 
> If anybody cares, I can convert the obsolete valloc into a
> posix_memalign(&src, 4096, ALLOC_SIZE) etc.

I don't care.  It may be obsolete, but it still works.

If you were to change it to anything I would think mmap
instead of using mprotect on the heap at all...

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

