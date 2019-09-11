Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFF2C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:43:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9EF22087E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZRL7F1dL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9EF22087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i84m1-0003nb-HZ
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 11:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i84Hw-0001cI-FR
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:12:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i84Ht-0000eg-80
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:12:07 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:45827)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i84Ho-0000Z3-8C
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:12:01 -0400
Received: by mail-qt1-x841.google.com with SMTP id r15so25635337qtn.12
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 08:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ytgGpcKJ8xChj2rTMlTnzL0RsNsbPYQiQOGWSw99FaE=;
 b=ZRL7F1dLanylInYwFJKGUoij+5KycbWXDrvF5GkylxfFZq6OrTM7TYrmVFMLCavgyc
 /5R6X6oVg/ovseMsg8378lH1FBesbcr+uxBFZXke7/jiMNOd1GdMN/cW7r9gChq/ecOG
 4xtTgf/T8CTqPu7I9q7qeQz/KypvHHff6hEZpOSuTiEgqVEulvjVkNPx1yoVzIoBlrPH
 EeYAOAlRHSN6f5jNlfNXazytH3gHWk8DkcMLPNH0SAS5zLKYbLs3WFiD/oh3H97utqGy
 8j58mDjprj8ebXKppDsuFarqUwZxOIYd86NDeW3LNFiSyXNtzH6gIkcUHlHoJb2Ce7LY
 1GBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ytgGpcKJ8xChj2rTMlTnzL0RsNsbPYQiQOGWSw99FaE=;
 b=sSq37KZ7h7q9zHJIgAvUVTShNDLOOcGFqGCXE5lAPhz5Fx9M3q7FjHeBQaMCjzrQgF
 wPT2rAJUT/aovQrATGO9eGEyZVJqB8admtXbP53D/wFk9hXi3ZV4v6woei7K2MDkmYmg
 pd5UaytG0gC8ZeGsXx/eMitiuoX5FL2itakyI62iQCCTN3lslPb9Ek2wfwhC8/EuvoZr
 Fr1L124K4Ovskmq4HD7qgBG6AbGR84Oyo9YTZ3469ZWcSAu9/PtxGJNLZhKSH//noJHV
 jFISfRi/3i82myjQvGhziJkX3rr5dqHnA3KPCocnAaQJAdQa/znNYLcw46YsDO5YAjJ3
 dJSw==
X-Gm-Message-State: APjAAAUnBKK2us0hgTyfWs2K1mdAWeKdW7sk0pCqGdU47gzxwY36Dew1
 RqduKSLB9Bx1bi5DKJxrvAf0Jg==
X-Google-Smtp-Source: APXvYqwIehUYGeMm+qNuBND0ng0Y67PON/1mqwAPr3cjz7xQIpnqyuIrhPU0LsJ0NzOLGMi0xgg/GA==
X-Received: by 2002:a05:6214:4e:: with SMTP id
 c14mr22503197qvr.89.1568214716908; 
 Wed, 11 Sep 2019 08:11:56 -0700 (PDT)
Received: from [192.168.5.185] (otwaon236nw-grc-01-64-229-69-35.dsl.bell.ca.
 [64.229.69.35])
 by smtp.gmail.com with ESMTPSA id q64sm1358702qkb.32.2019.09.11.08.11.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 08:11:56 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190906075750.14791-1-david@redhat.com>
 <20190906075750.14791-12-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1da7221c-e665-e3e1-f0bf-e1b0e4bbf130@linaro.org>
Date: Wed, 11 Sep 2019 11:11:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906075750.14791-12-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: Re: [Qemu-devel] [PATCH v2 11/28] s390x/tcg: MVCS/MVCP: Properly
 wrap the length
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/6/19 3:57 AM, David Hildenbrand wrote:
> +    l = wrap_length(env, l);
>      if (l > 256) {
>          /* max 256 */
>          l = 256;
>          cc = 3;
> +    } else if (!l) {
> +        return cc;
>      }

Um, wrap_length only takes 31 bits.
These insns take 32 bits in 24/31-bit modes.


r~

