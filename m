Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98ADAC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:18:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6434B2053B
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RhzKT+d7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6434B2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jheKQ-0003gw-Nr
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 15:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jheIh-0001ub-2H
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:16:15 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:39931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jheIg-0005Im-81
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:16:14 -0400
Received: by mail-pj1-x1041.google.com with SMTP id h95so4252007pje.4
 for <qemu-devel@nongnu.org>; Sat, 06 Jun 2020 12:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=NqJPQYE8AhKk57fEDe2SRR2597Zx4WalSrSESB9S/DA=;
 b=RhzKT+d7/V0Z9jw+HO3t2uwkaI0eKab7zhUQzAxMvCN8vtarkbBlEYEVG2x5NtQ+ZA
 OsFy0JRJVBFYgjVTv6br6drANNdOvrfSkHxcAqJdX5WubkwwGbvxyHKNRXlKMdVeiZYe
 2e2Yl/oOcUS2LnJymdusF5GTyyD36daeyhxtsxZzZL5025xFsT0Au6oUc2ikS9Ex0Bdy
 LlWMiQ48BtmG+P/bWGfyDup5weBvcpBcOr3BFwStXkXnyV0p2rMh8VLsxmBLQfb8GfJ3
 b3BU4WUUYjM9pSv7Ge26uPcHaopfrgUSI2HlU1HBd221GgVksjw5A+VmNMsuZBTqHURS
 IXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NqJPQYE8AhKk57fEDe2SRR2597Zx4WalSrSESB9S/DA=;
 b=DhVqkWyTfqVrqHcheq01LRUTM66cM7vQR25h8PGBfCd+Yq4rWAfF+oWnzoKrZ0OOY7
 UsGqlmNF/9tCjU4YW6cPT3rhTROvkMMwBD1cFcGcZFKtfXXPcdv8ojAwU80xqkjNYBcP
 fwCsb8Xbs2cruzs4Tr7ul03Ld/StEoU+ISAx6+jkrY+YkkPdXvXliM7xcU18TviyWCGX
 zAU5mQBlIDeS8unpRfEjWN8+URPlfShtHK6/6jaoTpxeCb6EuP2+fgNqM78GvxIWfKn/
 JXXb94wofNrpk0Qk4RhziF6lMe75Wu+iqm3QCm1hZJr5Sx/g5Zz/8xG6xe5SQV/gYF8h
 5zew==
X-Gm-Message-State: AOAM5323gZ/dA9TJGvwgT2mt8q8g4ITX5QUUjkFM+RSeB8qtCEhYZOLl
 ttL7QXd8Eo1vaOZ+rR4AuVoeKQ==
X-Google-Smtp-Source: ABdhPJzwCwg7iV67pRS7OrD0cg79PFXngqHnGnvpdsEv/FRJMT9JS7O4qRrdtFaO5P+Zi+qNQPJnCQ==
X-Received: by 2002:a17:90a:f688:: with SMTP id
 cl8mr9522129pjb.166.1591470972798; 
 Sat, 06 Jun 2020 12:16:12 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x1sm2832316pfn.76.2020.06.06.12.16.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Jun 2020 12:16:12 -0700 (PDT)
Subject: Re: [PATCH 6/7] target/i386: reimplement fprem1 using floatx80
 operations
To: Joseph Myers <joseph@codesourcery.com>, qemu-devel@nongnu.org,
 aurelien@aurel32.net, peter.maydell@linaro.org, alex.bennee@linaro.org,
 laurent@vivier.eu, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
References: <alpine.DEB.2.21.2006051857110.13777@digraph.polyomino.org.uk>
 <alpine.DEB.2.21.2006051901480.13777@digraph.polyomino.org.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <07f1b77f-29dc-6698-3337-24392349d0c8@linaro.org>
Date: Sat, 6 Jun 2020 12:16:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2006051901480.13777@digraph.polyomino.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On 6/5/20 12:02 PM, Joseph Myers wrote:
> The x87 fprem1 emulation is currently based around conversion to
> double, which is inherently unsuitable for a good emulation of any
> floatx80 operation.  Reimplement using the soft-float floatx80
> remainder operations.
> 
> Signed-off-by: Joseph Myers <joseph@codesourcery.com>
> ---
>  target/i386/fpu_helper.c | 96 +++++++++++++++++++---------------------
>  1 file changed, 45 insertions(+), 51 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I would merge patch 7 into this one; I don't see value in keeping them separate.


r~

