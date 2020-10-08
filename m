Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E92C43457
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:32:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 634E822200
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H5NL2iGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634E822200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQZlp-0003aE-8L
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 13:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQZkx-00036J-Tc
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:31:08 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34902)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQZkt-0000iO-Mj
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:31:07 -0400
Received: by mail-ot1-x342.google.com with SMTP id s66so6284411otb.2
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 10:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=H2wSdDtfr6H9va7KWUp0ttV3/y+VVsmoZOWuIN1fJA8=;
 b=H5NL2iGt7VWhAngZVZ7KVET36dxDHqX03Uqive5bD4AusqJOUc56IgaEQH+2B+q7De
 xUyTzam+yljY/VfKysLrAUDjINa5nH9rFMdWHIb+Rtvu6Mei/TS40IUAyAo0MteE9mbo
 1/vM4CQbpVKG9L8nY0nWO+PUYwzrrVfTI141RPyfyO39jQbi20KkwfLrutURuhvqVnil
 TegGmywKDMTZ+LmmtYLmVNdn8TOztNpeZcwSRyyOgOI3uVf5M+frlcEolMz2+emPLkAs
 xdWbMW7V0QMfe45hEQVl6hEJWOIeLkUOJTDGQar/yVYctnZfHdepxsFRj3wnt74Es+rs
 MaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H2wSdDtfr6H9va7KWUp0ttV3/y+VVsmoZOWuIN1fJA8=;
 b=A8nAMerWMsAlRejqhfYIAzinpfxsoeoiO5fILRi2EW5OWemYzIoy7v15evH608hBFA
 uPYWMI/wzMmDDHtdXaWXgFfmawVEaBe5pXMkjcShMV3Bj2HRHwFlxmDzFnx3xvazcZA5
 Bz+ieXdyiOJJNJq6NFJQNeMBg83bN/8GsMga6VOEgg1BBknYP3ejE3DhLXEHECyWIN9n
 pQE9W3rxh7J0JCVTEr/h7T99OcoW1i4ETjAS+NGMlcZmzx9APcg5rDeWGpYMWs35p9m0
 /R44iCAxAL+WMrm4CKHb0GZPunr1L8TWnL5e7prvLKfgahs8G/ueVujjGYHr5bKxXLDz
 V48A==
X-Gm-Message-State: AOAM531TOmhLj8y0T2YDvd8VPxTeKtrVaXDHXkJ/DIcQUTq5NrM0IMlx
 L/JaEQbw0A4ml2b0uJ42Nf0UlA==
X-Google-Smtp-Source: ABdhPJxy1gw8PDDU8NQojTMBPC4h/9L+0lkoFe25miMz2mKwus+9T77dy54JEP7hkKv03letjaCt3w==
X-Received: by 2002:a9d:6a8e:: with SMTP id l14mr1097613otq.343.1602178261234; 
 Thu, 08 Oct 2020 10:31:01 -0700 (PDT)
Received: from [172.24.51.127] (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id z10sm4500743ota.70.2020.10.08.10.30.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 10:31:00 -0700 (PDT)
Subject: Re: [RFC PATCH v3 26/34] Hexagon (target/hexagon) macros referenced
 in instruction semantics
To: Taylor Simpson <tsimpson@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-27-git-send-email-tsimpson@quicinc.com>
 <75d5275b-76e5-38a5-f9a3-f36d1ee08c74@linaro.org>
 <BYAPR02MB4886F48B7E22A43984D78A13DE0B0@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b77feb32-9170-0c19-8147-5a195a227cca@linaro.org>
Date: Thu, 8 Oct 2020 12:30:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB4886F48B7E22A43984D78A13DE0B0@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.214,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "ale@rev.ng" <ale@rev.ng>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/20 10:00 AM, Taylor Simpson wrote:
> 
> 
>> -----Original Message-----
>> From: Richard Henderson <richard.henderson@linaro.org>
>> Sent: Friday, August 28, 2020 7:17 PM
>> To: Taylor Simpson <tsimpson@quicinc.com>; qemu-devel@nongnu.org
>> Cc: philmd@redhat.com; laurent@vivier.eu; riku.voipio@iki.fi;
>> aleksandar.m.mail@gmail.com; ale@rev.ng
>> Subject: Re: [RFC PATCH v3 26/34] Hexagon (target/hexagon) macros
>> referenced in instruction semantics
>>
>>
>> Ah, so I see what you're trying to do with the merge thing, which had the
>> host-endian problems.
>>
>> I think the merge stuff is a mistake.  I think you can get the semantics that
>> you want with
>>
>> probe_read(ld_addr, ld_len)
>> qemu_st(st_value, st_addr)
>> qemu_ld(ld_value, ld_addr)
>>
>> In this way, all exceptions are recognized before the store is complete, the
>> normal memory operations handle any possible overlap.
> 
> Following up on this...
> 
> 1) We don't need to do the probe_read because the load has already happened at this point.


What do you mean "has already happened"?  How can it have done without doing
the merging by hand.  Which this operation ordering is intended to make
unnecessary.

I think you're missing the point.


> 2) I'm not familiar with qemu_st/qemu_ld.  Are these shorthand for tcg_gen_qemu_st*/tcg_gen_qemu_ld*?

Yes.

> We can't actually do the store at this point because it would alter the memory before we are sure the packet will commit (i.e., there might be still be an exception raised by another instruction in the packet).

What other instruction?  Give me a concrete example so that I can give you a
concrete answer.

I think you may need to do more preprocessing of the entire packet so that you
can answer this sort of question (is there any other possible exception) when
generating code.

> 3) How important is it to support big endian hosts?  Would it be OK to put something like this to declare it isn't supported for Hexagon?
> #if defined(HOST_WORDS_BIGENDIAN)
> #error Hexagon guest not supported on big endian host
> #endif

That would make ./configure && make fail on such a host.
So, no, you can't do that.

> 
> 4) If the above is not OK, are the macros in bswap.h the correct ones to use?  Is this pseudo-code correct?
> store_val = le32_to_cpu(store_val);
> load_val = le32_to_cpu(load_val);
> <merge bytes>
> /* store_val is dead so no need to convert back */
> load_val = cpu_to_le32(load_val)

There's some misuse of cpu_to_le32 vs le32_to_cpu there (I've never liked those
names, but it helps to think about what form the data is already in).


r~

