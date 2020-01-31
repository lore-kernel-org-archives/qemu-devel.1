Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1099C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 20:20:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94CEF214D8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 20:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VXJ6BYvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CEF214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixcm1-0007Hj-MX
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 15:20:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ixclS-0006t0-5R
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 15:19:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ixclR-0002dg-2F
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 15:19:41 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36993)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ixclQ-0002d0-Ph
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 15:19:41 -0500
Received: by mail-pf1-x443.google.com with SMTP id p14so3897698pfn.4
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 12:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ut9gpvG2ZZRQISR5EgEaMhq1QMcGI/j/zYvJc9MMg78=;
 b=VXJ6BYvIaOflZbpNJF+MNpPPSPpnOvD+VhtVSBkIvrlBZSMhwfip6Tk8fwnlRWpbeU
 /7I6o1jvbQlVoHdyMpzC5nD41MlpRnJt2IqOJKUMkP9B/urp1mS+aR/TZ+dw4tH5p0gi
 REx+h2jd7Psfixi6miNu83bXPN5Of03HUtJiz7QEBaxUD+twxUNuIpCzqc9CEsnqj2ST
 BBRsCUS7ZD16XMZBtqqXuYIiI2NPrBJ31tGm/mMRmhnhRPaR1pcPBEFjopTK0SmJ1FZT
 GWB74jgwtyPZ2Hq4RYH24kUI+46LF/9KtwK5+HJj5T9ULDsKKTBaoKwiC+uKhztdOcFx
 BQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ut9gpvG2ZZRQISR5EgEaMhq1QMcGI/j/zYvJc9MMg78=;
 b=T5eUvao3EIB7Od0Fc9guE1zBqM7yZtSD6M49JAEp0nleLJysKxL/BDdACpnatUH4VP
 sPd9/OGCHotgdadqPtV4QIYjvRGMDKsW8zKyfOPGkVmXpi4cSPZwapxyOLopodH/1V+E
 FZLqyPd4xBQjbZ0DVgOWSbgfCeuDefLPb/8rtpL3EbR0PoEJe+hR8s9fYWdmxz6TqHhi
 sui2Ke0j31loxSBbRkBxRe3CJUt5Tn6soCQAkRL7qzslb2NPjm/MAPNiuNcwuB7hSalT
 k2BILIEHPIHk56IsuipjndSqJGs+gUFRYzZW4asQOlYuWgWHUfCmdnI4rAGwF4ARbrwx
 Knaw==
X-Gm-Message-State: APjAAAXRcgOicFgh5OtX6UaZJQadXEiSQOckdMzRJuwFewCbEyDIw0P9
 lO3DdMBrKeK1p5CJxbegsjYC0w==
X-Google-Smtp-Source: APXvYqyJsXdYePgv+FNyiXOyH0MchwHTycWa+QnnFsajxCL2ws0qcqxUnAZwX8LirH+Mb+sQxijPbg==
X-Received: by 2002:a63:7744:: with SMTP id s65mr11851585pgc.312.1580501979227; 
 Fri, 31 Jan 2020 12:19:39 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 t28sm11467742pfq.122.2020.01.31.12.19.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2020 12:19:38 -0800 (PST)
Subject: Re: [PATCH v5 30/41] target/arm: Flush tlb for ASID changes in EL2&0
 translation regime
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
 <20200129235614.29829-31-richard.henderson@linaro.org>
 <CAFEAcA-FnhiRuFG49ZJ3s9OUb2VAqKtJAnceMQ8GOOyJtmHDnQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a7bb9abe-b364-883f-6202-a3fc5e3ee72e@linaro.org>
Date: Fri, 31 Jan 2020 12:19:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-FnhiRuFG49ZJ3s9OUb2VAqKtJAnceMQ8GOOyJtmHDnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/31/20 5:11 AM, Peter Maydell wrote:
>>      { .name = "TCR_EL2", .state = ARM_CP_STATE_BOTH,
>>        .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 2,
>> -      .access = PL2_RW,
>> -      /* no .writefn needed as this can't cause an ASID change;
>> -       * no .raw_writefn or .resetfn needed as we never use mask/base_mask
>> -       */
>> +      .access = PL2_RW, .writefn = vmsa_tcr_el12_write,
> 
> This blows away the entire TLB on a TCR_EL2 write, which is
> safe but a bit overzealous; we could skip it if E2H was clear
> (and probably also be a bit more precise about which TLB
> indexes to clear). But it's not a big deal so I'm happy if
> we leave this as-is.

Yes, it is overzealous.

I once had a patch set that attempted to track actual ASID changes and also
contained the set of tlb indexes to clear.  I thought about incorporating that
here, but decided against.


r~

