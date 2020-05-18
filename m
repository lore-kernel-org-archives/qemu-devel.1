Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D14CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:50:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C2E20674
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tzolg2vm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C2E20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaixp-0007YI-K4
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaivn-0004za-Sl
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:48:00 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaivn-0000Lz-2H
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:47:59 -0400
Received: by mail-wr1-x441.google.com with SMTP id i15so12633868wrx.10
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 09:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/rWFIYBYl7LM9hVJi1HSu/jq7jH1o5xUbwYb+shJLVk=;
 b=tzolg2vmaTShCo9m/057BRP/j6rFU+UpWw5WjRhctTG1f/sb6qCFZVDi7gSq3c3qrE
 abSPjWm15Z2FweiDKwRImhtyCkVo1uatJI3mlBvaeII93s/zS9w+/Ue/SwrUoGnp17Mc
 /jwOCtm5GavbRpMEpoiXOnyTB4aOVQ1AVaZVI9QTJTN8+S325nxk+uVvGt0s6UgffWRl
 cY9igGpsrmkS/i8VVcl5JtryZXsRcDcwq0z3++qyh3kTUfQlcVvv7AsfURXoZk+RpV8r
 pAWD+bZ7nL6+BA4jW0EiRg9e9+8+6MrPRgrUAxQGL2JJjh42QrCcXxN+gQZjHchJKa1T
 6IhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/rWFIYBYl7LM9hVJi1HSu/jq7jH1o5xUbwYb+shJLVk=;
 b=KZJLEY0il0350ldk4hv4g9pYfQw03icbSEM22D1DIuCASzOHCWuYz4rHYOlvCkOGzh
 ONNT6UC+LmAUPZa9zqwJxdOFR9dUB9tUfSpsLNjdG60O/6kmiLQ7/Bl0rO52uLLLzEfR
 kfwCrfZ0xPYgYggt7R/l79GQRhYFmR89cCfXunZ0Vtuc/tsRgZhMKNqqmwAcNDqDYG5/
 Oke4+Pi8yLMPbuFsQrtAPDZ6n0ga/mIL8dS0QCjVfbjqukRcjPW12s/WCRymoolRpqCY
 X3drgvjJ4KQ4I0LkSA1hjSLC1ofKdivoBO8RV72NShb5y7z2XSZ87yWmmGKmdBM77IAA
 jpUQ==
X-Gm-Message-State: AOAM530/6NTXul4FZLnsgh43SaE+2azzpR3WEHTawFh1ofkSvVYChjTa
 6P0fqJxVw+PSejT127rk8ms=
X-Google-Smtp-Source: ABdhPJzP9lBZnF98/GrRbzJffytUd0ZtlAWrZoi7OJfBm+qaVfl4XeAVGJHyZEBt9lXMZPvnGsF7eQ==
X-Received: by 2002:a05:6000:1150:: with SMTP id
 d16mr20799375wrx.197.1589820477411; 
 Mon, 18 May 2020 09:47:57 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id m13sm132659wmi.42.2020.05.18.09.47.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 09:47:56 -0700 (PDT)
Subject: Re: [PATCH 3/8] decodetree: Rename MultiPattern to IncMultiPattern
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200518164052.18689-1-richard.henderson@linaro.org>
 <20200518164052.18689-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5ea1bd54-d3b3-8b56-778a-ff6561988bbf@amsat.org>
Date: Mon, 18 May 2020 18:47:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200518164052.18689-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
> Name the current node for "inclusive" multi-pattern, in
> preparation for adding a node for "exclusive" multi-pattern.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   scripts/decodetree.py | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> index b559db3086..7af6b3056d 100755
> --- a/scripts/decodetree.py
> +++ b/scripts/decodetree.py
> @@ -371,7 +371,7 @@ class Pattern(General):
>   # end Pattern
>   
>   
> -class MultiPattern(General):
> +class IncMultiPattern(General):
>       """Class representing an overlapping set of instruction patterns"""
>   
>       def __init__(self, lineno, pats, fixb, fixm, udfm, w):
> @@ -410,7 +410,7 @@ class MultiPattern(General):
>                   output(ind, '}\n')
>               else:
>                   p.output_code(i, extracted, p.fixedbits, p.fixedmask)
> -#end MultiPattern
> +#end IncMultiPattern
>   
>   
>   def parse_field(lineno, name, toks):
> @@ -751,8 +751,8 @@ def parse_generic(lineno, is_format, name, toks):
>                             .format(allbits ^ insnmask))
>   # end parse_general
>   
> -def build_multi_pattern(lineno, pats):
> -    """Validate the Patterns going into a MultiPattern."""
> +def build_incmulti_pattern(lineno, pats):
> +    """Validate the Patterns going into a IncMultiPattern."""
>       global patterns
>       global insnmask
>   
> @@ -792,9 +792,9 @@ def build_multi_pattern(lineno, pats):
>           else:
>               repeat = False
>   
> -    mp = MultiPattern(lineno, pats, fixedbits, fixedmask, undefmask, width)
> +    mp = IncMultiPattern(lineno, pats, fixedbits, fixedmask, undefmask, width)
>       patterns.append(mp)
> -# end build_multi_pattern
> +# end build_incmulti_pattern
>   
>   def parse_file(f):
>       """Parse all of the patterns within a file"""
> @@ -860,7 +860,7 @@ def parse_file(f):
>                   error(start_lineno, 'indentation ', indent, ' != ', nesting)
>               pats = patterns
>               patterns = saved_pats.pop()
> -            build_multi_pattern(lineno, pats)
> +            build_incmulti_pattern(lineno, pats)
>               toks = []
>               continue
>   
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


