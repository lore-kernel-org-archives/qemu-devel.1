Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5C3C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:08:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6D3A20723
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Helaj5dA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D3A20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jheB6-00041P-26
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 15:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jhe9G-0001rQ-Q7
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:06:30 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41616)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jhe9G-0002JF-0f
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:06:30 -0400
Received: by mail-pf1-x442.google.com with SMTP id 10so718174pfx.8
 for <qemu-devel@nongnu.org>; Sat, 06 Jun 2020 12:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=D4p1Y/1JDfrDlyp23X2PBIqnvZntNnoFZrQhEZiNXTI=;
 b=Helaj5dAmmzbnj3lJaCw7uDmzT7SFlMGb/ogsFbMf1uWCwpQ8EyiGbsmuK2gRLpExm
 GoOZr7TnSJjUnmLy23bCqKiiYGFFFR6b6WeYJZOnx6SoaXPEfrOpKMeOndjVNWDPVtM8
 +MjIJ9RMNzd3QCM32DwgDkzVVY43JwFnAwSV4yUOgaKX1nseVDSTl9B7qIZEZYZ7j9+0
 YzpBJc7vPOLZR7fmG5MHG6ULW18NuttATByEtStuIPcApOLZWGmVZt1Q3nPqQAutoYlp
 zKPog5IYzCilzBJSjrdmVwukP0JWdKRIs9BC/OSMR0evsbA4iHCAGN4JjgUstk1RY+Qp
 YYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D4p1Y/1JDfrDlyp23X2PBIqnvZntNnoFZrQhEZiNXTI=;
 b=tyqeLEP6e6+FFeMFNn44PoWWRgHSIh2nCavHGbpt/6r4j6ELTXhmTuBk/4xanXKijb
 tipLpuzgHhiAqbAkAookbk1yKHcqdThvD4EwF/ArME5bVIA55jzFdovLWsT2ORp26oie
 Z2S1faqZVBAQJRqnvc1eiENME/3Ufip1d2LOAlLmOcVdDppgaj4bvPTrmRZopfUDhsFT
 0sLp3Xg5yJUf3b9bTe9kUdJSCUMjDiljYQVihQQ6sdRj+hxeEN9HqLCDNrcUpUJLvrdw
 wd42v40BvWgdAWYLybD6MxuDeJvLR+kYAFHE6GKok2nlm+eyBNB0sVMWSNszrd034oaC
 IGSA==
X-Gm-Message-State: AOAM531iZEkSpPVZJ+S1STs5baJ63+1bR6FHpCl3Aq3Uq7GZun5RlcPH
 ch/zwP+L5UFXQQfBcUatXa92PH7zLYU=
X-Google-Smtp-Source: ABdhPJxDoLp8z52+HD6YBrbFbb5DcSERPSfBMuZZFxATMpBhDRpxOXFq/4HO0KhV5E8bpAPOq2NZxg==
X-Received: by 2002:a62:6305:: with SMTP id x5mr2172233pfb.85.1591470388653;
 Sat, 06 Jun 2020 12:06:28 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id n24sm10974399pjt.47.2020.06.06.12.06.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Jun 2020 12:06:27 -0700 (PDT)
Subject: Re: [PATCH 2/7] softfloat: fix floatx80 remainder pseudo-denormal
 check for zero
To: Joseph Myers <joseph@codesourcery.com>, qemu-devel@nongnu.org,
 aurelien@aurel32.net, peter.maydell@linaro.org, alex.bennee@linaro.org,
 laurent@vivier.eu, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
References: <alpine.DEB.2.21.2006051857110.13777@digraph.polyomino.org.uk>
 <alpine.DEB.2.21.2006051859440.13777@digraph.polyomino.org.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <475fd8e6-af9f-34e7-c612-51e2958fa397@linaro.org>
Date: Sat, 6 Jun 2020 12:06:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2006051859440.13777@digraph.polyomino.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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

On 6/5/20 12:00 PM, Joseph Myers wrote:
> The floatx80 remainder implementation ignores the high bit of the
> significand when checking whether an operand (numerator) with zero
> exponent is zero.  This means it mishandles a pseudo-denormal
> representation of 0x1p-16382L by treating it as zero.  Fix this by
> checking the whole significand instead.
> 
> Signed-off-by: Joseph Myers <joseph@codesourcery.com>
> ---
>  fpu/softfloat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

