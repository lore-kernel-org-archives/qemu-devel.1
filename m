Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38380C3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 21:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4C5B21852
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 21:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C5B21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzT3m-00068S-Oj
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 17:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1hzT3A-0005ii-8p
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 17:49:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hzT38-0002vT-UA
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 17:49:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51926)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hzT38-0002ur-M3
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 17:49:18 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 76F6C85365
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2019 21:49:17 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id a17so4204391wrr.10
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2019 14:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AmbSyxDegB8/ETY+f1s7Z1As1lHcUl+q51aElfnGMNA=;
 b=EFdcDEWEggbnR/f679kg14jtRbWoQghKcIPwyxBGWSNgxaem/oyXaDHMQ3XLuk93kJ
 O6Tvh4wgeTdFx+JYZa4ua42NS3qkhQNeLBfw10VzBuJ2WGp+P4wsChmTKsIIP+44uRdo
 emdJQoFC65TeXAgQcrFHFlDcmqKu+cZnjgu+bSqJBqGNgNlLHeJCj9bT3Ua9xVYLax2E
 EI+s0OmuswTkKb58ppVvsstgvKdhzzeoe0Rbf/rN+9JSVCVoEmwvA3ckI7YHV1W7z6pE
 4Q9hZDtQD0BUcTIrnS3SnT2fqpFLs7Eww2qDE8yUqXtI9qiLAXP9rlwk02xV5mAt/QE4
 7NWw==
X-Gm-Message-State: APjAAAXqq/Xx6sPxz5Bs2eOOMjU3Xcv6ONOBOf/fh6yJrjvB2hQLiVws
 vU1NvQPN18EtbYzqCWaeylJYTAG2AdU4TjxcMWD0d6JjYgVs/23rH5F+II9GiP+q8FYynHXZEM+
 /1GTC6YXDn25X+S8=
X-Received: by 2002:a7b:ce02:: with SMTP id m2mr4362119wmc.7.1566164956221;
 Sun, 18 Aug 2019 14:49:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxXEihX9eAO7QcntIhqz9YY+a3xAUZPdtX3JMc6fsA8smYevZIz4Wrc3aC2aEUyn7JfMdBFNw==
X-Received: by 2002:a7b:ce02:: with SMTP id m2mr4362114wmc.7.1566164955987;
 Sun, 18 Aug 2019 14:49:15 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id a23sm22630730wma.24.2019.08.18.14.49.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Aug 2019 14:49:14 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190818063959.14533-1-richard.henderson@linaro.org>
 <20190818063959.14533-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <aa685c99-a6d9-c055-0ee2-abd208c2ae3e@redhat.com>
Date: Sun, 18 Aug 2019 23:49:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190818063959.14533-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/3] decodetree: Allow !function with no
 input bits
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

On 8/18/19 8:39 AM, Richard Henderson wrote:
> Call this form a "parameter", returning a value extracted
> from the DisasContext.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  docs/devel/decodetree.rst         |  8 ++++-
>  scripts/decodetree.py             | 49 ++++++++++++++++++++++++-------
>  tests/decode/err_field6.decode    |  5 ++++
>  tests/decode/succ_function.decode |  6 ++++
>  4 files changed, 56 insertions(+), 12 deletions(-)
>  create mode 100644 tests/decode/err_field6.decode
>  create mode 100644 tests/decode/succ_function.decode
> 
> diff --git a/docs/devel/decodetree.rst b/docs/devel/decodetree.rst
> index 44ac621ea8..ce7f52308f 100644
> --- a/docs/devel/decodetree.rst
> +++ b/docs/devel/decodetree.rst
> @@ -23,7 +23,7 @@ Fields
>  
>  Syntax::
>  
> -  field_def     := '%' identifier ( unnamed_field )+ ( !function=identifier )?
> +  field_def     := '%' identifier ( unnamed_field )* ( !function=identifier )?
>    unnamed_field := number ':' ( 's' ) number
>  
>  For *unnamed_field*, the first number is the least-significant bit position
> @@ -34,6 +34,12 @@ present, they are concatenated.  In this way one can define disjoint fields.
>  If ``!function`` is specified, the concatenated result is passed through the
>  named function, taking and returning an integral value.
>  
> +One may use ``!function`` with zero ``unnamed_fields``.  This case is called
> +a *parameter*, and the named function is only passed the ``DisasContext``
> +and returns an integral value extracted from there.
> +
> +A field with no ``unnamed_fields`` and no ``!function`` is in error.
> +
>  FIXME: the fields of the structure into which this result will be stored
>  is restricted to ``int``.  Which means that we cannot expand 64-bit items.
>  
> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> index d7a59d63ac..31e2f04ecb 100755
> --- a/scripts/decodetree.py
> +++ b/scripts/decodetree.py
> @@ -245,7 +245,7 @@ class ConstField:
>  
>  
>  class FunctionField:
> -    """Class representing a field passed through an expander"""
> +    """Class representing a field passed through a function"""
>      def __init__(self, func, base):
>          self.mask = base.mask
>          self.sign = base.sign
> @@ -266,6 +266,27 @@ class FunctionField:
>  # end FunctionField
>  
>  
> +class ParameterField:
> +    """Class representing a pseudo-field read from a function"""
> +    def __init__(self, func):
> +        self.mask = 0
> +        self.sign = 0
> +        self.func = func
> +
> +    def __str__(self):
> +        return self.func
> +
> +    def str_extract(self):
> +        return self.func + '(ctx)'
> +
> +    def __eq__(self, other):
> +        return self.func == other.func
> +
> +    def __ne__(self, other):
> +        return not self.__eq__(other)
> +# end FunctionField

Nit: end ParameterField

> +
> +
>  class Arguments:
>      """Class representing the extracted fields of a format"""
>      def __init__(self, nm, flds, extern):
> @@ -433,17 +454,23 @@ def parse_field(lineno, name, toks):
>  
>      if width > insnwidth:
>          error(lineno, 'field too large')
> -    if len(subs) == 1:
> -        f = subs[0]
> +    if len(subs) == 0:
> +        if func:
> +            f = ParameterField(func)
> +        else:
> +            error(lineno, 'field with no value')
>      else:
> -        mask = 0
> -        for s in subs:
> -            if mask & s.mask:
> -                error(lineno, 'field components overlap')
> -            mask |= s.mask
> -        f = MultiField(subs, mask)
> -    if func:
> -        f = FunctionField(func, f)
> +        if len(subs) == 1:
> +            f = subs[0]
> +        else:
> +            mask = 0
> +            for s in subs:
> +                if mask & s.mask:
> +                    error(lineno, 'field components overlap')
> +                mask |= s.mask
> +            f = MultiField(subs, mask)
> +        if func:
> +            f = FunctionField(func, f)
>  
>      if name in fields:
>          error(lineno, 'duplicate field', name)
> diff --git a/tests/decode/err_field6.decode b/tests/decode/err_field6.decode
> new file mode 100644
> index 0000000000..a719884572
> --- /dev/null
> +++ b/tests/decode/err_field6.decode
> @@ -0,0 +1,5 @@
> +# This work is licensed under the terms of the GNU LGPL, version 2 or later.
> +# See the COPYING.LIB file in the top-level directory.
> +
> +# Diagnose no bits in field
> +%field
> diff --git a/tests/decode/succ_function.decode b/tests/decode/succ_function.decode
> new file mode 100644
> index 0000000000..7751b1784e
> --- /dev/null
> +++ b/tests/decode/succ_function.decode
> @@ -0,0 +1,6 @@
> +# This work is licensed under the terms of the GNU LGPL, version 2 or later.
> +# See the COPYING.LIB file in the top-level directory.
> +
> +# "Field" as parameter pulled from DisasContext.
> +%foo  !function=foo
> +foo   00000000000000000000000000000000 %foo
> 

Reviewed-by: Philippe Mathieu-Daude <philmd@redhat.com>

