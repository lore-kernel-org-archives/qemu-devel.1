Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A394EC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 15:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E0B924652
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 15:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OcG8ofke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E0B924652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icslw-0004R1-JP
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 10:10:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1icsl6-0003v6-VN
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:09:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1icsl5-0000gM-Nd
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:09:36 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38978)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1icsl5-0000Z5-D7
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:09:35 -0500
Received: by mail-pf1-x442.google.com with SMTP id 2so1748188pfx.6
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 07:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=y/AgR35mpHK69lXRFvNC43XsKTUGrLkfChZyzBKdGTY=;
 b=OcG8ofkepuxIfi5KyXLd4cOiWLPUoP2miedNB2AZANXVLv+qW4FAxu4kxMzLoL9Yzq
 JUKJX5OVUwXEh7lbR4TClxdLODOX6bxfvFzRI4SrLaBoOkKFV5r1q1/jY1+OlIWxIiXH
 ukhdRssnVSpD1h0dwvYu+vOtxF5u6TFBgBPyKIjyp9uXw+Dgklj3QXPQoBR/jmc+lDWZ
 IsIs2Fo5U+nSZ+APylcM7E5xPiw3xcRK7cHIbubUfGsxoANJRbZq7tg40PN/OQD2gwnV
 84L7eclahJSP67KgOohY7L/ZE5R12kmyXRaY1TZiUfV5Yb+RNSQvsxvI917uaa0bNNm/
 pFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y/AgR35mpHK69lXRFvNC43XsKTUGrLkfChZyzBKdGTY=;
 b=cfivv/c/d6HtKWY/oXXfY67JWHrJ+t2yAw7NcrFCKgfY+NkyigfHvALcpDPoD4Fy1A
 QEEPoZoAQk2BRe9eZ77wIgMJTo1lGJM4XnRzGpcqDH1Ca37zUKwGTOdIRs8XiszEgbmt
 7TBPn91UK5eLjSzEWQKzcoiiaDfywUWiTg7CHGOC++Gk+ArJ4Sp6xYY5wiR2zAV3+pSo
 bZkaT7fTXCrfM5rZHmrHt5B1DSlvaF+nFoDODQ/jb1Sc+eq5cK5HxBydQEtsJhrUJsGP
 zd9aJ6RASbkk9PY4AemCE8RBo2mVCEkGrpFNt81m4dSQSDsb0ZZrWjra8hAZVwaoS5zp
 E01g==
X-Gm-Message-State: APjAAAXEXMLjbuaTpllxZg5x9EuycR8nSHVvzDsGSMl3q4XxsQ0wCBk8
 23LyulkaIjAmqYDHgzHRyrXZ6Q==
X-Google-Smtp-Source: APXvYqxQKimhmjCKbtCXCzb/NX/anKeCO6IB/nwU4qP/BpRyrS802RPUEuoNt6WkfGc9wm26BnBdHA==
X-Received: by 2002:a63:551a:: with SMTP id j26mr9708823pgb.370.1575558573787; 
 Thu, 05 Dec 2019 07:09:33 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w11sm11867964pgs.60.2019.12.05.07.09.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2019 07:09:32 -0800 (PST)
Subject: Re: [PATCH v4 26/40] target/arm: Update
 define_one_arm_cp_reg_with_opaque for VHE
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-27-richard.henderson@linaro.org>
 <87tv6f7w9u.fsf@linaro.org> <37abfbf0-be00-db96-fbf5-b6d6ea7bb237@linaro.org>
 <87r21j7m2m.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5432c436-d6f7-ab11-dfb5-0f4c9ba47c28@linaro.org>
Date: Thu, 5 Dec 2019 07:09:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <87r21j7m2m.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/4/19 2:38 PM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 12/4/19 10:58 AM, Alex Bennée wrote:
>>>> @@ -7437,13 +7437,10 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
>>>>              mask = PL0_RW;
>>>>              break;
>>>>          case 4:
>>>> +        case 5:
>>>>              /* min_EL EL2 */
>>>>              mask = PL2_RW;
>>>>              break;
>>>> -        case 5:
>>>> -            /* unallocated encoding, so not possible */
>>>> -            assert(false);
>>>> -            break;
>>>
>>> This change is fine - I don't think we should have asserted here anyway.
>>> But don't we generate an unallocated exception if the CPU is v8.0?
>>
>> This change is only for validation of the system registers themselves.  It has
>> nothing to do with the usage of system registers from the actual guest.
> 
> So what is the mechanism that feeds back to the translator?

The existence of a structure in the hash table.

> access_check_cp_reg only seems to care about XSCALE. I guess
> cp_access_ok would trip if you weren't at EL2 but what if you are a v8.0
> at EL2?

This is sanity-checking the structure as it goes into the hash table.  The
version check happens when creating the structure -- we don't create registers
that exist only for v8+ if the cpu is a v7.


r~

