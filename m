Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C85C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 17:57:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AFFC205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 17:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d3LPthwq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AFFC205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDBXE-0001IN-4t
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 13:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDBWD-0000k9-Bo
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 13:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDBWC-0008Ii-2O
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 13:56:01 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33228)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDBWB-0008ID-Q5
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 13:55:59 -0400
Received: by mail-pg1-x544.google.com with SMTP id i30so296351pgl.0
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 10:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=v+syrApcrMsvu4H21xycRc0iR43xVWWnHSl+gyh3/70=;
 b=d3LPthwqPWGUFE27kQoLfKmG6F6IdIldKvLYXYkeWkOxg5rcIIizqfDoHdubkmlA/m
 d41ELaMgm9ZWtxI4g7YL2is3VtnNNhIHQVAGJFCz2h8KkA2NH3x7TxnYV/vKMhgXiIYJ
 NBhiA9RRXWiMKMa3ojZuH+KcFmO7+BuFfRNEF2wxTNAjPXWBiW0u1203gHNw6Up1ZkHT
 O3BaPpoXaZuAOhTbGfCbuIgUWZWA7hlKJqLvmA2JVqWTsRq7UAS3pV+Js43E44+1ekoN
 jhcF2KOvacaPsc1DeWzhBG2rIIQ3H1CzaDc/m/0fwTfKYuj7lMrkDV5VA/6OvVxrvS0t
 Mz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v+syrApcrMsvu4H21xycRc0iR43xVWWnHSl+gyh3/70=;
 b=TkP/HHjf+SzwKbAH9AV3+WJZaNeXnsGqG0f9CsgsrTIBQgriFrx3JE8C9MIET5dGQ/
 dunm1N0UgYbS6dkQNj9W6HzLZELwxyUJDL2y9tXeySfxe8hG4zyECvb5hdhvfuXV4WCk
 vHylBPzDuRtoi08aCcduIeccl4DB99fwg9FTm2Yyk5m+6fZO8KR+Wm8f0A5P0SIKDqJq
 zogbVmYjUzn6Flkwtum379/Ee2Wm2cJR+2WXXQ7TtyceTtRI/sivzPYYlW+t5z2xDFRu
 je0pg8oORJHEGOzR/ntLkY5Jz90g9Nc8LeTkkgBPlPF4xHp3mqw+ORHRPwBX2TfpbF9d
 NG8A==
X-Gm-Message-State: APjAAAW7ssLM+3qVgIr8jrWEfovJUuLIEzYpicWfWHTx8CUZQm9Jdx2X
 T8i9fUdHCAJoytSww97ZoXTnPQ==
X-Google-Smtp-Source: APXvYqxsj7/N9ioPiOsS5x6UV/3CWq2vfET5miBlJ+PrtbVZG8fLNXWrcOmMCoxtZDcgqGShPmjnAg==
X-Received: by 2002:a63:4a47:: with SMTP id j7mr508157pgl.399.1569434158405;
 Wed, 25 Sep 2019 10:55:58 -0700 (PDT)
Received: from [172.20.32.216] ([12.206.46.61])
 by smtp.gmail.com with ESMTPSA id v8sm12116827pje.6.2019.09.25.10.55.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 25 Sep 2019 10:55:57 -0700 (PDT)
Subject: Re: [PATCH v4 10/16] cputlb: Partially inline
 memory_region_section_get_iotlb
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190923230004.9231-1-richard.henderson@linaro.org>
 <20190923230004.9231-11-richard.henderson@linaro.org>
 <c61bc143-81d3-5198-fbdd-054777faafe0@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c396f679-d100-2f1e-012e-045ad0976268@linaro.org>
Date: Wed, 25 Sep 2019 10:55:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c61bc143-81d3-5198-fbdd-054777faafe0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/19 12:59 AM, David Hildenbrand wrote:
>> +    is_ram = memory_region_is_ram(section->mr);
>> +    is_romd = memory_region_is_romd(section->mr);
>> +
>> +    if (is_ram || is_romd) {
>> +        /* RAM and ROMD both have associated host memory. */
>>          addend = (uintptr_t)memory_region_get_ram_ptr(section->mr) + xlat;
>> +    } else {
>> +        /* I/O does not; force the host address to NULL. */
>> +        addend = 0;
>> +    }
>> +
>> +    write_address = address;
> 
> I guess the only "suboptimal" change is that you now have two checks for
> "prot & PAGE_WRITE" twice in the case of ram instead of one.

It's a single bit test on a register operand -- as cheap as can be.  If you
look at the entire code, there *must* be more than one test.  You can rearrange
the code to choose exactly where those tests are, but you'll have to have them
somewhere.

>> +        /* I/O or ROMD */
>> +        iotlb = memory_region_section_get_iotlb(cpu, section) + xlat;
>> +        /*
>> +         * Writes to romd devices must go through MMIO to enable write.
>> +         * Reads to romd devices go through the ram_ptr found above,
>> +         * but of course reads to I/O must go through MMIO.
>> +         */
>> +        write_address |= TLB_MMIO;
> 
> ... and here you calculate write_address even if probably unused.

Well... while the page might not be writable (but I'd bet that it is -- I/O
memory is almost never read-only), and therefore write_address is technically
unused, the variable is practically used in the next line:

    if (!is_romd) {
        address = write_address
    }

which will compile to a conditional move.

> Can your move the calculation of the write_address completely into the
> "prot & PAGE_WRITE" case below?

We'd prefer not to, since the code below is within the cpu tlb lock region.
We'd prefer to keep all of the expensive operations outside that.


r~

