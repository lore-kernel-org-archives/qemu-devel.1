Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF38C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 15:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFEF4205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 15:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SNGb0Vyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFEF4205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTRoP-0006lf-Dc
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 11:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTRmP-0005l9-Sn
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 11:05:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTRkN-0007D1-52
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 11:04:13 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:39967)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jTRkM-0007Bg-LP
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 11:02:06 -0400
Received: by mail-pl1-x643.google.com with SMTP id t16so8465301plo.7
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 08:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=51pRypiGFKSGI4pYYYy/oWUaBflFIbs/RrLf++hBG20=;
 b=SNGb0VyuRnRh3WVgHha7whyhblwGUKS5Ilsatd6ThWGikhGmviLo1J0B6KbcRSfvXs
 caT2RF2ykTsjZS0CMMnwpYNONjvAIlouYmJkwuWNfg9THyPDPyC9JlzmDFiMLSTkIfBG
 loIhFtwnuxK8CRfkxYfRvzZfFPCCARAAQzvxW05Efhv/FK6q4g3klXI1JVMhTIwO7uSC
 bllBRnCQQCOm2kmP5ql6svaV1njZbjaAm+D91fvxOIC8FeSF1YyQ0vwVHwaerLKip3DB
 cEqAs290R1eNKStR05RQYO4gTo6BsUKDLioazCXtlcCksr0/kbsbp97P3fhyKbkS/mFl
 lovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=51pRypiGFKSGI4pYYYy/oWUaBflFIbs/RrLf++hBG20=;
 b=b7CupncQ2sj0bFjutewS9oKhl2QnDKQ0o36OrQwjIKiWiFaaJ4TzahumsrvYjggB8q
 KN5u7gblkjuR6xsgsRS9sC6Csr2mWfKnalWMRJ01lLRFKz8FrYCjOSjh5iD2j6jsmpCS
 t9l01jTn9Vftxjwt/ASy44To+HiRdjWPpdB5BZnqjCyAZOz98EgJqa2/b9FzzDw1hWRw
 xZH8/Bd/FAMXOOkNxWgpAJnEVQnYKZNwhq2uDKBClcoQWPc8SUUmsePX9ia9jROM01l1
 JzvH2OGHQKdEr88swoChQ/dRR8EpXFNaV5sxsFQr4tA0QiDrtwQBnZ8bK6VxdPf647fJ
 rKDg==
X-Gm-Message-State: AGi0PuZ/uDMFHjA5qPzfQ1q7bhlP+7M5AYeB+o77AHFKO2B6Lse9WPeO
 led96pG+ZSHfWMekf/pohl44Lw==
X-Google-Smtp-Source: APiQypIEdxLMy5vPcIjOv6L4SuwKYa+3vtDteaMNS3VEpC2eRbNDzxlV5lVDpBTNWZ4FeNsF2OiHQA==
X-Received: by 2002:a17:902:5a03:: with SMTP id
 q3mr11264040pli.45.1588086124325; 
 Tue, 28 Apr 2020 08:02:04 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id w66sm15307675pfw.50.2020.04.28.08.02.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2020 08:02:03 -0700 (PDT)
Subject: Re: [PATCH v3 13/18] target/arm: Update contiguous first-fault and
 no-fault loads
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200422043309.18430-1-richard.henderson@linaro.org>
 <20200422043309.18430-14-richard.henderson@linaro.org>
 <CAFEAcA8oWP9XGzD+pb_VhDth8zx8j1Gz4vwiK+dArpw8x1BmqA@mail.gmail.com>
 <22c1fd55-7cd3-6320-1f90-40d1bd2cc883@linaro.org>
 <CAFEAcA-iqrEi_wQ+mBN1NtrEKq3uDYPoDunqW5e9KV6ivz3-SQ@mail.gmail.com>
 <d148806b-c7f1-fefc-bfb4-fcefb81ab509@linaro.org>
 <CAFEAcA-iJWqPQ-SwukaBcxgNFppAmeZNUR2doz6sgV6RduC32A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <df19b271-55ad-9071-2790-d0d4991fe831@linaro.org>
Date: Tue, 28 Apr 2020 08:02:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-iJWqPQ-SwukaBcxgNFppAmeZNUR2doz6sgV6RduC32A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 11:38 AM, Peter Maydell wrote:
> I would suggest something like:
> 
> +     * From this point on, all memory operations are MemSingleNF.
> +     *
> +     * Per the MemSingleNF pseudocode, a no-fault load from Device memory
> +     * must not actually hit the bus -- it returns (UNKNOWN, FAULT) instead.
> +     *
> +     * Unfortuately we do not have access to the memory attributes from the PTE
> +     * to tell Device memory from Normal memory. So we make a mostly
> +     * correct check, and indicate (UNKNOWN, FAULT) for any MMIO.
> +     * This gives the right answer for the common cases of "Normal memory,
> +     * backed by host RAM" and "Device memory, backed by MMIO".
> +     * The architecture allows us to suppress an NF load and return
> +     * (UNKNOWN, FAULT) for any reason), so our behaviour (indicate
> +     * fault) for the corner case of "Normal memory, backed by MMIO" is
> +     * permitted. The case we get wrong is "Device memory, backed by
> +     * host RAM", which we should return (UNKNOWN, FAULT) for but do not.
> +     *
> +     * Similarly, CPU_BP breakpoints would raise exceptions, and so
> +     * return (UNKNOWN, FAULT).  For simplicity, we consider gdb and
> +     * architectural breakpoints the same.
> 
> assuming my understanding is correct...

Yep, thanks.  I'll merge this text.


r~

