Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66881C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 23:52:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 326822075E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 23:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WTm4540p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326822075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm4Ka-0004up-Ey
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 19:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jm4Jq-0003yA-Bf
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 19:51:42 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43832)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jm4Jo-0004cB-1C
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 19:51:42 -0400
Received: by mail-pf1-x444.google.com with SMTP id j12so1355617pfn.10
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 16:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=8P4SJ3hnAsoRcrvAM+d3I18xWYnLGQwJERy69QNUJMc=;
 b=WTm4540pvYtO2LbR8slmG6gX2cnY+HWHNnlFNe7G/meBQa77/QALeEJjrlPpjqtvqy
 EJwMbhWM8wAaWoyDXh8UjAHjje6ytgVL7/B8G3XZ4s/sLO6U3ECA+xC+qvCd0K9I9iNr
 uUELqn6NV1VU3z3u03mNfVA6iwgiyq+lNXke6R16Kqckh5RNpWJYbdosVYdix2p4xsug
 rQK4LF/CcG4/IxV4JjwIe1P8E/XdF4rlapJsF4j4xNf60e22eHkW7zuj6BrrJUjpmUo/
 3QyvP2ocYQ/LoAzKpkTK+yhpdExGi8VlEIeFw4movhThAput2AfxciuM9NEzm4ZdC3I1
 ttbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8P4SJ3hnAsoRcrvAM+d3I18xWYnLGQwJERy69QNUJMc=;
 b=pBKySCS449fUo3EBSYpniykIxLbDNDfqP3LcAs3U1OHrw+3lBAjxMr2Qlh3vY0KIWA
 BfJ/ial6U5MKltGRASq2l4E0MT1R+u/hdo1HDywkqeSAZMGBAbZG2G2tLnHbyZJeMOnr
 /QJmRSFx+RbrQsuR783Wp/FaKATb5C2pzIUvcjrSR2Xwtz7saOB+XvCFD7Mwn216TO+5
 +u4KpwcDfB9yrR3vad/XTTSUfmI6+NONtXsnu0G20qCYGL5yPof6mcCvKwOCxKmy3+D2
 IcMvmIrfuxQErW4P/3nGK2VyRAPtO5/wRGnJRnAuPiOc+hlqULZfxiBfNxoGbsen2+Jg
 vpCg==
X-Gm-Message-State: AOAM531hBYJfiGY0rf8/QQDYIg3ulofcAD1a0H4qJIUNOXSI7a+Pi3kO
 mzQsCwCGzhfTdSJWnZrePHJfcwkUyNA=
X-Google-Smtp-Source: ABdhPJxNFC9Flyb4AkO2fYyyOK0206OF2FTyMBIl/jdG7jasSDGD63p1NKvxlNkVIv5xCCeEeT+09w==
X-Received: by 2002:a65:43cb:: with SMTP id n11mr809305pgp.160.1592524298125; 
 Thu, 18 Jun 2020 16:51:38 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id n14sm2359350pgd.78.2020.06.18.16.51.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 16:51:37 -0700 (PDT)
Subject: Re: [PATCH 0/6] Add several Power ISA 3.1 32/64-bit vector
 instructions
To: Lijun Pan <ljp@linux.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20200613042029.22321-1-ljp@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6c2f6b83-2132-7042-7df6-3267c9112df0@linaro.org>
Date: Thu, 18 Jun 2020 16:51:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200613042029.22321-1-ljp@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/12/20 9:20 PM, Lijun Pan wrote:
> This patch series add several newly introduced 32/64-bit vector
> instructions in Power ISA 3.1. The newly added instructions are
> flagged as ISA300 temporarily in vmx-ops.inc.c and vmx-impl.inc.c
> to make them compile and function since Power ISA 3.1, together
> with next generation processor, has not been fully enabled in QEMU
> yet. When Power ISA 3.1 and next generation processor are fully
> supported, the flags should be changed.

This is not the correct procedure.

Step 1 is to add a new define for ISA301, which is not enabled for any processor.

Step 2 is to add all of the new instructions, using ISA301.  In this way there
is no intermediate point in which a 3.01 instruction is enabled for 3.00.  In
addition, we do not have extra churn simply to change the ISA.

Step 3 is to add a new processor for which ISA301 is set.  It is often
reasonable to have a fake processor named "max" that contains all of the
available features.  For ppc, I see that "max" is currently aliased to "7400_v2.9".


r~

