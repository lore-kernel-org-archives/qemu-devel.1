Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BB2C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E220D20731
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="upQqfGsc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E220D20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUFFb-0004aL-1z
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 15:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUF9X-0008Ox-PY
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUF7b-0005hj-Uv
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:47:23 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUF7b-0005fm-CY
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:45:23 -0400
Received: by mail-pl1-x641.google.com with SMTP id z6so2678337plk.10
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 12:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=ZtIrSrAV4lsSH1lBsBv9oGsR1UrOCm1sCFGIH0Bw5eU=;
 b=upQqfGscWGwb61/k1epVw0L0KJ/FnknounBfrlNeqaErX82PhvNMHtEUd5DUiCMPdF
 W6kRiyO2mjotn916oRmNrfC/eP2TAAMej1rOa7U6YD1wgas1z13H/Q5HsIhOpN/hcD/P
 6XCQYbry+8UMziAAC0DYnZBAHL8GKolgOXaHe2qF2naWcz4wKhXl8dgRKmXUOAkc4wcj
 tHceV3EBn7ncwZWTTiIh7Kv5RqRq4ldngRIptBTtqpyQfHpEhbk8iGGkSDbeYGM0xcC4
 MCYZmsZMqX9m0aW/uobyI9imb9xNTEoXBYhDP3YK3OelPOrF8l21k83XhweU18MSfAdL
 m+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZtIrSrAV4lsSH1lBsBv9oGsR1UrOCm1sCFGIH0Bw5eU=;
 b=pPA0qdKh6qdPIeJLgjOqp07+76Ns9j/BIa7hnaFJd6BeCwIM2u1iH2gBKprjOfltC2
 T9ftjF6eWiYCjCajOUOhYLb8fogVH1jO6lQl79MEP/ZsN9RatznXcPd+kpWSuX/Ze24D
 PaWQptRQrMlD2qPzVGbsZtwHY8hDEQN2NTEeCQf3CiRO6fTuTj/ZWX2E3Hz1OfImYEjh
 I6dCO6HOVLI5OPUtRWGf0ncJ1dW9VQVmOFq7BSkGt5mpUXCR+u49Qbv9q3ejRhKnnVOa
 iVoKF1I30R9QNt5EFdYZ9NefOLN6u5kKO/BrzjyRetsz6tu+aT+ZFyoavs1GQp26MS1w
 qqQQ==
X-Gm-Message-State: AGi0PuYLWQdHrgTQ7x+BojqhDIV3aWX0rCXf7gd6P/7eCUV4eGwEffDl
 VVydjLClvlzrB+0wIPIPwQPy15FIUA4=
X-Google-Smtp-Source: APiQypI/Sc6Q9aYzlo59XucUZkI1ydOepc0opWbzqFMclRSWeFBd0EhbZHY3mWTyMWi5ezIXP9Fi6Q==
X-Received: by 2002:a17:90a:bf12:: with SMTP id
 c18mr446165pjs.180.1588275921085; 
 Thu, 30 Apr 2020 12:45:21 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id b9sm506642pfp.12.2020.04.30.12.45.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 12:45:20 -0700 (PDT)
Subject: Re: [PATCH 16/36] target/arm: Convert Neon 3-reg-same VMAX/VMIN to
 decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-17-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <539479d3-eb53-972d-bdd6-116285c024ab@linaro.org>
Date: Thu, 30 Apr 2020 12:45:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-17-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::641
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
> Convert the Neon 3-reg-same VMAX and VMIN insns to decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-neon.inc.c | 14 ++++++++++++++
>  target/arm/translate.c          | 21 ++-------------------
>  target/arm/neon-dp.decode       |  5 +++++
>  3 files changed, 21 insertions(+), 19 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

