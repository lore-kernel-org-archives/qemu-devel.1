Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B816C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 17:06:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AACE206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 17:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gVrFXbRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AACE206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwqnZ-0004K9-B9
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 12:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwqmj-0003hv-70
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 12:05:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwqmh-0004xH-Cr
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 12:05:48 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33129)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwqmh-0004w3-5f
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 12:05:47 -0500
Received: by mail-pg1-x541.google.com with SMTP id 6so95602pgk.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 09:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+zN1pkKq1oz2sKf5PNAJNK2rTWQFEmWAmYPEH0wv3RU=;
 b=gVrFXbRVNJGayeDPpBuOXAOPifgiWF79Rfe9Tb+WaKcjbR/lKU475Wde9BWw1MUNWp
 MPMWy3stGpOX/3iq5mY+C3am0H/EPzkn7vWUtxDxL3+Ot6IIaJ2N4fRVO5qk4LsQmUnu
 no7DOKZEcOllI8/9XaEQf27ShGLi5CgCi1w3qlJt9JKpOu2EjC4RwwOiOnn+bmanG3xd
 pxwu42EZHkuyAgg9kRqP1bvFHgmq4i4pZI2woNrGNpsIhltXVz9mAdkewfjFKLOJymt7
 PYRj+vINiA63hI0vobRFRapNrgyAz/3/Wr+kVn0qUvhU7WqEpn1//3uUua8G4vuAqM/d
 scAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+zN1pkKq1oz2sKf5PNAJNK2rTWQFEmWAmYPEH0wv3RU=;
 b=FGKnGaS9xZKQFBusF39gUlot9y7He6EAV+SirIrG8ScRGZzxMBkJx73yR0OEhZWNRg
 NCrL3RbhUdbF/fdgJzo/wqeo9oJGge7HpUJ2/k31eLi2gCiSOOf+4sWBkfY0vOmlmvHR
 RS/G8C5kfmebeiP2bRgpnP3uLyWDgZPYbHv7mmI/vyp8loAUOK4LEk5g7R0Z6d3uY9Xq
 vwjQmijcq7Kd/sAza9Nt87CSrlEwtriZPMySoPA6yooJLsBqj+1GQKHXYyn0uyuQ2Q8o
 tgzUVUcE8GjHpf4EGeHYvGSTaAc1E0iJcrq6lGJOXNR5tPSNC97p+Wz1iIsW91QNKVo/
 0P8Q==
X-Gm-Message-State: APjAAAUOBX6YiIxNfWNGBiPkK289iVTgWl9JVI2+FLtcGgRyGMLLfEfx
 7cliulDbox5UB4OcQ+zJ0SGN6A==
X-Google-Smtp-Source: APXvYqwOWvxbFBS53cP9aXF5Nsgdf71oEAKtJGikLmtEdkvasFs2Pn5izI0Bu2PfDcccmxWoIZTCQA==
X-Received: by 2002:a62:2a07:: with SMTP id q7mr510398pfq.153.1580317545925;
 Wed, 29 Jan 2020 09:05:45 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 w4sm3237166pjt.23.2020.01.29.09.05.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2020 09:05:45 -0800 (PST)
Subject: Re: [PATCH v4 30/40] target/arm: Flush tlbs for E2&0 translation
 regime
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-31-richard.henderson@linaro.org>
 <CAFEAcA-=s0rd78PUQSLV3j0xM4RdynxGv6jUYaYUqMVExsZb8A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <768e2785-9336-0eeb-4296-4608fd541d9d@linaro.org>
Date: Wed, 29 Jan 2020 09:05:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-=s0rd78PUQSLV3j0xM4RdynxGv6jUYaYUqMVExsZb8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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

On 12/6/19 9:14 AM, Peter Maydell wrote:
>>  static void tlbi_aa64_alle2_write(CPUARMState *env, const ARMCPRegInfo *ri,
>>                                    uint64_t value)
>>  {
>> -    ARMCPU *cpu = env_archcpu(env);
>> -    CPUState *cs = CPU(cpu);
>> +    CPUState *cs = env_cpu(env);
>> +    int mask = vae2_tlbmask(env);
> 
> Why do we use the 'v' mask function for a non 'v' TLB op?
> 
>>
>> -    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_E2);
>> +    tlb_flush_by_mmuidx(cs, mask);
> 
> The spec fror TLBI ALLE2 doesn't say it depends on
> what the E2H setting is. It says it flushes all entries
> for either NS EL2 or NS EL2&0 translation regimes.
> Wouldn't that be
> ARMMMUIdxBit_EL20_0 | ARMMMUIdxBit_EL20_2 | ARMMMUIdxBit_E2
> ?
> 
> Contrast TLBI VAE2, which does say that the entries it
> flushes depend on the current setting of HCR_EL2.E2H.

Hmm.  True.  It would seem that ALLE1 has the same bug, because I confused
matters in 4a354502869.  Will fix both.


r~

