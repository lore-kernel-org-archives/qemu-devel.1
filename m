Return-Path: <SRS0=KvPE=UH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51497C28CC5
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 19:29:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20712214C6
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 19:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uNPWE4Pk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20712214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60040 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZh2M-0007NF-Di
	for qemu-devel@archiver.kernel.org; Sat, 08 Jun 2019 15:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37195)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZh0Q-0005n3-H7
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:28:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZh0O-0006TJ-Hh
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:27:58 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44730)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZh0O-0006Rw-CL
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:27:56 -0400
Received: by mail-ot1-x344.google.com with SMTP id b7so4884603otl.11
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2019 12:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mTSBuLLkD9ZUETkcyw6UxodPLZ3R6xviQCot0ZhBSBo=;
 b=uNPWE4Pk9M7Yh6eiZiOW7FMbF5Hsi8EF9e+pIxhLEV9pThfdlVSOdV1Plxzzk4OkRe
 WRXftRA4kLDJQY446jNLgLV8UNzEsU2cpH8E2C51RyWWZl20vV8NoFoljthE8vYMBjAM
 4be9PNiPNu5gXXYQE9AsbdwBsmM5XnCLCfbqV6vyZddkckUKDpVLts9JxR+qtkmkK5YF
 u7auIuIBkmp4RHOYjCuJymcZ7caXJOanrcg38Qi3JsiD+5SxlbYn3HnKeW/V0l1NkfDO
 AIIntP7CRF4TzJ7+78L1NppU9aU4Jg3PgPF/ChQZIL16NkiCkhrsdjMoyko3KegMQ8q+
 G3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mTSBuLLkD9ZUETkcyw6UxodPLZ3R6xviQCot0ZhBSBo=;
 b=La3GVZj7tFV7pjAXOfWdmvTnJA6GWDHzWTvi0KvkQCUj+Ut2+T43yq/4nQ57DYn+Or
 DM6u65c2yGb8MaCfrhInHzz7pftJbDxOOjjjTOtN0/3USYwx9ZBdSAQtD0FwnLtSqB35
 wry/d3SRMZVdM4ZnVo3jh8p4Oe10kHoTCoWIIpnzwJKllNjV9I8XJehHr34QgPFSTAT/
 lPJ3uSYkkuZ98XgIiHl/sQGlJiy0TNsvr65fLSCRu09lmUowflMKAiOD0yPs/Fv5WSB9
 q12WOb4p9Xy9cJGxQgvftqZ4m9lfbypdWFK5QwO8OPnA3ujf+0kmmCqH3rjasLXqxswW
 CXig==
X-Gm-Message-State: APjAAAW2jQ0sIVxN1GurDs5wYjaX0ViRi+54MqIh+qZL5Ws4PdlhIFWE
 Cdi7VBWyB+vpUpbGoAc+fG/emy5d6XV3Aw==
X-Google-Smtp-Source: APXvYqxdHNFkcPRIyKuHuy3c6KRM4vXlCLe2DF/cz6K8gbXm/l1be+mPUBfhzxrKLwicMyVWOZhHgQ==
X-Received: by 2002:a9d:27e4:: with SMTP id c91mr21512082otb.360.1560022074116; 
 Sat, 08 Jun 2019 12:27:54 -0700 (PDT)
Received: from [10.219.49.199] ([187.217.230.84])
 by smtp.gmail.com with ESMTPSA id q62sm2056850oif.57.2019.06.08.12.27.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Jun 2019 12:27:53 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-21-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <53422629-9764-afc0-7b46-cf69e02884a7@linaro.org>
Date: Sat, 8 Jun 2019 13:25:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606174609.20487-21-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 20/42] target/arm: Convert VFP VNMLS to
 decodetree
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

On 6/6/19 12:45 PM, Peter Maydell wrote:
> Convert the VFP VNMLS instruction to decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-vfp.inc.c | 42 ++++++++++++++++++++++++++++++++++
>  target/arm/translate.c         | 24 +------------------
>  target/arm/vfp.decode          |  5 ++++
>  3 files changed, 48 insertions(+), 23 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



