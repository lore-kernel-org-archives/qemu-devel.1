Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42321C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:01:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A70420661
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uG+ALDT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A70420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izfqX-0003Nn-OK
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:01:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izfp6-0002dB-N2
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izfp5-0004fO-Ps
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:59:56 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44257)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izfp5-0004bg-Fn
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:59:55 -0500
Received: by mail-wr1-x444.google.com with SMTP id m16so6805631wrx.11
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 03:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ugTmMjZDVlcovwqWwilo+FlkL7KBnhXf/E6DYiyih8E=;
 b=uG+ALDT8fSGcA2Yw7gjXagHANqn52smYG6bnTQ3emIuEHwSHHx9q0uHyNyuk8nRdO8
 yW+QWqgrn5awBLk1KIeQXZADl+5F8yMLyXXS5QX30EwGMgRvw5IKtLaghuIbgUuK3fV3
 u8/h3j5X2M1pm0VpckWyk5lY94JrWKQYUkx0BZxcI4HJSsMvCn7AnYVT2ssps8CfPMee
 jWnp3R+tZfVwb+zuFgoh0WzD+cKBAWV1bX5JLZG+kYQuEgWVUXMFB3Sh4uy5z0sZX827
 m9R6NmFGnSrIk6rEMJ8A0GFlAG+dmJ58pt5TTsQUMQZkkUIDhzuDR72BMbv/Zc24oESA
 q0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ugTmMjZDVlcovwqWwilo+FlkL7KBnhXf/E6DYiyih8E=;
 b=jRMW6wbnF61qYPIuphZEW4F5W3o9IcIACMPMnKy0f6+ykT4JJB1UTdootXRJ6tBhe6
 yGU8WDAyczf+YIxgOyOZDNrHm8aZk0lLAVxcIOhGTxdOF2z2eqw8+wtKJ7NYdcLTqGEW
 BGvbV07DdaT045r0rl7QcWW1+gSwWPZPPHyXLeqCWgEGB94FEf3xlWqD177YEKJKcQla
 cgPFcZ07kiWK/tRi/dHFIhynt28ckfZTaxRun844Oa3D0fWBQGHGH42yQskCBmFY1i1z
 AlxCkEtrJKWa6unWQnnxjU9buitLJmCk+ZYQJlL7Gmib4pyWqVSw1IvhbfE/QQqcGpuv
 xFCg==
X-Gm-Message-State: APjAAAVjQMEMFPPiN7JjvVFSI7UQdW2ikEdyiGVgafeSQk999cnDRPtX
 aqT1n1oOg8oelvr9dhwNe2bLyQ==
X-Google-Smtp-Source: APXvYqyovjz7HaA3XDcBiH9inaHxPk4MuXpY4VetBmFx4ahWZ3T93XPMgiyqn34tby+nM/SDOmXVNQ==
X-Received: by 2002:a5d:6b03:: with SMTP id v3mr3320931wrw.289.1580990393503; 
 Thu, 06 Feb 2020 03:59:53 -0800 (PST)
Received: from [10.43.13.93] ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id g15sm4025164wro.65.2020.02.06.03.59.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 03:59:52 -0800 (PST)
Subject: Re: [PATCH v1 07/13] util/mmap-alloc: Factor out populating of memory
 to mmap_populate()
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200203183125.164879-1-david@redhat.com>
 <20200203183125.164879-8-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <04926fd7-6133-c2a3-d33d-85c48cbffbae@linaro.org>
Date: Thu, 6 Feb 2020 11:59:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203183125.164879-8-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/3/20 6:31 PM, David Hildenbrand wrote:
> We want to populate memory within a reserved memory region. Let's factor
> that out.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Greg Kurz <groug@kaod.org>
> Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  util/mmap-alloc.c | 89 +++++++++++++++++++++++++----------------------
>  1 file changed, 47 insertions(+), 42 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


