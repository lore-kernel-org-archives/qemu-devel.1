Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C333C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 390A220709
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkGqIbsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390A220709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jajDn-0005Jt-CY
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 13:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaj1d-00063u-4x
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:54:02 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35306)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaj1c-0001H2-Bx
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:54:00 -0400
Received: by mail-wm1-x341.google.com with SMTP id n5so292726wmd.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 09:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qSmmpZnsauG5YEoNHbAj68iUIKh8foHcKQfd+rX2W/w=;
 b=OkGqIbsQP62duMvusVw0rMCreq/ic2phesVD6+NM0K1P9q7k8ELyuDmObXSMIIX7eB
 dLd4fiwAsCSp2kggDzFcuQWW+P21eFcZ4R2y0wAD8QiqbbDo6so7xzn7UIlhXba65Ekj
 1Dagj4xt2zSf/tu0wkhUF/tSIKAnoEzSXHLWr/PVgT35+qoGcdzDPvYEeDVzkTvFP7EB
 UrcCtVe94PlWL092FiYjxkU2XR9o6Su6qid6g8P9Nb6VK9YIL4my3U9Z8MVYzGYiQzCj
 nEirJRZGTYnm33vgBfGA4RnAl+FkGHbaQj+d1uUDEf60JHZeelnYu4RWeCDjsUSgN20X
 6srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qSmmpZnsauG5YEoNHbAj68iUIKh8foHcKQfd+rX2W/w=;
 b=hs/kd5KdnIVC8d3fXt7zSNQK3iR2S0ORZrs6RI7HcCeez5+3ajKDoxNY1qLaad2/qK
 MzF/2SiGT7uTFIJuFRQ+wVBA8YlOc2HbawQUTz27br4n1sKilS5ZE6WYH4TT8c+I3VuG
 DnxahzjzsEVMRXYTjY+Rnt4R4IXbV+yhkALiTceiIruHwBhtNMIR7CAxnmeBArnZuEmR
 /GNlqVk1nAhmEE6k+P91Ky39j2mkC9IYtxntDYKmvRkA32IMRWg2Tb+YSr0SAVZ9akws
 gCwcUoySH4PZYZtHKJdd6D+mIau4bSPi9bB1zB5oeptjvBsnEQDR5z2I0CCLttJ4J3j9
 omog==
X-Gm-Message-State: AOAM531/y52Hr7CuJl45/liB2YrXSEec7WV8SyNyPccl9+C3U40RFmSF
 4zUiqYIUljci5XfVwY+fz50=
X-Google-Smtp-Source: ABdhPJy5XsLRQKuxaRlx6nhGZfDuerty0cczsoP/kHomHECdtrhFCV5ie7/P9y4DRyEdoSGeS6YVpQ==
X-Received: by 2002:a1c:a912:: with SMTP id s18mr292876wme.55.1589820838376;
 Mon, 18 May 2020 09:53:58 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id k5sm16607688wrx.16.2020.05.18.09.53.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 09:53:57 -0700 (PDT)
Subject: Re: [PATCH 7/8] decodetree: Implement non-overlapping groups
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200518164052.18689-1-richard.henderson@linaro.org>
 <20200518164052.18689-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6b235434-07e5-1830-3ee5-8f18bed00a47@amsat.org>
Date: Mon, 18 May 2020 18:53:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200518164052.18689-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 6:40 PM, Richard Henderson wrote:
> Intended to be nested within overlapping groups.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   scripts/decodetree.py | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> index 0ba01e049c..a9739f671d 100755
> --- a/scripts/decodetree.py
> +++ b/scripts/decodetree.py
> @@ -1021,21 +1021,22 @@ def parse_file(f, parent_pat):
>           del toks[0]
>   
>           # End nesting?
> -        if name == '}':
> +        if name == '}' or name == ']':
>               if len(toks) != 0:
>                   error(start_lineno, 'extra tokens after close brace')
>               if len(parent_pat.pats) < 2:
>                   error(lineno, 'less than two patterns within braces')
>   
> +            # Make sure { } and [ ] nest properly.
> +            if (name == '}') != isinstance(parent_pat, IncMultiPattern):
> +                error(lineno, 'mismatched close brace')
> +
>               try:
>                   parent_pat = nesting_pats.pop()
>               except:
> -                error(lineno, 'mismatched close brace')
> +                error(lineno, 'extra close brace')
>   
>               nesting -= 2
> -            if indent != nesting:
> -                error(lineno, 'indentation ', indent, ' != ', nesting)
> -
>               toks = []
>               continue
>   
> @@ -1044,11 +1045,14 @@ def parse_file(f, parent_pat):
>               error(start_lineno, 'indentation ', indent, ' != ', nesting)
>   
>           # Start nesting?
> -        if name == '{':
> +        if name == '{' or name == '[':
>               if len(toks) != 0:
>                   error(start_lineno, 'extra tokens after open brace')
>   
> -            nested_pat = IncMultiPattern(start_lineno)
> +            if name == '{':
> +                nested_pat = IncMultiPattern(start_lineno)
> +            else:
> +                nested_pat = ExcMultiPattern(start_lineno)
>               parent_pat.pats.append(nested_pat)
>               nesting_pats.append(parent_pat)
>               parent_pat = nested_pat
> @@ -1067,6 +1071,9 @@ def parse_file(f, parent_pat):
>           else:
>               parse_generic(start_lineno, parent_pat, name, toks)
>           toks = []
> +
> +    if nesting != 0:
> +        error(lineno, 'missing close brace')
>   # end parse_file
>   
>   
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


