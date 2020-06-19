Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7438AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 21:18:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BF652158C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 21:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oStDwxar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF652158C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmOP3-0003xh-IP
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 17:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmOO6-000334-3i
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 17:17:28 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:46601)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmOO3-0004yP-5e
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 17:17:24 -0400
Received: by mail-pl1-x62d.google.com with SMTP id n2so4401104pld.13
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 14:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sq1njPA0iUN1/hOMXyA0GkP1uP7zzPDoctkkevR7DNI=;
 b=oStDwxar8yW/Oyx8YVHTKPjBiWfM1+RgMlqI2mHbXqHuRGBTNgrqNh0IV+jQ0PhtOV
 aOmTMcnZ/HKKwrJvKR546hpNl0PCoyvjnB6gmZTCHyEZeGIvgFg8ggZ2TBAjyog5cgp5
 FbQSK3OsElv9Ss8WI6vN8OlwKJRANtnQkIYf0ZlzVrCMemmh+tTLRuLt/V2eFs51hb1x
 gUpcjc3hwWyO/vgVvaPjWL6B+bltGCzS7JEVTEuCmTwfkUJeXq/Prj/0qlfJoSZyEihO
 8b9qI66H1r9PiIj7O5dPojUi6RXU3l1IdYzKDLs2Db5PTldwBUnHmNb8cwKB+5sWjTLJ
 Ed+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sq1njPA0iUN1/hOMXyA0GkP1uP7zzPDoctkkevR7DNI=;
 b=dkLC0LmQVUnyhOrVUiuczKGI/xYXEtSILynjzOvu8UdSj4fi4aPDykn58svKTSlLPv
 WjsPZIW1LIroUVDvaJBHySwRyEQS1jUjXMbgj/S8RGBp6w0gX0iQAB++bUWHNALzeFKu
 0hGun/pqTSydpLDMkYRri0xx+eF0KLgtGjDVu5xslCIJBmLT1xY9IcYRjMn59YAV/li0
 8/A2bUi+2gOJ3ckApawbvZrUZTVBlSeX0uld21X0Afh92HSHbtJIcZW8ylJZTM8iBHLQ
 2XUstMJ8TyUkRQh2Yf4L3jmCkHwp8IcpQXC7nda0470/wmCbUtEPc77oXOF9mRrif3y+
 T6YQ==
X-Gm-Message-State: AOAM533Av/nkzqNi/AMYFfoj/YVQC+iJrJ68JPVe2fJKSum5tNzROqi0
 1jgIUYx/tWj8crU7lH8W8D28vHWsEHo=
X-Google-Smtp-Source: ABdhPJzcJhMs5IZUAnjKr5EfFDLoZf9WvraNOCEuYK+ubsNCOtdF4YBe5DNXH2W/SqwkR4sRHC7cIQ==
X-Received: by 2002:a17:90b:3c6:: with SMTP id
 go6mr5584778pjb.224.1592601441466; 
 Fri, 19 Jun 2020 14:17:21 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id n189sm6669040pfn.108.2020.06.19.14.17.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 14:17:20 -0700 (PDT)
Subject: Re: [PATCH 3/6] targetc/ppc: add vmulh{su}w instructions
To: Lijun Pan <ljp@linux.vnet.ibm.com>
References: <20200613042029.22321-1-ljp@linux.ibm.com>
 <20200613042029.22321-4-ljp@linux.ibm.com>
 <0777c1df-6010-ff2a-2bdf-72c381da7cbf@linaro.org>
 <D397FCD9-91C5-4C7B-89EE-67163264A79C@linux.vnet.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <90f154b0-ae66-fc9e-339d-0e4969e3885b@linaro.org>
Date: Fri, 19 Jun 2020 14:17:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <D397FCD9-91C5-4C7B-89EE-67163264A79C@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, Lijun Pan <ljp@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/18/20 10:37 PM, Lijun Pan wrote:
> Do you mean writing two functions directly, 
> 
> void helper_vmulhsw(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
> {
>     int i;
> 
>     for (i = 0; i < 4; i++) {
>         r->s32[i] = (int32_t)((int64_t)a->s32[i] * (int64_t)b->s32[i]) >> 32);
>     }
> }
> 
> void helper_vmulhuw(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
> {
>     int i;
> 
>     for (i = 0; i < 4; i++) {
>         r->u32[i] = (uint32_t)((uint64_t)a->u32[i] * (uint64_t)b->u32[i]) >> 32);
>     }
> }

That works for me.


r~

