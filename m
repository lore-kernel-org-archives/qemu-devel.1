Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED15AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B430B205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WfH5BMl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B430B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1CmI-0006wN-3E
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 12:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1Ci5-0004Rd-KI
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:46:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1Ci3-000124-7t
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:46:44 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37116)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1Ci2-00010X-PP
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:46:43 -0400
Received: by mail-pf1-x444.google.com with SMTP id y9so6436807pfl.4
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 09:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SeQTjSbXSFNIw+BQ/nWIVkYKPWZvoYbwRR116PNQt1Y=;
 b=WfH5BMl7KEjsno4z7eFYoTHlXcx2DoDkrQjWq2zruDMCcxDKCQQnLtUtrjJ2wWzPba
 nG7zkRxv8goaupOL7alE1TD3n8yzOB7e2DluZ5F2EjJa3IEbg653JZNvGS2VNmLAE0m/
 O9klobrA0ZvYlrzheIwgm0gVOPPu1s2FmFCZdAOBDS8hd2kbf5DG2QLXhyYU19cIUsf0
 g6rkl/TZr0iGVtkqlIRmajHNgKGDNzUm4kes0z7dH1hy/aGHVxCBmYL4Mkyc2ZnW3Fn6
 YhLjRmdBxMXqcxM5uw3QypztSFHTZsCKGifMLVF1INkTwevJH1vv773Rf3ja3rFUko8c
 2C0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SeQTjSbXSFNIw+BQ/nWIVkYKPWZvoYbwRR116PNQt1Y=;
 b=k0hayi55k91xnxx+SO44APc4VB7MAwBjUwbP1qCKKcz+WnvVS6k1PJUfDHMgo59K6s
 JDqadvj0ditexoDWNLUb+jOMH8fRoX7KvntI8OpJ4d+5brZOOBf6NseSD4w8eGVpKDNl
 qU358f0sMOs21EvipDZxEazhMq4YvLIneagLt2U/hNSOblSKl2YsyYt+kbJXJK62HQye
 RRoH6lER6429PjEKiSYmzQ191VO9Jfd4KJ9qphhKQbkoigTm2sblwYHNsxHnrM1Ef9Lm
 HLj3vuA//irhHRITnaA+qSBbLqTsHK///J1+vPOw/or2H7pSE50O2AeKuc8ktqhzY/Ls
 FRIw==
X-Gm-Message-State: APjAAAXfrpPpSoEiu6h4hGFkMzGKvArXg6KonynxtI3KRHXD3kAuFhfG
 WPG3IpeiveRb9ZzbGzgoxiBehO48XO4=
X-Google-Smtp-Source: APXvYqxJ6pSWR3rlCxH39rxnzpODarWMCiY7HOjS+Mx7a53KDRWj32xSctgp9Ow0Pf8JGa4CqB9MEw==
X-Received: by 2002:a62:2ac4:: with SMTP id q187mr6202945pfq.242.1566578799815; 
 Fri, 23 Aug 2019 09:46:39 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 203sm3818278pfz.107.2019.08.23.09.46.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 09:46:39 -0700 (PDT)
To: tony.nguyen@bt.com, tony.nguyen.git@mail.com, qemu-devel@nongnu.org
References: <cover.1566466906.git.tony.nguyen@bt.com>
 <a61e429b-6493-3ad0-cd22-07832dbcc1f7@linaro.org>
 <1566563109661.99467@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b0f6bbc8-6ee5-c8b7-f565-3bce486312ef@linaro.org>
Date: Fri, 23 Aug 2019 09:46:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566563109661.99467@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v9 00/20] Invert Endian bit in SPARCv9 MMU
 TTE
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

On 8/23/19 5:25 AM, tony.nguyen@bt.com wrote:
> On 8/22/19 12:29 PM, Richard Henderson wrote:
>> So... after an hour only the cover letter has arrived.
>> I'm thinking that it didn't work.
> 
> Frustratingly, I keep getting blocked.
> 
> Perhaps new GMail and Mail.com accounts sending in bulk on behalf of bt.com
> falls foul of spam filters.

I have no idea how to solve this.  Perhaps a personal gmail account, bypassing
bt.com?

In the meantime, I assume v9 is intended to be the same as v8, except for the
wrapped lines?  How about you push your branch to a public facing git repo
somewhere and I'll do a final review and pull from there.


r~

