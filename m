Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6703CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 20:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D3F72100A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 20:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xIr/NJvZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3F72100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmNts-0002n7-C1
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 16:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmNsx-00019C-9o
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 16:45:15 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e]:33436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmNsv-0007bO-EM
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 16:45:14 -0400
Received: by mail-pl1-x62e.google.com with SMTP id 35so4392194ple.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 13:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FnnzkFqi3jNdpOGhGULFv4079oGowRF2t/8s+taLUmw=;
 b=xIr/NJvZHcU/zzc2YBEJQdpjoRyBy67d9v0CdHxfUOSicK40GS3TgCXay5/skI1Yhi
 g0W+RtOJUQbPihC1kXOPyQHcSUexuZfSb4rywGX2uiCl/RFlU4wA2YGEwGQ2iP9aeGB1
 hzIOFgzes7i0IWLPnZcnrl1n8ppiqAMgy9UBtTR6N9uuONyVNo04BlMKdX9gWHy0wiz6
 5CG19mCbh3oTiszhH/+yv+lyfUPVSH5pG3ap8jlCE2vSQ26wVfmob/leDVrvTRrjwHjy
 m9ZFsjcYOPxAGNiFtEJR1his+n3smstrvznSF2KEn6OPr+5FKU6QaFXG5br9CCiqZON+
 kYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FnnzkFqi3jNdpOGhGULFv4079oGowRF2t/8s+taLUmw=;
 b=GOVsiFhFEdvwg+AWjHHi0y/6z982ug71hsNHTPvNGxF94wXLNvOto4tj5qeZIpzfzl
 dlYt4eZQ0xmOH2q8l359EBdUDz09dfcRhZKV+bLGUJJp4K0+bRwR7SdX2cLg5Z2X3+M8
 75Bo90wCMCVjGhEJmyI5AMZw3h6JBy8vDCMC4HAljYlQ8HVjpctzGtEAf4yY9AnmLj4K
 BMpqFGx2wk+E0Ff63CWtzbvQeZz+IO//vB9pBWm7eZMFyz2V8dQrQsev8ErkEGKe89WJ
 QTg/zhXZI8Oe6HxBIjuSI87Qeipthp8lfket38HvcQrKgU0TuCf1wWTUMgLWGcU9XTtv
 Hu+A==
X-Gm-Message-State: AOAM530CQ6Qj9iC1bxv9UkxI3UqnJVO0Z7KwZXFDHc+4dWT9U8KTHTR+
 qahCcxw9wbNEL3TJ8UpZoVgYFtz/oHo=
X-Google-Smtp-Source: ABdhPJx3ExZ7QBaIZeMP1/Xu2xMi2s2P66CEKybHI5nBCmboZAV5cDYjd3zuEZdCd0ehNJp5krn9EA==
X-Received: by 2002:a17:90a:326d:: with SMTP id
 k100mr5528888pjb.191.1592599511132; 
 Fri, 19 Jun 2020 13:45:11 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id e124sm6449780pfh.140.2020.06.19.13.45.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 13:45:09 -0700 (PDT)
Subject: Re: [PATCH v2] target/ppc: add vmsumudm vmsumcud instructions
To: Lijun Pan <ljp@linux.vnet.ibm.com>
References: <20200613035546.22041-1-ljp@linux.ibm.com>
 <4f0e24af-5043-98d3-0f7b-e8d460bac617@linaro.org>
 <73404995-1D90-4E2B-A328-CA5C47C933D5@linux.vnet.ibm.com>
 <13dac383-7d04-faf2-7a87-c4e92e693148@linaro.org>
 <772D8DFD-8784-435A-AB9B-E0A78B12A7E4@linux.vnet.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e7207e62-001b-6160-1b0f-bbcfb820b64e@linaro.org>
Date: Fri, 19 Jun 2020 13:45:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <772D8DFD-8784-435A-AB9B-E0A78B12A7E4@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/18/20 10:10 PM, Lijun Pan wrote:
>> Unfortunately, I can't find the v3.1 spec online yet, so I can't look at this
>> myself.  What is the instruction supposed to produce?
> 
> https://ibm.ent.box.com/s/hhjfw0x0lrbtyzmiaffnbxh2fuo0fog0

Thank you.  So it really is the sum of an input and two separate 64x64->128 bit
multiplies.

I suggest

void helper_vmsumudm(CPUPPCState *env, ppc_avr_t *r,
                     ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
{
    Int128 sum;
    uint64_t lo, hi;

    sum = int128_make128(c->VsrD(1), c->VsrD(0));

    mulu64(&lo, &hi, a->VsrD(0), b->VsrD(0));
    sum = int128_add(sum, int128_make128(lo, hi));

    mulu64(&lo, &hi, a->VsrD(1), b->VsrD(1));
    sum = int128_add(sum, int128_make128(lo, hi));

    r->VsrD(0) = int128_gethi(sum);
    r->VsrD(1) = int128_getlo(sum);
}

void helper_vmsumcud(CPUPPCState *env, ppc_avr_t *r,
                     ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
{
    Int128 sum;
    uint64_t p1lo, p1hi, p2lo, p2hi;

    mulu64(&p1lo, &p1hi, a->VsrD(0), b->VsrD(0));
    mulu64(&p2lo, &p2hi, a->VsrD(1), b->VsrD(1));

    /* Sum lowest 64-bit elements.  */
    sum = int128_make128(c->VsrD(1), 0);
    sum = int128_add(sum, int128_make128(p1lo, 0));
    sum = int128_add(sum, int128_make128(p2lo, 0));

    /*
     * Discard low 64-bits, leaving the carry into bit 64.
     * Then sum the higher 64-bit elements.
     */
    sum = int128_rshift(sum, 64);
    sum = int128_add(sum, int128_make128(c->VsrD(0), 0));
    sum = int128_add(sum, int128_make128(p1hi, 0));
    sum = int128_add(sum, int128_make128(p2hi, 0));

    /* The result is only the carry into bits 64 & 65. */
    r->VsrD(1) = int128_gethi(sum);
    r->VsrD(0) = 0;
}


r~

