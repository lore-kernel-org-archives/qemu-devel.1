Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA05C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:48:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C804620659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fd8Ovthm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C804620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFq0-0002qe-80
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:48:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1idEt9-0000O0-FL
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:47:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1idEt6-0003kr-TJ
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:47:21 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:41811)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1idEt6-0003dl-9X
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:47:20 -0500
Received: by mail-pj1-x1041.google.com with SMTP id ca19so2832436pjb.8
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 06:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ou2NIgpCqpSNreFVd54xN+SCEb16nwgso+pX/SawtfY=;
 b=Fd8OvthmQkw/GsY6S905ylcQrpZ884BcwuhMOHSNo3zAU6sVr6aJsKGQ6sTxDKHTvM
 pTMYt8b9JFDOSQq26xLJGTitsjohWxFB2O27kHIUvIvxtR/WXWcCTR4dasGUkm6BdFa7
 zfwh2dx0/R4YnOQNj59d3zlRuMs6G04Wz1jDAMSaja33x4jxctSgQrykxGQcz2+nACgp
 sgnPomnHoj0w0624Q67w8RnJdMejqRWI8ymO+s+BLS9Y78pV7ru8KIImDlY6l+AGD9nn
 XF4+wSFsllcXoge+1N7BtZ0gFeSF05PdEcCLO/pFKg1N5slAFOaFvUOpIsa5PWeGDHgR
 lRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ou2NIgpCqpSNreFVd54xN+SCEb16nwgso+pX/SawtfY=;
 b=tyCXtm3d/KnV3uad1Amo75t2j3GL+E8mf897BFz9UVWlZcupSUZQ4Qxg3TYljbn0wv
 XSVPYwcpECQ2ISo0VXRoLIRj+oOjGVbuPQD+PN9Hp33Gp+/S3JGD3IC75OdG6kmU2X2M
 WkmY5suSsYQAPRDfAHfIoAT4/GtIqUm+FFD3FbjtiPi2i9Q+XHDH6+cIsBsZh9OTKtea
 XfiUnR5k2FhUipP4svn5pa7u27ytb0zmEBKSXCsTlOiQQDzaHN96qG6ud6vlZkPUXBbc
 LTGtaKR35eh894TY01xqP2Srg4bu3IAwv/RIp+aECtY0CagFti2aN93Ftlint1dum72S
 pbBw==
X-Gm-Message-State: APjAAAVdbXhRS7C1wBCrwPAYTPU2ta03kBKN2hy7B0uYsjHwmGRVVfdF
 vHURUkos3rLKzoT86/rsYMchRg==
X-Google-Smtp-Source: APXvYqxLD0LwUBKhDzrDEj45ePVTacM/K10xf/6cqmiMz3a6bF5fvPqlELND7WgSc9RRnQLi/CLk6Q==
X-Received: by 2002:a17:90b:f06:: with SMTP id
 br6mr2226536pjb.125.1575643628749; 
 Fri, 06 Dec 2019 06:47:08 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a22sm17794578pfk.108.2019.12.06.06.47.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2019 06:47:07 -0800 (PST)
Subject: Re: [PATCH v5 03/22] target/arm: Add MTE system registers
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191011134744.2477-1-richard.henderson@linaro.org>
 <20191011134744.2477-4-richard.henderson@linaro.org>
 <CAFEAcA8_SQ6ugs360PJD58547mmZY1yu5xb=Fq0P006HJ1yGRA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <597e1b27-24df-164e-d289-f8d8bb69f0c3@linaro.org>
Date: Fri, 6 Dec 2019 06:47:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8_SQ6ugs360PJD58547mmZY1yu5xb=Fq0P006HJ1yGRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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

On 12/3/19 3:48 AM, Peter Maydell wrote:
>> +    { .name = "GMID_EL1", .state = ARM_CP_STATE_AA64,
>> +      .opc0 = 3, .opc1 = 1, .crn = 0, .crm = 0, .opc2 = 4,
>> +      .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = GMID_EL1_BS },
> 
> This should trap if HCR_EL2.TID5 is 1 (since we're adding
> support for the TID* ID reg trap bits now).

Done.

> So, aa64_mte_insn_reg here is checking for ID_AA64PFR1_EL1 != 0
> ("instructions accessible at EL0 are implemented")
> and aa64_mte is checking for >= 2 ("full implementation").
> I think a couple of brief comments would clarify:

Done.

> (The other way to arrange this would be to have the 'real'
> TCO regdef in mte_reginfo, and separately have "reginfo
> if we only have the dummy visible-from-EL0-parts-only
> which defines a constant 0 TCO" (and also make the MSR_i
> code implement a RAZ/WI for this case, for consistency).

Done.  I agree this is a better way to treat the EL0-only case...

> An implementation that allows the guest to toggle the PSTATE.TCO
> bit to no visible effect is architecturally valid, though.

... because this could turn out to be slightly confusing.


r~

