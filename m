Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7DBC31E5C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 20:00:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14DC9208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 20:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LcjTqbjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14DC9208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51632 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcxnd-0003Dj-3Z
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 16:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57876)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hcxlw-0002Ab-Fc
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 15:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hcxlt-00069y-7h
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 15:58:30 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:36649)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hcxls-00066X-UW
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 15:58:29 -0400
Received: by mail-pf1-x441.google.com with SMTP id r7so6250975pfl.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 12:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MzEmANWA/oEzNp9SwidOOKf5gV/VJZKGnTQ+PcDmTl8=;
 b=LcjTqbjFdRbrE7l58yftYitNdIrCH0WNsDaInEqabKMFElBujoPGKVDI9J+/9gSBSR
 iU8uF/oKmq1BlORfvEmSNlzB29hla0drV/ccElmPotUfLD2W1AcV7LehkN3FxHaTaa+3
 amH83cmJnE56BCnXimI1d6Rbpslclm3AiAJqSI3eH1fS+icMa9pqVLp4uUjH2LzLsTQM
 QSVcGEdG+iJLyuMb6z4ttfOjrvwBVEwcdGcJWh68Ywf8U0GpBj+zlIfhcYQCsDrLYs4r
 TIM8stWd8B1aYsuL81AYpc3nP1XTLRtAWLLaCydD50FgbZvxzi40ynTVlJIY02l27gcv
 xG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MzEmANWA/oEzNp9SwidOOKf5gV/VJZKGnTQ+PcDmTl8=;
 b=jKuHN7ks+I4ffGZA39kATIcbkyZZbhhGzkIOU9uMTLt1QCcWs7CewEcSKMZ0NfKPUT
 2n+lMkIeFFSJRiBnFfVPn0gaw22OShAnhfqRrjH5Cx9tjAPF62y02ZrmeA9GW+EJuDne
 vB9LJ/gqUcP2OhLNom/7qIzijlu/fPPxixE3Iet9StevmHzxeKHpXeRCHZ8cLu7NET+D
 CyyqGHdy/6nkAp/r5BjaUeg3ug1LNWnu4YYTEs7MyLnI91rDVXvpQ64QAa8gggOuOMJ+
 sXHMUgxg8LjXAZMJwJo6y3NaVqerr6ETyomGc2nsmXtjtx2Hrz2/CYXV+P82erZdnKlX
 sBVA==
X-Gm-Message-State: APjAAAVAdcEw52QZqxpmEDPpSgiyX/KEMXNyUZ4TzOUt9iVBsFOVhKTl
 Ruqb7nrjuSMjifyzhkacs84Q6fuSCgo=
X-Google-Smtp-Source: APXvYqwdt6Q5CzXuJHZx/R+Y1T5+rilCUqhXzwfZsFN7vBHg+aNH5VVcPShXG5zvHRaE6Qof4hxA4g==
X-Received: by 2002:aa7:8202:: with SMTP id k2mr11592070pfi.31.1560801507621; 
 Mon, 17 Jun 2019 12:58:27 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id e16sm17162923pga.11.2019.06.17.12.58.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 12:58:26 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190617175317.27557-1-peter.maydell@linaro.org>
 <20190617175317.27557-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d74796ed-4bbb-da09-c69f-f14ef71b08a8@linaro.org>
Date: Mon, 17 Jun 2019 12:58:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617175317.27557-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH 3/6] target/arm: v8M: Check state of
 exception being returned from
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
> In v8M, an attempt to return from an exception which is not
> active is an illegal exception return. For this purpose,
> exceptions which can configurably target either Secure or
> NonSecure are not considered to be active if they are
> configured for the opposite security state for the one
> we're trying to return from (eg attempt to return from
> an NS NMI but NMI targets Secure). In the pseudocode this
> is handled by IsActiveForState().
> 
> Detect this case rather than counting an active exception
> possibly of the wrong security state as being sufficient.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

