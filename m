Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E412DC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 16:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB75B20833
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 16:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uugigD6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB75B20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibp1F-0005vE-Ku
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 11:57:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibp0Q-0005Du-R7
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 11:57:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibp0P-0004N5-Kx
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 11:57:02 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41353)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibp0P-0004Mh-DZ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 11:57:01 -0500
Received: by mail-pg1-x543.google.com with SMTP id x8so4881142pgk.8
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 08:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MeuV4D6ktxPa/YgEl2UBmPn7x6GUvNqnWKVZFqr0yzI=;
 b=uugigD6cpfvgcFC2IlS928ViBqPEvvedoctgOp//5OYApNLYAhtzondWkwVd31BSPr
 JwMXaHfYVkBLbpaolj5OiiPwqpJDLduCyT8ZxmxChxZKqz8L1EnLVsT229E5iJHPxnOS
 CtwvNwK5rzq3y5XEOWg6sV7ejfqitWc1hmy9kmWu43i+4kIlmHd4J0VAXQF0k5tqtDOH
 3Nls31wxkMrMAkTNloMgNvixwtqwx3KJUtQgdZGeYkSq/49JJvlt8d2dRdExc3IG5L+/
 6QPQzO0z7ghkdtBwtRa+Q+ts+1nVjor5tIR3TbXJMScx/NktgTf/hM5ligwGBRLfs1Gs
 FFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MeuV4D6ktxPa/YgEl2UBmPn7x6GUvNqnWKVZFqr0yzI=;
 b=pBUDWnRMKgcOX++6A7CZZqiZIn8MIbhzN1zOhg9dqcPx9l7Ulb2Y41FfhneFwDLkpd
 YR23NyJ01qUh+1jaS7xSAyUYlQo/IsgnyCGT6YroDtc0D7SiWypeXE8lCn6+tBIotUKr
 zzX4AZ0rdgKNL8ad2y76/t3W+Fj2M7WgDAxdzIF733e7q/Ku/W50iVhGIdrki34ZAxsZ
 1vpAs4IlDbQV7pEHpkvbOfxpjh6ZaRyGtCKifyrigFocyt7S7pe/LewbMTNGNojggr2Z
 vQwcu5BE1ViQpROC8Bz281OMzFGgCMlkv38Xmdq22tLPXOlmyNJti2bS2SozOekyKGF9
 DhyQ==
X-Gm-Message-State: APjAAAWlcCSxNToh7TlP+/rbyEu0Y89ehx8RRHv4RdM1lItm9w51SIvc
 vnkx9ocTuhbyodSEBdzUv3A5Mw==
X-Google-Smtp-Source: APXvYqyOLbBMa6qw/CKGehc/nTrONPFSgu0BQIXkHZJTEPRR4cFTf7y013lfGabVq6fKLkUqIv1IaQ==
X-Received: by 2002:aa7:86ce:: with SMTP id h14mr17978631pfo.248.1575305819965; 
 Mon, 02 Dec 2019 08:56:59 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k19sm1335pfg.132.2019.12.02.08.56.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 08:56:59 -0800 (PST)
Subject: Re: [PATCH v2 3/5] target/arm: Handle trapping to EL2 of AArch32 VMRS
 instructions
To: Marc Zyngier <maz@kernel.org>
References: <20191201122018.25808-1-maz@kernel.org>
 <20191201122018.25808-4-maz@kernel.org>
 <0bc7c461-6b92-2782-4aec-2f649f5bc8cf@linaro.org>
 <d2875338d734fca3e5263b94eaf52c18@www.loen.fr>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9909b304-9e52-6960-4397-b7d33159cebf@linaro.org>
Date: Mon, 2 Dec 2019 08:56:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <d2875338d734fca3e5263b94eaf52c18@www.loen.fr>
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/2/19 4:45 PM, Marc Zyngier wrote:
>> Annoying that there's a bug in the manual -- FPSID is listed as group 0 in
>> plenty of places, except in the pseudo-code for Accessing the FPSID
>> which uses TID3.
> 
> Are you sure? I'm looking at DDI0487E_a,
...
> Or have you spotted a discrepancy
> somewhere else (which would be oh-so-surprising...)?

In DDI0487E_a, page G8-6028:

> elsif EL2Enabled() && !ELUsingAArch32(EL2) && HCR_EL2.TID3 == '1' then
>   AArch64.AArch32SystemAccessTrap(EL2, 0x08);
> elsif EL2Enabled() && ELUsingAArch32(EL2) && HCR.TID3 == '1' then
>   AArch32.TakeHypTrapException(0x08);
> else
>   return FPSID;

within the summary documentation for FPSID.


r~

