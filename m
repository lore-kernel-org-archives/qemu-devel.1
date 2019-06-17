Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB983C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 20:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8125020665
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 20:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D3pxrOke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8125020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51686 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcxub-0007ck-RG
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 16:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59540)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hcxsS-0005rf-Dr
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 16:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hcxsQ-0004SZ-Iw
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 16:05:16 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33716)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hcxsQ-0004JB-75
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 16:05:14 -0400
Received: by mail-pl1-x644.google.com with SMTP id c14so4594834plo.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 13:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bb0b5b5JuBcsrlcLhxC7EfAEH5f5CLzmFNTVbFtfcYs=;
 b=D3pxrOkeqD+RZMvXg2k/sB6qCEpi6fLDSQ0W36u7eCAJNvQv/WaVNnyTbSLG5UufyN
 T0lFl4yXbmQZvytAbNOGJgVal30JRrk6DKzsL0kJuMBl9pU3LQeKPZQpXZzTWuCFoIK8
 Yw4tcsQ/29vDT+yH9N2JZCLLwsfnI8gnwVezqh/rxg19XwOTyo5PropNaB32Q0+MmkdM
 /mW3zibi9VesJUR9CVPkUzSzPwtoGdcUMH0ueSsyGsp+fxhaWivyYsqou/N1uKnl0ri9
 62dgXSxAaO9i9XswmiN1G6XTwtEpUFDhhvgzbUXF3qPT1VLdZkxysbSpm/dHT8LuO/LH
 VbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bb0b5b5JuBcsrlcLhxC7EfAEH5f5CLzmFNTVbFtfcYs=;
 b=bZndWnl0UycvucjyRZe8TPa3jn6bLArpy/JdChwggAjSuRMrZGivi4Dxx7ubxvpp3N
 3mhZrjoLc0J809bOh8tYzkE6KmT1mYF/wpPFQMFMuQq2UfnLDJK+PK98f7544vpX/YFG
 udBczq50RnLH7IfoozIfjJtT01ErfKX9liyWHyqZUy4FWg6rcKitlL9YlkNrU/Sf+D+G
 kGsaql25BuVN4vhhc1d37L2bvLCPRKrE8bYeO1t3Bf4npHXQOnDeOLTge5wzLagjQG/O
 o/TSTS5Iyqvd56Q111+BcR7lZAc14cMvbrMKV92sWc+RKPfShp1Ao5PJ5Hmk4jvbV/OQ
 izUQ==
X-Gm-Message-State: APjAAAUgBiKNjcilI5PyLxxwH8IuOQXaP2Q0oFj74xzyXKviUd4oH4NO
 PbImr0VvSuilDZtQIz/gHqxJLY5bzjI=
X-Google-Smtp-Source: APXvYqxAbZMuAezYBPFepbfrI1KmODX+9W1SGubC7LPCPEUpp23rY7+PJ7hwxP4Xal0Apnhmy8AWHQ==
X-Received: by 2002:a17:902:2ae8:: with SMTP id
 j95mr69679979plb.276.1560801901035; 
 Mon, 17 Jun 2019 13:05:01 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id l1sm11896451pgi.91.2019.06.17.13.04.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 13:05:00 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190617175317.27557-1-peter.maydell@linaro.org>
 <20190617175317.27557-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0e1ea74f-a99e-eef6-aa12-2248ce056eb1@linaro.org>
Date: Mon, 17 Jun 2019 13:04:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617175317.27557-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH 6/6] target/arm: Execute Thumb instructions
 when their condbits are 0xf
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

On 6/17/19 10:53 AM, Peter Maydell wrote:
> Thumb instructions in an IT block are set up to be conditionally
> executed depending on a set of condition bits encoded into the IT
> bits of the CPSR/XPSR.  The architecture specifies that if the
> condition bits are 0b1111 this means "always execute" (like 0b1110),
> not "never execute"; we were treating it as "never execute".  (See
> the ConditionHolds() pseudocode in both the A-profile and M-profile
> Arm ARM.)
> 
> This is a bit of an obscure corner case, because the only legal
> way to get to an 0b1111 set of condbits is to do an exception
> return which sets the XPSR/CPSR up that way. An IT instruction
> which encodes a condition sequence that would include an 0b1111 is
> UNPREDICTABLE, and for v8A the CONSTRAINED UNPREDICTABLE choices
> for such an IT insn are to NOP, UNDEF, or treat 0b1111 like 0b1110.
> Add a comment noting that we take the latter option.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

