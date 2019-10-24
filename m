Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE481CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B882F2070B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aUy+Ieye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B882F2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNe6e-0004vm-En
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNdkq-0002db-5a
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNdko-0000Ky-Qb
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:06:19 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:37830)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNdko-0000Ko-L1
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:06:18 -0400
Received: by mail-qk1-x741.google.com with SMTP id u184so23519521qkd.4
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nfmjIwBPnkA+wvYUM3VvUWJrrt75lDRQLCmDT4Oelhc=;
 b=aUy+IeyeiEr0dCVl1bdkYDbzGFbXs3PXmVpvnYq8vIV4OmFYST3S55UUsRxT3R6AS5
 gjjcUHQ24JQ+96M58whEJPGBaD9zvkwZ06m0JbvJUwuBOzaSUjplymHUqYRNLg3sjCxw
 droWLMjnEHqNp9Wm851h0/jo80rBeB1tg4/EYpN7Ag3JqhGfveoGcZiEzZEnY42R9JFg
 pF+pjJT94/WxJvIqSEOPqhsxSvYXmeNjE/k6EhMc22jMItYrud+blKMLOlWHpBQ/DDai
 RGJnbngM5CAGgyFGHrboZH4RTo8HYdSaWU/qNixoeMEvnvZ2md9JwnZnWJgt62B7NAzY
 EN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nfmjIwBPnkA+wvYUM3VvUWJrrt75lDRQLCmDT4Oelhc=;
 b=nXeGovGT3t6miOJVn9ouuDhTxRYUCQvUSd/Xw+Sz6LzyAXrDcWR8+TEGl2c+OSn00u
 iNxHJw1FFapQaUG+qF6Z2BpycAq+kxSol2UnQUZtyzuQhXekWdipY+NN34LTt5ieSmy4
 td+I7wZ8V5JCr5Xxtx5YLi024aP1O3DSHKlTzAR3MNaZ3QTuVlmelh2zYsd5dCzhsNUE
 1p4XJx/aQ7l8V1lVtsoHr/3WxEsX01oG74WT+mMSfnX5HwUtF4TU695U8WQMTjfS+M0o
 V1vwlg6LB1orW4gNu0YYFXIYVdhQylcW428mcYYE9nFQQYbY5VGwkCH7KBKKKdgvn++E
 5CZg==
X-Gm-Message-State: APjAAAVhetKdCHUfEef6pvWS/pDd//NnyYCWo+3nHjyk6jaaKf1MjEE7
 ZDe9lLhudvF4DMb5o4YHcSvjaw==
X-Google-Smtp-Source: APXvYqzI525ktSqQ9coMyMsoE29dnvdQ1QiGVKpwiCf9MntngloXZKXNMaH0ndHqYI5YBvJYh1OKig==
X-Received: by 2002:a37:4e81:: with SMTP id c123mr1066034qkb.468.1571925977776; 
 Thu, 24 Oct 2019 07:06:17 -0700 (PDT)
Received: from [172.20.87.163] (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id d55sm17723809qta.41.2019.10.24.07.06.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:06:17 -0700 (PDT)
Subject: Re: [PATCH v2 1/7] cpu: use ROUND_UP() to define xxx_PAGE_ALIGN
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191023154505.30521-1-richard.henderson@linaro.org>
 <20191023154505.30521-2-richard.henderson@linaro.org>
 <55b477b7-877e-954f-2175-ed36fa787600@redhat.com>
 <e41a98e4-189a-1e0f-7b29-51a6e00e4d7e@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <26cb0551-fbac-e059-c1bf-9c17420528b7@linaro.org>
Date: Thu, 24 Oct 2019 10:06:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e41a98e4-189a-1e0f-7b29-51a6e00e4d7e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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
Cc: alex.bennee@linaro.org, Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/19 8:04 AM, Paolo Bonzini wrote:
> On 24/10/19 13:52, Philippe Mathieu-Daudé wrote:
>>> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
>>> index ad9ab85eb3..255bb186ac 100644
>>> --- a/include/exec/cpu-all.h
>>> +++ b/include/exec/cpu-all.h
>>> @@ -220,7 +220,7 @@ extern int target_page_bits;
>>>     #define TARGET_PAGE_SIZE (1 << TARGET_PAGE_BITS)
>>>   #define TARGET_PAGE_MASK ~(TARGET_PAGE_SIZE - 1)
>>> -#define TARGET_PAGE_ALIGN(addr) (((addr) + TARGET_PAGE_SIZE - 1) &
>>> TARGET_PAGE_MASK)
>>> +#define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
>>>     /* Using intptr_t ensures that qemu_*_page_mask is sign-extended even
>>>    * when intptr_t is 32-bit and we are aligning a long long.
>>> @@ -228,9 +228,8 @@ extern int target_page_bits;
>>>   extern uintptr_t qemu_host_page_size;
>>>   extern intptr_t qemu_host_page_mask;
>>>   -#define HOST_PAGE_ALIGN(addr) (((addr) + qemu_host_page_size - 1) &
>>> qemu_host_page_mask)
>>> -#define REAL_HOST_PAGE_ALIGN(addr) (((addr) +
>>> qemu_real_host_page_size - 1) & \
>>> -                                    qemu_real_host_page_mask)
>>> +#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_host_page_size)
>>> +#define REAL_HOST_PAGE_ALIGN(addr) ROUND_UP((addr),
>>> qemu_real_host_page_size)
>>>     /* same as PROT_xxx */
>>>   #define PAGE_READ      0x0001
>>>
> 
> Isn't this the patch where Richard pointed out that the compiler
> generates worse code?

Richard confused ROUND_UP with QEMU_ALIGN_UP.


r~


