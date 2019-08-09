Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19631C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D43552171F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43552171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw78Z-0007Wk-Ry
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 11:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52209)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hw786-00074u-NO
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hw785-0004sh-HZ
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:48:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54599)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hw785-0004sE-Bg
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:48:33 -0400
Received: by mail-wm1-f67.google.com with SMTP id p74so6194221wme.4
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 08:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YJrmoykIBEWAFplSajUyfYNmvAFn9Dx6xYH3F/xZC4M=;
 b=Yf71OfZM5ekUIQZAYZNnXDOCFGQAX+cAEixIRZMOwdIoGq41MiIlNbmmPhG1DxYAq2
 UpnYjCmbwqQxPlaQY8L8cMMToouYdpA6ItZfj78xEAw8p+V7itEjU5Gzdj9SZQAivab3
 LdXd/LEOgZ08nPJpeg9hpUi25VTExcpO/fU76jESPMm7LfdvTLiZW7IASI7WQx27eG97
 7fSK8kileiEqp/jlKfPU2UH25MJJdsUZMfZukxV47sgWumYPwGws+cSqYZfJ1Ef30TrO
 xDodyekmzhjnuO2hZt/Z98NyvzZTp5ms1eZWObRvV527z7Wz/no3ptPszq6qWHiXMMrq
 Qxnw==
X-Gm-Message-State: APjAAAWU7dAZZSqHn7OJ2CKDpY2ZKTrzAF5lheWy2Z5R1j0bkIWWIrQg
 J07SNC/MuCDr0Hq8IHrl2quclw==
X-Google-Smtp-Source: APXvYqwKqCqKFK8m0vpwWfVTPQnsYyNUV40M7p67yQ4H4O5IRyKfSGRkB8jz24YWFVkNyTC/uiJ5zw==
X-Received: by 2002:a1c:c584:: with SMTP id v126mr5899578wmf.27.1565365712237; 
 Fri, 09 Aug 2019 08:48:32 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id v124sm9581891wmf.23.2019.08.09.08.48.31
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 09 Aug 2019 08:48:31 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190809154153.31763-1-richard.henderson@linaro.org>
 <20190809154153.31763-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <004e3b74-0a20-0dc2-e01d-decc31986eea@redhat.com>
Date: Fri, 9 Aug 2019 17:48:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190809154153.31763-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH 2/3] decodetree: Suppress redundant
 declaration warnings
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
Cc: peter.maydell@linaro.org, Alistair.Francis@wdc.com, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/9/19 5:41 PM, Richard Henderson wrote:
> We can tell that a decodetree input file is "secondary" when it
> uses an argument set marked "!extern".  This indicates that at
> least one of the insn translation functions will have already
> been declared by the "primary" input file, but given only the
> secondary we cannot tell which.
> 
> Avoid redundant declaration warnings by suppressing them with pragmas.

That was quick, thanks!

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  scripts/decodetree.py | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> index a2490aeb74..f02c8acca1 100755
> --- a/scripts/decodetree.py
> +++ b/scripts/decodetree.py
> @@ -33,6 +33,7 @@ arguments = {}
>  formats = {}
>  patterns = []
>  allpatterns = []
> +anyextern = False
>  
>  translate_prefix = 'trans'
>  translate_scope = 'static '
> @@ -485,12 +486,14 @@ def parse_arguments(lineno, name, toks):
>      """Parse one argument set from TOKS at LINENO"""
>      global arguments
>      global re_ident
> +    global anyextern
>  
>      flds = []
>      extern = False
>      for t in toks:
>          if re_fullmatch('!extern', t):
>              extern = True
> +            anyextern = True
>              continue
>          if not re_fullmatch(re_ident, t):
>              error(lineno, 'invalid argument set token "{0}"'.format(t))
> @@ -1191,6 +1194,7 @@ def main():
>      global insnmask
>      global decode_function
>      global variablewidth
> +    global anyextern
>  
>      decode_scope = 'static '
>  
> @@ -1251,6 +1255,19 @@ def main():
>      # A single translate function can be invoked for different patterns.
>      # Make sure that the argument sets are the same, and declare the
>      # function only once.
> +    #
> +    # If we're sharing formats, we're likely also sharing trans_* functions,
> +    # but we can't tell which ones.  Prevent issues from the compiler by
> +    # suppressing redundant declaration warnings.
> +    if anyextern:
> +        output("#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE\n",
> +               "# pragma GCC diagnostic push\n",
> +               "# pragma GCC diagnostic ignored \"-Wredundant-decls\"\n",
> +               "# ifdef __clang__\n"
> +               "#  pragma GCC diagnostic ignored \"-Wtypedef-redefinition\"\n",
> +               "# endif\n",
> +               "#endif\n\n")
> +
>      out_pats = {}
>      for i in allpatterns:
>          if i.name in out_pats:
> @@ -1262,6 +1279,11 @@ def main():
>              out_pats[i.name] = i
>      output('\n')
>  
> +    if anyextern:
> +        output("#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE\n",
> +               "# pragma GCC diagnostic pop\n",
> +               "#endif\n\n")
> +
>      for n in sorted(formats.keys()):
>          f = formats[n]
>          f.output_extract()
> 

