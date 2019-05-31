Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BA2C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C452343A
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PSirh8XS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C452343A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46902 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWlIY-0002ep-Ib
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 13:26:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWlHK-0001s6-OC
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWlHJ-0000QP-S5
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:25:18 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWlHJ-0000Og-MX
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:25:17 -0400
Received: by mail-oi1-x242.google.com with SMTP id 18so7515618oij.5
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 10:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=axwLYKEJFzL96EpUlAV6+pFc52KLgAS7W92p5GCriPY=;
	b=PSirh8XScHu7hF5jWOYwIwu4DfOmXVT/YsPgflS3CGDcWcZB3t0CoI9vZPkLJmNuMA
	f5gtzN+bs+8Ww4imCCOmKneIdynUxRVpshyLlEJMCXt1XF7KuWotap1lVCC5cHqOxC20
	8C9aI9s61PvTGY2r979gW4r0beZGXlx3nrkFx/KVb+4LUATYcTd0deMVb6RaGnOIoBhU
	rdwE6QIfdp9ixsiDZ7v/tHSmnOxNneCH8Q8RrrYnP7zbExCXusZAoUkcxD84D1L7qarN
	/4Qx5GgddQnuIXZGDbHNrb9wen64LRJAZsMYE9FA3I6wFR/W7EoszAS/CcjZeyMFQv6E
	rHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=axwLYKEJFzL96EpUlAV6+pFc52KLgAS7W92p5GCriPY=;
	b=rvzakWzIH5z+/FXwfW5JBDnCi7MrFD8leETvYa5y0vmU1C351iqTUgMjjMahoAxRz2
	A2TqKkPllcVE/LFc0Fb9XYcBQIDrf3aLeIKjo8/semsdwasLlMWImcVnm0xNerIq+K8p
	AzglNZNo1pWvOJycbxfVuYIjY4adpdwgB5yvhmD4P6Y5Di7vSGRRbumGTcOQWuGCCsDA
	uc8lRmINsi8Jl7zXYfkUYG+JqPfd3jUCzSv75PUx/Kcr5SEeb6S8e8s82gq7calDp4x2
	//+yvk4CBuNTMLLOgRmNYwDv1FlVW7W49EsGOC4AEwt41SsFo5wQyoXOZVSxRMBerYuP
	qBKQ==
X-Gm-Message-State: APjAAAW4IiRtGH14rJyOV/g0GC3A3A88XrKGRBn7O4We7urUk11ilvph
	fwImvAblDAwvIebWuXuGmuJ+0AHcy/2tZA==
X-Google-Smtp-Source: APXvYqyb8yqvVFc+49H1xykZmNnV50HapAZ3xUq4nvFY28x8/v9GHTK7U0GcQVrB7or/b1eD1xDhKg==
X-Received: by 2002:aca:438b:: with SMTP id q133mr6744520oia.36.1559323516617; 
	Fri, 31 May 2019 10:25:16 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168])
	by smtp.gmail.com with ESMTPSA id d77sm1948920oih.9.2019.05.31.10.25.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 10:25:16 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190531104432.29379-1-david@redhat.com>
	<20190531104432.29379-12-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <28541e8c-599f-5126-f211-a301d2ef752f@linaro.org>
Date: Fri, 31 May 2019 12:25:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531104432.29379-12-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v1 11/23] s390x/tcg: Implement VECTOR FP
 DIVIDE
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
	Denys Vlasenko <dvlasenk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/19 5:44 AM, David Hildenbrand wrote:
> We can reuse most of the infrastructure added for VECTOR FP ADD.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  2 ++
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c |  3 +++
>  target/s390x/vec_fpu_helper.c   | 17 +++++++++++++++++
>  4 files changed, 24 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



