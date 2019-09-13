Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E86C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 10:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3058B2089F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 10:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3058B2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8jIu-00032i-1Z
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 06:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i8jHP-0001gl-9F
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 06:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i8jHO-0002NY-4z
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 06:58:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47098)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i8jHN-0002Mw-TZ
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 06:58:18 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 18C99C057E3C
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 10:58:17 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id l6so13559039wrn.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 03:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n72sIx3PlUAb1mMQE8NMyk8FCw0L7VTc6lZvY5/jK+Q=;
 b=XvwppzLH2JEY7CRaQhDC1fzhmmLyKZA+/qv8rDJStqxTbj3GJ59fQM72NcUTs7KfVr
 70Fc3PZZs9C46DVlSxjVZRM8gcycnSD70TtwJqyav2ZNjWAcGuSii7LmnJyNhjboMp2x
 Lt7rY1ogIy652xn92Zv1yLkfWDndgCWiq4KcBRKRVQtCHPgV+YEL20e4DvHS78bppjFW
 kAeyXb/93PS8zwo3jww7EOsQHlIpXMBrvoXQl6m9MKT0YCYZxNL7XdanQTYFkS1juINk
 xSjzTdHACyyPkkhZ32yYhdQneqhSIEOAVkr3vAz7NhGhT4BRyxuyhfH4MJC9UfFOmGWk
 +efA==
X-Gm-Message-State: APjAAAVB7up/Q+JJFjXkrOMFUi0ucXgxdneyBp78WOmGsDCAC6iMd/nA
 RMO3ZUptAtPUlpCkyUm3akVXi9bGhVuvDEPp9ofifKiZMsVW1sva2CFe/MxbnBbByl0SzODO6Ho
 0d/XShYsuDymP2Vo=
X-Received: by 2002:adf:f58c:: with SMTP id f12mr1602364wro.38.1568372295907; 
 Fri, 13 Sep 2019 03:58:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzswcx3Etslkmj7LB/X9jEqrM3MJpNucfKYszkpayAMqUFZGF6G0x6QwS0a6QhjvLDaIuIDOw==
X-Received: by 2002:adf:f58c:: with SMTP id f12mr1602351wro.38.1568372295707; 
 Fri, 13 Sep 2019 03:58:15 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id k9sm50597469wrd.7.2019.09.13.03.58.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2019 03:58:15 -0700 (PDT)
To: Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20190913101714.29019-1-svens@stackframe.org>
 <20190913101714.29019-3-svens@stackframe.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <01208241-04a5-0db6-f941-ff9cbc64440f@redhat.com>
Date: Fri, 13 Sep 2019 12:58:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190913101714.29019-3-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] target/hppa: prevent trashing of
 temporary in do_depw_sar()
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
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sven,

On 9/13/19 12:17 PM, Sven Schnelle wrote:
> nullify_over() calls brcond which destroys all temporaries.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>  target/hppa/translate.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index b12525d535..c1b2822f60 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -3404,10 +3404,6 @@ static bool do_depw_sar(DisasContext *ctx, unsigned rt, unsigned c,
>      TCGv_reg mask, tmp, shift, dest;
>      unsigned msb = 1U << (len - 1);
>  
> -    if (c) {
> -        nullify_over(ctx);
> -    }
> -
>      dest = dest_gpr(ctx, rt);
>      shift = tcg_temp_new();
>      tmp = tcg_temp_new();
> @@ -3440,11 +3436,17 @@ static bool do_depw_sar(DisasContext *ctx, unsigned rt, unsigned c,
>  
>  static bool trans_depw_sar(DisasContext *ctx, arg_depw_sar *a)
>  {
> +    if (a->c) {
> +        nullify_over(ctx);
> +    }
>      return do_depw_sar(ctx, a->t, a->c, a->nz, a->clen, load_gpr(ctx, a->r));
>  }
>  
>  static bool trans_depwi_sar(DisasContext *ctx, arg_depwi_sar *a)
>  {
> +    if (a->c) {
> +        nullify_over(ctx);
> +    }

I don't see how this patch helps or change anything, isn't it the same?
You clean in the caller rather than the callee.

>      return do_depw_sar(ctx, a->t, a->c, a->nz, a->clen, load_const(ctx, a->i));
>  }
>  
> 

