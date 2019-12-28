Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E9DC2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 21:03:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A36B207E0
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 21:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lv+ptIFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A36B207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilJFU-0002cc-Hs
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 16:03:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilJEa-00028Q-BI
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 16:02:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilJEX-000424-UC
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 16:02:52 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40954)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilJEW-0003yA-SI
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 16:02:49 -0500
Received: by mail-pf1-x444.google.com with SMTP id q8so16439925pfh.7
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 13:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=n3ZBdu120SzqT/aV9zyK4g5SerM1O4cdHFmjq7dnWeo=;
 b=Lv+ptIFHj0cralN/l092/7QBHU6gULyafV/9MTjiZhwz8Z0VCHfWu9TYVgiXQtAk6M
 U2iog5nEn4JswPeUBB/t5wa+dxxGtlnEx1C1zWaUhyWeWj+56H805Z/czMrbT44aPL3s
 7i7Wtb3uRQgjhXIb9P/D3dju3TFCrR6BDj4l+AwTXr3aMHT52qIcrzV/3wY9AWoG4OLf
 h/P3OqztYMc7Ky/TWeJyIYp4S+ZoYulZMoCn1N3iHJzodnvazAYAGRUwJJjuRMV2Y3zZ
 2zVGTy2p3RwnPEbOkDfOCevZcNtnSm0wb2ZqZyBr+hBNObjKB59Gg1+SW5Bkp/n+1MQs
 6oIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n3ZBdu120SzqT/aV9zyK4g5SerM1O4cdHFmjq7dnWeo=;
 b=B/qkYKTTovFz5elKbMB2oR4fQRytgLanhKHHTar3K6o2zeJVOlZ08X2h7D5G/Zfgcy
 S5tCsAow6v+5MvgjcVl6yyEt69p6sJ0faCk/3Fu9TmKY6Zgf0LjrrXNnDxR4Y4f8PDHm
 wWhJlTJdb6SAPuJHnfsjhZBMrNSMlxwFKr4LPwUqZCuP5XjVUwIy0eNsHEyyCVEFHPBo
 5+kp4sllhjCJKi4ACx1n7HpkQN3cDgPCAxBXPBsjVWZB9b/6qQbuvIFnf8siwCxBSioS
 xl+M6J7smly9C1NlUHxb1I+xFBVjhVkAf+AI83DKiNpJXfMNpzOP4tLFiLZJNvjv5ICv
 KHzQ==
X-Gm-Message-State: APjAAAXhE+QM+XyxLKwRATKFMysKewF+OQLCTrCnBLuUvvFSKHTHnhVh
 GhROWewppB0Bd+FWlvRRmM+OUOvyCI05Vg==
X-Google-Smtp-Source: APXvYqy9jjeMVCoDSOa1z1vLgut8uY18yT3Jaff3VID+VwuEo8u6CpVj7HWkGsQZEpimMcEm8v07Fw==
X-Received: by 2002:a63:da4d:: with SMTP id l13mr65128202pgj.106.1577566964589; 
 Sat, 28 Dec 2019 13:02:44 -0800 (PST)
Received: from [192.168.1.118] (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id k12sm41401310pgm.65.2019.12.28.13.02.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Dec 2019 13:02:43 -0800 (PST)
Subject: Re: [PATCH v2 08/28] target/i386: Use cpu_*_mmuidx_ra instead of
 templates
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-9-richard.henderson@linaro.org>
 <87o8w2dhb1.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ea211e4e-1317-d59e-9263-8f9d7961d40d@linaro.org>
Date: Sun, 29 Dec 2019 08:02:38 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87o8w2dhb1.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/21/19 4:42 AM, Alex Bennée wrote:
>> +/*
>> + * TODO: Convert callers to compute cpu_mmu_index_kernel once
>> + * and use *_mmuidx_ra directly.
>> + */
> 
> I guess this would only be if it was a significant performance impact?
> They seem to be mainly called for (I assume) infrequently called
> helpers.

Yes, they are infrequent.

But if you expose all of the hidden cpu_mmu_index_kernel() invocations, one
should immediately ask why we're not caching the result in a local variable.
If for nothing else, readability.


r~

