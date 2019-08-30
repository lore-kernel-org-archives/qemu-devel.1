Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CB6C3A59F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 01:35:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA5721726
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 01:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cf31/lZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA5721726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Vol-0003Jc-OA
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 21:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i3Vmc-0002iM-UV
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 21:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i3VmZ-0005vp-HR
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 21:32:57 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45396)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i3VmZ-0005gS-9I
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 21:32:55 -0400
Received: by mail-pf1-x444.google.com with SMTP id w26so3400628pfq.12
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 18:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ebag+3kMLc5NJjseN3RIqWI9hFm0qcW7CgCN9vMt8e4=;
 b=Cf31/lZsjX/P7ta1iF+DtmoHndu5O4+bSxzmIYOmjoXnq9xFA30Fy78SlUbb4MYZOA
 LKukENDRjy08EfAUaGGz8wbYYpNBio4EqE/Aeymhn7xGlOIUxWs2yRThh3fZ8fuQ7vBx
 2031sASAMgtafiTVg7Z9zxWs26XXAktrBGn4oTWY03WsWsg7ZDE3657fIoLxXkccK6al
 OM55zAfT1TLlwSqH5zzClR6tOltrF2HohUKTlyPWP6EvJn6eOvtKmXM0zKn5xP5KQ2mL
 +g3d9Old4hX9y2b2+NZGWx603RsGcWyHTT/o8EOgsjft12jO/ryqTlLQKYVg9Ch+GpE8
 nurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ebag+3kMLc5NJjseN3RIqWI9hFm0qcW7CgCN9vMt8e4=;
 b=RzUUqUdX2SQ5iQ+CbUd93KoPK/VfY5V3fX4YoND7hwtVW7PEDqpXqeAVjP1ub8rwXP
 f2KZO84bcHBrpp+V44dhToIufqMwXp72At61CcH+OmGf8yRy8V421ZlnXelIM67kS4zc
 qo8UOfCF0PdzJHjCLqkjV9QMTEPIHbB6e3Pd8kD5Eo2jKAc0W+NsuglQujSTDb0QrLTT
 NY2MbcoTxNIqa7ieevgVF5FnFqLcwx/k2U8PTudKCmAObxkQwpH2rjIU0o6j9YHn+aw+
 RZYtld7e4LqLzhT6cQ8yt+PmHqa2bJypQI7agq+s/KLqcYk990xOOrVSjoMpto9EyadX
 +5fg==
X-Gm-Message-State: APjAAAVcxcaC08H2Osb3Nrd99+gcVV4f00x5A9kVY5KWWNe1bchPWghU
 U3jKIjLPCXO+MDY2Jz2+VJONtw==
X-Google-Smtp-Source: APXvYqx21NPDa3BVUWHeO5FV41/Ub/ZQqVffuiEDS2fqE9I+ygV7a6zVfpqWujmWy+QFTZTgcO7q1w==
X-Received: by 2002:a62:31c3:: with SMTP id x186mr14717923pfx.97.1567128770921; 
 Thu, 29 Aug 2019 18:32:50 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id u24sm3017464pgk.31.2019.08.29.18.32.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Aug 2019 18:32:50 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190828231651.17176-1-richard.henderson@linaro.org>
 <20190828231651.17176-5-richard.henderson@linaro.org>
 <dc2d396f-d1ac-1c45-0bf8-16acc7421647@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <8b5b1247-cd77-d890-b15c-3e0a6db00afd@linaro.org>
Date: Thu, 29 Aug 2019 18:32:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <dc2d396f-d1ac-1c45-0bf8-16acc7421647@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v2 4/8] exec: Factor out
 cpu_watchpoint_address_matches
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/29/19 10:20 AM, Philippe Mathieu-Daudé wrote:
>> +    /* Avoid trapping reads of pages with a write breakpoint. */
>> +    match = (prot & PAGE_READ ? BP_MEM_READ : 0)
>> +          | (prot & PAGE_WRITE ? BP_MEM_WRITE : 0);
> 
> Isn't it cheaper to do here:
> 
>        if (!match) {
>            return iotlb;
>        }
> 
> or
> 
>        if (match) {

Note that PROT_NONE pages never reach here; they always trap in tlb_fill.

The only way we can get match == 0 here is for the case of an execute-only
page.  Which is possible, but extremely unlikely.  Almost all targets merge the
text and rodata sections, which means that virtually all executable pages are
also readable.

(Although I must say that in this age of ROP-gadgets, leaving the rodata
section executable is probably a mistake, and tools should be updated to *not*
merge them.  That's still not necessarily execute-only for the text section,
but I don't see anything in principal that would prevent it.)


r~

