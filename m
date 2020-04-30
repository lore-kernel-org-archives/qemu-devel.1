Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A4BC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:40:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA1C2073E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CmV9jJf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA1C2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUF2k-0003tk-7t
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 15:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUF04-0001uh-0H
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUEzE-0004nE-3t
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:37:35 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:43649)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUEzD-0004ho-Ma
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:36:43 -0400
Received: by mail-pl1-x643.google.com with SMTP id z6so2664871plk.10
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 12:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=9E3dQ6N/5EivT/j+fF8tuEmj3/H5q5PFI9OUH2nP9Js=;
 b=CmV9jJf/TmJvmfiaLU8EMBxpZbJAC3UFtEhV/KlBbmJFFqrMa1AmqLHTfG5h/iVBxC
 Kcqdq2me6jE9Utnq0+rSczTE+4IvXcW6wz9oWZxVIK3KMuxEXH+SLwBbXWz//xkKtFEz
 8rYIOV5SLct8XiBp7F8fycCBtikB4gTSwGiFwFx2LoooZJafW+5qgOLcXKJ1Qie7V+V9
 NQ+7He44goxE/cFTlXu2nSHXSAfXEM/aETNjDR+VbYSMd0xEuuyjr6ULW97MCin39COa
 Bna61InRLcYHQ5JlVblQ/tloLLgEIYCyxpWCq52vRGbLne8lGDBv6/Z3jI8qVO6K5ySa
 nh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9E3dQ6N/5EivT/j+fF8tuEmj3/H5q5PFI9OUH2nP9Js=;
 b=IvTkHojRB1qD1qdrtiabodX1FYnW56/rd5ik8KTyH5seaC0PgXXioq/168exSRjoc3
 6wuMP8cD8ko0R0a5LuoUGGplW9o+CRZJIV72oOBF4Sr6/t4Duj2nlqnaSkgsrgbc+MM9
 PekE8AtMah/0hcFUA3f4Kqwx0OX0LJYeYB4m96Mu2CXcis2gh1MnZ2kTldV6XWAp4W5q
 20w7j0JkrSBca24eY8jpxrBu5i4wzoub3Hy7lVp4UaNWurDnRt2giJZaRTWHV4vWJiLo
 46e08M9xuqrMJrAhNk/Ncb1og+JlU/n7tMOOXryCuO6DCfoysY6JlTtn8ld96F6H9X3+
 rH3A==
X-Gm-Message-State: AGi0PuYOV9/TV3ChnPhRN24SFv2r7cdGI1rI0h8Lq7364/eLUMYdaBuD
 /pjWuTtiOu98M1yXWaEGBBSuGCK1Ha0=
X-Google-Smtp-Source: APiQypKIinAP+R0ITMm6zHPnSPLIygG+Fef2wG3Zp2P/nrpzaCyzpPhxu4MhHiTlS3ecTzOcWSKS3A==
X-Received: by 2002:a17:90a:2365:: with SMTP id
 f92mr406161pje.117.1588275401307; 
 Thu, 30 Apr 2020 12:36:41 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id gl12sm479696pjb.27.2020.04.30.12.36.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 12:36:40 -0700 (PDT)
Subject: Re: [PATCH 14/36] target/arm: Convert Neon 3-reg-same VADD/VSUB to
 decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-15-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f8c2ad33-d046-45c9-7200-2ab4409f90d9@linaro.org>
Date: Thu, 30 Apr 2020 12:36:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-15-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::643
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

On 4/30/20 11:09 AM, Peter Maydell wrote:
> Convert the Neon 3-reg-same VADD and VSUB insns to decodetree.
> 
> Note that we don't need the neon_3r_sizes[op] check here because all
> size values are OK for VADD and VSUB; we'll add this when we convert
> the first insn that has size restrictions.
> 
> For this we need one of the GVecGen*Fn typedefs currently in
> translate-a64.h; move them all to translate.h as a block so they
> are visible to the 32-bit decoder.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-a64.h      |  9 --------
>  target/arm/translate.h          |  9 ++++++++
>  target/arm/translate-neon.inc.c | 38 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 14 ++++--------
>  target/arm/neon-dp.decode       | 17 +++++++++++++++
>  5 files changed, 68 insertions(+), 19 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

