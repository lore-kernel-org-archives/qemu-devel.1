Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FD3C3402F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 00:51:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC0C520801
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 00:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rh161K9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0C520801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3r6U-0003bN-SK
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 19:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3r5f-0002y0-Km
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 19:50:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3r5e-00031n-Ba
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 19:50:19 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44002)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3r5e-00031D-56
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 19:50:18 -0500
Received: by mail-pg1-x543.google.com with SMTP id u12so9708461pgb.10
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 16:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qX+ns+h1enFhZdytzkhMcZ0cr1TdMMWet4M2Y6Y05es=;
 b=Rh161K9GrvRCtssURtPENdF/I8CD7uLG137/dx4SbX/VomUSI+5DwoZu59wCoMTFbX
 9HgW5D7lH+PT40VBW7u17u9AU2HCS+G1xei2pO6rtzA9ATWZXYc9cQ+fJsypuCwSuiLJ
 8HpJk0erPNb5U+HUdP3SZsvnAQMxqzUANVlwS/0y5hO4xa8V+DwnbPQW07Dgxp6b8Jf6
 nTCv9tzsgbKSM/yP0X8+NmXcntO0Tc7CNyBaMtd9xX0A5ZTAQr/DI2vwxVZvlDb+b7bb
 GcWZWwPk2ZE7Q/aU2Z0Qd8l2rsotkA8+1+NfhPaEOgDbhvUpWJyoquxRpcPfPVziPdWF
 mGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qX+ns+h1enFhZdytzkhMcZ0cr1TdMMWet4M2Y6Y05es=;
 b=RJ5qT1t+YS+MsDk2KOLq8Uxh1iJHuMtghCToKg71R//HRhxgGsWtjsN4Ju162S19tb
 BaFZVNqyNjLmcwJq/Q5QQ8MUdVrpXaFoVcPRoUYTBOAo1aSjyvg4/d5tvv8wqhOFRVtH
 wXZQNSvEXf791AiP1ywnmDTvQwZu7sb2GW43NrpA9dVJj434gBE9mp00YLn64ZD5uZp3
 36nImJ9KD+ltudemhsTPpxWI29qm3WfC42EIMDlYOpL3uhmPiH1+0VxnSftTwZdxG5Wy
 dKVUrTMdTuS5vl2dphEG130AJvM4B9aTnkSGO0xthxF6ju2P0UtQImUWDroPSoE1Apoo
 HQWw==
X-Gm-Message-State: APjAAAVdPvXbihElcZYup3pQai/mR0rbiaEr/GR1A41X6YuqPD4rAvDg
 1Ng/ihaTLAUGzRRw3ULfZvBbjA==
X-Google-Smtp-Source: APXvYqw/PedPAqomD8AzDmunTfB4HSpX07/yAEDoKnLqQe97F+gQ//pp2vCaTm2iMyiQXo2lNomTNA==
X-Received: by 2002:a63:9214:: with SMTP id o20mr20266854pgd.146.1581987016739; 
 Mon, 17 Feb 2020 16:50:16 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 o10sm2000732pgq.68.2020.02.17.16.50.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 16:50:16 -0800 (PST)
Subject: Re: [PATCH v5 15/22] target/arm: Clean address for DC ZVA
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191011134744.2477-1-richard.henderson@linaro.org>
 <20191011134744.2477-16-richard.henderson@linaro.org>
 <CAFEAcA86hhBNLWhAe2UY+0-pS65wpSdPKFPTA9O4m9avjECxaA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3193d3bc-230a-8770-ffd8-d15d26c75ef9@linaro.org>
Date: Mon, 17 Feb 2020 16:50:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA86hhBNLWhAe2UY+0-pS65wpSdPKFPTA9O4m9avjECxaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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

On 12/5/19 10:58 AM, Peter Maydell wrote:
> On Fri, 11 Oct 2019 at 14:50, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> This data access was forgotten in the previous patch.
>>
>> Fixes: 3a471103ac1823ba
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/translate-a64.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
>> index 4e049bb4aa..49817b96ae 100644
>> --- a/target/arm/translate-a64.c
>> +++ b/target/arm/translate-a64.c
>> @@ -1766,7 +1766,7 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
>>          return;
>>      case ARM_CP_DC_ZVA:
>>          /* Writes clear the aligned block of memory which rt points into. */
>> -        tcg_rt = cpu_reg(s, rt);
>> +        tcg_rt = clean_data_tbi(s, cpu_reg(s, rt), false);
>>          gen_helper_dc_zva(cpu_env, tcg_rt);
>>          return;
> 
> ...doesn't this mean we don't do a tag check for DC ZVA?
> Or is that handled in the helper ? (I guess it has to be,
> the DC ZVA will span multiple tag granules).

It isn't clear to me that DC ZVA does check tags.  There's no pseudocode for
DC_ZVA, which is less helpful than it might be.

I suppose one could infer it from "behaves as a set of stores to each byte
within the block", but considering that stores are both checking or
non-checking depending on addressing mode etc, I'd have preferred an explicit note.

So far I'm treating DC_ZVA as unchecked.


r~

