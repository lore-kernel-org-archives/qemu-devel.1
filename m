Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC38EC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 19:30:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 991E02133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 19:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HLS6cjdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991E02133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFNqb-0006WB-S8
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 15:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFNeX-00066o-Nm
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFNeU-0004S0-D7
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:17:41 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39304)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFNeP-0004Ps-PV
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:17:34 -0400
Received: by mail-pf1-x444.google.com with SMTP id v4so8769436pff.6
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 12:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Dk66ow1kaGxqTbU91FsipftG6YfzopVyt64ZORkaZ3I=;
 b=HLS6cjdw6Or0b3o92VbO2kKtvQVLMmCPnrcq/9jFgVTdxdyKtWidcSnmkz04A7wqBN
 oQ1klIY+p2Hi2bw3K77ndXGgAKn6TWuoPzuweTC68ZGcwQkTOKbvCBGNbVw+vXTpzGHi
 k7WE8g3HCwFEZ4sE6jSPF455GDky+8012+BLVyLK4qx2sx9Rcw1q1Ce7xJbkS+aMIIQx
 vPrMmZ1WXbbOcY7zX12lGb5vTDXo3fZiLxyJQ2a3gG5GaGfsGa72oFdPpRrPvGh2kTnm
 LEPMAohyhbKrsYB16rPEWch9IEyl/s1FS28zak2oQFuMDpcqSr7NtjW/jsBl3iDp7z+I
 3KFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Dk66ow1kaGxqTbU91FsipftG6YfzopVyt64ZORkaZ3I=;
 b=htcsJ1z6+bwJowykAWhSx3H6kt04PAf28aHxgdkJfSur4m+c4BXCVLh+dVsYc29psA
 dX9oDWrxkBwIyDsOL3FEZrUvyUk+TeSpaTgQmIUGQFEC9ICAJIhEf5nahy1po9RfeS1X
 NAdV1XL4mZ7uvzPlxvZqyjkYVtuTTwJgSZeIGkr9oIXLXqzdRjxtDintwxA+j7jDM0KU
 j1uX9tTLPawA6HtNProCKsT+120UzRmNnVvT4DXnvFi18M22LWFw9nJZUEgh1sPqzRMa
 5AWFECGbazVfkdH11hcvrQoub/vDUjdDoKMnqGK2paTWvCdBwMXP0iS4h4uDPkQIrhv8
 J64Q==
X-Gm-Message-State: APjAAAUDLh0sXW6d5h8m/YpeH8R+Gt9ktv9TLfL6T9W6UIX8zVJKBdUy
 Pk4aet/KybYOgwAGcpSTHBqWIg==
X-Google-Smtp-Source: APXvYqxysgU4KdTuj038KkjSrfxjdNlVDRc5GW5voG3pB2rOB2s3TadrQxoUACiJeB4MsZOHjOu3zA==
X-Received: by 2002:a63:9144:: with SMTP id l65mr5566997pge.148.1569957452361; 
 Tue, 01 Oct 2019 12:17:32 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id p190sm23603979pfb.160.2019.10.01.12.17.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 01 Oct 2019 12:17:31 -0700 (PDT)
Subject: Re: [PATCH v1] s390x/tcg: MVCL: Exit to main loop if there are
 pending interrupts
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20191001181655.25948-1-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <720221d3-84a6-9940-812e-b427acfc99ed@linaro.org>
Date: Tue, 1 Oct 2019 12:17:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001181655.25948-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/19 11:16 AM, David Hildenbrand wrote:
> +static inline bool should_interrupt_instruction(CPUState *cs)
> +{
> +    /*
> +     * Something asked us to stop executing chained TBs, e.g.,
> +     * cpu_interrupt() or cpu_exit().
> +     */
> +    if ((int32_t)atomic_read(&cpu_neg(cs)->icount_decr.u32) < 0) {
> +        return true;
> +    }
> +
> +    /* We have a deliverable interrupt pending. */
> +    if ((atomic_read(&cs->interrupt_request) & CPU_INTERRUPT_HARD) &&
> +        s390_cpu_has_int(S390_CPU(cs))) {
> +        return true;
> +    }
> +    return false;
> +}

The first condition should be true whenever the second condition is true.

In particular, tcg_handle_interrupt sets icount_decr.u16.high = -1 for
qemu_cpu_is_self; otherwise, qemu_cpu_kick calls cpu_exit which does the same
thing.

Think of it this way: we only test icount_decr.u32 at the start of each TB, and
that's the only thing we have that brings us back to the main loop for any
other kind of interrupt.


r~


