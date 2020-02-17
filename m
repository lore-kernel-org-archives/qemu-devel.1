Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F61EC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 22:57:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01E78206E2
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 22:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ca/oPVr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E78206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3pKC-0002Bf-7E
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 17:57:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3pJU-00014s-4P
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 17:56:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3pJR-0001Ja-Jz
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 17:56:27 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:35658)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3pJQ-0001Ig-L8
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 17:56:24 -0500
Received: by mail-pl1-x642.google.com with SMTP id g6so7289244plt.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 14:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=B/yZw8BsUCzvzPWgM/M/oVrIGRQRILRpW+5b60Kx/8o=;
 b=Ca/oPVr973xjWW17Ed8M5C+tKVyWAMmmHGiwHbTfWHPujkA/MtwCWE9kmeLtEY6WzO
 7bWDCU2JApbedXk29hUYSiXkqfSTdedhvNt2gwLsI1oadkEFQf6a7pfMtTJf14i5zI4j
 l3lbtWjOW+mOuKGC1NSGzPs0bZjGl6Ur9cT7SEEyC3B97TiRc36evF/dZCTQ1m/+uyhe
 3X3LGahihviDacgcFpYaoDtpFCNidwNdsHPAXk4SSg+gS9+OUSnO6bgfz0/4pwTn+qQb
 35/v/Bbb2pNJS653RcMGMD30wzZK9GD+F2mXdeB4keN6ykEHNJtqNXQFJvNUzSj+RmxJ
 MV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B/yZw8BsUCzvzPWgM/M/oVrIGRQRILRpW+5b60Kx/8o=;
 b=owbcmxZ5zwqVQ0074XV2ziTpTrtdO03IGn0cVQzxM2zZ6PVT27x/ausVf3yGlVPY/+
 v7Rfy9TneSUVim6U1fZ5kxaG9KOcuk8SIR3EpEy2AbpeiP/A3SKAhpt3wdF1Ig0rnNxG
 ML2HPLZSRSyUhaXCwhvC3lcNndVsQwUhwG+ZBduGF5RhoP/9h3qIsik8pKkelqNB3Vvh
 gjNAwlqEVuNCh9V1hlHMOGWhv58O2LHJD7CSEDWeVUqI38oNITwCxwXwrnbDj6wuwZus
 5ROZOZt1PsEqID3xIo1ahkn4SM9PQyBnLCm6e7KGz6TBpf8t7CmFdtFLoaThWvPIDoWW
 5eYQ==
X-Gm-Message-State: APjAAAXtKYcVCUGgmCh3GXCkTg+eduXy2b2zNVaFtvFkA7NWJ6Pbp+i+
 OfO6UL7Q1T18GzmUVvKWr0Uwyg==
X-Google-Smtp-Source: APXvYqx95PwvdC4J9gaNFiuqeKHdlbvDDVPofcpdo7uKx2B23MeXO/eSgL4EFwj6vtLD+QG0QakfMg==
X-Received: by 2002:a17:902:124:: with SMTP id
 33mr18460218plb.128.1581980182915; 
 Mon, 17 Feb 2020 14:56:22 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 u1sm1348362pfn.133.2020.02.17.14.56.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 14:56:22 -0800 (PST)
Subject: Re: [PATCH v5 10/22] target/arm: Define arm_cpu_do_unaligned_access
 for CONFIG_USER_ONLY
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191011134744.2477-1-richard.henderson@linaro.org>
 <20191011134744.2477-11-richard.henderson@linaro.org>
 <CAFEAcA-MKN5vJYTwF5fbQVvgC_QpfezG_S4Z1gF1Qxtc5NSNoA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0ecaf16f-d5cc-9448-0953-64f71af4aa26@linaro.org>
Date: Mon, 17 Feb 2020 14:56:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-MKN5vJYTwF5fbQVvgC_QpfezG_S4Z1gF1Qxtc5NSNoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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

On 12/5/19 8:12 AM, Peter Maydell wrote:
> For arm_cpu_tlb_fill() which handles prefetch/data aborts
> we just have a separate much simpler codepath for
> CONFIG_USER_ONLY which doesn't call arm_deliver_fault().
> I think being consistent here about how we handle the
> CONFIG_USER_ONLY case would help avoid having a codepath
> that isn't very well tested because it's only used in
> the odd special case of unaligned-address exceptions.

Fair enough.

It also reminds me that I had failed to add the linux-user changes to go along
with this to raise SIGBUS instead of SIGSEGV.


r~

