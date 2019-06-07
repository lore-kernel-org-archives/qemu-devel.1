Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C683C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:43:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4233A20840
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4233A20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51241 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZF9k-0000ZD-E3
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 09:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41041)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZF8K-0007tj-Jf
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZF8I-00088a-Sp
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:42:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37189)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZF8I-00081D-MN
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:42:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14so2224090wrr.4
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 06:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y1UgQePrZd4MkCNM6uaxtsR3eqH1fhysdjC9nkbB+5I=;
 b=HbHwIJcfYQjROMnlki/T/kQ8osW4vhQSiwk3H9bW85+wPXMuSYiDA7O+hAUg3y1H+q
 SDNLnXtcNJBAGqYy43WXMmXHk/mSwNORO2Dg9MA6fnPq9LcTkFUvbsQz2lpV+crQ9QnW
 FgL0FvHi0ZJSUpDw6OPmj/VfM1O/ycPWi8U4xfACwuNw9RB91+t0jUG/BbzNgvxLAkNt
 nWtbwgSpWx49YyO+Xax0zRaOq4fz7kN1sBtO5Wfttk2AKvoj7MYEvsjn4FrROY9nAadW
 +RRwcmyqlJdt7LudQoiYDdI9bGgTktc7GAM+uw2RdBB3HAOklDKJKeKItEGvBSxMWijY
 YXHw==
X-Gm-Message-State: APjAAAUZ6hHly/bGPGrS9RT4ovVEbCiB959CAM/NfPObsWUTiIY1M9gc
 efcKQTyKekIR/AltiHZUsp3l4Q==
X-Google-Smtp-Source: APXvYqyXupdha2fWALUtc3tSfB372FJ0I05pCigpOYwDpC3j3wpBUFBaNKdJV/wLDSmp8R+pRlrbyw==
X-Received: by 2002:adf:ecca:: with SMTP id s10mr17196911wro.168.1559914930924; 
 Fri, 07 Jun 2019 06:42:10 -0700 (PDT)
Received: from [192.168.0.156] ([78.192.181.46])
 by smtp.gmail.com with ESMTPSA id l4sm1706983wmh.18.2019.06.07.06.42.10
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 06:42:10 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190607091116.49044-1-ysato@users.sourceforge.jp>
 <20190607091116.49044-24-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <48581c4c-f3e1-9647-6701-ae79c2a50221@redhat.com>
Date: Fri, 7 Jun 2019 15:42:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607091116.49044-24-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v17 23/24] target/rx: Dump bytes for each
 insn during disassembly
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
Cc: peter.maydell@linaro.org, Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/7/19 11:11 AM, Yoshinori Sato wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> There are so many different forms of each RX instruction
> that it will be very useful to be able to look at the bytes
> to see on which path a bug may lie.
> 
> Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Again:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  target/rx/disas.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/target/rx/disas.c b/target/rx/disas.c
> index 5a32a87534..d73b53db44 100644
> --- a/target/rx/disas.c
> +++ b/target/rx/disas.c
> @@ -102,7 +102,21 @@ static int bdsp_s(DisasContext *ctx, int d)
>  /* Include the auto-generated decoder.  */
>  #include "decode.inc.c"
>  
> -#define prt(...) (ctx->dis->fprintf_func)((ctx->dis->stream), __VA_ARGS__)
> +static void dump_bytes(DisasContext *ctx)
> +{
> +    int i, len = ctx->len;
> +
> +    for (i = 0; i < len; ++i) {
> +        ctx->dis->fprintf_func(ctx->dis->stream, "%02x ", ctx->bytes[i]);
> +    }
> +    ctx->dis->fprintf_func(ctx->dis->stream, "%*c", (8 - i) * 3, '\t');
> +}
> +
> +#define prt(...) \
> +    do {                                                        \
> +        dump_bytes(ctx);                                        \
> +        ctx->dis->fprintf_func(ctx->dis->stream, __VA_ARGS__);  \
> +    } while (0)
>  
>  #define RX_MEMORY_BYTE 0
>  #define RX_MEMORY_WORD 1
> 

