Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6D5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82C0020674
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKRo4/eb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C0020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaiz2-0001B5-OU
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jaiuk-0003H3-1I
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:46:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38322
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jaiui-0000F1-An
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589820411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yhCOFJIAAvM+ZUbTNx/ycFerJ96/a8v6yvLEWaLxONU=;
 b=VKRo4/eb+a9BUMPp5U7SkfaB93yzwPJog1C7NpFXM8pK+JwOx1vKaxxDHsjcB87aj+lXg6
 kUnqf3ZxdoR1yDvooAUAIuowLMtNyZAaUjPV6teHr+LUAcKrvYwGYa7H6CE4QHjPdaxRtt
 5soZZ6WG5/7msWuamzDqrEKp4eIOSjs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300--jFdk4sONguvwoxrVOYcaQ-1; Mon, 18 May 2020 12:46:49 -0400
X-MC-Unique: -jFdk4sONguvwoxrVOYcaQ-1
Received: by mail-wr1-f69.google.com with SMTP id e14so5898007wrv.11
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 09:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yhCOFJIAAvM+ZUbTNx/ycFerJ96/a8v6yvLEWaLxONU=;
 b=APQpuhq68fUN4X+t1KDXZMOXhk/2b7JAe6OFnZ+lb+URWOqhZnmzFQq48MX3OiIqcp
 DELwWJePGnUUk16FY/Zx42bXNE2q0FR1y501oiRYpBbXU+Hy4CAvGtR3WdLWj57n37/h
 rJ9Wv8vqslUn4aO0CgXYDe88k9f7QodoZRZBjolRzDlBzH06HnD6yKSdsiCUsCpaHnTb
 12epXLNeJ3vK4egfg85Wcafq0cF3pEzL2mTVZKmocsfJdtWLbK2vGpAVhnSxCZIxtRXy
 EriPxpzU+Pvena0VqJPV4kzGOsNANdzuHrRV6fmAJOQfXD3vQGryqFl1xgMNmSdXLEoF
 xDFA==
X-Gm-Message-State: AOAM532Xsol39hfKEZLt9XS9kc+ETxH9sewsK0l3CtZstO0+GsymNSKu
 WjTwn0uIrxDvY8W58m6k8827M+XNbDYHsnmIuILqKjR+d1BeI7CrJREp9TpwxR2R6PJ8RSOvMwe
 VijhxdJ53uPpOf5Q=
X-Received: by 2002:a1c:9e52:: with SMTP id h79mr282289wme.84.1589820408373;
 Mon, 18 May 2020 09:46:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxscEzD1YWtBoMaPAa2HYZgVgbyWxx+tvKgXVZxnSlzZUxBotx1q1vww0f6otiUJl9UWrRCVg==
X-Received: by 2002:a1c:9e52:: with SMTP id h79mr282265wme.84.1589820408084;
 Mon, 18 May 2020 09:46:48 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id a21sm171427wmm.7.2020.05.18.09.46.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 09:46:47 -0700 (PDT)
Subject: Re: [PATCH 1/8] decodetree: Remove python 3.4 check
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200518164052.18689-1-richard.henderson@linaro.org>
 <20200518164052.18689-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4f563882-90ac-1c91-da97-eb6e94b0b201@redhat.com>
Date: Mon, 18 May 2020 18:46:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200518164052.18689-2-richard.henderson@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:51:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
> We are now guaranteed python 3.5 or later.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   scripts/decodetree.py | 25 +++++++++----------------
>   1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> index 46ab917807..f9d204aa36 100755
> --- a/scripts/decodetree.py
> +++ b/scripts/decodetree.py
> @@ -75,13 +75,6 @@ def output(*args):
>           output_fd.write(a)
>   
>   
> -if sys.version_info >= (3, 4):
> -    re_fullmatch = re.fullmatch
> -else:
> -    def re_fullmatch(pat, str):
> -        return re.match('^' + pat + '$', str)
> -
> -
>   def output_autogen():
>       output('/* This file is autogenerated by scripts/decodetree.py.  */\n\n')
>   
> @@ -428,18 +421,18 @@ def parse_field(lineno, name, toks):
>       width = 0
>       func = None
>       for t in toks:
> -        if re_fullmatch('!function=' + re_ident, t):
> +        if re.fullmatch('!function=' + re_ident, t):
>               if func:
>                   error(lineno, 'duplicate function')
>               func = t.split('=')
>               func = func[1]
>               continue
>   
> -        if re_fullmatch('[0-9]+:s[0-9]+', t):
> +        if re.fullmatch('[0-9]+:s[0-9]+', t):
>               # Signed field extract
>               subtoks = t.split(':s')
>               sign = True
> -        elif re_fullmatch('[0-9]+:[0-9]+', t):
> +        elif re.fullmatch('[0-9]+:[0-9]+', t):
>               # Unsigned field extract
>               subtoks = t.split(':')
>               sign = False
> @@ -488,11 +481,11 @@ def parse_arguments(lineno, name, toks):
>       flds = []
>       extern = False
>       for t in toks:
> -        if re_fullmatch('!extern', t):
> +        if re.fullmatch('!extern', t):
>               extern = True
>               anyextern = True
>               continue
> -        if not re_fullmatch(re_ident, t):
> +        if not re.fullmatch(re_ident, t):
>               error(lineno, 'invalid argument set token "{0}"'.format(t))
>           if t in flds:
>               error(lineno, 'duplicate argument "{0}"'.format(t))
> @@ -621,13 +614,13 @@ def parse_generic(lineno, is_format, name, toks):
>               continue
>   
>           # 'Foo=%Bar' imports a field with a different name.
> -        if re_fullmatch(re_ident + '=%' + re_ident, t):
> +        if re.fullmatch(re_ident + '=%' + re_ident, t):
>               (fname, iname) = t.split('=%')
>               flds = add_field_byname(lineno, flds, fname, iname)
>               continue
>   
>           # 'Foo=number' sets an argument field to a constant value
> -        if re_fullmatch(re_ident + '=[+-]?[0-9]+', t):
> +        if re.fullmatch(re_ident + '=[+-]?[0-9]+', t):
>               (fname, value) = t.split('=')
>               value = int(value)
>               flds = add_field(lineno, flds, fname, ConstField(value))
> @@ -635,7 +628,7 @@ def parse_generic(lineno, is_format, name, toks):
>   
>           # Pattern of 0s, 1s, dots and dashes indicate required zeros,
>           # required ones, or dont-cares.
> -        if re_fullmatch('[01.-]+', t):
> +        if re.fullmatch('[01.-]+', t):
>               shift = len(t)
>               fms = t.replace('0', '1')
>               fms = fms.replace('.', '0')
> @@ -652,7 +645,7 @@ def parse_generic(lineno, is_format, name, toks):
>               fixedmask = (fixedmask << shift) | fms
>               undefmask = (undefmask << shift) | ubm
>           # Otherwise, fieldname:fieldwidth
> -        elif re_fullmatch(re_ident + ':s?[0-9]+', t):
> +        elif re.fullmatch(re_ident + ':s?[0-9]+', t):
>               (fname, flen) = t.split(':')
>               sign = False
>               if flen[0] == 's':
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


