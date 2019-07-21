Return-Path: <SRS0=xsRN=VS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3EDC76195
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 01:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66C202085A
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 01:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t6QaMI1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C202085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hp17r-0002V9-Im
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 21:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58979)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hp17h-00026n-T4
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 21:58:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hp17g-0006a5-V1
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 21:58:49 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:34126)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hp17g-0006ZP-Nu
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 21:58:48 -0400
Received: by mail-pg1-x533.google.com with SMTP id n9so9823664pgc.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2019 18:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EwogGR0MZqCmWn5JWrEHJtTqFlzxJ8chIj4aETAiBkQ=;
 b=t6QaMI1MY95JVZ2nz+R7PvM7901aKidPmf3qM/A41IYJlquiz0YoVjcUW+mVyEh+GX
 Ev27INtImnYNYl48OPE/M++wSekGO7kK+nl2Qz7u2bfkZiQvazJS0tQuSNfs1DPoxWfd
 d+lUSNtsowVBkr4v4qteLty8I4KkoHz7rBzmpOG1ahIitIBkaP/1bBI6PHxzTPVrbLsC
 Ew8/UoWwVYGYs7pyBUpMAocPuNXe5K0LQa3JBn8Q77/Nwv3PWw3kgHfNljhWUMwE4c8z
 Z7+zIbhHHNY/I60O2BtcgTPj7M1x2Mt3EkfpUk9+daPBW0WWvanU6UlMyYEvo4F0P88g
 z56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EwogGR0MZqCmWn5JWrEHJtTqFlzxJ8chIj4aETAiBkQ=;
 b=q89QLVMx+vNnoPJ1Qq9eMtoEEUVuX2iJyk+FcRLimpwOGPNrOEFNPL9ce7E1vW2B2P
 VMo4SIxnEyvTXa5TuggfvOzqDXfGDNmDCpF1CjdmnB8ShYBOxlq6v6d3wt5px/D2VRGt
 luQwJQc6LhRDqzGLfTXfok+gqS8WT0IINGtEyjbFJZOxkrN/aBiPXvP9thPPP76a4sLo
 ME2uWPlF0U4vHEERncuAItNk7UBIohNYFMlALpyRflW3kFfMEGXcWH0mBf6J7FSkhjoZ
 ov1QiEvcLPpYRCrVNCaBQcWDXeuoaDxdS4mDcu+0j02RPvWFf8hIHV42kQLLu3Ch2/nl
 mp+g==
X-Gm-Message-State: APjAAAWLyL4cxw5zotJ92z86AsvKEMJObNmEUO7IDuZaQ2oItwdlKyut
 tO1/oZ5BXKzEJs/w4HcINFWaVA==
X-Google-Smtp-Source: APXvYqySrkGnKZfpFD8DygqbeebKSYk4oJFz5U5aK+Gjz4w1O6rE5tu/njuLSNqgRDdnpq4LhlBtiw==
X-Received: by 2002:a17:90a:1ac5:: with SMTP id
 p63mr66731701pjp.25.1563674327739; 
 Sat, 20 Jul 2019 18:58:47 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id f12sm31395990pgo.85.2019.07.20.18.58.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 20 Jul 2019 18:58:47 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190711223300.6061-1-jan.bobek@gmail.com>
 <20190711223300.6061-6-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a5e745d8-fdd6-d3d7-185d-eb75d2623c18@linaro.org>
Date: Sat, 20 Jul 2019 18:58:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711223300.6061-6-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::533
Subject: Re: [Qemu-devel] [RISU PATCH v3 05/18] risugen_x86_memory: add
 module
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/11/19 3:32 PM, Jan Bobek wrote:
> +sub load(%)
> +{
> +    my (%args) = @_;
> +
> +    @memory_opts{keys %args} = values %args;
> +    $memory_opts{is_write}   = 0;
> +}
> +
> +sub store(%)
> +{
> +    my (%args) = @_;
> +
> +    @memory_opts{keys %args} = values %args;
> +    $memory_opts{is_write}   = 1;
> +}

I was thinking maybe we should add a mem() that allows a "store => $d", which
would simplify the "$d ? store(size => x) : load(size => x)" pattern.

Anyway, that's incremental improvement.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

